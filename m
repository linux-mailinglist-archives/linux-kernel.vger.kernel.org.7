Return-Path: <linux-kernel+bounces-684280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE666AD788C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABF61746A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0929B77B;
	Thu, 12 Jun 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnUpXXZp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03D10E5;
	Thu, 12 Jun 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747398; cv=none; b=XGKJOh7FF/gUwRR7A/c8ZT7jackrMjxUcZ17gH/EyOp9jNv67LHqOvsoup7ztlikTaqiX+dx9jnnOaLPvlZcO78lHzWvbA1t6jwfJmGCjpxshPbwpM13W6ftCaqW71clZIclQ4e6iH2d5m/YF99ZUa+gRSD+GEKUkxVfs4IXfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747398; c=relaxed/simple;
	bh=8Ye67YnjttyTwFTBHI+RLSlHPDRdNz234kvp3fp5Y9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u10EE370Od5Q0ZYNDXetaI77CQGIphy6w/fEQMWhAexEsY101uEYZZmTx2NB281Qg5ule+W984z51p1WxEEQfqWQi6j+7AMAE7EuMPbBFCwm/PN2lcAr3nhQbwKIIDvCfuYy9cahelm8nJzV0okuhZNz7UQMLCzwDWkXKf1ylKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnUpXXZp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749747397; x=1781283397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Ye67YnjttyTwFTBHI+RLSlHPDRdNz234kvp3fp5Y9M=;
  b=TnUpXXZpdFiZZhF+4UXGq3hxk1eRm/34eTtKsyBc6oNm99yXQtFzaeUC
   FrXfplTJgH70k0mRtRsB0U788kq87zmTU1+wlorUSv4lhSG2uDGq4nnLu
   +p0kaJ+Tb3Xe0uxTcUxHDT6jFPcW6DHIlCBg8U+YCGRC3pho1eWiOicSk
   GWseOsyM8B9IwUCehv2lw9Gj9Zj9+CxSMqDz64XvS0yz+KWrEhf5HPdKJ
   LiQUxvG8BSdb5WmqluR1nHZ/dQUixuRlXBifzJnP+SC6vuzciZRt0HE21
   342rbys55+VyM/7O7NuaXu1Vc95GbGF8uf26pJCH8QwQ48I2ZIN+Mlk6P
   A==;
X-CSE-ConnectionGUID: THhNqup4QlSCCRicfyZf3g==
X-CSE-MsgGUID: 8D0RYl9QTfuMK/qA86vccQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52039761"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="52039761"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:56:36 -0700
X-CSE-ConnectionGUID: IEi61bqhR3G9Riiy6tUyzw==
X-CSE-MsgGUID: 3V8D+rDbRz6duGbQpO2V6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152483191"
Received: from dannysua-mobl.amr.corp.intel.com (HELO [10.125.98.185]) ([10.125.98.185])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 09:56:35 -0700
Message-ID: <22b3158d-565d-450b-809a-af302220bcf4@linux.intel.com>
Date: Thu, 12 Jun 2025 09:56:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/huge_memory: vmf_insert_folio_*() and
 vmf_insert_pfn_pud() fixes
To: David Hildenbrand <david@redhat.com>,
 Dan Williams <dan.j.williams@intel.com>, Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Oscar Salvador <osalvador@suse.de>
References: <20250611120654.545963-1-david@redhat.com>
 <lpfprux2x34qjgpuk6ufvuq4akzolt3gwn5t4hmfakxcqakgqy@ciiwnsoqsl6j>
 <684a5594eb21d_2491100de@dwillia2-xfh.jf.intel.com.notmuch>
 <990ce9cf-0e48-432c-a29f-0bd1704eede4@redhat.com>
 <e11ba418-4184-4f4f-add5-18a5edaa0f34@redhat.com>
Content-Language: en-GB
From: Marc Herbert <marc.herbert@linux.intel.com>
In-Reply-To: <e11ba418-4184-4f4f-add5-18a5edaa0f34@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



>>>>> I spent too much time trying to get the ndctl tests mentioned by Dan
>>>>> running (.config tweaks, memmap= setup, ... ), without getting them to
>>>>> pass even without these patches. Some SKIP, some FAIL, some sometimes
>>>>> suddenly SKIP on first invocation, ... instructions unclear or the tests
>>>>> are shaky. This is how far I got:
>>>>
>>>> FWIW I had a similar experience, although I eventually got the FAIL cases below
>>>> to pass. I forget exactly what I needed to tweak for that though :-/
>>>
>>> Add Marc who has been working to clean the documentation up to solve the
>>> reproducibility problem with standing up new environments to run these
>>> tests.
>>
>> I was about to send some doc improvements myself, but I didn't manage to
>> get the tests running in the first place ... even after trying hard :)
>>


>>> http://lore.kernel.org/20250521002640.1700283-1-marc.herbert@linux.intel.com
>>>
>>
>> I think I have CONFIG_XFS_FS=m (instead of y) and CONFIG_DAX=y (instead
>> of =m), and CONFIG_NFIT_SECURITY_DEBUG not set (instead of =y).
>>
>> Let me try with these settings adjusted.
> 
> Yeah, no. Unfortunately doesn't make it work with my debug config. Maybe with the
> defconfig as raised by Marc it would do ... maybe will try that later.

After a lot of trial and error to get them right, these fragments have always
worked for me:

make defconfig ARCH=x86_64
./scripts/kconfig/merge_config.sh .config ../run_qemu/.github/workflows/*.cfg

Warning: there is a CONFIG_DRM=n in there to save a lot of compilation
time.  Nothing against DRM specifically; it's just the best "value" for
a single line change :-)


The run_qemu/.github/workflows/*.cfg fragments are mostly duplicated
from ndctl.git/README.md - but unlike the latter, they're
machine-readable and testable. The CXL fragment is actually tested in 
run_qemu's CI (CI = the only way not to bitrot).
https://github.com/pmem/run_qemu/actions

As I wrote in
https://lore.kernel.org/linux-cxl/aed71134-1029-4b88-ab20-8dfa527a7438@linux.intel.com/
these fragments should ideally live in ndctl.git/, not in run_qemu.git/
(the latter could still add tweaks). Then ndctl.git/README.md could just
refer to the testable fragments instead of inlining them. "Send patches"
they say :-)


