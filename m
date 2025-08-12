Return-Path: <linux-kernel+bounces-764318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EBB22172
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DC71B665E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C732E62DC;
	Tue, 12 Aug 2025 08:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CiMgZmxP"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1072E62D0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987582; cv=none; b=f5u/0r5KNLQvCXtssoblNIyO7DeMPROr9PIDm9Bsp+LN6JLDj9u5466P1655hOThVwNroUb+VNHJ/I1QemMWrU9BUem2sE8S188Hw5Yz96t2vG36oGkmZETsyhgXiCGHNK/AAV+rBtLLbp3Lv4LxJweTunPqKD7MabHqUyr3PKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987582; c=relaxed/simple;
	bh=gQqRnUDmyiq/c1A6dM6BP6rq4rA+ezyDXaqyuPkF4QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHMxvlxrAFUSzlo6tZ8zUxGBEmtTOe0XMJYsNK0AGfsDiWM3IMkAlDaMt8TEEWYYQ3nqK4E2YD2XA62qRjVVXhoxAvXaswpLpmKaQq4ryzexbe7OZ/6jTjZ/qMHZY0Lx4xpBIigBVDogNHUhqzQh1lDyGTFJ5nRuAQTOrobkHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CiMgZmxP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so2914305f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754987578; x=1755592378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wyb11Vz1qMy7piLHwJTSkYzDASFNds+IfXed84grTFc=;
        b=CiMgZmxPPDhq+ESiTzNiqo43ATK1tJ2A9Mu/n1b4o417B59XY82oBhSAB5b+6C5jQv
         W/Un+ECWJ9Fi8H7kzenfKjbMb/jaI4VbO75jY2ZDU8YRxZ13dYu2dpIjOgDvR6aPPgfT
         ZNzALa5fiQu9X/TZ3xxTB/0yRJdD3J4/GDgfkbgHtHLXHyQgqgGvUU5XPK6undPkWXiU
         fNwiVdpIDB3LOXYbIvZIacYrw7IpQD8cQ1Oy27ClbzhXUrI9vKsmrfTPU2jcRr8UHllX
         afbwbZyIQS3BOCu6Bash5qhVDLHtwvCeP2uyY14Cor6CYm9auFEchaXrZo28pUyfNt2n
         tBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987578; x=1755592378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wyb11Vz1qMy7piLHwJTSkYzDASFNds+IfXed84grTFc=;
        b=CqOtMtKo2CURoldIV3F7pWN17n24uGua/Y1DWxfztnApM5Cr9NVqIfbT20tzzQmGpH
         82wmBSaAf4B/ZUxOjfVB1lNUVfPBLKukvq7tWZ0uhnkNmDrPI+ZP47pEmFJXKPBp8IYL
         eICTvBaFJ6KWEq3Y0Dnb3kR3QyVzr27+F7keqnD/w9alo1z5mZNDcHim0O6DGHrqWEYO
         ygLD4AAMrWN4RdThLC1GuJoiqDIfkOX1acUpzTRrGonF50j4zYG281UHknonpHOIAY+7
         78eWzwxOW02JTPBTbXLtww0RwYfymC48M0LTIDGEUVH5LpejQ/vvB9fsmqWX9J67KjRV
         Dgzg==
X-Forwarded-Encrypted: i=1; AJvYcCVvDFM5agayUsV3mC8FBhZRB28HgujkpBpEfi5Qkxp4PQlJobBM2vfyBTdm1Z5aUzQRuNLCIb/35+fTOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwylH5XvLKrjClgvgMizDRY/vwoDPjgSgMP0ONTXFWbjpY9IJgf
	iOpoSV87jGhSDbyzwgMrdn4l32FYtzbCEIHRUrHogSRDuAnRqTjgXPx6S7sD/qLcemXtYhVy3HV
	zv2QreLxFc2EBoeue02acMF8DsmGTJF6t9YgueH1T6w==
X-Gm-Gg: ASbGncs0CjQMUtc7HAxuPAdN6p8w5/M3Jzl66Zk9HnuK265QvqGXjHQiNopo50vy7Yg
	FWz/GLc4H3vSdCrWJSwDIhScmM5yyAiZkONDV6TjqsQxHUuVa3k8GQrBpQFk6KMJjuO6IKmMe2j
	Z12Jq2F1NsqUBH1vKC5dcutJmtJbLo0F8XxM1iCc1dcx9eQ8JH1RsBS9DzQ/0A9c+27TM+GmE8K
	t89eg==
X-Google-Smtp-Source: AGHT+IHBLtLTODzXDFsr93yFdNHPG9OO0ylpV9rnIadLqUg4I1ShoVedu2pugApagMzIzY5ooOgOHXkrnb/sZBPX6qo=
X-Received: by 2002:a5d:5846:0:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b911032aabmr2058548f8f.44.1754987578494; Tue, 12 Aug 2025
 01:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082554.48576-1-zhao.xichao@vivo.com>
In-Reply-To: <20250812082554.48576-1-zhao.xichao@vivo.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 12 Aug 2025 10:32:47 +0200
X-Gm-Features: Ac12FXx-L34lpqbbVcTmKAvnU127pOEmWITQM3t417pxgkJF-1SZu7BL7ZF1YMk
Message-ID: <CAPjX3FdqXPnb=_JDsAtid2WszaqaODM1rxF5XcGGy7WmfJLquw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use PTR_ERR_OR_ZERO() to simplify code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 10:27, Xichao Zhao <zhao.xichao@vivo.com> wrote:
>
> Use the standard error pointer macro to shorten the code and simplify.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  fs/btrfs/super.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 68e35a3700ff..57dd58fd8b9c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2257,10 +2257,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>                 device = btrfs_scan_one_device(vol->name, false);
>                 if (IS_ERR_OR_NULL(device)) {
>                         mutex_unlock(&uuid_mutex);
> -                       if (IS_ERR(device))
> -                               ret = PTR_ERR(device);
> -                       else
> -                               ret = 0;
> +                       ret = PTR_ERR_OR_ZERO(device);

LGTM.

Reviewed-by: Daniel Vacek <neelx@suse.com>

>                         break;
>                 }
>                 ret = !(device->fs_devices->num_devices ==
> --
> 2.34.1
>
>

