Return-Path: <linux-kernel+bounces-753551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A9B1846A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436F6567425
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84CE2571AA;
	Fri,  1 Aug 2025 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LGI1QlUo"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A54690;
	Fri,  1 Aug 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754060633; cv=none; b=Qu9zyL97JRP4PkS+rGx+4ss6APeRfaJG9SsgMqEsgiLsKiv/8M62wlNfVE+FYZhwm5nX3XX69pDhoC16INIEFM4LjsajCEngh5g5QK7SgfrBOzIayQZ0caaNvvvkWyK8RgnuA50Ixls5iJO5mCYWxTEmUJBeP+Zk51UY1pxiMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754060633; c=relaxed/simple;
	bh=L1h+dx+2xXkj4zM2GpO7rUPl6V/axz/5ALFK5sdvo80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OumKeuGFc00gfPkyWuFHR4c3BertTJuX3eqArQB6EKuAP32QOr3ENd+TMOwyRkkgDbdECRqYYR0HJ6QlQoKvA2zab+lOI6mCimCrWbnoXIS7VfnHWle0GJrfdQBodWwWq21h47jppB37EmpHGxMyuzA/1lL9Xrd2bhGnofmH0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LGI1QlUo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571B6aWW015630;
	Fri, 1 Aug 2025 15:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gDmG46
	Tk3Fu6LK97TgF72a8HHzYJ3HI4cdqzY4OubmQ=; b=LGI1QlUoUZejyC1agmDUer
	tb/ipM8pu6VL5ju0GpxYcpGWierr1asbq0zYtwE1V8cPBUAtazux3BGdZWqJoHUh
	VAkRB8rJNclZIHCWCxyM48v2pprFcrWL+w+LqAeY0El2tw+OASLSHgs8HS7GL//W
	jgHSG435ncKskKOzpnc+nGvskanN2TQtbnqvLtO1x50qPC+lXII9eqiVyGn/wzTx
	UbcBoqayVfWANSNYaYla7oDlnIB0aqXFj9+DdhamBiD7ZiS1EkUOOZHv/e/cF8ik
	HXuF5kuJ8anVMzkNY3LxsumtZ3cieRoqtU6fUgljIDqSkaaAh9oMae5PiGaf78fQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 484qfr9c3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:03:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571B1JEW028782;
	Fri, 1 Aug 2025 15:03:29 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c231j4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 15:03:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571F3SUu56492292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 15:03:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE5FD5805F;
	Fri,  1 Aug 2025 15:03:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715D35805A;
	Fri,  1 Aug 2025 15:03:28 +0000 (GMT)
Received: from [9.61.163.64] (unknown [9.61.163.64])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 15:03:28 +0000 (GMT)
Message-ID: <ea5177ba-5905-40aa-91b0-9bcb66b6f0d4@linux.ibm.com>
Date: Fri, 1 Aug 2025 10:03:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] dt-bindings: fsi: Convert
 aspeed,ast2400-cf-fsi-master to DT schema
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
 <20250731-dt-fsi-cleanups-v1-6-e7b695a29fc3@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-6-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDExMyBTYWx0ZWRfXwkqOO444EumL
 YXjZ+64rSmUjTmtLSxPfWnM4021W3gqsEQnnSb0HENfzkTFimBJfR7mCrgaIo6aMTMtp3PDbnvM
 epWcngSfV0HEhKtKRrQxQoK+9NcPiAVhyQfODx0jxTdBdy2nZd8xGhdV+fXPCi9kZCJkzhCTSeK
 engtvGWpOoHFHSn+Y7mkAUhYj6Wo8Zwte3SPKhT33BYopPAjiyjoHFqNU1wMZXxGO+ihXqwTAPX
 6BeVpFhSzoLwJ2E6OCqpijcs2kQkO6SAIXXayKzuzo+fCG2T/islMnKvz5/YcIYIymBYtEHpZ64
 GliIoc1pyV6O6KZ00qfhvJZcSzHhWY0izOpO1DdvbSg6Nktfu9gerXa32A0vke/qe290gez6xPt
 FYa21WDN02TpHENI0YvLrnR46JtLZLb22kXwyDAC2MrdqvB3WCFaQcWMQOzB8QqH1sGnN/sl
