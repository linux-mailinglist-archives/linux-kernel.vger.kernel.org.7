Return-Path: <linux-kernel+bounces-780476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FC6B3026D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE461BC4C59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11345343218;
	Thu, 21 Aug 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAW01N6B"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8FF1F7569
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755802506; cv=none; b=Cv/lW7nLuYS4A0w6GfsQtprc24NbvdQM9qzNDAdfi4cp0NhfW82jKN+DGUXG5sCVVVoyhX+Yf8xJ8KCSLTTkclr7nZaK4JlJWRlT3onk1hLN8APFc/sISSZgGBs5H0xdXHrKk1IvBgMlmuqtXxqWyhNARPuVnkzlqVau4W864dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755802506; c=relaxed/simple;
	bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRM6X2Pfa1wHBsGwWgX62DxjSB8MY+6F5xZ6ZgWbfsrONgHAdf62PBOwGqp55Bi7eiXTauvCumbPY1Qte6MepQiOFeSNZdy8K9sAyWCVhPYyVcTOyF0X6ZiwJkzXxneXfm25xZX0M9ucRxSB38848Zomhnhf3TtMwlUATueRzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAW01N6B; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f2fdfe097so5468e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755802503; x=1756407303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
        b=YAW01N6BeFX2is6FFdpuOJ7TwEfFcNJunSEfcxHWv/7J3EMlhlY+Gc0sd/1ml2ISMn
         S4dcEOg6iePFSd2divYFgAmrMP5m98yWNqvEOW8CMrEkLRuFb7c94nzOsPmEH8nzupKe
         X7ou0g/TPuWtaE310Sne6ko8pODWKzH4VWaZt72s7w+6W53LIo7MtOtGSdTPgFs/S6rE
         DeCvWONigrLFrEAE+ZFBN0e6nahqMGAs982zmqka4ehskrBkCjnH+OiCkASagixeglKu
         +EPz9cDEMV91CEqXY8EY9VGPa80v4szslfBHyIRCyKdQFK7ORN4gBjh7g8UzGq6ADxxH
         BzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755802503; x=1756407303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vV7oPr9msy3vmhpWdf7heCm5ZVEbOV2WJGQ0WQebzEU=;
        b=asnFaCrr8KlDhgBc6w1daa8I6RbXS0IvxkStZafL+uKAenR30neBrxCdQ1DF4SxFzK
         K5xMXSZtdL/0AXlbjX+2deRgpVlke6cMpf88V1usIVM6cgtZGDKQ41jMv0JmTbyzjHfF
         nE7kEsw/nyaAGuvZp/0+M7K2zVnU21HzAqp7E3nHfhHdmdzXTE9W2W+jFkKXfn4a98AB
         37miR0GKN/9WB2m4nXeE/DhHY08Vqyezv9P7sLYnC9ULFUnsVVTVs8gHU5kMkAgcamba
         wkwYXRUqGnX3y66R/bIpS+L3JXt/4ckE1Uj7YOh0zniMOgMIRTMsUgVN6dkEI2brZav2
         m0bA==
X-Forwarded-Encrypted: i=1; AJvYcCXuuW/fKGmM/e4HvoxB5CYJjf63yMDpJb+jCQ2+xO9zxgeFT373WyGlRB9dRomdcX5PNQ9ucYpW85iGPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHo78rDF+v29Y5AGmXbae7fU0Q9feLslMaxXu3kz+aN+A9QiY
	6X0LJNkTLiasKGglrrfH1q4Wopx9Q0DSE+SgnVs1hsbjgezoLO/ZMZvVSec4gfzmoVK7+FNPm8s
	dtupNJtZ2PO3MvoOysfY5Fz6smBWOK6ZQw1o2QEw=
X-Gm-Gg: ASbGncs7vaOW46DNz1gAhW6/vT5JN9iRT3bBysxdrljDTUWVXB3cRRAzgFYrjfVsOpJ
	MsAw3903Z4uA+xYR6l8ls43JX22xxXIJdTHpIPSo43dUTGiB0fayPgsR9hRxzRvrecGbGEXA0OZ
	8ZczjLpXCRv9uD3bjKDwL1BUR8K7235BFWXJfhunyieNBDmsBKwjaNrGhl3ErKoc8r0h3l8lWuA
	TwvddeT4fqE2V7sj0fOI/5kUNMW2XqpcCgGog2cWlqy+vc2xZkP7g==
X-Google-Smtp-Source: AGHT+IHZZIjN6g1zYUADrxI4BD2krvDOeWcnq40aUOp4JXZVppT78w8gSvLCCuaqIwOLzEMB7cMuz5N0bPi/URvyahc=
X-Received: by 2002:a05:6512:68e:b0:55b:910e:dc10 with SMTP id
 2adb3069b0e04-55f0ccd3689mr198822e87.36.1755802502567; Thu, 21 Aug 2025
 11:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812161755.609600-1-sumanth.gavini@yahoo.com> <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
In-Reply-To: <20250821184055.1710759-1-sumanth.gavini@yahoo.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 21 Aug 2025 11:54:50 -0700
X-Gm-Features: Ac12FXyudxm68vNxRiaRi-JpYNUUJ9ypqKjjiHgpfDn_K-UyK_k-qh5laH7nQtE
Message-ID: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
Subject: Re: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
To: Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: boqun.feng@gmail.com, clingutla@codeaurora.org, elavila@google.com, 
	gregkh@linuxfoundation.org, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, mingo@kernel.org, 
	rostedt@goodmis.org, ryotkkr98@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:41=E2=80=AFAM Sumanth Gavini
<sumanth.gavini@yahoo.com> wrote:
>
> Hi All,
>
> Just following up on my patch submitted with subject "Subject: [PATCH 6.1=
] softirq: Add trace points for tasklet entry/exit".
>
> Original message: https://lore.kernel.org/all/20250812161755.609600-1-sum=
anth.gavini@yahoo.com/
>
> Would you have any feedback on this change? I'd be happy to address any c=
omments or concerns.
>
> This patch fixes this three bugs
> 1. https://syzkaller.appspot.com/bug?extid=3D5284a86a0b0a31ab266a
> 2. https://syzkaller.appspot.com/bug?extid=3D296695c8ae3c7da3d511
> 3. https://syzkaller.appspot.com/bug?extid=3D97f2ac670e5e7a3b48e4

How does a patch adding a tracepoint fix the bugs highlighted here?
It seems maybe it would help in debugging those issues, but I'm not
sure I see how it would fix them.

thanks
-john

