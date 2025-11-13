Return-Path: <linux-kernel+bounces-899019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D67C56958
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 04AAA347827
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8452BCF68;
	Thu, 13 Nov 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5QEFRD1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X92KHcee"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBB727E04C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763025771; cv=none; b=q0mRZL07F3o9vpDeUtab19+BeHghrmWWYa2j4Fxyy+roWQvbkivYljbOJ4OgV4zOj7oKpdx30oq8r9q+PbCsrmdcNcwtKcZX4cGYLuBliVHFosuMGh11drfbD8J2NDJVLOCkGZ6Q7t1KbKUpWc+LA7c7HXjukn0AmpuqP0XkUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763025771; c=relaxed/simple;
	bh=W2BfkHtgH+1v9VUb0JpsQJoWkwy7PUVQrLyLNngOu60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfEVQpafFg4DBSQGxaXNy8y457ToD3wEKmWslf9WJOJ7AdPPQC3rM8MRxZ23YfdeQPGBX8rfZrrkhEeLCxUECxnGPU7MhLRLs3h/RafjsYIJepUHgFMZBsAmU2M8/AN2P9ydcBp00jI1rLwPMW4CI3ayuKFHsOct5qkwveZtcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5QEFRD1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X92KHcee; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AD99tkH2962273
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MDrtrR8Qqt+4GRaR7Lz/ou1frFaZigGu4hEdUoSZ4U8=; b=i5QEFRD1mKAd4wFk
	zbFAk+IzuBboErGBOlwl9YBTXPt8VN0f5YBG8NGbz+/f37VHOANJZWd8zAaKal3F
	17onAaS4O7MlRVRaZppTv2jo+p86JatKEt6GfoVcL4HoSCsrKa4c1x0k8dja4aAz
	LxXkO/OcAYHxDJYq34K6L8ppyN00LOrFjw+SKSJMhXXQSSLGZoRKaQH6pvN6nNzq
	HmJZZlkSTBBWVjkc343Nj/Ba9an8QS9sA/3VBkqvD87RTNdUyDHSUtkBb3hrWg5h
	BkttYorOBbbMUvGNHJpqNIW1djzWzMErSVy91AH0TYJrdYeL+tle6oW894RuKdeQ
	aDHyhQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acwbptygs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:22:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ede0bd2154so1533731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763025768; x=1763630568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDrtrR8Qqt+4GRaR7Lz/ou1frFaZigGu4hEdUoSZ4U8=;
        b=X92KHceelQ1jW+VCMNtcdxfyINwFrJG3ERwoovoI185wzTitflH/suBAKtDfoHpLYF
         b7v7lKNvLzYRsgoopfLjr+KtBkgJiuJSLvtEa3fmIIacwfRfZOwTgPb2qihrChy6HliY
         n0Kwz6EYLVrFp8ujyrh4UY6+LR2VMyEk9ja1j800E+EvgyjnWwHtifzOOEQrbvo1lgWL
         NSfafh7Ou9dGNgl3UuBWESBUi6v58xa9T53uJQbkf0TvYhAm6yY2sOtT0AA0h5/ZyaSS
         sR7ceygz6PmbdE0hlg97QBPEJZl1VtiXDLWL4C/ht8TYF0UsQbIK3xsXFwn8CpU9e5jg
         1o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763025768; x=1763630568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDrtrR8Qqt+4GRaR7Lz/ou1frFaZigGu4hEdUoSZ4U8=;
        b=KvSEtRhwf1M/YvuA4l+mL3ZK/xWwO1O1hz8AD9o8PyT7Hnk7RZkoxrDpAH1w8fibCf
         7UczxmF1Yl+9lsRdfx9WNRM5tfACvBBX2zF7zoTxtX9b3bMYGfrb3/E+8DUQW2gHYgUJ
         A03upZj1Mvq7+NQkqPjLeqafWpCQC1LRPkKmU89s5tuDTaIWTzPW/uUHj77VGmEcY3f0
         ugBKNrE1wldar4+WBFTFtPyZfpy7mnCggu1xztbIHSTL9fmicFG+b7++UNARbAG2j1Ts
         Bn0+IxUMgZve7GeiTyEC7wJchRyr31jkIYb2kzhUOh1fNaTO/4hFlS9yLo33VLlPFSyU
         b5bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS0U/5YpHleZLjmM8KEC7zKB6Dgbfdxc8BwBFkgKiAhuQ6g9dQdgS4HGQbcb0ja0KWRIXCJMOWfSt63RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YypBcOQH7o2WxX03Reg+yViD8YJSjRpKENQD07t6wzFf5SJJlnJ
	yMoBnVOmZg9ytxdvnofJ40kkxaiUim6q3OhI/btKpWNxEwm73MwPG5V0sloaOBUGdrLqbCz/jMB
	zruZuNELJmfxhdVECTMretomHlRBXUW50Hl61JWr/MuiNVR1xOBkOntbZiPg5+u4eKJo=
