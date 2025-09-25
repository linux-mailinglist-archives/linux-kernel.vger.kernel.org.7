Return-Path: <linux-kernel+bounces-833245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B021ABA1847
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC6616DF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE631E8A7;
	Thu, 25 Sep 2025 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ncHx4GVX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115DB2E8B6B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835250; cv=none; b=qK5ae/xetrOVcbV+fKb7yaYOCqXIJ1anuaGQud7ZAtw9exF6wcDpzyXdYSVH/LFmCnZqKldSQI7NC0C4nrB6LZ6/6okm1tW7vPZioDYej9jU9qxrTXpxhfyBBEp8ujGuG7b7PDawyYMKNPDXqk/Cv4Jdzy/072wUVW9ui3zoFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835250; c=relaxed/simple;
	bh=rcBKbX2QQn3pJYGix6+NDLTiuW9SZmD8SBtEhKyVVY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmHitbyQkRBJ0wKZ/Rw10t757/F62bzLIFGP5JDHXlYeP3YR3lHM+IXs8FZh5J3ESRQiXEKpPAnSn9Uas7aorYzFom+7LUbMd2BMiLN/+yUQ0I0A3Rn7MOCBtWlzLEqV9epXeh/xn7V6qAbg52Lr0zdUtgjCbiL6wltGqXDJ/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ncHx4GVX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIQlvQ026136
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MNWENP4TW6FfVNRa3Q4FonUZ
	vk/5CHP1DhoTM0WHlGU=; b=ncHx4GVXQYg6MMTCJ7RYXegpCgTcsQFO1PK2sWkd
	mdL+P05vzuo37QgxtWCzzjikvqfRIbzHDBPK0ez5c46VeFHhwz7tzQ00lD0zRCDM
	6DWYi0TmadbPFFIfDdo0O6Z7RL7udFzvm+hF+04cD1yL4uY5ez4uY2kW475XsnPF
	VSDF673dU2WEOcAl+v5CXgx523H6ACDBNMghyE+5idEDNK0MmUPSrrIrXewH3s7h
	VRxwnx6B61lB4j/f03MpkZCK2HL3bKA1fX7lN4hoDrufJ/SzHv9Qe3g94hySXbIR
	9jkzrczffUacIFjInqYrqkaby4P9/hURvoHJSDHISC8cvA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0qre7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:20:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cdcff1c0b1so47683801cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835246; x=1759440046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNWENP4TW6FfVNRa3Q4FonUZvk/5CHP1DhoTM0WHlGU=;
        b=qhxHUVG2QV4tK003ZlqPVMfznKges/xENVh5sLmd6uQsBfDI5hZsQb0ixFVzfAktPo
         /9mgeEDTWEX0f70Z+t0iYyNxV0lGVTVuA6lNGtm6zivv+8ggDilzwFp0SiZHnHqqwHEz
         asAEQe0zNJ1LSGMoSTmzYh6RngezPcceRYjDMfZzEHRWYO8ZgQO40L9XZmjJvNKLflJT
         Xll3wd6XniWOPdSm4Ii6WdW1s73iMYO1BSvmWBUqzcd2UqveaEFZktrFcyxPQYMNQECt
         diRphuSh0KBSYH7qldHrlA9vuRcxEiuHvhtsttdjiZjy2NzwD97Sbvlmcjr/wbm19fnu
         d32A==
X-Forwarded-Encrypted: i=1; AJvYcCV3kb+jMXKJwIVmnOQYaQSqAAVSxZcuZL+9e8G43HSAOm7XhyXuHyc9TS0IUdnCcam5BIMRUQVs8IW69qc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+nZr+73W+/bSz6+9SgABA77YntpiFkWTLBD17LQalkT8ibF4
	wAfg0bpsxPahMpfDTigZrtDitV/vP521zlgI3+w+86PkF7sEVRCRyFyGCm3ywRbbDJMYwCVRtJ/
	/d3LFoydDxaxynKufZHeGOfhFCgSFWeg+Qp1p5o8sl3XBVo4r9DUrYRc50606bOMjV/c=
