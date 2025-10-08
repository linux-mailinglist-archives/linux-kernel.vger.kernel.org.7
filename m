Return-Path: <linux-kernel+bounces-845244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA3DBC421F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954D740187B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275482F291B;
	Wed,  8 Oct 2025 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLhXqxjK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64419ABD8
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914912; cv=none; b=buYDp08GFT1uoEBSIOd3MBumt7eMMSGyP1KZ1obcX9mN8NnaPQHA1DjaPf7oacPpwmHAGcWRMLpixESPZC0AYrvmGOvEmgDwx+mqlbDPwxu/ciREnpyIlbzjF+1lD1Ah/QGOZ7Z4fGRdzqSMmOWjEWyIkgaTAlkTLlniveQAsTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914912; c=relaxed/simple;
	bh=SiozhhMfDbi/0gGGej9l2K8p5tBuMdyNvW79cB2nu+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=maZei9wgdz/Tv8f1QDWN2mn09mWucibeqUb7HuYwj8qx+aMhYLadKC1kB0sbJAwSvTjTAOo3lXgvV7kzXm7otvrdjhj1Beijk1/otG+vR//+32H46Yxg1B20GiTTez6bl3pkFRcFMgjth7E8D5YY2TuJOCQNv8xXs/kinIL+1Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLhXqxjK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782bfd0a977so6282099b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759914910; x=1760519710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0o0HS2/pqE2C3fiE9prxdfeC/X7f8Sic3V/E2Xltqg=;
        b=NLhXqxjKxxDhC0m2+v0Dcysqe6zD1NmY/XVJx6I7G+dXrbOG7KWpJ5fKmyo/HEBpph
         F/vRwm5/T+GRVn3tlplC8W+U/9Z1hZm4arbwbFotzf4KqBwLHICQhnh2DGVGeMEwLAbV
         YFSpEZMftQXgIQ3h8oPJBlmp197MWEx4fd4Fz650fTxrbp1KlHS8HMKZRS+0sRFzSMJZ
         ybD2zB009QthBKI0FHq/hRlEmGgypAkIsQGakhSYND5JbPCzNF+90f5+kEQITXyun3Dm
         Dop++IG7NKhPWbh9YKD6p1gki7e1GvvFKUU7vtUgjDwFtCcTkafRXeXtqWjzNhx38XzD
         nkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914910; x=1760519710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0o0HS2/pqE2C3fiE9prxdfeC/X7f8Sic3V/E2Xltqg=;
        b=NziB3mmUNQbWI4A8dRqKi2lBnjpWXbu0RByp7Ix84FpklXUxj/H97EMkQ3QHvXSIqL
         Gv0xYh0+uLQNPqWp9GP58wtZoRz7sZFpAy6DRvZlZk5jsbjT4mI53mjDu8vhcK5WTCvw
         QDAuTP5s/1a68EP6OYMLciatitMiNHKiMLMb568oW9z4/ZMFSEs6rKThJVb56M2yeqg4
         G64BHfnoMzeCgavvQwOna3XUhcG4iCDxkUd1rPQj9J0HkD4FL6KzEefrp/6wfJCMmyFt
         pCoPF6DQ1nCbTJvmxbXtHM1MuIaAo6sfY2tsR4wwDy3UVVJIgCKjo6vN7CKGWdnxyv2B
         5C+A==
X-Forwarded-Encrypted: i=1; AJvYcCVcRrXPBLSr8HT0fCsAbPDeAqTVKXvEt1NZr44JO396OWy+ZyP9WlldqBLzUoB31PYRvjKe0QaRZHS1LVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5k486Yjs5H5lzaxAUpFGGFeTND0trs5PDXWIGiDJN3j1C1zXi
	+Vtf7B6s4X3nvPNnAl9C7/lMGp4Ftjf0T+HPSqNkTi2ETjcKmvzSK6jg
X-Gm-Gg: ASbGnctBk/yn38xjOtOCbmkzya3LnxVVRKt7iwf2lPtyswDR/rtn/HwMarrNBsvfGJ5
	Q+dZem6I6lWsqOF/tmMhLH00NRc7ftoKE1zTbxZ61wc7NYWDVKnJUQXy2nA+rA0zVkk/gqvGOcw
	70pmUNsPvi8zb7X+rwR7FM8aHsfkzVHVXlyjQXgAByby/IfZZqoY2e5rjoYyvMXRKrQomrLZUf2
	vPhH1N7ww8xWAAiDshBcvqlFvGExQJFGGs7Pxa69r4jphOgMCs8Hap/7OVLqzP4VbMamim2nH+k
	ihsOTgRsWGLR03pEeDQI1+RYX9O0eI0GwY5beZtdy2P/YX+bMxZ0TuAn2pcgveYbeOaYM/LMj4g
	qFv2S2OEzpv8cv//7MYP0bhhyxuNadoU6g2/umvkF4sXUfm1T
