Return-Path: <linux-kernel+bounces-892566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F189C455DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF0FD346EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F36C2F83AC;
	Mon, 10 Nov 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haak.id.au header.i=@haak.id.au header.b="fOw69M0z"
Received: from mail.haak.id.au (mail.haak.id.au [172.105.183.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C749E2F692A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.183.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763094; cv=none; b=Q5mb1vbGHrfUp+WjRp0X1u22Sh4qPTaZZGxBDdBNfcsbcW9smIQfbl9YeuaLxDfjPALclY4th0BR0lC4qSAbGdoPCpgj9hOYB0bEuexkZn2b2BrXqmN+CUi47Y/3LFhCaQHI4cVhwf72+7sjmHjjBwKSgZuytFd6xscbOEJlfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763094; c=relaxed/simple;
	bh=NpCmVUJwh/xKBdJAggdydPdh5BDCLpa3XMmphcI6tEg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=fwzV3vR0LLJnFW3USYdhF14Ih5U7My7/3cbmIjN9tq4UP5cGLHvlrHUZZAkGG+xgW2lXziro3Pxq5cCwAMT3uFscMVBoFnaWS6Ec5iubvbolyukVd9k/HYRM9w0vUxt+q3DNYNkYvZgGthwGIOt1QHc5GipS+JCBCuCkC2b3dIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=haak.id.au; spf=pass smtp.mailfrom=haak.id.au; dkim=pass (2048-bit key) header.d=haak.id.au header.i=@haak.id.au header.b=fOw69M0z; arc=none smtp.client-ip=172.105.183.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=haak.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haak.id.au
Received: from xps15mal (180-150-104-78.b49668.bne.static.aussiebb.net [180.150.104.78])
	by mail.haak.id.au (Postfix) with ESMTPSA id BABED83228
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 18:20:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=haak.id.au; s=202002;
	t=1762762812; bh=NpCmVUJwh/xKBdJAggdydPdh5BDCLpa3XMmphcI6tEg=;
	h=Date:From:To:Subject:From;
	b=fOw69M0zj0f54Kl3BwhUPFpoGTD8SleejLRWVlMLC7RxSQvGPGd9d87C1xoEeoJl8
	 Qt75C1jjF5mqFR0vJc2UlWE/G2R2zDDAa/D2NwC32UHPRKrn7p4Kxc6rAZS/tsXQWA
	 rASJ9hChF227FRiZv59sFg2yajypVMXfgCugoVzl0h9Mn/2JPphBSQ/6JNCF75LbeY
	 r3FfZi9wC/4EBXRq8r3l2ohqWQXCCk4fbxAy+4KCiBAeQ8v0zMsaLAN7YFbBhBHJi8
	 jjiNzF5BpETW00jqMw+h+b7vIhDwZUAODOMG8YTaCj6MQAJfvKduyGy4s+o6NYyXz0
	 3oLooyDjrM0+A==
Date: Mon, 10 Nov 2025 18:20:08 +1000
From: Mal Haak <malcolm@haak.id.au>
To: linux-kernel@vger.kernel.org
Subject: Possible memory leak in 6.17.7
Message-ID: <20251110182008.71e0858b@xps15mal>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

I have found a memory leak in 6.17.7 but I am unsure how to track it
down effectively.

I am running a server that has a heavy read/write workload to a cephfs
file system. It is a VM. 

Over time it appears that the non-cache useage of kernel dynamic memory
increases. The kernel seems to think the pages are reclaimable however
nothing appears to trigger the reclaim. This leads to workloads getting
killed via oomkiller. 

smem -wp output:

Area                           Used      Cache   Noncache 
firmware/hardware             0.00%      0.00%      0.00% 
kernel image                  0.00%      0.00%      0.00% 
kernel dynamic memory        88.21%     36.25%     51.96% 
userspace memory              9.49%      0.15%      9.34% 
free memory                   2.30%      2.30%      0.00% 

free -h output:

       total  used   free   shared  buff/cache available 
Mem:   31Gi   3.6Gi  500Mi  4.0Mi   11Gi      27Gi 
Swap:  4.0Gi  179Mi  3.8Gi

Reverting to the previous LTS fixes the issue

smem -wp output:
Area                           Used      Cache   Noncache 
firmware/hardware             0.00%      0.00%      0.00% 
kernel image                  0.00%      0.00%      0.00% 
kernel dynamic memory        80.22%     79.32%      0.90% 
userspace memory             10.48%      0.20%     10.28% 
free memory                   9.30%      9.30%      0.00% 

I am unsure of the best way to track down the memory usage. I have
tried stopping the workload and unmounting the cephfs filesystem. As
well as removing the ceph and network related kernel modules. 

I assume some kind of tracing would be a way to find the culprit,
however I am unsure of the best way to do that. 

I can do a git bisect and am in the process of getting a test
reproducer made for that. 

But if there is an easier way to do it I would happily do that.

Just to note, slabtop looks normal and doesn't show the memory usage.

Thanks in advance

Mal

