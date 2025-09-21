Return-Path: <linux-kernel+bounces-826187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12725B8DC98
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D643AE3C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639832D8785;
	Sun, 21 Sep 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQMmXiwy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAE2D4803
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758462166; cv=none; b=dTZxLHc+Nj/lDQtrdmuFYlIdmiSRljEZUafm1y4BtqjhEPjmlO070Lz0pTL0F1Us4Xv2thFF9O/b0Y6PgzF3yy9Y2hDymvuD3K1QkeN/n3dI5Fkkm0mWM0Wb73mzlGbZDOlydIym8EmQ0TQTuXSTmi/FccdlfA3r4R7xPDgosBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758462166; c=relaxed/simple;
	bh=H6pGhEhT4oR9iVYSy6gV+v2KRH+Ert41re6H60vwxz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzLAQO5lpb0w80V4vs/sPwtV5vy3Lqwt4Ef+PDZeymhTEH8kQK5Ea3E36nLRZyRcL4IdJWNb1ruKwVdgAp1zZVr6NEfx68Vq9h83nR4HhLOBsJ30FxcO1ogqWKoHk8CmkpOt+uQwkqETcv0kOKm4v+ExiP1PAFpJKybYnd6Pe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQMmXiwy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LAgFPs010469
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=41GBfb+Fc3UcRhw/qydO8Bys
	CX0wolmp7w7aZ1a7kNM=; b=DQMmXiwyrLveKBRQc6LwPjww5zdOW8yvzc9R0qIl
	owhE3ofRqCf/OzzfW+p7q3d2jfTswf9ZevD5ld7qd5K59k22RjDqT6Nx1zGHRKXO
	c7jqNNsdrBaRC7z4fbg3Mi/m4qnp0kINtiw22DVG8eR+Jl5NUMQksNXvnHl89EPE
	RKs0BinJtrRrMLiS3m49rHE7MqsYY1ENsKs0Yt1s9wFS+Zb0FQlzAHOR7SsUOoHW
	CiE62soSklyVbcRcG3wWzoxThO/8GXtNJ09rFd8w9gd1vf/mJ9Nrt9nyius2s0Dp
	m0R4Mf2Q4aldYzfECOa9AUnXJMNUdp4v1zMkRhjMhiO8Vg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499nj8t3qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:42:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ca8c6ec82eso4104081cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758462163; x=1759066963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41GBfb+Fc3UcRhw/qydO8BysCX0wolmp7w7aZ1a7kNM=;
        b=XLCvp3e7ZLEW4Z6Nh/B0jp06TsI1gQ80q/GqqfGfkeJxFNkEF9WC2vWL0wQaoTZzNt
         5+ccvupy7dD83V8p8rCnGICj7pa/lW5vp3HhAFiRkaafU+wKJwPU19+Fx1f2iyoScnBP
         ReDh7vRzQQ+yvsSUZRSO78snNaiGgSrBxI0LjeYVuZ+7on+HmJJ05/eloZN3oW93g5Vr
         zHJCjIgljH+HShcxmxvGnMABs9HD/EJ3Z3H6RV4ipLJAffazdjz5Da5QWXxhbWJ/GDzW
         X1Jbg6W5tSsk3q8iVVieuOija+dpb9GTnd8Ll5Jsi6CTRQXiaIFVTBQTGdA6R2jHChPg
         MRsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFruWQYBhQj7RPXlNP+hVVk+Ie4nGDHv6z6usC6EQk7c/cIqFsQYbrDkKjNxQ8rKw6f5XcB+fgSOmbHy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF27YwoMEYX1Xkiu90knF5SULJLSVptVel+uNUV8eXjg82W4J9
	rlXkmZEfsQAGjEsBg35O/UoTk+CjHUqL9StuPhiF9cF+w3vBMhPXTaLrgcEX6asHpk3vdh30Ijc
	MvQfGKvxAnN4qDkPPcYRUm1xDzasUUZxEFuZj5RdTSbPFXQIPTCrM/blf7eQuqFaAntM=
