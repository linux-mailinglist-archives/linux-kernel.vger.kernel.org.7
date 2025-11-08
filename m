Return-Path: <linux-kernel+bounces-891346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307BC427DA
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8605E34AD2C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97232D3220;
	Sat,  8 Nov 2025 05:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqaZG7gw"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54474317D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762580623; cv=none; b=lBI8x7vG37fmJkuLygxIEyPZ0fFWyloodoyue0EZJK2mVdG6SDQp+Dd//QH7JD3LqZLO/DXsFjfwXQUW7HvrYJKJrrFGgqQq5kmuj8FE452KojZWIYJB0JuV9Evt648R9NJ+nwnaf4PJ0GoH3qBnAoFb/a+V1GzEYgJNKP1qDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762580623; c=relaxed/simple;
	bh=6+3QBIMUZuIBDI74CUWKSNU7+Vn+B+YyMwNW3K9c/8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTSKuwmYWLLT4zlfVK3VpVU0cRJpYgGcj+IWUP7+X9QgWougOxwuJtbPW6BkQXmzJ19l/GBIKk4/ZG9X3IntnqlUTWu6zNP37kjHzgBnthAJnog4YfSolXPlbCef7qVYgAE0Iv+24XOIO8WjjOwJn0NxPEzx/r8b4ghsM4myqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqaZG7gw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-341988c720aso1181659a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762580621; x=1763185421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgYVFt/5cKKkxw4z+MkcUXS/aRBQjVkrukAvQeR1s08=;
        b=AqaZG7gwZRCLyQODFvlJSCsPqbpDNttnGMfg8/k3+F4THg6osuPwYx1Mp5ge/voQ9W
         Qft2oS6/+AwMH/+UM2UGorqF/eSwp6l9a+QKSF5WDGh0+jvoCa1jFTSYfzzhePZhFIqR
         G8BjsIUG5NSGH9HqAlgOuZd5Mx+AUlxVAwIbzuM0L0t5K4c3LnjUuBwjCj5FQzeyi+eE
         e8BuDEznk7lJmzMQZARonvwK9dFB/ML/i6CbCIllMQqXa+b8URQCB+L8CV4LRf7g95/4
         5ev4bRrDJB9v17/0ZFiOY30T6+6S1db7/ap+UwkMfynmL9p17aheUD8EPGMYiVfD0dM6
         SLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762580621; x=1763185421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgYVFt/5cKKkxw4z+MkcUXS/aRBQjVkrukAvQeR1s08=;
        b=G1zb1nhzVs+NX69FSiIhZHYJ4dxJhYzdohnrUfMnJAu6U6Pg3+vyYDA+ZJhZ5Oixsm
         nB9P7I8Vzdcm2APjzyuzo2XaClLPS1brzWDFG0XLNvdc1JjTAoMpo3Zom2qO3DQK+MBS
         br1ZCf11QfKXpOmSN+IYyA4T6kc2sJ43lt9VjL/5bHjfZR18j3rqZEo72i7g6+6qdmH2
         /qC6crq+F2x+4iw9W60xmNgU1bWiNjXICZjF5dJsaf5diKrWYwg75qpqeZjDfdGxgJ/u
         w23UDlbMscPA1TRGiLAoY/vqwfi4aZ/wHSkEt7HXUTocqoTcsvX4NNlxWntWekVt6xPk
         x3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVxjXAoXUdnMkFX3UHFxnWLOP2OJiuf5XGBRnWWCahBfSNhD5dsQwuZMvdzg2C+uY12p3sPlcY2xpmfOf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDiXsj4//ohM1pE6tYAz0MMRPUqRMcH76b2nj7ogyO/i07fHu
	ntLGpKbhtnySGbC3SdyHQfpNSCupHcl80h12Q/BuYJLjhdPoPTY4fBRdNG8LDQ==
