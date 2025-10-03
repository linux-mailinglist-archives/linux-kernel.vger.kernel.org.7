Return-Path: <linux-kernel+bounces-841031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E6EBB5FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A11E3C5F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F324D18A6AD;
	Fri,  3 Oct 2025 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="srLOvNJZ"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6C21C186
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473912; cv=none; b=LuTPpTzYnTuUO/HRLknZq9UcLlRCRPdGXsSVlIH91zRS7vMqvWfM0DZDrMF6Z9Ny/sLS2KswDMxHFIItT2ttZMdHquXbqxMYSnDDbIllBnuzWryxOG5c32RLNnOvcRT++ES5lW7+MFgqGEo/vrJvY1dHyFVOVvICD08ecE+/4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473912; c=relaxed/simple;
	bh=Xs0k+T2nk6ZBx6NYfGOdqbhVdwWIomTm+4Fy9nW1fjI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFUJcACRwVoDYhxb4HgUjXpPQn4XEa2K45ow6sZmhdhVRKLOi4bTN13H7aXNfbFtlsMUTFWZSbIt88n23C/hqakzJUQTktbc6qQGGrVtMU4aopw/SywdUJRUrctg1Gfa0+gDkGSY3M4k0PJqodbrak55m8Jsh5V+rG84lXvNhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=srLOvNJZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48DF041967
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1759473890;
	bh=cZ71oTLvaYFmCM9yGlV1PXF0f/l2eYKhSwYaCMTQsJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=srLOvNJZHGdJfYg+Xmirgyt4NQRgIo0rTOwW1cuoqaJDI1CB2UCkAzCTQrrV2Std2
	 fVZngPhhuUx32oEPpSjGTYfawRVV+eo6w6Ol2tCAez05fUHoEfBMyERFbRsAL5TUqK
	 usdlHMDXNR66GETYnm/2NSx+9+RVAZjrBlSuPfWohBqPer+odPAurt/jZmOSy3m57v
	 1w3RoLcfDFpwnkqj0X77EQW2TXPOdZndzw06+PM9lZAC+3kUCZmq1kFlZbFuvu9bbg
	 kQLRevRtSfMaTq16zB12aD0zgPpWAOcPRBHGOFo88bDE3RdZpJyzH+YC46cQf4WpVU
	 o0iHsuX+MKTcV3nxz7xpPalEGT+PieAmSv6UmYhatW0z8Fdi9gWJjVZFFjSHcysu80
	 91H7o6XRHerjUW6pmW1z3a3Eq/SBoiSqOiRxH2pROoj76L0dhhQC3WTGnb+ezmpKpZ
	 +9AdD6bYANjv34NwBJF3qVLH/1tnJtGQrmFuyPdILceywUz+C+auAVEo3QaVngvDxx
	 kEKA0dR/HVvoYJvnLxZmWL3qDN3nAs4xVsFMcE4mriyise+tslfIeXHoWnwWT27MKX
	 yqkdK0A4F2e8Q/Xp5pQr3UiQiULOneRSi3KZ/IEITXzzg2gMblOs4Sf8k+IT1XuGN1
	 T2od7DjN2UVlvy7VDZ6FRH6w=
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810af03a63so3350049b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473882; x=1760078682;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZ71oTLvaYFmCM9yGlV1PXF0f/l2eYKhSwYaCMTQsJg=;
        b=XbBRm89gt4bMcbne5rmDS3OBXHlZtGqdkYonU7cU+9VgGFVmaAU69IIrdz6jOVbREu
         xRypkgLxWS5JYmNRUk11eHZA/qcdqc2OXbwwDJq+NDZC46gXy7IBwn54UZX4DS6V3ECk
         i6baDxA1NMAFCqSCT51wzDVTfHUM2O0ctY+DTXPwrKyJClfJ4BchNnyfestevnKVmarr
         a6C0GFp2LneI7yGNtD851hbBL15sCLdGrcyD3z2c/3HOO4xhGG0BS/N3nYZxYax5rsw1
         +6LN4qkRWb32XzwMjDK2AZilXvz9H9aCnwMjeVaO2cVsGSdoyU6jGMlczCh03qvwjSVc
         CQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXyph6k4VEuHSrQkfXt5F8JG9NIe8dBC6JXwNbzno8yXNrxxfyKuD8HONyC0wq8CyMbn9B053cn5XIAVWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAShVpMemWY1rkDfwYQhV4SYMXx3vFtFa1NFVHVah+ZPayKcZ
	HUhzX+OJUZlkLy9I+HKB4rDGpfbnwp1k6K2kTOersOK1WagsWoqVFSdIH2vvbUIToC2Di72D8CY
	gp35drkRadmyZPoX5Fbu2Ylt9eAztbhlBUpv986nBjcz1TlKK8gx7IvdTJkKxnKSzZ1ObiCorlr
	BDzFInTw==
