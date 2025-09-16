Return-Path: <linux-kernel+bounces-818037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B957B58BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3568D2A82FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FD5233145;
	Tue, 16 Sep 2025 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U1n1VC/u"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAD18DF8D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757990118; cv=none; b=dbzbZU5YtxVDzkKeBNE6Y+PZDxb1LUfpvP+8O1YE88etj9vl19G+x0S8WzlNu7trNk3c05zPttsg+pmpXf8rBx1YSysRLiBPndJK7ebKzPbgR2y/JmAgCqqrXfu93BYbDPgiLSl0PXZBfuWirrE+c/CbBseBuZbmtjTVfkRJwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757990118; c=relaxed/simple;
	bh=BuIkzkW9SurkzhD9X+x4Ym4NDCdNu94IfsZgoDxRdV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bz3h1kZt08N/TpyWhDjpwhtZw0gJsfIMiliGV8mXHSfW4Kx7/cQ8R6Yi071EMYJhemIQ961v/e4xAd2eI/FQLvEnWHUYSHpOkmAxr3adDYe2Y9/ZXmQlHDePWsUfhZeqeBeVPMOnspqEqC9hFsby6nvINwfyLcpGHOWacFpwh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U1n1VC/u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEb2RL005772
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JASlTDQ+qZuxm/AEyyWjcH2QxjTgQBqcBlxVgn/e+JM=; b=U1n1VC/ugsjMH+FR
	TRa/Zp81NWeoR+8v4fb76LnrDsQy/5gxZFzFcEb3X8yySbtfh4JUGpO3UodDKUYc
	Nsrjrl2upDyLuKONmqHtWzZURcUKU+L0CK+npEflmcnDTnAN8a1OlC78KKbBxR5T
	lWasq+r2dJ0gFuskpky3DF0jdCon0FWQeznM9qs2VJJ6jtZCfROyrheNAU0SPqJ3
	l+YLqv+OM5LwIqO1H7lFoUEh3x1HfbeM6lx7Orre+OcSJsa5xVBLTSmBYxq2of/i
	XLjPKBzV5be20h/eOcy69hAr0cztLeyxsyWBRs16vLgDqU0nu5q/NVyP/XDWUrqk
	2+0miA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snpuwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 02:35:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471737e673so6523421a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757990115; x=1758594915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JASlTDQ+qZuxm/AEyyWjcH2QxjTgQBqcBlxVgn/e+JM=;
        b=KXAVF61kqh7WFE/84seWbxlJ2Dmm+J1QwlAxuljTm1JnTDL2nDeOWWrrUCKM2C0c0q
         5UJjIPTOVLieQhnN/xpOPxeS6pKvP0/FrT6ZFnzZwEcf5/30s4Yx99X+flwotkilr7CM
         5vwVxOgMdOeTnSxTgamSnRqwlb7ggvL8K2Jkup/PW+jqApXVtmDHqXvPq6hpbD2JgzBz
         4N5DkoV8JnrLr8TnmIPBusjj8BIFCSigviFXBdcGQM4a0qhjzpHREl9ziKyJ5BjUSO/j
         lfenSYC3ojhbFIURkZnHsnj6KYC4x8ANU5TWcHgm/9ZUhJjtoSG7Xkm0gbG6GEldSFgS
         5XWA==
X-Forwarded-Encrypted: i=1; AJvYcCXmeVG/x6BCqe/TitOjNIn6IGYoRZe1wvCD1OlwK/s48w4UBWkdHSN9pyxjp3/Tllfa1LCMyY5zduxPNeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatFz83TrZKc06GiE9CNn25I2HXL9IiNDPBGxYlqAFfqI2xJXC
	wJnexTINFNgIUAr9Xc8C/+txr9n6ZVGObmH+gogzJxbj/5hnQfJkxV42uGOmWpEHbKIb6uEX9Pe
	+CPCCLzALpW63nbbJsupfQwrcsfnwwKz9vMTjOpKEKbgUUILVEuCovRk5giQUOsOajrsGF1MC8r
	Y=
X-Gm-Gg: ASbGnctwKGdb22eAn0WW8XyHDWASu9CfL508wy+fPk7GNdk5H9Fch7z0uontu9C+1Pc
	pL3Vp/K4JH2Bd8HIH/USElbbVPKoBxzwZaKRCnkF0/n/sGrs/P8DZu8wbJrG8CvaI79g5RfNnML
	h03N2YmzbMxabmH+NQQSZ7jtLT+lBPQ85kQoHqe9TdSqU/IaPgPf2ot9U2514jllKu00pwi5uXX
	dYyiebsmxg439z1ZDBOryDoxvo4IpNhVfYqIAzyGws38b6em8w6qE+TLoMLJcjc55xGXZQv9wuE
	cxzvWFro4jZgsG2r2JIv1lKXaBmJvH+3I6JOch2BBB1JD98tqZfnKgtr1H0oib4cQXYObSq3Z1k
	iOFJbS6i33W0SizpHIvFNT0OZsaiwk9G1Fd5gbxI=
