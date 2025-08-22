Return-Path: <linux-kernel+bounces-781652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31016B3152A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D80EAC09EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4272D7DE2;
	Fri, 22 Aug 2025 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/A9pubU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2105263F22
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857906; cv=none; b=EzWyIS/5zdwKJTySVNb9iEqaMr6s2MJf2M0USJ1BjH5OPFsQ+WMwp6rNzcY0QRmnFDK09PCn/jBJGbwLRj3iNDDv3M26JVaCP8pQd3dJqFC5f0vVKSKKWOnlrFqq8NQt+PRfeQrRzsYwql2b3AdxubLVmrALrqeTCojqnKfLHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857906; c=relaxed/simple;
	bh=ZRhqxi1umtqKjUZlTismpejrp60ueT8URBAZNkgaPLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEU+G/rFSChkuK5wrebrlg4/Oe9mw+737VsgSw5rLe2LaxAlgaaobkQkjrlHUgowQ9/sRR9gcfGk7ryjXjQjC9PL37Xl3sj2SuwbScfpJ4mzjDRBTv+qiOlvfhjBx4YmKcDMGZiW9n3UmsN9NrnY/+M9KdVJgRVK10dkCg6ChNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/A9pubU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9e7437908so1302374f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755857902; x=1756462702; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lUMVWvMJsvr8u0JNPGfEHSPjEjWHpYL2vU3r9p4k75c=;
        b=B/A9pubUJxisjipK7c7kPfQYEveIMSV4dmcWSR1Mzk47ZuHISo4jg6BGKs0+m0TyRA
         KUNTx13DNiRijkHqLuxrDXlOuJYKtKhVCNaWIa/1/EHVXj2sCjwQvcvQy9/ZbkduxVJf
         NxmU5ztsGiH5L+fjrUZ5TcJogYZCIkNXTv3cXXyRidCH/XBe0gXFNEFj9uvHVxUt5jzI
         cmncI5aFq2mXhSj8Rytv1QnufiU+6kWeqx2YuTBC3rD2krSj0r71Wmw+IBsqafifSEp9
         evsjLYlF1Pk/lNgDBSYYD3qJMp0DKOJ/YsLU4RY4n1RC8MbtfxaUKDqEGN2x216Jop00
         q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755857902; x=1756462702;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUMVWvMJsvr8u0JNPGfEHSPjEjWHpYL2vU3r9p4k75c=;
        b=TOYdtO2r3ksRxOxjUcXdhYBLZNZdsw9QkIZROBV11TFdoZbdcNx8GI3te72bYMM2wG
         wft0di/wgfhaOInRbUFNJJtqXTF1GpY/qabDl9BbcNX6GB1rmwCjs5HtHk5FEIzS519B
         5xK9jYiwbxX7T0nit0MdEiNOeB0/zo5hQOVFVJxst04MnXY+5uyxvlZ7Y+ozvdLbcRRx
         grSB4U4S1mpAMCCEDvqExioPWYwXcsySlKWleVwm894DtcPNKEUUUGPEJjdwCF/RE3+9
         S2BVQeSEJ+yuQhCHYB3LSoZ1TbW+PJQMkQf0V6vdo09jyZZYu0P+9AzwgRAryIuQjsA7
         1eQg==
X-Gm-Message-State: AOJu0YyHKGYg0RTJ1aVz7If/4uxbGlXWMMTw7NxkvRxputTP4p5qSgQU
	1MCU4z2dxyjlF20ChAqvIIzC/gJKJnWQ1cXQK4/Ejgd/7WO9V9wyat7FZb59UCvag5E=
X-Gm-Gg: ASbGncsqRazBq4/8c3QiuEKmuZrAr5pbayQCbGFp1IxaXawBX7faVu0V9NSHQVN5WVk
	/ADfd6RSJxlIOAXa+agl77G5YJ8Oz5iRWzgUeeGkLcC9lWgImGdILtaXKaGjf+XquecAfi+G5ed
	TdANzgs5IIsFZLyAnMDuGFAMlz98YjKIRY46OHXEsGnAWgl3ktH6oMiYDX/Ta1/o74B4hlXwA56
	aU9CATuqxGR2CjsNWcpMKDdc0Xwj52dquI15Fo1zCjtYj4F5xnrf/x3dEH3pZ2RZBJJPkNBSW88
	TjiH1KEGUPpDU+KbA6DtiousSIwU+Sv7lNeSiUvMa9qP9TG6+axL4lttJ6ePJEyURA70MJOAjAO
	sMdTDpGkXs60s2UoztScPKxEK304cfGw20ez/u4eA0UGfZ09eapQmeqq6i1qV7g==
X-Google-Smtp-Source: AGHT+IF/GPcupV5lDGUOlmnOAJWWxOnSu3BrReGiSDsdOUDO4mFZN9L5UYnmPt128iVddNAXK9FWYA==
X-Received: by 2002:a05:6000:2501:b0:3b9:1108:8e99 with SMTP id ffacd0b85a97d-3c5dc542a7amr1804688f8f.41.1755857902108;
        Fri, 22 Aug 2025 03:18:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33cac4sm80039385ad.16.2025.08.22.03.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:18:21 -0700 (PDT)
Message-ID: <9bdb2726-de7b-4ef0-9ad5-7050d214a85f@suse.com>
Date: Fri, 22 Aug 2025 19:48:16 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Accept and ignore compression level for lzo
To: Calvin Owens <calvin@wbinvd.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>
References: <a5e0515b8c558f03ba2a9613c736d65f2b36b5fe.1755848139.git.calvin@wbinvd.org>
 <a637a576-f107-4d05-84c8-280b133e925a@gmx.com>
 <aKg4PcgUCvXblVCY@mozart.vkv.me>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <aKg4PcgUCvXblVCY@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/22 18:58, Calvin Owens 写道:
> On Friday 08/22 at 17:57 +0930, Qu Wenruo wrote:
>> 在 2025/8/22 17:15, Calvin Owens 写道:
>>> The compression level is meaningless for lzo, but before commit
>>> 3f093ccb95f30 ("btrfs: harden parsing of compression mount options"),
>>> it was silently ignored if passed.
>>
>> Since LZO doesn't support compression level, why providing a level parameter
>> in the first place?
> 
> Interpreting "no level" as "level is always one" doesn't seem that
> unreasonable to me, especially since it has worked forever.

No means no, period.

> 
>> I think it's time for those users to properly update their mount options.
> 
> It's a user visable regression, and fixing it has zero possible
> downside. I think you should take my patch :)

I do not want to encourage such usage.

Sanity overrides "regression". If it shouldn't work in the first place, 
it's not a regression.

> 
> Thanks,
> Calvin
> 
>>>
>>> After that commit, passing a level with lzo fails to mount:
>>>
>>>       BTRFS error: unrecognized compression value lzo:1
>>>
>>> Restore the old behavior, in case any users were relying on it.
>>>
>>> Fixes: 3f093ccb95f30 ("btrfs: harden parsing of compression mount options")
>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>> ---
>>>    fs/btrfs/super.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index a262b494a89f..7ee35038c7fb 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -299,7 +299,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>>    		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>>>    		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>>> -	} else if (btrfs_match_compress_type(string, "lzo", false)) {
>>> +	} else if (btrfs_match_compress_type(string, "lzo", true)) {
>>>    		ctx->compress_type = BTRFS_COMPRESS_LZO;
>>>    		ctx->compress_level = 0;
>>>    		btrfs_set_opt(ctx->mount_opt, COMPRESS);
>>
> 


