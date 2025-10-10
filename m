Return-Path: <linux-kernel+bounces-848645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478FEBCE3E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CDA1892BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B52FF64F;
	Fri, 10 Oct 2025 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRLRSjuw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F144299A94
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120945; cv=none; b=JiCNA3I8e1xv9VXbRdiCAytndGJnD6VWlNcxuz+Fnr+TbJ3emKO1NKSyPnRl0teNn2ofPIv7Ber47LbxLQVKIQvD07Iv4P1jpqhP9em3to7Td2eALtA6vi+OOBegzRoEX5nJkOKIR7nQjKGajocqtYuAFU8LpiBKHYt4Tohwgf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120945; c=relaxed/simple;
	bh=DDGFgNcpRXXs5drDknCOk7ZT+jZa1tJMMOq5dszvroo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjyGAeGcnyo1N+ztpFP3ObY9ti0b9k/wLhnfHz1hP/oZ2tCQ79BPZHO4QsHGt1Ough7AC0QAyBVrNBWgNoRo4ehwnvzbOHeOEBKlnYFe4/+jTTzsUr7sDX7QdmSBWDpPiLmEb1lNfyY2vrW+rhJCtI0Ry7K+4j78UjU6tI3zfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRLRSjuw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AExixx009932
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dMas5ueTnfbR6ogwJDvGtBET5Zhd3Y1zcYOGGYAo7eA=; b=WRLRSjuwy/30kckx
	lUlmPjjISE+Oc+T53aXKK8yjijNhLGKAdhrajBwPqIcZrrPhzM7aMXm5F4p6DdDc
	UDl29/ajikFx0MESr89fC1/HeWYCv6fi7RSKTI1kUuag4TVql0CwY7D3X3dPjuP4
	WYAYUitFYyFVHg3Ru4uEiSwlDHYXogiyyohbO/eQdJYWFaueDnAkF2NiRpcV0QZf
	qke9TQsrjZOm9dguouFN5ZE63ATbNl+HH0yYBepSwzKuES+rDWsucSlVUEp6xsoz
	/x6VJeRizTjasHjaOK7fHHF/G1j9xbCC+IKAW7LqT6qPrFsS8dWYUSyLzEg0Ixwu
	lVv9yg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nydfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:28:58 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8572f379832so89305085a.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760120937; x=1760725737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMas5ueTnfbR6ogwJDvGtBET5Zhd3Y1zcYOGGYAo7eA=;
        b=eYRlkL/5CXQ8FDudxASPVNDtfovxCbYAIs2FuoqGCwkINpFvPjqjlDJkBd7P9OPJkm
         IEa7RkE0dsXfsj5nPJlp6aX9O0W32NLqKBEVOeESokkkzPgBKYoa/4IubN2R7XECbLvY
         8RCAPse7+ZdCyqrc+GT2Iu5nDYbUOZNFQOAL2lkPNGBknTzTcP29BpR9lmf/wzL1fl6G
         z2tlU91/h55zOQJYpYQVALBljhL23l2uTbTpdipaPYJBYRKoAnk01xxYvuoGN1Bj0/hq
         Nama6Z3XvSKbgADn5OkjQfc04QxRaG8VhDAajv0c+7TzM6AcG9dDFIVIUzHthElT86Mc
         MtiA==
X-Forwarded-Encrypted: i=1; AJvYcCWxMiJlqWcXs2tdHBJI3DQK/XocFYy0U7Sipp58f8XtqxjwOP9mDt/fgBYwGlYAQlWF0fXbyN1BZb2kGYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUJSsMEOg2di5u69UaUZoP28/i1+EmLBR18ntmgYVs1AHL8zE
	Gc6bA8Az4XQT5tnIwajPmRzPvlRy8VNvYQo+PzbFNZoomOLyJa/9v/RK1I2G3gajjniPrhRcJyn
	FTbNR2iDRTSq7gcJNucogn7jLU+8UNz8cD0Q3HHt6JmjyCQSIxu1rj/GLAD3pY5uTUNc=
