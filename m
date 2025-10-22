Return-Path: <linux-kernel+bounces-864792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A29A8BFB8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DBB5855DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD07E32BF22;
	Wed, 22 Oct 2025 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Km4qErSb"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F8E32B9A2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131428; cv=none; b=NMawFuOiDyiHPikbefEK0A/SUMM9R3T3cMvywOiloGko5HEcdiN/+wq4IlVP0krlRf04ao4cjs1PV5KDAB0V41KDlU1BSsF+CAmKH5URoSILnnolX9TwnWuv+zsIiMLbkagqBZW+JKD31FsdtNSpd2MRDOvo4GSo/Nw+FeRR6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131428; c=relaxed/simple;
	bh=nm6Gb8AwFBmRqLCV2M3J+ady0z+J/PK8dFDQ9i9UNYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5dfQG4tM+iI93LTmTIDZOkHyGaBQyhKi8kDkvj9DLtTf8Mef0nujrEi3jB2y/RATfGsKeGjAN1zrA81dbLflM4rILDdLhLgGu1zhRppRxdbMQMWUYrUuLngnWhWnnoyIEB5qGW1ip1DuC5orT7w/AWRxlhsD59/l6bwPqOrhwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Km4qErSb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M6sNrA021232;
	Wed, 22 Oct 2025 11:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t2boCF
	R7C/oAdKw6eO4grEERwlNfhetkURuijkwtMfI=; b=Km4qErSbjtJ+NBQIUR3oER
	U0xAsMwcGJRJdSWK7L5WQs37oGWCxY8QSkMYH8NCDG/a8xJXd/OOa+RdcJyYv6LW
	pM0maU0Rmvip+8a4FpZsANLt2sXpciQK/GtlzqiMoB8x8OJSnHOWG6DnGW+ffTJr
	L5GcqhOs4bz/yYEqXrEq0u+J6n+kwJ1krCCG7PDFwhPZIg3AeTY9SbFXvrNKMLMQ
	fG7WIIbQpOvmCndDtKvi08EqHxu9JSZ3eLsdcuuXtX+oKL1run90QoUCiQ+mRU2J
	oMhvdv6u81CKQSkxRskbdstilqVzBrqzAnYaeLqok4WMiec/0nzs85MVBjOWMTuQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31caxq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 11:10:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M82HX0011053;
	Wed, 22 Oct 2025 11:10:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx17m31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 11:10:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MBA1LH40305018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 11:10:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F97200A7;
	Wed, 22 Oct 2025 10:53:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A04FF200A6;
	Wed, 22 Oct 2025 10:53:52 +0000 (GMT)
Received: from [9.87.134.81] (unknown [9.87.134.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:53:52 +0000 (GMT)
Message-ID: <db8fce479c6a682d7ca1c37f7427ad30673fc34e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wilfred
 Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 12:53:52 +0200
In-Reply-To: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
	 <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JbMCHma0NNtYrJkd24Qgl8MdsDQ5-Eem
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0pREBYWkk+8e
 TVUkY7E0MItQSpHJh7sp+T854CAF7tM89U3FOpLSXM47nGSooRE5aNZ70uf6JJUmVf6byR82wZO
 FN4qNTpkFGmS4Tz4cXnpHu6F5wfG7RQDTjbcA0hFumh1tb/GnOcCFXxGGGVo4q61PfE3NW+zlIf
 wB8LQ1Z9pByUQzs4NbJJcUxxWyAJe3OuTNiavPegUzy1AC0quYIfIF+O6KRbRfSQmFCyefxZO0D
 s56CJXMrTd2d8FZ0Zx6vg27+JKjhpBUv74hTwAWkGeQzrl23LdpBBVmhY/1j59W4WTutuKrtXR0
 V18SBmT/R1gKS2W4t3h8k+7aaXXWPBdaZAX0LJ4qfUqXsv55kz9mc56nJLDHOqV4zMbqCc4p6g8
 DwwJCl7yDsZssp9zeeCu/3zlR7oZew==
X-Proofpoint-GUID: JbMCHma0NNtYrJkd24Qgl8MdsDQ5-Eem
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f8bb90 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=WF68Xd0AlUmpovsNYtMA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Wed, 2025-10-22 at 12:33 +0200, Gerd Bayer wrote:
> Add a new error message that makes failures to probe visible in the
> kernel log, like:
> nvme 0008:00:00.0: error -ENODEV: probe failed
>=20
> This highlights issues with a particular device right away instead of
> leaving users to search for missing drives.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c916176bd9f058b49e6e6768675711df52b15765..8c624960c9f67e0cc8409023d=
e5e532d6ed9b3ac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3522,6 +3522,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
>  	nvme_uninit_ctrl(&dev->ctrl);
>  out_put_ctrl:
>  	nvme_put_ctrl(&dev->ctrl);
> +	dev_err_probe(&pdev->dev, result, "probe failed\n");
>  	return result;
>  }

This one failed to reach Chaitanya due to a typo in the email address
on my side. Sorry!

