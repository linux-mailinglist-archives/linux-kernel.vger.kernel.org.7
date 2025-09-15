Return-Path: <linux-kernel+bounces-815934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9CB56D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893AD178CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87886344;
	Mon, 15 Sep 2025 00:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dS5O9eWp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506A60B8A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757894909; cv=none; b=r3/pES9gENmToRLSFa/XVdskpZLNBBSgOH3f1tfM5ZHhK2PTWqkgOG+zpLqJRutJhwJGTX8vY8/CTJxHuhjkvIax0WgA7YwR7bXT4JoVEXjHGhWww6vMYBwWtO5gNX3+28FD7MARZ07WZYCKu43p0/BlIaDXi/rEvA4SR+JuXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757894909; c=relaxed/simple;
	bh=w5+8AtP73tAF4f80M4jzv+Fd3m1mwSzu1c5/Mxog6IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMMIb20KXb0hPTVHBtjJVnM//d+cmsXToswHDVm/yRTU5qbn5MRfa/EjqjSsxT3wR4Nt0EvvCLHdUPmMCsNF2Wo+BIANmxFAjkIFDuGPSkMu81uz8xuvrORIWxNCaAvpbNpHsida7hwDokQI9nVp7D8KDWAklMnr6+pyAcbPDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dS5O9eWp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMMd0Q024273
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jhHQJ2FaZhjbHowvbcKpjMEF
	Vjk3jYUMJhk+fRucFz0=; b=dS5O9eWpq95Bj7YN2/hf0NUR+QUi9prvfH+97CGM
	wGLciooned986w5e0IsJ9fbTgJwG/pNgegL8JTzuY6TIwMjBB2uGTKJt4HpD+ipd
	M73z7oF4ydGllcKJYHhxh1qbSax51CwmOYo61HvMOx2Z2XB034BntzdilBy5Osk/
	ILstF1kthGk8yJAhRRgbyTR7Bb8b3q9bHTJ/xtojxzJBoZ7SlAi6orW6lVrAbtvr
	os3JHoV/nwZJuaTlA4Ehe0ZPxS++rfrrppvwq938nqzYXQGEuy7zwIR7XKVzqtPe
	VG9dLEK6vw6LQ7Z6lE5+8rWGL1No9WO+7sZxWOcE18oTaw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv31rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:08:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso144056611cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757894906; x=1758499706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhHQJ2FaZhjbHowvbcKpjMEFVjk3jYUMJhk+fRucFz0=;
        b=Yy5OAnP5qECVdXL9x/M14atpaGHHRa8lMZ1gt394OmQ6q8QNkkF+VvrwwYMbKuKZkP
         zwAlxk6Wke6RT2kUEIbjelozqxJmOF96caqt/KzDE533aiiz2YIpAN65tUCqb89gtEnn
         Ds6u9QqsyvwIiz5ShzSEHnZrjzSijCT/MwyNWyyGktYctcdkm/PDHGkvuJFYAgRruKYY
         leaWBFUUWGWskEQrfC+77N6rpJGryja1BRQdcyNDjesci7qha9ipEQsMpgG7VB+mcaC/
         yFNAf3emWRWRdjJ2CcKFyOSrzF7tx62ug/X/LcQSBGVJVMUFx5OwrSn0YpryTFquUxGi
         cj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnc1rxkva8wja0oN4lynyVUOfIIIBYErmEPuSUr+ZUhIOEnKj6L8mH0FzuDESH8yO3AhR2kt4KEOpW/qI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLIyBZqqgcsSg+KDX6iwS78ii+TAY4FCdLaU59XAvuU5EGLvm
	vtcC/cfCdsmBpBpQM+kJCtI0VNiOlz55tCN2l91oG5u8tAg3xrNMiWO5rDBRKO4uKQzmOh2AdA5
	wwlxPnonPxP1V/zuDh9et7Shc+7lq+7oNxOKyHSRzCxTjk33wW4veYtWYpmCf4BW1070=
