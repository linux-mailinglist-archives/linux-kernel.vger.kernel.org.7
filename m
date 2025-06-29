Return-Path: <linux-kernel+bounces-708041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA56EAECB5B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 07:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60371898346
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AB31D9324;
	Sun, 29 Jun 2025 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RUE9yFMD"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409B18CC1C
	for <linux-kernel@vger.kernel.org>; Sun, 29 Jun 2025 05:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751173541; cv=none; b=gfZdi0KShMuCK4WWBtVGNrTJCRGY0y0+wJw9qaRLwGZdhCAlemmxacCUSb5rS5PZprc30u3FxEv+LXdayDM63L+79BnELdIfWDPlTm0nBlyiNNQ7ykXyZfJkkrVXR2iIU3X+XJHusabtrTPT+6KwujCGakfNVdxqQQU7c8y1aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751173541; c=relaxed/simple;
	bh=Ue/W5efR3ZUyfRDr877CJhtn/yC/o+yQhSbXgyHykvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5zfeSsTjV2Cuk3xF6pUXZ4KRg+9fwUYELdOdwR42vlYXKcZjEXUsPIEa/giZl5od4ZOCVKCZoNVgzeG6HLuHTvPZMkg0tOBXpi4ldbFL1UaUcs2bZfIS5Vq3h89wIrRoum9xusyAyw8D5sBfSwV/sNhV+6y+JthFsvGTpqUb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RUE9yFMD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so941100f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jun 2025 22:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751173537; x=1751778337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Yb5FHZt69bViccyG3ZRFxBOBsZOgDDUL9VQu65hjfpw=;
        b=RUE9yFMDNxgKuPNnRDWc8FTx7JueU4roitNDK64YOA1cyVNzB0tfcjBMf9Qhqhfd9d
         5FLQfb/BlQthbs1pDcREhV9pLXFZFzTN/30546LFMFmC64U/e3B/MevYtTJfUFRYmLCj
         Ufi+FbUqLatZE1c9tEjOrBOqcb3Fq/PayLP6GILunKFe6rh9PKDa4JW6GdpOsJISDqHW
         RhbI8VYNJzo+n+s2MnsM6VPOPU/ExrcN45vQOfYUQiZB/y58IeebfSdpqY+NSNsZrLWO
         QsvoCsz5NkVT/szFPUaphnsOGoDd1W2DJbP7lxypFXiwaojxvMB+EnKe97CDUOSIb53g
         aFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751173537; x=1751778337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb5FHZt69bViccyG3ZRFxBOBsZOgDDUL9VQu65hjfpw=;
        b=J9+1VbAqZnHs/owNNiR681feNdBJoFvunGn2DyE4+RRkKIl8BZ6aXRCggphc7UiLSR
         eC/HYh29zllUmS1wnRoxJUJVyVWINE24qRYUa2zmWYYl9TvSOGyEoUpySJeggSTpg2fl
         QFZdjAJ34vzlqxOOMpUFKnwKOxu9P7LDO4wXxvLWi5DySC2I75+7dssPXKv+ftEWKGy8
         0IjAzhEqmPwf8pxrHyAvugCbSt/u7abTgV8fGlVFszPzdXyiksj9mcHRqVd8SiL2ZmCK
         K5Mn54rjW7g25t5/YrK8qB2Q5dUoXjpnVbKfJ9Ku2xaa1vjWRh26+7tLw63a8Uxm0K2F
         NeZA==
X-Forwarded-Encrypted: i=1; AJvYcCUW52YQOuMieWsO+qhBZZK+GSRWNgNaVjMkFHvjpDNgP6M3qn3BRwJULmyljs++gtxR+Pr0TBTYKgACiSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fxzDtEn8KIdYWF6HLJ9PTVlgMcdCn3IR5HFZvkx/Hji42vjh
	p9nr9OALyHZ6LW93XE533eV+m6MTlPDhsFvpeoeql96pm6/yFvzxE/G9jfpS1PVx9Cw=
X-Gm-Gg: ASbGncspjLU7+2AkvdZj3z+/HevmdGBakKL3YsKMrDlmnrrZXXopbVzUWNj2TsMMYc/
	PUIFoVx0gs3reu8XJksRmif9CgMnHWIyAwXLgSzXIEO8OBjD8aFuetNrJJXAcfOAJKAjwGw/oFW
	7wRnlVqk5vUd4Z2khfqnNwCF0oEQefHnGtRWkHfPICsK3+5u+z7iWIUeZcTZorvZbYSjBnAzxUW
	8z55uFFYjKtJFAPKG80oowYl7tAWthjrS8Cj4UrRoTOuwDyX5I4to4CvhTf8ksQIISFNcu80JHS
	58I28WY6pIAFqPCxUQHy74NdoXAva2zfkrwLQz2mhlRRSKGJcCPuAqKSHOATKtkd5KU8ZoX0MwJ
	wxtgZ7J+u9yAaYg==
X-Google-Smtp-Source: AGHT+IFkOJ0/nDWij2eK2pF1W/YuodMCeD/ZrytP6UkIlm05Wh4VH0AchsgOMKw5nwR/Fe3NcMlR4w==
X-Received: by 2002:a05:6000:64c:b0:3a4:e75f:53f5 with SMTP id ffacd0b85a97d-3a8fee6504emr8092587f8f.35.1751173537192;
        Sat, 28 Jun 2025 22:05:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f467bsm5924382b3a.170.2025.06.28.22.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 22:05:36 -0700 (PDT)
Message-ID: <66c06601-94ff-47df-a951-157a1315aa99@suse.com>
Date: Sun, 29 Jun 2025 14:35:28 +0930
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] btrfs: fix deadlock in btrfs_read_chunk_tree
To: Hillf Danton <hdanton@sina.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
 syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com, clm@fb.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
 <tencent_C857B761776286CB137A836B096C03A34405@qq.com>
 <20250624235635.1661-1-hdanton@sina.com>
 <20250625124052.1778-1-hdanton@sina.com>
 <20250625234420.1798-1-hdanton@sina.com>
 <20250629050000.2069-1-hdanton@sina.com>
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
In-Reply-To: <20250629050000.2069-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/29 14:29, Hillf Danton 写道:
> On Sun, 29 Jun 2025 13:57:43 +0930 Qu Wenruo wrote:
>> 在 2025/6/26 09:14, Hillf Danton 写道:
>>> Fine, feel free to show us the Tested-by syzbot gave you.
>>>
>> Here you go:
>>
>> https://lore.kernel.org/linux-btrfs/685d3d4c.050a0220.2303ee.01ca.GAE@google.com/
>>
>> That's based on a branch with extra patches though.
>>
> Thanks, feel free to spin with the Tested-by tag added.
> 

Normally we only add reported-by/tested-by from syzbot when the 
offending commit is already upstreamed.

Since the series is only in linux-next, not even in btrfs for-next 
branch, I believe no tags will be added in this case.

Thanks,
Qu


