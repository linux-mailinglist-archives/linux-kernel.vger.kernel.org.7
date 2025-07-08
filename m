Return-Path: <linux-kernel+bounces-721602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA76AFCB8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D81BC7C3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675E52DEA6E;
	Tue,  8 Jul 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PP6LPZ7J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A7A2DEA65
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980131; cv=none; b=Ee70rbBmsUxCNij8HNNgVjwK/mFxcmafleSHWGbiMdFQF0N/EuamxxOAUoF8m/WtCmt1IWSu/xdqjdOY127z0pBg9ji7buF32EiZFvAS2Rus4NjT8G2ylO0BNr2Dbz7Ot8VMtU2wXZl4HIz1h9P+RPVdW4/rkRnSDCABiFpezOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980131; c=relaxed/simple;
	bh=WzAnNBoWqDOEgWIAvOrUUm+cPnnAQsDqlITlF4IdpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tk/qew0gVjnZf8qaTnnk/jP3TJ+E4SLbnttNYcKLx8aXtNsFGk/w7clQ6dt3m36MhJ7Q4Uvl203VdkLMKXifnqSnQZkW9RgAoXfcH2eCmOLwa9XaBlyMeAeW8eiBHlyI13Tgo04dvuMxZIDmHBay3BJlPNFcXOm4LhR/r/wo76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PP6LPZ7J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAP6f030392
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=; b=PP6LPZ7JgWREVlGz
	xfOB3FpIVnYll1AYnAcFtC/DmwaJdneoFKAds0rkDurunf9pH4YLir6HsmEf4de9
	HcAb4L1GmOdV5asQHAXWWHVSYybzZscWrdsAnruQvX7JKZoWdGwgOp91+6ZrIWQX
	YUre65nGE2maSnxdnrutcHQbULUETjK2S+d+a2CpRm1GzVKb36THIn0oNrO3edvn
	EhkHEL/TwV7aqGGErrPonLag+kMrXl42AS6mV7ArPdePlVFgIjTmLDTZcPQ9ohiD
	20G6VCM78LPNilAxjywxwTnMG2XzL+304fFq0SgWTulqm1zX1uARzTyBfJQBNETZ
	rAGD4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47r9b0u572-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:08:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d094e04aa4so90307085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980128; x=1752584928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=;
        b=DkEv84kPuPzgnSXOF7yCeu/IxWNWT+mvcD1LmQhFLSJUEb/6HQE6ljnrWbaFkbAjIL
         NlbjsrpHvNI0nI0T3RbRobgzdn+GF4O+x1R2tOsMW05AkmHbHEytGl4mvGSHlP6fy/By
         8/2psYHlRACGuE0NaSDqXdeihwhtCTVuC+tkfAwAMfmHvhEAcL8h5u5dpGNKgZ5ACsX+
         cUWoVBCUEi/aY7iIc6vtIcK7hTzR+AdcwjBkL7nP1KT5K4VRvUSOX3XunTXxI0v982sj
         YWpbbtAAZd/YG7x5QISuSNKyRrKZ/uDkN7gV/A6EEGMuxLwkPnj/0EN6ior4fT+lnLwc
         ge/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwEqd8wCsPOnvhMuT1M17g/Rnhsa0c4sSyJwX/ehSK1Fd62phkGFLsasxXAFBqURDKQnDliJIViUhSzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5K3Gg2FO8uTp/D/zOckh8cb8lQNH2tNiNmJ/+RSkgvYTkAbpb
	bOE71UFr44thBntPbNzQkJpvITosnoXq2ejSGeS0TGf75RrNtHyZA28XwufPmY0hTiIVv0u0Zax
	5yXTzAFjwTCWwQX6ztvm0gouE+O9cxkv2rz3TyiZWBEQXrmbCVtsYI3WYH+DMEM+QqFg=
X-Gm-Gg: ASbGncvmtzDNNTw6ZuYBkcYCG4Rwv7/Ly7zORXWML67il8eyXqaTQLXyz7iCQNdKsZB
	CmGd6RRKMX3mZ+50GsJMPSvDG3nqGP2HPGigLoJQhyARA1hwJKXp5nYoVeQ3AG6f/lJncEuqxVB
	YUWYUBHMbWQuSXeoIzVAOmQoORb/FszR5XeP59PaxqO9tViz/LbfjZpAq+tKRPVIdZy0x06ktxS
	UM23LYiXsTjsZ1kmO0+OAvxo9Q/NjkwHwPJ2xP3G8BgTQdr1PlY2cj7USpKY0kXrnDVpp93OosX
	eCb1jpcdM0oemkjRjI6b0+iYVu5Fo21jnNDD0ziOPFc6MrwtrXCnaKSkbbywiTU9ghCUilIEuZj
	N1oA=
X-Received: by 2002:a05:620a:4710:b0:7d4:289c:884f with SMTP id af79cd13be357-7d5ddb39d6bmr894185385a.1.1751980127634;
        Tue, 08 Jul 2025 06:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBiGS5COZ9Dfk9VqBJ+kMTORiJffjyBCmhWeiZXp87B/AUtfoZjbT3vyAV0W19xiv8/+LqXQ==
X-Received: by 2002:a05:620a:4710:b0:7d4:289c:884f with SMTP id af79cd13be357-7d5ddb39d6bmr894183185a.1.1751980127166;
        Tue, 08 Jul 2025 06:08:47 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm883127366b.180.2025.07.08.06.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:08:45 -0700 (PDT)
Message-ID: <8b473da7-5e6b-465e-ac33-a114a2b6f673@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] clk: qcom: rpmh: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20250703-clk-cocci-drop-round-rate-v1-0-3a8da898367e@redhat.com>
 <20250703-clk-cocci-drop-round-rate-v1-4-3a8da898367e@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250703-clk-cocci-drop-round-rate-v1-4-3a8da898367e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dYuA3WXe c=1 sm=1 tr=0 ts=686d1861 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=oBXrOfH6mq4iYN50PBoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOSBTYWx0ZWRfX6B32yBQoGu3I
 1sGAqNVgwAMQ+Y5eZZIVFCocLJ/0EtnKrE4GQSOo0YUObjaUKtM0opIMd2tG9OLmPVhnuQCgs4k
 QvZUnW/edirUBM0r0SHnOmqj7RYSPzdH32yBe7pz2HnGVJdZTe06zeU2C/beHrpWM7qvAohHBL3
 HlxCG6Da3Rt0WT+CY/gwz01u7tPPw09o4AXdtZ1Pp9N2TRYJNeE7/e4gOTQ4qf1NTF5IdF2I0Uu
 7jboyyAIDCtZuT86w/239Umr7KexWng4KRPh4h5Tg+E/aMZWvZbywRKGo+ZDSe7cOg7OL3Wieva
 4voNtccabPTNpi6O2OMlcxlbzXyGwiqmMWCaTVTgM8VWmjFNUXhc2zfgYvbii9nCttofDZmIAjd
 ugVvGj3rna1wZvFZAsVwDHgZQ4WzCQGaBhx2oAx/DJefbrqkjszDOBO232+Wmmzu7gMSvsHM
X-Proofpoint-GUID: 6xrhT34pVK4pcDGks7-9J37RgMBQ4TO_
X-Proofpoint-ORIG-GUID: 6xrhT34pVK4pcDGks7-9J37RgMBQ4TO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=798 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080109

On 7/4/25 1:22 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

