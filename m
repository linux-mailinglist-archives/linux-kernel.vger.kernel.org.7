Return-Path: <linux-kernel+bounces-874610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A247C16AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18DA1C22B78
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798802C15A5;
	Tue, 28 Oct 2025 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HS45+suS"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122052D0625
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681282; cv=none; b=N9/stI99sd8MG35Mssos21LRrxgiyEvPcA5a97glVHA2rIQGHcn+10hOHuoc0RFaTUsvd0YUDa8qMmVsQ5gFA+geU2i4vltnzPx1UsJLpzeEfnrgBahAAPw/acUCmRMrWvYgykeOLEQQU8KBn7TMmh4p/2IjugXOzvnnsTaK7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681282; c=relaxed/simple;
	bh=GhznppW5jwYDRcAihiwYTPNGnL0pOvsU68n6vWbNcPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QADzsR+EwdityBYWWvPSU+HIvMI38oiWjgPiapETUk97z7DeIyfARG8RZ/k46Ryts+aq2s1QvBfqU5kjKhNqNwwvdRN7cku048mIiK0yKLiEN9++J3t/G9f0eMqdUoi0r1+SeyC3LlFd2/xHpJZMTHbUkegzB+xEPDQASfdKiS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HS45+suS; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 28 Oct 2025 12:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761681277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bb0C3VyuAmSiKsi2qlBRx/pFXIP36IO29vP/bFyjw0g=;
	b=HS45+suSm2rzrJQMMkE+ycYcgEd0ql+2mj/3Lex3TN7T7ZQvpXI25hP3pXR3WsB0zcaUNK
	uiEipqPSyA+Q2udnhlpK792HxTJ2Mp/Q/kHXIOwPZubUX60qkv7f5jqoZbW18g6cQajOUP
	D0wHWOIWHS9q0agqXQNk/58Ej7bERuk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: oom-killer not invoked on systems with multiple memory-tiers
Message-ID: <o3gxx5uipm53gccoccjjdvtvv6gkyx4r7qexzdkg3uqtqc7wsv@yd3rqfsy2bpz>
References: <20251022135735.246203-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022135735.246203-1-akinobu.mita@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Akinobu,

On Wed, Oct 22, 2025 at 10:57:35PM +0900, Akinobu Mita wrote:
> On systems with multiple memory-tiers consisting of DRAM and CXL memory,
> the OOM killer is not invoked properly.
> 
> Here's the command to reproduce:
> 
> $ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
>     --memrate-rd-mbs 1 --memrate-wr-mbs 1
> 
> The memory usage is the number of workers specified with the --memrate
> option multiplied by the buffer size specified with the --memrate-bytes
> option, so please adjust it so that it exceeds the total size of the
> installed DRAM and CXL memory.
> 
> If swap is disabled, you can usually expect the OOM killer to terminate
> the stress-ng process when memory usage approaches the installed memory size.
> 
> However, if multiple memory-tiers exist (multiple
> /sys/devices/virtual/memory_tiering/memory_tier<N> directories exist),
> and /sys/kernel/mm/numa/demotion_enabled is true and
> /sys/kernel/mm/lru_gen/min_ttl_ms is 0, the OOM killer will not be invoked
> and the system will become inoperable.
> 
> If /sys/kernel/mm/numa/demotion_enabled is false, or if demotion_enabled
> is true but /sys/kernel/mm/lru_gen/min_ttl_ms is set to a non-zero value
> such as 1000, the OOM killer will be invoked properly.
> 
> This issue can be reproduced using NUMA emulation even on systems with
> only DRAM. However, to configure multiple memory-tiers using fake nodes,
> you must apply the attached patch.
> 
> You can create two-fake memory-tiers by booting a single-node system with
> the following boot options:
> 
> numa=fake=2
> numa_emulation.default_dram=1,0
> numa_emulation.read_latency=100,1000
> numa_emulation.write_latency=100,1000
> numa_emulation.read_bandwidth=100000,10000
> numa_emulation.write_bandwidth=100000,10000
> 

Thanks for the report. Can you try to repro this with traditional LRU
i.e. not MGLRU? I just want to see if this is MGLRU only issue or more
general.

