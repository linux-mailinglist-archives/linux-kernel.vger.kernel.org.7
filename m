Return-Path: <linux-kernel+bounces-864612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F13FBBFB2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 979424E41E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2711828852B;
	Wed, 22 Oct 2025 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p7muIRRM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DB2877E6
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761125704; cv=none; b=FePbdNU2g6tJq/jyxqb8n+EWJ5ZZ6MTEv8Xb/P/Q3AmpRe/Ib68HQzzZH36fU1Pr3nRPboXW1DxAewrQqDpR+VG1EOtX1L7yiz6tiKjFFewqxiuK2X+uLzPK7O/ux/amepdL9ljzTAIUnMpskbGgzNU+petkrk0qC9tukqg65N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761125704; c=relaxed/simple;
	bh=iaNEx7s4uoRtmsi2utH1ilDHvvFszLsPplSRybeNpP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0o7KPyl5EHh+DdKu+8yA3bTwbDEReBz2JnQG8F+HmFmsxCwJsWCDrYXhR/PH4JQx6zY2LTG07gv/jE/WHovggUQ3/hTNqGKsCkBO80sIaGe0nWWcl7bitZZq/kuavf+Hw8T1qaeVhH1ODeUUJa7r2HN9os1xswEGKPIa+wqLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7muIRRM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2Euk0020555
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3FTnxE9dKj7bwSpZ1M0v3uAR
	b4FbmeVp0/jOfC46FWM=; b=p7muIRRMqeoEpMkvhS5e1BdrF8nVhK00Es7oSREz
	BlH605ZZgarTQlVK49cTO58BCxnrHXsL4m2P+DHv8kgR54kP1h8rLC/c8hAlRdF/
	IaDOUJI0C+mGs8rfHowR5VzwQsDwk3MIKjxqy1ozq+GCByhRpKcXuUhlLyqfNWae
	JJUPfTqLnWem+MCsWk/lT2H2gG+pebDe/QzO+5avndaoorHUKpc51ri3aFY+6scp
	L2IFtbuqWtIpex8cN2aYuABN5GCWGVwfM7kwGBD6tiP4wwi+VD7JPgnbGbUYRW29
	o79t0JauHuPHcMc8l0Q/PHbeBLp80qCf6EShlUnPXtotBw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v344449j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:35:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-891d8184bebso1340779785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761125701; x=1761730501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FTnxE9dKj7bwSpZ1M0v3uARb4FbmeVp0/jOfC46FWM=;
        b=ZyR5yQ2envKx1D3fOIdYvJ2PDIa05AdNYUV6k80Fiwj3j9JzxEALLyluTWpuVyKsSA
         H3Ldldu6/UhyApc7ZCMtRETbr3hBP/Bvj0yKP5NGq9eQzLjNYOqSiaS25YwS0xKtgG+R
         M3uNZly8idgQtaHhVQgrBf4TqaJegYBKP3yrPMmYhKh9ScfjJHPSLmtcyVq7f5OARBEV
         15U4mlwjGaqeGmQ81ZIlxClMGNdJZ8PfZIEcgiFqoaWXR6HDuZRviRPEGpjjgcXbNFOa
         b78CppZOggCoy/s6qOREQxDoqx0ltvgyppY4zMN0kVlCHEosfYliZGAMxp86q/W+om46
         GvBw==
X-Forwarded-Encrypted: i=1; AJvYcCVEA9Ygek40oOz64YYlqcgbkgM6AljsH4NALhQNLeQIawcafpLy0Bv1x3sUd7C9On7Yb5A9RU3nv6bjiBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtI1TZOjhZXg8vGOhFEqy6bbRX3pR/0FywTJc5PLur4kx/OvF
	S43tgC3j3H8Z0FjCFayz4IjH+Lgdta/IyzhbOn63banISi+lzqMuOW5M4krcJ1C8ZBTDdLJ1sJ8
	8vmcgvzWs7UB2l0ZEnK5Boy0Ps0PVQxbeNertoWzHwpVG8mfngrlaiEKTwd4077daD2U=
X-Gm-Gg: ASbGncsgcNB6gmUhVz1kov5Doz33swNjBN4jo8+yEcCZToQ+1KehVUWWPpJrlNDVPfu
	xIYyNKwhcVJKvDizVHxZhw+60Jq34vUqwUTIAaowpDUHw+yrEQvsjZbaluUHIvxpHqkdbnunrtP
	u7lUzQhmO3h0o9M3G1dII678/+5ySUCjS/+/53GqgdwmR3HQzUgKhV0nJo12TlWo2oQLR3LDpKR
	m6XOvnn9ly1vQpqa7rZDEPtuPc21H+1lL60eEZkXUk+qsbaFH5oiwyG7ciJJ0rNG2fOWS18cZ8s
	BBbY0Mg71pKsCB8F+Ji/e5vC7zXqPoo91VCXIb3vmsxfG8jvapeAucg6aqw207kOXZyADU+Peu5
	Vs1wm12KdFBjXCMjZmz+JKt+MKbsyw16KnL06qnc3/zXoeuu13WYQlBRuZUUXvrQ9hzwINboW7n
	mLu29nLgZg5TA=
