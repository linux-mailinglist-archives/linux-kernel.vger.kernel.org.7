Return-Path: <linux-kernel+bounces-736549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3BCB09E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04A73BF69A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6E2951A0;
	Fri, 18 Jul 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/7lG6cE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91106214A9E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828749; cv=none; b=IN2JlkO4RrUGR4IKeDguEORtQmYR+wv9U1sq2ZfGZMZs3rsWv4uyVxVLmQJQREhFbKZNfaO2sa3OJbiVMuptqkYHISI5vcnLvY7ElEtLI5iliApu/b1N7vb+h5bWf+7ge2bT+OWAjrzNvGFvlME2Qw7lmTBBXmJNfxsWgU+HY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828749; c=relaxed/simple;
	bh=7tLUqMMeWyUSVgHeIio6NZAqwLFuscFzmDiihAOR+Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrR4RZVqusfkPkbRYSHJfYs2s2zw64JXnojsHcBQs7TrKagwW4VFRODPwYoCpYk362FirvFVg1XoOMnywqQJMuNbW/qS1AEP21QoGn3SV72Aqvj9D7TZwa0IGd4mVW2MPDt34uMymra5UJ7/x7LIJAk16gXc2VLApmOgE/T4WXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/7lG6cE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I0J103015968
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	12aFvAN8Kp4LU2nkNq4n4C57+tw4URn/SblrQcy62ao=; b=N/7lG6cEKR743O4P
	kOsmvxoV3V4Be35YVkAqtZpS0+HKcp8YV/eaXPs/YXhxy6wfLtR3WHnALX6XeRei
	41fvMOKM6ovFK7Ocf832YBKclvhSDaFbYZxwSeuFZpXXugZ6hQNfHmMMuDxMJASB
	pH81Ss7iFSgFiDPW00qDhXrPftd5ugAqTRziaPUGO4uuxkLW8NPab6YtGg1BNzoK
	bYfhrD2WJWqpNpqqHN3+kE9ydX9MZORdrkpTqs2dDu+AG3ia59x6XvZrZcRyntqR
	0Yhui/aFyfmft2JabWB3QzFG7T//9g0c+ChWtvIZtaM79M+aK66+xTjOVfcDkXBF
	oIRTFA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47y3tc2p4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:52:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab7a01c38cso3928481cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828745; x=1753433545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12aFvAN8Kp4LU2nkNq4n4C57+tw4URn/SblrQcy62ao=;
        b=SyqUa73isMUdAAXi6+Qd7lfbjl9phvPsrD82j20OeoBbzqZFyQnD2z+NzmK4LyF2Pm
         4/pKJoplGCIVwfIjVvJywEKFehUrmniLW8j7XCEWCvwHfuMjnpOKwXxI9vhDD6zNwPFp
         mfNKNnV9Yw2SFqncOmKO/Xqwovwii2ARsmjLlSNtS4WaFnadMDXXxoVl+THXXaVAenS9
         dw4YlX+W9tSXJ+SlUy7fokvDyAXJ6S64z48DB3MMzOVsTFE7HUs/5eJenb4v2pvb1AKQ
         ZvPw7gcMd6gxLB699tZDbbaoKS7M0pA0BW3EuRaEG4zz/yTnznGsiTvKSK0YQu6UyMNw
         tzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0gGXq1ZNgHxX94NUKnuEYncHlQK8Otcyq1KJgkzs/VHENDNJVQ2ZerSctkRaM/zuFPe4ErcoO3JmR08M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjROjBLtCDsu1nW6aOmR9bMdDVePpPS+Be2UTYJT9lLTA04uBj
	aW8TUKj978Zd8l9uS0oPLnKfFCIF2TIgeATK9XNn4rfHAM2SKX7Mw8EfCdR2OSncwGZBzTqKTds
	TPalNXe/b/nFOSiii3YCELjTsRs47SbXTvrssBxl3bmTgY5hBScF9hkqe8t+NHzdHunaShGyAqy
	0=
