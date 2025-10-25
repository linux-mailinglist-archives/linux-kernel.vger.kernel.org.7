Return-Path: <linux-kernel+bounces-869880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBDC08EC3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305803A92F9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98DA2EA724;
	Sat, 25 Oct 2025 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LVY7o8qr"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FD71DE3DF
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761386826; cv=none; b=EDYE34fGGE+hgDtBcfsztOFfGj+RYtYFKVpF7n6KIN6E/cVWVFIhONxXLgDkkc0JGv3pD8bg9fKLcTQcnNRiBUo5lLkv/qoySS5Gd5SLoKZUcSiErF5t3ksdX3+yimE0c0xScLA8779j6AFCYxafDxZ1fZxFZlyYTqXlIbASFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761386826; c=relaxed/simple;
	bh=/nkvwQcQOUseZCfuA5/TaYOK82Tbt6IRGSTD7moFW4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUz/O9J+IcwY/pIlL6HXY+w7YyOK729JQ8KYRZfMu7ZiWgbRFBNGUHyUIZ2Z+w/4cu/WuH/LHisotLuDCYZ/Dbp71d5t4N5glHGZ2fEH1p3C7MLBB3HwlUxJ+JOVP/e0Sd+7hdM540iHSTw9y4Wi0IMxAtLpsYOreO0yxeR/38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LVY7o8qr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112a73785so18296125e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761386821; x=1761991621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ffKrW4JJrj3VHxVVjDqJDojj1sAYTEf4Ex+dz329C6w=;
        b=LVY7o8qr8b62fD2ja4wY358UNXMN4lOtWgAfqngfLV6z32Xkum2dJuIcO1oA5ZiJBB
         Xno1eQ0H9C5uLW/mR4sAfahps/NczNy5NgK4X7jP7zAvDDJ1NSnD1P3EmAooQJF/mX/1
         67J/ZLIya0BTnBTztQs7AC7kafcxyXiDkrXMceVpvKb9nVBw/kPbnxVM3s8GF/PxVbLz
         I+J4f/qPGJ2LJb7E8mYEXeDEbpdlGAv+wCeDbfUN+N6dkafIvSqQmPnRFXCgKedRjk75
         cZ8L1cWOoqkYfh2qkj+X2rc8tOa5Of97oGDO1Lr57hZ7LN+5945jqrvcm6Fbum3yyYtT
         lVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761386821; x=1761991621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffKrW4JJrj3VHxVVjDqJDojj1sAYTEf4Ex+dz329C6w=;
        b=rLAFCF5YEsQYRvRd0xHyj6D8aJZVTsgjlX0D09Pyna/uoYPGDIU7sldqFe4FfZaFcB
         JZ015klU2CjGs7y+VIP401MMKsgGIZNcV8B46879ojFH52sMlCfT2/J6COgAd6bCNemr
         lvJNkspg44wks2fmgWFgm7oxDGDwTkfd5r4mjE4MrTRtVczwR8CcroMrFK2p8wCgc6aH
         QmEDENJpHx8LWqR8E8nsGRzosov9tFojmcBW9dr6WCGzEv48znqL9+SW6kLTcvfWteV3
         2uRUtXkruEJHpPZPYlSCE1ZiYcb0JKf8aVeLvCBXp3V6QzBgiagTg+vzW/RhMtn/w1/4
         g5lg==
X-Forwarded-Encrypted: i=1; AJvYcCUVLqZyoutPZw907gKqSSSpgGRkp6KmcKDtebX2kPJLnN5edof5k98QdR9KWVweIMmSjtsAJTTOFZiMYQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Zz6YvFPUucHET+tM8DX0Nq8AME7zGoqbMMU9u3gykr1Dm6yh
	0nLvHp61sw+dLb41KiCWzw+vBmQmap18s45y0hTtKvSIBq0VFOFv9dGJ1+rkhOV+6kA=
