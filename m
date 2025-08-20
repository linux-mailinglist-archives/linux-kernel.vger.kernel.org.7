Return-Path: <linux-kernel+bounces-777002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D07B2D3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D27B16FA66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C7267B89;
	Wed, 20 Aug 2025 06:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GG5buEa9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A776E555
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670618; cv=none; b=iuSpl5LYQ3erhiQUIGJSgM/L/8msHMgK6uD+++ZQQZxPkv7PQqXrXKbK5i2ub/P8ZFoTHRqN+BMMfqDTF6zEcM77VzlKnqx5cjbpZwPLqO+jcpxqa1ZnUdGdom+CWUE7M0M9iFSQ5i3PSNBLhpEs9o6rndiB+DIo/uVGW3DeDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670618; c=relaxed/simple;
	bh=BkNEtWfHC0W481jdirYIhyOmkfVe/vp4DlWZgEyrPcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhB3I1hX9hpb9x1vwH6oBG9AzchE081iOTZl3K1byXX7Q9/QXxm0tjoJ/9G4F6yJ48NExrD32YbFHgq2E5TDr9hajUFHoCQ+ljqhKtVPwWLhzHd5fXdagd/HXHt+qKe8Xjsi3jscybTEEsEs76p8BBGEhGLgmDojMFWc6wJOR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GG5buEa9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ocp5008766
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zo+qBFSuOCOdT4196vaFitQ277UyoAlgWb0yHJHAlaY=; b=GG5buEa9LEnTmScR
	pHefOJkgG5kNp36UZ+Bu4OR5AavLXm2tVsKFDlurPDgcHmpNNoJEgBiRu5T0exaE
	TK8tc+EDTmo1O62xXCyeZ5cwzsrUVO8GI0RJ+GS1MIZgOYuv0WfvnfG+F42ctT7N
	5OCNa9Vs/tkI588n7pD8jpAR+C9UaLhs9N6y4Aup5R9DidI7OuI3+t4GMFdUFay6
	Ru1APe1uTqzv71Qj9G9lJgk00kvYA8gFRP8kOiGxeriwnkW/EQvESROxmf0Q58ke
	AfhqOV+GY4aibLmLu3J3L1RwRZDEoJT6uEvdHo+EV8d+OHEnEbfx5UKaMPEU4UVh
	Knqlgg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a0m1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:16:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b47538030bfso1658577a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670616; x=1756275416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo+qBFSuOCOdT4196vaFitQ277UyoAlgWb0yHJHAlaY=;
        b=CC8Map4cwVjzn+n6vWjCSFY89zPeYt0fr2W7WKLOePZUplSh0fkQhb0QK5dCBFmiIC
         GRvZd9yUKd9Lo3kDOHWiepjczDGOChKJ4sOvtcvCt71jPG42T+xLm5o+JBmuvQ37D1G5
         EBBJeg+Gmir+rmuhqIsJwqIrVSFWpuUjtycUyjBdpLvtIkWr7VyIx3RY2bFTsZ2MhnDi
         xPvre8Z2CpzCFUZD0oc7iBckKybJJC2YXVIT8mbpCvAg6f14J2s7Ut/f1fHztiIB4DgL
         Qs8NG7L+zW1YAsi6L/xjP5AIdVfagPaXPgOI2dvMn3tCyR5kl0GPZKErkCen+OIxget7
         5pVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuiLQXry9SpM5ikvZrJTxd7e0iivv/BgHlbgjZmtxBSsSaIcYHpfb0bab65OUes8wY5Jm23zU2+UqJiYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJH2pbJqqyPXHIT77ihdc6B/8Lh4VPLdX+bxLP6lXbrqkaa5J
	PB2Syh083SApaz4nRr1MPD+exltnFtq7tbOByo/8SZT6qnIaSHpkjOl1YMDV00FUcY3oBWy5Dnj
	FzGT2tsb1MIt0Z6G7maxzlytLkZqVCYuy2q5ihBQAyqzS7iMRrIfHaaWGjW7f2K0vehg=
