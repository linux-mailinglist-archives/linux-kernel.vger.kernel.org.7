Return-Path: <linux-kernel+bounces-768064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D03B25C83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A4C561D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AAC264A83;
	Thu, 14 Aug 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VTt6dHxM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FF25D528
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154935; cv=none; b=HII+632nHr6fDJtJ+PTfXJ1I2AFFgpT9RNDg3oW3mBgbHTRvvJfh5iQi2rivYWrohJVA5UrkIkpuoczkp7WUnEOqeiX9iQEqDjg+jAMyCv7yS3dm7lhvn6X3KVYLL4WoiGQz6pz9dtSWfs4HIcxNQnmZPUAvD0ND9wJxQf+kU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154935; c=relaxed/simple;
	bh=Lyxa5/1zntq0dfVNk4rbh9qz47lC1ZTh6Pytnc+GsqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMVPRCdFyudvaBEVa9nSG/920yQWEfchZ4XNKh4bZQf4s8T0GHSaW0h0AhIP1cLbNP0k/cWYR9QD2YKyymvNkj6kblcDXXnRWo6HEM8Vz3dLAY7l4Y98JWj7GkT70o203O7MPP2YlizPbRkXkcFEIr06aDbicfgdc9/AySDPz14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VTt6dHxM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNVRWr029021
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Iy5XjLJ55RnUenJqnrBHZVwS
	VIhZcPvSxAiSS+k4+Ww=; b=VTt6dHxMQ5uJCZ26BA7BTEZ8Yb5u5ySn5pbhKa9C
	w0GVXirFEI2J9FgwVdQd562ooU+7hjBn2SHIh5nyOgyaK+P21VQikgA0r+mmejbU
	W3Kg5AvMNxsZotpCQ/x63kbx7Zon3nl1+SzElpFWiUO6vmRxnmAPz8doYLwIQ5Y9
	lViJIdCsasV482a4StmPS5QcDNCiMxHkVTYYGqnyWPkInqIMSgVBRZF4PixGfmoU
	WSWT+lQw4IIBiVoX7NCaIQ38D8jBRzz6yJEOejA7KwePbZc4YivFWVc/drlj0BRp
	UsyGclWX07v5EVC84OWJeqQcRwBXoznhdkxqNpzQypv4sw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9wrpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:02:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bb3e22so19688941cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154931; x=1755759731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy5XjLJ55RnUenJqnrBHZVwSVIhZcPvSxAiSS+k4+Ww=;
        b=qFSElShZIEafjTRY6zscD7+KARNexQPUUc36TdOFJZL8smd6TEBGAWIPFSj0x/MuuN
         dqyTPYRQwoOQjAC7v9CojOsXKE5M9v0oZXISufcsroeN2LiopI22/S3b230psf5ER/Ex
         ZxvjRUTr4fx1bRf+tcTuhRGHDTg8jCsbOf5x3Ut4hio6s6X+6ximbab3dUOjr/Z1qm2M
         b9/IKYZCTnxjMCRFPv+HjTPa+LYieE/CsePULRqyYnsnDHtwYOydW/QPbkdIMs848xvj
         GzmeasI1OoFslH8N4tMfR7rnW8ckWpymmI3MDxGIMBNrZchtHQXklohibrY0MmwD3mNc
         7POw==
X-Forwarded-Encrypted: i=1; AJvYcCWDO1NBNGhF5B5xZSfVSgJHY7RAudeZZ7zuwzhRHrX/6yMnRMumZA2kx5A4UoTwAZaBvgX/sF9XnGy6gW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqA1YkZ6EvKj3lJJAVqvkVy7TrEELfJKRg/XXi33NpYTXG/K2Z
	iW3ITbWVQE2GZI6czeSLlD4yqT7ieQ5vb3RNftrbAQMoaVEjUfIfsrucNXpDqtSTm6h8xs+BQYQ
	joaFxVrs/0y+CKnhm481QEoAhaWQ2zeddeKJ1ktiDhuVGpuTSK/ILnuvbsa2AAz7ixyU=
