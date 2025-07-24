Return-Path: <linux-kernel+bounces-744478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E6B10D74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ABA169D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C772E3AFF;
	Thu, 24 Jul 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xckxuzj6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8ED2DEA70
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753366805; cv=none; b=glGkWxFrbNaQCDFGrhv5bDQFTgcd/pD87C2gtgPa+xQe/Ezo6jLGZVE2OJ2zXfpWCwFm6Etg8YkA9mZWf7/nMX91ed2MNKJrLnaNtgncQF6Jz2L1y6mYLy6dl00Z8be6uzvTTK1VItXuALXMt7Ry4JY8yGPiYx2Ntta4NfM3ST8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753366805; c=relaxed/simple;
	bh=RB0MXSL9iAdyQfhytAVo156s7TbriQQimjTjISxShuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdbqzWbHGLvVT8er/ziTwq/6QEPkFM3JKGd4XWmhmz5FgE3aAFbsWTbFho9Qsseox2+kZMYyUMHv9i+sqANN91nNwt1RJ/mpPLv7OLS9AHOwWf20eDGf61zsn3oNqbILiHg61zNaXESwUnq5nmRrjFGkz9wfMdFs99J+HcXIKzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xckxuzj6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6dpdK028534
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=A+VdurEKUduQkz+MfAKRObdV
	YePeVHPl1wVvZbZgeJc=; b=Xckxuzj6GDcsD/3rzVHt9pBnkZoBD/6fEgbaUWmZ
	7vx1oTdWAS+aSMsCN5L5w3nHLUQzfMNpW8qeh1dk23Y7oR6z2xgwN+CqOndRAaIT
	FF4Ba2X/m53dxzIWPB8wz2SgsXrk+sogtrC2xcqsHKQZKwL+91Q9lXqK7EArbHdo
	nr0A/aEIIu6WEnvqgPzI5BUKP1D43Qm8ByGQ1GzTHSLVgVuwpiak/d4ITYRphyOY
	Z5wTfuQFX948UOU9nFQevWR2ayHkuDYLU0arv/l1zw0eDaEBjUV++XYRykTvmk/R
	FjigUunVkkwXNhBjDRH75Hgsgjmw6/NiNPuTnEvWqLqIkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483frk1awx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:20:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e33af599bcso164984085a.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753366802; x=1753971602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+VdurEKUduQkz+MfAKRObdVYePeVHPl1wVvZbZgeJc=;
        b=I6g2t+Q+vzXKoQ1Wfk2C/G05hEsUpojwzQqhN99PlrnTm8yBFNt4cuu3NClkQg4UY6
         GILyAqFiB77YKST7jAKEZ/jrevWX8lHrlpCc7yJ9LIflqptgLNqVIaKWdUMTeV0HlyLj
         BJVL0q9D7UdB+YNOPLX2gLUeY7lj5IiF7gtSSsHvMw+SgzOYuskRVQsNl5KvdGAdncyg
         fjSiXpGEYm9lkeOpRg6JP1mrVneQxUdZEezZmXuaZxr4jOuoYINQiIfQVorg2CwSvqtN
         Gus02IuPba6xuImw3BERBqiIK2xMP9Y3GlBt9bpmdLf2LWkr3TK0WUgxCI7zJNDLASt/
         IsMA==
X-Forwarded-Encrypted: i=1; AJvYcCXzFAnS7w4bJ7EUXfx9qGEAvSrJQovCS0App6Ky1AbzOkdhXkJxGliq2xV/AlJJQtB7Ec7cB8xRqLLILKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB9x69En/jKTst45kVL7/MFR5zEXY7hH0II9PTutfEkTHSW60S
	T9ejKlsvyF/TjvnEZdEzdWBU6gSkfgXCTNgL9kgWqU+XOFUBBX+jkQLrJ/bij/TfPfdkjfvVPIH
	0+j7LH686+ts8CMKQrx2pu9O5XJl+c9cMIJBuT1s+vUSI43pk7aQel8eDHwmIaX6Bq38=
