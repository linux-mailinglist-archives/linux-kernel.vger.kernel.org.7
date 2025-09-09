Return-Path: <linux-kernel+bounces-808383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE32B4FF08
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E251BC5461
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F663019CD;
	Tue,  9 Sep 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T5ixmLeo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027B219A8A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427258; cv=none; b=Hg8B0O2BP2Q1zaaNgozrTVfdPtE+6CKZmnBpWsAxitghytqR+KyPnKuXou0I15h7iRXwFyreFwHuL6+bMvHx7AE+Tf9BybLfcO/caNnp6hNvPI2fwsC9+VjbaOvNa/xC75Gu/jD58mt8uN4lbXCEH9ao+WJto7HhOL/07PPCcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427258; c=relaxed/simple;
	bh=Nxxx5ZLT87xReElleyI5bb0omvCeccFguyi6UuhgYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REDXEOVSc7ZveWMC9XhP6x/6mmctKgdOeEq6e1kZU6kFzVlur9h0vkaWgGY0jzbAWg74uZ2B1FQv5mwyUqfWW5Uw6N+X8iZfz1rC8Ku7NWvPdsEs3tJ2ko2YZGcz8SFExL1GIAItzbDLiJ8dM7K5hhg7I/8toVEkhcRDLKzFv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T5ixmLeo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LepJ030639
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=W5FZPnnAYfSSnhNPm1f6v5Pu
	spMlQ9tOXnSUoaQvITU=; b=T5ixmLeoK0g8oikx7Hu43fr4ZiNog5OjTS3WtXRm
	r85JhqR1KHFmjCO0zzFbrFDIgR2hVIjeQCuIG/R1DNsCaWmh04mLy/PO2Y55OOQv
	hyXrREj0rvrA+Rn0kr5CVUTiL99qDpNcWyli46KC7hZcVraKNwEqN7ObZVfTvg49
	llWOKc2aJuaIune+alEcQV+ClCp14LsgEJoToTuDRHk0L3yuiHdVooeVXfNp8jc5
	Elxt/0ugTnursyPGhLQ5klGmUmwXtQ3JPxoj02bZuOemwS3wze0na8Q7wD/6YY6J
	Ci7v7quxokL4LoP2N4cV/Pivmx/6vYqmBWjNvZIsu2U6Mw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j8jhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:14:15 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72023d1be83so197855896d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427255; x=1758032055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5FZPnnAYfSSnhNPm1f6v5PuspMlQ9tOXnSUoaQvITU=;
        b=hYGn3pvELvOPUQGVpEoVgrSuZ1YmA2JfhS5DQszMQFnP9vIzL2JmFlk/RowJHtepVD
         YGhyJRt4iuA+sardgunmUb5cKntoXLp0iALqhJeQFSdvyU0AZzCmF76VHxYYszJhRjbO
         H9yCXQP030r9AcfNRkv3w/Z1zRFVZd8DEGLma5WT3yi8OLiLEY55mvX2pD4xacGwIMNS
         1x3mmH3Io1SjD1PrY3PdotqZW9rrjaq0+8xCHWBv6kG2vM8V9F2fIRDK5FJYxtTN6n1B
         jeJuy++fO2MFHH8nt3Zj4F0cw9CEilV7b24OZ6NzHiu5UkHUf0AGmAsSeIp9LHoySF2M
         //Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUW5Rfh3FXfu+NTo1QEfXOezwyheWNbK+MRUFFbVp+0kD2tKYDTbAi0kxC54NnKCAk96HpfGqVcL7iKSrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWxQuKOhPuvl2NVYrZ7o0nxuj55aFENqDtSI/VcFU/gEpd+sCu
	+/Cjtx20JmdAMlaieK/bodw65I48YoAhXkVgwaTDoUHJ9iVQRSXfkalVTE1Qmtknyvo8zvv2Oyq
	jMGvqg3d7H/nOueNXMUEuQsz0W0GZi3X7D4E1im9kMBS+xqvqLyukNF3oGEsDLUW4nPY=
