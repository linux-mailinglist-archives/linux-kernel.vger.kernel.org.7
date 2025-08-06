Return-Path: <linux-kernel+bounces-757930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A083B1C873
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE5418C35AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF428FFF3;
	Wed,  6 Aug 2025 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khTcZuR5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2026F1D5146
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754493202; cv=none; b=j8cfFbLXbkO+xFe0st2EPFfiSlAD8iNGfTboiHknlgVqVrnfHEPBuq6qGksIoBd86pC+X9nRV/28HeO7c67KrxkNORWFpNu35PiDBJtAiaOBpg6S3ZVe3uzZ/2cb6bpkgjCCEH8niwXiCYuEEVQe/A5cCjBBRUfWpfAbc+jr6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754493202; c=relaxed/simple;
	bh=E1ywD+6b5TLidW881C8mih+zT9s566iOTR/teEUThjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Udp77Ywxd5OxxyoqkpTF7pbYSydQ5GcrHY7kwWaoQ98zKPTeIXaEjhkZI0H8bKP2p3vOjhw7IRjU7PsxWsBgTjdUtkkUaivOoP1GZyJFhRt7M7dqTIytJIoZWEh35SlzkKP7CSW89b4AUIT9sxRpfvb5+oBLdJVO4QvuawWRLWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khTcZuR5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576ANBRR018341
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 15:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FoD5ue7FLv/tVVaOYwgBAkYsHyRWsTQqwoytYtbdy8s=; b=khTcZuR5SEhABMhO
	WwwhLWA5NvWeZ3UTRbz//6qHPRP6zoOaKH+jm41Ar0R3QiURPxJlIeRaiCI1mjvJ
	hf2GyoYqtjuusjbVywIroHfjbUZoftoUdB+Dn8a5hYBAhE11k/OuvYZrGVRq7q8i
	Ts6pnSkBprKFdNFQyTDqDEvkZKzRLA2icIDCFnLQO0w60667mcNcNV6q+UZh4NzO
	eYvDXM4aJVtOpRmQX6zGoby+oVH6PiLU2dsSKrQUNCkSHkqU/NOjxpGD0IDhYwdO
	nQeI6eDpKV3q5tURWaYc190g3xOcnhBcfkE3sNPHAD3z6siBecp0rT0Js/sLJDVJ
	ebpO+g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c5868rwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:13:20 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-707641946ecso100146d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754493199; x=1755097999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoD5ue7FLv/tVVaOYwgBAkYsHyRWsTQqwoytYtbdy8s=;
        b=jNkIbLMe/SW59fIHf3/8ORyjT8T9Timz5K+P2wkFM1xMG4Bhx06f6Xjz+nagRNE71+
         VW806NRmvrbY+SOYv0iudDeQh+Vn04RHEzWHnlrvdpatwBA76dycVFNu1RP8AvHtx2i2
         xNA6AypDICI0jnG6duwLut3BG3KvJ43NPdWVIsZyeEDabUNaNp633wD8aCSOkgDkWM9K
         7CcqOS4pyCv9gBqUU11Jr5+DieHUvJUqj8mvYXFBdpKw65QndonfLA7qbimY4uGaA6ww
         Pvva0jgKDowFzzaWj72gdDJsQ8gI5FHCFK0XUYtUz7Os0fRPRW8nqgK0xa67kSOFqkCn
         PAUw==
X-Forwarded-Encrypted: i=1; AJvYcCULuGmjZ9oRws4k8r3fhLrjLjeJ8pDpAyxNZqIUivLmbOD+63l59pjZmkzcdr3pCb3MlU7/gaYukueCukU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdEGmsD+ApKBD4UnJRcHaiGVA26BNLy6iKFO3riohYczpO4zR
	jzD+7UeCy2tZcu2UHrZKub4luHfr2WVWodZLT7XZy073XZCIalghAmOYEALIAfE0k3eHfBqo9s8
	ar3kO85TkJ1FnVQm8n3BV+j9k20SLQlPzz8Hp+AD8XuOZSxCqexlfGQ7szNAI1gwCmAw=
