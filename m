Return-Path: <linux-kernel+bounces-859788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EACBEE94F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4783C1895CA9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AA2E03E0;
	Sun, 19 Oct 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8NTMZQF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60F354ACB
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889699; cv=none; b=bD20x847QoURMTeYe69dk6fnmzgeypLKOXpx3s3fAEjy+xQqXGrR441iBk/hZEVpU48Mh+3HQQIItSEt6SVJ8Qri1sl+Dbei2JDXRnHh/6S0U9gG/6VAsUzVh4jW4vM3HDJGsHERfQd2Z+4amTpZiyJLSAu0W7zSQk9ajS5+W6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889699; c=relaxed/simple;
	bh=Y0iJ/9eyYoK3n3lm0hBp7ryvH71Ibi/uouxRKsL8GCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEzQSZ3ZIAwU4g0790/otkQVNwb/06ikiUPqbTNnPxEGJnye3Kfg6CBuRK446aVk1AEBFCz5uSIum0OsEYLyG16kFmF1dOG5eOBZZSXY+3jsxbDUdCzVhCYULSoMoPdqJBwdOj0G9qPSaonUg46hrLHlNdUkaRwyJXu/2VajSRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8NTMZQF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JBHQZD020365
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7rP7pPU2oH883opYvKMVKA3t
	WKGuHzQFE50XbgQsV2I=; b=I8NTMZQFu5H5gWjo1xihfJpbicuFbwvN+TinEeDN
	Tn3HNQtK/qY7cfH9cEd8lkpZVSYYtOaIER7kdQgUJzerkOlvi3Z+Z0Ridv3T9DaY
	ZQ0wYvJmY/9wDDJT4kvDCaTHzTx98X6xLhujkKoivfVH2oxdVzCWOnuDETP9XWQ9
	22fZqEdepDld91YJBTVKOpBnWb0EPLUxxjJqGqSOdTu+7b5xhmMFInYlNS5Im7CQ
	f5SPwivV6pX3VXlmA58sgF5ffcLHzUSIMXG2Ys+gimr0LYjHaMS3SN2g6RgXytLF
	pidetQtlOHVXfdTn5BO+S5zFHwuqBqxGpPJ3Z9xGHDr/DA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343tkc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 16:01:37 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-54aa347b2e1so7494300e0c.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 09:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889696; x=1761494496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rP7pPU2oH883opYvKMVKA3tWKGuHzQFE50XbgQsV2I=;
        b=UASozzPWQrFgnV78eAlV5w/rYp96r7NzzqW0ZasPOjrF2l/gGX5ZAnBFttaA3fg3HB
         Z/07xb2wnkKISY2Dq8Qf7qM6t0Dmeheev9eoFQy76rZTiR0icDI108UmfVR+U4OddsXh
         JRQBbrLN7u6lpzf2Yta6K9hqkNuXVAZmGUStr5tPx7M2iPP5mtxHY0iycGh0lfFEh3/9
         lufFQlpODgmF/p5fl5h77P6ySZMM0lNB7JVBzxKBN67KIrvOLsVmN1/PRgaTQwib6DPb
         9Hyx3jHPDtPn6utl4y14r1nj20/WgUl6uRGZErS/IPMR6x7mOduUVDUAdzZrs9zZwZT3
         PuCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu0ThH/pV70NOLLyvpWflwTBnKA7Ct+1Om/Bq8RAJXJv8j8hedgF0YaafKk4KeytHTJkDfajia0Hq4yeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/RYhcUGDen1hhSxs10qgYyUac0vSPRxTRc7mBoU26F4V/HhR
	Kq3m/zp/RHWiSZFjyxcWV7nOxrr9rr7vcok21bJkuPhJ4ltekYgOMnCONJEHeOWJVfDMJxDZnD8
	sA5IiwwqBMcZq5yC2FOL8k+R57Ig+eqWoTMdts48wgX3xGbLX5TNioyDDDe+WOCBFrgc=
