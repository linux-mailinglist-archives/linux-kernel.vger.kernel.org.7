Return-Path: <linux-kernel+bounces-624317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DB5AA01FA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67014640F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B87224234;
	Tue, 29 Apr 2025 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hun5pi1i"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA017C21B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745905694; cv=none; b=LdD2BEEcYZ1E9kG+CJNSTO0J7hrYXbLwHLuaFXfWggAtEshALgxxVtHzZZkBHBl0jK3m2Af5Q0kdcYWv9weEin5sBF/pl7s9y/Cncw4d0rhT0nIqNTtMHsbD49KvNbt7K58J3B4JBYVmkILLyMed6ujZS19oZ10/vTif3Tru8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745905694; c=relaxed/simple;
	bh=S2F9cy1P32D1MrCP40MrmJy0aXKoJEYRPzonUjlMoHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv1Lr8C3xZ6tCfdB4TPOYexVmIulwOSUA+cZRPTAbAEtLGEgS0uD8/vXHrujRyVVdjD33Solf750Tuh+Xo+h0REUEhd5QJoCIVHkdSJApGT8F7y971CSMzoOu6GJsoFy082oyWut97Pn0WwdsIQsewKna6esO76wxFEOT02nWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hun5pi1i; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a25f585-de46-4e3e-8ec2-47df25947df1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745905690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LZcbrAMfCDd4lnWPi8BBDX0LHsvZTUM8X0yPk05FoE=;
	b=Hun5pi1iblLS3Eb8YZyho/6ZdLG7pxP4GsGlQWTPl/rtedWkZJ5TejZ4IkSzXvQ4f04waS
	O5R4upoh2OSNjAoJvLc6f05gDO2cQb0XyotSksGiSoiTf3hkO9ZeTZbw7dRDDpTJB5T465
	I2y54h4bLxxvk8NCxsXoAHa0jqrBcCI=
Date: Tue, 29 Apr 2025 13:48:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: remove sample_period init in perf_buffer
To: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Namhyung Kim <namhyung@kernel.org>
References: <20250423163901.2983689-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20250423163901.2983689-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/24 00:39, Tao Chen 写道:

ping...

> It seems that sample_period no used in perf buffer, actually only
> wakeup_events valid about events aggregation for wakeup. So remove
> it to avoid causing confusion.
> 
> Fixes: fb84b8224655 ("libbpf: add perf buffer API")
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   tools/lib/bpf/libbpf.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 194809da5172..1830e3c011a5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13306,7 +13306,6 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>   	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.sample_type = PERF_SAMPLE_RAW;
> -	attr.sample_period = sample_period;
>   	attr.wakeup_events = sample_period;
>   
>   	p.attr = &attr;


-- 
Best Regards
Tao Chen

