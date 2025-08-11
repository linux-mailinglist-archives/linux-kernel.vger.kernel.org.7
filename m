Return-Path: <linux-kernel+bounces-762361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F2B20586
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEECB17EED0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2682367DF;
	Mon, 11 Aug 2025 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gNwlm7V6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88823BCE3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908414; cv=none; b=aXDFMdb9q9AeZMjzSi9/Y1si0iQgQwpkw97QPJWJnGEheYmyjdFw2tFrmfsVFLcM53xU5nyube3TpNjmZ6nfmfRmd0XIVOypVAf9Mrl2qXjTre1uJR6kd63bCh5tsZYxSkArSFN88s2bP9qg1GTrOyC01S31h2/INGbOoWpPjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908414; c=relaxed/simple;
	bh=kHespbBD/Wze4n3BwKAN4MIeNGa9Z3EOBJc+ZThJyHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEWY3He6YJekB2nSzxGn+2+fUWZM6241NVBAEKIh+pUqxTUG7ZmB4N35zYPAH3bq/CK1cYMLWKr8SIAeYIqRZzf5qlpXjgkmzLvDhE6VJaHvFR2vNKg5u4FQfNUAUzH9GYzi5lLP10FhbGdkG1yFK2uVGZ2/sPYMIu6CxnDr4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gNwlm7V6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dCtj029255
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xUcHQjufN96j50i8isc5wxtk
	0rBCIWP/iFq3mpKJof0=; b=gNwlm7V69ms0r2+cku8n+dYK4oiEv8wxmw6sru2F
	Dk/5KoJBMvxCi9HJT6QDLQ3Nett6DKGwwY59zakWxEg40Ymp9nzDezXM+OJ5yt+Y
	1nY0GpVWZ/6hbiswN2N4c0/hhvjImsQDCzoH99Ig5NZ2flAhlrMleMnIcT7yPyB0
	0Chrjc6IHQhVTqXz0vSj5b+ERott85Z80cfK7wk9Vx+acOzAo3A4uwvQ5pMt86mn
	29iqKTey/mXBSylxXJI5iJcaqO1N2np4T746Z0sArngEa2PJfH+oesilWmOIwypI
	Ply3VV5RBqbNi+32nC14rD1yOKWuh2sTgeS8+cT0fPm0ug==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9sm4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b08898f776so106902261cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908409; x=1755513209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUcHQjufN96j50i8isc5wxtk0rBCIWP/iFq3mpKJof0=;
        b=GgrG63IfGJnAVJlT+yUkMs86c5mvQLlR37tvtYQ69vnSylrMLqWVVOHF+eIs959y7G
         6G8h4/td5wLnnw7bBzpP8TrD996Bbrg4Rb72r7Z27LFJUgK2ZfsSMDgbQqCLSWk8228J
         fEY7/QS+iQvmF6kacSRpKu7bImmPnUtlZCJnvfENLjmmE1g+72gsw/Kt77koJjMNpDEK
         QGz75EjJFK4XGmMoE1LvJVoDHoBCHIqqjQRPKAJKcxeq4MJmY4Ce7cU3GZFs5+H9WpxO
         kCQxer/52BOXdmvkdiUaohONHdE6Oxg6qTTol6JdrrW7ttIIfzw66IMm5qmzhCPS058o
         fHHw==
X-Forwarded-Encrypted: i=1; AJvYcCXyM6hKZFarNGowZGb6oV+xPqtnJAhyE1UHvkv33gABCyxwNoWP1ZNBQzjzpMDJM9atYie3WBS+qbIDVm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9V52fedFIGbPbJEuUzFhBzdthp6dpeC2w6g8znNTlwjWBERe
	CYQ8bFzDYIcS/9vvB9k1cQWAh92PZuw4Utxr72Emqp5ZZUaDo0JSvZ6/07X+Zn5SnM8iaVS76bW
	iK28ZQOoDATigJNbTNhCAVkFwTsvr76crulT0t3FyR2cjKTnEjQUgW2ibZBkB8ZoMQAc=
X-Gm-Gg: ASbGncsuBSXUYaRk+CEzdhs4ZdTS/ZbhDjM80I7ShnpqbmCmd/GE4cTYS2cNIHTxvkr
	2cmnzRYOYxeE1VU2gPIH2kWWIZCLvpbbPMwVhEsE6T84r999oIAEwC/sZBWNKCcpDMc7ppxY1mO
	8WstjipKEObnKakhZ1orOD/L8Ezr1dUVJxRC7RWgFMaqH1cQMn6ae5KBxm6cHWwqEz1MY9vY7d1
	iy41zOQC3hzSMtPHfo/1gHLgY6nstmWc00+6/1y/LG7UowA3iCjt+4i68ik9m/xe8GXaKcmXI2h
	qMLXDyd5jc0Ov6lSyIOgbnsnjQAY8sgEwYIHSKFj9ixqSJfHycLsC5xAplHt7ycRdnwd8tNU3ZW
	uPl+SdqZWwB3x3zZxzlg2M2qjtJep5OTINi51paUbyDyqEktX5hzf
X-Received: by 2002:ac8:7dc3:0:b0:4af:1fbb:3a05 with SMTP id d75a77b69052e-4b0aed802cemr172661121cf.58.1754908409496;
        Mon, 11 Aug 2025 03:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5+d1EPtwxEZN7NaQibr0TadKLirlbN/cpnuNlgXjLHPDePtrYQxufGwDmRoZ5/mmER8t8g==
X-Received: by 2002:ac8:7dc3:0:b0:4af:1fbb:3a05 with SMTP id d75a77b69052e-4b0aed802cemr172660611cf.58.1754908408908;
        Mon, 11 Aug 2025 03:33:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bddasm4246799e87.39.2025.08.11.03.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:33:28 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:33:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] drm/msm/dsi_phy_28nm_8960: convert from
 round_rate() to determine_rate()
Message-ID: <m4a5sw7ghzepzjh5rzxltyktmgqocaacbkulpbwsl2alqbqjhs@st5qillinrnb>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-3-0fd1f7979c83@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-3-0fd1f7979c83@redhat.com>
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=6899c6fa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=oBXrOfH6mq4iYN50PBoA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: KIvCYtmZt5vtNZrS7z5iAh8279u9to97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX/1dtimFw2vdD
 aPLh3gVNVMvul/+exGG3JRfVqQK/rp01A1ihmJTVO6xMlDfkant92ja3hFFjBHmlxuqyMSYCck2
 h5vugE9BMZoBEkQyafEza93n1+Ip9A/nKSpCHv72ybnlhfTBZo9O1KqEG36YgMbksutkpMkPcs1
 12wXvV6NDqPxp8EGEOS9HzPH9MKFLL5aXS62mfLYTmE9cpA3GoTZqNTRZZFtzqYxY5KD5tVujzi
 hXiUbD1HwzFACApkrYU5LYjA9v3CeW6lpYkHKUlXPWNc0JIxcRZanqDhZluVueaPZFK128kaZI6
 qz3+o6Sq5aC1yMvdre3P9V+PcK56BwhJFvd412+JGLyOsMLOzecJhcbYol3TCCeoITIZ7tN216N
 A/YkNnZj
X-Proofpoint-GUID: KIvCYtmZt5vtNZrS7z5iAh8279u9to97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015

On Sun, Aug 10, 2025 at 06:57:27PM -0400, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 32 ++++++++++++-------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

