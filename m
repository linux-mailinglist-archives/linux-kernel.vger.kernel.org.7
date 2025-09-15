Return-Path: <linux-kernel+bounces-817039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAD5B57CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1ACC3A814A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326D2C027C;
	Mon, 15 Sep 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ecdJyacU"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C33031282E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942726; cv=none; b=gqfBg1/GdBVP1FCkmXM0kPnO7Nh+OjSDVPyaYeJjBsRpbZSseYKm0fuJTnLKPMMTsD+mskSsV/VTwU0cHY1ICvT31PwFNkGrA1Y96cQ4hDrcQ8Cywn22QzhrWjGOlKjNBP489+VG9jta1vl6mkri/0CUypQQHpdlfhrp48AKWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942726; c=relaxed/simple;
	bh=Lh3Ewj+eaiZ27SQgPdOvdafuhktnqtBuhs6NGQHfhA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY1mKOeEry0D8+3HF+reMV8sU67UUDi82N4HKSCSngPpYr9mndV3VHW6tVHtow9VmFbUDxhrt0L+qagmMSQVpSO39E6DsfUHYKCImypJvH24USbSZU9m5B7vR45RXy6JuL4ms01p8AR6qzwQYZBfhQnJVMji+/Q5pHPsVqMFXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ecdJyacU; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58FBYXl01285418
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:25:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+OeUW4b0iTtQSlBksBON64DALPlRhQHDwWoPGx/RrlI=; b=ecdJyacUIINV
	ZyhlyY01Dnd0GhvqwNEvWMBpYKGM3FQe1wLbjJDeKgog4pbwzQBG91o7+1k8F41z
	a8UKFkE55IZtdvJj5GCziUaWFTwT3gdZwYivO6Svem88ujafjTUKBHf8x8qsNxvj
	PdpjdGL4BhkBuzLpFYB9AhrdjV52VduTtcgsgM89Blx8YE9AGi0sL0WxELPVhIi1
	9INSJe2mHYhQBt4lv8l2HIQ/mIE0cSQ8UMRIZVhT8O9g9QYqMk/CTx3cLYqnyEPe
	TDyaBBy67BIjhp4wpLskcHTxMzVffFL+A5owFKibfECjjSsi3IydrVx90MANXO4U
	uZAlnbZNnw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 496j1u0mvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:25:23 -0700 (PDT)
Received: from twshared14631.07.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Mon, 15 Sep 2025 13:25:22 +0000
Received: by devbig091.ldc1.facebook.com (Postfix, from userid 8731)
	id A040325C3EE4; Mon, 15 Sep 2025 06:25:09 -0700 (PDT)
From: Chris Mason <clm@meta.com>
To: <liuqiqi@kylinos.cn>
CC: Chris Mason <clm@meta.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm:fix duplicate accounting of free pages in should_reclaim_retry()
Date: Mon, 15 Sep 2025 06:25:02 -0700
Message-ID: <20250915132506.2889372-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=SZz3duRu c=1 sm=1 tr=0 ts=68c813c3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=yJojWOMRYYMA:10 a=IEEH_mcYg3zSNz_hGwYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDEyNyBTYWx0ZWRfX883ZHwOx8+bT
 FSUlUXs4+GC137KnA0/a+OTUEmh/x4Nscws4yzr8cex2dMEMRxX8pjhOD72CCNUKiY0J4i//5+g
 npWf947Yj58HdJP1cFBZfQmwBTRvRBzqDEa9RjV5ZykrPqPu2hElf57X0H28HtdTKrjYgWz/Cf6
 s5uazE/LYCtUGR9ifnjSlsskkFdY8swDwLlTBS1DoRaEopf+vpsuOzSz0etR5dcZg1KNqq0zxiv
 ywNTl7xem8pmYtaa7F3s+/d8SyvHimN3WDuo5MTg2nbsr/1utrt22nOZdljNINhEMUK32rlulKv
 /X2deW8xJWfDhBMoxQLA6ZsQkwRiceV6ihDQCoijyKMb+BcWAHfXWF7ae21Hco=
X-Proofpoint-ORIG-GUID: WECyw4VzVCM8cB7t9r5tQYddSuUsoIxO
X-Proofpoint-GUID: WECyw4VzVCM8cB7t9r5tQYddSuUsoIxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01

On Tue, 12 Aug 2025 15:02:10 +0800 liuqiqi@kylinos.cn wrote:

> From: liuqiqi <liuqiqi@kylinos.cn>
>=20
> In the zone_reclaimable_pages() function, if the page counts for
> NR_ZONE_INACTIVE_FILE, NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON,
> and NR_ZONE_ACTIVE_ANON are all zero,
> the function returns the number of free pages as the result.
>=20
> In this case, when should_reclaim_retry() calculates reclaimable pages,
> it will inadvertently double-count the free pages in its accounting.
>=20
> static inline bool
> should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>                      struct alloc_context *ac, int alloc_flags,
>                      bool did_some_progress, int *no_progress_loops)
> {
>         ...
>                 available =3D reclaimable =3D zone_reclaimable_pages(zo=
ne);
>                 available +=3D zone_page_state_snapshot(zone, NR_FREE_P=
AGES);
>=20
> Signed-off-by: liuqiqi <liuqiqi@kylinos.cn>
> ---
>  mm/vmscan.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 34410d24dc15..a9aaefdba7a2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -393,14 +393,7 @@ unsigned long zone_reclaimable_pages(struct zone *=
zone)
>  	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>  		nr +=3D zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>  			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> -	/*
> -	 * If there are no reclaimable file-backed or anonymous pages,
> -	 * ensure zones with sufficient free pages are not skipped.
> -	 * This prevents zones like DMA32 from being ignored in reclaim
> -	 * scenarios where they can still help alleviate memory pressure.
> -	 */
> -	if (nr =3D=3D 0)
> -		nr =3D zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +
>  	return nr;
>  }
> =20
> @@ -6417,7 +6410,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat=
)
>  		return true;
> =20
>  	for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
> -		if (!zone_reclaimable_pages(zone))
> +		if (!zone_reclaimable_pages(zone) && zone_page_state_snapshot(zone, =
NR_FREE_PAGES))
>  			continue;
> =20

It looks like the logic got inverted when this code moved around.  Should=
 this
be !zone_page_state_snapshot()?

-chris

