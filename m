Return-Path: <linux-kernel+bounces-844980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F298EBC3312
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0DE04E6FE3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFE29D287;
	Wed,  8 Oct 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLaiwFVP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F329CB4D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893246; cv=none; b=vBCv0aGLWtkGW70KNrJX//q5WgzZQM133a6Vp6g6LM9op1KmYQJwSlWZX32jbLFwp3fZrXDXGJQ9YTkvJ5kz365lGcWCGfq2RCNJCSgYDXWVsc5VoPJFcKzwc/s0JOW7/L7X0fx2IFILC6hrJb8j5f22RwCoKe0lMFCyxrc5c/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893246; c=relaxed/simple;
	bh=EYDzc0Ut0l+GI9wUjAa1aPUQ8uWs0g4z/m1BxODGh/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi3lFBS9056DOLxSGkVQzB2iT/0Nl3g8+4hJteQZcdhNVkoBeE8ZTejH+7RqnW/lpv+stL82GiX0DbecIR2l97j4mRfLiyTKDEdL0UyMQelehTO9w3kl9MQLy5r+vuYEu4lyLe3kPHtfElG9MqnmrGiIxYQRSRGEpbGDRe+qRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLaiwFVP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59803Vd1018096
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 03:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=80U+BEnC+XavCbbo4ruTpk8X
	0HxNU2LOw7lkXj3xDzM=; b=NLaiwFVPRVFljbihfs3tIsWZ/YgmaYgcCKyh10az
	d/G0gUUnBpNkboSKCgfhwVUBgYgJyBXzgfq/6leoj7iOoMJwLFdImQGRayecXa4M
	WO8ETvsi8AMf7jVch4kvpXu5jg7qttd+UnkfPlwKYS3zUtKWbN0B9gzd4d0tJZQS
	kfIN45agNBYN9osaMQd86HW5L63+1lnQ3O21NXuitx60vcGHSs0ctdHEWOiY1ksJ
	x9z8NVmEBum4Ds1PhjHVc5xmOHuPlFURNWqY1Y5IoRQoY8qWzlm1wTSJhzJNMG2z
	nbYFflJUKGusPsHW5z7ZEtozZKxb/eferTFkei9Ubtbp0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgs7sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:14:04 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e56cd1d360so173697551cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893243; x=1760498043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80U+BEnC+XavCbbo4ruTpk8X0HxNU2LOw7lkXj3xDzM=;
        b=CiJDpg/n0vhzuszZH+NNan0lg1YB9NYIIPXpbVldYKHSM37r+8qQbrtV53wZ4fC3oY
         Q+/IwD+zhiId8zgrRkG/+LVK7bMnBrBYil/vbsVjLt3TwOPdMKB0loun5lHMmhfrZ+kq
         /oEMAEoNCSwjq7GrNt7fgC0m58nX7iTf5+WAwgq0hiWceV/jWeF5W313zsjrsZ4fs3lm
         8np/9OvExKxeWXTU5UavB4g92ZGzBu+lgA1K49gjE45+ocaKrorJXZCzi52GXbUcluL/
         qFdn/SKRqPItbk8MmhqrHR4VGZYePdzj/9dkK3LAKjltwtF/dNLc9sRKvSbgK2+PlJxC
         NVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO2bcxVP2Pbxh7lMYOJXD6IvmLePz31+bNU5ayS2ThIbLljR90YZY+3hUJDHUc5PBjBHTYS+i2SPKXaOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx896j/DTjHO0heKJgDiXS1aqGw/KJHzH24zDx0UPwMUubRgjfT
	VzYBaRh0DvkIM5+ShlsaM9LFr69C2d8ouen7JuR+UjkP2aRvmBAbVdiMu0FfDEzJ8k7W1UaV+6G
	zz6ugV7gOaqstJ/sRFbfK1cxBaV4VHz85Bc75tEXXVBYRRz32WTSIl8BjlIwKdgp7RJg=
X-Gm-Gg: ASbGncve7IzWNy5O3LXwsob4SJIzu/cYbcvhq1rjenLu9XinSBZCq4QUxIyNyYcc/BZ
	LrJuDcb+wwIkg2ommJ6GZNZnO0U4BGCl5b2Jbxn5iFzRf3H/6X8IpUGFTKrELx3y4d0dA1s/+WC
	ydndM3H7Me+4Fc25qMLz06HdSdHh8LXu7y4E33WjEjmwQPntqoZDLgmQalSFp3OTJCnx+attsHG
	/2Y5fbsM+da1TlZNIqHnrzZveN1PlEU+ujEPWYv4QrglrmaDcRTpCG2qC3YQBbh4OcsqTfqB+AF
	DionxNxv2lkBl7oGCSB/A8L3UEEUFjOc0mQi0BgpwrWsh0U5GyT3bd2MMe6rphGqU16+EbJo05/
	g/VrdHy9jFXMCo/ehI2SqwA9OYI8B+HB39k447/McITT833oGlWlsn+NQvQ==
