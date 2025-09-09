Return-Path: <linux-kernel+bounces-808601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772AFB50226
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B695E31F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91713314C1;
	Tue,  9 Sep 2025 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RMUDHvIY"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D431815E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434093; cv=none; b=iCv2IN4q003nI5Tl3S0TiJ43if+1dOFeYyPBFdt8+bdYfaIhtCSB94DFmG5E2KI27kq/8isaabmwWQYeTsghfwm5Ip1d9KcoFiF5K2XoPZj9IxPqRwRb4PjgnQQkRoADS2s+ZXXaiL83HUnzKwymL2FHfPVqbaxeL0UAwdLvk8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434093; c=relaxed/simple;
	bh=6U4jBPfP+4hqpr9Ns80fHNJ6S3WC/wxAlNqw9CepAoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRL00rhcvAD87KfhpUxY0E/0aYugmbw1hR13ur4fm7j6y/PF/EbfzqE6vrW5iauhbK6Q/3mumilGgRsSnFL2G17hMqTWlyoVGVTtjUPMp4F1hLYYzg7bUUOjeUOaB7FQNDow4d4XT+ifVyGHB6jTb19sl0gJoQWgWwJ8QFkMIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RMUDHvIY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589G3Fq8028539;
	Tue, 9 Sep 2025 16:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yCzij3
	lwPXWu6sDllPHsxlKV1DFXRLK5f2LdkRAekRk=; b=RMUDHvIYarO1NPovxTczAe
	k5kcMSb813GbwXwDV6i4ZK6LkfrpQy9OPMQNkzLid/8iOJ6UFiFTB4v662KJj/Dd
	58SKurn/jRaW9EbkWjd9mvj/oL3ZGkWTdv+F9AdhVcOdqo/Imn0V379zX6kGhInN
	KQFzFw3Y26OWLJ7o+VadH3+AiWiIWFLwNOzEwZCgrAhljE3ADExSzJvwl7KmSDYw
	Fwa5plZVDKk3OKh/MWTFoUZfTSyVwKrHnu5upR4CqRtOBsGoeqjh97OR+9ZUWk7H
	JDeAyo5z0C7YZvO+lfYx3MaH6X5fDTu+DuamWysIUvPbfo/my5hNE1zNthV3lImw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490ukee3pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 16:08:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589F1qF6001188;
	Tue, 9 Sep 2025 16:08:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203bpx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 16:08:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589G81EU33817068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 16:08:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E31020040;
	Tue,  9 Sep 2025 16:08:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB0812004B;
	Tue,  9 Sep 2025 16:08:00 +0000 (GMT)
Received: from p-imbrenda (unknown [9.87.128.215])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue,  9 Sep 2025 16:08:00 +0000 (GMT)
Date: Tue, 9 Sep 2025 18:07:57 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard
 <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Christian Borntraeger
 <borntraeger@de.ibm.com>
Subject: Re: [PATCH v1] mm/gup: fix handling of errors from
 arch_make_folio_accessible() in follow_page_pte()
Message-ID: <20250909180757.1114d727@p-imbrenda>
In-Reply-To: <20250908094517.303409-1-david@redhat.com>
References: <20250908094517.303409-1-david@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX0lWyfEZGUS5w
 LXY1c5sfuf2PvmgsPHWuzkS83RGsrAWpM95nq+N1tKo5UF9U1zi/qyS98B9Hrdtgd1vd4oX+MDw
 6T2KHaGz34IVzW2xyMI/VgeytPjmtz/W1yF0ZnuXiMeUho0dUtN+zS/YAwgpqrTs7YdjO+tT24t
 yAdj5SMIAFUOcJvRoThf7tu33NkqVNw/wY3iIc/DXVjYak9T9G0zxVgnvWup4U89NMJU8XID02F
 SRy8zxIXVOoCZbA9ncIax4x19FS1Zjl9EAxURUNtvQY/I/fnoNp2xTgIZqGkRjmQSpgzTRNdxAE
 1acb1XLGrt1uWX+Km/KDVO831wf7CYoG4gRzGAHNbMzX5PO6sn+wPJ61we+6JaY2RJoHEZVIc3b
 zY4ew97r
X-Proofpoint-ORIG-GUID: vj4YCukf9maoZjMYBKZeshE7HQm4n5R6
X-Proofpoint-GUID: vj4YCukf9maoZjMYBKZeshE7HQm4n5R6
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c050e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=Z4Rwk6OoAAAA:8 a=9jRdOu3wAAAA:8 a=Ikd4Dj_1AAAA:8 a=FgLdBiW5u0QFqUhnriMA:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Mon,  8 Sep 2025 11:45:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> In case we call arch_make_folio_accessible() and it fails, we would
> incorrectly return a value that is "!= 0" to the caller, indicating that
> we pinned all requested pages and that the caller can keep going.
> 
> follow_page_pte() is not supposed to return error values, but instead
> "0" on failure and "1" on success -- we'll clean that up separately.
> 
> In case we return "!= 0", the caller will just keep going pinning
> more pages. If we happen to pin a page afterwards, we're in trouble,
> because we essentially skipped some pages in the requested range.
> 
> Staring at the arch_make_folio_accessible() implementation on s390x, I
> assume it should actually never really fail unless something unexpected
> happens (BUG?). So let's not CC stable and just fix common code to do
> the right thing.
> 
> Clean up the code a bit now that there is no reason to store the
> return value of arch_make_folio_accessible().
> 
> Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")

Ooops!

thanks for finding and fixing this

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index d27b6b9818a18..c969259d095c9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2920,12 +2920,9 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>  		 * see Documentation/core-api/pin_user_pages.rst for
>  		 * details.
>  		 */
> -		if (flags & FOLL_PIN) {
> -			ret = arch_make_folio_accessible(folio);
> -			if (ret) {
> -				gup_put_folio(folio, 1, flags);
> -				goto pte_unmap;
> -			}
> +		if ((flags & FOLL_PIN) && arch_make_folio_accessible(folio)) {
> +			gup_put_folio(folio, 1, flags);
> +			goto pte_unmap;
>  		}
>  		folio_set_referenced(folio);
>  		pages[*nr] = page;


