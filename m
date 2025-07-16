Return-Path: <linux-kernel+bounces-733355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DCB07388
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D16500E58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EBA2C3274;
	Wed, 16 Jul 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFscRiR+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE32459D2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662036; cv=none; b=RepRLaVsVFj1er52xcS1Yun66X+ghE8bnMIiv0GqZH4Bp0TAFNlTOsx386R8tVvqZZCuDSUcmgoNo5hzODQulcFG30ROVk+oRdaRcCAJ6E+04CQAMKsWRVxdY1moLgQrkbEH1QDq06tMqW9sW2CSoSaIxlS5/sJ+8siZkTnFqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662036; c=relaxed/simple;
	bh=c3p7q1pVi/3z8r69IqVIDGZ/WL9MjIwWFzKdnDLShSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuLM8l2uL9d6pBeMTzGOGwEfQ/kkZ4LsHVaUR/ixvOF+l5RH9iKaFT6TDH3lneNGMGdfwT1zRdb4Toc8/Rs7lAEMoie4rpVtNk9kLIOFwLpPTfYsMaWeZRHKf3OXmhBNjE+/iBjbVNrx6aC7xFLStf4ZCxVFH0eZfiKZ/tLudB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFscRiR+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G5gunp017640
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sQWjm0Dvlp+InqqRH1JLvImgPKkONjZ92vuXT9CYs0U=; b=oFscRiR+oPVlPK8g
	qt9Uq/vaonqRFYJ6ZISJQHhy2pFq975zZSUP/pLsC8jXAdpSLMPmWBNKHpTiEH94
	jq9uvH8WUpDJUo2fsMtfykqwhHhdjv4pyri+pBZ5KVc3a2kuBjNy+5heIwIvX+Aw
	hjVti0jCguoHo67bd2Ver2qI3ycwwVAo4RBngHIbEZhjJ4Lksp5kZDiiQ83oQKjc
	5PBEtUby8oPReRZa3zYJblLlV/8Ygj69dAVCO6+VkMAbhTVKQOjBkr/YDFwyDKTf
	7ahtyLuP3VKBAnjVHKvnNBPLbs97rC+7iAjIx64JB0EzYpiz51H2G2FqC7qDSH/t
	xl0big==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8bev0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:33:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a58580a76eso2686931cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752662032; x=1753266832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQWjm0Dvlp+InqqRH1JLvImgPKkONjZ92vuXT9CYs0U=;
        b=JtkroCfkVq1k0VbaK50UDOChtU1JGO84DnIQ77RKHBKoGqPDK6RbCZSC/nTS5SpKd4
         k6R1yZupYW4hZ6zYNG/U1rpjQDMsTQvoFk+CEiNupUnrvieW7oWA4RGLTqURNo8ZvQrO
         YHmBu8PwjkkBaerCKd2hDCWcRCmaGh9R9U+aThSFOJLvTrI2LB8Kbmp5gj4IxFIfLmLD
         XpSdjoNNezxx/OCenBT5IGDI0W2C8+mdj+OduVfRYUM2Owi7bUS4wTqgo92O1wMy26cO
         af4tkcxNgaG2zkUlEeGC+uxtxmH+wIYkrgcNTikzAB0dCohRBLPN6o0+6BrJ418OlrfX
         C6FA==
X-Forwarded-Encrypted: i=1; AJvYcCV1e5fIdpTWzGDoIXfG+y9yZGIjSc47j+kjbvKjQsl8wHw0WAMch4iK8IR2+pE2fBLOOYfAQvLhhPcD9gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLqWsYTjheiKGaODrdMzM69DMDus+M1bMrDA4ti6nQZPnpwscO
	V0Bk23PH5c2PD7rBwVfO8qdNkhy2R8AdlC7mij9hkXN7rc8ozBRdwX2GOQQO9e7PyUHHw1WbDOo
	euvOfytuXWyvAr5UhP4v+gstQBOrTPGoabJfl6trCLwYnCp63bIOIQzPCt/cAf1o+9PQ=
X-Gm-Gg: ASbGncul7iX8Vj9UqynZiBozNfKK0VkVBhtKSV0pR4b0kUHOMZmuEyqK5zZ0X03WPZr
	NeRRIOzEbzgNf26lxKbTnGXvMJtbevGhpbnXJGWxDaPaFzq9IvW3RopHz7g225ch55JiPIC355T
	WguSmGTYGAEFVXJUD9odOi0zEB/+RmnJ7SqwP1aHkW0g+oHAJrHRXH54nPccCQeqFkiYYWlEHze
	BdwvvI3z0GgO6LB3gJ+Z+kHKz6ebcDQC8d7zl6gn+defBB+uwU29Hp4Pu/oMXzzaTREN8BGaBCx
	syDjaCZk6DppFE449lNR2DulVo1rL3mbC1T5cGlkP9QWZNAnqrh6mJJuAC3XerpoqJdg1WqpVLu
	isqqA2hbjk2b4LtQCkGSm
