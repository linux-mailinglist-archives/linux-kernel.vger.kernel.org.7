Return-Path: <linux-kernel+bounces-842790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF00BBD9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF12B189220E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49061220694;
	Mon,  6 Oct 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxkCshM4"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51521CC71
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745258; cv=none; b=eg/6jGHQVfO82Em2ypaTpgaANtw25QDXZRgCuTt6GZPdP5ipbKDuZCar20uXe5t98uPFPosmgNcEh3dcAVw3saEXqgos3aL18iz3GZCYhG1gImw9FOxJdZzUQcaLGFO/t0LO/rvUlRA6lQK93HBvrhOVuyUI9xiRaQEWLoocZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745258; c=relaxed/simple;
	bh=Reg6DEUnvSG/PqMheoUThHkpNRwNh1kG272ad8We2Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQDBEp0VQ78qBldUrRwS9MRJ/m+ZzHggNpXLgImlE46CjmdTwOkLAaBjsRfguDNPySBfkAOFyymVbEKZZdJClIz16/UGYsr+dpCiDC4DCXcrp2aDbOnQmhmsS6fQ2TIXA4NivECN8VD1rdzeafnD1E3iMxu2YGm0Mlt4S7flV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxkCshM4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7b6ac55cf86so2968355a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759745256; x=1760350056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwsmE3SV2vtMhHon4ZznLX7pnLrz2wmwEFX8iUdXXb4=;
        b=sxkCshM4w7gQLCxgAmpn91btv66isSbGY4g4Jz8yy87UKqSTE7eBp90aEjOORRZEzu
         cVsg4EA1s85JTAO3w1xr/j8fa20hQKRTISPd2D2BXR6Ct2Rk5RCuMaSFDrRH5QW9xXbg
         fD4uVtZTs5WbxZqaUmXkbczA0kW8F5EGa7zvQ61HdTcMxoxB3Gctd++PIpkL187m+SwG
         OUG2HG+L8ZN/WQ22pW7HMCGusAm+PXYpF8Nuw2Dh3EKl0xZaceMWEY7C3z2gEKPP/zeM
         yKvVLRuD2ukrmTTZrhZnCopqbq8Ere68HYqEpEOoopcQ0uevyyrikDnm/Y+UYpGtLn04
         84sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745256; x=1760350056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwsmE3SV2vtMhHon4ZznLX7pnLrz2wmwEFX8iUdXXb4=;
        b=r2/M+JXzsLocoFQBe8dVcLmRC7jHqsJLoFoAVntOICvRKko7txGLyfINVAXgKtS3Fc
         WYFQK3GMaXJ5Y1boj5R+wVwkUdUZIj8napnOclYJDudKhygVhIWO7NfBti/QMQQXxc9q
         ZDn/G2rcqX/ciE4WroXPRgnTjvKQvYgH1lIqIJgYT8aUO+PGkfLHYMRtQQ4/MofqEr/n
         PrieIb/vNKmTRIOOQ/vgoe1E7j84z6M2NoF7592sOvnBQrZIdvt/Lm+MuVFXm/9k6hTo
         IhpOZ10ydE4PpsgXGHbu+NddqX5mZ6zFl1Vy8d8ewH2yLbDT5PDvYqHRpeSuY84q7fA2
         C43Q==
X-Forwarded-Encrypted: i=1; AJvYcCVl7ZnOWNX48G3TCe9kltcBeLU7YeG834rLQVq2v+xBssCL8USGRUpuTboKj8vSxID8BPR+d3dRSDBgoaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJC6p9Eml1hm3DypF54d5KVVJdMllOs4abScWlB12FKkSrQrm4
	JTarl+6OyXR5cOIw7yCg/MA2yl6Afds7puU4MEhXKcGNCGNVIkI8MiaH/W+VYQVqbWeHbR2kn7r
	nYdrRw4wJ7vGCxZvZcqNggOGWzZ4s1mMr86A4PvCKbg==
X-Gm-Gg: ASbGncsey6blbAORqZOBXncFqM3Hr+MOIFRdF6iu6XuLpaEYkqjJ8RYUWcgzlEnznMe
	xmimT9iebWBiPbuGEE9IPa89usoHHqcyyG/baI5OriLkP/wuAK4Y1Mdtu995DG7y2kKQbbvrxZL
	N6LohafLUrO2NrcvBx7KC5zkDlUZ3vafcvt1rrrLRqHpAAyWmBo2EBRQDd1BtwQQit9Mo9eEXui
	lQyj6ThV5lCcRE8M3ljrhBVHDXUwXk+n3Z0
X-Google-Smtp-Source: AGHT+IEdJ5Le2b9EMN+8OcDi2xR/v9zl58sylKncZKdQEw83GkEpTqtV4uR5jTler9bHHHLpjFyrCxpl+3Txo6zqQzs=
X-Received: by 2002:a05:6808:4f53:b0:43d:6a69:7752 with SMTP id
 5614622812f47-43fc176d2fdmr5320387b6e.2.1759745255999; Mon, 06 Oct 2025
 03:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001060805.26462-1-beanhuo@iokpp.de> <20251001060805.26462-2-beanhuo@iokpp.de>
In-Reply-To: <20251001060805.26462-2-beanhuo@iokpp.de>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 6 Oct 2025 12:07:24 +0200
X-Gm-Features: AS18NWDfF8QtP2N_zckbluKcwTLkJmTAFyn3AWX8aYt6fYlCV-dWp71IEBl-Yw0
Message-ID: <CAHUa44FeRN2MWmSngJWKHVXXvUaK9yongfBxbXDLQs357nUq_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: move rpmb_frame struct and constants to
 common header
To: Bean Huo <beanhuo@iokpp.de>
Cc: avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, can.guo@oss.qualcomm.com, 
	ulf.hansson@linaro.org, beanhuo@micron.com, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 8:08=E2=80=AFAM Bean Huo <beanhuo@iokpp.de> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> Move struct rpmb_frame and RPMB operation constants from MMC block
> driver to include/linux/rpmb.h for reuse across different RPMB
> implementations (UFS, NVMe, etc.).
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/block.c | 42 --------------------------------------
>  include/linux/rpmb.h     | 44 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 42 deletions(-)

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

