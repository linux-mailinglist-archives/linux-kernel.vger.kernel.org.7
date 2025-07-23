Return-Path: <linux-kernel+bounces-742918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85676B0F83B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821043B43CC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F221F8728;
	Wed, 23 Jul 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iCl1oCF8"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD85D8F0
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288625; cv=none; b=o1YThenwoCwBExxLa6ne96qLgx/dlU/a8j1Pj4vkl2N0RXkO+pLO9eWB6J84sLlAuW0ppYfxbclyTPIV0WNEMXeITajrOdl0StSgjE/eMQk5+rAbHayNoeEi5XtikNYElo1qGHVXEWxNp8zhlxI4uc62FipCM0PZFhbgHV6Ea0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288625; c=relaxed/simple;
	bh=uQK/kDm5O1+JDjGflQAUOpedr2WcSif01QDjqbCyJng=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=okmvBzV94jMcJDgwtHYSOL+OQTAtZUr92RWHjuZAiFrr1Qwl20/inOebs9oIcPMyBaiR2BKK2P6UHXmQ6n+E8dJyy1TDgNX+8+SrG0o7MMrkAgHIogWTf9gLLzvD6KO6k80mNOUNRfl3j1x7S2UFdRJK+b8w1/YySdCBERBb+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iCl1oCF8; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64ad1cf5-16a5-4d01-a6ef-17f2afa92663@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753288620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQK/kDm5O1+JDjGflQAUOpedr2WcSif01QDjqbCyJng=;
	b=iCl1oCF8ys4oRJWVZXAfqNIkO5CU7zD+DU6vMhIK0aRioPQ5Y0zVdUk6tdh9En5JCwan4V
	uYLXDZwD5BkpQCXcE8fPpNaVCiezcfMeD/SPFn4TYaJ0L2SAHc3EyIY5I9vMP3GSs2VVN7
	KT6YrpPhdn/RxhUeY17tjJK0ZSKToss=
Date: Wed, 23 Jul 2025 09:36:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Show precise rejected function when
 attaching fexit/fmod_ret to __noreturn functions
Content-Language: en-GB
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org,
 laoar.shao@gmail.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
References: <20250722153434.20571-1-kafai.wan@linux.dev>
 <20250722153434.20571-2-kafai.wan@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250722153434.20571-2-kafai.wan@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/22/25 8:34 AM, KaFai Wan wrote:
> With this change, we know the precise rejected function name when
> attaching fexit/fmod_ret to __noreturn functions from log.
>
> $ ./fexit
> libbpf: prog 'fexit': BPF program load failed: -EINVAL
> libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
> Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.
>
> Suggested-by: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


