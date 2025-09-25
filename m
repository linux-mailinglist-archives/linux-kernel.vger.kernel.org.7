Return-Path: <linux-kernel+bounces-832303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2320B9EDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579D67A7B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5DB2F6175;
	Thu, 25 Sep 2025 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dxh6OJCj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254892E9EC4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798406; cv=none; b=ZX75iJjyMPSvoMpFjZGyI4hz3AnP0OQjebiK1epdJqZ1Kqzd39HxqBRIoMF7xWKZVTh0KGQpbCRBGVENYwfCmHi80WTJ6nhWPMHP5kXb458moD9ILkvn2MYMKDkfnDK4y9UWmN6WLaDQ/eZwEQtEmEyeK+kZH1Wjxw5BrzYGRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798406; c=relaxed/simple;
	bh=iTkf6MbCZfjRYj6doNponSJfEdSohtdYGWNCRkJceag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFFQ5OqVhbPdHl/KixoZAwT31HboOWbIzr3TfSM5ZZdb+Uy8yn5MMSrFcFbT8XCN4XkgCIzsUCL1VemMc/5HKPPEvUW30+BGFj4/FwNiVigmVhc4tUFp62mI/VQwegZaCotpBxR5SS1uiBNrDubg9emwdC/Ti4ZafP2vI5gXXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dxh6OJCj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PA7m1m029604
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4TUqX/2UP2jnwCgFCh3YZoQRNRidr+suu+zk9+HGhfM=; b=Dxh6OJCj3lnwPsyx
	AmJAr80b0qoUvS3i2Rtb6bVQ5f4zIReE8iXTs/axPlMK5YzgD2xZ+k8PIslqVjeU
	ghLJMqdaDJhICKmtK9Y0qkFgdy9bYw5vM25yiQIhekwgVxVSfkoeSpyNsCrpzsIA
	c9KnYpOy/ovawMNMtSlb5kJsED2JuvMbaaFImWMWzbFFpwmAeHGKYfz4gl3D7Zhd
	xk+/PiwES+t4EtkpQNGd1NLm9bMvkz9JioOHZg4YPJ+F/WnOB+YV1lXnBrUDKbKI
	aDBET/l36TBwA3d2Ug9p65or3lvx+rFY6SC6KfmKX+nHj5sx0dmddtntUc68Q32l
	YKrqfA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fqqn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:06:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-82b15c1dca8so33326085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798403; x=1759403203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TUqX/2UP2jnwCgFCh3YZoQRNRidr+suu+zk9+HGhfM=;
        b=ovXwDl3RS0GTHWgjUE7VmpaEpsphZGSV7SM2y74arvPw4SHjVRt89U/P2X2jgW7t/S
         TimliLPxd2UH6tSiQxIMac3te2ztbQBWTV8hu5q6XJHqutWh2BUpQNHn5IknCjLQLEtX
         AmPsxmfKnYxpzh1X1ff6fuocBuOkDkupALb9LeXO/23CPayxvwaHeyG/dWAWkKRd2UQV
         7KZAw0z0v/rQ65fXDXyQEM7pUpFfsXWHZsjPKF6t/21MzwusbJeyaw/52NHJ8hbmJFM8
         aihAg0EQMvWFyTQfsEe5NjQelA+h++XvYb+ekJReDUtZManPMyHeMKekOJI8ElApd859
         NPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHZJN5dZXeScwD3JW/7JHf2Jx6+FHWUoQhLLKXz8wAKr2DQ3NgE12HWAW5qoN8Lq2RiXMizDcIDDLbj1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/azMfe146kk0hU2I5qo/oM52N1g3uLeCNvTdLwJrj0eF3i19V
	1dlQsWOtHuJpCWc2Olcfn9b5eWdjuroCuR6JobO3AA9KYu1S8M6rqLInwYn/NICXl8BA52QXa5T
	2TVGwfsE+oVUO+0gmTO2gI+3qPmOkCdwbrqY2hqX3a0yIt4Uyuju1vTmOqX6iYqolE7Q=
