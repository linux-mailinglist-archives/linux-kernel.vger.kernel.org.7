Return-Path: <linux-kernel+bounces-842498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD3EBBCDBD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24263B4D2A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8E1DB95E;
	Sun,  5 Oct 2025 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="grCnBlXK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DAF27461
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759705706; cv=none; b=ZvdD9UqXa2uwXIcFofX0gW6ro5gAXUHWWkbbLPF6rTsxzlbxBfdBTfkCrxM3fTVYqilUGhucQStr9oOuyxwx8z9CRPIVIwZ2+sMD8TN1mCZ+NRFxEUhz8YS1sVnB01YIPCtEgskfnywA2wCeeBtOhgiblIDh7IFdyvoY7TrqXqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759705706; c=relaxed/simple;
	bh=YrxOzNVXmLJE4p6kZcsRkAJ9wWhOPmGI8PQURrfzTCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjoLrZVPHOlV2fNdZaq26gegMGWhzHAzHS9uFPbQWGAVMk5ABQt+cX1q5HF5Zgv6xQFUelKXL6Z2SU3JbCTgiJFgNszWIgFiSPIZ2bresBlt7ScaMYai+UfYmDHg+IikFWzmGqhUETXKTItVQCIgqFY4HZ7I3k/iYgmjc3A4SCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=grCnBlXK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595L1jRX024856
	for <linux-kernel@vger.kernel.org>; Sun, 5 Oct 2025 23:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zlApvwg/fcACgNbb2Fz0N2Ld
	p2XyEFilO0F90mEZD/U=; b=grCnBlXKBCQKIfzKto/4qdNVaA/lLy/DcBU20hXk
	aT2Be+NGFcPOQBtRipP82bnngTS8ByYojuftIdtXu+ieQwCpR0x9Zkc+nrljFsIQ
	0YQ7kJRZjVf1j3wHqNcnIqeBcQnXvUNJBEokvPdSOdZShZMj5VBJCilB5jLd45MA
	HOHng9rJPhb7/Q89I2iF8G0hoTwaETdrS300slTO6JTWVgXrPPTC4bA5kht7+uep
	lXdjlwAWXYd6s4cJvOp0xt7VtO4vGaOGIa54g6mh0x9dk6d+doIfSjBOzfjkknHH
	i7j6gUQm/7Ykd93kD77jYHCbcof/qQSrHcuzOkJ2jh9BwA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49k6bfhqyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:08:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e0fcbf8eb0so105601131cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 16:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759705702; x=1760310502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlApvwg/fcACgNbb2Fz0N2Ldp2XyEFilO0F90mEZD/U=;
        b=fss7/uqgRJ/N0JKT1Brh35bUycOUEelVDnrIcTn1Br6rI5WzzJoy2EImroJ+yovrJF
         NVlWT3E1FMa4hdkHCdsuvWmCzwxzyXKSU5OBujx8W5HqckiF/o0W0o8kUlK5dXhHYUIP
         g/7JPyqUjGlOxTQYQL20zOc3hq/U+q9/3X4rNvbqPw92ddbMeDe1NmS4qAs/FBHzLNzg
         BkvX67se+ioAPq2ti8lxNZDH2oosjSuZ5dgkpavYvi2YkwheBmvryXAN6gU3IH9QTHD+
         cWRe8st+s8T5NAUe3VWJ/nhn/b6Zl5aSg+63ad5jbN1G/9i3Mi3MQbc84WGQdIL2veQU
         BEqA==
X-Forwarded-Encrypted: i=1; AJvYcCXexAc/3NNXAJE4/UyaZ1UZ7pqC6aL4+OO2d1Ty28ylKEOJn2lF66Lz1yAH8yHHeDKcfQRbQePmfym9C3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKnEZYv4qi4xIRzXFu5gK5DoWo4W6eUTMtGEy7BN7yqakG5D6q
	zUFeRam4Nh/89wLzlQ/xOZ7wioF8qidSxOSlM8JUxDQ8+DaAh5rwfBxku/bkRSfVAgpyHR/udZa
	5hjnieTTqm6iMVdLOx5XkP+Pt97oFvVSoBwiPEfklwk14pLcTgyBbZ6Ga0YjtMDCN0jI=
