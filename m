Return-Path: <linux-kernel+bounces-785516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F174EB34BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C808A243B55
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1228C5BE;
	Mon, 25 Aug 2025 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TjjzCZ/Z"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF58635C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153781; cv=none; b=URA4dcM0GB5l50SqX1kN+yxfJCHwda2Srr2D/Sbz2zX5etfdHlPvlTXFt0wU1MUSAy6CEdZAKjqklSRlan68/UUr3Qj0gxWVTloWX2t1fpcL05knL/LxyyLTH7rg+prWPuAKRT6A3R47t+IEBdhGtOo/kYYLIc1UZ64zgYeCc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153781; c=relaxed/simple;
	bh=02+8MH6hCAPPlDg8TadPjxMPFyzg3PMO1koKRqRz91I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Voaos6rUKu97cDaT8bEACZ4o9+SzWjRtShj96bECE2YrAnBOChvpHKvlkTSeCk5O6s33rREn9S6eU50NtlqbcYUB/1VQvEI/ajVIGWPBHLk99uA1Xwd2NWCDCtfclhRj+A3fEZMf5aSdMFGz8IwOmRgCXrcDm+/zqnIF4H8I5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TjjzCZ/Z; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <659fd81f-a017-48f0-b04a-41679dc5a61b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756153773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02+8MH6hCAPPlDg8TadPjxMPFyzg3PMO1koKRqRz91I=;
	b=TjjzCZ/Ze/wzh0nrIm9uj0QEDQIhK1ieq2BTUKU6v9xLzlfXIRwOQ5VinGJIc770SNgCDs
	Vq4hrVGz3aoXlnTy45Uc3ndH5LTJ5xYmqwFa7rVG/dwiPaYX5cQ7OYJnEs1W56x1Nm91d2
	UDmsSzYpsobzZ5V3nuTry98jj8I+hjo=
Date: Mon, 25 Aug 2025 13:29:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v7 1/2] bpftool: Refactor kernel config reading into
 common helper
Content-Language: en-GB
To: chenyuan_fl@163.com, olsajiri@gmail.com
Cc: aef2617b-ce03-4830-96a7-39df0c93aaad@kernel.org, andrii@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, chenyuan@kylinos.cn,
 daniel@iogearbox.net, linux-kernel@vger.kernel.org, qmo@kernel.org
References: <aKL4rB3x8Cd4uUvb@krava>
 <20250825022002.13760-1-chenyuan_fl@163.com>
 <20250825022002.13760-2-chenyuan_fl@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250825022002.13760-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/24/25 7:20 PM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> Extract the kernel configuration file parsing logic from feature.c into
> a new read_kernel_config() function in common.c. This includes:
>
> 1. Moving the config file handling and option parsing code
> 2. Adding required headers and struct definition
> 3. Keeping all existing functionality
>
> The refactoring enables sharing this logic with other components while
> maintaining current behavior. This will be used by subsequent patches
> that need to check kernel config options.
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