X-Received: by 2002:a05:620a:4542:b0:878:4b36:bd2e with SMTP id af79cd13be357-890707f9bd2mr2572313285a.59.1761125700960;
        Wed, 22 Oct 2025 02:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqe3mjPVmuogD+ILAShdAe/Bdmd0fzuf/dwf5tkGY88cXDlcY6uEnEqG/0GchRnCldvugDEw==
X-Received: by 2002:a05:620a:4542:b0:878:4b36:bd2e with SMTP id af79cd13be357-890707f9bd2mr2572311085a.59.1761125700490;
        Wed, 22 Oct 2025 02:35:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91b7086sm37505991fa.12.2025.10.22.02.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 02:34:59 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:34:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soc: qcom: Add qcom,kaanapali-imem
 compatible
Message-ID: <dwfvko3hszsoh4ihnz3qdpsugmocbkrbhosijdw5q3bxh64kuo@o74as2li74px>
References: <20251022-knp-soc-binding-v2-0-3cd3f390f3e2@oss.qualcomm.com>
 <20251022-knp-soc-binding-v2-1-3cd3f390f3e2@oss.qualcomm.com>
 <g2iviaqetgxf5ycz2otzkpmmc4goo7xuyjmttuu254bfzqqvkf@4vybjh4eghpm>
 <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eebcb7d-1eca-4914-915a-d42232233f9f@oss.qualcomm.com>
X-Proofpoint-GUID: roVYMqkRB3rEyOPmdpmSvaNWHBvtPqrW
X-Proofpoint-ORIG-GUID: roVYMqkRB3rEyOPmdpmSvaNWHBvtPqrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX5fwdufDLw2Jp
 Q4hu2qgu9WZewHjpi9FacidBCkmb0IBkSZZJaaEm0Q/+toKxgVnH/bleWQvd7EbD/KwONr4jBhp
 KCDZ233xuJpfVoez0JyRb5jvQusD7sMRqFSt7RMg9sZRpZONJrkSomlnITR+akrP0SdffgghB6T
 st8UoPciqn3Ppz3xcmjKpRuZUjcgEK/nW/5q2jDR8epmIR3tPcJkyeZ8dtj/23tz54eIDtMYoFJ
 xBmFVIAlhtDv82/FCa+ZrJF4v2pDTCjtyN7QnIBv/Y0a8bY0udoVnMAKQRXGWNZtHmu1rDsu07d
 HuQaX6NRbMr0dJAPGlt8Q12fw6JAOBd6eoeGhNz8k++obFAxDn0yr5+4g9bhtjtk6qmVbEfaELA
 IqoM7O2awhQRD/PeawZyDDFuVnNQ7A==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f8a546 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=weVaEQBACJBk3bPpPTMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On Wed, Oct 22, 2025 at 05:05:30PM +0800, Jingyi Wang wrote:
> 
> 
> On 10/22/2025 4:49 PM, Dmitry Baryshkov wrote:
> > On Wed, Oct 22, 2025 at 12:28:41AM -0700, Jingyi Wang wrote:
> >> Document qcom,kaanapali-imem compatible.
> >>
> >> Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> >>  Documentation/devicetree/bindings/sram/qcom,imem.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> index 6a627c57ae2f..1e29a8ff287f 100644
> >> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> @@ -19,6 +19,7 @@ properties:
> >>        - enum:
> >>            - qcom,apq8064-imem
> >>            - qcom,ipq5424-imem
> >> +          - qcom,kaanapali-imem
> > 
> > Can you use mmio-sram instead?
> > 
> 
> Here is the node: 
> 
> 		sram@14680000 {
> 			compatible = "qcom,kaanapali-imem", "syscon", "simple-mfd";
> 			reg = <0x0 0x14680000 0x0 0x1000>;
> 			ranges = <0 0 0x14680000 0x1000>;
> 
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 
> 			pil-reloc@94c {
> 				compatible = "qcom,pil-reloc-info";
> 				reg = <0x94c 0xc8>;
> 			};
> 		};
> 
> other qualcomm are also using imem, could you please give more details on why
> we should use mmio-sram here?

https://lore.kernel.org/linux-arm-msm/e4c5ecc3-fd97-4b13-a057-bb1a3b7f9207@kernel.org/

> 
> Thanks,
> Jingyi
> 
> >>            - qcom,msm8226-imem
> >>            - qcom,msm8974-imem
> >>            - qcom,msm8976-imem
> >>
> >> -- 
> >> 2.25.1
> >>
> > 
> 

-- 
With best wishes
Dmitry

