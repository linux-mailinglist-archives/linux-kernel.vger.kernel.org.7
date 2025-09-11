Return-Path: <linux-kernel+bounces-812931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222AB53E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B481B29055
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42F2E7198;
	Thu, 11 Sep 2025 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUugf/LM"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0D2E540C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627907; cv=none; b=ne8ibMv8dsYr8UU2IwVkfOMN0J8FlBm/Y/wV8/1FWYs2N4HXvxm6wkOTOUAEnDLODoDv2MV3drxVe0IASXdDj6+rDobv4I4Ns+5ULIlm5/SM/8D0p8Ew7APSJ/M8vQD+w67x7/VWJYKpPPvgO6AtwvnVNzE2anZuNcDhitxDh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627907; c=relaxed/simple;
	bh=0W0ugld9idsCY1TcFykNGEpN8ggbtVo9qqVnDRaPVfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVqLh3UXS6Xo8eqoMt9k5AtW6DBx5JqnPrw3k8B/h12mLFC9gSOAbUGOqHtuo71nw0pPl1yXoDpoYjeIyIUD1ZN/aQ2IhP+MaglpkDDi/8bAM1TqYlWLURdSpMS2mo5ZEetXCNIE979wIxYxZlr3oGdTt7Vg7eQN05rK2tuKFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUugf/LM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5607c2f1598so1405960e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757627904; x=1758232704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W0ugld9idsCY1TcFykNGEpN8ggbtVo9qqVnDRaPVfw=;
        b=IUugf/LMW81lUnB80lqVmkTjpVcoaOn4cwoebCJpu0+7TFI9jzSZQI4sYA5ZwA/a7a
         fhU7qCiaFmrUOroZm2Yzhn0MqDXhbT2C34MEQpp8z7rLYSW2LeHkiwV81C0eptMJLgU0
         4wISo6K/PJK7/Bzxh8oOqmZ0ha+2QeDswsXl+puoXVe4kaJLqKoNaum4/a1TCl/Tjhaz
         104NnatvFwpKoFbPLPaCRe8yq9np4/Dn02jX8VFX8+Zs8/N98hgWmjCDsL936ZdF5xbc
         zTNgbz42CUJ1HL0ukE9DqQC7P4GFnwVs70aFXLXhVBneRQs3hypiPxjpAzwAdYj8/pxh
         diCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757627904; x=1758232704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0W0ugld9idsCY1TcFykNGEpN8ggbtVo9qqVnDRaPVfw=;
        b=ac10R9JItOZTD+dQ052hA2mIPh3g1U5PIMUocQvAHc54fNxk5EvakTEcEdz5JOQraR
         KWoTD/FCMACzzXsD43IsslwSuU25nfq6NtVfoxt+DxrUg/X8B/bIEQjtc6qjKHlmNzFG
         u1EOIEFX6DWqRb0Afk2sa3a6Mf2iwv4RE5tTBsgV1ukZa/DBvkETNBaZrjHfiOWFAz51
         PJoHYgSWs4h327BbWzM9cBp4G68cR7GGrDF6XxE6/yRUR87JlGiupYTlkFe/BbmccCgE
         A4v7dfXzmFlmY/Nx2kfncKDP+Vj/Uo6G3bk62bzFFjeFHFDAfUB2/2kgPbpWNr/y5iJ7
         ufIg==
X-Forwarded-Encrypted: i=1; AJvYcCXhCTVO3pma5cY1NA70Bu5e4eZVRrVL0w/xTMi1+VbWuUd144W9+lkZcswr4t9c4noo0CQod89Ifa8HukE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLPKtMJH/hxNgjhVAMeYhAOh1QTGzHzh+Hkge+MRjgvePcvp/
	4/ZqHBydEd8TqQQtgtF1zvnGDzA/T9jCEKmUoe2iB5bI1AHNqtz7DtE9OV1YPo12MDLVqCio4F8
	Ns/Uc+YGU7aa6ELg+yCB248ypgmxX6+I=
X-Gm-Gg: ASbGncsemxG5TsFrwDWRWrJiXXsZ5AM//Ado7q18CsaqldA0kmNlYg9ONq61XivxdWO
	D+tRPgba6f3E+Kr4IL9aaZC2GQAVCeobH0DAGFMmJ48sfUgqQwm2SoAkQZslq28BSjvbRtCk3W8
	mdjf+QjkuPZicwxNQimVaQUjGp1kh4HtJTwzVBE43v4D+eMg99oqFeNfdjB547P4zkNJDJd639v
	kM4Vk4=
X-Google-Smtp-Source: AGHT+IHQTRZCuL6gZAI5xA3kq+cJ/rdq4B7A7fP2ET2XUXeBi2OlT5Hdl3FKWnoKQmRyk/20azMJBe31VteTWRfnTLs=
X-Received: by 2002:a05:6512:63d1:10b0:56b:92a1:387 with SMTP id
 2adb3069b0e04-5704a105ea5mr326155e87.7.1757627903918; Thu, 11 Sep 2025
 14:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906-gk20a-devfreq-v2-1-0217f53ee355@gmail.com>
 <eff194a2bc0bf5f59d6fb92ea5913e2343589178.camel@redhat.com> <4777352446cb5fed094246db526f3d6f09729736.camel@redhat.com>
In-Reply-To: <4777352446cb5fed094246db526f3d6f09729736.camel@redhat.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Thu, 11 Sep 2025 16:58:12 -0500
X-Gm-Features: Ac12FXz5J-DcG25Sbjvg1ZaCJ8cUj3WY-nLpRDh4VK8xggBzNXlBd14W6PGpg_A
Message-ID: <CALHNRZ8UWL4FX_pQ4AsoHOVyUU7N3FAkd-DBS7vqfjpPjKd-_w@mail.gmail.com>
Subject: Re: (Can't push your patch :( ) Re: [PATCH v2] drm/nouveau: Support
 devfreq for Tegra
To: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:49=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> =E2=80=A6Wait - sorry! I should have waited until actually trying to appl=
y the patch
> to drm-misc-next, it seems like something is wrong with the way that you
> formatted it?

It depends on the gp10b reclock patch, as stated in the b4 metadata:

> > > prerequisite-change-id: 20250822-gp10b-reclock-77bf36005a86:v2
> > > prerequisite-patch-id: c4a76f247e85ffbcb8b7e1c4736764796754c3b4

Aaron

