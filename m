Return-Path: <linux-kernel+bounces-849046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B33BCF12D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 09:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F525407B3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E6F20B21E;
	Sat, 11 Oct 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MBw5FlGj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291721CC4B
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760167907; cv=none; b=eg7VqisxEJThclJfM19qLkmCWYKAOEqhCyWTeEJ8Hc8A9U74EQWMBx7e0yK9KKK4TSkuCzcZKKSR2UckV/pBHRmMd7AGJJdpFtkRLH/gnU1XP19NIH9+YsKBVqgvGe/YdsWrlpZP1pdowLmuKxbD1q+FJrs87ua6zZSjgFw9JPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760167907; c=relaxed/simple;
	bh=4ZQMZ6lu98hFT5R3rQTJZOSGHKLpEJ+yNr9McwBwSuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMWCw/9zCxFpEmYGZ6EKB51hrrh9uH5Hx8OQQAX3k+F6YArMwNQBZ6ldqqpDCK9cifuvN4nzUxR3c6yOt3rmilrg4BF/NLJ3sESIyGzyd5FiI8i7ZwnDKFxcKxF61edrbVS1KSuqz0kaMaeVyB2XnNpFaWyBpSVzfp8fXTXdGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MBw5FlGj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e32139ef7so4506785e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760167901; x=1760772701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbYY7sY8Jo2X7gob7T9wRzQDhnsoRHBvrry0f0lUkwI=;
        b=MBw5FlGjsR1Kau/5c/K7C8lG+wovU7He6F17s6pnVtCxbOcFQaOLt13Gu4tqLYxL5G
         6z3hFKWPDVBUQF3H1LqF3qjIIseXi0APAp2lAOCrOPp6BnQxFmJUfArav+bjLg+Bsvnv
         R5SCnvSNPlVD23lsjB6sP5A87FYUtq43/eKUsN+thl6bdv7A4i+GzDWU9ltY0ZU4KRZD
         T4eLo+zYHiWR8UutVWZ9vNtZaRqBLyvONP+Xaed493Cf29NsZn/6xKM9HD7viZSXadSK
         xt0yLiWTCC7w3puM8mOCOhT0FF2yELX0XrcFUc3174z6XFHxqak9p0HuFOZvRShcXane
         9dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760167901; x=1760772701;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbYY7sY8Jo2X7gob7T9wRzQDhnsoRHBvrry0f0lUkwI=;
        b=YEiT3+e25JUmwgpMLoyrGtwlapnUEB07Ez+HIGrHJD0DNYTsg4GxYPP01DdpZbmNHX
         yFxnht0KimdUZc5N4IBDiqISgwSWODZD1fcSBGU+yVzH+5BwbTBdCNlUY+8mi7d42+P2
         ot395YGK2Zn2q+uHCV4UlSAxPSvaLdZaG6JAY9L/cKylqOj3HdCdIsjaRDYdjkBxDGUt
         0B9pkizWrwS0wmwv9EOoWJrO6gMRl7IdQl+aLEstgmxnRcaPm0W4hCwP9+WapcXZGIVG
         AAR01kHm50ZxwG8ApFK/bOnI+HdZP1867ZOWTfwbsWUh4yj0wRQ5HK0qmOx7OlBylHkN
         PRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8BKoWS0PLS8IJNePSaRftZb7KuJGAZ3hkPpapMkIXpd0exYqs/ktIXeRZxbVGpbc4NXMBP645a4lrKbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6NZzReBmLbjqY7H819nMddEJavrI0Eq0rSF7cGNO21P5Xz/Hs
	LrpAh6pR4dYuSFcGfTFf7AyneG6Yif8qrC0Zq4RXT5Rv6STx5eG9nYynrCzOMsYq9xw=
X-Gm-Gg: ASbGncvJJuKHGs7g5fHBR6nmFLwG6+q6cryuO4XqmHya0Vz6kqLCOGPXWwcyX3ycKT8
	6xQT2zCcsZelxc/edM3PCRESnjOLNs72GNqgVuOTLT3y5LFnVCPK2P7N+/Bbnd6d4JlABqaqr5f
	Z/OOH3KJAAUdpTWrNIaYTYsKWQ4dDrCLuEXUn96HxDPNkREKk0I7UygrTEo/vuJN/YMJYpspmtg
	oHCIxyjA6i0oxSZ5IcLohaKF2gp5F1n2mM3K44AutRK502QqZBANhvmRQcgwOaFUX9axbmdXyYq
	nwSp0/JsvGCtpnlYL/eV5D1dvOGV0gCTGbFwbVtwZqjNv57QMLW5TIe2yZFvya6b/Hs3JxWSig1
	uN3kCRkr3sQt4Woa8bIfTo89t7Y2jyP7RDXdlJxhSQcbh3pwyIp01SaWKTZ8=
