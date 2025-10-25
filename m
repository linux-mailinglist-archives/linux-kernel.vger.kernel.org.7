Return-Path: <linux-kernel+bounces-869890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66447C08F06
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB453AC88B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E272EF64C;
	Sat, 25 Oct 2025 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E+LGOFVJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B284825B69F
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761387735; cv=none; b=UF56j3k5yjjwQU4SbLtLeNitNANHZVWruIktGve1mfhAwku9Bqeb+Zs2CyXr4hLpxIlbUDZcCtGdO8kCKOEj0Qx13696PCCBXrbhgL7XA/qB9ZXwzs56F9QBf7m9UpDeCpJlZ+X28v8/1wB1v019MTawa3S/Wf/Ir0odx8X4JcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761387735; c=relaxed/simple;
	bh=44pTS+lBoqxlTHc5dDQxB8Mc8BXXxf4gPiq3GBcKnwE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QBwI7vsdr4d98LK+sX56nFA544r59YECDW709H62ldNwnV5TsWp/sFDtdN8TElzdEwCJxWuh+UJCxVbX59fCjMEXyzukjISkDYEXK3xSxxIQtCBVcc1HQYMScU20lFvNOhQzJ6FeYEBbrMjxz8Oex2slu6Nat9V20LBH6xhF0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E+LGOFVJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47109187c32so14357585e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761387731; x=1761992531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4fNjxfMWJNNamEIJToaAFCvp9NaiazS8H8Vb/xpPvlo=;
        b=E+LGOFVJ3D+BIYXqYAEhLyecx+ucfN0i6BCRQ8wVySryjnAASjCf8xB7kw3lI/lOkb
         5MhNSHFxrPh6kBl33Cv7yXiN5ECQtvhJj42t23AeKHRSsoapcBIWrLNNC2dudFC6Db9M
         IAChdkEn7LH5kcVH1Q3v3ND1w5i7txcYsjaygnA4MIdGDkzS78XGqNtTSBwgka/14E1G
         oZFUXRloXwq1KZZ4rjO0XznbTCw79IPe6BqtQqTltcssxDoTkS4ntoXM8iCRHxFQO5P7
         6BNL/qc9hnCW2etrsAXMS/w/22+NPLeFmhvjLCemUYSx1m9NBBxqO9nNsO3PLwgRVmC1
         7nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761387731; x=1761992531;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fNjxfMWJNNamEIJToaAFCvp9NaiazS8H8Vb/xpPvlo=;
        b=NnMo9c5P5GgRPedGeTctMtoL+m5ytt1B85ddcNF5WsWHEdU1MaQrC6GUF6XVRXKEUE
         f3iuGsvZtPMvai9j8VwoawKLV0nzVo/Xuo6ajegT7gl2fQlbO2iRRdiNSrrNsgDgSGZW
         Vs4UOmG0VHFaOMrwhTLrZ6Q324WrZp61jdf1tdnAqVt7RlDRS2NgKVKrgVAADd1ocgVq
         fwrMK1c2/UHlNQzFWcjAMFBNmQCdC/bAP5azZcaGM5QrirOvqZILF6W1eM78RPTdKxTW
         xOD2KTGklLNvyJ+wTnjC8JuWaJLwFdfU46hxi4mtAzyeLcb2ku6DDk7FbJS6RftM9Vuz
         kEKg==
X-Forwarded-Encrypted: i=1; AJvYcCXHgeAP9Mv/gBHprD91s5pSVWOZdkpOUcFg4/qhD/6O6Lo2dC0c0Gs0lOjD0CXArGGZQ71qc5V2PVrWPDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCSQfB4pVm1iLfRvnH9Ef6y0+W84nSrSd4JyrB+AF5d0/rydAI
	M5dl8OjBS9kZaP0aqaexuiVr+r23IK4nPpp3nC8QzNkhKei6F06s7mqer8BqkzGWlf4=
