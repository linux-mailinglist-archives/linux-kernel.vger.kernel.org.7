Return-Path: <linux-kernel+bounces-750687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6153DB15FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C750218906B1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF7290D81;
	Wed, 30 Jul 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2DX2/ke"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E01E2848
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876306; cv=none; b=OGSMQb65oOVeBHQrUVTRWcZ8gCUwTtr0DTelpDGX06aPWB4upkU7SU+wrcXwckK6j/kYJF29ts6u8M4QnU4v3Y/ynoAWiZq7//PWknagoXCw6IjPQAOgVDNyB2sPudhXTNdrBf+cf/gpZKbR50oq4BMeVHLdSigwslF8StGjPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876306; c=relaxed/simple;
	bh=jgREDXGePmQdfd2E7Vl8U2KGORUW/8wrdY5g6v1eY0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGyU7whRGEqT7r1rtNvs/IAHu5Ioph2smdM+q09rP8kvRquPjfKX7eK8miMms4Ajez3Vi4C2BAx6U+SCFEE+vtzblGsfrFOKghpxbRU9O/ETnScjql+jTx8M6tJcr8hHabM2j6ISXUoHcVFz4O+Zoy0WsXY/eSp0fFmrhwz4co4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k2DX2/ke; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7754e178-d8dd-4f11-a300-1fc964a5916f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753876302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cofzKk3+SnpP5m/YhFynok1TZi2YE/wS6Sd7AtPq+HE=;
	b=k2DX2/keevHls4RWwiShG9QTYYdPCBaBEnDitRcDbUIdV/Sf9k7fpwDfenlMoA4N4j3bWV
	XjmnquGeZ5v3b+SPyOGcao0dSkA0F0ywg9ppoeBG4ENvYAKATfOaAncZkeSywfUN1YBRGH
	BSgbX1yVSgL14a8i7ub+xecn0/53i8M=
Date: Wed, 30 Jul 2025 19:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] tools/latency-collector: Check pkg-config
 install
To: rostedt@goodmis.org, bristot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250730113028.1666038-1-chen.dylane@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <20250730113028.1666038-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/7/30 19:30, Tao Chen 写道:

The branch tag is wrong, i have resent it, sorry for the noise.

> The tool pkg-config used to check libtraceevent and libtracefs, if not
> installed, it will report the libs not found, even though they have
> already been installed.
> 
> Before:
> libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel
> libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> 
> After:
> Makefile.config:10: *** Error: pkg-config needed by libtraceevent/libtracefs is missing
> on this system, please install it.
> 
> Fixes: 9d56c88e5225 ("tools/tracing: Use tools/build makefiles on latency-collector")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>   tools/tracing/latency/Makefile.config | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
> index 0fe6b50f029b..6efa13e3ca93 100644
> --- a/tools/tracing/latency/Makefile.config
> +++ b/tools/tracing/latency/Makefile.config
> @@ -1,7 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
> +include $(srctree)/tools/scripts/utilities.mak
> +
>   STOP_ERROR :=
>   
> +ifndef ($(NO_LIBTRACEEVENT),1)
> +  ifeq ($(call get-executable,$(PKG_CONFIG)),)
> +    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
> +  endif
> +endif
> +
>   define lib_setup
>     $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
>     $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
-- 
Best Regards
Tao Chen

