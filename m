Return-Path: <linux-kernel+bounces-875071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A549C1825B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F42F1C65CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3892ED858;
	Wed, 29 Oct 2025 03:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSH9NQ1Y"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F082EA157
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707615; cv=none; b=bVO7roVj2/MvQ+HqVGeJ/+jz7fgF4sup0CWppaoOj1iBrNAdubhx8BcPF3J0jXBwrhVYCEe6A3A4/tTGB2ZckbxaAxS2DUOpjcjsJPyw3L5tQwREr5hYTAj8lR2Bp8zmj5Og6f0rBe8IHq9gl4EhPKo4iDBQpzRy+v+MqeWKjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707615; c=relaxed/simple;
	bh=k54eydI27xAJhGpftKo2XfSaIgD0swUdm+m4j/J+kfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=XaK9LfoMbA2j5+hgvcXvWbeKiQPi30A6/6NmudKtLHkd9UPeZyRdo17pjbQ4EckQeJ85llQneQMVAZ2UKu82k2OnzvI3MHOpe5rrKvH1jZlNEnqpSjgTl81KQYl8ZEfe190Kxqrm2G9OG1sz1OAj6tdxnOVNxL9GELD28xDmmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSH9NQ1Y; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a28226dd13so5436229b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761707613; x=1762312413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAHShkoqXEH7y+tSIgzST7Tr6+153mEpoQhsPPxfgWs=;
        b=JSH9NQ1YQ69yv1IgNlOSFkTOqeisR9jXk4OZBLKH3H1w7FyIYgbhJaWXOnEeHwssoj
         8VoNLAOPEZADnBJzx6R4C0STgXFQSr7xqda3iNr2IDh6OI3d8lQnEbev+tuE8bYKdiFA
         +wZeAywwpEUFeDcBXHWMPz+RF/kVJ9iAaKfdC6Wha/OcP5GGaq9vwCLiF27dQrT3D5wL
         TBNDvGjh2tCUjjdz76jYQRVdZjsPyYLxPAbhVDuW9s1/J2aUwRwpWHhDDPiVrwL0vn4u
         VusR67myZbYi93C3l/7WBtbWHxShQoI2ydh/x0tUbfKipwLQnvi+U7YD+TME3p9N4Iyt
         2qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761707613; x=1762312413;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAHShkoqXEH7y+tSIgzST7Tr6+153mEpoQhsPPxfgWs=;
        b=EqYv6NTpkte6MKbAKCxLwEtxvS1Stm0ux8FSEc557thrmhL3ED6deBfYcfryvgIxU3
         g1ErU4wJ0Rip9WMbDP/97dDxZiP7SUwto8rWH1YFNUNUlM05FXRUox6QK4V/0WpfGsfp
         zgNlUQKt+zm0R7gArth/uIAYS6T3jFa8p1vGkJpigA7Q9YTZnpE/qY8VMUBvNDymFWRd
         PepMV/Ro0HzWugonvH4myVfaGGtqATE7+xP1fjBJ1Sb6wuLIN+n597MrsvX+XVeD52Te
         +xFc1TNj9/CS/SI8VohlY7oKAx61BkZg8+Ud7vDgvRB/3BVwWNM/7q0pC9RGFpkjYat0
         NhYg==
X-Forwarded-Encrypted: i=1; AJvYcCVW+S8g+rKXvj8gCbGpaWoc8ZzZkwtuzreUu73/3bMkNOV7s1TCw4zKlQ6yKJ/U7ghy4v31GXRIze3P6qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoYAZCskitxQHai0ewhetlipeH7Rzx6XgxOLpXs+y4svRP6yh
	EqhY4epuCe2spbGbc/lG27FO7vG+scz3QeNb3+EJUbHs6ieUln+szYus
