Return-Path: <linux-kernel+bounces-883816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D4C2E7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 00:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED67C3B7B17
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 23:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399930595C;
	Mon,  3 Nov 2025 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qLppOKHy"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660112FE582
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214262; cv=none; b=ZHTHNWUW0vsI8cCFl6R4g+wmDHuGql5JaHO/UA46tVytpzwMDvbtA/FYMwR3UX1pSwbXFYWIks2n3pu3k0QElRxjWxQgWSQtxWkO4MrUHhleOPOQPe4QEQZ8VwxKREVgCO/XO1gH4+3ktdRM6HJmNR4ROaPd5rqECzjSknnDok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214262; c=relaxed/simple;
	bh=y25Fi9R+DV774dACqWt7ANCpRtX6RdoKdfvMXM9/UUY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uP1k4bDu0a/2YspBswxLR0FPGxrXh3E3+4yK2eaO0Bo7efkce/UeXg7O0jbjmSJaHIGLcP7wvuPyuigMp7UL1I+MhHl25CW0x0WtOdsDBcW9TdlnE3vz6QiI+M/dJXKTyz67yclNIF80fbcKxs7aW9ifvNPLeve1mIBxtXjIi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qLppOKHy; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ab28c85-fc15-438b-aa5c-cfeb2c6917d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762214258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blZkUePTFN0ZGEGKm/2J8vki+7wNvHua0gAAI8x27B0=;
	b=qLppOKHyWQmL8ghCgXgR2/dToJNjU5th1omqK3tV+0prJw5i+ySuIecVGp98bJMihxMWTK
	Eu6c3aMiXo6SIEpaxwncMA4LnTVNCPQZMry3MQ0ma85IpQa3Z9wsBjk2dtQnwFyH6Qwvwa
	WyK6u1x9NwOcQuLIsQs0x/dH49YmoSc=
Date: Mon, 3 Nov 2025 15:57:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Requests to git.kernel.org return 502
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: helpdesk@kernel.org
Cc: bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <d0ca5bfb-5ead-4f67-8716-d44485a8d8f7@linux.dev>
Content-Language: en-US
In-Reply-To: <d0ca5bfb-5ead-4f67-8716-d44485a8d8f7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/14/25 2:36 PM, Ihor Solodrai wrote:
> Hi, 
> 
> Today we started seeing frequent 502 errors on attempts to fetch from
> git.kernel.org in BPF CI jobs, which causes many of them to fail.
> 
> Kernel Patches Daemon instance is also down because of this. 
> 
> Example [1]:
> 
> + git remote add origin https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> Initialized empty Git repository in /tmp/work/vmtest/vmtest/.kernel/.git/
> + git fetch --depth=64 origin master
> fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/': The requested URL returned error: 502
> Error: Process completed with exit code 128.
> 
> https://github.com/kernel-patches/vmtest/actions/runs/18510075579/job/52750495992?pr=404
> 
> Any recent changes on kernel.org side? Is this a known issue?
> 
> Please let me know. Thanks.

Hi all,

HTTP 502 from git.kernel.org picked up again today.

Examples:
* https://github.com/kernel-patches/bpf/actions/runs/19052891379/job/54416890870
* https://github.com/kernel-patches/bpf/actions/runs/19052904470/job/54416948499

