Return-Path: <linux-kernel+bounces-827057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9853DB9009E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5231E422A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA912FFDF3;
	Mon, 22 Sep 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KX2CjQ92"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D32FFDCC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537218; cv=none; b=ayR/5FgM7JN+1/r1tGtz0cClUKN0bp2M4WREFO+URs4tEOZv3ygdb2zdenSBc9Hqdtt8gJ8Qw50ruZxk5uAC1rDzhOI5od8A+o++QfBqFTXBlHp1z/OV1wkEKxvO+tMyM0gGXm1Y0fq/btOKoXiIUX8dz6UrhhrzpuWb93zngRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537218; c=relaxed/simple;
	bh=StOqZObgJ1vM4HpcUU0gQz23RbwVWYAw6VNTT2jCBsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtL7mf8ll5Uc9xu+J+UV7ShhIiolwETrtwuCk3JSO4kEsujqWDK7JFDv0v/POeDGnZsTWj2OimYM/iP2F1mxiMWPEPQI5IOnjQ6352AMuJ4HaDLXM4jG4oo+IcWhCGVcaJVVMk01/H52i4TGN4liNpCC0PxOY8kVOxTSHcD8Fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KX2CjQ92; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M91ZqC002083
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6vohyW6P/xPQXkhXTVUfhSzg8HjrVtZUzEp0pInDVYA=; b=KX2CjQ92y1QB0g4O
	rLrVpqbT/7ySxN2LlyfK5dVOBHX+hPmsSTQ9sf96uX1fYoAkJkhJPbBZjQmb30PV
	7iL5s9SQ4HEtssjmNl+GByORbFZuniK3c4DTISxRxyLcfSsnFl2dPtCbLadr22hc
	jZDOGGBVlgUcO0ZReBdwByADAu1QH1+3T3GreIUqlZgUj4/315rAwKJIZ7lyHbml
	stWTN64k6Ay5QpcSPfQPI2TUCByVSm94htltesG4DXhKcThENo9aQK1NGuY6jfA9
	yc8YP881loqz79dHFjqnq/ZR4R7k+8fL6vfpgj7RESV8teWY6GLtPqNXqD1ZAPTg
	uwW52w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fcas0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:33:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2698b5fbe5bso53036245ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537215; x=1759142015;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vohyW6P/xPQXkhXTVUfhSzg8HjrVtZUzEp0pInDVYA=;
        b=PZr3kYdOMoAa++ffw6j8W/7QbvCgGfvC9pX1YhHSNjfr9lHwW9M64xe0NOj3X0o7sT
         fu3RNyHze49ceC2BF4hGIM0geI4Ljrgza4l0qjBBznWKsmOG+GwLkwa7HvVLIX/n2NRp
         KT9PaArPXULZkXzktl68n+3U4ivMLuLyul3ups80aCECJ33UmO5zHmGaAYJaYbANNi5L
         kH3TnwzP/tbKdaAFWYCB2J/C8Zr1F72UuTDnTUpIStIoLD5bbD9S9ZzX+xZXUtaon9sR
         E9NRxumuQFOuyWaQGxv0mI/iBS3dowyI9f/r4id7vm0uvYZ9qbWkj2NmojnMR6NfrHSm
         LEKg==
X-Forwarded-Encrypted: i=1; AJvYcCX7wBz9bqW8HXDq37sRqUbBgdaSRNFNQy5qj4fdVxnA7qbTK0uLwiXUdwyf3p3Po9EBkPbAjG+UmBDoNeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZ8LpzrMusmm/yddIKZEvcOfdUkNytDA1qZlVCd1NzcffGJfa
	wbci3kGsQLEcLXou1zA44Xx10v2CDN0qJGjr/+VL1aDhmQxlYrPFtAKAqpBK142XJvxigvMzqD7
	AO/7G+EbPoJGYJz+2GaXA6rhA4pRSKfx2M8qUY3k6BSCYHQIdFnfTMJ6dTbWc37F1JQrMDsuH+g
	I=
