Return-Path: <linux-kernel+bounces-734120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5CB07D50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18319586668
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D0273805;
	Wed, 16 Jul 2025 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="Qx+/aa81"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9D1BD01D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752692491; cv=none; b=sGdtEpdA2hEUntdm09so/AYX9Y+Fus12ZoyoEI2/PcZlTKF1/dLxy4Ezyk9oihF36KrVetsNcU0NSxfAw00mBndb4DMztF4rT5y9cZi2L2JbLNIsfCUWLhZ/pv1vAm12f5koAx5zPk8t4/WdUxdML0cSYJZ4h7Z4AsVHQq83ers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752692491; c=relaxed/simple;
	bh=hoN8NBFqslNrJ1cgRO5bb89uChr9c2ucc6Y5E6scZYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7ijsQCKvLz9xt+0gKrOhZHYbujPSrTzvNzkn97oG7VSOBSe9nihc1MTv6D291O9ClRmupk9lTtUy79HvAhJjKwFhUz/ru65NvJjdXXM9HOiSpA/8sJK9/5rhnZMBr/RKU5XX40PFbXvPtOctFvCP/pogOSMrhPeVffIBW7cSfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=Qx+/aa81; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso35657466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1752692488; x=1753297288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=76sqhAyNFYqdF73JxY5ePEl9Cv/zf+qN3iFWyzE9Y3Y=;
        b=Qx+/aa81yquY67/4rmfvkW/MwAuCZR4HH1Lsymv0moPoH0CL4ySr1PDgutl/+tbsDS
         0T+olHbbR9dI4meUf+h8+/LPvavYvg4wL0k/ooXQYi85yfHbNizuLERlPDwrxeozewZD
         gWmsnaH+0mwHZL3iKf2rrBxroudz4iUS6xNM0EzPWHVBLtMBHASMgOyLsQSU0S4KCwhG
         LmuHxSHgVKl/jcfjAgM2r07nEZaUafC5HkCCJebWUnlpdqbgAbQIV3EH12Q5vYmCVOEH
         C5X7fqlLTUWndjIlnCa4ecM4zT+hV2jZPk1ea7pjMLiuvra08dcIrs/PJHyTbT5oBoI4
         qlew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752692488; x=1753297288;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76sqhAyNFYqdF73JxY5ePEl9Cv/zf+qN3iFWyzE9Y3Y=;
        b=ZrN66tM7aEoXt3hRcMG3q/44k45Ca7fHpe6pzkpgw+11vxwb3VkH+bMHAgQy2qYeYN
         8ZrlGDB0gvS37E6Q6tphQyOFzPDcdmk5mRC5vLcVeOAwe/CXcy+Xk5WWRShDSMfqVpR3
         c/+Wuc9o804Cx0y/wvBjYisyHqHyLQlQCrMSKcUQCImWmDLUvTp5wArItCmtlU9K2Dsn
         OrkND7haGsENYbMLe2dvsE9F2KgOPrwTnNUlbm+ZJM8GNtb1MIpIubT2QJf0TlIN/zTs
         U6FJEHJj2/i02juEyIIhCrK5SrnTO5GWAGMy8UzdzlLiZ8mF2kINICr8RrwgsRp4oYfJ
         3OmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRo+9UIXY1F8oibJv6ibcNu3dlzvfm/OuVdsvdX6o9szf+MAJFpwdB5DYfB8y+6jsuZtSac3hCWl3xv6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJh9ddN14T6FtJsUCtHFyLWSdCPFn0ssIT2JYeyuqBc/iYgSFH
	fqd1dIErGRbR0N4vc7r1LwazfwbnyLX73648W3WQdCdoqvwGrw2e8LfpQ3DUaQmmNek=
X-Gm-Gg: ASbGncvWPONMDoY3pf3gFXykNBYdFt9nHgimh68TPE/ePgwHloGEltUHTFzSvZ/UnTU
	o78iIP5QqGp8SjFef8GOoOZ3HIhEfLRbvIBWJbIjlPX9IaXp7Do91QPMMXDaH6jjBOdFH3dMgIL
	e9/nGzGK2XJaZgn0/lCExj4XjrchvqSfTkr2KtsR2xpVY3kXwIc+9SrNJtHns4Vyf5OLWDXIicI
	NTTK1A0qXKwRqrRL5Ud4YY4MDcVXA6NwbpeU77y4qZXuZ0DYps4zRXcIhBGwPUclSDoHB1wyynV
	bpaXYqBdBPAv8MDmee8EE8jNPxw7D62R/OKr/BvKyBc3kSDqBGVyu9npbkimmHSHDcMJkkS0VOj
	Lu4PON3JfSXq+KvopvZh2+OJ/aUX0Ui+xKhWcHr6Wts/IfMlF6qzlLsMnlwtchBxUPrL2e55+iA
	==
X-Google-Smtp-Source: AGHT+IG/7zXy+NKaEVeJIavvKHpoCy0YHi50u41CHESuStxDEGvMbVvxZCHhuiJ0eKDneko+qzn4Zw==
X-Received: by 2002:a17:907:d48f:b0:ae0:bb16:1cb3 with SMTP id a640c23a62f3a-ae9ce19f15emr376969066b.51.1752692487582;
        Wed, 16 Jul 2025 12:01:27 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a864:eb02:add4:d64a? ([2001:67c:2fbc:1:a864:eb02:add4:d64a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910e8sm1235904466b.36.2025.07.16.12.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:01:26 -0700 (PDT)
Message-ID: <bec0d00b-1284-4d45-bd42-f3089898ff3f@mandelbit.com>
Date: Wed, 16 Jul 2025 21:01:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, linux-mm@kvack.org, David Hildenbrand
 <david@redhat.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250716171112.3666150-1-ziy@nvidia.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <20250716171112.3666150-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2025 19:11, Zi Yan wrote:
> Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
> every time the code is modified, because they do not understand that
> mapping cannot be NULL when a folio is in page cache in the code.
> Refactor the code to make it explicit.
> 
> No functional change is intended.
> 
> [1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
> [2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
> [3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Much easier to grasp - Thanks a lot!

I am sure Coverity will be happy too at this point, because the 
ambiguity has been fully removed.

In a previous email you asked me how to prevent Coverity from 
complaining about certain code: my thinking is fully aligned with Dan's 
reply. IMHO refactoring the code was the best choice - thanks again.

Regards,

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


