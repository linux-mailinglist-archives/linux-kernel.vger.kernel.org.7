Return-Path: <linux-kernel+bounces-877496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A358C1E3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54CF84E471D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981032D7386;
	Thu, 30 Oct 2025 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ff7b/zPO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="am4a+kn9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409972D1913
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761795823; cv=none; b=JOVylhIpRZcF3JtjjzBn0UZP2dhrwax81DHhkmjsc14py33L1OfLHMKzGNhJmwT9ae9mNsjEvHeNcbuxlfiNLVi130rv5s5aAcpU3jB5ENZgsqWtS45EUgP3+vosL95OwfG0lPFYkSvBteiHDuP7ejwLKsXZlrnrSWyNbgh7Vnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761795823; c=relaxed/simple;
	bh=syWr0hrchEYBIUz0nvESOsKkTCKM8MAjLs9LG9A2Ri0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Duhs7STa4tAsZAz3gNVeWKuERoyO2CU8sfIWSITnYLrVTFzFWPohtxv/HpTuOU0eMOJ5VG7eV9khXbxVO2bl7fLpM2Qn1kvmdCxz1CK6NQ9Mml3K7JKWsaR94JYB4XPvC4S3OLNEBdgnRerNmgg2Ylfi8Uj+6Xg8P18qat1l+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ff7b/zPO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=am4a+kn9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TLT9ud568891
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=; b=Ff7b/zPO8tvJceRY
	Cy74AMHIYHiNdUVuJcP4f/lSQDyMMcebAS0DE7AeVm+xAKnTzShtg34YkxNy/wdt
	0g/NgpqpoAnJcIwT+n9clchm94r9tbrElusIK7GlLiRc2pz1AFcKCCUJFZpQCbHb
	e2XH92o1WH8HIESZAW0yg4FczD58ri60/EcSr39tD7F2kPSrT5vBlNVHNi37cCeE
	s75H5V6v6imgELujCXf9R4NerDgKzEjBRpO/HBLA7QXsuw075f/x6sEFhGWdAZcV
	aTVcBDFbMl/YzO6id4gLeaZXeFKzfoEj8DDXlNudFrRmuwCUptl38Lt66V1h83z9
	QLLDUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3m0bjc5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:43:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290ab8f5af6so3836205ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761795820; x=1762400620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=;
        b=am4a+kn9pM3fQ7lSfl9eDgL7UcHRBU0k8iuEBI9mSGpI6iIG0IxuzNzxGrQYsRY8ow
         +8ZF6Bb3HSbqBjzFzTPcqJH1eY8VYXXVa8WwELqg/yr7ul71zsbsKjHNRgBvsXCFVYQ3
         2e5L6BTzVobh/aqOtcOG77OH7Zvp83U2f/QvPs373V2aINt0U/MIbhlOp6b3IBQ73WaC
         y5s506DuIJDJrt+uOJPI66VPSb4+sU65XdqqqDeOho4skt/MNzBijB9WF14GlvH/OXFB
         GjOL5sKWZwcwvvyqOihTezNqPjWYTlimnEndhR6U0t2d6S2mrBjyQSy+kXRo1pEc4my2
         frcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761795820; x=1762400620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSWFWmnOzX1VHAiA276NE1gVjUwB6rf3KGgQY67Spo=;
        b=WYJdQAtOntVD4g8me2Wi9OZYpXgpdlkLj3sU0VOdo7JbQNLbxH90mRr7lOASIqoSuN
         YSLE7H/lC+3t9+GKSQPziaXErhVf91C1NLtKyo4KSM+app1JO1rycCnjVynPq5W8maL5
         j+IkQY+lJ6pkGCgy+MF+uBkRKtw8CNrgonDCVTlI3mY4ACz6c5oMvBOUV4/RVZR4/eno
         hnNr+g66VzJLSkPb7rCGCLdrLNgR+AA1jzcl4ZXlFx73x+DcU1FFfG8lcK3pb9hJJYin
         /J6EBIQGuiJJudEz63oadd1E+/PmLzCXpuMigWjVzESG78TKLQNIRPMV/vZ4h6rhDwOW
         iM0w==
X-Forwarded-Encrypted: i=1; AJvYcCU58UVfo5Pzn30M906I2xj7+L9BQmFFSx2PofpMWp3+1h+B3U4IT7PxT1s6neYmHjQDnyaE0uIXV6yrIsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVymj0f63mxixlqAc9G6ECO1WTI/GI1/M35LFX2hwPHxw0VLBn
	AgZ1BtsZOJs3TwVvMiU6R0rMH9lGWJsYVVlUN/nFO5MWHrWUF7H2df0i+WUTbd1vufK9wLnIato
	IIpOHfKoZBeW+GViLRKJaUtZa0LibE38nxTbqrbCDUx1GVaf6q2qGHojnzZiOwGyuTzM=