X-Google-Smtp-Source: AGHT+IH3Fu1/FK2XkLjEzPs+tdGWk8//yg/29/qkmRtovY3U1OJ54a6kwdpjvuNZuN8cPifJyZtrZw==
X-Received: by 2002:a05:600c:4e93:b0:45f:2919:5e9c with SMTP id 5b1f17b1804b1-46fa9a8ae60mr55204465e9.2.1760167901536;
        Sat, 11 Oct 2025 00:31:41 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626403desm5241528a91.7.2025.10.11.00.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 00:31:40 -0700 (PDT)
Message-ID: <d4398dec-0b71-4070-b542-b595edd0f8e4@suse.com>
Date: Sat, 11 Oct 2025 15:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: clear extent cache after moving/defragmenting
 extents
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Deepanshu Kartikey <kartikey406@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, akpm <akpm@linux-foundation.org>
Cc: ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
References: <20251009154903.522339-1-kartikey406@gmail.com>
 <94c9efca-2805-4fcb-a52b-e26eac8f58e1@linux.alibaba.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <94c9efca-2805-4fcb-a52b-e26eac8f58e1@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joseph,

please check my comments in another mail.

https://lore.kernel.org/all/20251009142917.517229-1-kartikey406@gmail.com/T/#m0c02c884701c12d71206d0f9aba4450879b18e0c

- Heming

On 10/10/25 09:21, Joseph Qi wrote:
> 
> 
> On 2025/10/9 23:49, Deepanshu Kartikey wrote:
>> The extent map cache can become stale when extents are moved or
>> defragmented, causing subsequent operations to see outdated extent
>> flags. This triggers a BUG_ON in ocfs2_refcount_cal_cow_clusters().
>>
>> The problem occurs when:
>> 1. copy_file_range() creates a reflinked extent with OCFS2_EXT_REFCOUNTED
>> 2. ioctl(FITRIM) triggers ocfs2_move_extents()
>> 3. __ocfs2_move_extents_range() reads and caches the extent (flags=0x2)
>> 4. ocfs2_move_extent()/ocfs2_defrag_extent() calls __ocfs2_move_extent()
>>     which clears OCFS2_EXT_REFCOUNTED flag on disk (flags=0x0)
>> 5. The extent map cache is not invalidated after the move
>> 6. Later write() operations read stale cached flags (0x2) but disk has
>>     updated flags (0x0), causing a mismatch
>> 7. BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED)) triggers
>>
>> Fix by clearing the extent map cache after each extent move/defrag
>> operation in __ocfs2_move_extents_range(). This ensures subsequent
>> operations read fresh extent data from disk.
>>
>> Link: https://lore.kernel.org/all/20251009142917.517229-1-kartikey406@gmail.com/T/
>> Reported-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
>> Tested-by: syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=2959889e1f6e216585ce522f7e8bc002b46ad9e7
>> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> 
> Looks fine.
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
>> ---
>> Changes in v2:
>>    - Fix moved to __ocfs2_move_extents_range() instead of ocfs2_refcount_cow()
>>    - The real issue is in FITRIM/move_extents code path, not COW path
>>    - COW path already clears cache at end of ocfs2_refcount_cow_hunk()
>>
>>   fs/ocfs2/move_extents.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>> ---
>>   fs/ocfs2/move_extents.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
>> index 86f2631e6360..10923bf7c8b8 100644
>> --- a/fs/ocfs2/move_extents.c
>> +++ b/fs/ocfs2/move_extents.c
>> @@ -867,6 +867,11 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
>>   			mlog_errno(ret);
>>   			goto out;
>>   		}
>> +		/*
>> +		 * Invalidate extent cache after moving/defragging to prevent
>> +		 * stale cached data with outdated extent flags.
>> +		 */
>> +		ocfs2_extent_map_trunc(inode, cpos);
>>   
>>   		context->clusters_moved += alloc_size;
>>   next:
> 
> 


