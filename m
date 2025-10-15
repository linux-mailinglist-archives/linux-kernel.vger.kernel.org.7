Return-Path: <linux-kernel+bounces-853592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B47BDC0D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183F4188EFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C3303CA4;
	Wed, 15 Oct 2025 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i2E5z5A1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1C53019B9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493043; cv=none; b=Q5PN43AVqb73CVDGuhHBeac8H7l8g43mxviNai4cEYQLATX9d+Zm7DxRTqtjEARL3LrwgRgc+qxdmdYoP5GgbRhANqz5xj83RDSsJkRPO0yviWEjcuJUy7/KrjPu5Yauwnsk+XCWMxNHrSpHODkGNntkS3Q89eSJYWzmjF4+ztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493043; c=relaxed/simple;
	bh=gNxKy/NFi3oZdFH8CChq1eOS0b44Am5j10TI+FhWK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuamEQupyf8aUhyGBQr2yz+T0voD5IOH3f0Lfx1rQad6gAq67NHH+eQbe1FyUG2id16CF1Cvwk613D6BzQ7iBZVpbHXpUqFS0VxHtPiY9JmGTcUYLb6+sPifTzis8zD1Q9fVEv1YPRSd00Y80JLZFKNVEmDpx/xsEHR9TgtVgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i2E5z5A1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKRCV6013463
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UMEzdqx389JwWZAC4l4+WiOd
	cOP/xrB76GzYftznSis=; b=i2E5z5A1AJr+3WMXNSpHS5OQmEQ5TI8D3PaJb/aP
	VEJ3AWrvK6LmI7BmQzaTUQsU0TxenSwIb0iJN9Dfme8KZ2rfl+eKHG5JcF5abg9g
	5BN45OESyyfyeSaXKdeq7+aZcYfRjE31nh9lIuFWoAIbfvDF/09IfwAMJ75c/qON
	0fPJ80iUNH2ESJeEEo1UMEZkz9VX//KwjqGK8HxArEFmGWqxH7v0oeLsigrFWA7n
	TQyTlZWLcvjf/l9+ZIcgh7V4NacRhYN8NkxsLlJVFUTCKI6J0Nj5QAUB1W0NDhQa
	xhEAZVfwgkPVJxFceitZGFAR5DQiKeoXCn1cgP6lcQDJVg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd92qsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:50:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so16216148a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493040; x=1761097840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMEzdqx389JwWZAC4l4+WiOdcOP/xrB76GzYftznSis=;
        b=ce0o3SSC9GY38PY5tQ2kshd7PuQ2n3kPDeXRy+h7yEFkHOqcYhF2IqbncxgDPXpvE8
         k+Dp01nlPrBdhvPqjNVPNxUQW8Ll6aE0vfQdGgno+dxNNbjVZUOFZxQo/+4b67t42z5/
         5DPwgoxVscvpzRKkCCsi1zxRSyy0QMnIy4umnb6/penf+rS1gvtKXNKFQFOld8C9h1SP
         8ezhURW3/EyU5aT1clgG2tUDikNvoZ54fQHAuJ/29A7GmEdNtSGydICVwk5Q+FhbY65v
         BhbZUJjkA5UdEEqAdRKKic70RLFpzQIkCpTq1tFI/ZTYnz67oBVZypOptKlBF/Bi7oR7
         t/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXPFTyYk3SGeaESefV8NANZnsxpGKAIXV30bZhplLFyc8HpTlRt05Qno5QjgTPjfyY7fFITB6qQkzGBIjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPPwG1cfIoHl6KERvzcD9xY9+5HLMtKVczSkgwVh3utHJaN//
	VjZnmI2gdE9poa6VCtWGgEFKEVTq8byv/0YVKK6shv9ZnTmWQ4kHOGzi00MZV6wLd6hj60WmoOc
	9LN8RW+pFpW6cK+6TmddjWnjQSdD842MQPRGIVaNfnQJGt2oRt5tiZX1dD1eQ3VcgiME=
X-Gm-Gg: ASbGncvc5PR4fzkiLwAN4hn47U9xZtlrtXQNsPvb03PBbae0W7Bqn+XzIsImQR+CbBY
	c3YuLbO0yt1mIegrop6hw5ogxudRQvABZTLFO7GWYempp3/NpPDNfZRWgphKUQ6kJEzKoF+Oh7x
	ITJP0GXGgZb9sPvlvOWkugG/56Ahj5UuF67eKpiM73EFIZSUWAiaiMtKxyrYESh3hm+gkqKvqiN
	/2oFCdotlLkUuH5+LwfJbggl6/aT0Nu64MY9rcxpWm1OzZ0YSpz8geBz7a53JOCPWIjDOYQXjVe
	GMGPATGYXMF27jzfbZ8eVuVepGdm7wzY6YDTMULk/rWkIpxLTGtR4Pq9meRF1uGxhMGzybllmp/
	dl87P0aNI3/Q=
