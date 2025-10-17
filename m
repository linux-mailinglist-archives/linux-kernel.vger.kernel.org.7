Return-Path: <linux-kernel+bounces-858300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10034BEA023
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA3CB5A0EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A638232E13C;
	Fri, 17 Oct 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G1JeZR/0"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A23BB5A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714514; cv=none; b=MCR7oZlV9f3q4nfesXsTQUghJLqEdPZWDIrUeWhiGVbEfifbs9NbildbkGOkyla9/rl1i95HS5IpVpUVOPE4wBfPJEk9ReJqpKbdi5hTTV6+PJL9i2UynOyHrkOXKYrYvKhUTuSiri4eBUnVsLfXBb2M0z+bAAsv16ybBnZoQBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714514; c=relaxed/simple;
	bh=cD5lzGSRwCd3aMVoBb/nxlQt1Ub9ETxjqx5mZdiEI5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw5L2lvIhLngHlEzPqhWOzlcR6LKgLCG4zhrWsdt0TZfjEvqYKDGOxAV50bptm6luIYf95Q97HI5rdVlknommC72CAjMoFghIqglbkPyFfdSAzlunz+Ugqrkgkd2K0Gh1WMLJF++v/k1V1QXUS8VaZiNtoKkCNrC86/Mh/RJAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G1JeZR/0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40982e43-84c5-481b-9a9a-0b678ef7e6e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760714509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkMY0uuZfod9gyq2VvBYbOMe1I9+moAbfCiqtkeHOTM=;
	b=G1JeZR/0XdTvDX7J04eTIuCdHlwYN0vWjBao0csCkAYnXby0hel8CzU3cfo9paLEzpN+JO
	eXY4vlpddsMntvNmUDbuHsb/tkRwQa6onnUvUDFrD98QMtPqKy7HvaHWI0j/kJAw+5cHsT
	wXGDh+Yo69Upov8+w6cqsejGyHGg/gU=
Date: Fri, 17 Oct 2025 08:21:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [selftests/bpf QUESTION] What is the proper way to fix the build
 error
Content-Language: en-GB
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <5ca1d6a6-5e5a-3485-d3cd-f9439612d1f3@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 3:05 AM, Tiezhu Yang wrote:
> Hi,
>
> When compiling tools/testing/selftests/bpf, there is a build error:
>
>   CLNG-BPF [test_progs] verifier_global_ptr_args.bpf.o
> progs/verifier_global_ptr_args.c:228:5: error: redefinition of 'off' 
> as different kind of symbol
>   228 | u32 off;
>       |     ^
> /home/fedora/newfixbpf.git/tools/testing/selftests/bpf/tools/include/vmlinux.h:21409:2: 
> note: previous definition is here
>  21409 |         off = 0,
>        |         ^
> 1 error generated.
>
> tools/testing/selftests/bpf/tools/include/vmlinux.h:21409
>
> enum i40e_ptp_gpio_pin_state {
>         end = -2,
>         invalid = -1,
>         off = 0,
>         in_A = 1,
>         in_B = 2,
>         out_A = 3,
>         out_B = 4,
> };
>
> The previous definition of "off" is in
> drivers/net/ethernet/intel/i40e/i40e_ptp.c:
>
> enum i40e_ptp_gpio_pin_state {
>     end = -2,
>     invalid,
>     off,
>     in_A,
>     in_B,
>     out_A,
>     out_B,
> };
>
> CONFIG_I40E is set in the defconfig file to build i40e_ptp.c after the
> commit 032676ff8217 (LoongArch: Update Loongson-3 default config file)
> in 6.18-rc1.
>
> What is the proper way to fix the build error?
> (1) just disable CONFIG_I40E (CONFIG_I40E=n), then no "off" in vmlinux.h
> (2) set it as a module (CONFIG_I40E=m), then no "off" in vmlinux.h
> (3) modify the variable name "off" in verifier_global_ptr_args.c

I would recommend to rename 'off' in verifier_global_ptr_args.c to 'offset'.

>
> Thanks,
> Tiezhu
>
>


