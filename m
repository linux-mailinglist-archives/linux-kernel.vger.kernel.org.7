Return-Path: <linux-kernel+bounces-833547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3DBA24A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B197AF027
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8AE267F57;
	Fri, 26 Sep 2025 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IY0hQEii"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18962265CC9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758856626; cv=none; b=cMx0E2LboMkBej4J2pWpJoidaZXCpr1XFMMG3WeSC5PlBGPsu9Cn7UH+8r9ESXJJAMa1Nk+FGW5CVm4lSxju7TMIH4ZmCGek99vIo/BfKxrY39/2cCJRZmEFAP4VQRbYIP4Nj4D4fNJJyEW5qW8GOwi5TRpEPifMFQOFC/mr7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758856626; c=relaxed/simple;
	bh=M2cMozZeB8nC9X8dnmwplIBPaVCtjwjIuAhM0d49Oaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKpiAZFsjSEdb3jMTE2zhLZIQL+/YxXJxONMOpLfcu0pRWyDnkR8pd82rqCty59H+Bn52ggSB/dsHCC/gpsUdduFKaY7Wixx6sgnl4MVAiaEA+yVyQVCO6ws4Ja1sGDIFBXTpMeEkWGIiVH1ZQBVFOkqfxgmzq8ul1SnAnCEwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IY0hQEii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPxTR025426
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9f6LSM6OdZg1tUtjh3SpMPAi8kke+aQ/eiH9bqFrAoc=; b=IY0hQEiiUKjWIxlz
	GvvGIamAvxkoqk3lbTXoYxuP4aHFIE9UWsA7aAy+slvo7FTwMZd3gfWIg6hU/9VH
	wCBQjhDxjZIfKR9tKWr8OvDiGSauCiuPczfoMhEFmBnozzfPhq4j2UPHP1DECSgH
	0CtqodR7Aw/J+D9RB/cNu9rjWTofNI91RD6xrxELmyKZV1W1xobgA6xhH3P/owRc
	wRFheeh/xVhRrPERbBtch9dShWYLyr3b7eUeta6VVLFMWKWZKhQLn4nUzGPAQXyG
	aUg0r9zWQebI/yZVwWdcfHA0TwlBrpRt7u46cG0HTs2ZaP2tcs9n9mJyb1762b4M
	C/+Zyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0u15gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 03:17:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32559972951so423226a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758856621; x=1759461421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9f6LSM6OdZg1tUtjh3SpMPAi8kke+aQ/eiH9bqFrAoc=;
        b=ruaVStFun3bxbHBR4t2nB4ydhAWsWK4vltiVfPoir2u88okQJjETptT8vppqCvwlbv
         AuH0MfOM7KWGwcj1QD2oPMp9CCbmnxq+B2j7jOqfDAw82B+80WpDOEY/4UyrhjLpHaSy
         YGF0l0vFxkTn1ykw7WA0kzukiKjAYlAB53JAaLfzzR9dN3XszueEX+dBr3QG8zp9/I28
         dc/AuIfBbbiLU51OEgGRBDapoya2WoySdfSQ3VWVbayNuf2MziSiJKbcFAQcO3TrFiaY
         b++HocONkF/hSqRW5L1bbnXjrZS1hIilQzEr3kaBS5a18Km+S82a4ISe/dGZunVOTBaU
         HsXw==
X-Forwarded-Encrypted: i=1; AJvYcCUX//4x76P3lRVZhx5aVb+pZquuDYV11UuOmbs8002jfPDpF9+HQVLPSDM+S9k1f75oG58j2ahRs2TduV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/g68NiNDTkcghvieZbw30oF9KGcUCCeD5t0IvsnccRVlPZ5t
	BaUFHo+aXJIA2cJHo5qRS+LmqkZc4mI0rcjlv1bZCqWc4crw8OD8mifjU7m6B8vVUuZFigFeCiB
	lxWYcsQN7UGEkDWKzKSH2rBKg0GmvTLZo6q+xcWd0athl8cJEQpF4pk7VDKmkVFarlMI=
X-Gm-Gg: ASbGncv3F32JMgjIyux2zVGU1j9G2QRldylLovm7qfYrRLacpgFC4WTflIcGiPo22wX
	JyXi+SP0e3K0oa7oqW6wmTCByE+y2o+SuAzdnDc8ntOyCuCoW/wXCBLY8yVkkfzHm8oz7KDll4B
	JdrD6q+dR3xSSzfYWpV2G7uLyvSttQaT3oFuaTELCf2JYNQO44Wy9On9pDti4K2f+CJrIT0QWwM
	oW93wX0cmPBM/sshrwpEVeWVcob0ki9kcz/zhWIThGKVMKMWjjSVdPvgURPR6GxOdf4tmvQAXZo
	Dzqir6DAU/sEmujaJOAr6849hD8MmTF5d7PDe3eVdkpDovX1hgAK/2RpLQHocPs3CPZO/xum5sP
	ZUpJ71IqNCHnQVy++K+rKjr+5NZCfuh24wEs=