X-Gm-Gg: ASbGnctH96IufwL0ddn3qQ4rIUYIQCZQ8T6ACR1R0J83fuJSi5R1e+t5IIJM0O8hrO0
	q9NO3f99SVLth15hEKVyIegtwjbTXuccK12/foavlMJamDYWZojJCmTHNdFG9qCcchXWjZ37DJE
	SQ+9hNY/Y7R3v2ZqxAxbVrkX5LfQBZjZjJrb09gRyWo/rKJwrX06fC/XFm02WHHcT4i5tVoRs56
	VykdsAnYa0fNNJgxJ93AQBMm5D37+udHx90JknhTKdLKHIsP510nM7eTmBmFI6p60TX3bRK1Ztk
	rZEoz7Ihs8h3L5JRKUrGIJb9s5nArt++q3w7ger+l0Ey4VmGWcoHRQ==
X-Received: by 2002:a05:6a00:b54:b0:781:9f2:efb1 with SMTP id d2e1a72fcca58-78c98caeeb6mr2454609b3a.15.1759473882569;
        Thu, 02 Oct 2025 23:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRkc7pb2nOTbZ7c8Dj/UDGkoclrgPKazpbVxg/HFecHLgQfgRUlOOrOmAjbI4kVsd3bmTfQ==
X-Received: by 2002:a05:6a00:b54:b0:781:9f2:efb1 with SMTP id d2e1a72fcca58-78c98caeeb6mr2454586b3a.15.1759473882134;
        Thu, 02 Oct 2025 23:44:42 -0700 (PDT)
Received: from acelan-precision5470 ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a3f1sm3837742b3a.12.2025.10.02.23.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 23:44:39 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:44:22 +0800
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Andrei Kuchynski <akuchynski@chromium.org>, =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix workqueue destruction race during
 connector cleanup
Message-ID: <iexpu4kyyq4hwqwtgerihxumdxn5wx2mytqleagmhiogp7g2lp@cismgnobnik6>
Mail-Followup-To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Andrei Kuchynski <akuchynski@chromium.org>, 
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>, Venkat Jayaraman <venkat.jayaraman@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251002013026.4095030-1-acelan.kao@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002013026.4095030-1-acelan.kao@canonical.com>