X-Authority-Analysis: v=2.4 cv=Je28rVKV c=1 sm=1 tr=0 ts=688cd742 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=KHSZ2H1nh6ehvMvmo5AA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: ABclAUaAHOJT_qgRJ99oyhE207k_zMBu
X-Proofpoint-ORIG-GUID: ABclAUaAHOJT_qgRJ99oyhE207k_zMBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010113


On 7/31/25 17:12, Rob Herring (Arm) wrote:
> Convert the ASpeed Coldfire offloaded GPIO FSI master.
>
> Drop the "fsi-master" compatible as it has not be used consistently and
> doesn't represent anything.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml | 81 ++++++++++++++++++++++
>   .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  | 36 ----------
>   2 files changed, 81 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
> new file mode 100644
> index 000000000000..690b6c936f18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/fsi/aspeed,ast2400-cf-fsi-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASpeed ColdFire offloaded GPIO-based FSI master
> +
> +maintainers:
> +  - Eddie James <eajames@linux.ibm.com>
> +
> +allOf:
> +  - $ref: /schemas/fsi/fsi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-cf-fsi-master
> +      - aspeed,ast2500-cf-fsi-master
> +
> +  clock-gpios:
> +    maxItems: 1
> +    description: GPIO for FSI clock
> +
> +  data-gpios:
> +    maxItems: 1
> +    description: GPIO for FSI data signal
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: GPIO for enable signal
> +
> +  trans-gpios:
> +    maxItems: 1
> +    description: GPIO for voltage translator enable
> +
> +  mux-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO for pin multiplexing with other functions (eg, external FSI masters)
> +
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Reference to the reserved memory for the ColdFire. Must be 2M aligned on
> +      AST2400 and 1M aligned on AST2500.
> +
> +  aspeed,cvic:
> +    description: Reference to the CVIC node.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  aspeed,sram:
> +    description: Reference to the SRAM node.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - clock-gpios
> +  - data-gpios
> +  - enable-gpios
> +  - trans-gpios
> +  - mux-gpios
> +  - memory-region
> +  - aspeed,cvic
> +  - aspeed,sram
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    fsi-master {
> +      compatible = "aspeed,ast2500-cf-fsi-master";
> +      clock-gpios = <&gpio 0>;
> +      data-gpios = <&gpio 1>;
> +      enable-gpios = <&gpio 2>;
> +      trans-gpios = <&gpio 3>;
> +      mux-gpios = <&gpio 4>;
> +      memory-region = <&coldfire_memory>;
> +      aspeed,cvic = <&cvic>;
> +      aspeed,sram = <&sram>;
> +    };
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt b/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> deleted file mode 100644
> index 3dc752db748b..000000000000
> --- a/Documentation/devicetree/bindings/fsi/fsi-master-ast-cf.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -Device-tree bindings for ColdFire offloaded gpio-based FSI master driver
> -------------------------------------------------------------------------
> -
> -Required properties:
> - - compatible =
> -	"aspeed,ast2400-cf-fsi-master" for an AST2400 based system
> -   or
> -	"aspeed,ast2500-cf-fsi-master" for an AST2500 based system
> -
> - - clock-gpios = <gpio-descriptor>;	: GPIO for FSI clock
> - - data-gpios = <gpio-descriptor>;	: GPIO for FSI data signal
> - - enable-gpios = <gpio-descriptor>;	: GPIO for enable signal
> - - trans-gpios = <gpio-descriptor>;	: GPIO for voltage translator enable
> - - mux-gpios = <gpio-descriptor>;	: GPIO for pin multiplexing with other
> -                                          functions (eg, external FSI masters)
> - - memory-region = <phandle>;		: Reference to the reserved memory for
> -                                          the ColdFire. Must be 2M aligned on
> -					  AST2400 and 1M aligned on AST2500
> - - aspeed,sram = <phandle>;		: Reference to the SRAM node.
> - - aspeed,cvic = <phandle>;		: Reference to the CVIC node.
> -
> -Examples:
> -
> -    fsi-master {
> -        compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> -
> -	clock-gpios = <&gpio 0>;
> -        data-gpios = <&gpio 1>;
> -        enable-gpios = <&gpio 2>;
> -        trans-gpios = <&gpio 3>;
> -        mux-gpios = <&gpio 4>;
> -
> -	memory-region = <&coldfire_memory>;
> -	aspeed,sram = <&sram>;
> -	aspeed,cvic = <&cvic>;
> -    }
>

