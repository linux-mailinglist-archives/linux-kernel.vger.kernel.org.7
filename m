Return-Path: <linux-kernel+bounces-840162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6BEBB3B82
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CC87A9638
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D830E842;
	Thu,  2 Oct 2025 11:10:17 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E925CC42
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403417; cv=none; b=ixD1i5iwbyheodAH7LRLDe1oeHwCvHKYSZRuNQmXqu1J99r0QAEiJTKrO0rYaRhzBvnfvd4CzZaWX79bwWLRk+LcAwA4GQIF/DSSX1GcPDT64FXbX/KQlzM8L7KHgJVgDGwgWJukkwB9PPg/gS0ZEyG2IZQDMgOOO77XKWC7Cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403417; c=relaxed/simple;
	bh=yTEDfHAsR2bu6GvQnXfNEOmxY+Ul1vJRWrNJ7p3zw5Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVRINiNK3ybJNvIEC8TJbzbWcpiWrjNJQbL91Ymd8okjGlMrUM/c2hPoSxQc4CobXfIvmwgzsd1d0oHE5w9xpRHl3LCo4r0zhimEObhqwtxlRYqpB7kE1RxIqDUoNyUOQ0N3DpFjkJoNCYY9LkYbw/UXINn2bwVqTgrqNmSsiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccpwc6Ycxz6L50S;
	Thu,  2 Oct 2025 19:09:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A705140278;
	Thu,  2 Oct 2025 19:10:13 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 12:10:11 +0100
Date: Thu, 2 Oct 2025 12:10:09 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shivank Garg <shivankg@amd.com>, <lorenzo.stoakes@oracle.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
	<willy@infradead.org>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<Liam.Howlett@oracle.com>, <vbabka@suse.cz>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <vkoul@kernel.org>,
	<lucas.demarchi@intel.com>, <rdunlap@infradead.org>, <jgg@ziepe.ca>,
	<kuba@kernel.org>, <justonli@chromium.org>, <ivecera@redhat.com>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <rientjes@google.com>,
	<Raghavendra.KodsaraThimmappa@amd.com>, <bharata@amd.com>,
	<alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>, <weixugc@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC V3 5/9] mm: add support for copy offload for folio
 Migration
Message-ID: <20251002121009.00005899@huawei.com>
In-Reply-To: <20250923174752.35701-6-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
	<20250923174752.35701-6-shivankg@amd.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 17:47:40 +0000
Shivank Garg <shivankg@amd.com> wrote:

> From: Mike Day <michael.day@amd.com>
> 
> Offload-Copy drivers should implement following functions to enable folio
> migration offloading:
> migrate_offc() - This function takes src and dst folios list undergoing

Trivial but I'd burn the characters to just spell out offc.
migrate_offload_copy() isn't exactly long.

> migration. It is responsible for transfer of page content between the
> src and dst folios.
> can_migrate_offc() - It performs necessary checks if offload copying
> migration is supported for the give src and dst folios.
> 
> Offload-Copy driver should include a mechanism to call start_offloading and
> stop_offloading for enabling and disabling migration offload respectively.
> 
> Signed-off-by: Mike Day <michael.day@amd.com>
> Co-developed-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Just a trivial comment inline.

Ultimately feels like more complexity will be needed to deal with
multiple providers of copying facilities being available, but I guess
this works for now.

Jonathan

> diff --git a/mm/migrate_offc.c b/mm/migrate_offc.c
> new file mode 100644
> index 000000000000..a6530658a3f7
> --- /dev/null
> +++ b/mm/migrate_offc.c
> @@ -0,0 +1,58 @@


> +
> +struct migrator migrator = {
> +	.name = "kernel",
> +	.migrate_offc = folios_mc_copy,
> +	.srcu_head.func = srcu_mig_cb,
> +	.owner = NULL,

No point in setting this to null explicitly unless intent
is to act as some sort of documentation.


> +};
> +
> +int start_offloading(struct migrator *m)
> +{
> +	int offloading = 0;
> +	int ret;
> +
> +	pr_info("starting migration offload by %s\n", m->name);
> +	ret = offc_update_migrator(m);
> +	if (ret < 0) {
> +		pr_err("failed to start migration offload by %s, err=%d\n",
> +		       m->name, ret);
> +		return ret;
> +	}
> +	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 1);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(start_offloading);
> +
> +int stop_offloading(void)
> +{
> +	int offloading = 1;
> +	int ret;
> +
> +	pr_info("stopping migration offload by %s\n", migrator.name);
> +	ret = offc_update_migrator(NULL);
> +	if (ret < 0) {
> +		pr_err("failed to stop migration offload by %s, err=%d\n",
> +		       migrator.name, ret);
> +		return ret;
> +	}
> +	atomic_try_cmpxchg(&dispatch_to_offc, &offloading, 0);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stop_offloading);