X-Gm-Gg: ASbGncsE970a9Uyhfj/b1dzznTVfsAarZ6NaAbvuGLpkXZpWCQOK2bT8X6294l8413F
	ZH1yWYBGGUaoHaI25n+cpqYsJJczjCNd6Rwu1UjEEanVKQxLACHd3glmDgyi+DwY2UmV9tZD7nf
	sG0jkCa5HB3mrdyUkIOxBTAUBti0jqWVrsUwmwvvktY69JocaBKzv5rAh8Gl1S/m0w/JLIGecmt
	xN6CEWSI6QCnJ/8MJ9k0cySO1PsXf94gPTAEnK7yySORuThPF25yxQpRwuVSIbPti8w7zsGmmBA
	CFRSUGJRyWD0ViPJyxaBshkmSErjZDY0DlHpjIAnSUn1Ffk66kEma9qxUcOjZY3wylXr3XceBlp
	izC/2vgksK+Wmz2TIQqYouOtA/Umhfrg=
X-Received: by 2002:a17:902:d487:b0:290:c07f:e8ee with SMTP id d9443c01a7336-294deee23a3mr66507365ad.43.1761795820117;
        Wed, 29 Oct 2025 20:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG8Tsm7zsMNvRb42NpHg0S5cqbhX8hvTZ+lzZFtUmt1DssbzW9YgQ30jiCbWgwAcLvsjL2Pw==
X-Received: by 2002:a17:902:d487:b0:290:c07f:e8ee with SMTP id d9443c01a7336-294deee23a3mr66506845ad.43.1761795819628;
        Wed, 29 Oct 2025 20:43:39 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2333fsm166960675ad.50.2025.10.29.20.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 20:43:39 -0700 (PDT)
Message-ID: <3dccca2d-272f-451a-9e38-901a6fa3a24c@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:13:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, amitk@kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251029232323.GA1602660@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251029232323.GA1602660@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BhLNhbnoYYzZmThBJXuROQeQ2XhCCTzD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyNyBTYWx0ZWRfX8UtcaJb44Dt9
 ZOXONX2sIs0x4N2wBW26rBVU4U/xt3ssyoNKsVubcGVvBrGS9WP04PAYb9S5Ge1/5noRpM11Nkn
 ulDQA/e0hMA3GaeiuvUBmneQzoUIdSfibapGHe+si57FIJicdpoq4vq4w2lMssyfmLcAJdW+mLX
 /6uF8hG0gut4KUqzWqXjgjjJdHgXfdxJZRCAI+9iYUNByp56cBs0OnvGuJH5BPQppj/sVSgeg3H
 EmwBszLAWLK4SWnpv6z3KxKyFsI/YoNbaIXZQYkqfd6AFd2WhcACV9cXc7t8Q2yeetjUNvKAT1H
 bL5cySz3aiGobhxgWsRHo/GtYH/D7Pt80ilGUKSV/DmMtwWLemZVihi/VL7vI1ADPtuRdXC5rYe
 klJtsNdQrzEGXWkspDWsb2XYZ6ZXSw==
X-Proofpoint-GUID: BhLNhbnoYYzZmThBJXuROQeQ2XhCCTzD
X-Authority-Analysis: v=2.4 cv=YLySCBGx c=1 sm=1 tr=0 ts=6902deed cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FxhApbZLZ_QfhaJha3gA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300027


On 10/30/2025 4:53 AM, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 04:59:53PM +0530, Krishna Chaitanya Chundru wrote:
>> TC9563 is the PCIe switch which has one upstream and three downstream
>> ports. To one of the downstream ports ethernet MAC is connected as endpoint
>> device. Other two downstream ports are supposed to connect to external
>> device. One Host can connect to TC956x by upstream port.
>>
>> TC9563 switch power is controlled by the GPIO's. After powering on
>> the switch will immediately participate in the link training. if the
>> host is also ready by that time PCIe link will established.
>>
>> The TC9563 needs to configured certain parameters like de-emphasis,
>> disable unused port etc before link is established.
>>
>> As the controller starts link training before the probe of pwrctl driver,
>> the PCIe link may come up as soon as we power on the switch. Due to this
>> configuring the switch itself through i2c will not have any effect as
>> this configuration needs to done before link training. To avoid this
>> introduce two functions in pci_ops to start_link() & stop_link() which
>> will disable the link training if the PCIe link is not up yet.
>>
>> This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
> What does this series apply to?  It doesn't apply cleanly to v6.18-rc1
> (the normal base for topic branches) or v6.18-rc3 or pci/next.
I sent this on top of rc3 as we have some dependencies with latest 
changes i.e ecam changes in dwc driver.
> I tried first applying the patches from
> https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/,
> but those don't apply to -rc1 or -rc3 either.

This needs to be applied on the dts schema in github, it is already 
applied I will remove this reference in next
series.

- Krishna Chaitanya.

>
> Bjorn