X-Received: by 2002:ac8:584c:0:b0:4df:acb4:2f60 with SMTP id d75a77b69052e-4e6ead631e2mr26660901cf.57.1759893243157;
        Tue, 07 Oct 2025 20:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYrLPwwKS/KhGIeJB/ialCQXXZq2J67mFWSwiwPV4pHrI0Ie8iG4bCj0RI6DvA6Bif71ncSg==
X-Received: by 2002:ac8:584c:0:b0:4df:acb4:2f60 with SMTP id d75a77b69052e-4e6ead631e2mr26660561cf.57.1759893242575;
        Tue, 07 Oct 2025 20:14:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011a261csm6690140e87.109.2025.10.07.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 20:14:00 -0700 (PDT)
Date: Wed, 8 Oct 2025 06:13:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>
Cc: Bryan O'Donoghue <bod.linux@nxsw.ie>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Introduce "non-pixel" sub node within iris video
 node
Message-ID: <zoe23ugsqyqqz5edpxa6nsppqocwrxq56ekpd76r4ptnz2p5aq@iwnrpjuu47pk>
References: <Ujyoj3HGLVFhS2b0XzcYAMjSiCAuO-lSJ8PMEQLOaaX83tk_0D5zjrL0VDyZAmD3i4zLB3ElKSZBltISb5jJHA==@protonmail.internalid>
 <4a32bbec-2baf-4210-a7c1-1ddcd45d30c8@oss.qualcomm.com>
 <SuwJuCIcLVJwN3YeN1il6tB9wO9OH6bYcnbRpxpuI9Dl7piYLN-hVdnyv0Mal6N-W5pi2aCZI8MxHZDEkoE63A==@protonmail.internalid>
 <4d87d1ca-55b2-426e-aa73-e3fd8c6fe7bd@kernel.org>
 <10a8ccda-4e27-4b06-9a0e-608d6ade5354@nxsw.ie>
 <4cb4a92d-2f20-47c7-881e-aadcc6f83aa0@kernel.org>
 <I1DbPl0-zSS8tu3k8v0O-6DQdXnwza-Y3Os6GXsSDbOOhVbi3-F8jfL4q7QdkYo2zLv_s8Hy9v1PI3SiGCuDdQ==@protonmail.internalid>
 <CAO9ioeXqx4MoHNDiM4Pbp_evxEAACP0HhJ+8Fgqhhq60sCThdg@mail.gmail.com>
 <1481129e-3803-498b-bfe5-003c194f629c@kernel.org>
 <aocpjjk5zpdjdo33l3orq65r2q4t7v3lwbyl7rgkhzjceiseem@bfdk3t5dgwea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aocpjjk5zpdjdo33l3orq65r2q4t7v3lwbyl7rgkhzjceiseem@bfdk3t5dgwea>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfXx/OaDqpQn41Z
 68V/8F13YMCgacCAa3v5QPxFOlyO2sYdtCOw9Px5jEIoS6JJZmAgDf7dart2ChMxomIX1xTc797
 p1GWrSRVRV8YDPYoK7m6w/950/jGR4AH9FxOat7bfaLqlc/ipvc14UNMreFS4+JoCUvqPMHc2z6
 UJL8ZZD8nH265i9P8ErgudQCx5s/vPtLuSI64v4k+Gp0Kh5faQlYm18CClxejh0sHe+2qWbeRfe
 NyDjR0vFWlxKsxlKj+4fT9sjqOA+aTBydi/6FFA9QEtUMqdvDeZxBRqiPli7WGWbfszwe16uS/O
 UyKdVXfzCj1EWxU694K/q59FT/SE+mxT8nitQE2Z1jwtcY+bPA8peSFVVuFFQs7fB0q7sKLK/36
 1TgGUuWdugomvikt+ISsieJgiZNaZw==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e5d6fc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=YnPbhknI7qQ32hHCO4IA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 6a7GeKG0OMI2AuyZSUP9vPOIEeIp6mMu
X-Proofpoint-ORIG-GUID: 6a7GeKG0OMI2AuyZSUP9vPOIEeIp6mMu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On Wed, Oct 08, 2025 at 06:10:26AM +0300, Dmitry Baryshkov wrote:
> On Tue, Oct 07, 2025 at 11:10:28PM +0100, Bryan O'Donoghue wrote:
> > On 07/10/2025 20:40, Dmitry Baryshkov wrote:
> > > > Surely we could do
> > > > 
> > > >       #iommu-cells = <4>;
> > > Because #iommu-cells is a part of the apps_smmu: device rather than a
> > > part ofthe iris/venus/GPU/display/etc.
> > 
> > What's to stop us extending the definition for qcom platforms ?
> > 
> > Rather than jumping through hoops in drivers, we can just encode the data in
> > the DT.
> 
> The IOMMU driver or a ARM SMMU device itself has nothing to do with the
> way individual devices use it. As such, I don't think we should be
> extending #iommu-cells in the SMMU device.

... and I don't think that we should be encoding IOMMUs or other
definitions inside the driver, if we can express them clearly in DT.

-- 
With best wishes
Dmitry

