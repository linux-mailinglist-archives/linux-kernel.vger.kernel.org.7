Return-Path: <linux-kernel+bounces-673254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE7EACDED8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9611899009
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 13:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671BE28ECF6;
	Wed,  4 Jun 2025 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hPftu2LN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE8928ECFD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 13:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043167; cv=none; b=ZUbqRcZYhm70Tmkq8ESB3N7f1bHVGqJgoa1LQ+Y0vF9CuFJloI/k71r1aKvcqIHP/ANN1MY1p/5FSesa3NVAS5T3b2R7AIBqGbcG2BwJoXiY7vLuecgWV6+t5QHbhNGzT8KU/MWUfmyS6L1Cv72YV9yRnmkLidi2XGm5Qy/pM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043167; c=relaxed/simple;
	bh=wTGQA2MQdl24nKqbtgv4fmUZIT+gcMlYHT8VuLVGmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMeru2pVeNkNFlpKGgPQWdgbOPKYjDHlaCllVRYTOiGW8dysQrYCSehORCgcGpju0U24Uli/bH8jvGdR9KriUs2VN0sCxjbcpJgOGxMEplD/vOVO6CgTr9jCX/TG1jmSFBCyOY9+sEhywRHbG+urjnQ/QpXq5y5L/2bB4AyGW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hPftu2LN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5548A6rU006553
	for <linux-kernel@vger.kernel.org>; Wed, 4 Jun 2025 13:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AswgeJqCiwnzTJPIuOWk5TVVklGP7eakncy9+WM5WK0=; b=hPftu2LNVjzuOYgD
	QJLJSz8nBlytT11l5owXfIWEpJNojejLBK84ukSOs7+9yh9+q39+jmsjdLxKwIBC
	Kt0J1UDIZva9G+acYtDQ9+B0hHlop22mmQAI7kmJbYJCsfufLORoce9gNAlR8h8E
	6uIxS4p11HlvdiUNplzVqllCuOmlU4SHjWcxM23fxZe9xxvx+IK+QXNL3Lwg1i69
	YPTjTai975aW/25RBnkjnpE/CzmEQT3BVC1tRP2q/ea6ex7JsGndZDfXcDeVRkNZ
	+woW3yYpJKV9MZqdtNR2BxPpQ+gDCqGu8nfi+K9pmQtTTnn1TI8r+hiXkI+4OEDp
	b+u03g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8sx531-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 13:19:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d2107d6b30so294825785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 06:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749043164; x=1749647964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AswgeJqCiwnzTJPIuOWk5TVVklGP7eakncy9+WM5WK0=;
        b=TyHrZeVDuaBmCftwtDpjHSMHZQiUMKIQCMP7C7Jg4n26IiJaLmvE5xhR6Ak2by+7p9
         QWWrScb/je/n7sg3XQaXwfUeQsHVuSr1OVqmiwbVNpbzaRBcLsicl78v/KOSvj9TS2Ao
         ytqALPuZ41js7gdOTB0Kz3jgMIlqEK7GiDZSCb9F+M32aiO/6j6mFDIu7eyALajXal5s
         Iqpb+nje611KAGy1jjtLdDm9HgFUVNig0V+MbbEY5Ej1/VO9IeG5F3EyASDSkuv+bSZV
         eMvs7L/JV7tmpWrhrCvKZHIFR5sXEtiXe6BTpQCxcn5gJsJx9Ifrd2jXCBhVIUIPaYhc
         HHDA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/pTvNOqMOGRs+Y4iwXoLUI+P+4Xvv++sCt+VsJTfqu2Cx+ElZ/PeFNSveoeUKFAuu3MSn9TNP1YIwKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3cPWuA5WR9rQmJy5xht6feDngjnpvYz2tiM/H30RFeZxltN1O
	p6jRkfcIMvTTg0sLyQ4FYsMyoeBeHqV3FfPsLVVFeL4Tq+p6VgCatu3u0Ns0vFsZOqO20ZbtzX/
	UKRtk/Aql+qg1ukkZ1iBBIrSMLCQGQtVdTZ6NKTpXeU5Z9OAjHmzpB881XzVx55bFHgg=