X-Gm-Gg: ASbGncvYaXrS/K/+FQc+5oeRl/aB4wDLbyksi2fJrhX6dCHBxgSu9ohOEtqD/CLBNXZ
	kihleVBy4cRQdFfReS0VuuBIUnAPfpWMcJmEW5EnopFnUcMwbHABz6ie1r5SxyVNBNLoCGtPY6M
	Hled/Bw4+E+8Khg//1+KdQTaW4wHlZPdyeuVEDD2CW03PrrK6rIVTvYdrbNZjNFIdSjyf2FbEvm
	YtvAUrF8zW6FdvavrKdH2tra7OEkwOEZcf3C7GAC/pHB827PlqSZ18EC7Z+ew7nebc6PXUx8Lqh
	oR9D38jyzSID6e8NmzgQ/iAEpIla9m8ICvSXFyR1n/+ZA1C9h2jgT+zs0zHnJyO8RKgl81EFnix
	889ECQBAbxGwvq+P4kWwrljcQaN/WxRr+d89c0VJV/InDk4q6ay4DMPhLISOldAkiBc1SQKxIuI
	IJ0EPwYyrMAFtAMApgL2yyu328Tcen
X-Google-Smtp-Source: AGHT+IHchT8Z4oQ1De1jwRykmWf+L8ypsYopyNQhR9SYSssq2RNZbs9gtAznCWckyDwsQYkLDQzmbw==
X-Received: by 2002:a05:600c:8b71:b0:475:f16f:6f44 with SMTP id 5b1f17b1804b1-475f16f737bmr5258505e9.27.1761386820858;
        Sat, 25 Oct 2025 03:07:00 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127a0a2f9sm1696657a12.9.2025.10.25.03.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 03:07:00 -0700 (PDT)
Message-ID: <293c10e8-fa6b-4da2-8d7d-9eaf6b4ecd4b@suse.com>
Date: Sat, 25 Oct 2025 20:36:56 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH fs/btrfs] btrfs: fix memory leak of qgroup_list in
 btrfs_add_qgroup_relation
To: Shardul Bankar <shardulsb08@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, linux-kernel@vger.kernel.org
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
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
In-Reply-To: <20251025092951.2866847-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/25 19:59, Shardul Bankar 写道:
> When btrfs_add_qgroup_relation() is called with invalid qgroup levels
> (src >= dst), the function returns -EINVAL directly without freeing the
> preallocated qgroup_list structure passed by the caller. This causes a
> memory leak because the caller unconditionally sets the pointer to NULL
> after the call, preventing any cleanup.
> 
> The issue occurs because the level validation check happens before the
> mutex is acquired and before any error handling path that would free
> the prealloc pointer. On this early return, the cleanup code at the
> 'out' label (which includes kfree(prealloc)) is never reached.
> 
> In btrfs_ioctl_qgroup_assign(), the code pattern is:
> 
>      prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
>      ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
>      prealloc = NULL;  // Always set to NULL regardless of return value
>      ...
>      kfree(prealloc);  // This becomes kfree(NULL), does nothing
> 
> When the level check fails, 'prealloc' is never freed by either the
> callee or the caller, resulting in a 64-byte memory leak per failed
> operation. This can be triggered repeatedly by an unprivileged user
> with access to a writable btrfs mount, potentially exhausting kernel
> memory.
> 
> Fix this by changing the early return to a goto that reaches the
> cleanup code, ensuring prealloc is always freed on all error paths.
> 
> Reported-by: BRF (btrfs runtime fuzzer)
> Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
> ---
>   fs/btrfs/qgroup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1175b8192cd7..0a25bfdd442f 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
>   	ASSERT(prealloc);
>   
>   	/* Check the level of src and dst first */
> -	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
> -		return -EINVAL;
> +	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

Out will call mutex_unlock(), but we haven't yet even locked the mutex.

Please just call kfree(prealloc) then return.

Thanks,
Qu

>   
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
>   	if (!fs_info->quota_root) {


