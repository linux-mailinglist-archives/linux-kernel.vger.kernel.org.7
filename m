Return-Path: <linux-kernel+bounces-805171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4566B484E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8104F1747DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BC92E54B2;
	Mon,  8 Sep 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0BQAb9m"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9464323371B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757315796; cv=none; b=VgvoB7UhSBtwPS3CZJPYgkzXZ9kF2SRQx1jq7odW/NlN0uL08wpRGL4qb73NoyCr45CGn0En2h/4giOLjP/nN8RRm2hnktZhsC4utNB1vIJTAr44jjggKWqbdcOQGlNLLgpmgbUiR0cXWucWYsUfxBG3gKa95kJWKzqT/551NAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757315796; c=relaxed/simple;
	bh=0jZlyef1yvCqYyJvmMqZtF1i7wr8h7b7GqLpH86XQvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8V/vVQ9almawSdETpCeKtS20ZcpDpKLXY7cNQqW/A3YWGLQFRB3G3gKbT/6G3mPivV0JpfFItdyvkSGZBVSgpIyUXOrNy9e7Wo84NTo0azQb+bJfqkZ+h6WOIUqbfjQ+aLBbDpDLsMN3W+9aixQG9z7s5X6VZoQF4j93Bapa+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0BQAb9m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587Lj3kw012802
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 07:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZaKwF3uTvV0qt8pO//IeFHi+qzIUMNGv1KFMfckt8OE=; b=E0BQAb9mPmuozXUc
	MZp6LbIFfcTrzbktlYQW0oNLK8BLL8KI2MvRVU0YCJtbe129HTqEYXKukEnXFeYY
	Z9AvQym7Y7G+HdSCWYqX8ybqUHztR6Af3q7nhZCrJUhkuhMyX5m8vxsGYm05QYgG
	tpuRvSvqEMo3lnOvY2DZ9r/5/uvIVoUYJmkzhor1rPdaNZL2yMTBdnmARetqLoD3
	RzbUOsVqDItmNWvoFwpRD4b4AnnGC70+r/EvSo999YHbXox4o6yvSD08BXGGL3qH
	OQ9peWMvvQ+aZkFq51+x95T5W26XMF1k6kn2R93slZIAroLRoTwUa6IjSVo/L847
	1JjhVg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bws3p2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:16:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b601ceb41cso7653461cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757315793; x=1757920593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaKwF3uTvV0qt8pO//IeFHi+qzIUMNGv1KFMfckt8OE=;
        b=QOSo2ZKjva/T3uzx3aOZoqLztMQIbGTFGM6OiZR32K5EyiGn7Mpv7N96QG/mk8gAI6
         JwcawvaHqNt9sG9O0+7Y3jhRkOZDGowLiV5rxwcAzWFyQCL66F0tm0MW78v0swykYsNI
         +eje8FIVp7Etb+VEe2IgqUXXz2Jzg+U7Xe2fc6tWuMXpDaBlVCWeG8CwJTndfDiwOPv9
         4WK7q/5xmgehYy3PCakJVjlFA+Q+2EDyRAUYdiRqCXcVrF8W9xg20BAJo3q8iGBxg9uH
         bqCE9Rb5BzXZpmVVQaywT+p5P6XDAGyV139F4Xp2qKjjcg7V1mBDnNYZgwg7BUsAvXaN
         dIjg==
X-Forwarded-Encrypted: i=1; AJvYcCWNH7UcB+2sK/0R78FStzp6KqQKdiM77RG34Da6hfI6LNkVAREdI9foqfsxnO1rhsf6QECweK59dmVi6y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymdL2d1S+Mvtl9caMo4CInvJYxJq1BgVwD0zrIZhfzOXxCwS4j
	tkBn+KRl9kqoasxgCas/2YckObWPvmLi8EbhVu/ulmZWRpAJiY1gwDKdiPqlwUcOF4pYLuJCSjU
	1hwG48ES4oHATq0c7xwpK4NmmUwsqE/eOPjoR9msvU6oDHSS4Qp1C1s4E/fl6KnJxnXs=