X-Gm-Gg: ASbGncvdGNa3zlkKMPGbJQPOPVv17raKbo8D5Tg84wve0WHp8BlkkBGWbFFzHHCSVGt
	IIXOqMLDk8liTR02Wf611UZ4k7duS5doPa5v8cXFIIiDoCDDffR0SA+xIG0y3kQjGCIrv333H3F
	kI4z56n0TtvkzvQDrJ67SUshQyyvg8pExDLY2970CGyferd/pFgO1sIAugATdvecyCVQ1tibW/n
	3N8h5b8M2xjR7ASoGd3KXN9Rs9Eloa8yYv7DHaY0M/4CR+Jycu7uPVWQmg4tnf0VCF5FvlITBg4
	1jWu7ifMkulj4hsKizT/Jy5XyagTK4bM911WkxQ3xj3sC/g+7ZtNwb4Z+SkXwd1KetIxX4H2h74
	=
X-Received: by 2002:a05:620a:17a8:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d21a680f7fmr325496285a.22.1749043163542;
        Wed, 04 Jun 2025 06:19:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxd2DF9ZZitPuPShjI9mgm9ONIB9V2QAlo0khxT5DcL/JlA3x9QRIZjM9V+8DeFW1VeyZ+ng==
X-Received: by 2002:a05:620a:17a8:b0:7ce:e010:88bb with SMTP id af79cd13be357-7d21a680f7fmr325489785a.22.1749043162859;
        Wed, 04 Jun 2025 06:19:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32a85bd25cbsm23502601fa.89.2025.06.04.06.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 06:19:21 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:19:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Ziyue Zhang <quic_ziyuzhan@quicinc.com>, lpieralisi@kernel.org,
        kwilczynski@kernel.org, manivannan.sadhasivam@linaro.org,
        robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
        neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v1 2/4] dt-bindings: PCI: qcom,pcie-sa8775p: document
 link_down reset
Message-ID: <mzubbiwkfshplawugahzbtilibnq3wiy6bqetfarbv4kxw46rs@eranz4lm4bu5>
References: <20250529035416.4159963-1-quic_ziyuzhan@quicinc.com>
 <20250529035416.4159963-3-quic_ziyuzhan@quicinc.com>
 <drr7cngryldptgzbmac7l2xpryugbrnydke3alq5da2mfvmgm5@nwjsqkef7ypc>
 <e8d1b60c-97fe-4f50-8ead-66711f1aa3a7@quicinc.com>
 <34dnpaz3gl5jctcohh5kbf4arijotpdlxn2eze3oixrausyev3@4qso3qg5zn4t>
 <43a6e141-adab-42e9-9966-ec54cb91a6de@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43a6e141-adab-42e9-9966-ec54cb91a6de@quicinc.com>
X-Proofpoint-ORIG-GUID: YLHKuQNDGRKk2Exp8ue8fKK1PDqlM3Sd
X-Authority-Analysis: v=2.4 cv=EPcG00ZC c=1 sm=1 tr=0 ts=684047dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=JfrnYn6hAAAA:8 a=COk6AnOGAAAA:8 a=b_c0941waCFHaVHBhDUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YLHKuQNDGRKk2Exp8ue8fKK1PDqlM3Sd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMSBTYWx0ZWRfX5XvuWOysn2Vz
 Cw8VuCH+v7MqGWmnT2i4z22bChHvPiz20csW3UoNwtPtHRCh33zks7mL1uv+FaBwuHVJ+5JgD1h
 KkAXQBbsvePuHA3pOl225w7J6Buno1MGc/bhvlb4JQkqgF1YBEUleXEVX3ZK2OKu7oZVLEp/NJG
 rS3rUw5ACICDvlp5lpyzafjoJJRYk2EBCtRhubWUeaRAPq+hj0L1og+FB2CeFh/0Y2bjq3r1enI
 F4XM3xXiVbRomH8JnDmQHZCepqmXIoPJgalfMsfNEJU12UbsItZEQQxZX6nOpoVaKerNgnh1zOy
 VbmBoyxW4/xRucgJM2xboxNmxOnJ07sZr668v2TZ2ZELySQPdz3nSZrxDie3K5OrhEwEqwbN4pj
 RYplEH2MGPTQFkZjsDk489gM7etqp7xqd/1lPLClf4DsTUEmq4VYa66PiHfcTRjcnumd507x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040101

