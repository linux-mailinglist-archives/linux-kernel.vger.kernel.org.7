Return-Path: <linux-kernel+bounces-800029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A715B4329E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A53582031
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98627780E;
	Thu,  4 Sep 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d3SOZNcQ"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A82765CE;
	Thu,  4 Sep 2025 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967949; cv=none; b=THNQb1udhf37zpx5fDMMuitXB6xHWptYDeXXYZx1TQkm//tSfFtTcrdCaq+ffYUBBJwM4P5HDxZMR6oLv7F2yU/YUlu+fubN46frQq7qabLzmBYdWNsuQkhlaB8zYChdmZtdythso7hHMUvixZFTrVnZf3Cm2qTDHlmuSq63qmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967949; c=relaxed/simple;
	bh=qbYxlHDIZRbl9FyrXPxEzRARPEfVcOfA8LVbekz9FoM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OQ0TfHl/VaUkGYeF5StOr7AMQbd7gB8D+huyFkkjvEqoB1nfzz7EoeMADciDH3FBXXkXbaf8agGQ1JoZ+fJUGTqsNz+tEzxR9w5+aqSwU65svMEYOqe7q45+OicyHn2fFmUcg+m2/V89WQJUiGtTR8H7NpQQplyZnDE6QirYPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d3SOZNcQ; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756967938; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=JQIERyQlFErgYTQwmL0my1n3wai5TKb2ziBU+88+mqM=;
	b=d3SOZNcQ2cmpAIXsjwH5UEQ1LjEcc5rmoKkPPQhDxoEgYiT3xDjtxh26kelyZs+YJIkY4qZwgtkwLY58xQApC5hR58yn5jRq9Q4FjZ3sEc4mhH1BB9gsvys4yWSARURE5aBaXKj5haV8cQzCAgi6XoU658XmlFEhug727+4mQGg=
Received: from 30.221.148.63(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnEjMOe_1756967937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:38:57 +0800
Message-ID: <28004f86-72a4-44eb-aa0a-0c9c0a1d6671@linux.alibaba.com>
Date: Thu, 4 Sep 2025 14:38:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
From: escape <escape@linux.alibaba.com>
To: Tejun Heo <tj@kernel.org>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <aLhykIPSGV1k_OG0@slm.duckdns.org>
 <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>
In-Reply-To: <cfe595a7-c20d-4891-aba1-35546c488024@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/4 11:15, escape 写道:
>
> 在 2025/9/4 00:53, Tejun Heo 写道:
>> Hello,
>>
>> On Wed, Sep 03, 2025 at 07:11:07PM +0800, Yi Tao wrote:
>>> As computer hardware advances, modern systems are typically equipped
>>> with many CPU cores and large amounts of memory, enabling the 
>>> deployment
>>> of numerous applications. On such systems, container creation and
>>> deletion become frequent operations, making cgroup process migration no
>>> longer a cold path. This leads to noticeable contention with common
>>> process operations such as fork, exec, and exit.
>> If you use CLONE_INTO_CGROUP, cgroup migration doesn't just become 
>> cold. It
>> disappears completely and CLONE_INTO_CGROUP doesn't need any global 
>> locks
>> from cgroup side. Are there reasons why you can't use CLONE_INTO_CGROUP?
>>
>> Thanks.
>>
> As Ridong pointed out, in the current code, using CLONE_INTO_CGROUP
> still requires holding the threadgroup_rwsem, so contention with fork
> operations persists.
Sorry, my understanding here was wrong; using CLONE_INTO_CGROUP can
indeed avoid the race condition with fork, but the restrictions do exist.

Thanks.
>
> CLONE_INTO_CGROUP helps alleviate the contention between cgroup creation
> and deletion, but its usage comes with significant limitations:
>
> 1. CLONE_INTO_CGROUP is only available in cgroup v2. Although cgroup v2
> adoption is gradually increasing, many applications have not yet been
> adapted to cgroup v2, and phasing out cgroup v1 will be a long and
> gradual process.
>
>
> 2. CLONE_INTO_CGROUP requires specifying the cgroup file descriptor at 
> the
> time of process fork, effectively restricting cgroup migration to the
> fork stage. This differs significantly from the typical cgroup attach
> workflow. For example, in Kubernetes, systemd is the recommended cgroup
> driver; kubelet communicates with systemd via D-Bus, and systemd
> performs the actual cgroup attachment. In this case, the process being
> attached typically does not have systemd as its parent. Using
> CLONE_INTO_CGROUP in such a scenario is impractical and would require
> coordinated changes to both systemd and kubelet.
>
> Thanks.
>