X-Google-Smtp-Source: AGHT+IGI8yNIZ7gFtVqGqjSBsgXT7k8WHZPT+PKq0o+GwTZSoNWXWSv1W5+dhSLB5r3FHDgEyjLvog==
X-Received: by 2002:a05:6a00:1884:b0:77f:416e:de8e with SMTP id d2e1a72fcca58-79387efb06cmr3125777b3a.26.1759914909822;
        Wed, 08 Oct 2025 02:15:09 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7932d06d3afsm3168434b3a.70.2025.10.08.02.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:15:09 -0700 (PDT)
Message-ID: <20edc3a9-2efe-4431-b198-f00b3940777c@gmail.com>
Date: Wed, 8 Oct 2025 02:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] rvtrace: Add functions to start/stop tracing on a
 component path
To: Anup Patel <apatel@ventanamicro.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Greg KH <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Mayuresh Chitale
 <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mayuresh Chitale <mchitale@ventanamicro.com>
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <20251002060732.100213-5-apatel@ventanamicro.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251002060732.100213-5-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/25 23:07, Anup Patel wrote:
> From: Mayuresh Chitale <mchitale@ventanamicro.com>
> 
> The perf driver framework needs to be able to start / stop all components
> in a trace component path during its operation. Add rvtrace_path_start()
> and rvtrace_path_stop() functions for this purpose.
> 
> Co-developed-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> ---
>   drivers/hwtracing/rvtrace/rvtrace-core.c | 44 ++++++++++++++++++++++++
>   include/linux/rvtrace.h                  |  6 ++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/hwtracing/rvtrace/rvtrace-core.c b/drivers/hwtracing/rvtrace/rvtrace-core.c
> index 7013d50ca569..109be40d4b24 100644
> --- a/drivers/hwtracing/rvtrace/rvtrace-core.c
> +++ b/drivers/hwtracing/rvtrace/rvtrace-core.c
> @@ -614,6 +614,50 @@ static void rvtrace_release_path_nodes(struct rvtrace_path *path)
>   	}
>   }
>   
> +int rvtrace_path_start(struct rvtrace_path *path)
> +{
> +	const struct rvtrace_driver *rtdrv;
> +	struct rvtrace_component *comp;
> +	struct rvtrace_path_node *node;
> +	int ret;
> +
> +	list_for_each_entry(node, &path->comp_list, head) {
> +		comp = node->comp;
> +		rtdrv = to_rvtrace_driver(comp->dev.driver);
> +		if (!rtdrv->start)
> +			continue;
> +
> +		ret = rtdrv->start(comp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rvtrace_path_start);
> +
> +int rvtrace_path_stop(struct rvtrace_path *path)
> +{
> +	const struct rvtrace_driver *rtdrv;
> +	struct rvtrace_component *comp;
> +	struct rvtrace_path_node *node;
> +	int ret;
> +
> +	list_for_each_entry(node, &path->comp_list, head) {
> +		comp = node->comp;
> +		rtdrv = to_rvtrace_driver(comp->dev.driver);
> +		if (!rtdrv->stop)
> +			continue;
> +
> +		ret = rtdrv->stop(comp);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rvtrace_path_stop);
> +
>   struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>   					 struct rvtrace_component *sink,
>   					 enum rvtrace_component_mode mode)
> diff --git a/include/linux/rvtrace.h b/include/linux/rvtrace.h
> index f2174f463a69..e7bd335d388f 100644
> --- a/include/linux/rvtrace.h
> +++ b/include/linux/rvtrace.h
> @@ -273,10 +273,14 @@ struct rvtrace_path *rvtrace_create_path(struct rvtrace_component *source,
>   					 struct rvtrace_component *sink,
>   					 enum rvtrace_component_mode mode);
>   void rvtrace_destroy_path(struct rvtrace_path *path);
> +int rvtrace_path_start(struct rvtrace_path *path);
> +int rvtrace_path_stop(struct rvtrace_path *path);
>   
>   /**
>    * struct rvtrace_driver - Representation of a RISC-V trace driver
>    * id_table: Table to match components handled by the driver
> + * start:        Callback to start tracing
> + * stop:         Callback to stop tracing
>    * probe:        Driver probe() function
>    * remove:       Driver remove() function
>    * get_trace_id: Get/allocate a trace ID
> @@ -285,6 +289,8 @@ void rvtrace_destroy_path(struct rvtrace_path *path);
>    */
>   struct rvtrace_driver {
>   	const struct rvtrace_component_id *id_table;
> +	int			(*start)(struct rvtrace_component *comp);
> +	int			(*stop)(struct rvtrace_component *comp);
>   	int			(*probe)(struct rvtrace_component *comp);
>   	void			(*remove)(struct rvtrace_component *comp);
>   	int			(*get_trace_id)(struct rvtrace_component *comp,

I'd suggest add another function (*quiesce) or something like that. Trace
components have a tr??Empty bit that indicates trace has been all flushed
out. Also along the path when you do rvtrace_path_stop, you need to ensure
the source has stopped and quiescent before beginning to stop the sink.
Otherwise you'll get partial or corrupted trace. In essence, follow Control
Interface Spec 11.3 Enabling and Disabling. FYI: my userspace driver:
https://github.com/ganboing/riscv-trace-umd/blob/master/rvtrace/funnel.py#L223

Bo

