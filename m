Return-Path: <linux-kernel+bounces-759374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02612B1DCC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485195835B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1D920E032;
	Thu,  7 Aug 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mHWx7TxD"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9361FF7BC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589400; cv=none; b=GksJBGBeUpQ6fjATdbKirdSUw9IMlkYfhPXjFQOld4nBAgrvI8KSsGfjYBjGWv0FWjEEfSE1jVAY5Ou2AdSkytlnQ5WVB80k92gSRG2MNE2FOQvgwK63LlmZIuWex+pFFobCh19fVQgfPubo6Xe0buA1sD6CjWwDnh5grlOqPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589400; c=relaxed/simple;
	bh=xUzIsduhnzH57x0xDZhlh0GrQPY8S5bdwG7nGOIeu/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD5ypjvrwgKDeV/42DS58h/32knZ/ijYcpAzfuaFZQ4xtwOyrXlA3gF6of453FGoagvTyQoDaWCtpUL1N2Ls8wos8zT6mVKqW40Rga2omlpud13fXdTGQPj4GgKED18azack6cwQ3zdNcKuqOcE+7qONdZpbup4eL2D4VKZ0zUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mHWx7TxD; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00745334-e29d-4e99-b2e3-8c0076146733@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754589384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUzIsduhnzH57x0xDZhlh0GrQPY8S5bdwG7nGOIeu/E=;
	b=mHWx7TxDpkFZuTCbQjDhn6SwmQfCbCEJiQc4yHl6m5MIDrwBOi+JgrXfNL5z9lp/BCGNln
	C24s4/UnhHQfPyJuan9e48V1040ySMgvq3P4edgDWK2daloJLVpswlN8kB5/c9jsrZB0Ae
	bqCIwnUr/LyaXfgE5t+59qKdRaeM0CM=
Date: Thu, 7 Aug 2025 10:56:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Use cpumask_next_wrap() in get_next_cpu()
Content-Language: en-GB
To: Fushuai Wang <wangfushuai@baidu.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org
References: <20250807024800.39491-1-wangfushuai@baidu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250807024800.39491-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/6/25 7:48 PM, Fushuai Wang wrote:
> Replace the manual sequence of cpumask_next() and cpumask_first()
> with a single call to cpumask_next_wrap() in get_next_cpu().
>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