On Thu, Oct 02, 2025 at 09:30:26AM +0800, Chia-Lin Kao (AceLan) wrote:
> During UCSI initialization and operation, there is a race condition where
> delayed work items can be scheduled but attempt to queue work after the
> workqueue has been destroyed. This occurs in multiple code paths.
> 
> The race occurs when:
> 1. ucsi_partner_task() or ucsi_poll_worker() schedule delayed work
> 2. Connector cleanup paths call destroy_workqueue()
> 3. Previously scheduled delayed work timers fire after destruction
> 4. This triggers warnings and crashes in __queue_work()
> 
> The issue is timing-sensitive and typically manifests when:
> - Port registration fails due to PPM timing issues
> - System shutdown/cleanup occurs with pending delayed work
> - Module removal races with active delayed work
> 
> Fix this by:
> 1. Creating ucsi_destroy_connector_wq() helper function that safely
>    cancels all pending delayed work before destroying workqueues
> 2. Applying the safe cleanup to all three workqueue destruction paths:
>    - ucsi_register_port() error path
>    - ucsi_init() error path
>    - ucsi_unregister() cleanup path
> 
> This prevents both the initial queueing on destroyed workqueues and
> retry attempts from running workers, eliminating the timer races.
> 
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 50 ++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 5ba3a6c81964..1f71c9983163 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -283,6 +283,33 @@ static void ucsi_poll_worker(struct work_struct *work)
>  	mutex_unlock(&con->lock);
>  }
>  
> +/**
> + * ucsi_destroy_connector_wq - Safely destroy connector workqueue
> + * @con: UCSI connector
> + *
> + * Cancel all pending delayed work and destroy the workqueue to prevent
> + * timer races where delayed work tries to queue on destroyed workqueue.
> + */
> +static void ucsi_destroy_connector_wq(struct ucsi_connector *con)
> +{
> +	struct ucsi_work *uwork, *tmp;
> +
> +	if (!con->wq)
> +		return;
> +
> +	/* Cancel any pending delayed work before destroying workqueue */
> +	mutex_lock(&con->lock);
> +	list_for_each_entry_safe(uwork, tmp, &con->partner_tasks, node) {
> +		cancel_delayed_work_sync(&uwork->work);
> +		list_del(&uwork->node);
> +		kfree(uwork);
> +	}
> +	mutex_unlock(&con->lock);
It introduces a deadlock here.
  - ucsi_destroy_connector_wq() holds con->lock and calls cancel_delayed_work_sync()
  - ucsi_poll_worker() (the work being cancelled) also tries to acquire con->lock

I'll submit a v2 to fix this issue.

[  246.874552] INFO: task kworker/17:0:125 blocked for more than 122 seconds.
[  246.874565]       Not tainted 6.14.0-2014-oem #14
[  246.874569] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  246.874571] task:kworker/17:0    state:D stack:0     pid:125   tgid:125   ppid:2      task_flags:0x4208060 flags:0x00004000
[  246.874577] Workqueue: events_long ucsi_init_work [typec_ucsi]
[  246.874592] Call Trace:
[  246.874594]  <TASK>
[  246.874598]  __schedule+0x2cf/0x640
[  246.874605]  schedule+0x29/0xd0
[  246.874608]  schedule_timeout+0xfb/0x110
[  246.874611]  __wait_for_common+0x91/0x190
[  246.874614]  ? __pfx_schedule_timeout+0x10/0x10
[  246.874617]  wait_for_completion+0x24/0x40
[  246.874620]  __flush_work+0x86/0xe0
[  246.874624]  ? __pfx_wq_barrier_func+0x10/0x10
[  246.874629]  cancel_delayed_work_sync+0x76/0x80
[  246.874633]  ucsi_destroy_connector_wq.part.0+0x61/0xd0 [typec_ucsi]
[  246.874638]  ucsi_init+0x27a/0x330 [typec_ucsi]
[  246.874643]  ucsi_init_work+0x18/0x90 [typec_ucsi]
[  246.874647]  process_one_work+0x178/0x3d0
[  246.874650]  worker_thread+0x2de/0x410
[  246.874653]  ? __pfx_worker_thread+0x10/0x10
[  246.874657]  kthread+0xfb/0x230
[  246.874659]  ? __pfx_kthread+0x10/0x10
[  246.874662]  ret_from_fork+0x44/0x70
[  246.874665]  ? __pfx_kthread+0x10/0x10
[  246.874667]  ret_from_fork_asm+0x1a/0x30
[  246.874672]  </TASK>

> +
> +	destroy_workqueue(con->wq);
> +	con->wq = NULL;
> +}
> +
>  static int ucsi_partner_task(struct ucsi_connector *con,
>  			     int (*cb)(struct ucsi_connector *),
>  			     int retries, unsigned long delay)
> @@ -1798,10 +1825,8 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  out_unlock:
>  	mutex_unlock(&con->lock);
>  
> -	if (ret && con->wq) {
> -		destroy_workqueue(con->wq);
> -		con->wq = NULL;
> -	}
> +	if (ret)
> +		ucsi_destroy_connector_wq(con);
>  
>  	return ret;
>  }
> @@ -1921,8 +1946,7 @@ static int ucsi_init(struct ucsi *ucsi)
>  
>  err_unregister:
>  	for (con = connector; con->port; con++) {
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> +		ucsi_destroy_connector_wq(con);
>  		ucsi_unregister_partner(con);
>  		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
>  		ucsi_unregister_port_psy(con);
> @@ -2144,19 +2168,7 @@ void ucsi_unregister(struct ucsi *ucsi)
>  	for (i = 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
>  
> -		if (ucsi->connector[i].wq) {
> -			struct ucsi_work *uwork;
> -
> -			mutex_lock(&ucsi->connector[i].lock);
> -			/*
> -			 * queue delayed items immediately so they can execute
> -			 * and free themselves before the wq is destroyed
> -			 */
> -			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
> -				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
> -			mutex_unlock(&ucsi->connector[i].lock);
> -			destroy_workqueue(ucsi->connector[i].wq);
> -		}
> +		ucsi_destroy_connector_wq(&ucsi->connector[i]);
>  
>  		ucsi_unregister_partner(&ucsi->connector[i]);
>  		ucsi_unregister_altmodes(&ucsi->connector[i],
> -- 
> 2.43.0
> 

