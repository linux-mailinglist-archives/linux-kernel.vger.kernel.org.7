Return-Path: <linux-kernel+bounces-897258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 988B4C5267C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF3544F66DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080723375DF;
	Wed, 12 Nov 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQg7vxCO"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B95337107
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952898; cv=none; b=CljKMZzWh/ffND18Op70K29AvCmFdpplXCa5Xiqi6BHi/PO9OBzBZYg1Ec+Yfo7xuR/mVH13etvwjoXCffF9ciLoMvwe4ynd4AeBFpK6jHoFy96axf0EcohTTPQ3PRsVa39APg9nqqVWGTfE5ljfkIPkwqGLtJlqHA8OqAM+mAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952898; c=relaxed/simple;
	bh=5BUX+aPleMlR+0TV9/SdhpG8VKnucDfm0cN98ifo74I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWlx5RUJBHaELsBJ//fYDowgGoJrOhbjRLildQdM3lD2bZDyMRPOZQeODuVBsTEvsWjk1woz3KLaBpKfmFl1RCUvR1abxWB2ixMxCxkXbSyMXefGO7gaRWDREI545uPznjYYti5gRN88n3FFFYPukEpr0BDBfcvSP33gdJPK6R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQg7vxCO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so451200f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762952895; x=1763557695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZszFFp41//TiDs/7bMBLMV0kim0Oaw39R679g7Q4aw=;
        b=MQg7vxCOxVtjqzVjZJeg/LG4xhBIwo76dywzPY96rMrD3A9azjUcGX0FyAADfrolrO
         4VfFXGYT3InoubzSj5W2zBnVXnURQGYktXlLwSnBJipaWsaUu23cRMK5clUZr9L/S6ZU
         4OCohlM5hkbvxvgrQL29L5aaXvlypjt9nY6e8DHUT/Y/BTJmKLM6JfwhTopIFh9YsOG/
         /ERq0WZEJr8DyCgbLoJV6TvdnUK8BTEJmvcKf0enugFZbMyRoYgZIyxopwJicMwozSb0
         GCJb8jucLiUNuNmQkN+5nhu9SIYdlOmusAJI2mQ+bgeQAnbYnFeFTmEW9USQUrSAhwX+
         WUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762952895; x=1763557695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rZszFFp41//TiDs/7bMBLMV0kim0Oaw39R679g7Q4aw=;
        b=bKbPG/EDIMyQrQBLmrJcUEWb2z7xNCeA/qtxVMxQyLmiarY6IqWsyjPxw8h1Dk7RK7
         JRM/FsEWDviDjgb4R0a4x685DkMcaCuDVIU1wTV3XKy2QBq4soKfWR7/ddYpdXU/OPFY
         KwP2Icx0+b98wme7CvRnwXzd4lf8V4d9zCWxTiqfst24aDFjZii4ijtu7wZLRibAFWwM
         e1vBM0zBjvlyq61UYRvgsyqiJJbx+9So1LvMoYoNIWk3C+s/GAq7wVNU/4TypB5pSsjF
         NiRyj6+qwB3IR/hipFBF/VKvkxrB752A1zWrrVN4DeOjMOEokWO+Oupmtjok8e62nH5t
         8Gow==
X-Forwarded-Encrypted: i=1; AJvYcCWCgCUCBvxjQGKd945jR0BJV6OWTVw6Ri6ebCcbtw7z0em5OcW88baokNj4gWL7GBY6ZWx3h2tyBs6k6i8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF4HlZxrjM77PEECXMU7Yf2BVEWjqA3Dm5gtgj5Ezq2FEmBK08
	X7IwEEOc84eiMfz8Qlu8//NM7lP0gavfeMvoblwnEbrI1y0Ke5krv7lZ
X-Gm-Gg: ASbGncswuEONaHJZK45MSEjH+IEvoWiIb2MY2nupHqKGXC0/FCb7XIY84eOxIkVHKEW
	OE8f1qcbLEQwEBIGZxLeH59SJzZ0e1t9SoIaHBiqIkeOj7RPOwjHx3mBS9VAmbBvAaiDyTjA7Uf
	JcbjneKUdpNn6n+kWcd4QTRdIoDugDRBNMGP/UU1384Ej7FYN05LmNQpfAUx9vR1NMC8yxvpgiY
	mcQQ71nLNN6ad7LMKbN/BD6uSTnOJiAMq7bOmuHi6nu6yrv5KfwjymEsx6Qvr2tUxtaptnuESEJ
	t1epTOba6yM+foK72YyqOMn6J956ISiQi0/B7O/wjpvwWcu2q5SZxGkV6RZ5/a6KgkLw1zA2zlI
	UpWKs/+NSpenwG2jTkMzWCqvApY6oMKeI8JBu2F6xvMIWSbocja0Ig9LL83JDI+pDlTW9+up9+2
	Bh9UKO5wge9SwV+5+vAAKnyJ0kzTf9CiUVo6+0ChGgSA==
