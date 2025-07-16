Return-Path: <linux-kernel+bounces-733901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C95FB07A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB363AFFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F8A291C3B;
	Wed, 16 Jul 2025 15:51:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747C18C31
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681116; cv=none; b=KmSscFsViiCyoxDIhLJmFEnQ/TekRGFoDstWVbDUUdSuEht7csaI3cHC2Y5p8VBF1fN20rSiJkk1yHy+KQCfhJqsDCqcd9QFuLnLdaE69ElU5R1UnmoWKWDfyu/m5fbyGhoLo16FV32Iyuvb8YwUnjwuZ6wmzpddhOQUefZFKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681116; c=relaxed/simple;
	bh=kgoN0NIdQy8Ar5SkTkM0vtuIw1gfYA2TnRXxLCNg4WU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpPI/IkuGLZx1//gHaw7TApq7gvp8EMlLV+NAmRxgcuIj82xhNC1WntVs/AONQ7MqZZdUBDGTTp4DYYpMOSVM8PpKmkPbpo3IzFIzoNnlGg/8lg6QGfLzYqrzRmw6ZChnt8yzZjuQKyYNdn52072vwgP+0LIVRhIMdbKZSxfA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bj0rP208dz6GDPD;
	Wed, 16 Jul 2025 23:50:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DE746140276;
	Wed, 16 Jul 2025 23:51:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 17:51:43 +0200
Date: Wed, 16 Jul 2025 16:51:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	"Rob Herring" <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>, Rohit
 Mathew <rohit.mathew@arm.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	"Zeng Heng" <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
	"Carl Worth" <carl@os.amperecomputing.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <lcherian@marvell.com>,
	<bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
	<baolin.wang@linux.alibaba.com>, Jamie Iles <quic_jiles@quicinc.com>, Xin Hao
	<xhao@linux.alibaba.com>, <peternewman@google.com>, <dfustini@baylibre.com>,
	<amitsinght@marvell.com>, David Hildenbrand <david@redhat.com>, Rex Nie
	<rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>, Koba Ko
	<kobak@nvidia.com>, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 06/36] ACPI / PPTT: Stop acpi_count_levels()
 expecting callers to clear levels
Message-ID: <20250716165142.00002c46@huawei.com>
In-Reply-To: <20250711183648.30766-7-james.morse@arm.com>
References: <20250711183648.30766-1-james.morse@arm.com>
	<20250711183648.30766-7-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 18:36:18 +0000
James Morse <james.morse@arm.com> wrote:

> acpi_count_levels() passes the number of levels back via a pointer argument.
> It also passes this to acpi_find_cache_level() as the starting_level, and
> preserves this value as it walks up the cpu_node tree counting the levels.
> 
> The only caller acpi_get_cache_info() happens to have already initialised
> levels to zero, which acpi_count_levels() depends on to get the correct
> result.
> 
> Explicitly zero the levels variable, so the count always starts at zero.
> This saves any additional callers having to work out they need to do this.

Hi James,

This is all a bit fiddly as we now end up with that initialized in various
different places. Perhaps simpler to have acpi_count_levels() return the
number of levels rather than void. Then return number of levels rather
than 0 on success from acpi_get_cache_info(). Negative error codes used
for failure just like now.

That would leave only a local variable in acpi_count_levels being
initialized to 0 and passed to acpi_find_cache_level() before being
returned when the loop terminates.

I think that sequence then makes it such that we can't fail to
initialize it at without the compiler noticing and screaming.

Requires a few changes from if (ret) to if (ret < 0) at callers
of acpi_get_cache_info() but looks simple (says the person who
hasn't actually coded it!)

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 13619b1b821b..13ca2eee3b98 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -183,7 +183,7 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   * @cpu_node: processor node we wish to count caches for
>   * @levels: Number of levels if success.
>   * @split_levels:	Number of split cache levels (data/instruction) if
> - *			success. Can by NULL.
> + *			success. Can be NULL.

Grumpy reviewer hat.  Unrelated cleanup up - good to have but not in this patch where
it's a distraction.

>   *
>   * Given a processor node containing a processing unit, walk into it and count
>   * how many levels exist solely for it, and then walk up each level until we hit
> @@ -196,6 +196,8 @@ static void acpi_count_levels(struct acpi_table_header *table_hdr,
>  			      struct acpi_pptt_processor *cpu_node,
>  			      unsigned int *levels, unsigned int *split_levels)
>  {
> +	*levels = 0;
> +
>  	do {
>  		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
>  		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);


