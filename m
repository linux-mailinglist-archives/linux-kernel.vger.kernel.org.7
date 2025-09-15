Return-Path: <linux-kernel+bounces-817648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D7B584E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61FD4C5CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737452BEFE8;
	Mon, 15 Sep 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlbzvvFC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B8283FD9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961874; cv=none; b=RJeHegmTk9rv9IK56S6Wy+1zyV/Vop3qrGathrKkDPtqJPvOdlsEPN2ocdqYgVrZr8qLXOjYx1Ndbm0YoczlGV+V6lfLsC4If/OV6Tjnb9v7KR+Ui6Sn4aOsrvx5YrS8Gkh+Ofxh4DKG23ZTUWt7w698PUwdEPDX03wQ2w4EJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961874; c=relaxed/simple;
	bh=dvdcr2365IR6Adiclv91xOLP2sptVHyL8a9rFpMz120=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pF2DtUP5jaIylv0XKBJzq2XnVUlNgxX2i5uxzAUUpswFOORPdLPltiiuEdmyuNkSLv8rdlh+IK1WinPbzz9gPXZy6Jp/cpWk1yWglD7KS7Pn84Uhk5LCgcOBwd4a6vfOzPncTU/lwReCwdSbHYy7AH9dHVd2gUeThJvGbZ4fvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlbzvvFC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEqNw5006332
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H7zlZEbDvwrZ2WwVeg2HwNFd1B9kfu+h5gfiJZPAmHY=; b=GlbzvvFC0GOZbHNO
	YZK7RX+ZjCnBqRouBf8va5ruvETi68OI9EeYRlVq9iPIHaj44lsbyKCq3ig1Zc6W
	GNRINIjxjHOALjPa+RX9n/6tdrk8IIxnMDULOxE2Pj5UiiwkyRRLNd/gXCbMVSW9
	eAMNLqCUw5p0f1CYKC/GmedluhV005zaPKI+AX4VhAh+B8NVPGpF9FkMU7JfaDSn
	WHWtPgjDVQTMDositpa0l/2k4CepzcIwuL/MB7PR17huVF/9nG3WdfRiigSIv5W5
	r/pNAVl2PAqqC4cE2tKfdX1Nv2nTE/9vReCem72L2+EsQqWZK1qzVgvroiimkSuy
	b6243Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951che1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:44:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e91fb101so129273381cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961862; x=1758566662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7zlZEbDvwrZ2WwVeg2HwNFd1B9kfu+h5gfiJZPAmHY=;
        b=E+2fcoeilZC7TAG2n2/hDyH5YrD6F6RbNgCalN1xVLmn1/RStZNGCocO45Yvy2eacP
         wHiPzTeFNsqoFxGDgWaC6zHgmrlrlagddr5NdqZTfAkVini4d5Ncsa6G3Gw3FkKzJqcE
         xPIcj4P8nB90VikgcDFGEkrbyShqXB8q6lz1W1laarbnXPGYc+p/CA8a9fHIvrIIku9R
         2lUHdjXPFdh91Xp5kRPTzZXB1twZWljZJgUAD0+nKEnCga0DBTN4ptqGS5ZyhG8ftIuv
         RTOZv8K57QB+tlnt0oZCkRVUXqsijgyCoaP2d0NPxU97bwoVgWIizIhRay1QkTv/mgP7
         1izw==
X-Forwarded-Encrypted: i=1; AJvYcCXPQo8u7uXh+R5Mgm9KpOLZOBStLN0GlNDejXaleHBsuboRPS7EB8EYCONlT7fXzD1lScq1KuFdMPhqUHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnsG1iCxHTQ0nmXEeD8pfBziXGUg4UJl7u9dU8zyt0quIp25Fg
	J9mVRBs5zLcqgYaS1WwWo1aGyjeIuaicS9dY7uZxWwXguh2cuJ7SLftY3N3imc/79sMGU2p1kwq
	V7e6znaIoqKMEqcEYo5X3Hfbh6rYk4m8uhtVtag45WgqJfaRvnm5gOUWgIqVJTSvvMvY=
