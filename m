Return-Path: <linux-kernel+bounces-773422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34957B29FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7A11963ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1114E2765D8;
	Mon, 18 Aug 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM8ryQTW"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6630FF3E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514553; cv=none; b=QKeXcwKUtKuuveVexW3HW3tS1cvnaFF57Yj+jJG4n2Jw+9/O+SrIobBFAd+qR/R4MDET1E5Vd1/2/HqyDMQN4vOeh76jzK3vb7JSgFC1bgOUJEQNz417ufin1e7LxegANs9ZLm+PHgXmps5fgTPVnKNkjk9E15N3j5xwfQnkzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514553; c=relaxed/simple;
	bh=6uPzar8fnz6L8ml82QStz50hbQ5nxpvVN3h1tUdJAos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nk4lr6VIfQ/eSYHHbQFW/V36ABYzoTc07a2EJDMkgwkjhiNDDcH/MHJhLmpraDSaUflMOQqj/LjhjZiMhrYAxkqA/NBHSJ5DX8+wKLQe+415EHHu2eB7mT0hT9nGHOD3Tpdj681Plli0PJFy4EgFJuDIK8KeI+Sa1y6cdDhtIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oM8ryQTW; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e934595701eso1184288276.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514551; x=1756119351; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dSUcJw1TXruqA7NYhOWlsQiZC/PcevLoh3jJ9TCLJxk=;
        b=oM8ryQTWNOMISk6HXymQy6AyJP4wzGxSJf2DGG172ok6NREbSEoF5v0uW6e7t1NhJL
         x/MRkwuVpqTfSdhRec8erU6JaxZ0NOCPSmuHyPa58WLt+Q41Q1D4wCX+hcqG/CWFEGLW
         8MbNwYfja9A4pO9j4zMhcIaQ6FdjeLwa8HMePpExcfgSogwNPM9DWGua36rdg8jiZu05
         XxxA450TrqNuFamAID/qk7rXwRSOrOQYcs6F2fd+T0gCwlKdQD4jXMf8qyeyd0QljI2Z
         LMCdt/p2n7A3WeTI0LHe5rtCawZ4NrMvVmH+XsR4Zkhuslne+bOlMVpfBjka9mcJmqBr
         NxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514551; x=1756119351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSUcJw1TXruqA7NYhOWlsQiZC/PcevLoh3jJ9TCLJxk=;
        b=WjltTIgCqKb5JlmNbSTJLE0aB8yNLHFGlfUKDSLzhPDo/U9ZoTgmIB7qEPLx/Qgx+f
         NIqHBOkxrdEVaO9Xo88E2Sya8VNDHek+WxzxV+cjotk2cfUYHJjCXhdE+ykFNn1ndcLI
         /pvZ3bEKJepelsxBWm22B4cgDNDwU1IJsBwWkkKy6p8dwiylt+djnE8hUv9DkoYDItbO
         MvS2F2iBtwDpggU2ksg9SasSIiUODn0FQm5PbjqUexkgNEslLJjDXi7ffsBFVS37dCZF
         KXC8a8MBt/kXbi1VA/P9N939DxzvSWY0bVMPk6a+poc6YiXR5iEriSc6W8i6UREK9pIp
         6Tcw==
X-Forwarded-Encrypted: i=1; AJvYcCXwA8WMJtGFD4A4xMdj3Zon+fB+5hrWvE+ywkyJROsbGxMgughjQ+D1JNENI9SBO/U4uk2SpJ68lDtMPPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTFeJ+XuGe9wn/9UHI5gTH9cOTd+JuvQ/Ip8FKTScUO3xa+wO
	PfLthb9/l+7g/8T38H1APObLGedO0TMX2sIKIYJvR2o033EU5L+dtLcHt4IaP+st3pxjWIwoK5o
	uUpDuW0JukG2nlhKk4vEBCRRukRWeFavB6udE3P3VzQ==
X-Gm-Gg: ASbGncvU25ejSS4HpaWDk5VxtbTdBkLuKGE6vYrH9Gnw+rLKqsGUusIYwoNpSqMiV0J
	ZKsccz+QhmMXCJBtR7jMOHDGoiNyo6RKaXz9gYEgF9NiSbPELYw6AYw1FGlU8n3EdUcaMUB2Qwi
	8kQLY31ZgoblwGT51/PwANr0l3fotgInk7GYCYVMQVjp1Q826WDw2fyS2pq890ynBTp1EHHxQ+D
	pkv/d5W