X-Gm-Gg: ASbGncu8OM2fAlMGLrk9fHABaBYPhL/RXQgi43oiVwyuD5deJXq2ioMGbNL1/hAWCD8
	16PtHI2+PptVr7fK9CUxxFUwvXkpZ2ZV+mRVLbk5suMJMp3ZkSdBNjzSFCguKEk/v3x2hOSQ4ez
	njxQYROa4R8meBJ9zDEOmYySo65tTScza36WgMSEpuWov4jsCUwA7X8zLc2bfBohWI+syu7tODv
	8IEoSrhHRtOHIj3wxce8A6cMQ0jZPXx2AhwCCmb+4kVQSPFZpb+2wbY2/Nb9SC5PXS3o6kblGP/
	vEyFAnOy6Y5JtYwYDJ8LdO9433FxYB8awo+HUHJlkRwLuJq+7jQn0RksKLkv9HxqHphm4QXB5ta
	EJX96uws7H4aQCT5Klb8MA/KPAMErPzh6zcheI2nf3Yd6O5+NRQtd
X-Received: by 2002:a05:620a:a918:b0:7e3:46da:9e1f with SMTP id af79cd13be357-7e62a226f8emr851537185a.56.1753366801519;
        Thu, 24 Jul 2025 07:20:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu82FQZpsw4p0HB44p5QHytv3oARhOYGPxT+kbfN/+yl6AMnXI5Y2W/WXRiHc3PGuzslrCdA==
X-Received: by 2002:a05:620a:a918:b0:7e3:46da:9e1f with SMTP id af79cd13be357-7e62a226f8emr851531285a.56.1753366800903;
        Thu, 24 Jul 2025 07:20:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53ca2066sm375867e87.200.2025.07.24.07.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:19:59 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:19:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] scsi: ufs: qcom: Drop dead compile guard
Message-ID: <33dxc5kf4m2luijisbdzsxof5yi4hhrbsrfziqsbsqzm3xkkad@ivhyl5ozuyc6>
References: <20250724-topic-ufs_compile_check-v1-1-5ba9e99dbd52@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724-topic-ufs_compile_check-v1-1-5ba9e99dbd52@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwOSBTYWx0ZWRfXwbli1B3fjRSX
 7gcK7SMI0OuSQGRNYF0x+XbXHeffarUtBqiJrB1OUCTONIKQpI/zihSIR0l77vtErISbIFUSZm7
 KX+b2DKPDJV8JvGd3BYSBm3JargzG5J95dMaV0HISdpP3Q/5Pp+EHbAYE1xd8l0uiUVVQz/eKlT
 qPxIBUUT5cvTisWX/t+MfMNdjOy01PJnfmIAf074bLn07bBhZhFy0cNdavjclICAs8uEgsgzlzV
 2x9Fcpk6hUEHgjEwsWReM+WGPrMmBCMxk9ilqwttLXShWmS8cLtpWS8dz7Xd/Ffa3HcGzoOO9H0
 NxHfMQvSJC677y/maM1Y9//98yc0TJuMJCF4Pix6Z+jAemyNouISrFijCHr9bPhc65Z1l9XUpeP
 Dp85/piPOJ8jESRm7BkbrUy347XGqZ1eeE4Jc5+DgoHMHpK1VEanLWJgCnG+g0OkxfQhsSjV
X-Proofpoint-GUID: IaS9L7HEkm1aJXqecV93ilb04KwJvwiv
X-Authority-Analysis: v=2.4 cv=WbsMa1hX c=1 sm=1 tr=0 ts=68824113 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ts7gs6oRpwORAAbGo2kA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: IaS9L7HEkm1aJXqecV93ilb04KwJvwiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=918 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240109

On Thu, Jul 24, 2025 at 02:23:52PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> SCSI_UFSHCD already selects DEVFREQ_GOV_SIMPLE_ONDEMAND, drop the
> check.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Is this something that could be discovered by our existing static
> checkers?
> ---
>  drivers/ufs/host/ufs-qcom.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