X-Gm-Gg: ASbGncvQWvH2dCUCk9DU9s7KK44J4Av0qaMV7jcvoSJScYMQg1Bd0BUTahHZiXR/jKz
	Y/Ok/2vTOY2GHnzPYoyRxIllYheTlA+NMEFl5A6cFc7n44O117DKkQfA+4peNAwGXRD9CPd6ZsM
	3V23r0Ds9Ea9qBsZoSqZfoOeUjT5t5apwosGo0GOuByN9WcnigLc4VIvME/fW9PGcss96dOpS4s
	u7Zg6XcThK1KLDwZeMyDNVRrQYTizEIg0rukfFHLXpqoc1a2f58d9aifW9wuvrfomKduiyUPgbO
	OfoQcYXL+i8+8WCbZTu71Cq0wdv/RxApV1XQ2ccZU0j+BrZjRLBnOrWnObTmhlzVznRlfjHqz3q
	P5INoAHdaFqgiKrkCgJuM
X-Received: by 2002:a05:620a:2227:b0:7e3:2e02:4849 with SMTP id af79cd13be357-7e342b41754mr492338485a.9.1752828745230;
        Fri, 18 Jul 2025 01:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyYtt2uQEVydMUj+p7jbJI8Tuc+iSxESKJDUyd5T+9D6g2gDd4+/Gf5X597HAoWT/iga1mSw==
X-Received: by 2002:a05:620a:2227:b0:7e3:2e02:4849 with SMTP id af79cd13be357-7e342b41754mr492336885a.9.1752828744783;
        Fri, 18 Jul 2025 01:52:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79b8bcsm82882366b.13.2025.07.18.01.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:52:24 -0700 (PDT)
Message-ID: <1e08ae62-9898-4a70-9122-5fe6a8d14f4b@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:52:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: dwc3: qcom: Remove extcon functionality from glue
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250718053856.2859946-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250718053856.2859946-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Z5PsHGRA c=1 sm=1 tr=0 ts=687a0b4a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=gYDs5GclryXmtiFo2a0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: SJDtW8jIKtZUWlJxUGWHEKRVgMXTMEPH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2OSBTYWx0ZWRfX2dDvu33CyYzL
 ElvrN7jgyOeyEh/EQigurLXjEEC6qb3Fp+YTMr+JyVfzWCqSW+6kyBuf4GyFGLAI5jzM2ZkstJF
 bzDoxntJyLaAnbeZYoZMEXNVShjeTKyqGoxaKAtoPcLpbUeqjNCt9kNCZe6p2HBkyLath1Z3Eqm
 QuLAIfSB5WidQ9rXjBUw1RkCPVUoAljp68gjTNumrrGf69riM2BsIi4CVJydwZEesnGaxBbeTl3
 DMUHXjNLGLILLGHbFUnpu+HwqA84bW2PJ5v/MUAtutgJ58zTYdEfzK0WJokUfv6QdC0qSL8WKcM
 gO1CtW9FFGAxPPdU+599OGdqi5Y9pR0642LBnIgJy2zOGyMTFp5eIQX/grktH35M7DtOgaFlWnN
 Mqy+KohxIEZCtKnBRqP4IRxxATCKwHqUPaJ7T9w4M3GKFjJEuMpZlBNKtis1JctQd5I3a/oW
X-Proofpoint-GUID: SJDtW8jIKtZUWlJxUGWHEKRVgMXTMEPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180069

On 7/18/25 7:38 AM, Krishna Kurapati wrote:
> Deprecate usage of extcon functionality from the glue driver. Now
> that the glue driver is a flattened implementation, all existing
> DTs would eventually move to new bindings. While doing so let them
> make use of role-switch/ typec frameworks to provide role data
> rather than using extcon. None of the existing in-kernel extcon users
> have moved to using new bindings yet, so this change doesn't affect
> any existing users.
> 
> On upstream, summary of targets/platforms using extcon is as follows:
> 
> 1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
> effect on them.
> 
> 2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
> driver which relies on id/vbus gpios to inform role changes. This can be
> transitioned to role switch based driver (usb-conn-gpio) while flattening
> those platforms to move away from extcon and rely on role switching.
> 
> 3. The one target that uses dwc3 controller and extcon and is not based
> on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
> This platform uses TI's Type-C Port controller chip to provide extcon. If
> usb on this platform is being flattened, then effort should be put in to
> define a usb-c-connector device in DT and make use of role switch in
> TUSB320L driver.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

To an external reviewer who doesn't have the context, 'flattening' doesn't
really mean much. You should instead specifically mention the existence
and purpose of dwc3-qcom-legacy.c

Konrad

