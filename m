Return-Path: <linux-kernel+bounces-754953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F278B19F12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 740B67ABC76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27842459DC;
	Mon,  4 Aug 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ir0NdNZu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FAF244673
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301372; cv=none; b=JMLwAoG+kQnLIm0UFVPFRU68nc+zIOdIu24r4kilzHtuoyjtec6FGipV0rAojj+vT0hkzH5o88ivq5vYofx4xgp2BPkHnFVsstsdQc+SM6dTPOiuGWrb+neLf3PE8Is0cpkmjYhrcnUBn8FxA8szGn/K0L28keJVkLnJE3gS2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301372; c=relaxed/simple;
	bh=ObXAyZceYTZwG0k7CCc3oP+iY1FuHqfwGFXQAJSCxBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKioaFhb+00jGlb+fjlZBVBb4816lXHgikG44LTEi2AREosZl/tZZbKtF89PVAndvSySzWn9WULde2UXwufpay4DeHVPkLkfG/gy/Tvh3C9bwvUdcOlAHuvorK7jRg7ipFVz6ZAquxxAVCvf+hh3UQhtb25lN7mq8n9yzVBtebk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ir0NdNZu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57440tJs016552;
	Mon, 4 Aug 2025 09:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pCU8ninXVYcWh4jRTcA9x2LyPI6zCW
	kcNu6uPo+aMAE=; b=ir0NdNZucVvuXpjF2uF+lF2Sfdd4gOrU7ZDyeiNeZf7b3C
	aZqAjWZDtmL8SQoPkiVRdxFKmAS33PspooliJZ/itO4L8CN3mCo+fRTMYWW29oVj
	6ywiSSfwEMjJJzDwhTa1xzyvPjMyXV/h3Hfw2a9Ek2z9mFCM1OnjRh+30xC/BCgl
	VWt8FHs3GK7RD7ApNyr4dKvkd+ZWbTWnVjvDEWm+MyCmM5eufdo+0xlG+edfySHG
	D7i3q6tiAcr+2PTFGxhL1JTjGZ1XTnQdnDn9PLhnWnQvJl0UrrUqXjnnq8liCqaw
	duuPG0TKtYF9FnPDQfLYpVfbBQjuy4RQwFWgqrbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t0gk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:55:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5749tqos015263;
	Mon, 4 Aug 2025 09:55:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48983t0gju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:55:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5747KWoZ001780;
	Mon, 4 Aug 2025 09:55:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7kmyd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Aug 2025 09:55:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5749tmUZ50463122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:55:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86581214D6;
	Mon,  4 Aug 2025 09:30:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3637E214CE;
	Mon,  4 Aug 2025 09:30:11 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.ibm.com (unknown [9.204.207.58])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Aug 2025 09:30:11 +0000 (GMT)
Date: Mon, 4 Aug 2025 15:00:09 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64: Drop unnecessary 'rc' variable
Message-ID: <dtzjm4ngxlmpevlvjadtvnl5kfwxrkngrouxssq6skxvywe2kt@gbi362blsi3k>
References: <20250801035908.370463-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801035908.370463-1-zhao.xichao@vivo.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA1MyBTYWx0ZWRfX59lred3ItIuJ
 l+TJxeGn/ThkFpLvxglsoV7g4Umv5aGlYhlmJaOFXomffj56HZFy+gEWC7m6eJgA1EwuZ3YisLL
 S620FrF3f5w5ZVGUwynd+kWrlKAQvM3KBrMMgWLXFCRoZI1lLrrj7B32Igc1Ohr/O1YSOWNBtxO
 ymv+sOHD8NRgla/AZUGYPZYNXsKXszEQqj5wCXStbOyzhPsYe4C6Q7tl4nCHCwXlX7x7pjaYPgN
 XY50v1FZuEjFI94GY0MWTbd27VqRbcbYJ4nHrwZtI8je0Rli7yrKciFjSwvE5WQxclaOv/IP/6z
 MMI0LfbTXXGPfMSihWe7kwe9TnsM2+frwM8H4o0NoZnBh0KvkTRY/XTENdJmBw9LOrtAWzf4O+r
 PDBFkr7Wo4QP7q9RK+3sS5nhoKoxQAj82/T2a3iuB8mjFN9LK4pFgh1xgrA7vNAfKmpbSqYW
X-Proofpoint-GUID: QXtOYMhFiVUaqBtIA3xaCAaw4MCe-WGH
X-Proofpoint-ORIG-GUID: aEElh-yU4m14DDHukNKOmDuIJznMgYWB
X-Authority-Analysis: v=2.4 cv=AZSxH2XG c=1 sm=1 tr=0 ts=689083a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=VnNF1IyMAAAA:8
 a=95aTRTVSYsbvNN7snPQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=866 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040053

On Fri, Aug 01, 2025 at 11:59:08AM +0800, Xichao Zhao wrote:
> Simplify the code to enhance readability and maintain a consistent 
> coding style.
> 
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  arch/powerpc/kernel/setup_64.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 7284c8021eeb..8fd7cbf3bd04 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -141,10 +141,7 @@ void __init check_smt_enabled(void)
>  			smt_enabled_at_boot = 0;
>  		else {
>  			int smt;
> -			int rc;
> -
> -			rc = kstrtoint(smt_enabled_cmdline, 10, &smt);
> -			if (!rc)
> +			if (!kstrtoint(smt_enabled_cmdline, 10, &smt))
>  				smt_enabled_at_boot =
>  					min(threads_per_core, smt);
>  		}


Thanks for the cleanup

Acked-by: Gautam Menghani <gautam@linux.ibm.com>

Thanks,
Gautam

