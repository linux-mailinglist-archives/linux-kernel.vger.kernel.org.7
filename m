Return-Path: <linux-kernel+bounces-754168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC74B18F36
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17E427A7053
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB119CC3D;
	Sat,  2 Aug 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DtamsdDx"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F732E36E9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754148918; cv=none; b=uh1iccWpQ6gyQj44YwYZgtyhZk7HVJV9Fqya8kjh4VPK0MFmlMvAjHra5lPxw8a4UPA//+8vonRsRv9hPUsjQsEJOKuBeyrvTxA9uHMSLBkcW4ywZgqXCxEsznMHi6ogf4MJZUwaMrwicwxdCC3OdzBqF2nMFL21MQHFsuDcG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754148918; c=relaxed/simple;
	bh=lc8w/Ym29qsFdEdq81lGaizNvY2MuTOR5ZDn8sD4U+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOPEb0i5HHuCRz0g26Mo3mmn5VcI+/dhwrF49v8nSFKNcXEhKOc+aOv/YtTq7LBw9qy43aTC3e+svHMmcYoP/WoJ0fFMYZD77swr9bCrUc8yir5jyOivM733MkhQ+fOGH8DfzxSxAztPCz6hfq1iOC3AlVA04KBqdYdEcrKJurM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DtamsdDx; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e3ff43383fso19920805ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754148915; x=1754753715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81Ijm86aL/7Eg8i2CREJKo2zaZRo19ClQ9+K+/XGJDY=;
        b=DtamsdDxpIpUu+/468Qkmsc0I8itMgs3E2BkFJPQmNH783TDxlKs9a7jkOb0nEeMVc
         kpHK0bRV3Yvsz31wua2Xevyaky+3Ld/8q8aaaZ6PT4LaEB4TCpHo076dJr1uQVWYaEvR
         mnIDE7Yb9bskDj6Wv/zBxGzZzNWuYhk73uz8ShTRWy4d7/Y5mmkfHWlgRKOXsC1pOGLP
         /tW0lq8jUv2yESYLLOirUWnZ2aLd3+hxJuNA6jA3EoIS7T/r3CumcJWj6Qn90lE6gTzJ
         HdLiQncLzJIoc2rsHZHzwcF96JzuYTPVsFj2n18ey2NJlveMPJ/oJKAcm+2VY+6EntxU
         y8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754148915; x=1754753715;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81Ijm86aL/7Eg8i2CREJKo2zaZRo19ClQ9+K+/XGJDY=;
        b=s4ZC24MwxeZR8jXWQit538ejYhtFGQ8oM0tPFF7IfAYJaHUBN++CofL8D7ZeaRWGDr
         9BCt7Yld6OgVZyYLIVLp6okov6WKJH0DgxfwQcPV9fYu5ZZOxDEiNJ5Rk8leAK5mxHIX
         oTWqNdWRHPNM5V1y/eV3FKNx35R5wLBt1N2ERxxvvO9z3IQLxzlag0hBEzxR51gjX0pD
         5yox/dqimf1/MCNpvu6DDrFs9PmvJh+k0hUYKSeQjsKQtGoq0iR6ahaXbqyStlSJ415m
         x+b8ZklERW5KNf5CGsFAVATuWcAEgFjatR48MB7X9lokyCqilvh16ZFIIxr6KtvyxX+2
         tfZA==
X-Forwarded-Encrypted: i=1; AJvYcCVd23eLPyRJAt/sSkgzfK79dXv/Br02V6arp07SiH6+g5alo9u1pSHrAsAoTkTPRy4T8zkCxI4yb0Ga304=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNqJAael2R0/4mYkMYO1m/QYkP2fkYc9beLDwHyRzfUhIBu3a
	ZXsLjOiGxKg/BxieoO0D+RPwDl1tdxxVhe1C0EIpYPgFwIDDB3/XtQM0hx7QqmFFPMA=
X-Gm-Gg: ASbGncuA+K+5sYk5AP4fJHpqzDhs1WVyhdTkPfn6zYZ2C5s+UbY8q4r2Ki8Tn7nhHwE
	ZVkV+c1Fu7+bOUSdGC6BpPTuJX9LBG1TJYJsXh0riNmYIhlb26Gob/Ro8M1Upwz6AfiH2REvoQA
	guJ/Pdxbl0QBGyKFRGlcqE7J+Ww2Zg4QeBynMgnpVyK2FuJ4Js5gLh2Bx4bizkwAFNrdcwyqtTH
	lgHlYfDBC81nKpHXQvx5JXS5pFQzUqfzhQCPAtm08ocEqyPgPv4NODsX8T1XHkOe+zU6X7bH8cB
	JzmBzOnFuVFSaU60cxzv2ensi+zxRhBoEL+ncurfPlLuU96IgQ8HgIu8sYhqxOJXEi3knV1PCdB
	h8nv9JiYNJlQdO6t+Qts=
