Return-Path: <linux-kernel+bounces-736246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB127B09A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BF17B87E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736CD1CB518;
	Fri, 18 Jul 2025 04:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6wqpF/8"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3412B94
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811592; cv=none; b=NIa1PwrzOOIGiyvSZp/qFTumiB3HP2u99nHZf4k9r9qMFs/6oBpGBVGsmAFHAtw/TKfmisP15IRwyrQTMEZ50WTspEMxYu8sOQbb2M9K6HTqPX9sBuojialvQwj2hqc4NCIN+FC8RPpyKGiNd9hE4BMgL9yOYelv87I4VkyH6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811592; c=relaxed/simple;
	bh=Dj5u/KtQFgYFQRI0MbO1+bVCFk4kZLlPojif+opMDp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUGiudnSzijPCr9Z4ZaTw4Hgqx8uPnVDq01jkhgQR9JeC0M/fsqrAPJcn2s4f6UxsVYZsAFaGxNkJwFjs3d0ncz3SZqRVROEhyrLjj9vGQIO4QcTH7lLLpB6YBcTdiOD4cZFVar+rdYywI0IuX+9kEjcToQ5W+N2aOBZlOQk4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6wqpF/8; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <48d38fb0-a144-4c32-9d3d-da8ea2fe08d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752811577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tryI3rBd+up7m/BNegEFHhpaR0DXA2esdgQopySmydU=;
	b=Q6wqpF/8gauvVkF/6haR1Djd+f1UagPMj5Uobv2/LbIYcmKg+zwLjsJOiW6KiZQJe4xCgS
	ZdA/+qmNReLgIqaFI9hbdB9sC7cyFRedfLXo2JckBukCZvL7B8K1T881hRcGj00pb1G4t5
	en0L7nOAuJeRrcAFj7hA/mnOteSxnLg=
Date: Thu, 17 Jul 2025 21:06:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: fix warning
Content-Language: en-GB
To: Matteo Croce <technoboy85@gmail.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
References: <20250717200337.49168-1-technoboy85@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250717200337.49168-1-technoboy85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/17/25 1:03 PM, Matteo Croce wrote:
> From: Matteo Croce <teknoraver@meta.com>
>
> When compiling libbpf with some compilers, this warning is triggered:
>
> libbpf.c: In function ‘bpf_object__gen_loader’:
> libbpf.c:9209:28: error: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>   9209 |         gen = calloc(sizeof(*gen), 1);
>        |                            ^
> libbpf.c:9209:28: note: earlier argument should specify number of elements, later size of each element
>
> Fix this by inverting the calloc() arguments.
>
> Signed-off-by: Matteo Croce <teknoraver@meta.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