X-Gm-Gg: ASbGnctx39fVQgbCHkoybitGcDRlYOMgICTZFt7vZmTFuEzmkR6edqT5kzhrQ0WntSu
	YPFfx+sZ0V5a8TIpxdm7UpAzVzP+P2kE/C6wGYtSlxeZeSbsY2wuYN4NF+3dIMziUEzvMiOYeHj
	/yAO8g1Zu09VKrOu+zgGQ6dUJxHmKpCNMK2lFxqtoD6NEB7++6i9r6M0kg9VyZVKtx5IsmOsIg8
	wKkOEUeptEz468I+ad2BbokUES+VIvXu0x0UblALab1yat+2XQUevF4Hhp8GAnRcbP5HqM3eZ/N
	GCe44vGw/i8gcU8oRg2fit7daGOISsaKe21nZHR5K5gtvpFEh7TTG22uk4Ji4NtbzDCnnPVyxtX
	nUDVRvPgRkCzvzk3Wyk/gI/oQFzy8wKHkXaEqzAuUpmhF5rH/S38b
X-Received: by 2002:a05:622a:259b:b0:4ca:bde6:cc8e with SMTP id d75a77b69052e-4cabde6d94dmr6608351cf.25.1758462163167;
        Sun, 21 Sep 2025 06:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFswrcTGOhaSgk/wSyNd13eYZMRtIi7CH1fbBIBuWJI/FFQV4PYBBaf+PW90z6AV2BM7gp+Eg==
X-Received: by 2002:a05:622a:259b:b0:4ca:bde6:cc8e with SMTP id d75a77b69052e-4cabde6d94dmr6608161cf.25.1758462162670;
        Sun, 21 Sep 2025 06:42:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a957396esm2546067e87.107.2025.09.21.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:42:41 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:42:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, Max Shevchenko <wctrl@proton.me>,
        Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: dts: qcom: msm8960: rename msmgpio node to
 tlmm
Message-ID: <kfqv3prsr5q2ulbsir5ndw3baixoldt2qwhdj5spidgok7y7ad@pmwczkealior>
References: <20250921-msm8960-reorder-v2-0-26c478366d21@smankusors.com>
 <20250921-msm8960-reorder-v2-5-26c478366d21@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-msm8960-reorder-v2-5-26c478366d21@smankusors.com>
X-Authority-Analysis: v=2.4 cv=dZ6A3WXe c=1 sm=1 tr=0 ts=68d000d4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=WfKvcdoTxDYLXQoqPjMA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: cGmvird4GFYFdwDDi49rMWGZok4V7BSE
X-Proofpoint-GUID: cGmvird4GFYFdwDDi49rMWGZok4V7BSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDA0MyBTYWx0ZWRfX21HOOfBvM9d7
 ZpPi7e2qmAcmTAUGL5qUS9at2ZFGVR/DW7RcnlhXjqQvR2lKy3jtgLlcEvAoWDle5gucYxJzXwy
 mo8IEMpt7bRfq86iNcYBH+pfveLl1KflFt3KqcBerqy33hoWsjX30wXDJX+YDJGmxyGiaTj1P84
 udt43Jo/+A7wztS+IecCr6wMhA4SIV3I0VZOvjJTj/MxZbSTEB2TZwy6DLz+MexrDCuSaYhqMU1
 7z0Hv5PMz2G6fwDIfSA9tjWmFFCeNBy6y8iWwfqdORiRy+8UmuO5GjxFUzgWJm3DqBMFs3QyE7L
 1AdHg1clnuCLT99ZKUFasQ6Gk0jD8WRStvWwrQpuxehwFsjF/UvHAQCqvuuyc6xg6pFYI9/Jbi0
 gXEw4RhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200043

On Sun, Sep 21, 2025 at 03:08:15AM +0000, Antony Kurniawan Soemardi wrote:
> Rename the GPIO controller node from "msmgpio" to "tlmm" to match the
> convention used by other Qualcomm SoCs.
> 
> Suggested-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960-cdp.dts                | 10 +++++-----
>  arch/arm/boot/dts/qcom/qcom-msm8960-samsung-expressatt.dts | 12 ++++++------
>  arch/arm/boot/dts/qcom/qcom-msm8960-sony-huashan.dts       |  2 +-
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi                   |  6 +++---
>  4 files changed, 15 insertions(+), 15 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

