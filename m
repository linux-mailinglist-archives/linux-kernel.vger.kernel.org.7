Return-Path: <linux-kernel+bounces-746127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE713B12378
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF557166E48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA4623D2A3;
	Fri, 25 Jul 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A35Jc9w8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87514EEAB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466598; cv=none; b=avPRZhdfg34G3HaKFBXxuA383641aYhebc4WoSCp+8pPt1YgF7z6nlWfezssrODK5s33sTPjDzjdGXcpwKikEikTj4bs2OKU/iUGC02B9//9sBDiiDF3t1x3FRz4mJQ7FPCb0+yLw3cpIVSqlyP3cRcdrngZL7fH4yHXPnuIuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466598; c=relaxed/simple;
	bh=algYI/Js5KLsUwkz6o17cjJlXXRzud6fmYUSg4kKXwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLwaXhYjza6kbcHNzV0b90Y+WeanmVAtmM+EkKG4XYsgOFpWQgaPDXuhB1hSa9Q9Sin6eXeDOk2u51MTOmnDrMijbI7qJS4iAIOwKEQLAGsVWGRgDpSQzl8PnBXRdxOTwdPgNGVcvHGuQ8zuSzOcppwlL9gAPoKzyZrcCiVeb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A35Jc9w8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753466595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=m1A1XdrpKswvqDLqRwvvl2q/mzdhe8nMBmqHzzSNW3Y=;
	b=A35Jc9w8+5KA/Ct224gpFpYhv6N4PUx0tadfb5PzV25/TpZpHZ0RxqLFxAjMDoFAj+5FxT
	CXiWq6QKMcUp8rmFMZ797fLvz79GCOhFoqxUTX4BYwKHpO7diQYn/PH8q5NneZWDkb1znW
	OTvZVW2WfyhtpAKzcsdLUZmG44Hh8Hs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-Fa12eyQXPuCKrwcH2oPwAQ-1; Fri, 25 Jul 2025 14:03:13 -0400
X-MC-Unique: Fa12eyQXPuCKrwcH2oPwAQ-1
X-Mimecast-MFC-AGG-ID: Fa12eyQXPuCKrwcH2oPwAQ_1753466592
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso14047785e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466592; x=1754071392;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m1A1XdrpKswvqDLqRwvvl2q/mzdhe8nMBmqHzzSNW3Y=;
        b=kOOzmUNeghGbbga/TpC1co7ajTcAi7gPdBPVBSVv0C8GxQcps84iqIvC3Adu2fbNy/
         qDI7ouZEKm9I/MUW4G9NV/R2vlMUF76Bwh+3gMGfKT8T+sPmLFqS5Nnf7kmahGaB9wlZ
         BTHkwbgnjubAwSR1bSYjvaA9W/ahVPHMO4T4eo0M8bSiI3HuZxtgD/NZA3cz0SaIIuHn
         GJbyMWggkLWfnr03qXVHRdik7D9KuHwWW3J357oLCpPnaVhCDJUcnrhtZbKYsJpawHY5
         9hguYLoMMiioWfVhBPlMR9RC+HAgZfI0hUU4IABksG/8mFx19kOhVRJuu+1LLQat52TF
         W+vw==
X-Forwarded-Encrypted: i=1; AJvYcCWjTXpW9QlrZsZdUtfSL+kS8xpTRJ5QR86BBmOWwDbe+vby2aAH8knkG4Qddq4O44Clj0Q8XPFoO46uOx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGn8aKu46UYlbPl2FxHsg6ElSG0j1HFgc/rq6i4GS0xeO2g8/
	ZYH8APCgVqldPflo5BAckvnocULb5t8zDGp7t1TaIP+SUHe0d/wDZsEu9FTAV8fD4FNIctQU80Q
	dXl3D8jJnJA4Np2TFJWjSDD513Kgvm9Iw+JyNz+CgLqdeUfjxGZeQKYWz/n6DgrmxMA==
X-Gm-Gg: ASbGnctr+gqul8iwEORkBv0Giv37WfWyQujzweaCGAq7rgYcnzmL6k13NGn0YCV0cf/
	Z4KoA5Q9eDTJTsXPIytdJtqKDwrLh6O+EMZ1s+WPdLc9c7yNPKtW4U/cfy+N8t6xK05VmlK/fta
	9SsEhSEO+FTaOIq97UAHeif6ilw4WY3CNg71HMJurkM4bzZ55w2kEaRiaGXDxhQwi4DE3aSFekg
	h4IbG3p8Eq2R6X2/hZbpSNIbttvcKkEE9KZrA76rF4aQEZIFMEkxwloTsDBZsfEfz0vG2K5zL4q
	fmB0xO4VOHT1Y6vP1rBHbiRJjRTAYEkIt4E1EjlocaccjUjbWzDD+z7z+KLpUZZIwj/etlM45Tr
	1kdxwSJcKPKA3rsaTSJnKba7fSC4IzFTeY7ssb3BHzdVyF60EWW3nARghS9b2RX3K
X-Received: by 2002:a05:600c:12d4:b0:456:23e7:2568 with SMTP id 5b1f17b1804b1-45870580784mr45205955e9.13.1753466592369;
        Fri, 25 Jul 2025 11:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0emwjXKmT752G3twyQEVU2y3mXUVE5sfgxlQvTVcJZVNMgLqr4pAAogO1mHgwG4QpZo+CcA==
X-Received: by 2002:a05:600c:12d4:b0:456:23e7:2568 with SMTP id 5b1f17b1804b1-45870580784mr45205645e9.13.1753466591936;
        Fri, 25 Jul 2025 11:03:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f36:e800:2f2e:cb5:13f6:f884? (p200300d82f36e8002f2e0cb513f6f884.dip0.t-ipconnect.de. [2003:d8:2f36:e800:2f2e:cb5:13f6:f884])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586f88cfe3sm41356975e9.0.2025.07.25.11.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 11:03:11 -0700 (PDT)
Message-ID: <d546df23-70df-47a2-9211-2bb971f8834b@redhat.com>
Date: Fri, 25 Jul 2025 20:03:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add missing headers to mempory policy &
 migration section
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
References: <20250725175616.2397031-1-joshua.hahnjy@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250725175616.2397031-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 19:56, Joshua Hahn wrote:
> These two files currently do not belong to any section.
> The memory policy & migration section seems to be a good home for them!
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8bebd0886df..dec8db8b5cc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15838,7 +15838,9 @@ S:	Maintained
>   W:	http://www.linux-mm.org
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>   F:	include/linux/mempolicy.h
> +F:	include/uapi/linux/mempolicy.h

That one is already on that secion on the mm/mm-new branch

>   F:	include/linux/migrate.h
> +F:	include/linux/migrate_mode.h

Yeah, that one is missing.

Can you rebase to mm/mm-new? Thanks!

-- 
Cheers,

David / dhildenb