X-Gm-Gg: ASbGnctf11uZ4X4JqjEnKVdeurb2zo4lRXuKjrh2Mdu9ofp8WfcnF8+uV01R1SBGqr2
	rF9l7V2rDS77f38NkfqJ0jWr7n+5yZDhR1J1G9PhPvT0YcbJsoRuGvxS9FdpZ9TBt3NcadJlt5s
	VYacfeD5NmWtNUtf9CPujmj3tIoFEuf/MtfIOtRe/34+2/T3+WYSlPG2xRv1THAJfC3AJdwuB5g
	5mz7TqyAmVGzd7XXqG6crT7bHR64zpBzj1tFpAyx/OsoKVyj8bCvA4gBe7AgUCiGngnkLZ3wR3A
	ESdGUgXMtcet2yTRTag7e+0nwrKBCawIftH4WlU+D6lMoLAXDDpqFgLhiVFY/Rw1Xb4=
X-Received: by 2002:a17:903:24e:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-269ba46450cmr195196975ad.18.1758537215034;
        Mon, 22 Sep 2025 03:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlj2E1ZL+mzjQ9VZNOizJlfhTeeWSHY7qa+ersqewi96K8KrixBgeNCQrDKVnMq1/YWzgiA==
X-Received: by 2002:a17:903:24e:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-269ba46450cmr195196395ad.18.1758537214528;
        Mon, 22 Sep 2025 03:33:34 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980339e89sm125802635ad.130.2025.09.22.03.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:33:34 -0700 (PDT)
Date: Mon, 22 Sep 2025 16:03:27 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v3 00/12] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
Message-ID: <20250922103327.ylyqwo5hpmtsbx6q@hu-mojha-hyd.qualcomm.com>
References: <20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com>
 <aNEEglLZTJuR1sLi@linaro.org>
 <20250922094732.6tupym6ulroctm5m@hu-mojha-hyd.qualcomm.com>
 <aNEcngb2T62HYlMq@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNEcngb2T62HYlMq@linaro.org>
X-Proofpoint-ORIG-GUID: SGRKrJJxs6n6j_NbSNvxJgEkCp2EQT9F
X-Proofpoint-GUID: SGRKrJJxs6n6j_NbSNvxJgEkCp2EQT9F
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d12600 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cyWJFerwHc5G6ORteNIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX659bPizRxtRN
 7wzbEV8JcRccs4QBB1W89pGKSJIe1EFCH/NHmzap6k0X9Cwr2r2CW1QfTnHAEmeVPL9JQCBr5mP
 Z3S+mgWbF+W0SM1xCizLbZa2AcFeqDEEW625LeXg0rQ+mRoFWM5KJfeiMHgHYhKglKQND5sZP5N
 3ht/UQvyDJUmnq7OJBBlrgJlsYwUm1+TXPiL3Z678t7ibrMejYUUGo+ACMOdt///IFsmaPGfv2/
 Q04p0ClkyB+HdVTIIw4B/2G02rxbuyOLtc5W/tWNtUHCorUf89o7R8wKXuZMToZTaLHCCorR2C9
 6IN2jOGo3C2JR5YIwCcHPDQnbLmtBP5sLQ8771/h1g5t239nh4NsrpQmkI7gJIFYep+Y90MGlyj
 0S3+Og9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On Mon, Sep 22, 2025 at 11:53:34AM +0200, Stephan Gerhold wrote:
