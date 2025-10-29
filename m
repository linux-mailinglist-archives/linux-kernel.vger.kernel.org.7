Return-Path: <linux-kernel+bounces-875841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B87C19F11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CF244EEB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE9329C71;
	Wed, 29 Oct 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHrJIBH2"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6D323403
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736371; cv=none; b=BLn8AzbsOhcxLf+5Mx9Tfm1+wAH2xRdnRQlIHg9gUWybo6D1MRoHQJ1knnJsdIAUqmexIz5FIAr2VPPNIMvHXeRmE5859t+TTV1PwOdlqRuH9n18euff0em3DkXtHD427jZ5yXuJLEv1cSirNbVFQ917il7Q1GOC5QQRDwrJQgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736371; c=relaxed/simple;
	bh=721YmFXAY0dw+rZspFz7B6Nj7Y3ihKZPCK3BuZ55Bjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dsrp8xvYHyuXEc6HbQG/Tr+txYsdmZ/YoBF407mNZNYOUSh4jprdKgoMDDVm1QK/HfBOaxLyEkHTIEzyN0WlVRpPRtAAZd0F8acbmy6VVP++/OeNcDY89V+GQDF3V9JVBE/I8XwATGXcJkrq7KJW3ZoWGZRowa84seM2owSaWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHrJIBH2; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso6786476b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761736370; x=1762341170; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdFyWGvrYqTxjbl/9/mWe9P/vQnBsoX8sYUwKCEs1VE=;
        b=AHrJIBH24OSCEi0Qds4iOmoQBSpXME5I9bAXpTOS15wjplwwFZjSQF7Fhl6G1GT38F
         szX6H2pR0jT9sIojA88FE63zL+pUIRkT1nGmp2tm38R6s4wW5QqyCHdzIZ3t9863fAO7
         UvT2XztkV/dUx7dNOYZK0IPdMbP2KBbky4Cb08oDwRfJh6T//rkiAf0cQey/Hx6yfVjF
         sH2NnYlgre00NzpxbFtnoRbzAuTCVMwwz3hIxsqGF3x7LWWBGJKB4rsM4aeNdjKrimua
         o6ZTvk6EvdPPKJOEwwakDvrcCHoj/jqYzscQaF8t8fS3aVx8b18//BJnbieU0dpX9Qr2
         834w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736370; x=1762341170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdFyWGvrYqTxjbl/9/mWe9P/vQnBsoX8sYUwKCEs1VE=;
        b=nD4Patl9VfFlDWRr1k9peg3GXQpD6Rh9+ZNYupLOGs7UbVrXZD+GkAS/IPnKVwADeJ
         81n4owhZdFS4I0rK9KbtjyXoDHSH3cOSXXjY7hcwW2vtUhrVboRovKCzyZRP9oOjMbCw
         9W+b90nfUVF1Wfi+FeDmg99cVUQRQ6eSx5F0Inhk0Bzc+M8fSMEjk2tPfjY4fpgNt/mU
         En5vjy9liVgnKpySx9p8ZN8q7HiRsFV9108y9ULb83H1Xdl3yIYenU3QE1Z/tkEAyT36
         2G1aZTXYe9ahlhkbSD05hJDrx8idhyBPqr7lvBFYY96V1jmKbFyzwS9OEyDzEfqa4Dj5
         V+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2PYV3WxURYp6lRrocNTbOXmSvGrTE/PcDWJV3dEgORQLSfi6is1/A0GZnPGHk+hpFO6rAgZYHma4K4SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwmLZQrilV6yyDGVQeCZyxYymXU8KMdgnOjZWhmkjNJjgKpiL
	BOmqXoAbTuR1gQiWyfqtN3R9sk74QvrYrP3bdkNWrkq/vN5g+3M5r8gq
X-Gm-Gg: ASbGncu9SvLVk8WBqsldBqIvqq6RwwDUo0wpJBiyh83n8OFKrQeVh2xc4Bwf6IDzVhk
	kHYmdLsMxPnzhSJonVudR9Y6xMdSHBTrlp5cH4iefZPxOZBtx9UCpm+nZ1K6GqMuXbwU1ZWZULg
	NVRgrytgUuC+a++f/5LtgGwlCTp2k1b1vwZSTSja/r+2weGz2bkYfreI+7iLwDMhQsDgXW8AvYW
	cptd0oIsOGXGBxBTUMZj30gvBf1t7KxHPsjDkXFSCoaddJ2aHZsBD/FHVAwdt59AUFvAuKcvxKM
	n6eUtWhmiYPbb6yG7ga4UuslZntNaJdfzpGlR04DN4OkYOU34LMhi/lFDsQcNQSlU2K2PFgRWpe
	m2Q7kcPv/JZBy9tBWyeMjZdEKkDcwdFdENLmZI2EROdeKAbaGkI7Sdys+p1+Gk8FFTg2/CSaQx0
	W9yF1D6YBTuT6bEkGQNxw=
