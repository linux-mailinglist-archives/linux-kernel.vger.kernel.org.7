Return-Path: <linux-kernel+bounces-791365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B21B3B5FB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6DF1C21FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6D29CB24;
	Fri, 29 Aug 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ32Ag5c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33D27CCC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455895; cv=none; b=R/q5qrxV4C09/ef0qHd4Hpxp5WWsfPuK6rszxhaLNeHCTk9E5FqLQGrbtTvvzIEKgZueh8KLRpfxoX5QhbFDCX1L1+eAAdyIs0Dr0lOj+BXnA2gLZ551ORE69vXaQLed/lRpHG0Rsmow1UYcfz87kSr7KPlxK/bDGmmMfMd3pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455895; c=relaxed/simple;
	bh=zJSmfRVOkbtIQDtehxlC4Tzz6O3pXqvUInfxHeMwYz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Znx44OPeaPlV/H5I4DjRKCeVPvUnbTeUJymfzQj65zisdlsxitpFx9qKaiVIyb9vFH6mMoGlPekOG5+r7zJA6gWQrAOU2dmRjR1C6CNkKpONg9JrBsmwmFYS0eNvYpgq7trMADHnrvlXBEubAeQS+0g9BHXBAHNldC3ERygU03Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ32Ag5c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85FmK013592
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZmutOEL4BSdKwbUx9oh5gSZnIUCZlQ2dXVG3r2aUCeQ=; b=cZ32Ag5cV7lQib3P
	Apx9u1mcGxt6bBzqSbyaJU9Gzh8bJvapCUVJT4mxX/ipO2HXWjLmKOqclM3rLBgq
	JzL/KP1PnzaWlE/SXFHQ/hTouO3geinjc5YywXheztw+iIRoL1nX30vRuzu2pqq0
	FboL6whzLKrKO+GQXR4YW2Aai60yGBAuN5D4/VNOb0tcYOmYE0Si4UMIf0XaRAcL
	Of0mTM54xRhryjGxhpw1uf8PpcnPhY68Nvxdkl0Zniouey/Y+R0FC7B6eUv7FZ9n
	Z8L0PlMiZLkhwZY2crPTOxge05Skp8zfewyOga7zB3Gs3GUeSH8s4Mr5Zw7/DTE0
	NSE+aA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5w33gba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:24:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47173afd90so2726874a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455891; x=1757060691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmutOEL4BSdKwbUx9oh5gSZnIUCZlQ2dXVG3r2aUCeQ=;
        b=LDRgjIMag0ccL8MiCbiaKY35uzVb5xvTLAjzfHndhuA/HRUi4iq4LxL3QAH//aaeVf
         1vBm0vVDCJIrhpj3lewxJXAgrpaB3KIB7VPj6NrmdSvWbexcBKCU/cPnM+mWYCUqPMxM
         fH693FnBQRM5/nau3T1pekn87LTaL/T2FHcvGw3+k8kYckgyZCwy3TTmoXELyF2Q07ao
         QbB0FQapUMjmtHVuPN9Y+H5eFK8KcFfR7IZ5aXaPZF1ItzThx2zDs8QSheHFUf9Zo2+d
         Hj1WPXuUMwZ1yGDMAHv3teJIg29lgOCnZt0DJ2EXOOtgw7oNS71ll+rZXEkyVbA/+ifZ
         Pe8w==
X-Forwarded-Encrypted: i=1; AJvYcCUuFKy6xMPdwbxtR+xOQ6QiWQbWlGRnJSDl84yEUAd4RSkFuBNMtbiwRQGKxHzKaA/7TFocCAdKdWdgntk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJAVDiWicPVNCBm0KatbiCAuNGREL4i496B+vmeFIIJpNhCy9q
	oUhP5KXGtx0oyvwLZ5BlsKP+F/U3gaHSAzDvXUQhWl6pMOMvWYWBJvWdVudl6P9ppI7U74zXMVp
	zvSoTw+HYsMQeUMcdv9PJJRt1s0EIfEBLRu5yE4l5I/hqKx0Q9n/tJtCRmZrBf26eVGQHNu5YN3
	I=
X-Gm-Gg: ASbGncsXgNWR+X+1SC7ycZQNg5ZS+qtJ1h7RY3LF7doo3LJXEe9RGLksWWkjWRbokyh
	eamorPfkJEz3D2JMpu1yZHuBPXBHwfaWGqmX3qvDm0T40jCjyt5hUS12UvdpstN+F2wmfsN9UZm
	N3DL1mf3P39OAU25m7n/ZgE4CzzPBfY/2VGZ/IUHc/rwC9fvARYjxNrfOdqbasRYlduW01vwiMq
	mz+2uiCGfjWzPpMDCS+fkIcgivzy+cfkTSvytpJWMJuVDeqyUUbQU0u7CVPDIEiEsyxesm25dqP
	QoFTpP5WDVVbrrV1vBroXj0dmgCN4dQhFNYV0rcl29gLt9L5HOfrb2LFmLFOHP0P2kpx
