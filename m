Return-Path: <linux-kernel+bounces-708814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266EAED573
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 09:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A341897B82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AAA21A452;
	Mon, 30 Jun 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dw8jPdvu"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A851F237A
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268196; cv=none; b=ats02CZbIgAM6wBiT8529rSzn9aJCdjbq9LjBNVbZdcn+Xo9p9rw+xn//8XaP4B9VLMTNUYJ9PR7C2jXPpYWghLGhXBAp1vtDZOuGlCTqAejIRkD6CdREaCLwy9ttsf9dfxNbK5YJ+GgPXSUIoF6TY6x1KJyhnSoOv7xcCX3X9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268196; c=relaxed/simple;
	bh=L07bGvTxELmymjUxM2xQnfORKx4Enre4j/1hjyANcNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=buqh65Tkr/RgvZtX5lePlJs1Q9c9Kk9OPr6mbyIlpdZRbe9QZzxbRUhlUf2C1Q556BKJ8Zddr2YMvsNoan+cFpvSnQ+VCZGLxIIcnIvs3Tn2lBneWLbiNtUDYxCQxvrstasD5JPHwmijDrl1wAyfLOw1AN7lgKiDBi58Ja5QGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dw8jPdvu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso637471f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751268192; x=1751872992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LCsXT39Oa/3YIM7cSMzutIRPzrnIV3/KBT6ARtsZFuc=;
        b=Dw8jPdvuYp2J8i2WZVy0PIy0koh/Xa1rp79M6Y9sENGIAC/RqRPy8iLlBJ+vdMKAL7
         TlH4EyBJ/JcLI0Y1dAVInl3MjCvjO/GqATXn34aWHcSUzIDlACC843OvN/uz5tN0Z4tD
         dIF10lQryWwN8gtNXcD85dOKOLEg9amtP5m0tuOYbURLr0vmSSOm6KtxFHkPxCnCZ9xe
         RydhHBwWBcZVp/cSz5/ut3ZOxhxE3USbHYGeTfOaOATDFxsmODN+gxM88nBwWXD9zYU6
         yoFUOj8Hv5v5WMc7Lg0yryFlOR2iQloI5qOOtFhO5h5+TzR62wV3V7EDBLrSUd/06kbk
         epcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751268192; x=1751872992;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCsXT39Oa/3YIM7cSMzutIRPzrnIV3/KBT6ARtsZFuc=;
        b=JY5aifytOM5CBkbbnqMoR1WBYQCG4vpuNz0OJ6BWe3iVq0Vak80JsEFwZr6BhXeoiy
         Ms/4PGXOlYZH/PkRQqUjBzIcU2SovtGGkA88bpGjYdGzY3HmlQn2N5E9iTVw0IheVbeD
         p15Y/06oRsrlDlqgDMo3ehRI3tRvNlRG5+DzO91AkI9BaudvtYYiv5jOOaruEfP2zn9n
         VdlPu9ZhRq5NZniRyeZVR2/+Xjf1rVCjJaIInAFkdcXqb14Di5d+vcTFJ6gio0Rn3meq
         dthPBcJFDz+3GiLZN3ohXzfs0aBEgX153shW5rVMiY5Kztn7p6m4+xX7gUpY3pT/IlF1
         cGzw==
X-Forwarded-Encrypted: i=1; AJvYcCVa6hFPLxS3DFFHM7Qdke2olveuioU3aP8vXp3lIwfikDYJE6Q0eSQmktm13lhaHTYUWmcu+Xs1bXSvkAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8wntlUKiVMm2Viufy+NAVh2vVFm3v2m0g/Fg6adVjECaCDNU
	0yu0tk6Hpl2q3h5ZJkQ0Ns1/RNYazof4E7wb1JfOkDUli6bBUeaoTnho9Cj3nJ/8Pcg=
X-Gm-Gg: ASbGncv8ivSfdgjs/u/hcFA8MYG8ypyLhVqZ358baotpcpb6HVos+mPf5snIUm7EAWN
	l4rExVQnH0Ry339H/uzcAhNWROWojRi8LbYq0lmRQ4V1tAObCWA/xsATmxVzA9pfWkGbajRRa6u
	/uXycGBARo0iZGauVyjRLVRc2JWIQYFRZiCYNG+3dtmBneJVAIfvzW/1+S4fkmV7XUl/RCZZDW8
	EowwJhb+jEsI7wB0TAKr7CniA7Sp4bu76bPtcwoOIJ37DfJdDjS9+NEBn52jNFz8njHlXRxCybz
	c5G255vu3PehdjvvYizU2RfN/T+hyucsY96RJMELL5w+0UwNml98XEkps+S6QxrI+CeXQmZDFR/
	nPLw=
