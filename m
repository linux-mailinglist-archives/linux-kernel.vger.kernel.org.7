Return-Path: <linux-kernel+bounces-803399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F5B45F44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2003A8239
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66190306B2B;
	Fri,  5 Sep 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maMH/SiF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDE13D521
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091003; cv=none; b=V4wgBEhRZi/1VWvLaWEWRYH/fAB5Jvcfxw0TBdJXQhGrUWVwSTku/xvHw+CYD3C5JiVbWHTjsSTDwguMJ3Hohn0pMJN7HgY+feqCBGa7ScASJqqJxdMdswWKeNfhpmphTSQF708nQh54hAwV8I4Px3JZJRTQO9PjPtez8G7aYSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091003; c=relaxed/simple;
	bh=Zhw/UVqZNgFRdYxEbunA6uNYahlSCe9f4PRGkQs9ZXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlZZ6AHsLlm7KLwmYhfgBxocqRUl5zKk2TS4wrmqCiIieN6don0IP9srmGGamPm91fYRzxZU+Sd8nbBe+iNWqSC/cXnBBlazzGTHc/rSUzUkKIZkpOTzpeDJEuIj4lWWgsfAuH+91Cm2A/J/E1SM9ay1YQRytZxgeZHTR0QRG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maMH/SiF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GASmx003771
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 16:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9XYNERtBPOO9KHd6gblQiOck
	lBdNp7mI+kJcs2pzXbI=; b=maMH/SiF0k3R7jr9nOPmMR0ubPcAuKDxdq4fVOFn
	V2apm33QIUGTulrASzHPfpDDGiP/QSltqZuky/aDNjsiqcbioaJnZXImmxc3WEvC
	PfpNU1emhbpxn5DjkvGKPEe7XUovPdPKlru9LAwRmyzewmRhIlrdq0jgxIaDjH2v
	MERFbkYhm4cRNfaEY4/wYWIXwQftPtDxf4V0k9hWw3t6r+O/AUPnm38XpQdOsmjs
	wJUGDRB4RvD7XFx/90PO03QBTWk2XJeu8GWgte6nP0C/ZQKvVUf5HUQSilU1KzOS
	iQWmS+faD2pNOS9gBgUgN3Tj3DQ5lYZWdf6QRshuQd/D5A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8sby6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 16:50:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32d323297so52116331cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 09:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091000; x=1757695800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XYNERtBPOO9KHd6gblQiOcklBdNp7mI+kJcs2pzXbI=;
        b=TlAxbqSwP2QcQq9WlM/ZJzXDWBIfSBjoTmO80Ybc8VyEaqDYo3jNPElu3Z3LC8Mfpv
         PyPV8fTzu/+uSttEXSsN77A1nGPesyEbj3yZ+xBDlg07xeOQCwanzw6tapdT/P0W1wia
         sYEhtGFI8sYS1sLPbWX2BK0vqHt18vYTBQKYRO8akE1h27ezZwaz6X4FOtilkoH9bWl0
         zcDFQugDV9HB7TICpbGjuSg0kHun1sSSKFup7w0dQig0EpiqtlknmBhRAYhrcWKAee7w
         Lt9CCNC69B6DglkD7L5mgVNEboa65Kphlu4kJ10zh3ZAoe8l7ys16qquFhsyIRVCOqsE
         3o4A==
X-Forwarded-Encrypted: i=1; AJvYcCVSu7ydPqDfbgnuxxxj7wBhE+ogmosL6JJDDrCWxkSA8HG/Poq6XT9wqxQiGtOK3iuu6agZ3LfG1X3XtMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnxpSSLWe6EWm93q/rmhR/rzem/Mpecp218goIDlQ4PnYzHbJ3
	kK6Mt2nSA7gd1noBLetmQM2ZVs57XtaHz0YrGMFzAwfJpJJu1QIbfrymQ87IENP5AR8ctx/b+3E
	O1z5pOMfu07kyasDAxaRqIxIJVmV8eGKUclRiz49dJ7KQcvGDRg5Y8W20kfbIIyBYwdM=
