Return-Path: <linux-kernel+bounces-777009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24465B2D403
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683813B71E1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2A02C08BA;
	Wed, 20 Aug 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WTvN35Q6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED622A7F2
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755671083; cv=none; b=KOFkldBZoNcI/FFqlaWjvPm0SxrQY4b5sGM8yUTlZcqD5w/coGcc/RWjhx7lcle3pxwQTYLTqt73QnwhNu1BkdKFq3unGtjqZEdiIBauCqmyDKb9nrB/NF25o+jgHumVvNwY8YXU9RiYFwc/p6hJWz7PqSN+tFbPn26NgiP7cTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755671083; c=relaxed/simple;
	bh=LrH2WofXG6NubTOIL6SYNgxotAxylQjxzNFtKq5UgGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAKr5k8dMJ+zLfXZpWuIrcZOUezaB2mVf0lpwAWPULnNkJ3UlOXYtl3EXc6hRiLgoPmlpUWmHjLidhwsMHO11JFUEvqagV4zDDzVNFyJuKX6L9C1d0Cnryxn3njZHO45PDQxAFulSPkIhce8QJCTCtEewcZ+VVpdDpF2gFg7vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WTvN35Q6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ofoC006326
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iKDfblzDNT46YZA30uGR6v1f2o7XXcul3XVrMddX/YY=; b=WTvN35Q6cki4NjFv
	C5dybd5+82zGxiD4rcGhPQQ1avtwaO98mO6sOW4g2DKVdKj79cZ1fsyUW7j7xaLI
	h/c1+tEUyDS7uhXswB2G7bJASsZ5Psoy8OQVE3ZnoHIcHtrNbLUffcNf5helDQam
	602iIpsi0r6yM/Tctw6FZsq6jG8WnQr8NlKffGAjz8H7jADQu8xYN+Ojon8BnIvd
	jszcof3gc6JGkTuOGskFg6VtkzL2x22p/umtw5L/ks1f26fSmu9cEGWKZIWV5WYV
	sEngmni5ywi1I9QSwofXUHzgE0YqSTPEt5WYKPzaaIsqrewX2toB2hIZtgfxrOWl
	MIGg1A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290mry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:24:40 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e614c60so5418361b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755671079; x=1756275879;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKDfblzDNT46YZA30uGR6v1f2o7XXcul3XVrMddX/YY=;
        b=RxaYjKgMNB5QpboC0mN3Id3twoajU40s4z1D/hZD6NIB+D7Hjes9oTW5VN3G9ll1B5
         drQGp6lW5lp9eo6WOiGTmj84cp+jswE4pcOMakHFFowS5lvtF1s80T2SsDlCMof1lrRW
         TuU6ZvfFPpII0b68m/jXjF5xluUy6NJiMBOBmoUkXpabi2CxV4E+lJw3pJDumgi05PoQ
         FdrBcG0geQPAfBm7+FYT66D1nultDbAZYZ+foCRkcTsiU/9K1qBZ4NRoXubzGLh5ElQ9
         oNa9o+YS1eG1Stqj/IhnmedP5j1PqrxirTkVD7sWwDk/UQO14cM3cgD2b+nxsuNY+cB+
         m5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXy9eYrQo638GEKCMj5VoF7aCUpzs08MVZMtKal38xIX9OrOLWX3Pi87kEzvvHE0JifVdjZEnM1/QoO8PU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTuupBeusNPHCPAqgOctdzFntyLb5F0wWZTs14GaEqj3y5k1u
	stJJVJiRRE/WZzk6WtNZgFgNIYzdzi67BN18NG4EVEsZMyX9qzLxgLTkfKbnJAxHmrG9giMWEnd
	PKgCWG2aXZS9VfOWgPbURXmgVgu38uGEWZGJ2HQvsqNr3aMS0Iej4lFYVAbRjqy9WFC4=
X-Gm-Gg: ASbGncsK7IghRM3ubof3+xs/3ZCzwaMAeq6zY/OMtuCta3SFSQB+epBTmLh1fA9eylv
	uUxV2G22rTteQ+831hsBdTxcq/PwleyEfw/T1AzGggq2TUhF5TFQdj1wUaLE0MXhk3C4LTpToT/
	SKa5+Al2m03lgz+kjtSz/WCsYI0BwBQSqA3QBMYuoBWXkZH4NAUAjQNZgFfdDxuqw8navKlZoq7
	TYw/mLN50TAArZMs9GLr584v48vNGH2si87Dg1TGGmVcC8Fe9W5zmqoBjaeocWhn8NAxi1UPsV8
	hx/CqSVudB/ghAV6qlqG7qmYVkispJ9FMXMDVxnzi8Bg+z2iUonLqhYCCulrSYLEKo3WpdOvqRd
	5CTFCPUwLFWrjYI8JbdcyC3Q5mh6IJ6+z
