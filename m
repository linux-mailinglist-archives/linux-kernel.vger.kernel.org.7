Return-Path: <linux-kernel+bounces-852714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE95BD9B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61F75189122B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06932304BC5;
	Tue, 14 Oct 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKtOK6D+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC17B2FC881
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448072; cv=none; b=GqnJKOhlRxIiFuWgc1GXXpXcm1x4JG4wdpOVyvykvNj35tubhxOoqCg0Sa2xNdTlQIqKPFUoo5DHxDCQb77+hqux4Y5UWHkxh75aqpSGa9so2ix61jwkPiTkUrtc6YzsaU6V2CtiNSP2dlj/1iHnal0DUMiCO0oj8oLmUibKjHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448072; c=relaxed/simple;
	bh=dwlM0r1x41mCovJ0Qg9vjNNsJ/ik6stihf/fX5U/0ug=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hubpfv7Ixk+Yq1L6uZO6wOKA1KqQlYy32jBsMlgVNuuUPsGXqO4UHADHM4U2wQK9EgEkT0AlMaZD1TgBVEs1HhkCD8g7qvL3oX1alxsNQGfJaqEOWKm2VLLKlyTpfostxICiIoyOvpeiy88SQXLS0yQvarapWYkMHg2IPM8U1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKtOK6D+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760448070; x=1791984070;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dwlM0r1x41mCovJ0Qg9vjNNsJ/ik6stihf/fX5U/0ug=;
  b=EKtOK6D+6YUjAOI1hGTdnhFDzTQ7disVpLbn9R80tvDkdG7ssCSJKDp8
   ZGWO8qIdovnVVF3/qjcmMc0Bcisu8TJK1cm3R3S69Q78qK/AeYCJ9LH+Z
   GD9X7q6iYo6scn+lOZ/aXG+NMwPZGAHyopzCiPPWF3nzkOR5ucAacHTcQ
   eMg2WHNzfQsBVFhTcvjC7NmDyhu70VMADs5VODhRwnogaR6dT9/veBE6r
   oVTIkp80TrjZL3CBLhFVMqrs9BH59CbnDM4XKnoUQgT28XapMnByOWxhO
   ahtFCOkbBrWIq5iidK2dTfaTyx4awBvwWrT9+RtQOF6H0sIUWRFsOJyoH
   g==;
X-CSE-ConnectionGUID: /DP/qxzfTW669nyiLFOH6g==
X-CSE-MsgGUID: Uy70Me+HTLK/q9oGAHdc7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="65229223"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="65229223"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:21:10 -0700
X-CSE-ConnectionGUID: rSzo43+EStWT1L4l4EAH/w==
X-CSE-MsgGUID: f9t6ltQrTiCtilvRv734JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="182343602"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.236.114]) ([10.124.236.114])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 06:21:03 -0700
Message-ID: <a1883b7d-b5f9-419b-ba51-735a977522d9@linux.intel.com>
Date: Tue, 14 Oct 2025 21:21:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev, security@kernel.org,
 x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] Fix stale IOTLB entries for kernel address space
To: Dave Hansen <dave.hansen@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Matthew Wilcox <willy@infradead.org>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <c04d4c9d-e868-4883-af92-26f142bc84be@intel.com>
 <d3cf3716-98ec-419b-90b7-b91b83599498@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d3cf3716-98ec-419b-90b7-b91b83599498@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/2025 3:42 AM, Dave Hansen wrote:
> I wondered why no mm folks were commenting on this. linux-mm@ was cc'd,
> but the_people_ on cc seem to have been almost all IOMMU and x86 folks.
> so I added a few mm folks...
> 
> On 9/25/25 13:24, Dave Hansen wrote:
>> On 9/18/25 22:39, Lu Baolu wrote:
>>> This solution introduces a deferred freeing mechanism for kernel page
>>> table pages, which provides a safe window to notify the IOMMU to
>>> invalidate its caches before the page is reused.
>> I think all the activity has died down and I everyone seems happy enough
>> with how this looks. Right?
>>
>> So is this something we should prod Andrew to take through the mm tree,
>> or is it x86-specific enough it should go through tip?
> Hi Folks! We've got a bug fix here that has impact on x86, mm, and IOMMU
> code. I know I've talked with a few of you about this along the way, but
> it's really thin on mm reviews, probably because mm folks haven't been
> cc'd. Any eyeballs on it would be appreciated!
> 
> It seems like it should_probably_ go through the mm tree, although I'm
> happy to send it through tip if folks disagree.

Thank you all for the review comments. I have updated this series with a
new version and posted it here, with the mm folks cc'ed:

https://lore.kernel.org/linux-iommu/20251014130437.1090448-1-baolu.lu@linux.intel.com/

Thanks,
baolu