X-Received: by 2002:a17:903:384f:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2462ee92ef2mr364175325ad.25.1756455891391;
        Fri, 29 Aug 2025 01:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBH0NFwkkluNtoyFp/sOGVeW9GAErFZVXGcvAduDHifrpu0UX3YiAiOgtNINcHVTBJqK21Bw==
X-Received: by 2002:a17:903:384f:b0:246:2b29:71c7 with SMTP id d9443c01a7336-2462ee92ef2mr364175035ad.25.1756455890943;
        Fri, 29 Aug 2025 01:24:50 -0700 (PDT)
Received: from [192.168.0.195] ([49.204.25.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da4d44sm17598275ad.83.2025.08.29.01.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 01:24:50 -0700 (PDT)
Message-ID: <558ca51d-e1ca-4267-9166-2b929216c43a@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 13:54:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add DISPCC and reset controller
 for GLYMUR SoC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250829-glymur-disp-clock-controllers-v1-0-0ce6fabd837c@oss.qualcomm.com>
 <20250829-glymur-disp-clock-controllers-v1-1-0ce6fabd837c@oss.qualcomm.com>
 <hpfeihpixuauter7ik6om5sv7ocmots5gq3fw7cvn5wkuieipt@jitqslr4pkw4>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <hpfeihpixuauter7ik6om5sv7ocmots5gq3fw7cvn5wkuieipt@jitqslr4pkw4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z/vsHGRA c=1 sm=1 tr=0 ts=68b163d4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ubyLEIH+BItvSySilgXupg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=1ut_qpqdL47trf14q9UA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXwF/y4n767fiT
 TdNjley/SKp8EYHk3tAAKr8IiiDG7tyHYf7A3fMXAZeRoYIE+5yS5hHg2q64KOSYv26dt7SpWwm
 yqnEsLJ6y3+6Y6ClKg6/TqRF3RLLrCXOz41ougdHFwm98p+9mwhTnbquxEBLcXRmvqnvHmZjg2h
 f4A0g5xEj2aC/UpaUaUMKmrSJKaaBJKtDu5OB39pITGn7AK4zffO55DJ1mHRedQIpnEgmV6UF36
 RplSqIW89p/2StA1oRP+kJAxB0wY1lyHMQikgy/9PmzPHVZq1VRQq95aUI9xjejNb81WbnUeCJ2
 8RVdHrTWdWUDY5exbl3j6IbvYdZ5Yn3lsQn4OETSvrGJrjZezmr7WAhZUmkOo6/QkujORRONevp
 fueIMubf
X-Proofpoint-GUID: 6tfLnSBY6atYMDKxgxrmVpqVh5J4p8_Z
X-Proofpoint-ORIG-GUID: 6tfLnSBY6atYMDKxgxrmVpqVh5J4p8_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033



On 8/29/2025 1:42 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 29, 2025 at 01:28:03PM +0530, Taniya Das wrote:
>> Add the device tree bindings for the display clock controller which are
>> required on Qualcomm Glymur SoC.
>>
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
>>  .../bindings/clock/qcom,glymur-dispcc.yaml         |  99 ++++++++++++++++++
>>  include/dt-bindings/clock/qcom,glymur-dispcc.h     | 114 +++++++++++++++++++++
>>  2 files changed, 213 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..063da2416dbaed764b8579a090bc5fc0531ab60d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
>> @@ -0,0 +1,99 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,glymur-dispcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Display Clock & Reset Controller on GLYMUR
>> +
>> +maintainers:
>> +  - Taniya Das <taniya.das@oss.qualcomm.com>
>> +
>> +description: |
>> +  Qualcomm display clock control module which supports the clocks, resets and
>> +  power domains for the MDSS instances on GLYMUR SoC.
>> +
>> +  See also:
>> +    include/dt-bindings/clock/qcom,dispcc-glymur.h
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,glymur-dispcc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board CXO clock
>> +      - description: Board sleep clock
>> +      - description: DisplayPort 0 link clock
>> +      - description: DisplayPort 0 VCO div clock
>> +      - description: DisplayPort 1 link clock
>> +      - description: DisplayPort 1 VCO div clock
>> +      - description: DisplayPort 2 link clock
>> +      - description: DisplayPort 2 VCO div clock
>> +      - description: DisplayPort 3 link clock
>> +      - description: DisplayPort 3 VCO div clock
>> +      - description: DSI 0 PLL byte clock
>> +      - description: DSI 0 PLL DSI clock
>> +      - description: DSI 1 PLL byte clock
>> +      - description: DSI 1 PLL DSI clock
>> +      - description: Standalone PHY 0 PLL link clock
>> +      - description: Standalone PHY 0 VCO div clock
>> +      - description: Standalone PHY 1 PLL link clock
>> +      - description: Standalone PHY 1 VCO div clock
>> +
>> +  power-domains:
>> +    description:
>> +      A phandle and PM domain specifier for the MMCX power domain.
>> +    maxItems: 1
>> +
>> +  required-opps:
>> +    description:
>> +      A phandle to an OPP node describing required MMCX performance point.
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - power-domains
>> +  - '#power-domain-cells'
>> +
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,glymur-dispcc.h>
> Should not be needed

Sure Dmitry, will remove this in the next patchset.

-- 
Thanks,
Taniya Das