X-Gm-Gg: ASbGnctlj9EL2p06rPKi/8XNl+CwhqUjehtescy0nSYVpPArIaz1AWBnmZhE5cJ/l87
	zj4Y1kbkUk0xV2VEemfHU3WZv3zZqE5PKr6t8F7ezZdY7FPyh1/Sc0TkGYU5Tb06txfF3dV/oTo
	h69VFkLwdYq9SeuiZY7kqo+X0jT8I9M3GF/3dYbEcKQcFcNs99FWqINt+x8GMOrHUiyb/tboVcX
	PD7ekwau1nl7WTiQStwE9stEMeFDlprOtqkXNSB1A/fvCSqDGLGhMy5Umexwu4a3DDU1OBFVVg9
	B7nQvlwdWDhft+9lCugPjNza/ziZgXEv9/tNYIvAKc/RRsBHzARJ9QflB/dh+TjIDaRmaJL0gUN
	uptd3qSvnkMp6s4qBpbNaaPoB3K42dzYW
X-Received: by 2002:a05:6300:210d:b0:23f:f659:a0ef with SMTP id adf61e73a8af0-2431b884c06mr2689101637.25.1755670615717;
        Tue, 19 Aug 2025 23:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkuHrM5J+SA+TshY0ZVvPXqmiE0Q5IAuZ5MDZKibUhiwTCZup0o87PAGsuKT1kaJi+7h4VLw==
X-Received: by 2002:a05:6300:210d:b0:23f:f659:a0ef with SMTP id adf61e73a8af0-2431b884c06mr2689069637.25.1755670615271;
        Tue, 19 Aug 2025 23:16:55 -0700 (PDT)
Received: from [10.133.33.73] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbe626sm1356125a12.6.2025.08.19.23.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:16:54 -0700 (PDT)
Message-ID: <45bad7a0-119a-4375-887d-28aed2b0ee20@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:16:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        kernel@oss.qualcomm.com
References: <20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com>
 <20250819-itnoc-v2-1-2d0e6be44e2f@oss.qualcomm.com>
 <175560674472.26193.14154235220441518996.robh@kernel.org>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <175560674472.26193.14154235220441518996.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a56858 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: 0j0NRB1DUc5uBD_Nq7H6KgYjUE9ZS-WP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX51gI8XuOQ6IF
 X0hPBEEIh6D5d3G6SNkS+2j0ZO3RLMKR77xaJEDWZ9zGf6wfsLKFdaNzyIyNcgnPq+LiQB3vJKb
 FEzGadUTS4FXByAXfLe+dCd2IKnyn99Hl6+L2LSOnTe685kwUM2brLBH7V+qy2H6re6uzXQfFgB
 hocV3HNwkvT2KZPYdtREZQ592siuQYaLfuf8eVJN5e8sm+ULz04sNBV1OYDZf7sQd9yBp6JLrKL
 4TxwZs2H9r5GYHxS+zD4MGSSPD1k4Jv5YIEn+KEjozt5+Q8OHZ/JwkPCK3MpgNm9muiF8iWOOgF
 hD4PChPtpQ4hgLTq7J8A5w/4/lpski4xdQl0b8chJf5mFEi4bG96MgGHGCq3wUk6La7YI+qjwXN
 uAl97KyfbW8ULNg8/IyRJLQT+O5g2A==
X-Proofpoint-GUID: 0j0NRB1DUc5uBD_Nq7H6KgYjUE9ZS-WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/19/2025 8:32 PM, Rob Herring (Arm) wrote:
> 
> On Tue, 19 Aug 2025 03:27:43 -0700, Yuanfang Zhang wrote:
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
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250819-itnoc-v2-1-2d0e6be44e2f@oss.qualcomm.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 


Below is my dtschema and yamllint version, They should already be the latest version.
Name: dtschema
Version: 2025.8

Name: yamllint
Version: 1.37.1

I ran below 'make dt_binding_check', don't get any error/warnings.
make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/qcom,coresight-tnoc.yaml