X-Google-Smtp-Source: AGHT+IHL9AQYgo6qFd6z0/B2T05jAm1hrIoKtL5TpQMpLpCe7ZFr6wNffq1HGZAD0MUTPoLFq+5yjg==
X-Received: by 2002:a5d:5889:0:b0:42b:3c25:cd07 with SMTP id ffacd0b85a97d-42b4bdd2288mr2450774f8f.61.1762952894523;
        Wed, 12 Nov 2025 05:08:14 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b4789896esm8318176f8f.38.2025.11.12.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:08:14 -0800 (PST)
Date: Wed, 12 Nov 2025 13:08:12 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghuay@nvidia.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Maciej Wieczor-Retman
 <maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, Drew
 Fustini <dfustini@baylibre.com>, Dave Martin <Dave.Martin@arm.com>, Chen Yu
 <yu.c.chen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Subject: Re: [PATCH v13 12/32] x86,fs/resctrl: Support binary fixed point
 event counters
Message-ID: <20251112130812.51532c2e@pumpkin>
In-Reply-To: <20251029162118.40604-13-tony.luck@intel.com>
References: <20251029162118.40604-1-tony.luck@intel.com>
	<20251029162118.40604-13-tony.luck@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 09:20:55 -0700
Tony Luck <tony.luck@intel.com> wrote:

> resctrl assumes that all monitor events can be displayed as unsigned
> decimal integers.
> 
> Hardware architecture counters may provide some telemetry events with
> greater precision where the event is not a simple count, but is a
> measurement of some sort (e.g. Joules for energy consumed).
> 
> Add a new argument to resctrl_enable_mon_event() for architecture code
> to inform the file system that the value for a counter is a fixed-point
> value with a specific number of binary places.
> Only allow architecture to use floating point format on events that the
> file system has marked with mon_evt::is_floating_point.
> 
> Display fixed point values with values rounded to an appropriate number
> of decimal places for the precision of the number of binary places
> provided. Add one extra decimal place for every three additional binary
> places, except for low precision binary values where exact representation
> is possible:
> 
>   1 binary place is 0.0 or 0.5			=> 1 decimal place
>   2 binary places is 0.0, 0.25, 0.5, 0.75	=> 2 decimal places
>   3 binary places is 0.0, 0.125, etc.		=> 3 decimal places
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  include/linux/resctrl.h            |  3 +-
>  fs/resctrl/internal.h              |  8 +++
>  arch/x86/kernel/cpu/resctrl/core.c |  6 +--
>  fs/resctrl/ctrlmondata.c           | 84 ++++++++++++++++++++++++++++++
>  fs/resctrl/monitor.c               | 10 +++-
>  5 files changed, 105 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 702205505dc9..a7e5a546152d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -409,7 +409,8 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>  u32 resctrl_arch_system_num_rmid_idx(void);
>  int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>  
> -void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu);
> +void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu,
> +			      unsigned int binary_bits);
>  
>  bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
>  
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index 40b76eaa33d0..f5189b6771a0 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -62,6 +62,9 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
>   *			Only valid if @evtid is an MBM event.
>   * @configurable:	true if the event is configurable
>   * @any_cpu:		true if the event can be read from any CPU
> + * @is_floating_point:	event values are displayed in floating point format
> + * @binary_bits:	number of fixed-point binary bits from architecture,
> + *			only valid if @is_floating_point is true
>   * @enabled:		true if the event is enabled
>   */
>  struct mon_evt {
> @@ -71,6 +74,8 @@ struct mon_evt {
>  	u32			evt_cfg;
>  	bool			configurable;
>  	bool			any_cpu;
> +	bool			is_floating_point;
> +	unsigned int		binary_bits;
>  	bool			enabled;
>  };

Nit: You've added 4 bytes of padding.

	David

