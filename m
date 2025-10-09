Return-Path: <linux-kernel+bounces-846808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D8BC9180
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E393C5B88
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C412E6CBD;
	Thu,  9 Oct 2025 12:42:56 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D602E62A1
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013776; cv=none; b=QW+5K1c58Ru64X9JireQ22/fekv7bmMJp9x7WucncuTVYxzduzNtnBpziqm/Ky64BclBWgEiK2ZzltNgfbPwVoEYc4ed74RSBll+YVn5HlBNngeflhxvX+czx7hMxaQMB/tOOQQM+9yc5M4F/AQzT+9KU5h125VNifr3iWQ/VRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013776; c=relaxed/simple;
	bh=WmpQBY6TbZ5ansusUYRaOEUZ7KkH3epNLcYEh/JQ11A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sRIRaUXL+BrXrH2TndEdU9a8f9gmLGkJWfd+94KkHU+QdrM7D6ErVgbkeg+cR+CSC7Bs8+wxVMCCjFmRI1Ts5a4g8l+mZjbfKnE1eR/sN6YdMtO0PARp+/EZQTHnyG8KoA3OGPbXj7xlEDtOboyiDSn/hBW0RU3G2cXe7gphYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3dbf11fa9eso150607366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013773; x=1760618573;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyrRfyeyAKkW55cTD8t/TpjrjYwQIMXKnAOmH4iGp1U=;
        b=VV5aNZc/ckkv/HzXN342gl/TXCNUKELXlU79flLvKupIB73PYX6jR77GU+63+0D8Nr
         lrfG6nKyKgaPYgoneyE3T4sGBIOIFG7igDljED+eTzPpS3375fNySuBLrAB1tUQIUoUc
         xhmOPho0WKvZp8DBhzKLWMGEddCGVCj7mEurBKl+UuRQfpaenYf3xBfqWRVATu/6Obub
         qu5ds36K+ZL9Mmdygu6G/3DDKLI4mQp7R21iYFw0Ullwex+D21A19z56vqR4KkVPQ5fb
         Z1ESTdxEleLvMX53J2LRDCKOjWekhXFKPKW+2KxQxLHLmvg/sj4DvwJGcHg5KYcFG2G+
         xMJw==
X-Forwarded-Encrypted: i=1; AJvYcCWVy36oTgndy32rSDXH9/Z6pYU5+56O968T8QCXYhgBGdA8i72+u6CtimvwJQMGJZ1akkkXKUqdBxODyVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NBfgdc94jUjjSWjxSf2JdTUsKkEtUaMa4W4+cgtqlks5pvTE
	g7xfoZgizMQqJUD1DG20P803l70HchJjO2IhdymOyBfHJ2/ombeeLD3YtXGJkA==
X-Gm-Gg: ASbGncvk3Txtz9sZQ7R/cnBQ4SLCjVxBgLxRV2+PTkxLqvXgY0deCtQVDUtcKx11ebX
	WM+s2VCZrrQNYQCRasJPXjchRD1E/2L0hNlKk8t5vpjk9STsbYsSH5uYrbdU18YA592DASosz+f
	QOXAKTYQ0dLZoAlTtYUvs6WlILwf6m0fxNTS9uaIRSDrbvoUmsIhtdR4xCLlEUu6C/+PLDaJwAw
	oxFgY9yR632nhu48jSlq0dcSlxz/vJSjAHdrdr1OrXSKkRtcmDDCPLw4QwqbC+Xb8JiCDbXkpSr
	TJHcldoDJ52g7flvtQzo86aw6C5vOpqh1PM245qqg5HVt+HPDBGNMTY4vwW2JQTYxZ87UIj3I4k
	OBLrBEpPdCfZS+La6VAYqPo+ERhLIklATgW6kscVe4A==
X-Google-Smtp-Source: AGHT+IFuKfX7/ZZVmvCxT5q69r5K5958LNTBo4BJneTc+LU73F5QtYlXnUH99ORNGxM9LdOlBjnCZw==
X-Received: by 2002:a17:906:7313:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b50aa793004mr810654666b.2.1760013772798;
        Thu, 09 Oct 2025 05:42:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55a8843fd6sm5490966b.74.2025.10.09.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:42:52 -0700 (PDT)
Date: Thu, 9 Oct 2025 05:42:50 -0700
From: Breno Leitao <leitao@debian.org>
To: saeedm@nvidia.com, itayavr@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dcostantino@meta.com, kuba@kernel.org
Subject: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
Message-ID: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am seeing a crash in some production host in function
mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
that doesn't seem to be addressable. I am seeing this on 6.13, but,
looking at the upstream code, the function is the same.

Unfortunately I am not able to reproduce this on upstream kernel easily.
Host is running ConnectX-7.

Here is the quick stack of the problem:

	Unable to handle kernel paging request at virtual address 00000000213afe58

	#0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
	#1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
	#2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
	#3  snprintf (lib/vsprintf.c:2983:6)

Looking further, I found this code:

        snprintf(tmp, sizeof(tmp), str_frmt->string,
                 str_frmt->params[0],
                 str_frmt->params[1],
                 str_frmt->params[2],
                 str_frmt->params[3],
                 str_frmt->params[4],
                 str_frmt->params[5],
                 str_frmt->params[6]);


and the str_frmt has the following content:

	*(struct tracer_string_format *)0xffff100026547260 = {
	.string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
	.params = (int [7]){ 557514328, 3 },
	.num_of_params = (int)2,
	.last_param_num = (int)2,
	.event_id = (u8)3,
	.tmsn = (u32)5201,
	.hlist = (struct hlist_node){
		.next = (struct hlist_node *)0xffff0009f63ce078,
		.pprev = (struct hlist_node **)0xffff0004123ec8d8,
	},
	.list = (struct list_head){
		.next = (struct list_head *)0xdead000000000100,
		.prev = (struct list_head *)0xdead000000000122,
	},
	.timestamp = (u32)22,
	.lost = (bool)0,
	}


My understanding that we are printf %s with params[0], which is 557514328 (aka
0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
is invalid, and crash.

Is this a known issue?

Thanks
--breno