X-Gm-Gg: ASbGnctRwlSCdsUkDsaEZAU7BZmM9WoH1RL31+uq+MAm1jySUQLenQhzCHOobCgGuxd
	mrpfAMnTSQAB4LhZEvV1FaoEL2sVrladj0kNomWOup4pXAuECWiXqdn+FaiLYIWJrwQa/Gjn1bZ
	q4x/OHeRfHnycikuZezSxjjKQ10wtC8urWZqdzlE1sVEJ0HLWHIsOTRNM7ueSaLe3hZkFQujOLs
	n1wm9BRGTmLtf0NaXbbG0tpde3XQUjF8sTh+V4Tf3wkkpZIrxaOLg3KAD+PKisCA7aMTKStfR2v
	oSMz/iu8luZQQrd+xYAEftnc8muDrWezYxQiC24tGSOB9xt9b1ejuIlLp4Y2QkndBmy/Ud1iPoP
	bSzqIjDW/7XnLfe1b2BD/CQ==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr52719181cf.4.1757315793088;
        Mon, 08 Sep 2025 00:16:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGleczMa2Q7omIjZHxAPAoUdrSH+RT9RzFZmldfPTQGN+mYVhUoCTb0CBLPp6B4wg1HrxnQCw==
X-Received: by 2002:ac8:5981:0:b0:4b3:4d20:2f9 with SMTP id d75a77b69052e-4b5f83a513fmr52718941cf.4.1757315792535;
        Mon, 08 Sep 2025 00:16:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm2323810866b.88.2025.09.08.00.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 00:16:31 -0700 (PDT)
Message-ID: <c66fe361-74c9-4471-b371-353ca582bb3b@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 09:16:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 add HDMI nodes
To: Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250821-topic-x1e80100-hdmi-v1-0-f14ad9430e88@linaro.org>
 <20250821-topic-x1e80100-hdmi-v1-3-f14ad9430e88@linaro.org>
 <a38df652-54c0-4216-9aa5-c8d32599c8f7@oldschoolsolutions.biz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a38df652-54c0-4216-9aa5-c8d32599c8f7@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HJjWU-r9N5wPRBcY7ezEhkHCtnpzJ1xp
X-Proofpoint-GUID: HJjWU-r9N5wPRBcY7ezEhkHCtnpzJ1xp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX6uaxcNdNM0zF
 uH5aVLFsfGpvC1l3U2ugijoUFB8nOVWcB6uF7CbKKlC3TKtvl4n+qUEzHSvfP4C0iWLNZs09BZL
 rwDW80pgyZbYYfH7LC7jHdWEzz+3hjWeXjG3ziGV7dlTbGHk2iPBvuxBdBQNcUoXB8Pu9Yv3Eyw
 vm3QTmdINWvSK6PVsGEmoOSFEgbjAtoAKPv8EhvjAkby3dSqLNipjQ37fttl0SLlI5OesW9BhpS
 B7sT4YH7HHw6AgbhUdgf3UmV//Wug36KlXCFBEUb7pm1d1quvl2NC/pNPJ94U07cYrhR49sTuzU
 e0hjXsrzCWmJRa7dsx6mgpvfFK9XQ3eRoGroXb6SIXYekOovmstQ0OhV0vbODIuqg+KmQirkLqn
 GNGMY/BP
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68be82d2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=kc4OFxI6wrfgCCI0QPcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/6/25 10:41 AM, Jens Glathe wrote:
> On 21.08.25 15:53, Neil Armstrong wrote:
>> The Thinkpad T14s embeds a transparent 4lanes DP->HDMI transceiver
>> connected to the third QMP Combo PHY 4 lanes.
>>
> [...]
>>   .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 44 ++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
> [...]
>> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> index 4cf61c2a34e31233b1adc93332bcabef22de3f86..5b62b8c3123633360f249e3ecdc8ea23f44e8e09 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> [...]
>> +&mdss_dp2 {
>> +    status = "okay";
>> +};
>> +
>> +&mdss_dp2_out {
>> +    data-lanes = <0 1 2 3>;
>> +};
>> +
> 
> Hi Neil,
> 
> shouldn't mdss_dp2_out also have the link-frequencies property?
> 
> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
> 
> Or is it something the bridge already negotiates?

No, it seems like our driver falls back to HBR2 (54xx) ever since the
driver has been made aware of this property:

commit 381518a1677c49742a85f51e8f0e89f4b9b7d297
Author: Kuogee Hsieh <quic_khsieh@quicinc.com>
Date:   Tue Dec 27 09:45:02 2022 -0800

    drm/msm/dp: Add capability to parser and retrieve max DP link supported rate from link-frequencies property of dp_out endpoint

Dmitry, is there any reason not to allow HBR3 by default? Is our dp
controller/driver not smart enough not to advertise rates it can't
support, during negotiation?

Konrad

