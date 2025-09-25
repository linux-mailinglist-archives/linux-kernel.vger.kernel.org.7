Return-Path: <linux-kernel+bounces-831938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D4B9DF18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53A33AE4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3562F611E;
	Thu, 25 Sep 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e0SppuKH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18921266EEA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787095; cv=none; b=Dnta2l7n2lMRu1UGlZMlo2xWX51R74FlNTJB+lbhCZhS26BK09dZfhiDshD+2TjQBuQKtK2BkRD3HviKugmUSlqRx+FksRicfGdWZEsisK7qkY0Ej4jT1UTeJlz1A6ID8FojDLET8KNlGcR9KubYtQFpHxb381OggeeUMbYVYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787095; c=relaxed/simple;
	bh=oJBnVWEqis8/5n/SoApXp5MzjZD1R0lPAriYUQuTlhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKyjZ7Zs7zbxz+E5vDibzQU86nJQMQoxTixcmUdU2PVI/Gjh3PdIFCMO8/g8Q5KT0ZXTlEmzz2Jim8s5PWXORzn792KzzSBsA6p3T2rvhv35oU20FtJUuXFgJ3XsPVhM8kXf5r7hRwYvjzfg8+S4lHliiFvWgDuwnzmMXcp52OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e0SppuKH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONteSJ022115
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fcIbbzo7ckMjjA3PIeSOTCHWD7NrOELFEt61PIG0Skc=; b=e0SppuKHydi+id0Q
	7Ttdxpd9lHG6qvkmuEcecasOJhlEJFCmSALgtQkIXTP396NbWDzxAHbk8mIliUgo
	MXul15jZz8BtXk0QFyIWjxLJdX/cF6+xSbtjiDwUdOl3nNqAu9/J54JDT417lP/t
	9yzjJwKQ4fgo0mk8YO76Px8Z5CK6b2+NXEn9dLGFrVip/FkRC5twhnv9LIEGKLZL
	HiMgfK4rnbiJ6ZwZJ/EgE//zo70xdeSXRk1P2m12A8QPuskGLpNxPwXF0f82ko0B
	qmK/SJBFr13F2L3Opxu6QQ3QqSzlOJc7oQXkIoHZFSHQooQshLIuYjnND04r3Q+8
	kO81Jg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budaeu7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:58:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78038ed99d9so1105208b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758787091; x=1759391891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcIbbzo7ckMjjA3PIeSOTCHWD7NrOELFEt61PIG0Skc=;
        b=Wa9S6mAQXt+GfuS749cXYsELcTtkie7Vyqw1uaUk0CX++/iLxk0+cjR0aXl4msFjsh
         QhsIzUBX9e9t+LdON9Cb3XfzSDgSvmlQyi2cAR1wWUO7L+hMMOR73/Chvy5GInNVAVb9
         gRNZwrMwJE1n4kZJ7s2u0aTsaKXVq6dfz41vYIRV3kMjGw6lAnPWctFvr9L65WNr2uJc
         NCPkbVCHsiub7SNBjAD0vxGDDuyuQf3XA7WHJi2f9GFCmU7m4Txeo1/Jm3HDDEEUg9Y5
         W6iCIFg0bJuGNSe1mO7D9b4aj0+xbSgWwJDkOIaVVo7FY+Yz7QK6dgOLbFvg/tIt40FO
         Vhxw==
X-Forwarded-Encrypted: i=1; AJvYcCXjzMpMj8MLwgxu5MueM8jWHmu6mU1TG5dJ9HTBYAY3rnZDGDsdQBrrDLt6QTmxGdDP448zx0wseB3hav4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNK6PVrcnRpG8zFwyhHecjg9M25zHPwxJiYeC1SRoXBMCTa2H
	wBMRcvBUB0UbHOz5mCFF7BH+jb/QoQyNE1mNY7GLZ67rbnbdacHoXNkvJLlVej/NnkH4s7t/C5I
	WkWqEnbqZ7GWhv4foNrSzUCGRA94eDpc7E9T3Zrgv8vb0YcvF28sEvFJ4aCSwV2Lo+Qo=
X-Gm-Gg: ASbGnctx0MiWVm8G7jkpN/M6MlwNpX69aR3muJkvcBXNn6IvhKicDe5weotyrVqIZpC
	WFvow/dGjQKQfZ8ZsuHHN59JwZn3OqI47CTyr7kBTrC6KeFlh9GuzzfbiU63zhORqnt8QhbpaFd
	xDsr/tKAG8HyMMSeQNKQs89Wv0CmwcIJfUSHrH86MJ25/mp8KRdd3vcMG4vmUpygwfHeZI0ruNc
	zhHWbRHwc0aEkSDJPZHGKwSGffnhEf5hV5l3kBEww+ILDTD9JguF16ZdR6kNebzO864I1jfQu1y
	rvClk0WrYtQtUmoZC6yc1Xq8ZbEhJ+P3SRc57QvqGqTI13ZCwXzEm5exp+WRQ/rFNy5CJoXbEIg
	=
X-Received: by 2002:a05:6a00:c86:b0:781:4ec:4ec4 with SMTP id d2e1a72fcca58-78104ec5432mr1333314b3a.31.1758787090730;
        Thu, 25 Sep 2025 00:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg0TQxiv57fQVkmmQ5tE7NwpU2R6FvXPKEgVbgNY5wrTB6m01+7v3rANl2gXjzBuF8MNGZYQ==