X-Gm-Gg: ASbGncupDN/5nOcI4Cex1Q+C+0OO2DGMvwI5zACH3lirjIHSv0IB/YGHqhy0847SG3+
	1lUNbn0l2ZF+Kq3O93+BFDwuXkIj6skz12oMEepW2vCewNPLi/vALcRczmm4xzZFm6kp7vupk6N
	Wmzl45iG+SOmZE+QH0kOSM04hzA1cOgonbjiSuQwV1o/SMTwkNCqk3TTLlC5k8B63tDCJUqQdC4
	3IRD5NJOgoR2Db3+RAuEgETgdcVA2DZbmiZiKJkN7pjXlAjWzEAV+8qEt6O5RZiGx6KfTgY3Fmm
	etuvewz1no7gtMCkWR72NiO7hlOJXJjlz50gvDiGxsMVhuPvG4A90o36kRdDpTu+fcuY8AJYyNR
	dMoa1PonKof+nA4ApWlOUew==
X-Received: by 2002:a05:620a:25d0:b0:829:9017:82b6 with SMTP id af79cd13be357-85ae6d8219dmr223976985a.8.1758798402918;
        Thu, 25 Sep 2025 04:06:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUDkpnALbd8j8AqKvQTtvUGT+7H8HmfLLCVjMkeZx1BzRf5E0I8t3uyafJuXTdEjjnU2AsBA==
X-Received: by 2002:a05:620a:25d0:b0:829:9017:82b6 with SMTP id af79cd13be357-85ae6d8219dmr223972685a.8.1758798402193;
        Thu, 25 Sep 2025 04:06:42 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f86f478sm144386266b.39.2025.09.25.04.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:06:41 -0700 (PDT)
Message-ID: <a2008350-7aa7-4f94-9f19-926cf4e9d40c@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:06:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] arm64: dts: qcom: glymur: Add USB support
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-23-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gQ8jhMLlkvmt-mybUWivW5ehgUrvnoDj
X-Proofpoint-GUID: gQ8jhMLlkvmt-mybUWivW5ehgUrvnoDj
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d52244 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=f_k5thaLw67-wvj6FDYA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX7B0HqZwebkDz
 y492sqBAZVcGKwnvhwFZrEDLM6IxGBZBo1e1vAsCy0Z4cONeaUiwmJq9Ss1b+I2+OM6hg7u7xsc
 KV7v9NefwRKw4p/Qtna9ZLJ9wwbL6jQ4CHe0NncSY4+Ob8AekfKlAcRCK29nz39k7w7hZmnj8RC
 j3sEM/ejlulGU97mfGMOeBJuaD3HOpIk7vCw2Kc6b2WjTJXI7GfZmJsUpEGt9DdmyRqLHZB8TCt
 Svu6/HluGJ4N8/c+KGND7XmEgv2MdAfxQUj9svfWqJ0bSPEz+anG/kWGE7PNW7qsUsdCmCYtm2o
 BM6c7UIDio/eOFxQsqZEd9WgJKjaDvUKyuFTNPYk8G29hp0cuYRO6kCjlVdKm1YHrafqQG5+L/7
 6yxe+r1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> 
> The Glymur USB system contains 3 USB type C ports, and 1 USB multiport
> controller.  This encompasses 5 SS USB QMP PHYs (3 combo and 2 uni) and 5
> M31 eUSB2 PHYs.  The controllers are SNPS DWC3 based, and will use the
> flattened DWC3 QCOM design.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur-crd.dts | 243 ++++++++++++++
>  arch/arm64/boot/dts/qcom/glymur.dtsi    | 569 ++++++++++++++++++++++++++++++++

Please split this into two commits

[...]

> +&i2c5 {
> +	status = "ok";

"okay" is preferred:

$ rg '"ok"' arch | wc -l
6

$ rg '"okay"' arch | wc -l
33019

on a random recent next tree

'status' is also expected to come as the last property (but still before
subnodes)

[...]

> +&usb_1_ss0 {
> +	dr_mode = "otg";
> +	usb-role-switch;

usb-role-switch should be in the SoC DT, and I think "otg" is the
default dr_mode

[...]

> +		usb_1_ss0: usb@a600000 {

the nodes should be sorted by unit address

Konrad

