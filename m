Return-Path: <linux-kernel+bounces-756767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39815B1B8F9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0745818A7082
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF7259CB1;
	Tue,  5 Aug 2025 17:07:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D091552FD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413673; cv=none; b=rgKch0G7lsYh+HWMoVJdKY6KEBxbZZc/hEdqnCiNz80R3rcctY2mSCoAqUM8rr5Y+xA2SwGELocW7W9O43dzaQhlVNKypjt/zoxMWqXgUkqLV6YP7JFq10E2neU2XHL4BXbEWzJPQuvXNjKNAY4meU2MEZZE4X1xTmAAFNoMiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413673; c=relaxed/simple;
	bh=rCa5FIXvXNeiaLXvBzZvCd+dqpppymyDLWKJoHvm9aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cykQ9EymSPRrJhLYCvpfvi7jrw32uNFWh9eYMBxTTzWmhwAZtYe33aYlAC3lFM9ttXYm/jZt+XQzLVGBh1t4SGK53avVOTmGaA8zZsMMjKezWFUWXzNlLW1zqEiHdhmCv2fj1M/oa4ysTyViutoqjN+rbOB39ARExEyC8iGWd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97C91150C;
	Tue,  5 Aug 2025 10:07:43 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A5AB3F673;
	Tue,  5 Aug 2025 10:07:43 -0700 (PDT)
Message-ID: <cd5c9b88-2864-4253-8a32-b7f3ac85e9d4@arm.com>
Date: Tue, 5 Aug 2025 18:07:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/36] ACPI / MPAM: Parse the MPAM table
To: Ben Horgan <ben.horgan@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
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
 <20250716180725.0000452d@huawei.com>
 <84e52287-e46a-40c3-90b7-ab7e9f2c7431@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <84e52287-e46a-40c3-90b7-ab7e9f2c7431@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 23/07/2025 17:39, Ben Horgan wrote:
> On 7/16/25 18:07, Jonathan Cameron wrote:
>> On Fri, 11 Jul 2025 18:36:22 +0000
>> James Morse <james.morse@arm.com> wrote:
>>
>>> Add code to parse the arm64 specific MPAM table, looking up the cache
>>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> Throw in a link to the spec perhaps?  Particularly useful to know which
>> version this was written against when reviewing it.

> As I comment below this code checks the table revision is 1 and so we can assume it was
> written against version 2 of the spec. As of Monday, there is a new version hot off the
> press,
> https://developer.arm.com/documentation/den0065/3-0bet/?lang=en which introduces an "MMIO
> size" field to allow for disabled nodes. This should be considered here to avoid
> advertising msc that aren't present.

Sure. Bit of an unfortunate race with the spec people there!

Added as:
--------------------%<--------------------
diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 9ff5a6df9f1b..d8c6224a76f8 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -202,6 +202,9 @@ static int __init _parse_table(struct acpi_table_header *table)
                if (tbl_msc->reserved || tbl_msc->reserved1 || tbl_msc->reserved2)
                        continue;

+               if (!tbl_msc->mmio_size)
+                       continue;
+
                if (decode_interface_type(tbl_msc, &iface))
                        continue;

@@ -290,7 +293,7 @@ static struct acpi_table_header *get_table(void)
        if (ACPI_FAILURE(status))
                return NULL;

-       if (table->revision != 1)
+       if (table->revision < 1)
                return NULL;

        return table;
@@ -321,6 +324,9 @@ static int _count_msc(struct acpi_table_header *table)
        table_end = (char *)table + table->length;

        while (table_offset < table_end) {
+               if (!tbl_msc->mmio_size)
+                       continue;
+
                if (tbl_msc->length < sizeof(*tbl_msc))
                        return -EINVAL;
--------------------%<--------------------

Amusingly, PCC also defines mmio_size==0 as disabled, so _count_msc() doesn't need to know
what kind of thing this is. In principle they could change this as its beta, but a zero
sized MSC should probably be treated as an error anyway.


Thanks,

James

