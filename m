Return-Path: <linux-kernel+bounces-885979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9859C346F4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3E618C06CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73AB283CBF;
	Wed,  5 Nov 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QNtqji7Z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B912566E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762330801; cv=none; b=l7MGt9F0C3Y7UgugId+sYHPNNzRJQeGhE81b+tsuLaAN9uu/arEXZSX+emcZLI9TCyQj69Y0ZdUTjpBYVnraqyOLCpHVwn/kZWB+HYl4a6Lw1mAynWdjjXyzmjj0DjSUX1/Mja6p1DjQeF+rDQQ3WSVhcTj/SspsS3ung+PqlWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762330801; c=relaxed/simple;
	bh=iGlHjbSVKGGym3U23i7SdjhPDqTMOthBoaOervoF05M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAEwPjtsuECRuzEWzE1OWN6y6Spxeqk69p5dZ/FvkIJw4+ki9FnX8TCz28ce3vVGbuz1XjkQilUqRz/rZzy1zQY3GkPPN2F2oMpYPG6rRcOpA4U0PVqi3Y7xZU/qBpb9i7SUucUpC9u2uDjlaN6XVNm8TwWUg113CtyN7l+LS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QNtqji7Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b725ead5800so125508166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 00:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762330797; x=1762935597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQrBXNgrEH7DGm+hsPHKmGk/jGaaI76D+GIvDvjNENU=;
        b=QNtqji7ZsJkeLhXsxMUghte8cMXJTYocdx8sM7jeqmU3PIDKrSxGpQevN7OC2PyRfP
         FWrOm4dOC1cbzw9JNDVICzngTKDKIgjbyWBzBEnUscNdxdGWW42Czx6HxS+EDD564HKK
         eZMz24NFtgeqUTDYYGlt2HcLkNxT/CetGp97pjCejsKsB5VA8G6FW8SU+M1Uj1nR/faG
         HTWAsXun2zEh6Dc7cawkVCeAQ7o2GKnEMDHLwf7P6pn581v2yecGwukPU+asFxeiiKvW
         YJ0I7ght3Dz3Pn7nEOSyxDpzZVOADjmVA7gJwB0O+bIwJ9fZeiA+wFXVJqgflhv4cfH9
         hqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762330797; x=1762935597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQrBXNgrEH7DGm+hsPHKmGk/jGaaI76D+GIvDvjNENU=;
        b=eetFo1CU71ZMqSzVMp8PhHcWpuMJi2hDL7HwGxIsHqFeK2lUMmlF/Ei6HmOKxZgQEo
         u2kBOErH+usltaVjLx6oSc0Y0EjH1o1gjKvtwM/jM0d3E+fpudXGZtKYx0dAonzj/4Bo
         fIC+aY8dX9D8z4hOMS0tJZFhcW5oCZFexpT8x1/3v4CkIxd85z3gDuYvGEWxkYxDXwOI
         FC2H/8PMH4ASf9C/9dpzOlFlDOyKoddSIWI4tOU3q9bs6vIg6SVmVEJ2KLVTzl7x5ofR
         mOWVnJjAaDQYUgKcyoCs2W+3TX5OOYZK+7/nuu7mMsh11wuws5o4SoZdArxrbt1EAX1G
         wR4w==
X-Forwarded-Encrypted: i=1; AJvYcCUJF+Mvcwp+6w+OKj6juWJu/AgMRdWqa3glRIUE4GQ2QMSjLIfHJorLV4i9N+020xb1uGUav2J+2Rxpm+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4R8zIn3Llj/h5LuiuIKHIA8RRkH5tBRIpwRtctBW4EIaiMyh/
	2bmRvOc13Re603zzIuAlDiys1DHzrlBqPQYuXgaW7I5xaeKYvdh+WyXgICM1c7UKuFs=
X-Gm-Gg: ASbGncsr8CDPUZr1Xz+IXzomM3SBWjZ3mnq6adtS3fKF63NqzMOlU3hKEmjlv+8zd0f
	B1mXXZDUVBWlNXjj/5/O8vjM62h4xUiiEU5t+MSiBM/WwsWgvVFRN+HN98/Xb7lI+qUQ95s7BwW
	GmJAr6LpJyM09bpGbxUVnZRrlmARTD/ZXjfAe/4VuGkaWSaegqbXpWf0SuWujiRVLn/tmKE/tTV
	S/IrN6ZZ+HEb6lAOeyLrxL0mZxaHaiirYrCakYR4KcgIm/iv+TXMmQxq9rMv/FrVnj4VnzBgGyG
	dihGYYNbl8Ronh6ioESpQ+ENPgm9bHnDiShjTVIBM4kyEDTg7rhB62iAiX+igJtug8rJ2Olzr95
	XXIR9kFca0HtND/SVh3vosJ96aGQcUy3FMbhlxk5gP/vRdPjMZwDwl8tdnvuZES3zOR4/qB/ZEV
	DGuclnTQuC3tVfkg==
X-Google-Smtp-Source: AGHT+IEXHVZLvJt37T+Or0zq36XdlBJ5vgi75Kr1QEZUdY14YccQtqD44O4+t6LmVKBw9ksebwzytg==
X-Received: by 2002:a17:907:6ea6:b0:b6d:8e29:8f67 with SMTP id a640c23a62f3a-b72653eac19mr201927966b.26.1762330797054;
        Wed, 05 Nov 2025 00:19:57 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b725d86b9b1sm269126066b.25.2025.11.05.00.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:19:56 -0800 (PST)
Date: Wed, 5 Nov 2025 09:19:55 +0100
From: Michal Hocko <mhocko@suse.com>
To: Leon Huang Fu <leon.huangfu@shopee.com>
Cc: linux-mm@kvack.org, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, joel.granados@kernel.org, jack@suse.cz,
	laoar.shao@gmail.com, mclapinski@google.com, kyle.meyer@hpe.com,
	corbet@lwn.net, lance.yang@linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Message-ID: <aQsIq_zQXMfNNo6G@tiehlicka>
References: <20251105074917.94531-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074917.94531-1-leon.huangfu@shopee.com>

On Wed 05-11-25 15:49:16, Leon Huang Fu wrote:
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 6eed14bff742..8cab6b52424b 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "stat",
>  		.seq_show = memory_stat_show,
> +		.write_u64 = memory_stat_write,
>  	},
>  	{
>  		.name = "force_empty",
> @@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "numa_stat",
>  		.seq_show = memcg_numa_stat_show,
> +		.write_u64 = memory_stat_write,
>  	},

Any reason you are not using .write like others? Also is there any
reason why a specific value is required. /proc/sys/vm/stat_refresh which does
something similar ignores the value. Also memcg.peak write handler which
resets the peak value ignores it. It is true that a specific value
allows for future extensions but I guess it would be better to be
consistent with others here.

One last thing to consider is whether this should follow
/proc/sys/vm/stat_refresh path and have a single file to flush them all
or have a per file flushing. I do not have a strong preference but
considering both are doing the same thing it makes sense to go
stat_refresh path.

In any case, thanks for considering the explicit flushing path which is
IMHO much better than flushing tunning which would become really hard
for admins to wrap their heads around. Especially when dealing with
large fleets of machines to maintain.
-- 
Michal Hocko
SUSE Labs

