Return-Path: <linux-kernel+bounces-881327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA254C28050
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0D294E9E5F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561C3225417;
	Sat,  1 Nov 2025 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kSUNPqNL"
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA28C1E51EF;
	Sat,  1 Nov 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762004473; cv=none; b=r7ekCHpj3/U+SlSjw2SixQ8qKURvVZTNFfzJv1XznHJ7/pZ/QJy6DywsOLA+vQ5y4DtPtk9+SYOXyhx377LuaQ0EZkGJgU2/UTEBEQj/9anr4DsBsz3+rrtgbeGZKrNEQKDcZBxljpFouSffZLjGKJ1Vu3KOo2dVea7olfKm49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762004473; c=relaxed/simple;
	bh=AuDDrond62cdQlyE60iW/Lef0hfpGtCQrKuAmCVh4iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQTnoEY2OJUaNchvEjTg1iUJBNUjHmp6b5Zgx0qVTGGze8F9KGUUNYESThoWuP0FnfHyLw0Sp6YeuDBbqU8FU7f+mbZ2Lhfmms0uib7BskyTKD+mwxqWpBHBV4VbvOptjoZPgU3zDjRepUZmbvCcunCxox2IkqF4lwOnMIsuCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kSUNPqNL; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id FBqlvvyZc4wQjFBqmvMesc; Sat, 01 Nov 2025 14:41:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762004462;
	bh=BFRIQ+k/BrGzxmo6SmGnQQfTWG7vWAKgQMdsX7DqaCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kSUNPqNL8nv0iYridFZ1+9eObXZrpad/ZBAB11cVzlUfqy1ls+kQ5zBkWNxMK3WRB
	 g3YNuNlU7W5SkLZQQB7ky4xYBAx6QP3SY4TqKQqk4z3z8sqKA4IPa3WukEC91C5JDg
	 dTiSKQeU0oDw0KEbnxFjb5ZsmVAFByc3O8SVitjGMa2ERHXnqx1uvtUNnbwVSy+d2f
	 1GcakxJvEzOod1H1XQuWv5TFC1aiHi9BV6vMZwCjZ3PfT2NzuAm4h8SC9/js8CBuwL
	 7+sH34NimxdWkqYiseIgnhY/2iEPnWq0Qy15m9nvyzNNo6j0ucFJ5VRdqITuyGWX1m
	 oOCTPFQk2YBiA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 01 Nov 2025 14:41:02 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <7776eb1c-418a-444b-aa24-0dfb23f05a2a@wanadoo.fr>
Date: Sat, 1 Nov 2025 14:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl: Slightly optimize cbm_validate()
To: Dave Martin <Dave.Martin@arm.com>, Tony Luck <tony.luck@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <c5807e73e0f4068392036a867d24a8e21c200421.1761464280.git.christophe.jaillet@wanadoo.fr>
 <aP9a9ZtigAWCWSWk@e133380.arm.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <aP9a9ZtigAWCWSWk@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 27/10/2025 à 12:43, Dave Martin a écrit :
> Hi,
> 
> [Tony, I have a side question on min_cbm_bits -- see below.]
> 
> On Sun, Oct 26, 2025 at 08:39:52AM +0100, Christophe JAILLET wrote:
>> 'first_bit' is known to be 1, so it can be skipped when searching for the
>> next 0 bit. Doing so mimics bitmap_next_set_region() and can save a few
>> cycles.
> 
> This seems reasonable, although:
> 
> Nit: missing statement of what the patch does.  (Your paragraph
> describes only something that _could_ be done and gives rationale for
> it.)

Will add it in v2.

> 
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>>
>> For the records, on x86, the diff of the asm code is:
>> --- fs/resctrl/ctrlmondata.s.old        2025-10-26 08:21:46.928920563 +0100
>> +++ fs/resctrl/ctrlmondata.s    2025-10-26 08:21:40.864024143 +0100
>> @@ -1603,11 +1603,12 @@
>>          call    _find_first_bit
>>   # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
>>          movq    %r12, %rsi
>> -       leaq    48(%rsp), %rdi
>> -       movq    %rax, %rdx
>> +# fs/resctrl/ctrlmondata.c:133:        zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
>> +       leaq    1(%rax), %rdx
>>   # ./include/linux/find.h:214:  return _find_first_bit(addr, size);
>>          movq    %rax, 8(%rsp)
>>   # ./include/linux/find.h:192:  return _find_next_zero_bit(addr, size, offset);
>> +       leaq    48(%rsp), %rdi
> 
> (This is really only showing that the compiler works.  The real
> question is whether the logic is still sound after this change to the
> arguments of _find_first_bit()...)

Will remove in v2, if not useful.

> 
>>          call    _find_next_zero_bit
>>   # fs/resctrl/ctrlmondata.c:136:        if (!r->cache.arch_has_sparse_bitmasks &&
>>          leaq    28(%rbx), %rdi
>> ---
>>   fs/resctrl/ctrlmondata.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index 0d0ef54fc4de..1ff479a2dbbc 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -130,7 +130,7 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>>   	}
>>   
>>   	first_bit = find_first_bit(&val, cbm_len);
>> -	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>> +	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit + 1);
> 
> Does this definitely do the right thing if val was zero?

Yes, IMHO, it does.

If val is zero, first_bit will be assigned to cbm_len (see [1]).
Then, find_next_zero_bit() will do the same because 'first_bit + 1' will 
overflow the size of the bitmap. (see [2] and [3])

The only case were we could have trouble would be to have 'first_bit + 
1' overflow and be equal to 0. I don't think that such a case is possible.

> 
>>   
>>   	/* Are non-contiguous bitmasks allowed? */
>>   	if (!r->cache.arch_has_sparse_bitmasks &&
> 
> Also, what about the find_first_bit() below?

Should be updated as well.
Will send a v2.

> 
> 
> [...]
> 
> <aside>
> 
> Also, not directly related to this patch, but, looking at the final if
> statement:
> 
> 	if ((zero_bit - first_bit) < r->cache.min_cbm_bits) {
> 	        rdt_last_cmd_printf("Need at least %d bits in the mask\n",
> 	                            r->cache.min_cbm_bits);
> 	        return false;
> 	}
> 
> If min_cbm_bits is two or greater, this can fail if the bitmap has
> enough contiguous set bits but not in the first block of set bits,
> and it can succeed if there are blocks of set bits beyond the first
> block, that have fewer than min_cbm_bits.
> 
> Is that intended?  Do we ever expect arch_has_sparse_bitmasks alongside
> min_cbm_bits > 1, or should these be mutually exclusive?
> 
> </aside>
> 
> Cheers
> ---Dave
> 
> 
CJ

[1]: 
https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/find.h#L203
[2]: 
https://elixir.bootlin.com/linux/v6.18-rc3/source/include/linux/find.h#L185
[3]: https://elixir.bootlin.com/linux/v6.18-rc3/source/lib/find_bit.c#L55