X-Gm-Gg: ASbGncskNC93LdFjvMh6/KnCFhozBPOORVPcsV/7SI7axA4mRJPe8PB8ZVAuoOeken9
	Gnc9qT2bkjLj4kaStDuJJhmLnxZ/W4NmVGE5s0MxB7DFzuSR8T9gBIhbZ3WjW2aWgzFPymRPwtI
	fAwomcqqY4xZtmr1ldrB+Kxza1GVBAxrc5Q8kxZOzloGh4uOk9fqvYOr/DtvqCYhtpCwlOC1a6N
	htCu4kmZP3MEK6Ssf1WY2BB6EWdFIZFiKZAkuP+JR105FlmGFrTC2L2WmgG9VoB7pYsN7ZyDoLb
	2n4Fg7pV1AtoY930JTIRxKNZhfIpBslQMKxTZ4cmEqKZ16kLNnTW3pNyZS4ejCxOgJt0iLxBLNh
	rl+QdjgSK71byen94k+U++oLflRBdDstcyHflGRYzBLJgbVa8/one
X-Received: by 2002:ac8:5852:0:b0:4c0:9328:18d1 with SMTP id d75a77b69052e-4da4cd4705emr60742411cf.62.1758835246289;
        Thu, 25 Sep 2025 14:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1zqTH59YzrLbgWLCbgeEbMpGPbOhNPJ4n+cnP8cXc6+u2Aei7sqWMXJ8qxBaawt/sIexYRQ==
X-Received: by 2002:ac8:5852:0:b0:4c0:9328:18d1 with SMTP id d75a77b69052e-4da4cd4705emr60742011cf.62.1758835245791;
        Thu, 25 Sep 2025 14:20:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a3102asm1122425e87.97.2025.09.25.14.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:20:44 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:20:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 2/9] dt-bindings: clock: sm8450-camcc: Remove sc8280xp
 camcc to from sm8450 camcc
Message-ID: <34esqueoush5gnawnzl7hmnpwr77vip2iqf2w7eiac7jqyghvl@nquuefkyjive>
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
 <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-mmclk-v1-2-d7ea96b4784a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: _bBuvr-3Rfe3qBcUy11oPc6_H48Ivdlp
X-Authority-Analysis: v=2.4 cv=bJ0b4f+Z c=1 sm=1 tr=0 ts=68d5b22f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=awjpS8ss-hU3v18DcjkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX0WQ0onpWmJn/
 JWW7hkE9nTkNfv6m4AiTmWV8FgzTgg3fLCnQ22BCCk3VStEfXDJ8wiIgm2pUmMOlTXaeoNSP14o
 xyRzKgMNZVxo+2TxPKlSd0sdhRgigQOAXz9ibhre3qsQ+HngxANboQ7RFvXu7aLl0qkeVGzKZ4a
 sFqrUu5Ctsg8mubz08pV5p7kzXzdU+cGj/jWAOtL/IlfZ8mJXgtS+cPP9gdNsj561++w/w3/YDk
 U33bPx4M/DC61mBcWVyX2jxV4zzxvAyOScgvJDt5oMou02wRwnH3f1AnWoAF2OXvwk70orXYLQV
 2p7o0uhtgmO97AokTb88nVlXnIvDEN+TFcto7Y1JZzrTWtBF+37QFrrEbtPjzvnFDaTPvV/vozZ
 9iPIBgS+HP69n2Kmlm4ANPjbQ36otA==
X-Proofpoint-GUID: _bBuvr-3Rfe3qBcUy11oPc6_H48Ivdlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Wed, Sep 24, 2025 at 04:56:43PM -0700, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> SC8280XP camcc only requires the MMCX power domain, unlike SM8450 camcc
> which now supports both MMCX and MXC power domains. Hence move SC8280XP
> camcc from SM8450.

The commit message needs to be change to describe this change instead of
the generic facts about SC8280XP and SM8450.

> 
> Fixes: 842fa7482915 ("dt-bindings: clock: qcom,sm8450-camcc: Move sc8280xp camcc to sa8775p camcc")
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> index c1e06f39431e..dbfcc399f10b 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
> @@ -63,7 +63,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,sc8280xp-camcc
>                - qcom,sm8450-camcc
>                - qcom,sm8550-camcc
>      then:
> 
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

