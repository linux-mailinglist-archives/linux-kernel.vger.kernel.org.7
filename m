Return-Path: <linux-kernel+bounces-703096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A981DAE8B83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74CA7A247F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AAF283FD5;
	Wed, 25 Jun 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="wIv62U2M"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B651DF258
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750872711; cv=none; b=aCpwWTuAjJbR7TjGlZs0EiSQJRmLyj7i8sbEY7QHHmPiZDkecTdy3NQHKRNwd5VV3OeoLfDH6eEkqL89o1/j9YVIT6pjNMWIhczaq6ATJ70LzPijJvBGfpThEdnY7/AMHU4LUJ2b9yWqKDvaD40+pTYBZnlN/z35h+OAom+MNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750872711; c=relaxed/simple;
	bh=+oiM/jJKH9YwxBfMrhanQg/Z/mRGBVXx53Iyt5TqR9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7ihiCSP/K/LbMKr8Uwbm59Veppo0+G4VzwP6DowAHCQ2OvYzG62jqJa1pKonyWElCQ52rIPb2zQeaMaHEKZ0h1DGcFrB9KKhfmUnEBT/Jr6aELHtb5zhY+EB6K1mUDk/IuhjWVUz7R2B+jO99loc1pT68TojwYWvOgmntNfW7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=wIv62U2M; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id UCcWu69lQWuHKUTyKu4nVj; Wed, 25 Jun 2025 17:31:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id UTyIu8qXhYKhtUTyJuPmyc; Wed, 25 Jun 2025 17:31:43 +0000
X-Authority-Analysis: v=2.4 cv=TJ5DSUla c=1 sm=1 tr=0 ts=685c327f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=y7jUFFJD1EYPe7d4fIfORw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=BEqaKkcdS6MMFEc9jAMA:9 a=QEXdDO2ut3YA:10 a=xYX6OU9JNrHFPr8prv8u:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+I84/MI9zoV9OsiCK1atS49l1Bex64d49JeV33lBug8=; b=wIv62U2Mmt0hJA2iAd6m8+N3JU
	8PF7U9oJP3eyxnyFuhsHSdvk9Dm8iN83SezB/0pdsb4vTLL4Uf8JEGUj57qYQmHl450QGklqhMKX+
	bcNCUyQ+ZvZPzwsZTQuz5+cS7qFosnJ1RiXOcwCelfTbViREMEA3cB2N57yEWoKKg3jUktV8KmZn+
	p69NFE/kOFzjEKon4wlxPJN3tSAcl+P3soTW6+b9UCH9uuABSjLhg1fdRURMkHd6Euk/z0gZZzgWl
	261ebL5h6nV2vvvCd4RVMyDHELG1X/Vfd4fUBsa2VuFKui6WcwOqDzmBmRRYpDZOFYHXii3fgckjT
	goD3KpHw==;
Received: from [177.238.16.137] (port=54862 helo=[192.168.0.27])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1uUTyG-00000004FMY-3YIQ;
	Wed, 25 Jun 2025 12:31:40 -0500
Message-ID: <e0adad17-5d4f-4309-9975-81971597da65@embeddedor.com>
Date: Wed, 25 Jun 2025 11:31:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] acpi: nfit: intel: avoid multiple
 -Wflex-array-member-not-at-end warnings
To: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <aEneid7gdAZr1_kR@kspp> <202506250950.31C8A58E@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202506250950.31C8A58E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.16.137
X-Source-L: No
X-Exim-ID: 1uUTyG-00000004FMY-3YIQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.27]) [177.238.16.137]:54862
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOgPVoATmult34HAAD/P8KlqXu/6NHzdEVhUMq1L9B/Ebq3vm0v9UiYEuvdx8nK7lfOh3ty70sR0i8Xe0gjt42FBiwM71571yxUt4vxaGEEcHsrJ1okG
 DDg39EJTR0W0133453lpwTRieIRo0Sj7r5MLc+8G+24FbopJo1khymBGfjbUhR24i/t6fg+x6nhgAgo7oqHW/2GOl687D6ci8bto2UB0Kk7QrUF/0HT3Jd9m



On 25/06/25 10:56, Kees Cook wrote:
> On Wed, Jun 11, 2025 at 01:52:41PM -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Refactor multiple structs that contain flexible-array members in the
>> middle by replacing them with unions.
>>
>> These changes preserve the memory layout while effectively adjusting
>> it so that the flexible-array member is always treated as the last
>> member.
>>
>> With these changes, fix a dozen instances of the following type of
>> warning:
>>
>> drivers/acpi/nfit/intel.c:692:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v3:
>>   - Use union instead of DEFINE_RAW_FLEX().
> 
> I think your TRAILING_OVERLAP macro[1] is perfect here. I'll try to get that
> landed for the next rc. Can you double-check that this works correctly
> in these cases?

Absolutely. If people prefer that route I'm happy to wait for the helper to
land in linus' tree.

> 
>> @@ -55,9 +55,16 @@ static unsigned long intel_security_flags(struct nvdimm *nvdimm,
>>   {
>>   	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>   	unsigned long security_flags = 0;
>> -	struct {
>> +	/*
>> +	 * This effectively creates a union between the flexible-array member
>> +	 * and any members after _offset_to_fam.
>> +	 */
>> +	union {
>>   		struct nd_cmd_pkg pkg;
>> -		struct nd_intel_get_security_state cmd;
>> +		struct {
>> +			u8 _offset_to_fam[offsetof(struct nd_cmd_pkg, nd_payload)];
>> +			struct nd_intel_get_security_state cmd;
>> +		};
>>   	} nd_cmd = {
>>   		.pkg = {
>>   			.nd_command = NVDIMM_INTEL_GET_SECURITY_STATE,
> 
> I think it would be a pretty small and direct replacement:
> 
> 	TRAILING_OVERLAP(struct nd_cmd_pkg, pkg, nd_payload,
> 			 struct nd_intel_get_security_state cmd;
> 	) nd_cmd = {
> 		...

Yes, this works. Hopefully, maintainers will comment on this and let us
know what they prefer. :)

Thanks!
-Gustavo

> 
> -Kees
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/kspp&id=29bb79e9dbf1ba100125e39deb7147acd490903f
> 