X-Gm-Gg: ASbGncuyCKmde0iUNG3FcwQeg5FRvW8T92/EaUo94Of4Wlmul97N2EUDLzKTMjszZmQ
	yvNwfvcssMXNy0KFq3ElHWPtc5u8osylGooHf9uUG0bNdMHD4IbPcQFDL8/x35ps92lnDguUVUb
	SgrVxffTy6tgDY7ev3Ml4IlNO+BwubDsunoQPYTYkcqfgiT8Caq/zx34v4rSgkh0gUJhupWAvLj
	pL1kXMTv30Tn4a34dKBeIdA1umdJmiuUelzZhBjLcKZbCgw0jsgDWJc61X0wJi1x579H1MLIA2r
	HCYBi6vl3kWW26v8LzhQtaEu3ZoTrf/NbA2MmeSin4Oc1iJuW97Camejf3wMpZDn8qWCuLFugS5
	uzWszfTXwsJ927YuXqQ/+lR5UtVlu8BqL106ej3pLMcxexkY2DXyOQ7mk+A==
X-Received: by 2002:a05:622a:59c6:b0:4d6:281a:fe41 with SMTP id d75a77b69052e-4e576adb491mr134885551cf.46.1759705702356;
        Sun, 05 Oct 2025 16:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+6mOZKi+noEiA58aDqmkxFwHw9Tde5U+qx7nYhM9i1S3nYcgOiYN/Ve5cxBmXytJyIFxVdg==
X-Received: by 2002:a05:622a:59c6:b0:4d6:281a:fe41 with SMTP id d75a77b69052e-4e576adb491mr134885311cf.46.1759705701871;
        Sun, 05 Oct 2025 16:08:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0119e966sm4402542e87.100.2025.10.05.16.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:08:19 -0700 (PDT)
Date: Mon, 6 Oct 2025 02:08:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
        andy.yan@rock-chips.com, mordan@ispras.ru, linux@treblig.org,
        viro@zeniv.linux.org.uk, aradhya.bhatia@linux.dev, javierm@redhat.com,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
        s-jain1@ti.com, lyude@redhat.com, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v7 2/6] drm/bridge: cadence: cdns-mhdp8546*: Change
 drm_connector from structure to pointer
Message-ID: <ae3snoap64r252sbqhsshsadxfmlqdfn6b4o5fgfcmxppglkqf@2lsstfsghzwb>
References: <20250929083936.1575685-1-h-shenoy@ti.com>
 <20250929083936.1575685-3-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929083936.1575685-3-h-shenoy@ti.com>
X-Proofpoint-GUID: wzJwAuB1NSmft-sYJ1KBhmFCGWNo_K3D
X-Proofpoint-ORIG-GUID: wzJwAuB1NSmft-sYJ1KBhmFCGWNo_K3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDEzNSBTYWx0ZWRfX1Bv21RcxpwbS
 PZ6OGVjjr42b415FExwRAJi86PFp4yNMQPyyViod6i3gbb7PY6l9sUmaPDtdiRd55C4CbLnxb7q
 +EwmVXMO+drn94z0DTjwS4rkSybJKTWLJuQ3Odv97xoXRzQvmhi0QKVobJAMYCn9Q9X7TnsIEXb
 2CtGUtUJ3Tvp+ApTLELdTSi+c0/8pfhJatmuJzPGLTkNZeq3fAteg4kK1MRpr34yUMDUXAdb9u+
 v13Uj1HcRZLdvEP/6CX6bBH+1uK/pIvM7LFmZcxBYFEQngOistmM/NLGiR2PUlmN78dzhb01GoW
 /bsVMp78q6SUitvFQEHCBuWFCcaZbJVO/TRLpS767t2LLy3b9cMk1qYEw2c79pTyJsSb1JRKgI7
 0AUciXkmL1MIRdZ41KOsUMu7pRJlFQ==
X-Authority-Analysis: v=2.4 cv=Hr572kTS c=1 sm=1 tr=0 ts=68e2fa67 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8 a=J4nYnVWQyAtGn7mbgFcA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-05_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040135

On Mon, Sep 29, 2025 at 02:09:32PM +0530, Harikrishna Shenoy wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> After adding DBANC framework, mhdp->connector is not initialised during
> bridge_attach(). The connector is however required in few driver calls
> like cdns_mhdp_hdcp_enable() and cdns_mhdp_modeset_retry_fn().
> Now that we have dropped the legacy code which became redundant
> with introduction of DBNAC usecase in driver, we can cleanly switch
> to drm_connector pointer instead of structure.
> 
> Set it in bridge_enable() and clear it in bridge_disable(),
> and make appropriate changes.
> 
> This allows us to dynamically set the reference in bridge_enable() when
> the connector becomes available and clear it in bridge_disable().
> This change is necessary to properly integrate with the DBANC framework
> while maintaining all connector-dependent functionality in the driver.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 ++++++------
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h |  2 +-
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c |  8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

