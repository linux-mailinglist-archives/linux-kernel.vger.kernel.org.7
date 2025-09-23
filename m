Return-Path: <linux-kernel+bounces-828146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 921A9B940DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5398D44778D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 02:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5C2749E5;
	Tue, 23 Sep 2025 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9BCBNkb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C165184
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596393; cv=none; b=XYOMbod2waH1v5RW+dE9cCMeb2EE0rj9z1hYLj6xw03RWNlqejS9EizSgUeoeTxWIhErA49sz5Lh+j82tTdqxPcTR8dYrB2dSWROckD0DqB0diUfRt1RNWHvb8cOKyjCkcMIW3SqnGkOVUZr8ayMuPaAK1ZpMNztU1ZJrfOekkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596393; c=relaxed/simple;
	bh=5CC23e1eVoOYG4acE9P3u8bvarC+BnDsfHv4kMfuvj0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d0kG6vSkCfHW8SZU78ZXDu753E3nqYOaWMiUb2fadx5+krdY62hS3wq3C07UZqq/F5XqPqxAY0mrlVB9fs2SQKdtbCFTYXedaqIAaNpGOnFjP7RG0UaXqqujZXtA83jogmtQTwNUgJqsIkKwEKu2Gj2c70tcHiZ/L/8ZuMOUfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9BCBNkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAA2C4CEF0;
	Tue, 23 Sep 2025 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758596392;
	bh=5CC23e1eVoOYG4acE9P3u8bvarC+BnDsfHv4kMfuvj0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=X9BCBNkbX5gnUO8k6mfJ01tcVw2omOQY/OqLiOSVdby+qfmtAwtR5nDTT6Fqp9Jee
	 a1ZXdDdgub8dD8JkSnkbbTKL0y5CD7O9Pyu8Ex+KDATE36flwchCjmWBWCSTzWQraw
	 4ygiOFKwB0EeRV8hkGnt1dnP8PndKProY41EUISTm9XCBTIql23z8tVeZ8aWMRWWap
	 qsmbXPwbeyoKdzt3qOb4bk4SKKESKU54CrKS4G/jYcZw1NJEDXhzcg/D5khwXXruL6
	 Nbfv8kbhAPb1t9Hewr/pxrG+iEZXQlF/jceziWWTtM48YnoVDMJtCWIywBo84dwUjK
	 quX6yi6dKdXMQ==
Message-ID: <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
Date: Tue, 23 Sep 2025 10:59:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Bo Liu <liubo03@inspur.com>,
 xiang@kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
 <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/23/25 10:34, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/9/23 10:23, Chao Yu wrote:
>> On 9/22/25 17:29, Bo Liu wrote:
>>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>
>>> Add support for reading to the erofs volume label from the
>>> FS_IOC_GETFSLABEL ioctls.
>>>
>>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>> ---
> 
> ...
> 
>>>   +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>>
>> #ifdef CONFIG_COMPAT
>>
>>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>> +            unsigned long arg);
> 
> Since it's a function declaration, when CONFIG_COMPAT is not defined,
> there is no user to use erofs_compat_ioctl(), so I think it is fine
> to just leave the declaration here?

Xiang,

Sure, it won't affect compile and link, we can leave it as it is since it's trivial.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> #endif
>>
>> Thanks,
>>
>>> +
>>
> 
> 