X-Received: by 2002:a17:90b:3911:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-33b51106b22mr34954005a91.1.1760493040375;
        Tue, 14 Oct 2025 18:50:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnWtUi1/KGA/NsDwkjYP6WaNDZmXwB3TkYReHzrYgQhIYsKu3zKwyltFcVs6Z4M1leDOIagg==
X-Received: by 2002:a17:90b:3911:b0:32e:7512:b680 with SMTP id 98e67ed59e1d1-33b51106b22mr34953966a91.1.1760493039927;
        Tue, 14 Oct 2025 18:50:39 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787a0d1sm317573a91.19.2025.10.14.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:50:39 -0700 (PDT)
Date: Tue, 14 Oct 2025 18:50:37 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: PCI: qcom: Document the Glymur PCIe
 Controller
Message-ID: <aO797ZyWIrm0jx2y@hu-qianyu-lv.qualcomm.com>
References: <20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com>
 <20250903-glymur_pcie5-v4-2-c187c2d9d3bd@oss.qualcomm.com>
 <w2r4yh2mgdjytteawyyh6h3kyxy36bnbfbfw4wir7jju7grldx@rypy6qjjy3a3>
 <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dadc4bb-43a1-4d53-bd6a-68ff76f06555@kernel.org>
X-Proofpoint-ORIG-GUID: WoMSIh8FP5LQIL_fb3V1LHLIu4LAs8wc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX//FgQvRiSwIi
 /tW3tPUgdNnSCfDrgXDlh+DXhCLioyiZGwybYrkUezHDSy8Ztn+J4PTCImAUHT4TUZk0IA1SmzE
 e7iUJFjoelRib1tuHA3Kyz+/diIlv5nb1vVx2xamRXe1q2eKvogM3Di3kM0iJK6coMice4yNsAD
 qDaPlq3gt5FfSwEWdu5aeUjwVNL0nbsGUMS3u3p3bCEojZ7RDJ7iMxQZqMY2YXPHyADBGkD7PKZ
 MW7WAysOOiTwhfZefgnfl5MztOOmyvC9yQcxD+AypMaQ6GY19aS9fMUiYb61iPXwQmPre/qesCH
 AW4RAnaAmCf+RZuwK55vX9aWwa7nOxIpdBuR4DVY97BvroHpW16Cd/rimtaazQrg5jL9Sd/othk
 KeEs1Bmod3Z+2iZ5Qyo3IeiuwL9/fQ==
X-Proofpoint-GUID: WoMSIh8FP5LQIL_fb3V1LHLIu4LAs8wc
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68eefdf1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=DgPuKSVeHQMGQ7iqIbYA:9
 a=CjuIK1q_8ugA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On Sun, Oct 12, 2025 at 05:01:45AM +0200, Krzysztof Kozlowski wrote:
> On 11/10/2025 14:15, Abel Vesa wrote:
> >>  
> >>  properties:
> >>    compatible:
> >> -    const: qcom,pcie-x1e80100
> >> +    oneOf:
> >> +      - const: qcom,pcie-x1e80100
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,glymur-pcie
> >> +          - const: qcom,pcie-x1e80100
> >>  
> > 
> > The cnoc_sf_axi clock is not found on Glymur, at least according to this:
> > 
> > https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-19-24b601bbecc0@oss.qualcomm.com/
> > 
> > And dtbs_check reports the following:
> > 
> > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): clock-names: ['aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'noc_aggr'] is too short
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > 
> > One more thing:
> > 
> > arch/arm64/boot/dts/qcom/glymur-crd.dtb: pci@1b40000 (qcom,glymur-pcie): max-link-speed: 5 is not one of [1, 2, 3, 4]
> >         from schema $id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
> > 
> 
> So that's another Glymur patch which wasn't ever tested?

I tested all of these patch and also did dtb checks. That's how I found
cnoc_sf_axi clock is not required. There was a discussion about whether we
need to limit max speed to 16 GT and I limited it. I may forget to do dtb
checks again after changing it to 32 GT. Let me push another patch to fix
this.

- Qiang Yu
> 
> Best regards,
> Krzysztof