X-Gm-Gg: ASbGncuvxKLoZo3lSWSg9NtGX6Ww3H6PaKDIZ7YMTeb92cE50dTMxVttJ4i/8WJyS3q
	BFy5ywPyQY4bEdukJHb6TBZasQK2M4/Bdj4uXYsTN0YXW1kpI7i6aic/2yPwjMF35GphJ6X6EdH
	vI/zTn/mKG3wRWzNfLopMSe9vMPdJ3Nkx+FY65OKUsqzVk9eREaurUVih2sreS7NMQREzIdk6vM
	tK6EHr2eQg0KvbRtirbjewYEj8P/6lJ0JnCm3kltYmafQ2qs1sMnbeCpS+SkTLDbF5+oKfs6qcY
	aeXvFjKXT2dire0Wf4mIrzwSE+7jZZicxZYkt+gS53o1qwYi232ifu0GUyAWYBIlSks+DRaoVcT
	DpG1ANO0w0fFlI51IGO1lPmX7jUkOKHobY4Luwedjrir4w8Q15002aQtJ
X-Received: by 2002:ac8:5dc7:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4eddbc9b895mr52452791cf.4.1763025767928;
        Thu, 13 Nov 2025 01:22:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHPU49ojKQmipJqKygsJf/LlELHlgbacm9oTO7EejCNBiPlgkZGK9XGeiz9+g2IXa5o95g6A==
X-Received: by 2002:ac8:5dc7:0:b0:4eb:9cb1:c290 with SMTP id d75a77b69052e-4eddbc9b895mr52452561cf.4.1763025767491;
        Thu, 13 Nov 2025 01:22:47 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd809d2sm122683366b.42.2025.11.13.01.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 01:22:46 -0800 (PST)
Message-ID: <896b9ba6-c8eb-4bf9-b6f6-da5a05efc816@oss.qualcomm.com>
Date: Thu, 13 Nov 2025 10:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sm8750: Add display (MDSS) with
 Display CC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan@quicinc.com>,
        Abhinav Kumar
 <abhinavk@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
 <20251112-sm8750-display-dts-v2-1-d1567c583821@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251112-sm8750-display-dts-v2-1-d1567c583821@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NvjcssdJ c=1 sm=1 tr=0 ts=6915a368 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=IPDGKf_5clKAjOb-YU4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: UaTtJq0udufSLalzPp6XJFPw27Xwsgyy
X-Proofpoint-ORIG-GUID: UaTtJq0udufSLalzPp6XJFPw27Xwsgyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDA2OCBTYWx0ZWRfXyMXMTp3BiXUF
 nWuy7kO6cQfYHQBuHxootvxbEd6Ad9ugkwFLR3xo/vL3p9Y5MUH82umUnV3TsPbCtSEuyojo1GL
 Qw7CSBPwufsIjEsSQ1C1YXDR695tpHDI16IO36Wv4QXLevlgRrWLb+/E79beMomizz39nHLCSAk
 IWvvsLswwyHwoaJAdFgOgbOfbeSMk2zoV5Om71Talt74JljsXz/MmbwKHBciUoBw7p8cZchIcax
 Ig/ukjrSEao136aBDe/Gwnli1IZQa04FJIS/9ihG1mXuOPdEFoH2QIyrMCdBe6NxXJVFocAEDm+
 Fubz+oJ/3/Ohl9/vQtRjQkfGR0V/xovn+RzcWuwE/C00Zd1Sw+mpthGYALKh6QzuCYVx1cheJsR
 y4HQUU/0WS/zad2USvWx5Fx9g8Cu/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_01,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511130068

On 11/12/25 4:02 PM, Krzysztof Kozlowski wrote:
> Add device nodes for entire display: MDSS, DPU, DSI, DSI PHYs,
> DisplayPort and Display Clock Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

