Return-Path: <linux-kernel+bounces-775575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA0B2C0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1374417915D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822551DC075;
	Tue, 19 Aug 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="po0PNZHK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94D32BF3B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603622; cv=none; b=jp8Lhw0o/mympzgLkESuVt/UE3u8KP90Z0PfPG5nRM4yx9Y1mjbDJnlpwX2gqah0BMJuHHcAjh9PxGrBB6bbnlvs+9DyKLVkI+VQBzLK3KVrSftLjmd6o/7cC7AuvqkxdRErQOgfKaT67FWA/t+bGJzXLGmnDVs7tz+o3Mss4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603622; c=relaxed/simple;
	bh=zlUEJfpYmR4tX91EugAHvCUNzFBmNgD4zi112bP6hAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV/MY8RMUkl9zfKf/Ascldb/P3gzjrqwh4+TK01z6dAPN1j85ok+8Z8Ho6R+0pl/a56aNfXRXd7ictTtou8onhr7y+gIP34KKUunHQnvysqOTk8Qmyvvp9IV/imi0IAOCrrUw/DaDPOtDaXvln0VLR5WR+xzFIkpowrYm1CSC+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=po0PNZHK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90cqV018090
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=WUZCKijWjTUZrQrretf3iRXu
	z+Doo912w7iRSB+J4eI=; b=po0PNZHKBpmN24jA2AxvSrxpb1J7ZjMYLOJM87yR
	BryFWpsT0iAM3Vx8sOC2ZPGRRZ31x7ZNgroMgUzc7IgWCq1MBW0ZwxvAVBTjQ03d
	JOMHYwk/DhZBLs6v5huI267841cKfLejxg1l1sS4yWJAyKV58VVyffFpy2YGpduY
	7PAoLjWWpfTpyRMmuJXmyCWHGBktS052IvgGKyZDdqWnqAZSN6pZqiypK7XFdVZ+
	ow7hWTgtpQY3TfQjjdX6ECS5pPSWWiRl+PVCqUAmykzp9QNpvMCtbqU9wTai4fPe
	Yrm7xk/RBTKrVClh4TsG0wG4BlXgOVYYp365dBUsQzV1DQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhah09mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:40:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8706c668cso1552595885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755603620; x=1756208420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUZCKijWjTUZrQrretf3iRXuz+Doo912w7iRSB+J4eI=;
        b=mNMi+WfsbggVBA4dMC4420LUEyEpwbacAMMin8mrLLlSnjfCtIvZpptO7ePdkoinOI
         0XKCrrpIV7uxjcxGFjHDoEn32yRMkCEJ3i3LNaeU7nknH+Wrnxmu7mFDEMS4zaQovzhO
         CxM3HS4kprZILm/miLIozS0g5/8aOhull4RrUkye7qMYTHAW5RJtREDAtcKEqBXKTrn/
         fTWgpgoUjAKI8JCJ+9kuPZod2ZQJQrkPbRHzlwClRIBygJWPFy9hpTEcCs994F3K4qEP
         zQxy1aq6kPEJDbopXyepcfOSn/7e+Lw7TxX+CzC6lEkwmrYLv8KF7QSSEXCQJwqZo6Bs
         tTWw==
X-Forwarded-Encrypted: i=1; AJvYcCUpYtsYkJpLgK2VFHd7UxVbqZdwIDz6AWVzjM3wWbr99aWAcrH7z0Mcbhsi4jajagvEYBKQP/DCCOnLoh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1QQ9pAmkCWBt2XUtpscEbe/Br/ystnjrQTc6O7Ulvms5XDGg
	kPNF2LAvcX6gMTUsT/jUpUzt1lx9zBLwnRqB4fQUAz9Nyswpsk6aK5OkFhnFeuTYtAEfkHE1aFR
	fYWwXAv0rJmwEHNVoju0y3xogDbO5YTn3zhP7xBVCyT/4LA/pbV0/JJRPJtyzKCkcAD0=
X-Gm-Gg: ASbGncuvgz61DYaqDV5L5hm0GZjb5pH6OTUY3Y/MCj5ryHrzhf1T902Q8wh9SUxsOOQ
	YihLVifO7HpJd5WmOtp2gSaxV48/bMEhKO0BRp+R1Zgp9p5VFfCXe9MGRPwBeot4PRFulL4iz+1
	yL0RI+B7lXah5qXwzkyugp09Ga9Vf11pOgTcGBVqF/+q4Vx+nYKtP9KW2NPLafv3UftbVAzTVzB
	0/MWSHN5M54WXEFGqSyMgQN1iqlWmOUkLVKE8L9z1oT6j9xL9o7iiZI58KaKzVycTBoSGhuPol7
	2Jg90iwTRY+Z/qeT3XS65/Z8pWTNXZXh1Q/iUDDfM8JGec2hgRrMvmHJl/dsSwOHJER3WyYHATs
	fHU4b/fSdk5xFmBwIVTo34FobWdbm2AkjDv3vbOLUi4fc4M86s44Q
X-Received: by 2002:ad4:5f0b:0:b0:709:650b:914c with SMTP id 6a1803df08f44-70c35d30e23mr22234336d6.40.1755603619317;
        Tue, 19 Aug 2025 04:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoFttiRUeNCxJ8KFAt4cgTqEKpI9DjnbmEteHB0Sc6Ed6p67fuNf3H2ooC03R+rgzCqqtrhQ==
X-Received: by 2002:ad4:5f0b:0:b0:709:650b:914c with SMTP id 6a1803df08f44-70c35d30e23mr22233866d6.40.1755603618669;
        Tue, 19 Aug 2025 04:40:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3cca16sm2088342e87.92.2025.08.19.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:40:17 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:40:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <le3xcbnebjgkhzmy2xhicnn33prstewg2wymwc2nfjombxgg3z@ucsmlowzzd3n>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
 <20250819-talos-l3-icc-v3-2-04529e85dac7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-talos-l3-icc-v3-2-04529e85dac7@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a462a4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=cd8PGyEpGUmkB33UepYA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 6phUx6T2j78IzJKIHmGQWFmnxCiZBZd9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX9cE8I94pPZFO
 A3to93EGvMsh7upFgybka3pHDQXVUyjbAFCOGn+lGtMiY8HYZAazWLCfWmGpgRjTSwSbAdOOdr4
 otl2t/oM2I5WJ2wNs/J1KDiQqihgY2hgm1P4zgc7HUPFWbAMg7H3e6mGDfN4J5ahRJlxOhWFju/
 4PxEhhjLdHqLiAEwcNQYN3OtIlbIgBFwFBHA+8dWMMy7TTATAfdssQ/RbFH12HmVsSf67zu3ZAH
 V0BZyzA2hrs+ddtVqUeyWF8dddbexJb8TNOgmNAIEQEKjoxU1G+7/aHIFtIptLOK86xJMHHaUti
 6K2atDag9NjhXpHsIH2d1YjxgAPYwfcSBl0aKZuv7iyvYJ4kQLcyPoWRbB8ebVCMbg+uwv8FQae
 sQzKEola
X-Proofpoint-GUID: 6phUx6T2j78IzJKIHmGQWFmnxCiZBZd9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

On Tue, Aug 19, 2025 at 11:24:47AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