X-Gm-Gg: ASbGncvn+054gNt/BrvUohmJ3q6qzkLik00GX7h3H5RBUOBDWKVVOFXo8cWNBETGYS5
	rKAbkpAP5NUyhIMfujPpaft1cU/5sEyNPqBnXmz5j1MEaKtUP3euLOU/kftRX9YB3UXYGpZHBXo
	D8cLWpz4XL7f7FGGRrwQW7yfYuRQ+Jvh9i+EGbKJ0nUtetikiVHjjFMb/WXITsFqPdY+4GhjoRk
	JJ8Opifoxf7q84X+Q/Zb1xV/zBOB37STiEQGJdcNsc4EEdkQ74iVXTdsdZsyWOjqrUVo0KjzlZs
	/BOri3D+qy/CBATDDU/Mgvd3VajZ6obVZK1Wb0oZF+UDAzWzwDVe4j22a+QZ2fTv1XmEIsd2iLw
	7lbHLdUUZS9AmDeAHt5Ceww==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr1201123785a.8.1760120937388;
        Fri, 10 Oct 2025 11:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH4ijfK86so2oQgbaGVcntvQ4Ssr8eaS2Emg+YzBaOfN0x1ZloTX9mbEdoCPNs8davYPPQ1A==
X-Received: by 2002:a05:620a:4609:b0:86a:3188:bb40 with SMTP id af79cd13be357-88353e1de97mr1201119785a.8.1760120936880;
        Fri, 10 Oct 2025 11:28:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c133f58sm2911251a12.30.2025.10.10.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 11:28:56 -0700 (PDT)
Message-ID: <896b58cd-9a13-4b7e-bf62-e062728d3e53@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 20:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: PCI: qcom: Enforce check for PHY, PERST#
 and WAKE# properties
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251010-pci-binding-v1-0-947c004b5699@oss.qualcomm.com>
 <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251010-pci-binding-v1-2-947c004b5699@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 74SS8OIzqw71FuaMJoq3ISLNY9bm2o8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX2ozBra1EpVi8
 6AB/NHzh3RGbphFYWj70aL6CmqaJM1Y55hXwYKzXHIj6usYRHMUMDIde0ZANqwxTw27I4c06/Yp
 uJzoY9GNYghk6taPdpUCnoIuaUvbh4k6LGRJcNqZ0nmyAGFIBG2WLLmcem0+bwtorqes5j0Fkn2
 EaXJVJP0R1SUO9eWdw9IZyPiBIY5T1x2RIMqCqGgViSz0uWL7RCRbCov4l2WafFg6d8tJc2vC59
 /7YUu/VY2W6Xe/P1O8eMQZjcgdyx8lhGnXiNEi69E0KDjyB14FM3bHxb704W6pW16NH1t8aMtTT
 Naz9CIpfRPY6dl9RZlQfTQvZSJC2NWiPbASc8OWNnOB1cJbL0iazj2CVPzU8x51ABr8xnwJLdQD
 wUnxhsDzRA9nc77uqnLGjFd4vw+tEA==
X-Proofpoint-GUID: 74SS8OIzqw71FuaMJoq3ISLNY9bm2o8w
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e9506a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pqiSj10MyONZ7g7U9k0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/10/25 8:25 PM, Manivannan Sadhasivam wrote:
> Currently, the binding supports specifying the PHY, PERST#, WAKE#
> properties in two ways:
> 
> 1. Controller node (deprecated)
> 	- phys
> 	- perst-gpios
> 	- wake-gpios
> 
> 2. Root Port node
> 	- phys
> 	- reset-gpios
> 	- wake-gpios
> 
> But there is no check to make sure that the both variants are not mixed.
> For instance, if the Controller node specifies 'phys', 'reset-gpios',
> 'wake-gpios' or if the Root Port node specifies 'phys', 'perst-gpios',
> 'wake-gpios', then the driver will fail as reported. Hence, enforce the
> check in the binding to catch these issues.
> 
> It is also possible that DTs could have 'phys' property in Controller node
> and 'reset-gpios/wake-gpios' properties in the Root Port node. It will also
> be a problem, but it is not possible to catch these cross-node issues in
> the binding.
> 
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Closes: https://lore.kernel.org/linux-pci/8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

I would also like to add

Reported-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Since he originally made me aware of this issue

Konrad