X-Received: by 2002:a17:90b:3b48:b0:32d:e980:7a70 with SMTP id 98e67ed59e1d1-3342a17d006mr3998883a91.0.1758856620653;
        Thu, 25 Sep 2025 20:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiqzLmVD4byJpS81rkUiJ1Icsy/ExxJQYHMvD+WEtpM3r1cCrKQQ5MrCKcNruiodugOB5rJQ==
X-Received: by 2002:a17:90b:3b48:b0:32d:e980:7a70 with SMTP id 98e67ed59e1d1-3342a17d006mr3998835a91.0.1758856620082;
        Thu, 25 Sep 2025 20:17:00 -0700 (PDT)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c203dsm3184336b3a.22.2025.09.25.20.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 20:16:59 -0700 (PDT)
Message-ID: <2577fb3e-96bb-4f2e-871d-27395065ef4b@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 11:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/14] phy: qcom: qmp-usbc: Add QCS615 USB/DP PHY
 config and DP mode support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250925-add-displayport-support-for-qcs615-platform-v6-0-419fe5963819@oss.qualcomm.com>
 <20250925-add-displayport-support-for-qcs615-platform-v6-12-419fe5963819@oss.qualcomm.com>
 <5dtlqq7x36gb7cmiunoreoe2vftq46pusb75sbol47ceazefpf@lxrx3hhcwhju>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <5dtlqq7x36gb7cmiunoreoe2vftq46pusb75sbol47ceazefpf@lxrx3hhcwhju>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: poDtyPFIJGW6co-JDIytr2siIgH2cyzd
X-Proofpoint-GUID: poDtyPFIJGW6co-JDIytr2siIgH2cyzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXx5t8nhRIsJFV
 1zSCzQbA2PvZfKAStMPrwYeUeiLBs/aTpV4Vt5wT2lP4VtyVIRfeKQ0linpf2cpwd1daEIksZCc
 EHybaFVeQ/xJkrb4JhR4+wm8niryNhRCXgZYH7CeBBEFWHYLLiShbfTMpw2edWYxm9jDh2TcCoo
 8UTxGDYy+69Q0uupJh8dMEPg0wW7ntLDBGNs7UUqChAxe27FbjzAIk9QzCi0UnFqTSnuIicRsMH
 GJiKLWGU2A25xyRbJ9iwsHsjPCkm2Cs5kmLU0xgbLjaUqgXkL2Unzi1MKZHoXLSGyq+4Pdg1ZEF
 bGzLhpJYtqkAJTCw0GUIPf355Kt77YcdXTput08jt7LVv7OkHeVC+j05SM+AfrmWjSwR9BFSxMM
 2U/KM9UOJ9MnAhzsaiG9Gtoi1yKfMA==
X-Authority-Analysis: v=2.4 cv=ZsHg6t7G c=1 sm=1 tr=0 ts=68d605ad cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DA7DBj9iRjnvuWfEG8oA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171


On 9/26/2025 5:57 AM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 03:04:58PM +0800, Xiangxu Yin wrote:
>> Add QCS615-specific configuration for USB/DP PHY, including DP init
>> routines, voltage swing tables, and platform data. Add compatible
>> "qcs615-qmp-usb3-dp-phy".
>>
>> Note: SW_PORTSELECT handling for orientation flip is not implemented
>> due to QCS615 fixed-orientation design and non-standard lane mapping.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 407 +++++++++++++++++++++++++++++++
>>  1 file changed, 407 insertions(+)
>> +
>> +static const struct qmp_phy_init_tbl qmp_v2_dp_serdes_tbl_rbr[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_HSCLK_SEL, 0x2c),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DEC_START_MODE0, 0x69),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START2_MODE0, 0x80),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_DIV_FRAC_START3_MODE0, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP1_MODE0, 0xbf),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP2_MODE0, 0x21),
>> +	QMP_PHY_INIT_CFG(QSERDES_COM_LOCK_CMP3_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V2_TX_LANE_MODE_1, 0xc6),
> Hmm, I just noticed. This register belongs to a _different_ space. As
> such you can't have it in the COM table.


Thanks for pointing this out. It likely worked before because the default
value (0xc6) was sufficient during validation.

I'll move this configuration into configure_dp_tx() and set it based on
link_rate.


>> +};
>> +

