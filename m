Return-Path: <linux-kernel+bounces-764481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BD7B2239B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B65008A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E282E9752;
	Tue, 12 Aug 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLhZToN+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F802E9742
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991868; cv=none; b=TG5dZ+DQRK9MviOT5SRma0QuMuFlmaj+hz65bRjAuuPQ7xfvv4LDC4gObyOTp8gtbt4a64mFecJ+etC3N6EVMeaM6GQd0LoAh2ik48KuVYPSvUjGNeYivAE24g7APd1BHF/80xQ+5WESw1rrUXzugi4LhMdbsUFquJeFZPvCWBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991868; c=relaxed/simple;
	bh=NsDGUZqdxL4NnUZEx9v/dqkyeE0qj80lpP6HtlabIcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppJ664P7tKgLaqJ3SME/Cm3w7VGDhz/65liNHGSBi1fhllC4zuwoqU/HrlSHuc2UvQiiAdFSFol32uDIWJrlHDPf5FZb47dCw37tPKjtdYUpiZfR9EntNhyzJsVVzhk9G6AFGYfFEvrke1tukptn9H8YmagI4wbJ371cg7VfhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLhZToN+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XLud018323
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uVjk2bmpZceirDyJ5lxPbhkNfa1iK7XMzWGsFKMIYyI=; b=dLhZToN+ZMidVA/h
	gBMZDgcc2b7zbnX0BAbXgnMiQupk9yUh/7UiN422qSlI50qcnhhcVdU2TT7xFp1S
	2hgi4RJJHnBkhukUQDCdOcBnkuWXhdY+ikpsd79SeyzG11rY6O+N4un+HCvLtZBD
	Tr2nd7uvjoQdfm9NHdVqVu+PgpPpx1taRB/fkmwevmkDmBbs0XEy82lIlJTYwZA+
	jFEZBM6L+vvSPesOayKFU5ilMusBe6vIAsizZxbLvPNAEnBJI469vURZUCMR3xl1
	wL2ivSfukJ1ve6c0jrzusBxhe9l0aLDLBs82vBgZGaTjypC2jSvP9DslkazCrru6
	Gq+i1Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g7k9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:44:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70730da0f40so5168266d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754991865; x=1755596665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVjk2bmpZceirDyJ5lxPbhkNfa1iK7XMzWGsFKMIYyI=;
        b=FhGNxEPT7SGHMjiw2LdbbCHpE0yZcoosvFRSYcEmXfQLM/ZV9oghGCX/dklXzppmE2
         /P72fiAhcTVePhHLMCvE24n5f8QTW+RK6g5tKtXp70hnKKpqa7JL/YL+NEfg7CzqUHV1
         6RKwGmRPs8osGBeGcrm4nGq/102+7dCzQEOpf2GG9zdkuTXZn4IB6q1cND73VlZbf71d
         aY7L3jM+4/9Hfky2qqsEOAtTyP5gi1j1E9PUb854I5RyNiCojwSz8NVco6xfnKHzvR8h
         +nZUMNUQqDJs4r6dvKDxVRd/9n3Xk5a2IEhOmOv8ht/4BBWZu68TVOpv3QNSYvwDQ2ab
         yAbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQrDFCs41zL9VOmGKoWH2OHaMPYyi7GY5g2s7MmkVbdF6EkmWmOU+QKu7/DEbBoZZT/cK4vcHd7qt1qYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUxLikHDPIo84rhpGk87F/LxyNgH5Q6z4zmVdNcO7g2FuZlb+
	PxMgTC6aIvhUZV+VI5BFn0K85C7DYTptP0DCh9c160JyFXOwqrQ0jNxv6eseRm586x3ZtJOMsXS
	XcM0/9PJ0Y67MCOqTd7XO5eUY+o4yEopKBkXDE/Iq3WI49fTYkBJ4WHMrtYs+zx3O9jE=