X-Google-Smtp-Source: AGHT+IEzDMvKKG3HQnc6KQVfE3Sm8RA9MnEePBGjgtGWT3ISbraLvGrtT7nk5K+qI0TfYNvWTAxGAA==
X-Received: by 2002:a05:6e02:351e:b0:3e3:e4b2:8a5f with SMTP id e9e14a558f8ab-3e416116edamr65460525ab.8.1754148915061;
        Sat, 02 Aug 2025 08:35:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e40297c7dbsm25068145ab.7.2025.08.02.08.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 08:35:14 -0700 (PDT)
Message-ID: <e163bbcd-b4d7-4a76-a42f-950f3cb5a644@kernel.dk>
Date: Sat, 2 Aug 2025 09:35:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: f2fs supports uncached buffered I/O read
To: Chao Yu <chao@kernel.org>, hanqi <hanqi@vivo.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250725075310.1614614-1-hanqi@vivo.com>
 <d258ab6d-a97a-4232-bf90-5afedd5cccb2@kernel.org>
 <e1a1dbfe-165f-4cb3-9d5b-8ac4ba61265e@vivo.com>
 <087f7937-20b5-4151-8a3f-5b6b2b045b41@kernel.org>
 <b1cf56a6-d23d-40ca-acaa-07944140b1b5@vivo.com>
 <1b420389-d46b-48ef-aa49-585d84e2710f@kernel.dk>
 <68c061ad-cbb7-44e8-a905-c13b9ec81c62@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <68c061ad-cbb7-44e8-a905-c13b9ec81c62@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/25 8:35 PM, Chao Yu wrote:
> On 7/30/25 23:20, Jens Axboe wrote:
>> On 7/28/25 2:28 AM, hanqi wrote:
>>> ? 2025/7/28 16:07, Chao Yu ??:
>>>> On 7/28/25 16:03, hanqi wrote:
>>>>> ? 2025/7/28 15:38, Chao Yu ??:
>>>>>
>>>>>> On 7/25/25 15:53, Qi Han wrote:
>>>>>>> Jens has already completed the development of uncached buffered I/O
>>>>>>> in git [1], and in f2fs, uncached buffered I/O read can be enabled
>>>>>>> simply by setting the FOP_DONTCACHE flag in f2fs_file_operations.
>>>>>> IIUC, we may suffer lock issue when we call pwritev(.. ,RWF_DONTCACHE)?
>>>>>> as Jen mentioned in below path, right?
>>>>>>
>>>>>> soft-irq
>>>>>> - folio_end_writeback()
>>>>>>    - filemap_end_dropbehind_write()
>>>>>>     - filemap_end_dropbehind()
>>>>>>      - folio_unmap_invalidate()
>>>>>>       - lock i_lock
>>>>>>
>>>>>> Thanks,
>>>>> That's how I understand it.
>>>> So I guess we need to wait for the support RWF_DONTCACHE on write path, unless
>>>> you can walk around for write path in this patch.
>>>>
>>>> Thanks,
>>>
>>> I think the read and write paths can be submitted separately.
>>> Currently, uncached buffered I/O write requires setting the
>>> FGP_DONTCACHE flag when the filesystem allocates a folio. In
>>> f2fs, this is done in the following path:
>>>
>>> - write_begin
>>>  - f2fs_write_begin
>>>   - __filemap_get_folio
>>>   As I understand it, if we don't set the FGP_DONTCACHE flag here, this
>>> issue shouldn't occur.
>>
>> It won't cause an issue, but it also won't work in the sense that the
>> intent is that if the file system doesn't support DONTCACHE, it would
>> get errored at submission time. Your approach would just ignore the flag
>> for writes, rather than return -EOPNOTSUPP as would be expected.
> 
> Jens,
> 
> Do you mean like what we have done in kiocb_set_rw_flags()?
> 
> 	if (flags & RWF_DONTCACHE) {
> 		/* file system must support it */
> 		if (!(ki->ki_filp->f_op->fop_flags & FOP_DONTCACHE))
> 			return -EOPNOTSUPP;
> ...
> 	}
> 
> IIUC, it's better to have this in original patch, let me know if I'm
> missing something.

Right, that would certainly be required to have it functional on the
read side but not yet on the write side. Still leaves a weirder gap
where other file systems (like XFS and ext4) you can rely on if read or
write support is there, then the other direction is supported too. f2fs
would be the only one where the read side works, but you get -EOPNOTSUPP
on the write side.

Unless there's a rush on the read side for some reason, I think it'd be
better to have with setting FOP_DONTCACHE until the write side has been
completed too.

-- 
Jens Axboe