X-Received: by 2002:a05:6a00:c86:b0:781:4ec:4ec4 with SMTP id d2e1a72fcca58-78104ec5432mr1333288b3a.31.1758787090279;
        Thu, 25 Sep 2025 00:58:10 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.248.165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm1190027b3a.43.2025.09.25.00.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:58:09 -0700 (PDT)
Message-ID: <1af0d19e-30e0-1260-877c-5d6027c3d297@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:27:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/8] media: dt-bindings: qcom-kaanapali-iris: Add
 kaanapali video codec binding
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-1-e323c0b3c0cd@oss.qualcomm.com>
 <vqzon3svfqvk3poz76jm5x5gf4rd6vkygegonafcprmkejt4aq@5kwlwytg3ulk>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <vqzon3svfqvk3poz76jm5x5gf4rd6vkygegonafcprmkejt4aq@5kwlwytg3ulk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ndNdjDuxZfVmuAq9l0A4BItl9z15_vnU
X-Proofpoint-ORIG-GUID: ndNdjDuxZfVmuAq9l0A4BItl9z15_vnU
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d4f613 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=AkZwv1uTgJSVxlfcUQlFCg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yfRxjFk6VvuiwaCZe6sA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX0tmh9+RaRvqa
 S4O0iPzyuhBh2idnjFexRhWbV5PWptIQDoeRiXm32iQd0KYwF/+EVWNFbJeugntBBBOR/mVb9nn
 eMkNJVdXxzyQ2CUy06jXItyOqjQI3CJrfo+jBknKOJNbsz3E222RqxDptK/LxPtazAuQxGqsK3G
 eN7YCfSJTPR9YVcPN8BXv3+MSwGfi0rAAqB6Sjz8rnCvg3RugR6YFeCG3SoZq9BBzBlYOHrEKc1
 SZNC236Of6b0Hxw58Q8wu9N3/EvZIZ/foznwf7iABVrhwLB1FVh4loeejQl8yyDyFxbB6lLn1Le
 Pz1vxQgVWgyQOlv3XHnREloFElsJQ4E9L/z4Rk7qidgAPcX1zfDSHpPsdvJvyE01hcGVse/1XH0
 7B9VhHib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113


On 9/25/2025 8:36 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 04:44:39AM +0530, Vikash Garodia wrote:
>> Kaanapali SOC brings in the new generation of video IP i.e iris4. When
>> compared to previous generation, iris3x, it has,
>> - separate power domains for stream and pixel processing hardware blocks
>>   (bse and vpp).
>> - additional power domain for apv codec.
>> - power domains for individual pipes (VPPx).
>> - different clocks and reset lines.
>>
>> There are variants of this hardware, where only a single VPP pipe would
>> be functional (VPP0), and APV may not be present. In such case, the
>> hardware can be enabled without those 2 related power doamins, and
>> corresponding clocks. This explains the min entries for power domains
>> and clocks.
>> Iommus include all the different stream-ids which can be possibly
>> generated by vpu4 video hardware in both secure and non secure
>> execution mode.
>>
>> This patch depends on following patches
>> https://lore.kernel.org/all/20250924-knp-interconnect-v1-1-4c822a72141c@oss.qualcomm.com/
>> https://lore.kernel.org/all/20250924-knp-clk-v1-3-29b02b818782@oss.qualcomm.com/
> 
> This doesn't belong to the commit message. But you also can drop this
> dependency alltogether. Could you please do it?

Sure, i see below works good w.r.t schema and dtb checker. Please review and
confirm.

diff --git a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
index f3528d514fe2..537e8d627a72 100644
--- a/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,kaanapali-iris.yaml
@@ -106,9 +106,7 @@ unevaluatedProperties: false

examples:
   - |
-    #include <dt-bindings/interconnect/qcom,kaanapali-rpmh.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/clock/qcom,kaanapali-gcc.h>
     #include <dt-bindings/interconnect/qcom,icc.h>
     #include <dt-bindings/power/qcom,rpmhpd.h>

@@ -136,10 +134,10 @@ examples:

       operating-points-v2 = <&iris_opp_table>;

-      clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+      clocks = <&gcc_video_axi0_clk>,
<&video_cc_mvs0c_clk>,
<&video_cc_mvs0_clk>,
-               <&gcc GCC_VIDEO_AXI1_CLK>,
+               <&gcc_video_axi1_clk>,
<&video_cc_mvs0c_freerun_clk>,
<&video_cc_mvs0_freerun_clk>,
<&video_cc_mvs0b_clk>,
@@ -157,17 +155,15 @@ examples:
                     "vcodec_vpp1",
                     "vcodec_apv";

-      interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
-                       &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
-                      <&mmss_noc MASTER_VIDEO_MVP QCOM_ICC_TAG_ALWAYS
-                       &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+      interconnects = <&gem_noc_master_appss_proc &config_noc_slave_venus_cfg>,
+                      <&mmss_noc_master_video_mvp &mc_virt_slave_ebi1>;
       interconnect-names = "cpu-cfg",
                            "video-mem";

       memory-region = <&video_mem>;

-      resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
-               <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+      resets = <&gcc_video_axi0_clk_ares>,
+               <&gcc_video_axi1_clk_ares>,

Regards,
Vikash