X-Gm-Gg: ASbGncuv7xb+46PWNkkD0bnT90/P4u1YoQHdCR8+0Eq8b5B/Xn87ae9Q0XBNEwKwfu7
	yML3x1eziC1J7oRuwweUoDaGoU/fhY7+J8SS/Lwpk6cHIoFmJOuH66hJDJLovuSHcb7E0LikEUv
	7Nd7W62uIgH8bXprFVUrgbdnn58QsudLsox5Zwcr8OVpvety7oVsUFq+hexnZCiFov6QZKzaWOv
	FL68FkWtCXxoMnFd2FdKJlPi78bwVVs45C3SnK6q3Dw/H12ogVts6bemw5ZcEw250ceMQkq2joa
	ub5F2Zi0T6318iRpZPGiROSoSstAZso/zYOVu0qgFVF1DN3F/ADg4mgSx7TIKpfJyb7NSlwVapG
	D+xehqg3E+NDLMAqI/EU7de3T+jOJHTo00ZCC0eovflQs4NSU2Luu
X-Received: by 2002:ac8:7dc7:0:b0:4b5:eec2:fa with SMTP id d75a77b69052e-4b77d05c20fmr145396131cf.62.1757894905775;
        Sun, 14 Sep 2025 17:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlzWL1Pn7gtuuEpIlHBZn+SrnRj7NK/IECY8KYfOg+8dAVUiEVUigMgQ3DRWqq0FAo6LUpYA==
X-Received: by 2002:ac8:7dc7:0:b0:4b5:eec2:fa with SMTP id d75a77b69052e-4b77d05c20fmr145395871cf.62.1757894905336;
        Sun, 14 Sep 2025 17:08:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460ded0sm3264619e87.105.2025.09.14.17.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:08:24 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:08:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Max Shevchenko <wctrl@proton.me>, Rudraksha Gupta <guptarud@gmail.com>,
        Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH 6/6] ARM: dts: qcom: msm8960: rename msmgpio node to tlmm
Message-ID: <nudo46pgp2uaegztcpvp7iu6fuotkp4hjhpl3qo57jpkjr7dph@5ypen25l4xnc>
References: <20250915-msm8960-reorder-v1-0-84cadcd7c6e3@smankusors.com>
 <20250915-msm8960-reorder-v1-6-84cadcd7c6e3@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-msm8960-reorder-v1-6-84cadcd7c6e3@smankusors.com>
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c758fb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=WfKvcdoTxDYLXQoqPjMA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: eCRu2uo6eSZCYXgStaoXMWqmnixCqQ0d
X-Proofpoint-GUID: eCRu2uo6eSZCYXgStaoXMWqmnixCqQ0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX8bDN1dLjT/hq
 pAX+8SA91pqMphKcw+zMVLMP9m5K3gxZBOFtOicTre4RIGRrhydg+SbRRbarZS0TrgGKg5+Y8Bl
 RN2I0V65dsWND/J7/F3AH6pOSQZ2lc5DwPcIQ9tR2/qcQ5xzTGtBCUyeCa+o7jIIrTtRjKIR8z/
 HCT92OdDyD9E69DPCyqiPIdAka27a2WsDBFf2aKZyrCkq1Ng9/jQHM4WeqvEc94zAt4Q9zYK4Uq
 FZ9Ph7Bx5sqTASaINhwJhBE+2m2MW2goiTdCFFtR2IzseZDGQD7C00E5zXvaq+2pcxcycgk8Xtj
 rOV7oU51knopFM4WyFslIiMkocWZeICytKntb41oY5l9dPlzGO0IQ14KInzbogY0ThECf+7z8Y9
 75J2yG6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

On Sun, Sep 14, 2025 at 06:35:03PM +0000, Antony Kurniawan Soemardi wrote:
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

