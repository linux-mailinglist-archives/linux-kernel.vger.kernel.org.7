Return-Path: <linux-kernel+bounces-740692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD023B0D7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B779C7AD8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30362DEA87;
	Tue, 22 Jul 2025 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kuDjK8lV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB6328B7E5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182728; cv=none; b=drAwiMC0NTSoDs67SE75Mr6Ckq6d9wjNZJJ+EghnxlKGCEUw+ZsY07b/cVqLt+eN5NjE6YQpP3n/T9SqAAi8KEfUs0EwnWjmcINFaKMpgemMyLtds6AhDx1rfiL4QcZ44KU30elgPdoJMg9Dg+56/X81I/10FWmDldVJ2vjYd10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182728; c=relaxed/simple;
	bh=AdS/HEGQYIwXAPgGKh/dj7/4HJqP4YWiQMnvmpzNaGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBNujKx4roZcdruEShuXL86POozcDvskMB6pXWK1geSu7nJkHSTKdc1HTLR1yg08Qf5da6JVNSAtZNMS7V0B1vMcFcHSSoEecuu/Cn0P1s4CnpGjw1HVUWqUlQKjx2WqlP76vuW6TDagnNb9+vr6HcMhSiCDGqnM4GOXCpTIRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kuDjK8lV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7GHi0008073
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lp9oCAfC0uqs28+yLNSlWvHOEvpNJYHHvb1kBs8yoFw=; b=kuDjK8lVrMQ29mM2
	NnvkBJtssHyZ940GjxnoRNMKZIaxrrUx8OXjNq0M/7BtxrF5bJvbBeYk6ggjByLo
	PwzeE6UzPYbeH2HjAjXIWWUlV2lGbdSN2XiTlUTL9IgR/r9Zn7QKGAkBaD9K5lyN
	RIKWxENkALQGIO+ipEuOmfCiHWx3pFg+M73KWyqTq/Rz26jIV2vpsG6lgUxrkti2
	Lh3UHvoSbhksgHnFKlfDBWl+tzn/5QD0hSvpBlrkZIXA2MLcqD25MBwTkjLj/obA
	SmTVTcuY9IMCN16lD/Tackv2Syvpf+s7q0WFRV6BqDaEkCr62XhpKPUTbzRoxzuf
	HnrRrQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48045vyj1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:12:06 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-702ad4ec207so731576d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182724; x=1753787524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp9oCAfC0uqs28+yLNSlWvHOEvpNJYHHvb1kBs8yoFw=;
        b=MiGrHY7TBvgb/3wgBpqpXCadDGNd3vBRMavdyt74YsDrM5q9wu3j+8oJ616gbZQqnb
         hcS7m5BzsqOsbH70SFUNE8we7squu8f278fZENE57kaQ0joPM3MKU5jhn7q25tk81wDG
         RtGHI9KqtPrEs3n9kG/LTl6BQchLcW7i+av1tH8+A3VKoHhdZbWHjEdr39hQs7/8ZWVJ
         9RsSYsbZPux5vpiUCO/uf2zagyDpVlghDumJ5+nyKjAxW+LWVRfRGN6q6j/+Tp7Q9Wzy
         P7dViuGHVi2ICPauIVMCNovSfvgd8lBKDb/Etwmb6YvAu/d4rI6Uj3uzO5wdtp0l4/+U
         TrOA==
X-Forwarded-Encrypted: i=1; AJvYcCU0Pu8cy3f+fcS28tSBay68iMe5oG9HsIjoJGUd7jNEMJcD8e5b4Z2gPYTx1NqlmodmmuFnfglxyz+yt+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxraCzwbLhoapwS5olDHqT02/MUXDJ+K5wMjnv6pxvDyMmSHhRd
	W3WZPspQzC9e5V+fUPCqHgNkYA81bf2BQ6gYIDB/+WaaNyBv+psm52PmDoJM5GMKZYeGlVML50C
	dwna4Ddy44cl4Mm7BEWhVua5RfCpjCmRYWJEIUQMtPXNw6IceITOXv/Uo9miTAssFE60c933Fqo
	8=