On Wed, Jun 04, 2025 at 06:05:21PM +0800, Qiang Yu wrote:
> 
> On 6/4/2025 5:15 PM, Dmitry Baryshkov wrote:
> > On Wed, Jun 04, 2025 at 03:58:33PM +0800, Ziyue Zhang wrote:
> >> On 6/3/2025 9:11 PM, Dmitry Baryshkov wrote:
> >>> On Thu, May 29, 2025 at 11:54:14AM +0800, Ziyue Zhang wrote:
> >>>> Each PCIe controller on sa8775p supports 'link_down'reset on hardware,
> >>>> document it.
> >>> I don't think it's possible to "support" reset in hardware. Either it
> >>> exists and is routed, or it is not.
> >> Hi Dmitry,
> >>
> >> I will change the commit msg to
> >> 'Each PCIe controller on sa8775p includes 'link_down'reset on hardware,
> >> document it.'
> >> "Supports" implies that the PCIe controller has an active role in enabling
> >> or managing the reset functionality—it suggests that the controller is designed
> >> to accommodate or facilitate this feature.
> >>  "Includes" simply states that the reset functionality is present in the
> >> hardware—it exists, whether or not it's actively managed or configurable.
> >> So I think change it to includes will be better.
> >>
> >> BRs
> >> Ziyue
> >>
> >>>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> >>>> ---
> >>>>   .../devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 13 +++++++++----
> >>>>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> index e3fa232da2ca..805258cbcf2f 100644
> >>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml
> >>>> @@ -61,11 +61,14 @@ properties:
> >>>>         - const: global
> >>>>     resets:
> >>>> -    maxItems: 1
> >>>> +    minItems: 1
> >>>> +    maxItems: 2
> >>> Shouldn't we just update this to maxItems:2 / minItems:2 and drop
> >>> minItems:1 from the next clause?
> >> Hi Dmitry,
> >>
> >> link_down reset is optional. In many other platforms, like sm8550
> >> and x1e80100, link_down reset is documented as a optional reset.
> >> PCIe will works fine without link_down reset. So I think setting it
> >> as optional is better.
> > You are describing a hardware. How can a reset be optional in the
> > _hardware_? It's either routed or not.
> 
> I feel a bit confused. According to the theory above, everything seems to
> be non-optional when describing hardware, such as registers, clocks,
> resets, regulators, and interrupts—all of them either exist or do not.
> 
> Seems like I misunderstand the concept of 'optional'? Is 'optional' only
> used for compatibility across different platforms?
> 
> Additionally, we have documented the PCIe global interrupt as optional. I
> was taught that, in the PCIe driver, this interrupt is retrieved using the
> platform_get_irq_byname_optional API, so it can be documented as optional.
> However, this still seems to contradict the theory mentioned earlier.

I'd say, it should not be defined as optional.

> 
> >> BRs
> >> Ziyue
> >>
> >>>>     reset-names:
> >>>> +    minItems: 1
> >>>>       items:
> >>>> -      - const: pci
> >>>> +      - const: pci # PCIe core reset
> >>>> +      - const: link_down # PCIe link down reset
> >>>>   required:
> >>>>     - interconnects
> >>>> @@ -161,8 +164,10 @@ examples:
> >>>>               power-domains = <&gcc PCIE_0_GDSC>;
> >>>> -            resets = <&gcc GCC_PCIE_0_BCR>;
> >>>> -            reset-names = "pci";
> >>>> +            resets = <&gcc GCC_PCIE_0_BCR>,
> >>>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
> >>>> +            reset-names = "pci",
> >>>> +                          "link_down";
> >>>>               perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> >>>>               wake-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
> >>>> -- 
> >>>> 2.34.1
> >>>>
> >>>>
> >>>> -- 
> >>>> linux-phy mailing list
> >>>> linux-phy@lists.infradead.org
> >>>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 
> -- 
> With best wishes
> Qiang Yu
> 

-- 
With best wishes
Dmitry

