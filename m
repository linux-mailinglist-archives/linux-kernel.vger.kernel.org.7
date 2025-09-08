Return-Path: <linux-kernel+bounces-805287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7DB48674
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A80189A84B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B3672602;
	Mon,  8 Sep 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N65Pseld"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF21419644B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319473; cv=none; b=BiW+246T1nXe8EEzNRWQyj/G21x+u8QWC6m1Ukz9hutTWK3qAkHpZ2seQJ1May1Yj1zokbgN8+ih0uv6PS/fn42808z0e3SJUzosA+H3YatGPWOyRWznzFLToOaI83UVME0mhRMfoSDdfn2kSRyhBkMrNJMNmT542Z0d0IsYybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319473; c=relaxed/simple;
	bh=GG1pGjSVrpeLM9P3VVwtZPEsZ4X5zLkYIjoPR1vfRRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsRUy+jMoDIoMyY27rc3r58CfxNMR66MUsFBdvHIUALJo7hwKGAVduoDtOKjVf47rxqItvcymvJV3eLlvbdZsCCqWY8XAgFG/dGU3VOEVc8LDcH7JgS1AnEFEP4FPnM+bKw1Ive9/1ZHw5RdBPrkOlksRirpKdnKLOEoof0NL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N65Pseld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NVrKL030699
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vbaA8xj0zL+BI+9codvpqTtyP5KRkSsVEUoJD+vfW2k=; b=N65PseldRNfr3n7u
	m8uOcnVjh+hrbSp3KhPf9tsW9dd2YoBJHU7M0SxlDA9MXMiqTBVjKH7zneaGzllY
	2VpHgbf3XjmwLopSCzyofmzC546DVFFCA1ngYg6GbC47AfQIx6HYc2XM1w/mjKd3
	6ZbyfJs6x2tyzMgWXIoCZI6O87/Rxzas4dE2bbJIf8CMhdAPtvf7omVKR70A2W6P
	Pl+CndvPmXrJbpDdygcdSxm2++jjpQZBKcNOvuGu7FEQRJjUUmloUKdqAGSPhRHc
	roxEkJyEVfkPMH2CxhIXFYtN/Tbtk60iGASLt4GWZ3vevvH4KaQhaU3X3n+ko+gp
	u2NZUQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kuph7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:17:50 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b612061144so1960721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319469; x=1757924269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbaA8xj0zL+BI+9codvpqTtyP5KRkSsVEUoJD+vfW2k=;
        b=GleCBgyJXqCDUHxi/L2qW/21muO2IGp3WJUACygwg5GmLu/AHtEbDbg928xIqa82xN
         QD7esMjzvfvKu2p9htiJ/ewtQhgSqC8KP9wuhZfQFA3z2M/I7kP1EGkF+ERYqonD5Qu0
         NSrErTweyLcGyfWGVJf/lH86tETjcnW1ozv36RNHA/FEj8QlkOVCJ4R9b39C0lMMPMHX
         DpxWtJXWZ1lIK1m3ELJo4g7CESTV6QJAuHmOIT9pHczgqjr4vlACbLyLYtZFjvbTUUqb
         yzLFrRgQ4sIYgpK/h3lbFMQuOI0SyR9YV9C2zM9QoAmLzhwqmReG/SbEQTahYOpvN0cX
         b7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXdD0RxH/Alvo/NaBC5JPT09zuKXYxDv2RuC/1ib2VvlhGNRdPsMNJtSJU7dF+RAnqvbuvp3b1xmpCM3Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2mNq+uBTEEooQ+VFscWr+8ohhnynPsKhES3a9whV/xpmvxPp
	e0ms92iG4AmDYiDWeSRK7ssXynhNL9k/6OvCzcYs2R7BMtqkMXtWLgvjTHOheLS8LJbQVMYKWQQ
	iMTfSoh1rcdkP/tysUoC1ymkp4yihsuAVFTxXXRRDKYtihmIxBEy87fzpENT3lF/4Fc8=
X-Gm-Gg: ASbGncsCr8lT8zLPWu6hxG1bwlv1RvinaTLiXK4iJCpNP0eBkKJICo+cPOwdh0Q2chL
	T+M1jm7Ifje1cKbevSBpRdsUAZwD2E3O8Bsmm+U/6Q4K/EJkVV73/vwXROLXvJr7D0roCLPP4iF
	0SR41e+JxyIyN0jPHfN2OUkdE7MelmOhEFE4a9+I8BXYqNcMmmUM8MCoGPuIf8TiSyWvj6l1xCw
	UBeZK5On8cK1RgTxrM5pSCeCBetERlL5sPhb3v5yhGJ+oXZ2rcMTnl1AUj1qgPqHEZjTRJn+Stg
	rCSWSlwuDSpwF/rbmsaEczPMlUlyqxE9MKI3McqW4p+8190BAQAyI2ic+qM+RWeZj8ziXH65VLg
	rFSXUXlTVsVHxikC13XtQDQ==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr52561481cf.9.1757319469259;
        Mon, 08 Sep 2025 01:17:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBEfgpDrRtNN4TDghi2eIkkpFAnt1x/Ei5zwPYuhmrTl8KM/5H3CwRozot+PjpnqGD4xAMjg==
X-Received: by 2002:a05:622a:1355:b0:4b2:b591:4602 with SMTP id d75a77b69052e-4b5f85310efmr52561331cf.9.1757319468646;
        Mon, 08 Sep 2025 01:17:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04709b3effsm1224560466b.5.2025.09.08.01.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:17:48 -0700 (PDT)
Message-ID: <7aeebe52-6408-4247-9ec8-9822c8a96ee2@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 10:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] phy: qcom: qmp-usb-legacy: switch to common helpers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250907-qcom-dp-phy-v1-0-46634a6a980b@oss.qualcomm.com>
 <20250907-qcom-dp-phy-v1-1-46634a6a980b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250907-qcom-dp-phy-v1-1-46634a6a980b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX7Ik27PVRkCto
 MKziQHHYJES+QfTzBEsvhdTyhEMDNWJiLrtVOCdmdE8JKX1T0BRuiCgVV4bI49kIgYc/T1R0qmF
 XyISDzwmUIUAP5XEIkOOuQ54JbJE0q8Q3PtzFijQgdk6fjMidCI6XLv6UATcMC6EMWH8RMKzMrG
 bobSsaWhlKPNLIDVUA/9Scpc2bf45CIVH8s90OLEEieNkZoBxcIzzWM5Uapk2IR5M3aMTJ9NVyj
 hL4hMQMuiZbRI6wlzzZ6R+Pr+OT5hPvjCh8Pum85oEm5AfbykNEAGfa894pvu4QD069Sk8xyu7e
 buLkrqGhsmx13NuCz+Bso5MGtYOFLS2sUuzucD+nK9XXKVRIUQMdMScQbPyY7dN62WSJcl79Ij8
 cuzAHGXS
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68be912e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=gE7I6xvdJJFTcp_SK6EA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7mbigzuuT_54NHS2MH6Xn4anwAfyhPAq
X-Proofpoint-ORIG-GUID: 7mbigzuuT_54NHS2MH6Xn4anwAfyhPAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On 9/7/25 4:52 PM, Dmitry Baryshkov wrote:
> Instead of having a copy of the common definitions and functions inside
> the usb-legacy PHY driver, use the phy-qcom-qmp-common.h header.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

