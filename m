Return-Path: <linux-kernel+bounces-871155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EAEC0C813
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F7F834BA73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8402F744A;
	Mon, 27 Oct 2025 08:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngt45IGh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD12F6922
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555291; cv=none; b=OtQOv9wQ5JDxLcuaQLu8zBMJPGVtY59hhf7WzmIQuoi6aXe4lUvF00DbgxvtOrYZwTaoTLeUxUypx1C+b/QO7gGahbAzQgkVE0HP0M06he0XAsH8bQKLuLWTSTfjuC4FblPxD/Tbqqo6l3ZJHGy+knEoDGcycfQECULdENCwPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555291; c=relaxed/simple;
	bh=d0gHDNANklrUbVkVHIAruKx6owCCpxs01cR7OqXcJ4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVnwqFT02LpgqKrl5XuL6HqR3++6P/v9gujRDHM/FxZGmbENXjM3D6ZrcHmEKUHaDILTyhPZyB32Cdu5yv6ApiVHs43lkGfP4j4mXauLgNcZn+urZ0E+YkeyzDSs0McelBzI98GUU6qWONrmra363BhFGAPTxhpIuouX0q51/T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngt45IGh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8O60W796231
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LUrLsKs2d/s0PaieRlYVP53UUARWHT+wI36bM1TCnRw=; b=ngt45IGhK2sGcNJ/
	BGbb5/udj8f3VbPDEViLsDO915jqzlVWOUT39iQGGnQl9YTDmRHN7Gk+xgRmmVFK
	ICkBNWuWdFCpnzrMgP+xfeLBlivYTriuZBRqGURA+rgo6xiZ4HpeNFuOvfla0cjT
	MA0F+pjhVOJuE5tgktNNHm9Jk+Jx9uiLPLZ6xSO5WY4VBOGcZcIdrsJYJS5f/gwo
	GG4kJjLedhWF/wMS1Z8z9O77nX9DTP5NQ1CxbutvVPGTVRzScOl3AwEHMdWeo8os
	JDujRAkpehaviE+21PW60LPDvb9Z1mEzci57RJrcq19qbXxN8gxW9DsqBeOrHbkQ
	laUlnA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4wbwwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7f5798303b3so11226956d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555288; x=1762160088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LUrLsKs2d/s0PaieRlYVP53UUARWHT+wI36bM1TCnRw=;
        b=N994bs5TG4NBy6/2/4AFeJ3uebKOF5rL1v+mtvUme+0TXOXApF6gnrO4/7R9c9Qk7s
         a+/dQI0JOY9MvdMrN5qugjj8nBVvnpBVPe4aXpZ06XM0pORw47N3t/BhkdjoaOWElBVn
         UiB2fmQvn8ZcCyY81Vf5EqxZxu7nr+SvZ4aTvf4YjWzbKgO4sZ2xQJJGUJN1i635Gv3k
         cOdawl2e6WiJrhirSqI6tAzmFJPohTbBdpjm+s/2SnsqXn8y9kNud3YsGejlBlKfaKIY
         9faJNYNZvwYKSEhsgyLrqH8dFPLmcaIxxKvWoj636amQ6LXtMRLunuQSrZPLcw31SnNP
         nWFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqHSc2TT/CeG4nQUqx/jJIrOdJRyuF2AhD4lJohxDP41ZmmK6Ib+p5L04tf2p5lKYNJxdMH4mrVU3yHrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5FT4A3R96u3KLCt1gCdSnrnmdRmNi2UxF6GJjkczIfYsDKbB
	Pyd8bSj1/OTC4/WPOJQqlcMSYUOL3ITpxriHsR9H18GOcVU2/BKdJ1XY5xib4JJ3eqWmjqcaf5J
	RoppAKHRF5woK2oQCd26FSaT42LJBdJbu79qDipyKWbrdriZL952QOqie2xOghwP2/Sw=
X-Gm-Gg: ASbGnctxjs8GT/MWahYrxNpuzBmQbK+8K+kfFrEvSA+hweoFlNZzVYFp9mQL86cvxii
	Mp5vgalpmSqO0sZUKLFF31Fhom3nCx67/xJ9DRj4MzkSeTIJTIt8COSAhv94no9cNjsMqTt0E6O
	OEIY5vzo21dor1c3bOE4Sfee7gw2WIisEwx52oMwZoDvx5BBUesuvi1M0kaSEP3cTJha/cSaWlT
	nlguuJRjK58C9NsOiDMAd+z9JamSPlo74PKuZSdH2uOO+fX4nN9eCCfd39zzE+G7DjAYcuOc1Kv
	HHqqBtoB/Ghml9mD8T7xHBTLdCdgtvg3Psj/h5xtS3rOw3LsSs9rvgUqcMfx3ZkULXhNqYk2A4k
	OQ/YCWfGbpbh/PHw4+MGVbSDVTmmQeWR/nCnkrUi5ObTEF2+HXuvTJUph
X-Received: by 2002:a05:6214:240b:b0:87d:c7eb:2743 with SMTP id 6a1803df08f44-87dc7eb308fmr272761246d6.5.1761555287783;
        Mon, 27 Oct 2025 01:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQLwxIWQVmNEtHsQAWHxLLfHwABji01MEWnNC0Z9vg2T+gCI0aBxHit5UrPn0B8GJHlm8a/w==
X-Received: by 2002:a05:6214:240b:b0:87d:c7eb:2743 with SMTP id 6a1803df08f44-87dc7eb308fmr272761056d6.5.1761555287269;
        Mon, 27 Oct 2025 01:54:47 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077c7sm703606866b.7.2025.10.27.01.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:54:46 -0700 (PDT)
Message-ID: <507b99a8-b8ef-4bf0-88a6-1a82e6b794e1@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:54:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: x1e80100: Add missing quirk for HS
 only USB controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
 <20251024105019.2220832-2-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024105019.2220832-2-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4Y7ljC0eHC94LCLMXoZ9XDZiVkqwEvo9
X-Proofpoint-GUID: 4Y7ljC0eHC94LCLMXoZ9XDZiVkqwEvo9
X-Authority-Analysis: v=2.4 cv=NobcssdJ c=1 sm=1 tr=0 ts=68ff3358 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XwfBWbWjICH4QB9PVrQA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4MiBTYWx0ZWRfX35HbGALrQoCC
 Ip8H0vvBdmRBq4JfSSMor+TXPMg9xascqVpjD0NDzAYYxacHwML036wN+mQhf2dz98dzf4FUQUB
 HWBbab+E3JGr5JMhgnOAfX0mtKwoL2UmCq6Q+dSC2XEFR+C3gn5UleLjmVwj8vCyxjHo6bjGx1/
 4Z7natDz6W3tJbl1jaF58GwKCLR6skPSB3alweviOhyDCiW+vBq7rX8BiK4VDYz6N3icM3LbQfy
 hQx/dDFOrlmI6ajxrwU4qgxmUS82ZFoKXj1pY2jOv8iHrOURbs2FLKf5De5Uwl1FU0Q0yGd6bAs
 HB/eVQmF/lZFWb4xCpJrCJERQHDemR3dLYAN9xdytDStGsNHAvHydMHjH9Xwc4nQnCwQrfNTUi/
 rX3RPwAScZdCFW95WwwVw/G1p44RLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270082

On 10/24/25 12:50 PM, Krishna Kurapati wrote:
> The PIPE clock is provided by the USB3 PHY, which is predictably not
> connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
> quirk to  HS only USB controller to disable pipe clock requirement.
> 
> Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