X-Google-Smtp-Source: AGHT+IHolxYsPnjwh2qMlzrF/pN2XBKKI+4E4Rin3SC46lB+fLWUqAlzJo0u96HwFxYd2o30n+wt5g==
X-Received: by 2002:a05:6a00:855:b0:7a2:7df5:5bb5 with SMTP id d2e1a72fcca58-7a4e2ef25ffmr3515080b3a.12.1761736369386;
        Wed, 29 Oct 2025 04:12:49 -0700 (PDT)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012b19sm14750001b3a.12.2025.10.29.04.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 04:12:49 -0700 (PDT)
Message-ID: <130dbea7-01fc-44dd-927e-197badf57450@gmail.com>
Date: Wed, 29 Oct 2025 19:12:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to access i_size w/ i_size_read()
To: Chao Yu <chao@kernel.org>, Yongpeng Yang
 <yangyongpeng.storage@gmail.com>, jaegeuk@kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20251029063105.989253-1-chao@kernel.org>
 <f9cf5992-0357-4702-be73-881c9997929d@gmail.com>
 <45823945-2ea3-4ec6-9b07-686814f38567@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <45823945-2ea3-4ec6-9b07-686814f38567@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/25 17:41, Chao Yu via Linux-f2fs-devel wrote:
> On 10/29/25 16:09, Yongpeng Yang wrote:
>> On 10/29/25 14:31, Chao Yu via Linux-f2fs-devel wrote:
>>> It recommends to use i_size_{read,write}() to access and update i_size,
>>> otherwise, we may get wrong tearing value due to high 32-bits value
>>> and low 32-bits value of i_size field are not updated atomically in
>>> 32-bits archicture machine.
>>>
>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>> ---
>>>    include/trace/events/f2fs.h | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>>> index edbbd869078f..e1fae78d64a5 100644
>>> --- a/include/trace/events/f2fs.h
>>> +++ b/include/trace/events/f2fs.h
>>> @@ -204,7 +204,7 @@ DECLARE_EVENT_CLASS(f2fs__inode,
>>>            __entry->pino    = F2FS_I(inode)->i_pino;
>>>            __entry->mode    = inode->i_mode;
>>>            __entry->nlink    = inode->i_nlink;
>>> -        __entry->size    = inode->i_size;
>>> +        __entry->size    = i_size_read(inode);
>>>            __entry->blocks    = inode->i_blocks;
>>>            __entry->advise    = F2FS_I(inode)->i_advise;
>>>        ),
>>> @@ -353,7 +353,7 @@ TRACE_EVENT(f2fs_unlink_enter,
>>>        TP_fast_assign(
>>>            __entry->dev    = dir->i_sb->s_dev;
>>>            __entry->ino    = dir->i_ino;
>>> -        __entry->size    = dir->i_size;
>>> +        __entry->size    = i_size_read(dir);
>>>            __entry->blocks    = dir->i_blocks;
>>>            __assign_str(name);
>>>        ),
>>> @@ -433,7 +433,7 @@ DECLARE_EVENT_CLASS(f2fs__truncate_op,
>>>        TP_fast_assign(
>>>            __entry->dev    = inode->i_sb->s_dev;
>>>            __entry->ino    = inode->i_ino;
>>> -        __entry->size    = inode->i_size;
>>> +        __entry->size    = i_size_read(inode);
>>>            __entry->blocks    = inode->i_blocks;
>>>            __entry->from    = from;
>>>        ),
>>> @@ -1006,7 +1006,7 @@ TRACE_EVENT(f2fs_fallocate,
>>>            __entry->mode    = mode;
>>>            __entry->offset    = offset;
>>>            __entry->len    = len;
>>> -        __entry->size    = inode->i_size;
>>> +        __entry->size    = i_size_read(inode);
>>>            __entry->blocks = inode->i_blocks;
>>>            __entry->ret    = ret;
>>>        ),
>>
>> inode->i_size usage in fs/f2fs/ also needs to be updated. For example in f2fs_need_verity(), which may not protected by inode_lock.
> 
> Accessing i_size directly in f2fs_need_verity() should be fine? Because fsverity
> actived inode should be readonly.

Yes, it's fine.>
> Do you see any other cases which are not covered by inode_lock()?

I checked again, no other cases.:)>
> Thanks,
> 
>>
>> Yongpeng,
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