X-Received: by 2002:a05:6a20:7343:b0:250:429b:9e56 with SMTP id adf61e73a8af0-2602a28e319mr18346441637.8.1757990114779;
        Mon, 15 Sep 2025 19:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOLGzO215Y1vQ0GPjMPr4AcmObjX2DF8YFcM9ZtdXs0aLfAHkLZ+r8Bv6nCk8Gdo2y2Iny5Q==
X-Received: by 2002:a05:6a20:7343:b0:250:429b:9e56 with SMTP id adf61e73a8af0-2602a28e319mr18346398637.8.1757990114293;
        Mon, 15 Sep 2025 19:35:14 -0700 (PDT)
Received: from [10.133.33.235] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b5568a82sm9180276a12.34.2025.09.15.19.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 19:35:13 -0700 (PDT)
Message-ID: <f9d3b3ec-dcf1-42ce-b925-70e5543771ed@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 10:35:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] coresight-tnoc: Add support for Interconnect TNOC
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@arm.com>
References: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
Content-Language: en-US
From: yuanfang zhang <yuanfang.zhang@oss.qualcomm.com>
In-Reply-To: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c8cce4 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Wn57KMgoQ4YZn1JjiAUA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: NxnP4sjoJ4uedaraDcY8uZ0Vy35DZz6Q
X-Proofpoint-GUID: NxnP4sjoJ4uedaraDcY8uZ0Vy35DZz6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX4Fl5kEQH9t9N
 pYA7c5GjZ+XwUThN6ycWxDnC6aoZENQVux20wuseJhPO5UmHoe4W2ni8nkQhVLNS5667aOCpUbC
 ckSrkuRqF+fGQ6UoWwoMaT87UVrtxHjTGquxn4z+hWZsXSTJgDFO/JCsd/Y2UAVvHRM1bMj+GqP
 Z5SfiDkXqB3BIlQCZOTTihy2X5uB38rXUOgU/3XD/Nut7qs+nsk7XNK9M4ltlXuTACtN38ACJOA
 L9Q5uCifoOi3KAdd3pKK5ZHm9IwwARIIxNGlh1VX1rbtRKpxWnoQIwFKStjZ8/GlkEzDfkrOQ6l
 8VC/eGOLI/bmhn2O2EO6VZrZE/D7i3iR4R+VXEl6lUbTGo7Fd1qo/PjCIzgOx4M48Q1Mt6Iayvb
 Fmrmz8x9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

Hi Suzuki,

Could this patch series be applied? Is there anything I need to update?

thanks,
yuanfang.

On 9/1/2025 2:58 PM, Yuanfang Zhang wrote:
> This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
> (Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
> trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
> this block does not support aggregation or ATID assignment.
> 
> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
> Changes in v4:
> - Fix unintended blank line removals in trace_noc_enable_hw.
> - Link to v3: https://lore.kernel.org/r/20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com
> 
> Changes in v3:
> - Add detail for changes in V2.
> - Remove '#address-cells' and '#size-cells' properties from in-ports field.
> - Fix comment indentation for packet description.
> - Link to v2: https://lore.kernel.org/r/20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com
> 
> Changes in v2:
> - Removed the trailing '|' after the description in qcom,coresight-itnoc.yaml.
> - Dropped the 'select' section from the YAML file.
> - Updated node name to use a more generic naming convention.
> - Removed the 'items' property from the compatible field.
> - Deleted the description for the reg property.
> - Dropped clock-names and adjusted the order of clock-names and clocks.
> - Moved additionalProperties to follow the $ref of out-ports.
> - Change "atid" type from u32 to int, set it as "-EOPNOTSUPP" for non-AMBA device.
> - Link to v1: https://lore.kernel.org/r/20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com
> 
> ---
> Yuanfang Zhang (3):
>       dt-bindings: arm: qcom: Add Coresight Interconnect TNOC
>       coresight-tnoc: add platform driver to support Interconnect TNOC
>       coresight-tnoc: Add runtime PM support for Interconnect TNOC
> 
>  .../bindings/arm/qcom,coresight-itnoc.yaml         |  90 ++++++++++++++
>  drivers/hwtracing/coresight/coresight-tnoc.c       | 136 +++++++++++++++++++--
>  2 files changed, 215 insertions(+), 11 deletions(-)
> ---
> base-commit: 2b52cf338d39d684a1c6af298e8204902c026aca
> change-id: 20250815-itnoc-460273d1b80c
> 
> Best regards,