X-Gm-Gg: ASbGncsvRQYsw0FiTg+fDsgecAQTdmpa6xZcBf0Rf9Zk59fzPvbE87BHdl2sE/Lv40w
	0yrM6Rqt3+ZOk45daB1Ib20uYx0RKpXxMeTOK5xPWM1xdwaJangDdLx3RqrBCw6W7gpGPcBqLLn
	AjpN6FkZ45gbgOBuDz4yWxCV38l5TFaAQ/NvLQ++7Nw3jdgvzt59pRL08HfFfA22aZ8pNsdrdn5
	oJJK5pE6DDfa+vLfklYCEpJqnulR/sWagnuprayE1koxo6HKtkmkn2OaRQoVzOWmcxqpVHAoYfc
	xmhJst3WiM+ErTIV75qNgA+L3hzciLZu46ktLhCSV42pgLBBa0CGaCi9hG6gBeHx6pZbkXuR8d2
	uBzyErqAiIHznQkgyUJSFPYstg68/62eRRD+BUOdpnmEOEW2dNwu9
X-Received: by 2002:a05:6214:e4e:b0:70f:a142:afe8 with SMTP id 6a1803df08f44-7393ec1652emr110126076d6.32.1757427254582;
        Tue, 09 Sep 2025 07:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5HnvrIRYNjzKE2Adpf1VS+N1fWbBiiFfd+dgTBaSg1PUDf5W+niPtxk1dqQFL9lVco7WQ0g==
X-Received: by 2002:a05:6214:e4e:b0:70f:a142:afe8 with SMTP id 6a1803df08f44-7393ec1652emr110125376d6.32.1757427253933;
        Tue, 09 Sep 2025 07:14:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50b0e98sm39956381fa.60.2025.09.09.07.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:14:12 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:14:10 +0300
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
Subject: Re: [PATCH v6 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
Message-ID: <bnydasal33cfzwddq6djfjgfb6viavpfpkuks5j7mpmvihckui@o7jvkwmskcuf>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
 <20250909090824.1655537-4-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090824.1655537-4-h-shenoy@ti.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX2qRBxFFB9BR+
 DKd5lB4vc4xfH8wokpTSD/yIlhM0SPG7BgEx9VdzfSHTWTj1PDiDHVmkWU3HR6faj7B9NZVk/v8
 ISRw8Og8YnD1uoq5AYmBY+6vx8IjbBXG6iHeybqvQbZ1MmTDB5jTnmAzXXPDV4uBrrKSjRouYCy
 VgdE08pHFsKsQCCFip8wTh32fxSYgD4AnfDPj5vKGXR++UMT4CNSDR15DxQtloqMmfZ4HhdXTq7
 pXQAeIOb3mj78Mq1uDeeY1vwJVVdqW6pYn+bfCyKZvTInqU2hyQEJFY9y68ArgBng/cNGnIXvwO
 PmqSxcOKUFbvLhw0JkWrVg+vOiLEbhR9XHtf+8b/nCNZwBvOP0tqddaxwY4tOyEnSU6j/L851Y6
 Z41rf1G3
X-Proofpoint-ORIG-GUID: cocKTd1PuhGtFIKvoNGlNg-Q9_ZGr8J3
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68c03637 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=ATudFdEghz8k9U3f8PAA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: cocKTd1PuhGtFIKvoNGlNg-Q9_ZGr8J3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On Tue, Sep 09, 2025 at 02:38:21PM +0530, Harikrishna Shenoy wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
> in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
> NULL pointer while trying to access the mutex. We need the connector to
> be set before that. Unlike in legacy !(DBANC) cases, we do not have
> connector initialised in bridge_attach(). So set the mhdp->connector
> in atomic_enable() earlier to avoid possible NULL pointer.
> 
> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

It looks like you should reorder your commits: first apply the DBANC
fixes, then drop support for !DBANC.


-- 
With best wishes
Dmitry

