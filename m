Return-Path: <linux-kernel+bounces-818609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6236FB593F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5259165E85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F232FE589;
	Tue, 16 Sep 2025 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXYVQ8sC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474E237707
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019286; cv=none; b=ZsT78lY15V0abOgzvv/F2p3G7O7MrKyaVAkWdvEWwCXiq9mn+6786rk52pVyxLBtywVC00DQXLk2/aUvX/+3FLH0DdozQSrSfC1vAzBGoHy/bGSUeuA6O1pAkjRAAoJ/pcOggFMcov9BdMu9ZlTCqLt8n2sbKQhj+XVFou/tZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019286; c=relaxed/simple;
	bh=a3c1LzObWSzSsGNkduF01rflovELB97mhrlBOV+zEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F414xcoU4ca58cqhs8pMAQ1JZ9nWhf6B3S7oH5DNdnP6Ko3MjviLPmyYHC4noFbIr3Kf6uqy9x6ek9UdWHieJH2nd3+WdOhVOjhbEyhXg102CMzGJ+7PoJDCHyQs9w9PYKd9YLko9jugft/2D0D1R11r3KGgFfdlmx1A1DRAxM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXYVQ8sC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GABOB6005605
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tPxYdKKHOLmFp24yF9npg0nR
	5nLkrWcT5aWJm8/6HtU=; b=oXYVQ8sCjBK4eyhH4RHkWvbYitkru8CU5/kAhBr2
	PntKd7q330v4n+f7gG3VFoBUVuOBzO9pN/JtemQJ0UULunk60PV2KBmhtZdIdQiR
	UK0GSNA7HzbK4C0JUzuOcSUTxpqDaiE3SxbGJxrOW424xQf3O+cKDevLFirYg2Rt
	/+bpR0fxVzNFthRQDGqu5SKdzhbT7YIRypFoDB5of1JqnrJTQ6n63w6ERqEk4Ikc
	yIVOLTsDcxySJZx9OJUCWn89uAi/APxCRklYJQO/+u/YDDTuB/1Qf7LNHfVu3WK1
	zi7gJXQ5ddy270ZhVsu65KQlHz3ZgDiauXumqvwSnwwFGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u58fxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:41:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5fb1f057fso76275481cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019283; x=1758624083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPxYdKKHOLmFp24yF9npg0nR5nLkrWcT5aWJm8/6HtU=;
        b=kN3Q13zQO7kAFptiHO6GW0CSOzUwBDVOvRsSx9E96AwuoDJ+8ksUW4tNSBGGHRvOoS
         S5w0j6Mi4Y8VowgeYf3yk0He76scuuoLw6J2qJ8F5R9P1ULbgKp1n3gNUNhGIRyRrYK/
         cOvwY6arGLGur+PnLEcAr7MkhWZNmy1gHImNtkBDlx3gCVkSYQBlsanj94qmdMVp8gOL
         luD9L3pOHq2er1Ao09HzwFrWAjXKcJnFMU12KAevbISM1QKd8tVMHKfD4TPdqW7zZB39
         YQ+OHqdCLWDk/G6Lr6s58vo2RKsgBNiZn8UhBq0LiMQhAbbPPSSNPewex8DX9Rf+4cHe
         fSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEMg0fWugcj9+93Njp/6M8V54sNZbbkb75Ad3DdbAp9UR0i/vAq01poRik4hdOvBJ/zxdpUumVULHvh6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydU56i+yBcl4BJf5iBQms0ShnDjNq+MsflT71Z6OEH8Dsq1APM
	ry36khJX1kbl+VSntYTgMbCBd6SM2ooWpcdH8tDlK4o7U98GYblT8pMB+9Qsy0gwK40RD5ZV9ZV
	C9FBft6/FWh3BsEEIteqwcGgHDrhIkcI86GNgLfOvOIa0B+lUoTTECdrX5XZkfj7bkts=
X-Gm-Gg: ASbGnctbvDu9WG/DyvPyeekx/Vxy2240Qbi/hNTF7PgcaIF0DdNHU+vpSX1//oCSo9g
	Lm4dn/+0Ncuv3+JwA0VxDZg034w/gF2qWHb2MMoKbxVl+LWPg8Dq4Os+1rcJ86jtcLXTPYojJOm
	k20NCP+hqGII+ZsHIyNPQbn2S5M5GI/6k9jS0BWUYGSf0Cy9gvY5nftgsz6PkqXzrGiF3CP6TZC
	dwlJ/3RUn06kp/gsdr10Sbq1Z3K78gnSTTOlfz17BfFYVSijYisE3PU9Vq6oNjcAc2mz3rIlkRY
	Hzcb2nZ4ljw9ERDyfYYxOfIsJV/jmAiXnY9HYTKMlJpals8WzjWA2M35iq1Nn4N+SUHlvIZccKH
	KXS6aYghBps7L3QeWeStnmenzR9KLJ3RV3tbqvTef9w96tcLAm2OX
X-Received: by 2002:a05:622a:578c:b0:4b7:b192:1443 with SMTP id d75a77b69052e-4b7b192147bmr19834291cf.59.1758019281921;
        Tue, 16 Sep 2025 03:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErjF4yYxIondd0648SYuAvsJGr3H923yp/I22pyUDjDIWthCt3BxpeK46u/6PDovn3Xr2cDw==
X-Received: by 2002:a05:622a:578c:b0:4b7:b192:1443 with SMTP id d75a77b69052e-4b7b192147bmr19834101cf.59.1758019281418;
        Tue, 16 Sep 2025 03:41:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e5c3b6167sm4417508e87.25.2025.09.16.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:41:20 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:41:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 2/5] drm/bridge: it6505: check
 INT_LINK_TRAIN_FAIL while link auto training
Message-ID: <r6gmk2xlzczyzrpsrnlo32r3p7cd46qc3clnvbb7vwqbghhegj@s4hezvst2ro7>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-2-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-fix-link-training-v3-2-0f55bfdb272a@ite.com.tw>
X-Proofpoint-GUID: SY8yBwElp3IgOA73eILsGFJO8LaW1w0O
X-Proofpoint-ORIG-GUID: SY8yBwElp3IgOA73eILsGFJO8LaW1w0O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX1I8jmDz9nWFY
 ySSnn7xjvwhCuHx7ncCodScllJt5om2vD9pD09orig8oPMlZltHXBg0Yi2M0ryroT96/U2DbxQX
 6zL+YEUjqecBBPMqRcS/ioRftukAdX7iCxLV/FD28VfYMgFI2QmaZWkllN44xxdTXBezZYGIiMc
 DWnl5ZbbRcbEWYCphGfPITafgdPrc/FSmD6OZ+O9NUcp5DRKHaP1oOLW9XEWUD+Q+MjNwaPu8NN
 j3Kxi//bjwzwqkixoBT4BC6UiofJSfEb4vBJFYgrOJGB2msR+XrUqMuXINHXnamJgwg3FboKloj
 gvvTLl2aIsuX4/vNhsQaOhVgpPkL2UE2b4nTbfpZ3/tgHhymaEaDo4xmkjzjs/nLiK4G/YzuT2R
 9oF2T3L/
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c93ed4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=_LDb0pKpX-kM06tvKcsA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On Tue, Sep 16, 2025 at 12:47:42PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> When start link training, interrupt status INT_LINK_TRAIN_FAIL can
> use to check link training fail and no need to wait until timeout.
> 
> it6505_irq_link_train_fail() remove from interrupt and no longer used.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

