Return-Path: <linux-kernel+bounces-760644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96AEB1EE22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C441C26388
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6011F76A5;
	Fri,  8 Aug 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MbVenKpN"
Received: from mail-yb1-f225.google.com (mail-yb1-f225.google.com [209.85.219.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BF566A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676096; cv=none; b=t8kZqwSRz0VTEhvnbILzTFhnaHxOU/kIcr3RENuA6z5k1zoC4NgXEArTI+FMBWi43VzjxsuHwmyuXtkQehN7llhYeTKQiMiC3tgZXswd1HYqI6eOFJjvWy5kD0NsMPoGcRtYxoE7jmWOeo/QsdC4dNMLo80421i/mHJWdMt+CJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676096; c=relaxed/simple;
	bh=SsyPPJMmvaysp22qpQse6GPIGFPyPofA986E/cuuBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMZl5fM+6HLYdt3wz39fG9xOjHJnNs996706Q3+rt4HXuG+SieUaDbuv5v1zicPV2vFLZOw9C1+RHwLxWZBDMMTS4NY8drZrC1zSvJyY0vNvOn0rmRymummaGMDlpP/FoO5fHyaKfGvFYWOv3+n/qBiUiPlGB3S5u3cjWfNwBwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MbVenKpN; arc=none smtp.client-ip=209.85.219.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yb1-f225.google.com with SMTP id 3f1490d57ef6-e9052f82d4cso654332276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754676094; x=1755280894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTXWcQ/ORdy560KGcCDZgpcNl80jMFH9ifZEN0ULtpw=;
        b=MbVenKpNubDWXeepj6CHnI4ozTJXBx3Cc82B92KS1DG6XpBKqyKAJwZE2/6UDRNOAl
         d5liW3ELvqByDt+j7v3t8jho3OkFnL3Llg2u2hl3Wx2jDLbbXFDoeUsm1eqzrQClUm2G
         5d53N2+j3WijY9m/68gKEWSxmQ5L3JihaLJmXgFhJqcn9Z12QAtQPuAN/HXLSBvrnD5v
         KaIeKgClt/PoscLgHTcNp8Z1KoFrj6sXM0mfX5AYx+TVpKuLAbN/jXfIU6dJ3wfL30cT
         8X/wzzEpg1IEgOOuttkM0aePHp7LJy77dfPARKXU+53zmuN2Buk86JL+5YE/kUVdpesE
         836A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754676094; x=1755280894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTXWcQ/ORdy560KGcCDZgpcNl80jMFH9ifZEN0ULtpw=;
        b=oF5vupIAS1/bpAIN3EP3aN9yZaWYtBHvvKuYiQBPBdUqU5PMc5SmYYeZvRa5ocT3u6
         QmnEOQFjn9dbUfNzb8g9vYDEPmMYiI5grmCs7D/fSbFt9uflFF+6zyQJA5zPgU46KZ4i
         uVE617D3pCJ8J5VTSgXBDj4HM+Eb/VMgnAAjMVs3w8RCDXTuoK1VPmxFFBK1aXW3yfYd
         uo4r4Q6/sobFhcaiVyu7rEuPeWnHrx0tSbuv0jaGpU6vzFQQZVl+ING0b/bqPIMmTkrv
         2wI7G7zu000zNpH8Rcp6OpXClf7YuQevfFkQg663fUqJcTOwfR1l8guqplMQKv1JrKjt
         F3pw==
X-Forwarded-Encrypted: i=1; AJvYcCXzga84GCqXfJiB6pFmASHQb4ZfmtlF03VLTMfaM4AyqN/XxF6ppyFETHGi9oFdCelVxmTOTN+57uVx84o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjm8DsDvxvaHifoD5XAEidup0bOc0A1fgYNmRfFoVs6KLCkrE
	c6hHj7syBvXBgnB9FCwCw6O0Gu9ZIpkqgfpyzjyx5sgeCB3HTJNgs4xK2NQ5ArhjRJlIEKdSsEM
	iwlrYRwVh2rhnD3I3vp4s/4alOxrZw5J1DQjo2Y+AvDT7PJTzUS3B
X-Gm-Gg: ASbGncteyioh9VM0dGwwoF0iLDCpqyZvehfET68GBevBaDhWMV+Otoj/GfVaAAbmEGO
	F8NVQYWJ0umTjBseV55kcc2D6wrmxa8lNoL/PD40wxkDhcAtP35oF5OJNmhaXlT+B6uH34oKfy7
	w27edmr18Wk5i6Qt1YMeY9r/bqJefwzDMgUaOOElRllqo6gDxc1gO8x5N7KkMwukdHjWhjYLjEs
	+gkYKKcxBy7w8EKMt5SMCNbr4rgMVVIo3jLy5RrlC+MWzxInaWbzQhxYBGH5rZbxPLfXk2r5vRc
	gEhwhUP5P8zgO6l8Ma5f24Q3q52mit0fvMWjqghTEdROabpVvlDjR1dxooY=
X-Google-Smtp-Source: AGHT+IGpEJmA8wuiu7bHyM3anAmskWUJ+YGhc4UBossIDwMrUMtN/7LChpLKm0Ze705fw0cHnpIVIV1tP4Tt
X-Received: by 2002:a05:6902:114c:b0:e8e:120b:acc7 with SMTP id 3f1490d57ef6-e904b127023mr4685967276.0.1754676093522;
        Fri, 08 Aug 2025 11:01:33 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e8fea65c517sm1190001276.21.2025.08.08.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 11:01:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 66C8E340235;
	Fri,  8 Aug 2025 12:01:32 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 57299E4018A; Fri,  8 Aug 2025 12:01:32 -0600 (MDT)
Date: Fri, 8 Aug 2025 12:01:32 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Message-ID: <aJY7fPmOLMe7T5A7@dev-ushankar.dev.purestorage.com>
References: <20250808155216.296170-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155216.296170-1-csander@purestorage.com>

On Fri, Aug 08, 2025 at 09:52:15AM -0600, Caleb Sander Mateos wrote:
> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> daemon") allowed each ublk I/O to have an independent daemon task.
> However, nr_privileged_daemon is only computed based on whether the last
> I/O fetched in each ublk queue has an unprivileged daemon task.
> Fix this by checking whether every fetched I/O's daemon is privileged.
> Change nr_privileged_daemon from a count of queues to a boolean
> indicating whether any I/Os have an unprivileged daemon.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")

Nice catch!

> ---
>  drivers/block/ublk_drv.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 6561d2a561fa..a035070dd690 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -233,11 +233,11 @@ struct ublk_device {
>  
>  	struct ublk_params	params;
>  
>  	struct completion	completion;
>  	unsigned int		nr_queues_ready;
> -	unsigned int		nr_privileged_daemon;
> +	bool 			unprivileged_daemons;
>  	struct mutex cancel_mutex;
>  	bool canceling;
>  	pid_t 	ublksrv_tgid;
>  };
>  
> @@ -1548,11 +1548,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
>  		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
>  
>  	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
>  	ub->mm = NULL;
>  	ub->nr_queues_ready = 0;
> -	ub->nr_privileged_daemon = 0;
> +	ub->unprivileged_daemons = false;
>  	ub->ublksrv_tgid = -1;
>  }
>  
>  static struct gendisk *ublk_get_disk(struct ublk_device *ub)
>  {
> @@ -1978,16 +1978,14 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
>  /* device can only be started after all IOs are ready */
>  static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>  	__must_hold(&ub->mutex)
>  {
>  	ubq->nr_io_ready++;
> -	if (ublk_queue_ready(ubq)) {
> +	if (ublk_queue_ready(ubq))
>  		ub->nr_queues_ready++;
> -
> -		if (capable(CAP_SYS_ADMIN))
> -			ub->nr_privileged_daemon++;
> -	}
> +	if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
> +		ub->unprivileged_daemons = true;

Shorter:

ub->unprivileged_daemons |= !capable(CAP_SYS_ADMIN);

>  
>  	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
>  		/* now we are ready for handling ublk io request */
>  		ublk_reset_io_flags(ub);
>  		complete_all(&ub->completion);
> @@ -2878,12 +2876,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
>  	ub->dev_info.ublksrv_pid = ublksrv_pid;
>  	ub->ub_disk = disk;
>  
>  	ublk_apply_params(ub);
>  
> -	/* don't probe partitions if any one ubq daemon is un-trusted */
> -	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
> +	/* don't probe partitions if any daemon task is un-trusted */
> +	if (ub->unprivileged_daemons)
>  		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>  
>  	ublk_get_device(ub);
>  	ub->dev_info.state = UBLK_S_DEV_LIVE;
>  
> -- 
> 2.45.2
> 

