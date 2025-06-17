Return-Path: <linux-kernel+bounces-690500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBC3ADD259
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D375517D8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3371E8332;
	Tue, 17 Jun 2025 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0wh0vPi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBA2ECD22
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750174886; cv=none; b=g30kcKQbxhc+DiVvbw6e3aOlj+kJziAqyxjCovm1U28Z2W2mUK5ZZ5/FrZhv1ZqEZJ577C5a2g0cjYdwh3okgBAP2oSyVDtHa+dy2SDpZ7HFbN+CkBHzsNqBQOIwgil30PwB8yEmububEvnonNMrwQV6XaRpMheojw0cl9IXVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750174886; c=relaxed/simple;
	bh=YEaWsZ0wi7V0Mecrq5nmKoKbpvyYouj783eYF+zdy80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+9vGVOPNfVTtmz8VKD0ivVqL+l5G+sMSH69bFJDvugjqz2/rfP0qbwon9dL3WHJjwIF80Y4Q+A96Gux4a5U0tOotGRq4UjShafX5kzJlVPjmzWGNMKynXDgNigMKw6R6pCjL744YxTgNiNWHYGecbXhTOkQ0Xd1F4OqgDFHfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V0wh0vPi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so73620865e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750174883; x=1750779683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEyoVi/uOGo/A3hwmraEWtZd9MgKdLDFA01pXxqB4cI=;
        b=V0wh0vPiCMbZIRnsSmqIYnHCmDCT1fVFfOUX0ij/1zZvZEWm+2NV0bIvtEhVlNzXSX
         kT+j0D6zN7KmIqj69+B3iRPZNsOzG23AhiPIIVe5Jt5EXQwUo8TbbWJaaJi1oAhjDD4w
         aJ8ofwOhcdslW8rqbfllfsLrDbSvPJgUdUziF6oVwn39mWsQss8cDTcfhJ/gmNyLYfrT
         5ucix6dtkrJX7SmjK3+tCC7Mp8xOvq136rGbQ3LFvX5jkHyXM3slHWzGn9Geba3ImoGQ
         AuPSI1l5FNikCCdRz/oQPjCdJ/95QjSYrALzj7PmUGBSbYz+PWYUQSpjPwIpgEG3LhtQ
         K18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750174883; x=1750779683;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEyoVi/uOGo/A3hwmraEWtZd9MgKdLDFA01pXxqB4cI=;
        b=FUvGD2x97qDRxIXdOSaB8YeKnVB4/YxU7Ww/zanAhyDTO9rmybYDWqjdK0RQxJwPuh
         g3ab2b/nxYvPSpLHzaMjRzyN8pumld7+rscMCSIHBB0RiicsmReiRiZCsi4MD0lbiMr5
         cGaZr3ubZhZrPhb/Fb07h9BPw3FyV35XrnjfxfhEOY97ZaYlfPr7punpjhGMPX/IQVSS
         7Ei9yds8gcVc211vK2U/8NCjUg8JggW4WXejQNur6PAZ8Q2eZ2TiXAGMpeTggpDz9uLN
         S3jTbllYJ4z5Jm9eB2ybKfCNYXR9gWuqEbg2TdRubCKSECqpzuLOLp32z+V079MAWEC0
         tPpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNiV2Og1m7TSYDUcaMm4rrn9izikw/dz9Y45SPMO8Bs0JjlEzZpBf9rBN6k80g4rRjvIeL4m4sdu7Ge1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZthEsadEQ+vB2ULLG8dd20sT2NYg4nZbrKx1Wnzxg/DtWsvvS
	QFKHB4NJHZT2d35XMbDtGkliesf6zMfha42WGzyzYM7oNef513KrahDOVRI3R2QoIv9TSZoh6Hh
	AsvDIQHIssw==
X-Gm-Gg: ASbGncuf6squ3flXp4VZjQDKPyAEal/Oacxdz0pbUmC82G6G+LxjF+oNSI4oLIiu+yb
	IZlvTblowBwhhyE6vYNCJk38EuXE0AfGVSsvrlDZdVO+TpoJmAGjGv8Qv+TyzX9SHKJHP1zPZ+m
	FyUBxmMD7OFC4NVXQsATQwie0eLjrafFRoZdy3tVaMCTvlH4U5Xnt7PY93srXJKJ5vNFjS7FaM9
	y1ne+lsHYArXVic5akXhjqPMVRLc9WNSgNADLi4lWXRgLR8gyIb47H3qUi098jcGnuo1dkosbdo
	i7jNkwZ0vN+Fh3pklUKtllL/Hx6uKA7qh2fDQ6UGm8CRzJyykQ2mA+cqptYobV5KIg==
X-Google-Smtp-Source: AGHT+IEamICd2vufiU+uPyME8Ge0sakIyA0pSNU6/lqNJ/Z9dPqn3+6rpt7i4Y3hevVN4H/gRpO5wg==
X-Received: by 2002:a05:600c:3513:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-4533ca464a9mr135611535e9.6.1750174883104;
        Tue, 17 Jun 2025 08:41:23 -0700 (PDT)
Received: from [10.100.51.209] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e254396sm184091565e9.28.2025.06.17.08.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 08:41:22 -0700 (PDT)
Message-ID: <2c277bfe-3086-4007-bf04-ef229e6cbfb7@suse.com>
Date: Tue, 17 Jun 2025 17:41:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] module: Fix memory deallocation on error path in
 move_module()
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250607161823.409691-1-petr.pavlu@suse.com>
 <20250607161823.409691-2-petr.pavlu@suse.com>
 <ae967353-71fa-4438-a84b-8f7e2815f485@kernel.org>
 <c7dbb33d-98b6-45da-be77-e86b9e6787ee@suse.com>
 <7cf40cd1-fe0d-4493-ac15-e70c418e54a5@kernel.org>
 <97f26140-bf53-4c4d-bf63-2dd353a3ec85@suse.com>
 <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <732dedee-c7c5-4226-ad87-f4c2311b11b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 11:47 AM, Daniel Gomez wrote:
>> Do you mean the following, or something else:
>>
>> static int move_module(struct module *mod, struct load_info *info)
>> {
>> 	int i;
>> 	enum mod_mem_type t = MOD_MEM_NUM_TYPES;
>> 	int ret;
>> 	bool codetag_section_found = false;
>>
>> 	for_each_mod_mem_type(type) {
>> 		if (!mod->mem[type].size) {
>> 			mod->mem[type].base = NULL;
>> 			continue;
>> 		}
>>
>> 		ret = module_memory_alloc(mod, type);
>> 		if (ret) {
>> 			t = type;
>> 			goto out_err;
>> 		}
>> 	}
>>
>> 	[...]
>> }
>>
> 
> Yes, that's it. From your patch, moving MOD_MEM_NUM_TYPE assigment to the
> initialization and use the while() loop suggested later on.

Ok.

> 
> One thing though, we are "releasing" the memory even if we have skipped the
> allocation in the first place. So, I think it would make sense to release only
> for the types we have actually allocated. What do you think?

I noticed this too, specifically because move_module() is inconsistent
in this regard with free_mod_mem(). The latter function contains:

if (mod_mem->size)
	module_memory_free(mod, type);

However, my preference is actually to update free_mod_mem() and remove
the check. The function module_memory_free() should be a no-op if
mod->base is NULL, similarly to how calling free(NULL) is a no-op.

-- 
Thanks,
Petr

