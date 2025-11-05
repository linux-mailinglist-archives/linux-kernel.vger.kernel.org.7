Return-Path: <linux-kernel+bounces-886106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 173A8C34BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E49874FCF32
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E22C2FB62C;
	Wed,  5 Nov 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tk5fXqtT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AFD2F90C9
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334075; cv=none; b=rmIMJSxF2iPp2i4fzf4+9UeYWOdRaL4Rh8h6d02daLBi3TSiv6sJ37+X6E0GM1trOe2fKHK+0c/PU7CopWWj6z2c60hiTLCYPD0GSg34nVj8I1LNzKA4uCgNJCsX15b4LJ0RV+d7Hgh5AxVewxicwyheR8k9/VNQFPlAeYlLZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334075; c=relaxed/simple;
	bh=jKr1rGV4rgIjUCb1jumVH+bKGuwyxjg5hXXi6aiGi88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2YfhmZRyQRv1opmoOAud5pnecadHEwgmxNksId5mcuC+fppQcIg0U3oxOosDFhZPsARRs1J8qCFQDQ/pArxYFt6++rkrJvXWvS/LXz6I+47WTJtEO79FhWzcs1cRUcvLRt7ux0XCXuABQsJbkkZB+QNBb2VNb3F/AhooRvHadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tk5fXqtT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d402422c2so389434166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762334071; x=1762938871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jeoEzzS+NATU1AiVy+MYjoyYjfzwHEiduVCED9EMil8=;
        b=Tk5fXqtTMfvhqo6PMaVXmzdMSqF4YQRRAUm3HCATCdyJIquDWkyil5KYq40TutFErv
         L/SV51Nb5XQn2zgoe7HViweLJAp8Hj7gwUvK5GFYwKwb18pdX+vLPHik4flcJTbOiRqr
         Jpc733kNLVF1JTD2MnqA3dXbHfILnkCUvX+6sm8WJ128PV0D6r4wTC2i2vkz4NUGEc4d
         56S7Y1DbWhAGdJaFlmMDi3ibsLmjECuZtwX2RpkmjG5oI6gWYQsNgTPVUH2JyNZR+He5
         fopJVsTn5CA5sMNuttu42VH5RDMOdcOhUyda7SMIhczgHto9oO54MCOR/mkdvwT8Jo/p
         ko0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334071; x=1762938871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeoEzzS+NATU1AiVy+MYjoyYjfzwHEiduVCED9EMil8=;
        b=CZp/JWRXimMr9wRiR8ZVk2aQDvI/IiT1u3nOFIvUoUUAv6WiiKzwDSS23e/Vj3xSOt
         D9UnuADtcCIwbs1/VNbQ5SgptJtj2qEXSCNK2wbgUJI2qCHzKXbAzdfAWVNy963Z7BVg
         sxgOO/EHPDdP5EhAQ3pXVk9tgr3CsKO2aK25qI+fPyyhfOwdA3/FaMglrTbQrdVU6s9n
         rUWpURWxD7SKv3uPBW0cJCSwJN5SPMtrsyF2qTcxZd83ketkSESKXyynnHv1e4NMDccO
         aeDOkpAKajo5FzOL4/FLRd+AEumGLO0F0p+7V/igWFLiw10k5hUvT3MGl+w7/dXWqgCm
         ngaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM2NdhsuiAYFlYj1bVeKNCrQyUe3gbGkvMmx3D9K0Cm6oXnkGbMkKyTwT6ioiV3kV/OKJRtatvGTvvZNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOI3pey9PpLepuoJxS1rrqhBb4qweHeaNVkH5xl2GeHBGJEqU
	wSoRz24BN+gZ/8nMjCHE8CroiJg88oJ4C5KPIKeAscuhP3xoEf+h+qVmqix4ABHI+iU=
X-Gm-Gg: ASbGnct8Gje3vd+ubyrQ/YC+vBB4a3Lo958w3PIn4Js67YBWmOumE71YdIgScvpq4ZM
	mhPnFcwNbowZ0990mHl4ufqMVGkr+7v7JrVwuDhu1wuyFuAyLNkrPLo5U7BmoNPVezc4ftJ5V3P
	P0Kjq/kxeeR6/ymGZ8yeKK57TamRBaDjzcvgfFzkAkMbODiPFVrGywdiuFO94RvCSNl8+M4/HiO
	4/fThzSeBmlyBr9uV5bUtTDtvVKCGG/QFYxALOIg/5pKZ0pLPEoq0FrxQq/q7X446OjFv/mBvON
	SVVQvrcVqWIlcSvtQdEaft6IoEjagX8UwJu4ohgOuQSsnguNjri45SsjIpIW/I9pIqaguE5i358
	ZMzeK/JD6l6dMszYXgchKUJ6ycpCq7lS90tNhvEPMvmln8TJUwwfAJ+YcsWUAvVubT7y4SWpE0U
	BxW45avOMl1NNDFay6VlOcQPRW/5vz
X-Google-Smtp-Source: AGHT+IGPSpGbGi5CTwXbJ9njpmQ6nj0G/4Pf35m44cY/AqKJokN1oC23P9uAmuDjc7gnyRJnKlHQug==
X-Received: by 2002:a17:907:720e:b0:b65:dafc:cd0a with SMTP id a640c23a62f3a-b72655cde5amr209742766b.52.1762334070811;
        Wed, 05 Nov 2025 01:14:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a69d91sm53105955ad.95.2025.11.05.01.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:14:30 -0800 (PST)
Message-ID: <a794be48-90a3-4a6b-8cf5-d063f52fdd2f@suse.com>
Date: Wed, 5 Nov 2025 19:44:25 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix memory leak in
 data_reloc_print_warning_inode()
To: Zilin Guan <zilin@seu.edu.cn>, clm@fb.com
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20251105023722.1820102-1-zilin@seu.edu.cn>
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
In-Reply-To: <20251105023722.1820102-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/5 13:07, Zilin Guan 写道:
> data_reloc_print_warning_inode() calls btrfs_get_fs_root() to obtain
> local_root, but fails to release its reference when paths_from_inode()
> returns an error. This causes a potential memory leak.
> 
> Add a missing btrfs_put_root() call in the error path to properly
> decrease the reference count of local_root.
> 
> Fixes: b9a9a85059cde ("btrfs: output affected files when relocation fails")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Now merged into for-next branch.

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3df5f36185a0..6282911e536f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -177,8 +177,10 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>   		return ret;
>   	}
>   	ret = paths_from_inode(inum, ipath);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		btrfs_put_root(local_root);
>   		goto err;
> +	}
>   
>   	/*
>   	 * We deliberately ignore the bit ipath might have been too small to


