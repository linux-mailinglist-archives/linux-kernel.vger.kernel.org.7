Return-Path: <linux-kernel+bounces-747797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D7FB1386A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F211882080
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BED246BB2;
	Mon, 28 Jul 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AB01ZgpX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4A21D3EF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753696564; cv=none; b=SVthoLcMXcP65x2LK7qJJVNGt1OscAwD5XxWjR3j1a5ZtWI1uEutCvbpTx5eCSPtO4AaJ/Iy9fSol2x/fA2u27YGa/2mTKkghpBZlqFjz5pkWwnu5YqzegHGw/E59cOuLqN4OkRVSx7R2Jbmo9MEeS2Ly+rWJX7r3UJie+uc8E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753696564; c=relaxed/simple;
	bh=v101+JVVdRGnyO1F+hI3mGw6HG5ajOkVZ4PmcXP/YGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai4oyN88bYhX2C2ZQS0D2zSkv4QxGDx7wx1YEoPcy3icSjBACQPWucWwBo7Jvn/gF0fmVQQd2x/JO4IpO26msBO+GF84mxAbDxPIxR8ik/dhJzl3D1WzqtEceEdhs6mkxWDwWWUVZKuF9vMFSvc1A/BASECFg3kO4SHb5JoUc8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AB01ZgpX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rSd1014425
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	97qWNmr/hvr298Xbx3iKU+H/sSf9Iuo2XWsMv/z0KYA=; b=AB01ZgpXwV9CE58v
	oMRLvClbMm583FF/GHa1lJCL0VkbsWZ0CcsxGZt4WScLucw6To6cTNnifEGQ4H7+
	YB8zm5KkXQEZ3GNLML8X/4a2SAdzz0nK+9pTxKW6DuOdAu6Q/6i+omNfQ01T2Qqp
	FwYLMATgpwyNYmxBaAotT4cNcaokx8RAat6HjuAaT7WtFEhSZvuWccqwkYWIiVEw
	/gag44mFDREH4/vYAS39IvpaL7CHTy9uQlC3lfOkLGVgJFnU/ykM2kbMuuxVglOq
	lw9Cdk3F25Sdrkxnb82uH/Ci8QjbykzP5RM0D4N8EOpM7yJk3+dKzPTpCWU+/qwg
	xS1l6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1ac4mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:56:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab61b91608so16731921cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753696560; x=1754301360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97qWNmr/hvr298Xbx3iKU+H/sSf9Iuo2XWsMv/z0KYA=;
        b=LSq36X/6c2wF1MDf7vY5ELZ/3d3hW8DlJxiNYVaioN8cgbdznEOy3LM4bzl9vYf2ff
         H0g/9IHlGbGCzRNAbkbYLiqjvPwkJlGn+xR6ZkAl8A0dEAEqyK/CS5mc+AEqlngIGrLV
         pUwNVM/PJsPEP23MXm0dbJTlKSWw/KD+69H/w9A3isrXAK3N870qhgxp+nJ1OI4ixqY6
         YFL8P8EggaTdvFpyUwjTPHrWR5hs293aomY8u1lrGzZtjhKk1yAgiXKtUtgJIte9XRdn
         pqU+P39BQbqJ9o9+OxCVm7Y/uukAmnd7uzVYuDdgU7qHdA0BTFqMsABr8Rb185oqVgAn
         Ue7A==
X-Forwarded-Encrypted: i=1; AJvYcCUh0vNDGcsbf1ZzA4ekFkx/K39xeX7psOy3XqRp5vZJ2BwkSyqYbzu7yu16abLXyfXfNauI0/sdqFRpZzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kUtbyxEwGwWIS5gjfKXIXoPJKWUJeD05DTB83342adzFswwI
	8YbgHH0IIosNJzRFYJwA/RvKn/+EMwrPonleYuRHnoS9n5vkHLqTBOMwCi6aAHNhhGcdrvjmBgP
	390DNv53ehhNmh6bfaJxklf7xjWPvMIWMAPzNx26Yclb1WgPXYtypOFeLTpfSyFFAUKc=
X-Gm-Gg: ASbGncuqejil5WVPvFSAOIknLOkGHwTJMdtkKMTOocIVSD6xm0VQ0QY6XXN18BvGmEE
	CRzGouY/VXQJBZIgoCHEOCpb3HqtJLA4BkH/7dQ7pe661K+otOZZUz7SpwXfDvUsYSOyzy+MQkx
	FXPEulHjPhP9NUZfo/QI7nrP6NBGuqcpvf/AjvKZjmKugIOHTuwUsF3sbfnbHuS5wsa6yAU69Gi
	qQS9LMk1eYzBdEoVWuzTXh9sJZ3ykC7obcqG4sefNLvhsUAylx2efpLYCjsjCU7odtvDBcaCBPL
	WxeOqDD5UmuwvR0AW9MkLUv5bOELTAtZtGwHKkxwIalxyjL8ONDi80SvFzZ2yZ2eYryRaYbwLE9
	ZgXrkTfJJPJPAY0RKtw==
X-Received: by 2002:ac8:7f16:0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ae8ef5920cmr68336281cf.7.1753696559925;
        Mon, 28 Jul 2025 02:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0HAJx5dftHoSRKBGKbv7hde358hLOMoAdMt9sqZhRSin7VI9+c5bS2wf7Z0CKCrsCj+V1+w==
X-Received: by 2002:ac8:7f16:0:b0:47a:e6e1:c071 with SMTP id d75a77b69052e-4ae8ef5920cmr68336141cf.7.1753696559325;
        Mon, 28 Jul 2025 02:55:59 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635acc99esm390087966b.115.2025.07.28.02.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:55:58 -0700 (PDT)
Message-ID: <8c59ab39-8cc3-4b00-a694-3ed970b9f7dd@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 11:55:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Flatten usb controller nodes
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250728035812.2762957-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250728035812.2762957-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FHTSdeXgVIByILysC-Pd_FSV5q_Kooq4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3MiBTYWx0ZWRfX0gGafQXvmOdO
 lXcczMocbxHRnXjVcPaBK06TaS9Gof2DF0actoyHERxBOz4ErKH8N4MuSx/NrOPsTUeYG+aKmfe
 4haq36itUFES2/ny2nBeWbbZGRdYKippFrlC4SYy3dek0YcPwWbPZ5M5g0I13Q7OKPtuPi755lt
 8ZmMjCE5llx92QW5FvoJ4HGCzfFmYuWUaY1bkZfrZ2EQvgFmCJN+78OPu96yNMsT5vLwbVqmaKm
 ldenWkW8D4suBY3aBB43hdVg8FdpYxEzQ9AfAFOXkKQBglDsMl+UYQ/ocNpwPdzC1otqa+BE6to
 JWxXLkrVBU1eHVSDdYdIgqXwfBj03y1Lbc76q65CftEaQ96dSthDz1Sjdb6jvzssEYMIgqJASBF
 emKSyDjTa9xJo9KfzQ4KpPgbDJ8ozKwQOq/kdFDUs6ZK2IuAjaQHh1nYrTCwQiGJCk3awYjA
X-Proofpoint-GUID: FHTSdeXgVIByILysC-Pd_FSV5q_Kooq4
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=68874930 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GZkaEewYkbA08GeAVZkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=599 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280072

On 7/28/25 5:58 AM, Krishna Kurapati wrote:
> Flatten usb controller nodes and update to using latest bindings
> and flattened driver approach.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # FP5

Konrad