X-Google-Smtp-Source: AGHT+IGh7RVez0cYblanpn7QsvQTnxPk0VxeHoWXwhEM0PY4fYruJQmra/PgvlN67LU1aBTvJBYNVkGUDhr8hRBfu3Y=
X-Received: by 2002:a05:6902:18ca:b0:e93:4df7:6889 with SMTP id
 3f1490d57ef6-e934df76df2mr4130536276.5.1755514550706; Mon, 18 Aug 2025
 03:55:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804013604.1311218-1-lijiayi@kylinos.cn>
In-Reply-To: <20250804013604.1311218-1-lijiayi@kylinos.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:14 +0200
X-Gm-Features: Ac12FXyqwG0c8SLIENypbwfR6jFFJ-FTW3VAEPm1_XbocLArGkOzSh1HDj0UOQA
Message-ID: <CAPDyKFp4a_y-Om3CxEn2zO_s9yBeMmyMpgVL04j_xLEt7HtNqA@mail.gmail.com>
Subject: Re: [PATCH v2] memstick: Fix deadlock by moving removing flag earlier
To: Jiayi Li <lijiayi@kylinos.cn>
Cc: maximlevitsky@gmail.com, gregkh@linuxfoundation.org, 
	kai.heng.feng@canonical.com, oakad@yahoo.com, luoqiu@kylinsec.com.cn, 
	viro@zeniv.linux.org.uk, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jiayi_dec@163.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 03:36, Jiayi Li <lijiayi@kylinos.cn> wrote:
>
> The existing memstick core patch: commit 62c59a8786e6 ("memstick: Skip
> allocating card when removing host") sets host->removing in
> memstick_remove_host(),but still exists a critical time window where
> memstick_check can run after host->eject is set but before removing is set.
>
> In the rtsx_usb_ms driver, the problematic sequence is:
>
> rtsx_usb_ms_drv_remove:          memstick_check:
>   host->eject = true
>   cancel_work_sync(handle_req)     if(!host->removing)
>   ...                              memstick_alloc_card()
>                                      memstick_set_rw_addr()
>                                        memstick_new_req()
>                                          rtsx_usb_ms_request()
>                                            if(!host->eject)
>                                            skip schedule_work
>                                        wait_for_completion()
>   memstick_remove_host:                [blocks indefinitely]
>     host->removing = true
>     flush_workqueue()
>     [block]
>
> 1. rtsx_usb_ms_drv_remove sets host->eject = true
> 2. cancel_work_sync(&host->handle_req) runs
> 3. memstick_check work may be executed here <-- danger window
> 4. memstick_remove_host sets removing = 1
>
> During this window (step 3), memstick_check calls memstick_alloc_card,
> which may indefinitely waiting for mrq_complete completion that will
> never occur because rtsx_usb_ms_request sees eject=true and skips
> scheduling work, memstick_set_rw_addr waits forever for completion.
>
> This causes a deadlock when memstick_remove_host tries to flush_workqueue,
> waiting for memstick_check to complete, while memstick_check is blocked
> waiting for mrq_complete completion.
>
> Fix this by setting removing=true at the start of rtsx_usb_ms_drv_remove,
> before any work cancellation. This ensures memstick_check will see the
> removing flag immediately and exit early, avoiding the deadlock.
>
> Fixes: 62c59a8786e6 ("memstick: Skip allocating card when removing host")
> Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


>
> ---
> v1 -> v2:
> Added Cc: stable@vger.kernel.org
> ---
>  drivers/memstick/core/memstick.c    | 1 -
>  drivers/memstick/host/rtsx_usb_ms.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
> index 043b9ec756ff..95e65f4958f2 100644
> --- a/drivers/memstick/core/memstick.c
> +++ b/drivers/memstick/core/memstick.c
> @@ -555,7 +555,6 @@ EXPORT_SYMBOL(memstick_add_host);
>   */
>  void memstick_remove_host(struct memstick_host *host)
>  {
> -       host->removing = 1;
>         flush_workqueue(workqueue);
>         mutex_lock(&host->lock);
>         if (host->card)
> diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
> index 3878136227e4..5b5e9354fb2e 100644
> --- a/drivers/memstick/host/rtsx_usb_ms.c
> +++ b/drivers/memstick/host/rtsx_usb_ms.c
> @@ -812,6 +812,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
>         int err;
>
>         host->eject = true;
> +       msh->removing = true;
>         cancel_work_sync(&host->handle_req);
>         cancel_delayed_work_sync(&host->poll_card);
>
> --
> 2.47.1
>