> On Mon, Sep 22, 2025 at 03:17:32PM +0530, Mukesh Ojha wrote:
> > On Mon, Sep 22, 2025 at 10:10:42AM +0200, Stephan Gerhold wrote:
> > > On Sun, Sep 21, 2025 at 01:10:58AM +0530, Mukesh Ojha wrote:
> > > > A few months ago, we discussed the challenges at Linaro Connect 2025 [1] 
> > > > related to Secure PAS remoteproc enablement when Linux is running at EL2.
> > > > 
> > > > [1] https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
> > > > 
> > > > Below, is the summary of the discussion.
> > > > 
> > > > Qualcomm is working to enable remote processors on the SA8775p SoC with
> > > > a Linux host running at EL2. In doing so, it has encountered several
> > > > challenges related to how the remoteproc framework is handled when Linux
> > > > runs at EL1.
> > > > 
> > > > One of the main challenges arises from differences in how IOMMU
> > > > translation is currently managed on SoCs running the Qualcomm EL2
> > > > hypervisor (QHEE), where IOMMU translation for any device is entirely
> > > > owned by the hypervisor. Additionally, the firmware for remote
> > > > processors does not contain a resource table, which would typically
> > > > include the necessary IOMMU configuration settings.
> > > > 
> > > > Qualcomm SoCs running with QHEE (EL2) have been utilizing the Peripheral
> > > > Authentication Service (PAS) from TrustZone (TZ) firmware to securely
> > > > authenticate and reset remote processors via a single SMC call,
> > > > _auth_and_reset_. This call is first trapped by QHEE, which then invokes
> > > > TZ for authentication. Once authentication is complete, the call returns
> > > > to QHEE, which sets up the IOMMU translation scheme for the remote
> > > > processors and subsequently brings them out of reset. The design of the
> > > > Qualcomm EL2 hypervisor dictates that the Linux host OS running at EL1
> > > > is not permitted to configure IOMMU translation for remote processors,
> > > > and only a single-stage translation is configured.
> > > > 
> > > > To make the remote processor bring-up (PAS) sequence
> > > > hypervisor-independent, the auth_and_reset SMC call is now handled
> > > > entirely by TZ. However, the issue of IOMMU configuration remains
> > > > unresolved, for example a scenario, when KVM host at EL2 has no
> > > > knowledge of the remote processors’ IOMMU settings.  This is being
> > > > addressed by overlaying the IOMMU properties when the SoC runs a Linux
> > > > host at EL2. SMC call is being provided from the TrustZone firmware to
> > > > retrieve the resource table for a given subsystem.
> > > > 
> > > > There are also remote processors such as those for video, camera, and
> > > > graphics that do not use the remoteproc framework to manage their
> > > > lifecycle. Instead, they rely on the Qualcomm PAS service to
> > > > authenticate their firmware. These processors also need to be brought
> > > > out of reset when Linux is running at EL2. The client drivers for these
> > > > processors use the MDT loader function to load and authenticate
> > > > firmware. Similar to the Qualcomm remoteproc PAS driver, they also need
> > > > to retrieve the resource table, create a shared memory bridge
> > > > (shmbridge), and map the resources before bringing the processors out of
> > > > reset.
> > > > 
> > > > This series has dependency on below series for creating SHMbridge over
> > > > carveout memory. It seems to be merged on linux-next and pushed for 6.18.
> > > > 
> > > > https://lore.kernel.org/lkml/20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com/
> > > > 
> > > > It is based on next-20250919 where above series is already merged
> > > > and tested on SA8775p which is now called Lemans IOT platform and
> > > > does not addresses DMA problem discussed at [1] which is future
> > > > scope of the series.
> > > > 
> > > 
> > > When testing your series on Lemans, what happens with the additional
> > > SIDs from the peripherals assigned to the remoteproc ("DMA masters" in
> > > your talk)? Are these running in bypass because the previous firmware
> > > component (Gunyah?) had allocated SMMU SMRs for these?
> > 
> > There is no DMA usecase present for Lemans but can exist for other SoC.
> > 
> > > 
> > > It would be worth mentioning this in the cover letter (and perhaps as
> > > part of the EL2 overlay patch as well), since it is unclear otherwise
> > > why your series does not result in crashes the first time a remoteproc
> > > tries to use one of these DMA-capable peripherals.
> > 
> > As I said above, It is not present for Lemans;
> > 
> 
> Ok, thanks for clarifying. In other words: The IOMMU SIDs you have
> specified in the overlay so far are sufficient for the current firmware
> use cases to run successfully on Lemans?

Yes.

> 
> > To handle the DMA use case in generic way, we might require extention
> > change in remoteproc or generic iommu framework to handles these
> > scenario like its SID and memory resources should be communicated
> > through firmware resource table or device tree or some way.
> > 
> > And same scenario when resource table section not present in firmware
> > binary ? like most of the Qualcomm platforms, how these cases would be
> > handled and I believe this is similar to the problem video is facing for
> > non-pixel case.
> 
> It is sort of similar, except in this case Linux doesn't really do
> anything itself with the mappings. In the video case, Linux dynamically
> maps buffers (or similar) into those address spaces, while in the
> remoteproc case those are fixed(?) for a specific firmware binary. At
> least if I understood the explanations in your talk correctly.

Memory region used by DMA use case would be fixed with subsystem
carveout memory but need to be mapped with DMA SID before subsystem
boots up so that it could use the DMA. So, it looks to be subdevice
for remote processor but programming of DMA taken care by
remote processor firmware and those detail would not be mentioned in
Application processor device tree.

> 
> Anyway, if you don't have these use cases for Lemans this can be
> discussed later in the context of a specific example. I thought you have
> this requirement for all platforms.
 
Sure.

> Thanks,
> Stephan

-- 
-Mukesh Ojha

