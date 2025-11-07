Return-Path: <linux-kernel+bounces-889662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F5FC3E2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CE83AB198
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7282F9DBE;
	Fri,  7 Nov 2025 01:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HB5pHHbY"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAB2F9D82
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480579; cv=none; b=TJ8JGheUiawh0KNhOKPpWmIrpDZA4D3oW3w6tXSySKvgNRCwkhQ7wabqbIG9jLdsIGDtt6vYYLb+lZ97w7XV5eYIXT3qxs36x0z5WWd6A8Hyqoy1I/J1gbWjMKa2Pmj9jituCo/u/JOvFklfGVar1V2dvVwq8byjg1v0j3isOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480579; c=relaxed/simple;
	bh=p6R10Mt99IJ7L5EX9Pz64PtFc5GadxKkdrR4NCqCwq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG5gkJdWMIpdqOKs6gI6/CwZ+JauYqTrjw9ywaCh9QL7InBua8l8J+OHCINPzvrSZGr7kyKOGC8IchRc9vdpuwANj+7goJcgm2cC/ll6EAqKD5ATVKiLxx+dNYCOshvbUgugiNYWzebs9Pa9vaVeGIt1KkQSZxlEh9RUbztNHiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HB5pHHbY; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <531517b7-16c1-41fc-b878-f5e681696f03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762480573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6R10Mt99IJ7L5EX9Pz64PtFc5GadxKkdrR4NCqCwq0=;
	b=HB5pHHbYMHbGHhWYzOfnO1Fx0fTfSfMXutTqTjTENNPTO8eJrD4JBW0nXYDlac/KBdo21r
	waB8oEi5fPNBjRyBHLLc2SuDfgbbNBh4+UItg7RNdj1eIoefjSqG05V34njXHDnGKogMZo
	ipJPUlysA5beuUGja4NxnN9mf9q0Rzw=
Date: Thu, 6 Nov 2025 17:56:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Free special fields when update
 [lru_,]percpu_hash maps
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, ameryhung@gmail.com,
 linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
References: <20251105151407.12723-1-leon.hwang@linux.dev>
 <20251105151407.12723-2-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251105151407.12723-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/5/25 7:14 AM, Leon Hwang wrote:
> As [lru_,]percpu_hash maps support BPF_KPTR_{REF,PERCPU}, missing
> calls to 'bpf_obj_free_fields()' in 'pcpu_copy_value()' could cause the
> memory referenced by BPF_KPTR_{REF,PERCPU} fields to be held until the
> map gets freed.
>
> Fix this by calling 'bpf_obj_free_fields()' after
> 'copy_map_value[,_long]()' in 'pcpu_copy_value()'.
>
> Fixes: 65334e64a493 ("bpf: Support kptrs in percpu hashmap and percpu LRU hashmap")
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


