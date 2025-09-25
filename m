Return-Path: <linux-kernel+bounces-832312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A701EB9EE2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86293173EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60322EC560;
	Thu, 25 Sep 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gw+mVJCJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1229BD80
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799014; cv=none; b=bc91qy8MpmAsS8hSZYTvwycf1QwUAMy0P/1nXWlSOdhISAAvgKtElA7SV67BSbnP5Pqov9MPwJuVNSTY+if3LtVrpZZ5CshfR2tknRqmi+WSnyD4leHtaYk/gtYe2uO+9o+CG60UvfGJJMO3wmy52X8AtkkGgdlgBdslt4ScX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799014; c=relaxed/simple;
	bh=T2VcPwThL9SXdk4Qmg713JMUFXXSm3tP92DSAIb3VCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhYcC3yl9/pdFuKAGSrDdY4WSTGm9NSOuW3zmapM8WctDexRLsQrJanht6gv79iC/6xBE3YVXqatMSnxA+e6ZSg30RM2lx2vYA3Mtm4GtTozm6DLfB/RkG+Z3/AvazH2qKzxQT0edIeFNOUWqYSmStSzQcR0HB44BcZZzyl5Em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gw+mVJCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9RsS3019910
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3p1317b/OjiVJS2/YXmaa/8z5cpoRP1b2R07MF/E7aM=; b=gw+mVJCJfSpN45JY
	49ZsclwOPUART968XiXdrP0Y07w/LNlP3ipp517ItnAUM/mwjMnWgtHux6+rdNO/
	vyG1UUfIQbQZT1sajUF95ivCN1UlAeykPFD7TjULiYKEQDjfmnRHfkM93m3QUUjn
	wHTjtBb994uxY3PVdie+Tdei8tjDTaLq/kWMPTLeJSeG5V+Cr+SRY2mG+7DI9VFq
	lbx+0Xo36N40Ua3i+gdJSz6OSV9PTY3+jHlPzmZLrcAQnWNq3cfHgtujk1zox9RJ
	ZCrvQSvUNJLTpYUVljnS7gMTdyqec18Ld1IT19P/59UIXt8IHvDsXgWnPBJazLdp
	L1hDwg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe13k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:16:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85696c12803so36030285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758799010; x=1759403810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3p1317b/OjiVJS2/YXmaa/8z5cpoRP1b2R07MF/E7aM=;
        b=YI/w2tg/6JhkQ5oxJMYPzG718hLbm/qLHKf0Pa/ZhYzU/A2D9aT9pkhoMU3bW523X4
         7RQrJXVO79ziSYshu3sFhitB/MacPoZU6tv990S5bfkq/p42YxH25OweLms5f/LNMTKc
         aAxMHnvmsadqEKX2bzZtVZoHoVZmJNvNySLUiLE3Fw7tU/gQxYBFchQL29ItKJydWC2j
         DUxDeJfBvkcK8qTD/YG+WriOwFLp5AhFFrZrhsfFdm0HkfUK70nsr1kMTPP1kcVzklyq
         EWiwt9bjbkyrv1f9/knBSBg1oArsnK5/pJ7/7sVEape/PoO8E+63fPrSbEw3ajJI1Zb3
         9ikg==
X-Forwarded-Encrypted: i=1; AJvYcCVDyAdu9NwZplLgBcAGR53ob2RjehP2sM4uC6ZJvfalLvYM9lg4MqrbdHQuThHIi6s1xQvj6mgU+uDCxus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNZ3xRs6bQUYF1ptyVaAwjGWnelZdrDQ7zcVbHADEakAPM2L+
	/7409PTWTZmI4PMmQ9kGilsh7NKaQc348Z9OVG62DxN1jWeTFuMHfXeKQWb6FVyeB4NoaFt2Kh7
	2ZsFYNFhpAfEriEJMfBTLLL0e9kVerh4l0BMptNa17I34H6rObCjwzxXJxlCSMowMzdc=
X-Gm-Gg: ASbGncuoKi3HguiXF7KFMVlBzJzVRfpj8+tA0yomeO5jY+L5dyyl2qUsMwMCpqONp1B
	AgqOYDHejd8fhA67FUmsDV3Jqaat4unv+nqlyLe7Cmtm06pytYMrj7XPXKMmJ6J9xffjrqMxRID
	uKF+bEQTgoklxdipV7ciCo0A53qL6n1cCEHijlSN8UW2TAMqSnuaygn+gmZ5o8FFoSn0yuGNy7I
	21Oz5kh3zNPQ1P+3mz9BHQHKpV96L9aKytkoU2QaQU5LBWTviML3u++l6o6c0DkiV4r13SdnnbH
	hhot3DeYllk8QvDiy/u5bL0jeWmTChwA2STIXs7Awbi7e2vwfLWrlITMaaNqRC4nlwiw2vR78Yq
	Lr3dU98o+UWuzI71Gf5/3dg==
X-Received: by 2002:ac8:7e91:0:b0:4b5:f1e0:29f with SMTP id d75a77b69052e-4da4c1adf7dmr24224661cf.11.1758799010512;
        Thu, 25 Sep 2025 04:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNkcG9kfuA/k1nAetJ65GvIW+MEfbUrJraHtBF3h49xihmeaOKctfs4Ii0CuHlq4orjUfMdQ==
X-Received: by 2002:ac8:7e91:0:b0:4b5:f1e0:29f with SMTP id d75a77b69052e-4da4c1adf7dmr24224491cf.11.1758799010035;
        Thu, 25 Sep 2025 04:16:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353fa65a62sm147858566b.47.2025.09.25.04.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:16:49 -0700 (PDT)
Message-ID: <cd91e7f2-72bf-48f2-891e-4e6cd36b1e24@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:16:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] arm64: boot: dts: glymur-crd: Add Volume down/up
 keys support
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-16-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-16-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g3XaN-5POeYuY1x44XFOnl2Uk4DecWYG
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d524a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cz-Gyc_q8kcpoI4PfSoA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: g3XaN-5POeYuY1x44XFOnl2Uk4DecWYG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX2hgY5F1j5qIj
 Az02FLNjOh/qNIgnsk1rzSdKKUjTVC3hPztsOM4ihTMt75npM410ICX7+Oig5a0B3QoEKVCxW5u
 RczGUXbl/hmHxbnzi+ac4qE+fM6h3hQ2GNEb/mtSB0ssDLQZrCFj5NLy5gMBEAtAOmFmwsDM5ya
 y1nQexV2gs5vRrktqwzRznw/Snax4jokcTQ17+2c+AEuD05c5RIPTOfUrpfjcKoJOSXWwjPgcLw
 XOuvI4zxwfpXp5WgftbZqc/I4trgr2/DYmDn/sGtjBgGi8Pq+7pM20sN+TMaUOOaCnM8CvyDido
 W3k1gAABCw5mEnfBqtIyToTsEkp2tKOyG+e4/VQlq3YpOynKOnWSVwFb7U1q/mDDOtx7V6tC8+w
 3SRJaZIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add Volume Down/Up keys for Glymur CRD.

Does the CRD have these physical keys, or are they routed to the
debug board?

Konrad

