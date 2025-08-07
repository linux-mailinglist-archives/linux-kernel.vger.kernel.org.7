Return-Path: <linux-kernel+bounces-759318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F4B1DC02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B99B7B00D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455662741A3;
	Thu,  7 Aug 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="yZkIAOS4"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB42737F0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754585461; cv=none; b=aQu1y3QsJn+So8j9A+LnSAADooyOGmlEq69rsyH3ra2tprkRl9n6nVN95xLcEUyEdcjWPaHDsTt4XM/LE+SVlr7Md2ioiqhw+4AHm051XthObeLx0kOOwKZUrCMpgtp0b7Iti2AYj/B03SZRfRzC/Zp2AGI/svWkc8NW3qGfbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754585461; c=relaxed/simple;
	bh=v8rFHgkrPNB3ELButopohje3DL8oevA26/4a+ko21Ew=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVPstKIPkhcXs/8vpLFn2NkDIO5V/klikPIoQ3GKQK++apj27aHMoquib0fQMn616kPMUyKldKLfPN9fRLnPenMsXSouYVMUh6PtZKPY4vpSqMxkPmV8g0pq+7hN1mNoF5e4Ksx00Y2gHnUnHF+FogNKgDnba9w7XW4eGGJn324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=yZkIAOS4; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577EIrak005787
	for <linux-kernel@vger.kernel.org>; Thu, 7 Aug 2025 09:50:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=s2048-2025-q2; bh=v8rFHgkrPNB3ELButopo
	hje3DL8oevA26/4a+ko21Ew=; b=yZkIAOS4tJlscJPy7cL3PG2M4DNN5EVknRaB
	3sz9yJBC1Ym3BLZ4HJLiLD+dklxLjaIGOZ2Ow+b+f9ujGDDF7AmCKzQX13Ce+2NK
	bKRN6iFDbugsCovB8iL+BrEpJOzrCU9ZYDzhSFoGf+0+U4IZv2zba476iNA9zJ+r
	PUfWcE/WJizAhqj2ZnvSvTPcP4Q2FnYtLBAgvyVY9aZXYHxLwsx4hO06sBSY5s2k
	9l9kF+nepviKWOS73Qm5WhwBD7qOVuc/Y1nGvIb/zA9F9vGqTTYTlxqfPUi4blyP
	AGhYQPkJn2ZgySo6NL7HvFs09etYMCDliOu0E/ynRBaAfMoPyg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48ckc34g9d-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:50:59 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Thu, 7 Aug 2025 16:50:58 +0000
Received: by devgpu013.nha3.facebook.com (Postfix, from userid 199522)
	id 0DF4C837B4F; Thu,  7 Aug 2025 09:50:54 -0700 (PDT)
Date: Thu, 7 Aug 2025 09:50:54 -0700
From: Alex Mastro <amastro@fb.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch
	<kbusch@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <kvm@vger.kernel.org>
Subject: Re: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Message-ID: <aJTZboKCbYVkLLUE@devgpu013.nha3.facebook.com>
References: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
 <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807144938.e0abc7bb-a4-amachhiw@linux.ibm.com>
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzNyBTYWx0ZWRfX72W4CAs2W51V upWtOCqpew1R0JtoaWQCiHcJ89mi5Sbrlu/W6Wp3iwC/FXoUXynTWKlSp1HP+OWUCCE6Ss2k1Dm uFawTwNhAmifdJrXoKjJxsXiX+lgY5zWKG1zgIeUMmbo0ACM6jKnZQpvyX1I7WVJJAly8dvIE6C
 j7d2CVPdbytjunaw+oaRaCzNGXsn3TC05bSXl4jL18hosNCiIpkZl8kL5r0cdDkmhTcqhDbQWk9 cByd3ouhP2GYksMov880NKD863JQTWOICvhzTbPEptC0GHe7cbyKAGEg0akoBgdCCZbQbINIUDb 8+t9Psm2WkvxaO8Q/akvBE5h2fSqStNLMXFMJSKHfklNt3TGYCEpwvvqH9qAWOTtS8TWYgtYA7z
 F7vTlRjfVnTquFw7IBIT501BQuNsam6LSQWBH9Z18xnWuLIuHhZ5/8hcE9bwr540EnCJkvj/
X-Proofpoint-ORIG-GUID: 9Y2okoxG_4xaGwFCRmcakv4bJiPf7zAG
X-Proofpoint-GUID: 9Y2okoxG_4xaGwFCRmcakv4bJiPf7zAG
X-Authority-Analysis: v=2.4 cv=d6X1yQjE c=1 sm=1 tr=0 ts=6894d973 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=Ocdik3-Q_VXzhM4yoKoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01

On Thu, Aug 07, 2025 at 03:04:29PM +0530, Amit Machhiwal wrote:
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Hi Amit, thanks for taking the time to test and review!

Alex