X-Gm-Gg: ASbGncvrJ4jZMlI+yk+7UejQ+xX3+fCNWj/g5I2cHEj4sg4gVUSz2Q7mUQqCjg+q16E
	YMoET4JNjA2tJQzutINFe6Z82/SIxLW8O2SfpJUGNev8Aa8r2Y+Q9z0kWFhkKFtp25VJGwdTOaC
	gsD+XHGypHQQpJZYdOgwTJQrhfoQTsfqbRGXEZ2VCBi0zSWqtTig2PUnmssAAiAFfnkygy8uuA7
	wYzsrX5JiTRZHIYqUYbCuAaXev7IMoTfcTaK706HoTcACLz0rU1glOX7vv4+AqajCAJB588oR7d
	y0jlM0YBKag1iJ3815kwvZUtrtcz18nGIt15MhVBvhdeIa2m1t9jStOZRgJYYVuNEHxD60etPwS
	BP26ltr4PIhDIhMdWVQBX
X-Received: by 2002:a05:620a:4894:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e342b70ea4mr1315160885a.12.1753182724447;
        Tue, 22 Jul 2025 04:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVndy6GfF1/rbOfATVToveGOqPm5CxByBr7sl2oaOgD0x8vxoWl1Wqyb/DMzWWuenDTrgHg==
X-Received: by 2002:a05:620a:4894:b0:7e3:2c3a:aac5 with SMTP id af79cd13be357-7e342b70ea4mr1315159785a.12.1753182723749;
        Tue, 22 Jul 2025 04:12:03 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f96sm6863713a12.23.2025.07.22.04.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:12:02 -0700 (PDT)
Message-ID: <41dda9bd-12c8-485a-a6d0-69d040d724cd@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 13:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        sboyd@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
        andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        srini@kernel.org, vkoul@kernel.org, kishon@kernel.org, sre@kernel.org,
        krzysztof.kozlowski@linaro.org, u.kleine-koenig@baylibre.com,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
        casey.connolly@linaro.org
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
 <20250722101317.76729-3-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250722101317.76729-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LL1mQIW9 c=1 sm=1 tr=0 ts=687f7206 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=Y_nGuXgBD960inqFf4MA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: iPRrEjNftR_CyK2T-Ix25l0ACJGOqz_U
X-Proofpoint-ORIG-GUID: iPRrEjNftR_CyK2T-Ix25l0ACJGOqz_U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfX75qJ9UB58qy+
 Tz38AJk92t8CojfA0qeH9KDKZtX6d5UgXlNxywb+2eOoPSOm+NM5/L31X+U3sdP/HME6qrO4zsE
 3r3RTNMaxkkr4tg1Y/dCAXwqsbnSbRMl7/SGGzt8mDJJPPwuSKCtmobMgHnJWsWIpvavfbgCmmV
 sqlWRcfu/FP2p30LlEh2KK1zG795OiUWO5WpNNV3PUqJRhWaou6TlX8JiIXnQF+XMCpMih/55Hz
 sBFWmyhlLO7YK1Qdf006DfLC0v6BhTGMuWNj+gpsHrYD+RfgNvTI5j7Xs08RK1GmwAyh2XxiYub
 HZJ4EsSg0NZcnLKrlYH4cIlV1YIfnVWDs/xNvFy1J8t5CHN8EY8qp1EASLSqTfaJi0vFJbAF7Uq
 2TSlNzA2aQROuU+HX/GVW6SDz0UW4526VzBxPSA0ZnGx53t4yjLzRoIaLS3PtJfkg0tgfVcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=754 clxscore=1015 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507220091

On 7/22/25 12:13 PM, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a SDAM device, internally located in
> a specific address range reachable through SPMI communication.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for SDAM
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