X-Received: by 2002:a05:6a00:1486:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76e8dd255ccmr2038334b3a.23.1755671079368;
        Tue, 19 Aug 2025 23:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfH/JRqULP7unNKt/bNqp2cJbEU4cxpppDZWazMbkq05YCUx/tWuR3V1ofH2rijz+Dk6oT6g==
X-Received: by 2002:a05:6a00:1486:b0:75f:8239:5c2b with SMTP id d2e1a72fcca58-76e8dd255ccmr2038315b3a.23.1755671078900;
        Tue, 19 Aug 2025 23:24:38 -0700 (PDT)
Received: from [10.133.33.73] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d9438sm4271920b3a.21.2025.08.19.23.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:24:38 -0700 (PDT)
Message-ID: <60628e3d-0a59-453e-acb3-acfc6dfe62af@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:24:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
To: Rob Herring <robh@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
 <20250819-itnoc-v2-1-2d0e6be44e2f@oss.qualcomm.com>
 <20250819194538.GA1214644-robh@kernel.org>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20250819194538.GA1214644-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a56a28 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=q2rpgh4P1k-zP0bRiPwA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 9RUQbxq2zupX_SjqUE-ar_VDvwqpehor
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX/KSPcZExEAE+
 Mes1N2v+E5N01iP1Z2KB4QZKt1luzkKtrjoDlZWmUA7uD/1Vsd65dTFvOAWWcsYgT/vFqVmMV57
 Uwc6SrfMXH+jAz4AY+dPSEzZlE9MiIV18B5S/he8M5oaZmmEn+fbVjdmLJt2+sZkmWshOpjRIgZ
 gEjvSqPqp8r1t1+2MUDIvC4QseyUNbVi4yZ2THrpSNs3WLr3vmjcH2/RX0iDtI345Yk/FI4Jvgn
 bBJXJkiY7QZMZhM1W+0hcWTPze8RQckVSCdIRNLxA4FPk3njCLIqm93/61jl14b5K3DYU11KFqk
 xkkGUN8IAKxtjZJqJPkfYGftPnbdIxl8Bx/wR/VXw/s4MiNFSYavIT1O6q4M1OtScTKaeFnphOR
 C2bKolXhuWTehWhYp61tMg+bc+zMIA==
X-Proofpoint-GUID: 9RUQbxq2zupX_SjqUE-ar_VDvwqpehor
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013



On 8/20/2025 3:45 AM, Rob Herring wrote:
> On Tue, Aug 19, 2025 at 03:27:43AM -0700, Yuanfang Zhang wrote:
>> Add device tree binding for Qualcomm Coresight Interconnect Trace
>> Network On Chip (ITNOC). This TNOC acts as a CoreSight
>> graph link that forwards trace data from a subsystem to the
>> Aggregator TNOC, without aggregation or ATID functionality.
>>
>> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> ---
>>  .../bindings/arm/qcom,coresight-itnoc.yaml         | 96 ++++++++++++++++++++++
>>  1 file changed, 96 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a3b5f2b949f69617a014d0ae2831c9c767178f8c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/qcom,coresight-itnoc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Interconnect Trace Network On Chip - ITNOC
>> +
>> +maintainers:
>> +  - Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
>> +
>> +description:
>> +  The Interconnect TNOC is a CoreSight graph link that forwards trace data
>> +  from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC, it
>> +  does not have aggregation and ATID functionality.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^itnoc(@[0-9a-f]+)?$"
>> +
>> +  compatible:
>> +    const: qcom,coresight-itnoc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: apb
>> +
>> +  in-ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
> 
>> +    properties:
>> +      '#address-cells':
>> +        const: 1
>> +      '#size-cells':
>> +        const: 0
> 
> Drop these. Already defined by the above ref.
> 
sure, will update.
>> +
>> +    patternProperties:
>> +      '^port(@[0-9a-f]{1,2})?$':
>> +        description: Input connections from CoreSight Trace Bus
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +  out-ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    additionalProperties: false
>> +
>> +    properties:
>> +      port:
>> +        description: out connections to aggregator TNOC
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - in-ports
>> +  - out-ports
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    itnoc@109ac000 {
>> +        compatible = "qcom,coresight-itnoc";
>> +        reg = <0x109ac000 0x1000>;
>> +
>> +        clocks = <&aoss_qmp>;
>> +        clock-names = "apb";
>> +
>> +        in-ports {
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +            port@0 {
>> +                reg = <0>;
>> +                tn_ic_in_tpdm_dcc: endpoint {
>> +                    remote-endpoint = <&tpdm_dcc_out_tn_ic>;
>> +                };
>> +            };
>> +        };
>> +
>> +        out-ports {
>> +            port {
>> +                tn_ic_out_tnoc_aggr: endpoint {
>> +                    /* to Aggregator TNOC input */
>> +                    remote-endpoint = <&tn_ag_in_tn_ic>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
>>
>> -- 
>> 2.34.1
>>


