Return-Path: <linux-kernel+bounces-898990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E63C56867
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80C444E7C08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0356729E0E5;
	Thu, 13 Nov 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmvv58qq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C65286A4;
	Thu, 13 Nov 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024689; cv=none; b=giEQZ4i7uRpnTXRJM7q67rdI76p/hwQv6SNid14DQmh8X+MBAe7GA1ctMSDHATylrdJXltbHW+4uMuIERMpwwNU5KKqsIIR0+Q5NY0FpJ4827U6L7vjLMevJnHRZHZdrSjyq+p+JI1WZU4DjwbPXbfmyywkOZZPjVN+dHAusxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024689; c=relaxed/simple;
	bh=g2ApyTbvFn+O4SPpXvNk6aXSXJ9xS0/6+BQ/w0ijal0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPqp+q98DaSqnd0BeLdcHfudF5fDmxtT3aY4pFk3jngXXPjWCRCZim7SOxyV7l3RoBUV3VO7B+LRIkf9lwPQejrkYDEDLu8noOi9h2eYWn7d8sHZJHNVCDMUxEdL4HECZMvjDL2BiHnzFIcFxh9JkxJUzgJxOn1ZVrR9UekGmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmvv58qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C15DC4CEFB;
	Thu, 13 Nov 2025 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763024688;
	bh=g2ApyTbvFn+O4SPpXvNk6aXSXJ9xS0/6+BQ/w0ijal0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cmvv58qqtEpaPmX3c+SScMrcSzaga0Px1RP5KQeXSey4+8xsMlLqfGCnhbrKKZW/7
	 1x1IZ5xh793XC0Qc6GHi023xk+rgYW18Lr0xRCEBskq9ppRl11XNfacbYg18/w3gFp
	 07YVZ1tcjj6/ehzVskFNjBsUZu82L7XE4m3p3DBARMCShxXawh7Z0cBzj7YN0zDcv9
	 Bs+OsfW8jBuu2hv6YWt6955Q+Fs5eIUKQu0ykTlRVZno4XKwbXRJNuKGVGz7tl4FIG
	 u1+Wc4NMhVn96vKl45u/9MW2eIjXsajCrvLfmQ1fBWAuBhqprSdMtCwp4TOaNaDvto
	 4iQF6JIsdz51g==
Message-ID: <a786cb49-43f6-408e-af32-f05dabff36f5@kernel.org>
Date: Thu, 13 Nov 2025 10:04:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [mm/huge_memory] adfb6609c6: xfstests.xfs.050.fail
To: kernel test robot <oliver.sang@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Lance Yang
 <lance.yang@linux.dev>, Beleswar Padhi <b-padhi@ti.com>,
 Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
 Aishwarya TCV <aishwarya.tcv@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org, Jan Polensky <japo@linux.ibm.com>
References: <202511131537.1a31ee77-lkp@intel.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <202511131537.1a31ee77-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.25 09:23, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "xfstests.xfs.050.fail" on:
> 
> commit: adfb6609c6809e107ded9a1cd46f519c882e64ea ("mm/huge_memory: initialise the tags of the huge zero folio")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master 24172e0d79900908cf5ebf366600616d29c9b417]
> [test failed on linux-next/master 2666975a8905776d306bee01c5d98a0395bda1c9]

Fix is in the works, discussed here:

https://lkml.kernel.org/r/20251108191948.684586-1-japo@linux.ibm.com

-- 
Cheers

David