X-Gm-Gg: ASbGncvcOhz3gL3AI4nEp2RIOptfVUBs7qeH4CHlQG06wYPW71IQcRv2psmvNfuTLvp
	pVC/V3FaBK7yjtq821fqu7Tn/TCsw0eNOwyvmwkdX3t0NDKAGqrmMgao4vXuytggENlexWcuiog
	JhN99lZ4n7BfRoecfy312AD+oU7ywXxixIziyij/Zzk4DBAHZTVFS6NhHZ6M5YFDhR5wAXtzhoc
	3AtIx5VBORbSO6bcVoq9iVUwjweyHiRb1vEaarZRi4578BloFaHXWR1/BLWYCDy7Qn/MCXBAJ3r
	5y4M9T0LrzFDOJ7cLNPnlfu1zJ/m4c3gcpKcE3V/zM6hh4zvj61xS31Brs0c2ntdhij+3SFfTjT
	Gzu0My9L1F/HuwMeSaH6jKGxQbxI4i0+x43gM2F07AcXXmv0fjHrKABKgXHtSBJA7sze/wpQKpE
	+wISeMQAkOU4qbTVkPdTQ=
X-Google-Smtp-Source: AGHT+IGWiLR+9A+Wv9Xl8a2OKQ1ySYkVUBBFO2aK+0Osm/SMDZfRYSD20pDJN/39LOlHRqF2MjFjrA==
X-Received: by 2002:a05:6a00:813:b0:7a2:7964:64c0 with SMTP id d2e1a72fcca58-7a4e2dfb724mr1916402b3a.12.1761707612983;
        Tue, 28 Oct 2025 20:13:32 -0700 (PDT)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm13385745b3a.64.2025.10.28.20.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 20:13:32 -0700 (PDT)
Message-ID: <7040b501-6e25-42da-bda0-a15614a80d5d@gmail.com>
Date: Wed, 29 Oct 2025 11:13:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: add fadvise tracepoint
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20251028195444.3181203-1-jaegeuk@kernel.org>
 <81602674-b9f4-4ab2-91f5-0afc762e7cc6@kernel.org>
Content-Language: en-US
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <81602674-b9f4-4ab2-91f5-0afc762e7cc6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 10:06, Chao Yu via Linux-f2fs-devel wrote:
> On 10/29/25 03:54, Jaegeuk Kim via Linux-f2fs-devel wrote:
>> This adds a tracepoint in the fadvise call path.
>>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/file.c              |  2 ++
>>   include/trace/events/f2fs.h | 32 ++++++++++++++++++++++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 6d42e2d28861..4a81089c5df3 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -5288,6 +5288,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
>>   	struct inode *inode = file_inode(filp);
>>   	int err;
>>   
>> +	trace_f2fs_fadvise(inode, offset, len, advice);
>> +
>>   	if (advice == POSIX_FADV_SEQUENTIAL) {
>>   		if (S_ISFIFO(inode->i_mode))
>>   			return -ESPIPE;
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>> index edbbd869078f..b7f5317b5980 100644
>> --- a/include/trace/events/f2fs.h
>> +++ b/include/trace/events/f2fs.h
>> @@ -586,6 +586,38 @@ TRACE_EVENT(f2fs_file_write_iter,
>>   		__entry->ret)
>>   );
>>   
>> +TRACE_EVENT(f2fs_fadvise,
>> +
>> +	TP_PROTO(struct inode *inode, loff_t offset, loff_t len, int advice),
>> +
>> +	TP_ARGS(inode, offset, len, advice),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(dev_t,	dev)
>> +		__field(ino_t,	ino)
>> +		__field(loff_t, size)
>> +		__field(loff_t,	offset)
>> +		__field(loff_t,	len)
>> +		__field(int,	advice)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->dev	= inode->i_sb->s_dev;
>> +		__entry->ino	= inode->i_ino;
>> +		__entry->size	= inode->i_size;
> 
> __entry->size = i_size_read(inode)?
> 
> Thanks,
> 
The other "__entry->size = inode->i_size;" in 
include/trace/events/f2fs.h also need to be updated?

>> +		__entry->offset	= offset;
>> +		__entry->len	= len;
>> +		__entry->advice	= advice;
>> +	),
>> +
>> +	TP_printk("dev = (%d,%d), ino = %lu, i_size = %lld offset:%llu, len:%llu, advise:%d",
>> +		show_dev_ino(__entry),
>> +		(unsigned long long)__entry->size,
>> +		__entry->offset,
>> +		__entry->len,
>> +		__entry->advice)
>> +);
>> +
>>   TRACE_EVENT(f2fs_map_blocks,
>>   	TP_PROTO(struct inode *inode, struct f2fs_map_blocks *map, int flag,
>>   		 int ret),
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


