Return-Path: <linux-kernel+bounces-799108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F363DB42711
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B7A583AA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E13090D5;
	Wed,  3 Sep 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MvlRZCnH"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01F2FFDFF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917608; cv=none; b=sz8jwit/RRDCyQzTkQSf1zF/K4LrnKFaT91vvMiNH68MvO3ESNeJKBOYjd8BFHHon+EsHUr5MYYeBVJoJonOleETjnvGOvNLl8XL1zyLRFbW9lhcJz28i2ucD6biIcQYNir3BIbf3YbsDwR+big15RueoHl4VUcAkyRa0T8Sgs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917608; c=relaxed/simple;
	bh=GkT27k8521xKwE4vsVHYIijN+ErqAhuCYeNB+5iTVR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmXeJF1dhBJuW8YsL9Zx/p/4oSBzRiLMKgYFbaCuj6IkXtKesNK+fLzo5eSKdk/IAWktWkRoAkRmowmu5vIwsAFdDYzalRZVSLAs7pehI9lMqzswa1l3H8+88aBkWXh1uKI02GNGbGo6WfkXa3cKsHjdUpAgxnPOhI8+na/0PV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MvlRZCnH; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <809a98fc-2add-4727-af98-6f72e16c71e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756917593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkT27k8521xKwE4vsVHYIijN+ErqAhuCYeNB+5iTVR8=;
	b=MvlRZCnHdLtPkMM6ZWpEknGYCt88jSY7I/cEeQD9cSaxHJjfW/S92+tLoPcvFO6zldfvST
	6Av55wkxEencakn8CMgJ3Fj+5ElmKwJwae74p3KOO9X0/ew4bGx373NKcNu1JMCFWQg9k7
	LUwIEo7ptFZGaRifa3lsVEbRMYuX1dw=
Date: Wed, 3 Sep 2025 09:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strcasecmp kfunc
Content-Language: en-GB
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org,
 vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756856613.git.rtoax@foxmail.com>
 <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_292BD3682A628581AA904996D8E59F4ACD06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/2/25 4:47 PM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


