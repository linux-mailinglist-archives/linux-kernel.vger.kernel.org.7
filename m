Return-Path: <linux-kernel+bounces-780895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6504DB30AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318471D03ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4E81732;
	Fri, 22 Aug 2025 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ozOqVEiT"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904218E25
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825425; cv=none; b=jbLmY8Q+A8VU0MzrztJzYyp87fBaJW6NJ3hno3gpqm0y3T+DM9T0OpI0+0Vhu9Erg5jwszGmSLSLMgkAXiOBfUSzi5QyWZll8FQjzl9TFVvjG6Xxfd1UJLcLDqJxg4J/vrmutznxBaro6k6N2o9gLmiOHUU0xUeIbWx/VPXtsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825425; c=relaxed/simple;
	bh=SfV+p84JVNPD1kBUsca0CAxIdKOLvTjY2vLh6qCIM1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oeRgx9AZcU1UVKsILnvacIxiMLpDLZLxx3fhI1AO0N1D/hJlro5+KYQ3HZZtk7CS/BWi4etgDyuNig79hxq77Ele1sgh+sx7MQmSb0iuJzGdIvNfnz5vr3hrxPUz6W3GS9dptROxGx03WnyhBWsnFM7Kft7qoDcJKiF1TONqX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ozOqVEiT; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755825420; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F7oXX82YA0b95vCVWI2wQro+RqhMwruSCrGLcuvIj7c=;
	b=ozOqVEiT1x7mCpGxOJrctSWVMVK47utfxrYLoysNHnKJ+1+stkr+VomCWQmQhZ0/BO17pFV6CR1BZFGIf/Xr0IfE7tToSoqZ757Csa9rTtBZyiPBjHYGsQRZ5bWAd8p7FvTtyiRWQDa4WWpeg5IK8eCRne1R4qAX5EUbM7gyRc8=
Received: from 30.221.144.123(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WmHmU87_1755825418 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Aug 2025 09:16:59 +0800
Message-ID: <e7adfc92-6c0d-4fc6-8e73-5c1acd61753c@linux.alibaba.com>
Date: Fri, 22 Aug 2025 09:16:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix super block reserved field offset comment
To: yili <yili@winhong.com>, akpm <akpm@linux-foundation.org>
References: <20250807155749.164481-1-yili@winhong.com>
 <aJT9RpG19PWIcLe-@google.com>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 "ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <aJT9RpG19PWIcLe-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/8/8 03:23, Joel Becker wrote:
> Yep.  And 140 - (sizeof(s_reserved2) aka 8 * F) = C8.
> 
> Reviewed-by: Joel Becker <jlbec@evilplan.org>
> 

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> On Thu, Aug 07, 2025 at 11:57:49PM +0800, yili wrote:
>> The offset annotation for s_reserved2 in struct ocfs2_super_block
>> was incorrect. After the preceding fields:
>> - s_xattr_inline_size (2 bytes at 0xB8)
>> - s_reserved0 (2 bytes at 0xBA)
>> - s_dx_seed[3] (12 bytes at 0xBC)
>>
>> The actual offset of s_reserved2 is at 0xC8,
>> when calculating from the start of the structure.
>>
>> Correct the offset comment from C0 to C8 to reflect the proper
>> location in the super block structure.
>>
>> Signed-off-by: yili <yili@winhong.com>
>> ---
>>  fs/ocfs2/ocfs2_fs.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
>> index e8e94599e907..ae0e44e5f2ad 100644
>> --- a/fs/ocfs2/ocfs2_fs.h
>> +++ b/fs/ocfs2/ocfs2_fs.h
>> @@ -614,7 +614,7 @@ struct ocfs2_super_block {
>>  	__le16 s_reserved0;
>>  	__le32 s_dx_seed[3];		/* seed[0-2] for dx dir hash.
>>  					 * s_uuid_hash serves as seed[3]. */
>> -/*C0*/  __le64 s_reserved2[15];		/* Fill out superblock */
>> +/*C8*/  __le64 s_reserved2[15];		/* Fill out superblock */
>>  /*140*/
>>  
>>  	/*
>> -- 
>> 2.43.0
>>
> 