X-Gm-Gg: ASbGncuNRVV0D3U38eAizvG/TSj7etDSXQmU2RlZNASO1JE6S9vYGVJjyun9gifLnOS
	fqpRp4ZRoc7rXxs8F5k7LC+Eyiudz9GC/JWpyT1PnkHEhDKQICNKb3zWPox/3mEPYQWR1FZ47kD
	6Yp37CgOIOTrkfC4QYjyfjgCAs6PGBLRViiNfOnSxtDQZJL7EYVnifbgA3MbFoqi+UJBbDQnbK3
	qh6P9vVIThPMqt6pFp8Ab8npq3ThSnb45Gdvj7Fd3CuGxDqOuvn7xFszD2JVTKQVmFQbySVhrM5
	2KO+ArB2HVV91buMtJJUSm8a4xhzzMFGpWC8ZLE+Tn12hMPDRnGc5VGsJ3ta8+q2wSGKAQAf/5z
	qpWnU1h5CGTJKxBz3sPaO0ca/s9mfIw01ygAr1LX1BkzubehHRS47qila3avTO6yrc3+Jfe3bzz
	CLnu4DUWfkSHOa4N9lBLwzL+kJZwvRcvNbdQNBIh4=
X-Google-Smtp-Source: AGHT+IFrRxk+C6wSHlbHaOxVcqR25VztJE49+0+uc5Xnc3VjIYEkEx4tX2MW8hPdqM+0e1ldKjJGBA==
X-Received: by 2002:a05:600c:444d:b0:46e:4cd3:7d54 with SMTP id 5b1f17b1804b1-471178b124amr218578665e9.18.1761387730780;
        Sat, 25 Oct 2025 03:22:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf423esm18818645ad.19.2025.10.25.03.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 03:22:10 -0700 (PDT)
Message-ID: <dfc3110a-0380-4511-b044-e440c2c3ce70@suse.com>
Date: Sat, 25 Oct 2025 20:52:06 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fs/btrfs] btrfs: fix memory leak of qgroup_list in
 btrfs_add_qgroup_relation
From: Qu Wenruo <wqu@suse.com>
To: Shardul Bankar <shardulsb08@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, linux-kernel@vger.kernel.org
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
 <293c10e8-fa6b-4da2-8d7d-9eaf6b4ecd4b@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <293c10e8-fa6b-4da2-8d7d-9eaf6b4ecd4b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/25 20:36, Qu Wenruo 写道:
> 
> 
> 在 2025/10/25 19:59, Shardul Bankar 写道:
>> When btrfs_add_qgroup_relation() is called with invalid qgroup levels
>> (src >= dst), the function returns -EINVAL directly without freeing the
>> preallocated qgroup_list structure passed by the caller. This causes a
>> memory leak because the caller unconditionally sets the pointer to NULL
>> after the call, preventing any cleanup.
>>
>> The issue occurs because the level validation check happens before the
>> mutex is acquired and before any error handling path that would free
>> the prealloc pointer. On this early return, the cleanup code at the
>> 'out' label (which includes kfree(prealloc)) is never reached.
>>
>> In btrfs_ioctl_qgroup_assign(), the code pattern is:
>>
>>      prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
>>      ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
>>      prealloc = NULL;  // Always set to NULL regardless of return value
>>      ...
>>      kfree(prealloc);  // This becomes kfree(NULL), does nothing
>>
>> When the level check fails, 'prealloc' is never freed by either the
>> callee or the caller, resulting in a 64-byte memory leak per failed
>> operation. This can be triggered repeatedly by an unprivileged user
>> with access to a writable btrfs mount, potentially exhausting kernel
>> memory.
>>
>> Fix this by changing the early return to a goto that reaches the
>> cleanup code, ensuring prealloc is always freed on all error paths.
>>
>> Reported-by: BRF (btrfs runtime fuzzer)

And forgot to mention, if this is some tool that has sent a report to 
the mailing list, please add a "Link:" tag.

If it's only something internal to your organization/project, please 
remove this line, it makes no sense for upstream.

Thanks,
Qu

>> Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup 
>> assign.")
>> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
>> ---
>>   fs/btrfs/qgroup.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
>> index 1175b8192cd7..0a25bfdd442f 100644
>> --- a/fs/btrfs/qgroup.c
>> +++ b/fs/btrfs/qgroup.c
>> @@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct 
>> btrfs_trans_handle *trans, u64 src, u64 dst
>>       ASSERT(prealloc);
>>       /* Check the level of src and dst first */
>> -    if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
>> -        return -EINVAL;
>> +    if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
> 
> Out will call mutex_unlock(), but we haven't yet even locked the mutex.
> 
> Please just call kfree(prealloc) then return.
> 
> Thanks,
> Qu
> 
>>       mutex_lock(&fs_info->qgroup_ioctl_lock);
>>       if (!fs_info->quota_root) {
> 
> 


