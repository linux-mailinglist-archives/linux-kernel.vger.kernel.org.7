Return-Path: <linux-kernel+bounces-828134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D55DB94036
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 495267A5E69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A562580ED;
	Tue, 23 Sep 2025 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PEZU7qNf"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5013AD26
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594879; cv=none; b=n4UvTwTMRpimwG6AW/Xkan9LYri1BaEHdHONRgLPR3vyf+tkR0w97c19m2YiZfOiQ7/hPsfbOC/0mps08jdsBRASGVR4FFzmQq+J5OIIseq8BflTGk7rq7daWagdDpCbr/i4EugWHZ5yyjheoHJuJyHBhp4ZCGgSvDKADNJdcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594879; c=relaxed/simple;
	bh=nGLUipD3e5MJ7wFsldImeqMLJtm++FI/sKHGotYCg9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmeAUeyRJOQQKKyGUjV9oIu4Y5rAvEUwdpIkwz+js+btZHc/wgqoqHCzQ2O6B2G4YYgMrLx/EWzss29EFE1gtAgRd8dgd96LD889zliSC2TPtl6+IQ5UZd8Fl8/SFs0wnw5qa8hIXqrrFb90/m0iS60GPM+Nxud9YsUAsCwIZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PEZU7qNf; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758594866; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DvgLv2W5sn5O7MiD/dFRPsjAH496hntEQ0i1HALiM5Q=;
	b=PEZU7qNfJnqi59FbGOKHkTaYLEGz59SmjbfgvaEOs+ppRmlvv9RITBXBtMYyvsVtf0WrqSPW95sENex7vmj4b8NOT2NHc2jUWTlBup59DUEdTnjzCW4OQzR5DKZ5haX/opRgf/lewpjzwodlPbuEHZk9sQbB8Ktn1ae4yoo9XZY=
Received: from 30.221.131.45(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wod5Xby_1758594865 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 10:34:26 +0800
Message-ID: <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Date: Tue, 23 Sep 2025 10:34:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Chao Yu <chao@kernel.org>, Bo Liu <liubo03@inspur.com>, xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chao,

On 2025/9/23 10:23, Chao Yu wrote:
> On 9/22/25 17:29, Bo Liu wrote:
>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>
>> Add support for reading to the erofs volume label from the
>> FS_IOC_GETFSLABEL ioctls.
>>
>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>> ---

...

>>   
>> +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
> 
> #ifdef CONFIG_COMPAT
> 
>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>> +			unsigned long arg);

Since it's a function declaration, when CONFIG_COMPAT is not defined,
there is no user to use erofs_compat_ioctl(), so I think it is fine
to just leave the declaration here?

Thanks,
Gao Xiang

> 
> #endif
> 
> Thanks,
> 
>> +
> 