X-Gm-Gg: ASbGncve0eXcFgFngaxdxgH7ioA1s5wB49LLjBmJwHaSWAKa00m5/EmUnkToPb/J+Qj
	erBmSRYBVMO4o27WgB/f4Z4EUiSvWW7jcZ3msoyU2ENKjPMd+Vmunb/rUEBb8vZoZupp/rd+HUX
	t5C+ENeDbzG4bN5s0efVruxUn9gCvxkZ4ZtC+47n8KjEMORRDwry5K8bVN2XQEdq+4NR7XAyWXT
	gm7VtYbZD7wSVifh/v1/2KgC3uSbkqqlxe4WSEATLQHa1riNNaEVziPzbd3Y5R1uvtCPHI8cw2P
	RHNu5k1Pf+mbgMtcRreiv307BYPR/aZkmzchVnzvAD9x4x/1r5xqULDJgeo84X0tOV61cS/1c0G
	W0NVUp4Jbo7+M8F0LFQCU+H3zOqbf1qqmmzyqOQbHTSkfEu10akyq
X-Received: by 2002:a05:622a:738d:b0:4b0:8338:30ee with SMTP id d75a77b69052e-4b10a920d45mr22489001cf.11.1755154931332;
        Thu, 14 Aug 2025 00:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHNJhcD6JQ708YwPrqw+PAvDxzp0+x7FgcO77yGZpD5y7vEB02eM4qqc2J0t07nBTkfxfSOA==
X-Received: by 2002:a05:622a:738d:b0:4b0:8338:30ee with SMTP id d75a77b69052e-4b10a920d45mr22488551cf.11.1755154930800;
        Thu, 14 Aug 2025 00:02:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm5481193e87.102.2025.08.14.00.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:02:09 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:02:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, thierry.escande@linaro.org,
        quic_vgattupa@quicinc.com, quic_kuiw@quicinc.com,
        ekansh.gupta@oss.qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH v3 3/4] misc: fastrpc: fix possible map leak in
 fastrpc_put_args
Message-ID: <7gen36c5as6fxpgeinc6if7ysex4ieswh2uhqqjtqlt37tj7or@ngpiqfyg2p56>
References: <20250807100420.1163967-1-quic_lxu5@quicinc.com>
 <20250807100420.1163967-4-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807100420.1163967-4-quic_lxu5@quicinc.com>
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689d89f4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=7U_eyDcXjddG1dUirncA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: J90bXlVrD-DZUVP20pr67pVD_qOBUa_C
X-Proofpoint-ORIG-GUID: J90bXlVrD-DZUVP20pr67pVD_qOBUa_C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXwha+15L5AeQu
 VNsIdnooew4ehVrjluJmmSgD5aw3fF1Mom+oLhxe4oOaztZpgTlJbOF3amZTjbH0bvhOP10+N+N
 zXdG4OPVLA3zAdGpL7DryoQsnosPTlQjmQ9S7wJttHrYxnFOmAfr1lwV4tjSszzsvelr7c7ME9y
 cuF0qtSUatAam2tZ/goLrPddDbhRWD94+1xyGHEXI/JOYuhGM6h59KdWBvrpZtNuWP5MALhjwV5
 0/9V6UUY09OaDcjkPjkSNpbC8vsw3YxNTb17Y59+PtIkhsvayF8o3fZbnMAoPS/PU6Jfnf7aGjp
 Bii2AqZPB2r2cOjj6T277NFOgbGSECcDwPMkk5fqpp4wnP+h88F8yOAsqXYT3fKATQuuGyJi3lQ
 HOtOY3xv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

On Thu, Aug 07, 2025 at 03:34:19PM +0530, Ling Xu wrote:
> copy_to_user() failure would cause an early return without cleaning up
> the fdlist, which has been updated by the DSP. This could lead to map
> leak. Fix this by redirecting to a cleanup path on failure, ensuring
> that all mapped buffers are properly released before returning.
> 
> Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
> Cc: stable@kernel.org
> Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