X-Gm-Gg: ASbGnctgFNE2yd7IViFQtR0scFHD/JKNW5sOmgOQm9TCf0KGl1zyNj89fZUga5SyTXD
	2Ri7NB40tEdMrMAirdDxxUxNd7CbRopcnxtGe4IZA/pBY/LM2+4JyOwORC1JgDAXUA65Xu/h4ex
	i+x53PVfpc2XeDHpwtWK28SixMsn7Ga6dQi0C5Nu5/Lo7gZLWe9Yb/q2Pj5MDFuMJ59IregwRMT
	YwGfbTL+tzLUuOWJz1232F2mVvHbdmyno4UZbl3K6eagwdrk022c3QDwuXSzwj7KIKUotmPTurA
	97AxU99v4yxWt9dAT7MbHW99l4RQzOo5kbnJKD/H8BQBNwH259zm4snMIO9qUBaRPSfRd/RPLQ8
	L0BpSyS0Ca8cGShHp0A==
X-Received: by 2002:a05:622a:486:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b091575d69mr22519721cf.8.1754493198902;
        Wed, 06 Aug 2025 08:13:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVjPaBvVyXemUS3cDbhkwc4YdKlt9IkD9oqd8GDTb3Ol2Pm9hJNwgpylnDtIcL+fPMzpoJVQ==
X-Received: by 2002:a05:622a:486:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4b091575d69mr22519121cf.8.1754493198074;
        Wed, 06 Aug 2025 08:13:18 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a219ecfsm1118111766b.94.2025.08.06.08.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:13:17 -0700 (PDT)
Message-ID: <581aaa8f-9e08-475e-ad23-3369fa05e53e@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 17:13:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add vibrator
 support
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250806-aw86927-v1-0-23d8a6d0f2b2@fairphone.com>
 <20250806-aw86927-v1-3-23d8a6d0f2b2@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806-aw86927-v1-3-23d8a6d0f2b2@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7LtTiYKeSQ_wq3dhZXH4xGh-lZcfw3GN
X-Authority-Analysis: v=2.4 cv=MZpsu4/f c=1 sm=1 tr=0 ts=68937110 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=ZdkvxXOI2w3T0V8kwTkA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: 7LtTiYKeSQ_wq3dhZXH4xGh-lZcfw3GN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA2NCBTYWx0ZWRfX1yByxGzUVNxU
 LbSt/lrQtEVLrXxXNeX1RiIOS7kR81a9FbH3mhiyKf70VFye0jAkG2MGL5bTeEPSDcUpHM61XP6
 CGGLTgvVrTWm6q5UFAds8Nv1wYagBpqrqwxWKt2MlWeQUedGyI3H2is9X5ORWku9CoJA9lguQKC
 TpGgvLLY0flgkWLsiFyNznxPfHA3m9zXOh1JtLtp65uO49A3ZPDQq95Azor7ueqpcv2f/PIGxDH
 vcNiaN6nMpdbbhQytchuaFtMyxnuxmClaIlKL0Sk/TMTcgpOR3n3gbEHuJTWOhyPJDf2dz0Uo3R
 RZhLtA+EtZvNWNFv4jcsOmRfcfPPwvGVuckptyyb4HGZKmyr+CWxhVsvMeWjVwLLgikW7c8k9us
 npGNyak8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060064

On 8/6/25 5:10 PM, Griffin Kroah-Hartman wrote:
> Add the required node for haptic playback (Awinic AW86927).
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 4c6cb4a644e2..9576efdf1e8d 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -866,7 +866,16 @@ ocp96011_sbu_mux: endpoint {
>  		};
>  	};
>  
> -	/* AW86927FCR haptics @ 5a */
> +	vibrator@5a {
> +		compatible = "awinic,aw86927";

I noticed the suffix is absent in the compatible - does it matter
for discerning the particular chip and other variants?
Anyway, so long as you and the bindings folks agree on it:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