X-Gm-Gg: ASbGncvms3zoDJ+qOrTP7NVEqPKTvZqfxChK6aO5Gp5Httcxi2Yg/lUrOS1+xDKGPLs
	vUh8IShux2pAawrjfTC6XqzWrEsjVoGEY7CL7weWb4+QB5R5WgUxHfqOPTenYwV2F2kMEfaq4dY
	dppaCrQBUBOPRz/up1JM/tjKFRwH4SAWnEFMJ4+6R5JPbSB5msa1vR54J5vS4JAk0ZtEJQpfzeX
	HNtNjFrNQPptmaxChxKALNXL3CtAUBYbT06A+q8383vQMXVoiQc73ilcGuqyabCB0S5slOPaULu
	LURtmbeTTP2JbXuwHuqrjzuRTU56yqZtclPF4t8S3wf+gWKY8FkGkT0b0jVQzzRHMVz+Uniwpqv
	lCzMiZZsM5ygBnBhZ1R7IFeBWdxhoZiNaEsfmHSJFbiFUNqvCbDrn
X-Received: by 2002:a05:622a:1988:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4b31d80c426mr223970751cf.3.1757091000027;
        Fri, 05 Sep 2025 09:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESUiemXAgecIsqgg/wr+NsF/v1aaJddqDM6nMppXNbjeqxcZ2N1fHPzDKjQPw3tbxAbO/V/Q==
X-Received: by 2002:a05:622a:1988:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4b31d80c426mr223970501cf.3.1757090999302;
        Fri, 05 Sep 2025 09:49:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfcd18sm1861710e87.108.2025.09.05.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 09:49:58 -0700 (PDT)
Date: Fri, 5 Sep 2025 19:49:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tests: make sure drm_client_modeset tests are enabled
Message-ID: <voexthncfmefgr37xx57jf35h72s2zjc4wyn2dujyhtouq3tr2@xux57zdqov4m>
References: <20250821-drm-client-tests-v1-1-49e7212c744a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-drm-client-tests-v1-1-49e7212c744a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXzlEidj3BrWhH
 6eUA8YI5tDs1SnHvGco1suJvSLUe1GWVE6yLT8bcVog0nR/LlD7zQhDSDwFu3qUvd7gWbRzOaO1
 A3NFxig38gKT3XvYWrAG+ETQ5frteVMrZG/hovOuQLULUMBLA43gwhwtvYbDhb53YeXHLu0hxYR
 1OkZnUIiLLUyBr4RVtiSk85B9bjqJo/G9bunICIRmYZPnX28ez5xC+BAeGcuiUApxkJV7ONqPfk
 PqiCv2FP6vUU9i9bpu18cwQOFNVrfF1DCDISexaP0PTKcATk5vMVmu23xEjru4qHJMN+NDKmDrU
 233OfUnmotT6EUoX4Goj/y3K2v3x818WFYraRXP/S38HQVhyqxNaXs2EEhYY+nQyyvGttQAI1Mz
 WCw3f86w
X-Proofpoint-GUID: FENsV9iMHx29rGvO74Kriz0O86PiLUS1
X-Proofpoint-ORIG-GUID: FENsV9iMHx29rGvO74Kriz0O86PiLUS1
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68bb14b9 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=F7yDxb397TplVcg9Gk0A:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Thu, Aug 21, 2025 at 02:25:06PM +0300, Dmitry Baryshkov wrote:
> Default config for UML (x86_64) doesn't include any driver which
> supports DRM_CLIENT_SELECTION, which makes drm_client_modeset disabled
> (and correspondingly tests for that module are not executed too).
> 
> Enable DRM_VKMS and DRM_FBDEV_EMULATION in order to be able to run DRM
> client modesetting tests.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/tests/.kunitconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 

Gracious ping

-- 
With best wishes
Dmitry

