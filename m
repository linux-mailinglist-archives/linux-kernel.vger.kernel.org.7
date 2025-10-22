Return-Path: <linux-kernel+bounces-864746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07762BFB74B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1551505932
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A6325489;
	Wed, 22 Oct 2025 10:50:01 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF028DB54
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761130201; cv=none; b=qxwH0lwUglFtSBR6KK6kGxUuVvYGj8Ajb43fwCzJd3OEeiYnTQW4E1fEl36h53dzb/Pm9il4688A9xjPkTwOSyFC+pEh9bKrnzD8+/6dKHcXdFOU30zrVGsFz4TVEOTGI+9tZXPlH42GXZT6Iqz0RjvnZDM6fyvYS9Ij78bR5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761130201; c=relaxed/simple;
	bh=hQk7+BgO69kSZcptLFnOOSr+/Nv7+xol9ciKyci4pW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDuovHT0ZnASltEEZcvnKnJcEXg5x1fgx4miELrfo24nAtdz3uXngz+7j5w95pQ9ZA1nxXgk0qRkZcLjHqewO6zi35tgojwWQ3MTEStFvzK3o1yKwiMIJmfGQfvGjqzfjqHY1l8B86ZkR/m5pPB1Gj2U0auEVdZ0WteVCesZsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cs5WR6bZtzKHMZq;
	Wed, 22 Oct 2025 18:49:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ADA951A1A74;
	Wed, 22 Oct 2025 18:49:55 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgAHT+PStvhowhLNBA--.19816S2;
	Wed, 22 Oct 2025 18:49:55 +0800 (CST)
Message-ID: <7aeb1198-4c44-4395-9e09-971e0c8b6ef3@huaweicloud.com>
Date: Wed, 22 Oct 2025 18:49:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 14/16] cpuset: fix isolcpus stay in root when
 isolated partition changes to root
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-15-chenridong@huaweicloud.com>
 <a07b794c-d133-4d23-b0b0-cb9e0dc42d2b@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <a07b794c-d133-4d23-b0b0-cb9e0dc42d2b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHT+PStvhowhLNBA--.19816S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF4kCFWUCw1rtw47trW5ZFb_yoW8JFy7pF
	90ka4Utws8Crn5C3yjqF1Ivw4rtFsrJ3ZrJrs8WFyfXw4DWFyvkFWjk3y5Ga45X395Wryj
	vFy7ur93WFnrAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/20 11:06, Waiman Long wrote:
> On 9/28/25 3:13 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A bug was detected with the following steps:
>>
>>    # cd /sys/fs/cgroup/
>>    # mkdir test
>>    # echo 9 > test/cpuset.cpus
>>    # echo isolated > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus.partition
>>    isolated
>>    # cat test/cpuset.cpus
>>    9
>>    # echo root > test/cpuset.cpus.partition
>>    # cat test/cpuset.cpus
>>    9
>>    # cat test/cpuset.cpus.partition
>>    root
>>
>> CPU 9 was initially placed in an isolated partition. When the partition
>> type is changed from isolated to root, CPU 9 remains in what becomes a
>> valid root partition. This violates the rule that isolcpus can only be
>> assigned to isolated partitions.
> 
> I am a bit confused at the beginning about this as it does not clearly state that CPU 9 was listed
> in the "isolcpus" boot command line parameter, but I believe this is what you mean here. Yes, there
> is a restriction that a boot time isolcpus CPU cannot be put into a non-isolated partition, though
> that will likely to be relaxed in the near future.
> 

Hi Longman,

Just to confirm, does this restriction also apply to remote partitions?

-- 
Best regards,
Ridong


