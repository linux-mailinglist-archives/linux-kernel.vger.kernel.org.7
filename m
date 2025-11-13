Return-Path: <linux-kernel+bounces-898519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3EC55741
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8423F3ABF17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA72FD1BF;
	Thu, 13 Nov 2025 02:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j1Tav42c"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A172FC880
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763001368; cv=none; b=aAFSDFfg33llkBVvwmHJBNBiX9Pa6Rby1nh87afmv0VS4OWLqbH2u/PcGI0ajn+TA4Wl+vxSmpIQls8thS1QcAe42GR5wqyBvRzayPRp3G+fAkXe1qMp7HKgRED/KbKl0Axdeh9Z+AAZbo6rD672ftdTW+hE1hm6feDX69Rphzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763001368; c=relaxed/simple;
	bh=f19DCM9aBD+9or5EhavKhA1i5pmAxjlwLhcKf363rqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sP51ULvPV2mfKc5LVfYgv0gBgI58h+lEBn7lHB1nRqm3O+gI9ZIZcAR9Lzw8f4GD8qVejGuYvyT/NcZefEdS9iTt/HFd8jZ6CMg9C+b3zx2j4ZRngwhF/LUBiCHUjLTDTcFdn8hJzfCTf91XD+CCM/wV/jGTHu/qVnsrccN6oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=j1Tav42c; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-431d65ad973so1316705ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1763001366; x=1763606166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU6W1sOwNniOpGHk04oKlDXcIE9zKrR6PDF1cQwJ0Ag=;
        b=j1Tav42cCtOxur+BMkVnqkQKZoIFShCEbJ5y2HcQp0Hs9hxGcSPVSTF8hKgvNx1qli
         285ebeJun5I+YcGJd5BNXSVI6MXNMf/YImReBdXslo+9XF4/U+Bpnsms94Eneyey6ad8
         98nQ/dar9izCVtfZLTCU4C1K7z816VKy4+osbZWZ1tmrQiSt795YaLDNUZ6h1wpcvl9z
         CSo+/2J29LivAnmE1pWeXj38g+pkid868XaE9cePOqyP/vb20JDDNCdSm5CztxPQ3mnP
         w7s/Bo4jEJ5tN1h8eKNR87Mbug59Y6GSgsnm//2vb95Vti8FCYG8Y+Pi7Emp10XmMtNG
         Uf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763001366; x=1763606166;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wU6W1sOwNniOpGHk04oKlDXcIE9zKrR6PDF1cQwJ0Ag=;
        b=KilNpiJzcPys+xfEu8TkgC2NMIbymiQgoTx2hUotLK9UkVTzEIlmQxRpIFZv6YnLcR
         PEHQ5RY6BO5kxeddgEVtASA6RiwKwZnqhsr69W7sEi29qNIWGuA6D5evOA2cshHigcYo
         c5HTpyv2BsCMSsLIAgMbHVCtBzDUVGnYrMoOsGz7BBA+BBug4iPairwwQYXfPdZ8HdSI
         DzOBlu1BASYCtDT/EhVxu0EqHgJBiR45kKG8n1Rkiw++HmdE9TWPqp0wIJTNo84pFWIu
         d6lACfqb6KEM5NQbYYkHNrqkxO+/4Ec1HQyPGJ06vGsn2L9HKfwRnXRPy3N7V7h0i8gb
         nXZw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXZThkGEgR+YOgyZkpSco/yLh30sp/T+uOglMvnzk8bpH5KaQGyVJPDWKIUUptPY5n6mW7TKbqaD9zwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRBQAauRysMmQO0ViZKfBC0WD3R4DQA/mAGNnKPQyXeWHO4E9
	XG3sNlRiDAjXMZEy8IVUiYwlH142/bI/s+oswvkHrt5VejxLqY8qPuohn1das1pfVxk=