X-Google-Smtp-Source: AGHT+IG4eyyw2abepmK2ynnFXOiM0Oc0Y7o+zdGUgCtbUL2WGGA0BFKUPvEwrIEszUgqgCR7T2o42Q==
X-Received: by 2002:a5d:5cc9:0:b0:3a5:2ee8:ee1d with SMTP id ffacd0b85a97d-3aaf6189135mr1668010f8f.16.1751268192504;
        Mon, 30 Jun 2025 00:23:12 -0700 (PDT)
Received: from [10.202.112.30] ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e39f7sm75291535ad.49.2025.06.30.00.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 00:23:11 -0700 (PDT)
Message-ID: <d049aef6-4dc1-4a20-a8e3-306fd3e3b63a@suse.com>
Date: Mon, 30 Jun 2025 15:23:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Avoid NULL pointer dereference in
 dx_dir_lookup_rec()
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
 Ivan Pravdin <ipravdin.official@gmail.com>, mark@fasheh.com,
 jlbec@evilplan.org, ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: syzbot+20282c1b2184a857ac4c@syzkaller.appspotmail.com
References: <20250627023830.150291-1-ipravdin.official@gmail.com>
 <d6c72ab8-d600-4cc2-9609-8b749b61703d@linux.alibaba.com>
 <d6a11613-9763-4d9a-b4ad-5f451f770b70@suse.com>
 <a259f224-a471-45e3-84de-7071ec6595e9@linux.alibaba.com>
From: Heming Zhao <heming.zhao@suse.com>
Content-Language: en-US
In-Reply-To: <a259f224-a471-45e3-84de-7071ec6595e9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/25 14:58, Joseph Qi wrote:
> 
> 
> On 2025/6/30 10:32, Heming Zhao wrote:
>> On 6/30/25 09:26, Joseph Qi wrote:
>>> Hi,
>>>
>>>
>>> On 2025/6/27 10:38, Ivan Pravdin wrote:
>>>> When a directory entry is not found, ocfs2_dx_dir_lookup_rec() prints an
>>>> error message that unconditionally dereferences the 'rec' pointer.
>>>> However, if 'rec' is NULL, this leads to a NULL pointer dereference and
>>>> a kernel panic.
>>>>
>>>
>>> This looks possible, but syzbot reports slab-out-of-bounds Read in
>>> ocfs2_dx_dir_lookup_rec(), not NULL pointer dereference.
>>>
>>> So I think it is because it construct a malicious image and set a wrong
>>> l_recs, then access this damaged l_recs.
>>>
>>> Thanks,
>>> Joseph
>>
>> I think this proposed fix (at least the fix method) is acceptable.
> 
> But this seems different from the issue syzbot reports, right?
> https://lore.kernel.org/all/67483b75.050a0220.253251.007c.GAE@google.com/T/
> 
> Thanks,
> Joseph

OK, I think I may have found the problem. In the URL above,
there are two issues/reports:
1> From: syzbot @ 2024-11-28  9:44 UTC
2> From: syzbot @ 2025-03-09 11:40 UTC

Your review comments about report <1>; Ivan's patch is about report <2>.

And the dashboard shows the <2>:
- https://syzkaller.appspot.com/bug?extid=20282c1b2184a857ac4c

It seems syzbot changed the fuzz code and won't trigger issue <1>.

For issue <1>, the rec was an illegal value, and made KASAN report a bug.

> 
>> the crash occurs at ocfs2_error(), where the pointer 'rec' must be incorrect.
>> look back at the previous code lines:
>>          for (i = le16_to_cpu(el->l_next_free_rec) - 1; i >= 0; i--) {
>>                  rec = &el->l_recs[i];
>>
>>                  if (le32_to_cpu(rec->e_cpos) <= major_hash) {
>>                          found = 1;
>>                          break;
>>                  }
>>          }
>>
>> either 'el->l_next_free_rec' or 'el->l_recs[i]' has an incorrect value.
>> we can do nothing about this kind of error, simply returning errno to caller is sufficient.
>>
>> btw, ocfs2-tools has a similar function "static errcode_t ocfs2_dx_dir_lookup_rec()"@libocfs2/dir_indexed.c, which sets ret with OCFS2_ET_CORRUPT_EXTENT_BLOCK and return.
>>
> 
> 
> 


