Return-Path: <linux-kernel+bounces-721607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C4AFCB94
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1FC163418
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CBA2E03ED;
	Tue,  8 Jul 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CCpbj28q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7F17C21E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980200; cv=none; b=OaQ8Bs2qcvmzTEkolk5xQndjOuPaCG0Jix0nMmMS/BjWi46vhE40cG8aU/L5JGZweJV+7Ry9wgytRqMk63PP8XRca3VyHQORHlbiWrfyPB9kI07dpjbS2TZceGD48mUykTMXA1wvMhMrhWIkpAKs9OJ90NNziGRSOWaS/BsGVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980200; c=relaxed/simple;
	bh=WzAnNBoWqDOEgWIAvOrUUm+cPnnAQsDqlITlF4IdpJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XS9ccAncXwT016bZlr8aw55heCqmZwt9DGlt3c8zUCfMl98TTosCXCXeqgpafikL/wYztap63foyVo8ZzuGkyoNEDOf08kCfuBBqjtuvfZs7bUD/Lukf803G56qPQu4wJSa+pndiQ85/LAouh9c96bpzMl+cY259fnn2UTn+Rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCpbj28q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAbou031828
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 13:09:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=; b=CCpbj28qOrmF3wr+
	ylO4OFXys2TQmkJ2Dmul5uQ3ibyYnDGD2l0rIL4VZTVNuw8+wmsDZu3FFUJvqWIO
	cuXSxQSHSNviD7IHV6qCMxAVfKjH8zVK+5igRyJeKLPbPof6oh0ONw2W4ozKgEI8
	9y0n5wQyvwQIO76VfJD3Rr9DFa2uw483kad2luphG4QLnlQMa0eKAs6JlEWZe8Jy
	qtmkRS1kgi0oS/hxsQ7biMretS3BroonJXIFUxbf+edCiduWrqE3DtFLh6O5iAig
	frEXKZkN1FvwgHY+yIz4yJp9C/kg605PTA4wJFSWG68kYhP8hJd5VHPXmhes35rU
	Btq1hg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qn0y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 13:09:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3ea727700so27586585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980197; x=1752584997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmIrXBmloEveFtaKUykatLGYGI7N92PV13SbV/egCdQ=;
        b=sB1PsyelIe7MhS1i2cUblaWbFeUfIPcHzRtkaUewct31XFONIpBceSJFXQCVG6W+74
         V1VjaHD/Ie3kpITQy/nHd3vLcWbEsvsNCpU88K/limzCDapcGX9wPTENyhV8Q7PjB4UF
         beOu57mUoy8ysVtRSg3JGt2j/qN8ci2ki+lcqO9DE1S4QQ3XaKW65KM46DD2FqslEIhb
         olDUCuo1WWctJ3G46FFlUeDYj4kB6Yo+6EObHEGP/TBGvhfXxURo2gHjnWo3N9J0zajX
         84tAwyGyHzmxhEcgUO8vrvsCnBqxzCcpOr53UNii8695x8rFOkGYxGZamBU+q8EuCs8v
         cWtw==
X-Forwarded-Encrypted: i=1; AJvYcCUCJ9Gym52lo0OctQz7OjfVIr7JaRGCOk/mProCocSWrjxuEH9+uCqBeulgHCp782Ri4Kz4Zx49FK3quG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzig1qsM6woUk/bcJOBG0s9o3zCgD6mDCKVzdHQqJ3ak79aF2Cn
	M0mcfO5PZ/y4WyfBnF9MoyJIdP8vPU8SuVjWAnwRbYtPfskDMCv1vCUhHVCOSNnJI0olxXpUJlh
	fd5TikhMCYcYbfXtAuTXth2Cm0KcgDKFgAiS/Ct3+XyHRotvFMNwpkuVpRuDt1GCLILY=
X-Gm-Gg: ASbGncsdvitZip9YORyF6klS4nc+5GVm5jW683MCdG+2x02Co5j95mHCyPoNd85DIhd
	nPEgblfxWQMZNDNPvyG+JGPVRBMekhmCcB5OwWeZB6qp9dcK406Am3jRxoazNEki9GyjyEVznKc
	Xtu+Z1c8cVlvRtH6o/ydV3in2qmrk66fIgFqCbuEP+rry6OMDu8BhU8ilxwL8HKZJ30Gyc7/dou
	bSMEnzZH/udLZ8RtTbsH6/Sq/m2FF0syqfi16TvSo+KDoSa0Y05zuTcoqOaq3GPMfjLNDv9EWOR
	Qv/VcgOMQkR0Dn/zbgKm4XJgi4xNVlDjmING0bCbQjELpGt5vXfDUQztRfJMyAVQ5C7HFo8+6DY
	54fQ=
X-Received: by 2002:a05:620a:278d:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5ddb5ef03mr978558085a.1.1751980196536;
        Tue, 08 Jul 2025 06:09:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2dYjcZuaIWrO6O8xk1UgLVaTuTICWlO228fFZW+hQppHyMeiJyzzbcXYRDvSDFCu/Asg4pA==
X-Received: by 2002:a05:620a:278d:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5ddb5ef03mr978555085a.1.1751980195907;
        Tue, 08 Jul 2025 06:09:55 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb2f890esm7151467a12.61.2025.07.08.06.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:09:55 -0700 (PDT)
Message-ID: <52dfe364-9831-4425-a2bd-0541286b4f74@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 15:09:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] clk: qcom: spmi-pmic-div: convert from round_rate()
 to determine_rate()
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
 <20250703-clk-cocci-drop-round-rate-v1-6-3a8da898367e@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250703-clk-cocci-drop-round-rate-v1-6-3a8da898367e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEwOSBTYWx0ZWRfX3lKdwIIyt/0P
 I6oXkPuNOkPJk8uX390REZDIFYj13VUGeAzeuXHazMmEPOail/0S4O0Bx/fsUOv8+613hIi0vAW
 RcKfErysgZoV4YZYVv2ChNSA5INRxx8VJOB6KuUUILxXOZQN4szS947uz/tjV/r6YtudSuNVnXU
 3zZGtbVvkszUvlihjpBckNRjmbHG0f/cRXpcKHl9YY3mo5FucmlCDax1fce8aaiMfS+T6fIOxWt
 iljDaMbad1RBCfRkjFt6ZSPPaX0XlgTFYrxkeimUWUHTzTa+n0Vgl+fUaLt1eOV4LbeiC89L/cR
 5BUgw8e6s79N1OnXECmShsTd4MZLH7VaoOTzs0nvIlu/h17yB6PY75jKVDGk8uxp+e/c1HGV5kh
 0BNUdBIO31kMSF5RvhTYV/4VShn2G74mOy11946BFx3ib8rIP4bi/uxKLLE8NEEWoCBxdDOi
X-Proofpoint-GUID: 3zRKRq94xTBD7nnlLm2Rm_SXW8nHH5kI
X-Proofpoint-ORIG-GUID: 3zRKRq94xTBD7nnlLm2Rm_SXW8nHH5kI
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686d18a6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=oBXrOfH6mq4iYN50PBoA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=798 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080109

On 7/4/25 1:22 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

