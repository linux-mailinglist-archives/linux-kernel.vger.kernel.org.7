Return-Path: <linux-kernel+bounces-823299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA5B8612C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0C1C84DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B07A311C01;
	Thu, 18 Sep 2025 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Y6pdPutQ"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E621B9C8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213782; cv=none; b=SIaoLiu2GfBoCumpK2O1fKPU5AyNwyAZNWuKk+dDX4O8CyHg+p4NZQZ9Qho4u/6XyKSffZj+pEYU09g0JokWmNzaWhdDCqWdkUfVQMGMRkQv1b0X7QTiaSvziP0tYxYir9Mj4+LJf9xiMg7+LoGPyOpi5xaAzg+c3MjAziuLpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213782; c=relaxed/simple;
	bh=7smHhogxBfyhYoYf8mBOh8myJHhrKz49rA7ox7cE1d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiCLobTKnezD7m7Qz9DVC8kVLMSO0DcT1B8yZZLZOVKQaBPDW38Pp2H062iX0ktwUWqXP2H4J39jXLTirGXLd52jBDAW+PXdqm6yCkuVH6X+g/7Q44Yd01tvAZ0avqy82UYwvYA4JXXA/TIk0jQ5R08xAELdZGDzzoUfCaoxaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Y6pdPutQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58IFxXiI3010287;
	Thu, 18 Sep 2025 09:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=MRSW9PRf260/9Gt/pZkcfX+wCWrRuC4hgtYNOmdFk6E=; b=Y6pdPutQNUYI
	1C8YElettm7FxkgbNkPvwspxlu1INvT7ipj7MjnYKDKawHPwipzn8SJi+ILr3RqA
	ziVqa8rd/B4uSE18DHIZGtd6/yhHh/dAHZ0dLKSWWvJ+3rIRGJGqJhptF9Hrvt8Q
	SGYSM1BzpjgbrYtkm3E33uI1aBMvtMcvDx2e4Sz2dO7Vmm8kMqpoq66ZGYImaOhn
	S9iSrSc6o/DWoKwmBYgrz8dzhRkTTV25jenhk3McaBh1y/ZjRDWB9eEDziX6Auxv
	lTT6rDC0rATRyk4CUiKWpvhfmUKFfdlniLIkF+zI4juwb9sJPVRfH0arFTh9jOdY
	QK+J6UraMg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 498dekbkmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Sep 2025 09:42:31 -0700 (PDT)
Received: from devbig091.ldc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 18 Sep 2025 16:42:30 +0000
From: Chris Mason <clm@meta.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Chris Mason <clm@meta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <dri-devel@lists.freedesktop.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan
	<ziy@nvidia.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
	<rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price
	<gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        "Alistair
 Popple" <apopple@nvidia.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain
	<dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Ralph Campbell
	<rcampbell@nvidia.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?=
	<mpenttil@redhat.com>,
        Matthew Brost <matthew.brost@intel.com>,
        "Francois
 Dugast" <francois.dugast@intel.com>
Subject: Re: [v5 05/15] mm/migrate_device: handle partially mapped folios during collection
Date: Thu, 18 Sep 2025 09:42:07 -0700
Message-ID: <20250918164213.2866702-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250908000448.180088-6-balbirs@nvidia.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDE0NyBTYWx0ZWRfX09D5wzG1g1J0
 lpfwp5tRS1QFIV82x7ZEba60J34+rUhvgAyuPxfE+SQGFk5ZpkE4naGPpkpKhLO+pKSOqnNhtb/
 bQAsIfJD0XqLCzi5UHNKvl+lV2R+yonbyCdFwHNyrRK6Xt45aF6KiHJk6NYCBUOKMtsGOoX3U7x
 O39VaDjR228rh2VFFL7p+/+cYPDdVXpe54Eg7lOumaeNnoqh/Yt4wrU1xxvMM0XxJftw5tvIxVY
 QMIf6EJxoUgEs/twEE6S0A7t0Va1WRGzz3AJ70mC8f6hW0Uko16tgRmoObh8qaoP88F9elhu2p6
 Vocsd85DnZ1VDmsBb2XjQWTeAqteJwUOYq5RLveh2FHDCO1cgjIN+SRBq0F/zY=
X-Proofpoint-ORIG-GUID: j2nobX77OFnJOXWbfUlIfqTNJlMlS_Og
X-Authority-Analysis: v=2.4 cv=Od6YDgTY c=1 sm=1 tr=0 ts=68cc3678 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=Ikd4Dj_1AAAA:8 a=qDUe-vZ6ZZVRykDNhw8A:9
X-Proofpoint-GUID: j2nobX77OFnJOXWbfUlIfqTNJlMlS_Og
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01

On Mon,  8 Sep 2025 10:04:38 +1000 Balbir Singh <balbirs@nvidia.com> wrote:

> Extend migrate_vma_collect_pmd() to handle partially mapped large
> folios that require splitting before migration can proceed.
> 
> During PTE walk in the collection phase, if a large folio is only
> partially mapped in the migration range, it must be split to ensure
> the folio is correctly migrated.
> 
> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> ---
>  mm/migrate_device.c | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index abd9f6850db6..f45ef182287d 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -54,6 +54,53 @@ static int migrate_vma_collect_hole(unsigned long start,
>  	return 0;
>  }
>  
> +/**
> + * migrate_vma_split_folio() - Helper function to split a THP folio
> + * @folio: the folio to split
> + * @fault_page: struct page associated with the fault if any
> + *
> + * Returns 0 on success
> + */
> +static int migrate_vma_split_folio(struct folio *folio,
> +				   struct page *fault_page)
> +{
> +	int ret;
> +	struct folio *fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +	struct folio *new_fault_folio = NULL;
> +
> +	if (folio != fault_folio) {
> +		folio_get(folio);
> +		folio_lock(folio);
> +	}

Can fault_folio ever be non-null and different from folio? Apologies for
not knowing the lock ordering rules but this jumps out.

> +
> +	ret = split_folio(folio);
> +	if (ret) {
> +		if (folio != fault_folio) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +		}
> +		return ret;
> +	}
> +
> +	new_fault_folio = fault_page ? page_folio(fault_page) : NULL;
> +
> +	/*
> +	 * Ensure the lock is held on the correct
> +	 * folio after the split
> +	 */
> +	if (!new_fault_folio) {
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	} else if (folio != new_fault_folio) {
> +		folio_get(new_fault_folio);
> +		folio_lock(new_fault_folio);
> +		folio_unlock(folio);
> +		folio_put(folio);
> +	}

Same question here, do we need trylocks?

-chris