X-Gm-Gg: ASbGncvs4WsQqwwonhkseMVidxURub4GNyFa8sm20yrktvAxMmbBQntOOoBQ/tDZFOR
	+v79teWvFRpyfwGHdKD655mseD6bzmX0CiBgN31hJ/IL85Xnk73YvTxJZzsvCTAmUjTVInkNo7+
	WT58egxazLtExq04KIjGidJ5oABORJF98SOa3q+ZSs9tSCuW5vmChvyBKAHhAqohy0YEmsOHa+O
	pGtESvSBACS9cFKsIwG0b12j2nJcC1ZGNTg8i5FhFA3ftd5fa/y2/0cabvRwEQTeN4qUGwOBmQD
	oZ3yW/xyJBr7Ebh+v2Z95JXg2fw9o6W8KBBfCCYa51IgaOu7Jp8y189jQo/soWBMaNFxY/v3RUg
	BOsw35WBjvdd4WUK+jbA4KtM6l0Nxk01BCbcFI6e3ckrwsF3vtaIB+H76XWKgM2tVwLSDc472uG
	cf0nzalOY7laQ=
X-Received: by 2002:a05:6122:3c56:b0:520:64ea:c479 with SMTP id 71dfb90a1353d-5564ef2d46fmr3526023e0c.10.1760889695628;
        Sun, 19 Oct 2025 09:01:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4xGLbXTGWU7Ds5/rjiYwy6R8sjX5nyK0xmuA8TsMBsOkfH3epiqp7Zx0TK0V0Yx3i/1E7lQ==
X-Received: by 2002:a05:6122:3c56:b0:520:64ea:c479 with SMTP id 71dfb90a1353d-5564ef2d46fmr3526006e0c.10.1760889695208;
        Sun, 19 Oct 2025 09:01:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deea8cafsm1678400e87.2.2025.10.19.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 09:01:32 -0700 (PDT)
Date: Sun, 19 Oct 2025 19:01:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add '#cooling-cells' for CPU
 nodes
Message-ID: <itksdoavfha6xnozfrh5jcc4g75gcfyxp7ns75yz7xfb6wruy3@qwkcavvxrljp>
References: <20251015065703.9422-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015065703.9422-1-mani@kernel.org>
X-Proofpoint-GUID: RKqJN0twoJseU8FsOis9o0qycTLc825l
X-Proofpoint-ORIG-GUID: RKqJN0twoJseU8FsOis9o0qycTLc825l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX8AJqdVBJHZ6y
 I0YMsojDqGIjCdmvzNkLcERN6wduqdWBnkyQ9X9nPIFNhV1FTgwR+JTz+Pn1n+CT3245FJWphSS
 w4j6v/zKmNtxbdNfBGnHQa4lnIcZmGu/uC1islvwXXTJTlR7YHpyO8l6kD4bzaeGBjbACWPkqCo
 D2vsO/WBo+8c/vK8ibvV0IkaVyEiEL0/ty/+JuEsyy91PSQAFX/tcPztf/RRfJxCkitNE7po/ET
 fkOF0c+o/8GbFxf8zXWsFXgT9WR+6n1uBOIJAUlPcHO6aQ1YMpgqK5v5vPzeeDPuIalC2sojGtr
 VgSXc5GLza/9eih6p1AyYl1ZU+Pg9RbyHfqSE3qhCGTQjkhmPXNXEBSA28D7P71Ufw7tK2Sqebm
 R0muJSSf1wGwQrYfZk+pjjXmku/wmQ==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f50b61 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=hfyut2BFMVRvG-c22TMA:9 a=CjuIK1q_8ugA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On Wed, Oct 15, 2025 at 12:27:03PM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Enable passive cooling for CPUs in the X1E80100 SoC by adding the
> '#cooling-cells' property. This will allow the OS to mitigate the CPU
> power dissipation with the help of SCMI DVFS.

#cooling-cells isn't enough, the devices need to be listed in the
thermal maps.

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

-- 
With best wishes
Dmitry

