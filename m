Return-Path: <linux-kernel+bounces-845997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27748BC6AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E4219E40C5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9702C0F76;
	Wed,  8 Oct 2025 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ccvz4eac"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB1E2BF017
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958885; cv=none; b=quLzjM8oyOxrgyZ8L7KW3QEYbj7Y3/hJlStWE9n5Qmm9k92PKsocpVmQtnpJCGS0wjmH/n1fotVmVuFA/mOvTA1cwT95V5rknDMZNU4wzMylzsbsD1xqXBOrJrZ4Imr6aYqyU3bLGVRePKALPBTD0Ys+oWbqx0jvi+HsCmOlbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958885; c=relaxed/simple;
	bh=E5N2Fgy9mJ0mvj1n6CWlymPq/Ag30DuQ861RwNTamHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shcDf/P55rJUx3d5jfECkpTpWJRJWeEa7BMdRvgSkh0qHm7iLlbLMSEqigZWY5bFpFXz/E1IXaiYWdeu4tmKi0oY7TLG6d4FAlFa7ov6XBvAMvSKKUBxY9Lky7zftVKMsJl4mzcEy7i4OFqeSuHSXCkDD/Jac46XYJkfS/Vn1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ccvz4eac; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so206731f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759958882; x=1760563682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6D3EUCRhmhoMUd045LVIlT60xGnWKT3phek8gUNMDC4=;
        b=ccvz4eacBoXB5hmIFxrybCA+MYrhv1C6RrbKlKEBgy1SxB8Wj42EXCInZYK0MZWZBv
         GYt60iIqxKRFoAr1LBx0M8rxlYreHJkjq20eKALxXBY1AP5/eEFdxBJ50KU5UI9mzqHF
         ACu9Kq5vE7o/9IN8XUlZdJJvYU0OsbGOCTC0FDakQTz/1wo87h4yLuRqgInKQQVR9Fw+
         zOYtF4tZ8pXZmigi+X5jo1nvOUMS5NPWiqXGH33BviAZiRMU1skRiJGsa3KESiM5vxNn
         eK2MDBkSs6KupaXJg3Jb9cNEZs0Td4BP6aa2ocYxKmEaBSe0Il0S5ZZcO2zSf7mD9YDA
         PSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759958882; x=1760563682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6D3EUCRhmhoMUd045LVIlT60xGnWKT3phek8gUNMDC4=;
        b=m3vPrQWr5LkJ1JzhE3ccbyL3+MDEXi3sKRxDid6Etv6JxlK77vJxLMO5p5+Cz3aee1
         vaUfdNMSuSw/akE2ZdfnlismragOkaD33lDdc1iTZ3TBTmcPNmJtvueRqFKiPjTMwOlS
         qpufoHBbcNNI9kpzc9jP7eUTJpnhz7WdVgjo1Z8YF4dzNiwYJZSBtx41tSuaLp04KjaA
         3jjAunV/mMpEWWa1yiay25IrG8NZUImmGgQvqwaqhiY3nlTJpPEJWYwgCM5x8psQDgAg
         GodmxmCFSCIc6u0vVvIrA5gwBqE2bL8PmYtZuisamtQf0ecFUoMfI3B/XLV8k5UXDSz3
         F/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEVdULk85jAsIYIlvMMfxZ5CSK2cOsxZ4r5Gb6MeBmIRXsuGrgJws7gR/685Nrr2CEwT18PvoY78Mdrdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZiuqCs/+VWSKiNlolzSuvtroqs3CrVLtZ0wDr47NqXo4z+2ly
	Cg6mCDXoEZO6kEzKwqoObMHIfS4B8dCARXd4lbSRynfkmOFtKhzyIR98MgAp+a2RDUg=
X-Gm-Gg: ASbGncvxsju9w9T3Se0Qfa2NV3mVVRcDz6JP16ipE2qI1iSKkVI6ws2tOXDKdRz+t1o
	uA4sZD4Z0lfGg9V8Aw7JnFRfncVKxAWSvGMl44fPVCR3y+A8S0vOcQvlBWn++oQbTlfGtD+Rndl
	D1w8GvU/3JcqAH2fdOwkAtxwuXZtKnbvn4+Y6QFhtxKOOEbVSJ9QVxAFjkx6FxO3uvGFRjx4U6H
	6Nwsyxj1BB+a1FmH97xCW+mGGAOOz0hCYHNEEDQEttnHqA3CiYmSXPtwPaP/ea37fc0MgnB0Rzv
	KAEZUKw8nMNi92d9EUhr9oSNaCDnYkmu6YKR0wlwFDUGGGzIpBzU2uqtUgVhhR8XoJQB/dJR3em
	+73a161WzMxQeVhtDhVEwo97stvy8hjAxEanQhhip5hBb87wDh84XRGn8ekGxOQYmN3/pTGYA71
	Y=
X-Google-Smtp-Source: AGHT+IFeqI/ZwivgLiNFVO4l3oOVEHmh6kuhLEznUX/5OJiNg1nVk/Ecd7EB2BNW+Jn42ULb498vFg==
X-Received: by 2002:a05:6000:2087:b0:3ee:1563:a78b with SMTP id ffacd0b85a97d-42667177dc7mr3205640f8f.20.1759958882005;
        Wed, 08 Oct 2025 14:28:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b63201d6996sm5644011a12.2.2025.10.08.14.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 14:28:01 -0700 (PDT)
Message-ID: <34156b7a-b8b4-4f0a-8379-f212951b8d57@suse.com>
Date: Thu, 9 Oct 2025 07:57:56 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tree-checker: Fix bounds check in
 check_inode_extref()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aOZ-inc8o7T63QHT@stanley.mountain>
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
In-Reply-To: <aOZ-inc8o7T63QHT@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/9 01:38, Dan Carpenter 写道:
> The parentheses for the unlikely() annotation were put in the wrong
> place so it means that the condition is basically never true and the
> bounds checking is skipped.
> 
> Fixes: aab9458b9f00 ("btrfs: tree-checker: add inode extref checks")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Nice catch.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/tree-checker.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ca30b15ea452..c10b4c242acf 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1797,7 +1797,7 @@ static int check_inode_extref(struct extent_buffer *leaf,
>   		struct btrfs_inode_extref *extref = (struct btrfs_inode_extref *)ptr;
>   		u16 namelen;
>   
> -		if (unlikely(ptr + sizeof(*extref)) > end) {
> +		if (unlikely(ptr + sizeof(*extref) > end)) {
>   			inode_ref_err(leaf, slot,
>   			"inode extref overflow, ptr %lu end %lu inode_extref size %zu",
>   				      ptr, end, sizeof(*extref));


