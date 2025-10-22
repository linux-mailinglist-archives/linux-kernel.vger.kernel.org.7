Return-Path: <linux-kernel+bounces-865404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD965BFCFDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0183AAF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A2260580;
	Wed, 22 Oct 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RS9ulQ2l"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597A25D209
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148804; cv=none; b=UCfyKYpoxgjSFrrZah7m4+Su/UJG5GK/JOShM/ghW2rTnXeLe/4vN4isCSKpclPsBbb0J4nm7bNxrCP8KsDpbab0nENmTQjO7Xq7UhQdb94XTfEKVa4cRKPpjIXSl0eO928UbgbR4Iop2r2e2OiANuA2oXoELZSgx8WM/QcgywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148804; c=relaxed/simple;
	bh=KzWGAXTtJNaWOtBKzMnXWFA9Pc/O+vKz4Cro7WOAr4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/VvoBB9FGEQ9RxXHt1g6bVgFEYNdxEGVRNimI100H3fp1jHotAFg5YfuUZPbfjmF5SG5AbS2k8VHaqEyczJ9WJtsILoMNPd7TEpxM1CMxfdbMVufVliu1YVGEw+vbx2r6wxx9UTySwItMB8MZxoz7V1hPdzOx/eXrVe2kE4DPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RS9ulQ2l; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e89ffd95b9so15380821cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148802; x=1761753602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzWGAXTtJNaWOtBKzMnXWFA9Pc/O+vKz4Cro7WOAr4U=;
        b=RS9ulQ2lHiWmy/gV+7Kqw9PImxGQyCkaYijbZlLPIiPyGsXg2F/zorj+UmdBeVB6en
         Q/xu8+Q0vOXlYETVNZV0ClMR9763WXUOG9A71PMyT+ZFA2PwLnYz502V1c9mAeNNX3XB
         x7/1IACU7b+K62ZQ086pDExJbBH0lgAJrAcBuViflBDB9v2MW3oPDcI99ycWEtZQBTtj
         2aMilXNef/AKOVsDvB9faKPOg8BGZbuvW9MklZbXCcncAKD7BN9XF67IheTJuYUi/mVT
         gvzMCDdZx16eWs47ONvkakvAJWAH/dCdAlDgIBtZPPUibYOZAv6yZ5lsb5gq7AUZGS7C
         OoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148802; x=1761753602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzWGAXTtJNaWOtBKzMnXWFA9Pc/O+vKz4Cro7WOAr4U=;
        b=e1/urNBdaRczseHh0vQOtdYb40AEKzI30rRQfecfPdnzxd3cP8UO623XK+S/ghVZzR
         d0VJ3BKL0TI1BDkuidhGsDGsWSguRoTaanohnlyDx3TaWtVA3exZOSwJ5osPCTMN7FeH
         gC+ydvbNbYh09sCGtNn3Vc5EN+ns46sLDG/tz0aRa3R3NvoG6lCoSxeDqlchwFMlk3HR
         thzHUCaXtppGKc4Ka9Y/eBobRlb4e+1oSJ5GnbgpMDZ7ctntEYnt/iXuIWgld9oapDFY
         MLnYfyQL1OGVQBVzUezDumxzSfodDIdSi/skvFyLGrA0KensUhZjbywM7uyiVw4lDYi5
         fAxg==
X-Forwarded-Encrypted: i=1; AJvYcCVr/0DzEpX8YpRYG073ox9OtBaP6A8J74DCWmUUxnd7IwifYjqTgcWjbCDG4ewsGHYrgdZZ7JQXwyuUKb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqEWaUkxbCi7KRXI51OI0RPDyuNPIXfU5OMDhWKT7qVRwC9HyE
	nIA5cMfYy32Iy9Ub4QqA+7Na47CBDQua2XnA5AnbjnD17Kdb6hK3exIn3y0lf/47GVlitmtY9L6
	uy6ArOUnHqOUmZiTbhzNiTyvmUIX2tiM=
X-Gm-Gg: ASbGncu9ibzdCNBDREczdzJK1Ndc+cn+uQQYjeRiZbcOn4K5QGkd5Pnkl4pkh680nRH
	Qmwrb+OzSBeT5tdNMOu4bOIg+ojvsUgwbn1wi3WI0UGoMDSJr5m9vTlkPdgZRrWwsmVN8n4g/x8
	ICqHfxSWMbZ68dRxDcNzSMHK+1XrkhmTzfneSLaCGA/unYAXlh7WBddDdMlm2n9d+aFqyw8r3Op
	QrITie1alD5SP0XaKb35VHB5BIJwVnDN13RMyTUbvDRyKw+oRDWsqkPk4dyBVKBVKWTMxT8OZP5
	+7pp+aq/0rNyoAOKwatjkzU3eHA=
X-Google-Smtp-Source: AGHT+IHxWCD/w+o2vmfbuWDtKOmy2UCQxI4nvjqy0zKHd7wCbrRbTr3WpmmN6Tt3lY3nMvE06CH78X9xcKtEFyAyF3c=
X-Received: by 2002:a05:6214:2469:b0:7c6:bbaf:11b4 with SMTP id
 6a1803df08f44-87c2081ccffmr315026216d6.54.1761148802138; Wed, 22 Oct 2025
 09:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022150716.2157854-1-mallikarjunst09@gmail.com> <5b78c30d-26de-4e49-9bfa-121c9f40b4e0@kernel.dk>
In-Reply-To: <5b78c30d-26de-4e49-9bfa-121c9f40b4e0@kernel.dk>
From: Mallikarjun S T <mallikarjunst09@gmail.com>
Date: Wed, 22 Oct 2025 17:59:51 +0200
X-Gm-Features: AS18NWAJWcskmCUPndr9Lli3CHnsvOgWgxEkWkWuX7hMLeLHsGN9TYgqSU5HGMA
Message-ID: <CADv35-T8XchxB43FZ2XdJ+8nWDCULqz1FLX5vC9WN3gtgeSpQQ@mail.gmail.com>
Subject: Re: [PATCH] io_uring: initialize vairable "sqe" to silence build warning
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, "kernelci . org bot" <bot@kernelci.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Greg and Jens, for pointing this out.

I understand that this issue has already been fixed, and I=E2=80=99ll make
sure to pay closer attention in future submissions.

regards,
Mallikarjun