X-Gm-Gg: ASbGncuR86wVCGNbpCXmkNr1H0aUsQ7SHqdG1wpTersPp0Z0sJXfumDNo6y3lKdGWDY
	Fpx5OM8k9pOMc2YrM4vqLuiqehIhUCMxlxipvvyTdCOGW2VxAYjdY6JnrfNOvxx7hmYqO57Ba06
	8YEC4r4WKXOikWbI+JVC6PYYg1UTwUJ8EVWXPapRGHUc1BwjpdI3yKfhU/PFbj1x7tbL0BCKqqM
	yAw7CJBBeleOwI9/Gl+3vtvRAr6i1zapmIdt+/o0Vkcz4kiwPvJmrU2AIFEU7LFqf+iNHJPvZpu
	Sphj23Qz4uktsIRSYS/mk/2SPvqpLRpGkinZTZejvCzXopL13teTsakxy94GwRMLEmkkf/Gxurv
	y/t7CE4w2t9RRiKXetAVfBfXMu2Bgn/9bv3K3xvaCYVTe/ozWCMTsaGtD7JniUnmb88WUYNHVJZ
	wpJtPs95lWOKESVjvY39FPTtkY6DRxQDIkib+uUChItw==
X-Google-Smtp-Source: AGHT+IHMR7GPWAKEfw7ThuY13gPYohxp2j9WgbIuCb0ltB24qgokE8z/u2VYdWXRqW1JN2nKWRVA6g==
X-Received: by 2002:a17:90b:3851:b0:340:be40:fe0c with SMTP id 98e67ed59e1d1-3436cbc935emr2201562a91.36.1762580620883;
        Fri, 07 Nov 2025 21:43:40 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:57b9:b373:19a1:a072])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68c822dsm11076670a91.8.2025.11.07.21.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 21:43:40 -0800 (PST)
Date: Fri, 7 Nov 2025 21:43:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kuba@kernel.org, alexander.deucher@amd.com, pali@kernel.org, 
	hverkuil+cisco@kernel.org, akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com, 
	tglx@linutronix.de, mingo@kernel.org, Jonathan.Cameron@huawei.com
Subject: Re: [PATCH] Input: psmouse - fix use-after-free bugs due to
 rescheduled delayed works
Message-ID: <jbkzqczxnnf5el6xxyumeyoact7iw3js6reoand3clrpjyyblf@fhxvbg7fu6n5>
References: <20251108045609.26338-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108045609.26338-1-duoming@zju.edu.cn>

Hi Duoming,

On Sat, Nov 08, 2025 at 12:56:09PM +0800, Duoming Zhou wrote:
> The flush_workqueue() in psmouse_disconnect() only blocks and waits for
> work items that were already queued to the workqueue prior to its
> invocation. Any work items submitted after flush_workqueue() is called
> are not included in the set of tasks that the flush operation awaits.
> This means that after flush_workqueue() has finished executing, the
> resync_work and dev3_register_work could be rescheduled again, resulting
> in the following two use-after-free scenarios:
> 
> 1. The psmouse structure is deallocated in psmouse_disconnect(), while
> resync_work remains active and attempts to dereference the already
> freed psmouse in psmouse_resync().
> 
> CPU 0                   | CPU 1
> psmouse_disconnect()    | psmouse_receive_byte()
>                         |   if(psmouse->state == ...)
>   psmouse_set_state()   |
>   flush_workqueue()     |
>                         |   psmouse_queue_work() //reschedule
>   kfree(psmouse); //FREE|
>                         | psmouse_resync()
>                         |   psmouse = container_of(); //USE
>                         |   psmouse-> //USE

Before flushing the workqueue we set psmouse state to PSMOUSE_CMD_MODE,
but psmouse_queue_work() is only called from psmouse_receive_byte() if
the mouse is PSMOUSE_ACTIVE. Therefore there is no chance that work will
be scheduled while psmouse instance is being freed.

For ALPS, the work is a "single shot", so will not get rescheduled.

However I think that the changes are improvement to the code. Please
split in 2 (for psmouse-base and alps separately) and drop mentions of
UAF in psmouse but rather mention that disable_delayed_work_sync() is
more robust and efficient. I think if we switch to it we should be able
to get rid of kpsmoused workqueue and use default system workqueue.

Thanks.

-- 
Dmitry

