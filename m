Return-Path: <linux-kernel+bounces-868181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF51C0496F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 696544E3166
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B92278E7B;
	Fri, 24 Oct 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxXrZGDW"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF526560B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289038; cv=none; b=ih5MdStRTQ9KAC+5bV26uY7/4mB5c8Q5baYwrvz8xcNZdHeLibUvdS/gY59/UPmbVQv9Dk7k8EwOV2tth5DesDHEtplf5fmOmHNMugmOILFhdnyJny/seFtk2Fnt3PQ3e2bwR1v1Bn0onPnNQtQgI5R0ebY3SYihTWaancUKbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289038; c=relaxed/simple;
	bh=l27XdHQbBM+7OkmY+JBO6NcVOae8OD6osrJX9LZz7Ig=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZJShTcPpPqqKYSg0FjEAta7y5Aap2HqA5IFllzOweOTp2e04TlP804wTx2Wbpwrur98xVppFs1Ntel/+CnQF8hxViCTToJ4w1D3Sl+J0LFTYuqJiksHBCx8Kumpz8MRYH7+7YGXawrLaIWw054SBEAm5/yO3TZeBbdS9Uv4NnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxXrZGDW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426f1574a14so963486f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761289035; x=1761893835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ORMJ7BlrHXqNeSTsxJ4qy2dmyq6fW2e6Eo8f/etUvO4=;
        b=WxXrZGDW5ptcP3JI4+bdKvuYLMOOm0sKsV1617oZDPOq4otBUlkyOTMC1SMetgZK98
         4AIZsDC47DLX3IVnsqNRQtZtPICgv9RRfkw71kqUlVq2QHfgjtGyDBLoioX9Rdh9GLSg
         xe67v2HFx9WPb8qYtqFCw9B24Av6fEql2o3K87mrRAPCij7t7+MmFLa2uO4PcOOrUiFy
         5dKpEjL3qVbDFB30skXXrXww6lN7VmvNd3ceagRQh11WJUlHdbGn5+kvq0VlkpGl0Iat
         1+tDvQyZTKnpJVCSNm6L2hMEdUUuDpTWN56mV35mPNWTI9uFsGtwIJpggWglaeg3U7fW
         uEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289035; x=1761893835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORMJ7BlrHXqNeSTsxJ4qy2dmyq6fW2e6Eo8f/etUvO4=;
        b=uptTb6Fri+Ywyb6jQk748edlU0P3af0qRjgp65QX46Sxdqk48ckMHGza4riXS1uMMJ
         tc46f+pa9vIXXr4Nl58o/dz/iCVof7xRV7G65dprfoqmD1ckQ4ScWaUWMc3jTmyicMlP
         QgPmyEGxxpiWqvSz56UhskqrM9sDyYMG70aR/PiL/EV0uqk+qgRn6jlds07HubhTXSQ8
         8zCH6vXtdZQG5I0jFryIJMXqLk85q7iSOT54OcEyFd0g+Z7J0xCcrtJN0kmNKf/255d1
         kdRPm1MfHwKo+ZEpabCJ4gtWVGBMFZg+QEsYYACkCFuru5R5nt5KQQjOmP35ivK54v1S
         +R7A==
X-Gm-Message-State: AOJu0Yy//IWhVgTtZaYZGWfZTzgaR0eKpxuPUfBHsaSNx32dyP9Sa+rl
	bDsuQ0NzfYUlibUcgmbdCxJvR7/31pUNors1vRmZ7tOgEE/74dMqDIRS
X-Gm-Gg: ASbGnctsY1zLWjBjczUIoDjsKbiI8Y5nm25SyIsZnwIqqt352oHYgcNhYR6ui9ALJMe
	H6ciuXpfqrfhhUSHAHUAiIGYgK3RW6K0wPg2aYobyh9F81+ltne39JxgZEyVAqP03JN/etl9EOb
	F8SDWQsPP3oZXG7mrsVhsc2ZoTdwl4zmCe5wl0M6isUHb5VOkto+Tv3Olfy7srytVKKabbais3W
	9BLzFdl5F4EFb4iTUU3NyswRAPqz6pk7l/krqCcwL6cUJjNaa7LTuy6SWQQPoBw+Vf30muk6IQS
	wUxFStLY8TbjkAO8XE2WwfV+bNqk0zVbtC/Mwz16+c9RGuqItczbmypEa7+Nqvz6hE+/G8zjVOc
	ld6/ttdj84QhEB8go5bX8BH0osdgSMFaVrWEre2nQrRrkKlyvLg==
X-Google-Smtp-Source: AGHT+IHpUTilMgnX8ETVEknhaI2lHNfs+gF9oo5RMnpwrwZ3GZ6FYDuD6jwow1gnOGUua1J45MTuTA==
X-Received: by 2002:a05:6000:40db:b0:427:2e8:fe48 with SMTP id ffacd0b85a97d-4298a040682mr3178731f8f.4.1761289035317;
        Thu, 23 Oct 2025 23:57:15 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898eac60sm7545816f8f.39.2025.10.23.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:57:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 08:57:13 +0200
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Subject: Re: [PATCH] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
Message-ID: <aPsjSZtNxeQK239J@krava>
References: <20251024060720.634826-1-jianyungao89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024060720.634826-1-jianyungao89@gmail.com>

On Fri, Oct 24, 2025 at 02:07:20PM +0800, Jianyun Gao wrote:
> In the elf_sec_data() function, the input parameter 'scn' will be
> evaluated. If it is NULL, then it will directly return NULL. Therefore,
> the return value of the elf_sec_data() function already takes into
> account the case where the input parameter scn is NULL. Therefore,
> subsequently, the code only needs to check whether the return value of
> the elf_sec_data() function is NULL.
> 
> Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b90574f39d1c..9e66104a61eb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
>  	int nr_types, i, vlen, err;
>  	const struct btf_type *t;
>  	const char *name;
> -	Elf_Data *data;
> +	Elf_Data *scn_data;

makes sense to me, but this rename breaks compilation later on

libbpf.c:3027:53: error: ‘data’ undeclared (first use in this function)

jirka

>  	Elf_Scn *scn;
>  
>  	if (obj->efile.btf_maps_shndx < 0)
>  		return 0;
>  
>  	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
> -	data = elf_sec_data(obj, scn);
> -	if (!scn || !data) {
> +	scn_data = elf_sec_data(obj, scn);
> +	if (!scn_data) {
>  		pr_warn("elf: failed to get %s map definitions for %s\n",
>  			MAPS_ELF_SEC, obj->path);
>  		return -EINVAL;
> -- 
> 2.34.1
> 

