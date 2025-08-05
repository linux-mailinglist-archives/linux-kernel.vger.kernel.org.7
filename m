Return-Path: <linux-kernel+bounces-756768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AEB1B8FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A1F17F397
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA027EFFB;
	Tue,  5 Aug 2025 17:08:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C21922F5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413697; cv=none; b=D9Mknmo53a7E1uNXwnwO78bIdyXYX4viuCchtxpAtsHn3VoYoVXCd6iqGi3sNLELKebCxBxer24KkdRZ3f40mf6cqMY0d5UI8nb9/LkFf5E8+Ni/9vV3c/Bx8Hfe7Q4cMxR+JOCOxvto8FFcrH/QeiI4mxSzODYpVcNHIqu6RdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413697; c=relaxed/simple;
	bh=sXJ0P7NcCVKbTcl1fSfOuKfnP4+nvGVa4qIONOCi2oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1VxyELV7fHwXCo5fXlB9K4HekwKcZihdAauQmqWSiLaBI3IJbMRHmhoW0rFiZk8UGpBI+/3QJFhcGl7vU9D/BINVbDCuBkgNDeSVnR3TB2FFmiqKyhxp4sNm57+kZzVODBGLdkRhpf99/1kLFZ+Q5GEArXco56+MFau+hLEeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5CA150C;
	Tue,  5 Aug 2025 10:08:07 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 459CF3F673;
	Tue,  5 Aug 2025 10:08:11 -0700 (PDT)
Message-ID: <370d63d1-3ab9-4da5-bac1-29b4229df3bd@arm.com>
Date: Tue, 5 Aug 2025 18:08:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/36] ACPI / MPAM: Parse the MPAM table
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-11-james.morse@arm.com>
 <20250716180725.0000452d@huawei.com> <20250728110849.00004062@huawei.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <20250728110849.00004062@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 28/07/2025 11:08, Jonathan Cameron wrote:
>>> +static struct acpi_table_header *get_table(void)
>>> +{
>>> +	struct acpi_table_header *table;
>>> +	acpi_status status;
>>> +
>>> +	if (acpi_disabled || !system_supports_mpam())
>>> +		return NULL;
>>> +
>>> +	status = acpi_get_table(ACPI_SIG_MPAM, 0, &table);
>>> +	if (ACPI_FAILURE(status))
>>> +		return NULL;
>>> +
>>> +	if (table->revision != 1)
> 
> Missing an acpi_put_table()

Oops,


> I'm messing around with ACQUIRE() that is queued in the CXL tree
> for the coming merge window and noticed this.
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.17/cleanup-acquire

(not more C++!)


> Interestingly this is a new corner case where we want conditional locking
> style handling but with return_ptr() style handling. Maybe too much of a niche
> to bother with infrastructure.
> 
> Worth noting though that one layer up it is probably worth something like:
> 
> DEFINE_FREE(acpi_table_mpam, struct acpi_table_header *, if (_T) acpi_put_table(_T));
> 
> That enables nice clean code like:
> 
> 
> static int __init acpi_mpam_parse(void)
> {
> 	struct acpi_table_header *mpam = __free(acpi_table_mpam) = get_table();
> 
> 	if (!mpam)
> 		return 0;
> 
> 	return _parse_table;
> }

I've got bits of that from your PPTT suggestions. I ended up folding the get_table()
helper in here.

count_msc() gets the same treatment and the cleanup thing lets _count_msc() be folded into it.


Thanks,

James


> This series was big enough that I'm spinning a single 'suggested changes'
> patch on top of it that includes stuff like this.  Might take another day or so.
> 
> Jonathan