X-Gm-Gg: ASbGnctWxLlMeDKDUe8LwL/KoHcQQYk5GaVsFR2ywSHlQm9szyNlQMAtEG0dU3uKCV8
	ycM1Xa7mgJHD5KtF6BWcTKrqIKjemUGpHxVCpnCXkHE+jlQPNOLb+8tpVYqG3GjFE8pxSLw8ifL
	3av9lQ329DS9dea3/rMEec5XWx3ah+KdI3qghwl04e8FgxvEIb42lPqX4IqpOn26rMAk7jL6N97
	sihJkZtBWw3kGXVSmAeGWcqWsoEgj9XHLEE2SCudQ70e05YpVsNclrw368iRxEXNME3igcLXNx/
	7zTGkFbnKI7rPPkvUvLPRPFV9T1vCzV2kC4G6uOemBBhYGfOnVaf8rxSnzCFHrW5r9eaDQJZLIL
	1mywhzfPEirgVwfnAjsfUTpUjSL0eF+Grd3JwtQfe4RIZ7FErI5ag8bq6I/TBBhuV/raxKhFJ+f
	ly/s/CpzNKOkjoHVRp
X-Google-Smtp-Source: AGHT+IGraeE/bIFHpoWCxTBowHF0q/OZirZ/vsZdNcApHxPGLPbWrFtEzHUR2rGHxEjy2kfVThP5Xg==
X-Received: by 2002:a92:ca0d:0:b0:433:330a:a572 with SMTP id e9e14a558f8ab-43473d52e46mr77508645ab.13.1763001365760;
        Wed, 12 Nov 2025 18:36:05 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26ff20sm267252173.23.2025.11.12.18.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:36:05 -0800 (PST)
Message-ID: <a6e7a571-91d2-4e66-bc86-ba30f624294b@sifive.com>
Date: Wed, 12 Nov 2025 20:36:03 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/22] checkpatch: Warn on page table access without
 accessors
To: Joe Perches <joe@perches.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc: devicetree@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Conor Dooley <conor@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Andy Whitcroft <apw@canonical.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
 <20251113014656.2605447-8-samuel.holland@sifive.com>
 <1dfa1e3566cafbe43a1d4753defef9c82ddb3b64.camel@perches.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <1dfa1e3566cafbe43a1d4753defef9c82ddb3b64.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-12 8:21 PM, Joe Perches wrote:
> On Wed, 2025-11-12 at 17:45 -0800, Samuel Holland wrote:
>> Architectures may have special rules for accessing the hardware page
>> tables (for example, atomicity/ordering requirements), so the generic MM
>> code provides the pXXp_get() and set_pXX() hooks for architectures to
>> implement. These accessor functions are often omitted where a raw
>> pointer dereference is believed to be safe (i.e. race-free). However,
>> RISC-V needs to use these hooks to rewrite the page table values at
>> read/write time on some platforms. A raw pointer dereference will no
>> longer produce the correct value on those platforms, so the generic code
>> must always use the accessor functions.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -7721,6 +7721,13 @@ sub process {
>>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\n$stat\n");
>>  			}
>>  		}
>> +
>> +# check for raw dereferences of hardware page table pointers
>> +		if ($realfile !~ m@^arch/@ &&
>> +		    $line =~ /(?<!pte_t |p[mu4g]d_t |izeof\()\*\(?(vmf(\.|->))?(pte|p[mu4g]d)p?\b/) {
>> +			WARN("PAGE_TABLE_ACCESSORS",
>> +			     "Use $3p_get()/set_$3() instead of dereferencing page table pointers\n" . $herecurr);
>> +		}
>>  	}
> 
> Seems like a lot of matches
> 
> $ git grep -P '(?<!pte_t |p[mu4g]d_t |izeof\()\*\(?(vmf(\.|->))?(pte|p[mu4g]d)p?\b' | \
>   grep -v '^arch/' | wc -l
> 766
> 
> Is this really appropriate?

Other patches in this series remove 277 of these matches. But it looks like a
couple of driver systems (iommu, dm) use variables that match this pattern as
well. Limiting the check to include/ and mm/ avoids the false positives.

> trivia:
> 
> izeof is really odd looking.  I'd prefer sizeof.

I agree, but my perl complains "Variable length lookbehind not implemented in
regex m/(?<!pte_t |p[mu4g]d_t |sizeof\()\*\(?(vmf(\.|->))?(pte|p[mu4g]d)p?\b/ at
scripts/checkpatch.pl line 7727." I could split this into two patterns, which
would also solve the false positives with multiple variable declarations.

Regards,
Samuel