X-Received: by 2002:ac8:59cb:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4ab90a03e39mr19146571cf.4.1752662031706;
        Wed, 16 Jul 2025 03:33:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdB6bmCEgOE0icrNvcrOL072N5aMJQu4mPh7GiTS65k9BqW2Tqp2thoRg78AORFwjlaRT8pg==
X-Received: by 2002:ac8:59cb:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4ab90a03e39mr19146291cf.4.1752662031295;
        Wed, 16 Jul 2025 03:33:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee44d4sm1175223766b.39.2025.07.16.03.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 03:33:50 -0700 (PDT)
Message-ID: <e0553625-2864-4d9e-89ef-fab44fb18be4@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 12:33:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI: qcom: Move qcom_pcie_icc_opp_update() to
 notifier callback
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-2-7d04b8c140c8@oss.qualcomm.com>
 <b2f4be6c-93d9-430b-974d-8df5f3c3b336@oss.qualcomm.com>
 <jdnjyvw2kkos44unooy5ooix3yn2644r4yvtmekoyk2uozjvo5@atigu3wjikss>
 <55f2e014-044c-4021-8b01-99bdf2a0fd7f@oss.qualcomm.com>
 <kyu4bpuqvmc3iyqekmqvbpxqpbbxbq7df725dcpiu3dnvcztyy@yyqwm2uqjobj>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <kyu4bpuqvmc3iyqekmqvbpxqpbbxbq7df725dcpiu3dnvcztyy@yyqwm2uqjobj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5MyBTYWx0ZWRfX1kWViZTh2XZM
 i/29UgD+8zU4EnVJx/+m+YZuz3iZClJE4bmsadg/TN2G6Tf/w75NU9hflmqKJ80L26tfvvjdCeu
 yc3J4Aoztr79futIx6WZ5IkzeCrng8bpAcWAmUQxRGoy0QUDl9cp/T9retWBSPVg+G3cP3LCcNe
 OqbJSZz7fqapcdpXcw9UyLOVHLWGa64skw2dYuKaUxu9cmLt1+cgGxn2I5fIc3IsQEHCbN0u8x+
 9xhODOhLCsIsg9oxiPRenctAfjuSL4XfJ0oA3nY0elymMoJMCy+3JhDf+8aM53yUjNn0RgISxHN
 Bp9yBv9Nvlo+4U8rCnTaJBbRi2/YKkvZ+SOLqJKxfdptregRLBdBy78xZ5KXyiNPIRFH9wfr6od
 hIdNXZA+yKywgodiKUC/oeljOxXI+VoJ9VqzlNMUzwkJc1u+sMTxxa0UQ0IMovnC2BTvf8Z3
X-Proofpoint-ORIG-GUID: V4-U0yKbpWBNkoshg3jOrGN1yXgGOzbj
X-Proofpoint-GUID: V4-U0yKbpWBNkoshg3jOrGN1yXgGOzbj
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=68778010 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=EnMyU6b1km1a4ziX4qoA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160093

On 7/16/25 7:28 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 12:45:36PM GMT, Konrad Dybcio wrote:
>> On 7/15/25 12:36 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Jul 15, 2025 at 11:54:48AM GMT, Konrad Dybcio wrote:
>>>> On 7/14/25 8:01 PM, Manivannan Sadhasivam wrote:
>>>>> It allows us to group all the settings that need to be done when a PCI
>>>>> device is attached to the bus in a single place.
>>>>>
>>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>>> ---

[...]

>>> Let me think of other ways to call these two APIs during the device addition. If
>>> there are no sane ways, I'll drop *this* patch.
>>
>> Would it be too naive to assume BUS_NOTIFY_ADD_DEVICE is a good fit?
> 
> BUS_NOTIFY_ADD_DEVICE is not currently a good fit as ASPM link state
> initialization happen after all the devices are enumerated for the slot. This is
> something to be fixed in the PCI core and would allow us to use
> BUS_NOTIFY_ADD_DEVICE.
> 
> I talked to Bjorn H and we both agreed that this needs to be revisited. But I'm
> just worrried that until this happens, we cannot upstream the ASPM fix and not
> even backport it to 6.16/16.
> 
> So maybe we need to resort to this patch as an interim fix if everyone agrees.

I'm not opposed if there's going to be an improved solution next cycle.
Having ASPM 99.9% of the time is much better than not having it at all

> 
>> Do
>> ASPM setting need to be reapplied after the PCIe device is reset? (well
>> I would assume there are probably multiple levels of "reset" :/)
>>
> 
> I'm assuming that you are referring to link down reset here. PCI core takes care
> of saving both the endpoint as well as Root Port config space when that happens
> and restores them afterwards.

Nice, thanks for confirming

Konrad