X-Gm-Gg: ASbGncsdDOnE5VwuAdZ29suVfvZVEFtz8YmYd3b4Gqt7wzpy2uF+6q2diVaGTYqqxZQ
	L7WGYZnTULwzbXwKsgnHrTS/sxdHWJgO1/FLiCH04XOzWwpSUfh3/53qTYNVccKUGw4/6gmtpCH
	9KiXrGcGUgRBcqfpa2RlafLP3G9qXW+8fg3Whm10EPEM6zQQcSs6V+RQizl1f1Mp7XcyK4MEnqk
	AkVGuq9XopQr1c8Z9MJDTZZn+H0tJ81KBvdQB5q+3Oq1xnIK8O662YciqF0mvT+YQZwX9+gYXsW
	abs2FRk1YYF1G+iBswSRR4txLMu3Weo80vqP2Bofm5RFcu/rmFSDXipipzh4fv80pTVFucqaJx6
	wJ2qNFA7Pq5HDmURe3A==
X-Received: by 2002:a05:6214:dc6:b0:707:48a3:f833 with SMTP id 6a1803df08f44-709e223c2b7mr2670146d6.1.1754991864651;
        Tue, 12 Aug 2025 02:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqy9dVMC9gipxsspsY3jwJKyi3zLMV0FmTDf11Oprz2Uiwnp4y7BuUhf8pqW1skK9briuFUg==
X-Received: by 2002:a05:6214:dc6:b0:707:48a3:f833 with SMTP id 6a1803df08f44-709e223c2b7mr2669976d6.1.1754991864055;
        Tue, 12 Aug 2025 02:44:24 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm19914549a12.57.2025.08.12.02.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:44:23 -0700 (PDT)
Message-ID: <c3d192d4-934b-4fe3-9b1a-8405cddbc668@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:44:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qualcomm: phy-qcom-eusb2-repeater: fix override
 properties
To: Pengyu Luo <mitltlatltl@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250812093957.32235-1-mitltlatltl@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250812093957.32235-1-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689b0cfa cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=v5-_rWYg7EQBkViMn-cA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX6sUk5XpDZvHC
 IfbJH51Bu1ZhOf27xThun1ecPR2eCPd5k7H07mXr6pqIix970IQzWRCn+rLH2l4tJtJc+imKeVN
 Jinb6izWiYhpNc/MyjI5S+T1Gm5ySDzLqwCGrAYA0nGo6cZaRRDAjFnAFySaRg2FAU9OVsVZMKf
 AO46HaCyj50zPSIIE8Hl0wyOE6CPATM3c0f0Yi4h053qKk4DrqdZMPhhuwPZ18R8M6bMOx6Gc4d
 Qkc/W8i8Txw1e/bodSyO5vZ5Y6rTa+FHHUQySSuqjcUt8u+CNlCrFeOxyUoC82eGvpPHQkPmqVL
 UquXTswStrRqvoYAv7Db+b8dV2u7yu4rRveP1UKC1RylmRAbqqnG2yufAnEaYH6X9rtiS9UsrUy
 jdO+Ybl+
X-Proofpoint-GUID: OrBUWp8s5SZZ9ySI8aUlNRtdifLUI4K5
X-Proofpoint-ORIG-GUID: OrBUWp8s5SZZ9ySI8aUlNRtdifLUI4K5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 8/12/25 11:39 AM, Pengyu Luo wrote:
> property "qcom,tune-usb2-preem" is for EUSB2_TUNE_USB2_PREEM
> property "qcom,tune-usb2-amplitude" is for EUSB2_TUNE_IUSB2
> 
> The downstream correspondence is as follows:
> EUSB2_TUNE_USB2_PREEM: Tx pre-emphasis tuning
> EUSB2_TUNE_IUSB2: HS trasmit amplitude
> EUSB2_TUNE_SQUELCH_U: Squelch detection threshold
> EUSB2_TUNE_HSDISC: HS disconnect threshold
> EUSB2_TUNE_EUSB_SLEW: slew rate

The commit message is a bit.. dry.. but I suppose it conveys what
the problem is
> 
> Fixes: 31bc94de7602 ("phy: qualcomm: phy-qcom-eusb2-repeater: Don't zero-out registers")
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