X-Gm-Gg: ASbGncsR5k4dyZoHjYQ/P07okxb1xrforEZJnhJdlNaWNC+hllxZrbpVb3/YFDZVs9h
	7MCaac+8AwrjZ6qa2lPD8qsEyBCyCLN3UF8fTdW6Fp4JjSyn2rK8CfYS7J04nzHtOl5AEpZ6YSL
	z02F2WcDBDsZUbTrVzDXl/58wWtxVLfdNvVWvAIp2A9GVDaRa/zziwnK6j906hhzB2jTIrCu5cQ
	BWkRKHeL4IHIGsAzWeSvtyAalynzyi8Ao7kXDMHHXbhHjwq+Q//sV+pDimFvO3FobX67OU8AHyF
	kGNpsBOeT4GLy/Mk4SnBsKnwnUcmUqblhkBX5hDEyoVSzZDgCxg9aKCJ8vWewNIlEOhmaQSUaHZ
	7NJA2Cvn1izykG+G+G5vxVeiJ1Y7b4MxGqeqTV9WeVSibsMamdzZt
X-Received: by 2002:ac8:5cc5:0:b0:4b3:3b2:2b4b with SMTP id d75a77b69052e-4b77ce7b7afmr184749801cf.0.1757961862043;
        Mon, 15 Sep 2025 11:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTnOK0+T1KMMZsImJnTzdi1RZ8Wv8HmrxbQ+LPLk7FEY999LaEahSW76CR6UmwK3rVGc8FaA==
X-Received: by 2002:ac8:5cc5:0:b0:4b3:3b2:2b4b with SMTP id d75a77b69052e-4b77ce7b7afmr184749161cf.0.1757961861251;
        Mon, 15 Sep 2025 11:44:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460d741sm3824271e87.101.2025.09.15.11.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:44:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH RESEND v7] drm/vc4: hdmi: switch to generic CEC helpers
Date: Mon, 15 Sep 2025 21:44:17 +0300
Message-ID: <175796184948.521303.17608117947720640916.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
References: <20250705-drm-hdmi-connector-cec-v7-1-d14fa0c31b74@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eeo9f6EH c=1 sm=1 tr=0 ts=68c85e87 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=jF_5xbMhzLRUUPPL_nwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: XWjfUc-qFseHnqHYpXODOdLSdjMnMOj1
X-Proofpoint-GUID: XWjfUc-qFseHnqHYpXODOdLSdjMnMOj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzNiBTYWx0ZWRfXxmWxX4MaThiQ
 U+QIi8YzwJHrIeVeoCbCVjIRRURonEwW//oi4mHZH5FG9BHtZz9RlMrChI4tIijogGZYCZvvPIc
 QKkq+z1JLFdORV9c6KUHP1l9GJNnr3yAP4H12TkrGJqX8yQjKD7/f3pzhUOHN6ocMzYfe7JPZn9
 q40ogoNcoGZqghP1HcsEL+VjYcMhDSNx374kEvdFwZ+DNypb9hyOhnBjnGZAaWcR2FZ/nm7io7W
 vEMt30j6cRvozs/k/k7iCg++A91cC6LtSmjq8/a7iUJraieVslhsMO88hWwSB/R5KkRcKXzK3Bu
 GqFuu2SxuDb3LsjykwVSctVztBj8aSx9DmwXIofUt0LU9gcNzhQIfF8mHAU54MiVnlBbQxj3YNT
 j9rgasKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130036

On Sat, 05 Jul 2025 13:05:13 +0300, Dmitry Baryshkov wrote:
> Switch VC4 driver to using CEC helpers code, simplifying hotplug and
> registration / cleanup. The existing vc4_hdmi_cec_release() is kept for
> now.
> 
> 

Applied to drm-misc-next, thanks!

[1/1] drm/vc4: hdmi: switch to generic CEC helpers
      commit: cf207ea2c39d2809eb6e579279178dfdc89fa906

Best regards,
-- 
With best wishes
Dmitry


