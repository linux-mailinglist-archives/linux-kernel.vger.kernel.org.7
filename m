Return-Path: <linux-kernel+bounces-830309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC6B995FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9775164092
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E102DCC04;
	Wed, 24 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFXLBCvg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978A2DCBFA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708652; cv=none; b=aGSAn9DVZzTMc/lAEIWwFdoRhzrsQbjvLv4bkzBCuYShjorHwtLgZA8Oco1Y26ZJn5IgQIwRvweAG0U7eQqc3qkHzYmFmsDktAJbH7WGCanov3PJJeycDarSZBVHepjTpwezpShON9qV3e66QlvWNNusHybWwuryyPlk5XDJoF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708652; c=relaxed/simple;
	bh=hG9vXk3xqqS5sJKxJ+b3Algeez3MySj5qds+jtA+wyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGj4hqnEnMnM5CKUZ+wO4/sz24gO3E9+J5I3yccAoCR2OhiMYRar5zm00qwFw/JpKkSO+ARnkAyT5uSfaZfWu3MQgH/m45V5qdMkDOgtHSnMUD/UGJYsKIkuVoyCH2PcCc0iS1IN/VzgZI0dFjLfejMTSrPJxfDxZm0x5Vcg2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFXLBCvg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O4iFIw021569
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	reaQCZEsqV9Ey3nQvVS9bb8F/IOH+ZGngthf5MS2fkc=; b=jFXLBCvgEXC5dOt1
	3HbjdXv6FWO2UjygCeTY/UbxVNPNQ+iXuRSuAFRHOloKsu9gaWC9PDc+yACPLBhA
	z6nJFzIQEUWNhjq1meI+slJiMwWU72zPd4y/xX3CcZGaigperMCUIjZXkUhT4jyp
	NUpc9Lvi5NHmdaicoNbjh4HqsPSqzI7Y3t5QAwK325BlO5N2LBYLmmqeoX8Sz/3Z
	5a80PhRXWbTzUImyzwtIDl/F2zfClIySUQM8NKs8VtUZenEGhETboyhxwji0Zi+n
	o+RaZdKSEwQq6asF3o5m1+rLchvZpueUYMmqqVfpqXezIg9Sz5bRxUjDDd5RS32O
	ebUnGQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budabftq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:49 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85696c12803so29730685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708648; x=1759313448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reaQCZEsqV9Ey3nQvVS9bb8F/IOH+ZGngthf5MS2fkc=;
        b=pfH9+Nmb9KkhX+25divxIWbR7O5kDIcxWsAqyy8h6XaJCb7icLejs+VjHu9LVa6PUn
         qsaK0x7WSljGxCE9lZdH/lwZhGqMKPbvtnjZnBUmfOJ/F+UjAzZsX4Yt9GXJZU5RrFsU
         jcpmrthiNPOW8mGQM/yTTFkdtJRhmfT6N+uJZbP7zeCtB1V217g/SXT4gfrwF7RMvGmk
         z+KceEQIKhoCThGjlWJzUo1wSBP7p+dV/NIifA7EGn5rKVYTxM9cdQZyptFFANaQgLMA
         v590ruIRswTGCy6WK1aWr0iEWq9Nl4uuhUchncaKzp2/8vxBR3KO9NLblkwbb+GUrgvd
         ypIA==
X-Forwarded-Encrypted: i=1; AJvYcCXb7jRKDmgdsmuWIQVXAYCTUYvmmqtk+Bwm+EW2uqwBwl32xom7p3UtxaaDHzbriAWby/dmdWwtjsNFjp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLwmsyJxTfBBNgquKCCZ77xpThi2hy5CJlQZeSMNh17CEf+iYA
	PrOYD2SlwgRjIg3eZ2RF9vM0n9E5E9t5+ttwaiy/Kuo0R58/0fN6jeKmex+0JYntjjgi+RuMW8i
	qNplWcU+EtQfff/BES/Q+DidvwkPskFYWyCoKFnQ/EQ1v0xDcsuemWltujiiBXKIG7yQ=
X-Gm-Gg: ASbGncv7Y2QZwUCisI31r6fJuXnOwapuCBC0W+vqkvw+D+R4CilPwtOEWXprV7vNcTl
	a62rEnLZkDuFu85z9WP//IEmjq+zKyYgCZyxYIqvTWA4joa/CwZxPn06eAo974FW6DKf8gDB48r
	/kt//S8P/HsHKxizs4uPguOv0GVyAuepdYd2BvWZTpZJgTwGfx1y//5ye1rbre6ck22I7gbML3V
	GwBwYTfUPlA813G8YrjnVlxyHaO0TmifFJv8HdXK3WGt0lmF0+EwVD+2vK3K4ssvAvFJLavNALX
	2VLAYZD7qUh8kuVyGEYK4mmw2TwqaA3ZubeGoC8mMR16TYHz+UvtebzUAI32eYMyDAzZ0P793VB
	AKzt3tASyMGgeTnvbqZ/97g==
X-Received: by 2002:a05:620a:2983:b0:827:a484:6358 with SMTP id af79cd13be357-8516f7bc329mr421192085a.7.1758708648305;
        Wed, 24 Sep 2025 03:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSYug89XWA3Y36eawctaVvIFnPh8zbCfGbX3tsUavuH8pOUbnlgm6o1GsVRTRymVWoNhu+7w==
X-Received: by 2002:a05:620a:2983:b0:827:a484:6358 with SMTP id af79cd13be357-8516f7bc329mr421189685a.7.1758708647682;
        Wed, 24 Sep 2025 03:10:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29c776391fsm893244066b.81.2025.09.24.03.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:10:47 -0700 (PDT)
Message-ID: <b0984781-dcf7-42ea-9974-ac8967d56fad@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 12:10:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: rename sm6150 to talos
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
 <20250923-rename-dts-v1-3-21888b68c781@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250923-rename-dts-v1-3-21888b68c781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FG5MN_dnvogTFTKHzwBt8Odqj_smGnQG
X-Proofpoint-ORIG-GUID: FG5MN_dnvogTFTKHzwBt8Odqj_smGnQG
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d3c3a9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Mrsn0bZosBzyF9UykkoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX74AhXHioztpz
 7bWY5REE0pPnT1s30YPhTC/g2Jpr69++mbs9sVIYyNkTamRMZc2i4ORzMYEAqRJ3pdIPUlXvDL2
 65ENkeBui3bJjXFBzkmwIZx/bUPINlv4HCG4L1l+T8ZBSQgHWv/UUYwT4mGCLcXUS/gKTmP1o8Z
 AxkCf8PC0k3kGw0arp2CrbTGOyg1WfVdq/J9ILeEueresgxlEovI3blbxcuxcfWoVkToQPDvpkb
 8BpuhZlu+iVTRK4qK5kc2LKNvoAZyuUG0pMh23vXynuA7c4Z0TQQTGMWEACbLvISCiq+D3++jYb
 RTns3lb4S0652qtxJ5AjP/l1/XUics0IY/RHAewaYW17ytuYgqZ8skDIinuIB+41GbH7aqPiS2q
 UU+aYnq+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On 9/23/25 1:01 PM, Dmitry Baryshkov wrote:
> SM6150 and QCS615 are two names for the same die, collectively known as
> 'talos'. Follow the example of other platforms and rename SM6150 to
> talos.dtsi.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

