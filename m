Return-Path: <linux-kernel+bounces-649212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 609CAAB817C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 10:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A14C6B24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 08:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449902951C8;
	Thu, 15 May 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvZyz1WA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99A28EA46
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299174; cv=none; b=t0Jh1jK1vSfdaPfmyjSlxW/KHQDT/3jIlDjhmUB/ReHTE5hZy9yVkXzG2wwK6YfPOxFt/hK1GduXXQW1w/eMcMLKnH9nAsKRRzKPrcoP7u6JF5ZXGpf7SAeaJcejjfbNDOXHUqhq1W3Gi7ehLDqhwMGnSgtfG5BQY0uPnIeIQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299174; c=relaxed/simple;
	bh=FI7sGTrB08Zo/oscENddwqf8I3VuN6qo18yWXr+NkPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxcbaq+hgWeIJjghK/jMpi+cB7iPcbAMjTU2adSPVhsVAlih2z/gyKEVukwbPtj00fEEkedCzN9iZuvA9fBUM/YAMru+XWNJ/WW0jqNWRz3Yvs3Q+Dp6uiYrRK23feVOvmY1PTsXxiK8x7foZCvxi91/in0XMhPef52tevAZn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pvZyz1WA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EL4NVA025420
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 08:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hwaZDQYsVUdsi74SztNN08gE
	i0Qf+CiwpH9GUcd8v0w=; b=pvZyz1WABqrH3iWFcaH6vQ1u/BofwUf+zlSTmbca
	/dtZ75XMShxjLA7z3o2km1eX32eTFN3vj7WWo64gD97nTJc5Iq5VrS9M1fKNeqnV
	L6aaBdTaCEvItdmB3GwXe2Ko9erqm3IasMhQOE+BBz6v9GC+TCRcYSs1OFL22qfx
	sEIXlO/YIHA27Zrt/wlS0uRU011F2tM8BKF9AvgnG30bRL2s2pbM15YYTP/dajJQ
	ekTECu0A/5rS8GyIb8H5UrnAVWTkdx9V5j9i/64Uls0XU8Fysev5EBPC+k6F+6Rn
	IC7iaOxArCCBDLRUCsQ46y2SOYLHldXTjTK1MZS0/eJr9w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew5emj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 08:52:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5c9abdbd3so67198185a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 01:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299171; x=1747903971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwaZDQYsVUdsi74SztNN08gEi0Qf+CiwpH9GUcd8v0w=;
        b=BLeFqJzEoO2psqCdqyiCg0u2purFi1GD7kJTEftL+M/xoEK9gdExQXkCkBXknhyBgJ
         XHhTYQdwVaQcO+78A8HwEDagJN+tL8jloX4qdyDuP4G7N5+YnASv6/i/Y6hld/aHWHne
         bo05pvcadKlmPXfgKhfiuhENKdq5qvOD72HIu5nqIOd6z1+mPUjNVpJi2qtcR0z6MU7o
         X6LCk2EC2rZMo29q1GWyXWUilLPGWNs6f9P2KB5KKxQjC7BzkMaUF+sdBNhg6wOnjSiu
         JusB3rGlJg7Vd/TyZoWO6Z29kGoB3mWducs+o0tjetNwzUl9Ng+ULdqU+iFA07xKqLB2
         B60Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEFJJTCYBptIffebRqYHcKmfH/8ZViJhZBpTfURf01Yl/AXxL+9jyz+XUjMN0MPS0KoRHOBqZzt0ehMi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQlmz2o5IFGVrPG+pDM/PeFuDE/d77mH99lonR+PdCP4MFTr9e
	NlqlWOAhdlcIMyrh/he/iiyfH9SqSnj8LpEuWIBDzEDqtbJkn9njF+j/HFmTa/t6ishMzKtM05U
	yowwC/UWvq6G2+jtbzaBYpW7uuorNdx7p8GNhYxdmZYj3vZ+wiT2J+F4iLK2sIpM=
X-Gm-Gg: ASbGncv/G02e+5rsM2GcWetS6t3Ywb9Pg2QkkU0epi9Uc34lnFhIfGq04V3XaA39X/a
	BBI6KL688lugGDNhgidE4Faz2P/AdXkrZlsZonnNJu1cfTrAtVICBBzvdlQ9WrlGq812GZN+9Oa
	jJ8J/G/AKRI30fJ+6Y+78J+qPkfksFAkD5rmTEIzyNzT+KeBO4RU3PfhA7rYgrUnY/LHxFkk7fO
	0YJHkgtThPcvgRDeY4WaDCFM6Vpyd9OXgmwWBKrtejx05sF0akLcQe5C9IHRrCYFR+VM+GCSEdY
	7ZvCbybdZCqoEnphQ7/CCqVjMDAkpXZZenNmVU+WBMk5aapORvFcpsHTaFzNclt9J3yxtU+3x9o
	=
X-Received: by 2002:a05:620a:c52:b0:7c5:464b:6718 with SMTP id af79cd13be357-7cd2888faf1mr1253264085a.54.1747299170893;
        Thu, 15 May 2025 01:52:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ+BiR4gB9vfsEDZ2lofj7FH/2yViqW+rJhsM6lLhCtfcarFZ22RLGIEcYHdLuh4PfJ1Riig==
X-Received: by 2002:a05:620a:c52:b0:7c5:464b:6718 with SMTP id af79cd13be357-7cd2888faf1mr1253260385a.54.1747299170523;
        Thu, 15 May 2025 01:52:50 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc64504c1sm2555886e87.52.2025.05.15.01.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:52:49 -0700 (PDT)
Date: Thu, 15 May 2025 11:52:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com,
        quic_bhaskarv@quicinc.com
Subject: Re: [PATCH V2 1/2] mmc: core: Introduce new flag to force hardware
 reset
Message-ID: <rkmqeiyha2wldtm64ndcs7hssqvwsrqr66kwh6w3exbsyc6c6n@xhqdh65af7hx>
References: <20250514111155.10896-1-quic_sartgarg@quicinc.com>
 <20250514111155.10896-2-quic_sartgarg@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514111155.10896-2-quic_sartgarg@quicinc.com>
X-Proofpoint-GUID: MNJQGFTrjjGZmLxSuUFj_PIFMIAQEdoo
X-Proofpoint-ORIG-GUID: MNJQGFTrjjGZmLxSuUFj_PIFMIAQEdoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA4NiBTYWx0ZWRfX6HXllDN+1L9i
 K6XZydBGYtGtyGM4wOBS0bQTjQoi8P+x41GcPIvqY9T7Kfhw2APQ7X5Bfd3/byYgK+ykVgRwiaa
 nRjHdBylt9KE2Ddutg6FxrBFwtJSzxgMk3STJTzFyzaC6eFbzJ0Kei+yHbVw8maJwOIsdsGhRnD
 BJUC7kvIgCPvauFNv5gwE9K6edlAJgnOnL505d0HndladpyTNoaARn60wQll69BtkVAW2ewvN30
 tPiK+dfeD5iQ08o2b+b9gGYpc0rNoXXufUJP9TdoU32aypc29DQ4EESo7LVbkxP+q9QF++8oeC7
 zULz4mDkVSlyZ1fxtvjeBWxqpDufxC2wmGxXNejH3CZODRTCZtFLcqAngb7ba1jrYI07Nng1ZQN
 gw9AwC1kfBA7VY5Y4ySJpC9jOLet+Ak2htTsVMzoKAp2qm1Zs6IGqQ7rWav66876/IT5FJ3Z
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=6825ab63 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=QyXUC8HyAAAA:8 a=Dw_yFD_fkBKW1skOv8gA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150086

On Wed, May 14, 2025 at 04:41:54PM +0530, Sarthak Garg wrote:
> Introduce new flag cqe_recovery_reset_always to allow vendors to force
> hardware reset during cqe recovery.

Nit: CQE

> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  include/linux/mmc/host.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 585c2b274d98..dce2fb762260 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1622,7 +1622,7 @@ void mmc_blk_cqe_recovery(struct mmc_queue *mq)
>  	pr_debug("%s: CQE recovery start\n", mmc_hostname(host));
>  
>  	err = mmc_cqe_recovery(host);
> -	if (err)
> +	if (err || host->cqe_recovery_reset_always)
>  		mmc_blk_reset(mq->blkdata, host, MMC_BLK_CQE_RECOVERY);
>  	mmc_blk_reset_success(mq->blkdata, MMC_BLK_CQE_RECOVERY);
>  
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a90..d686adf75293 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -554,6 +554,7 @@ struct mmc_host {
>  	int			cqe_qdepth;
>  	bool			cqe_enabled;
>  	bool			cqe_on;
> +	bool			cqe_recovery_reset_always;
>  
>  	/* Inline encryption support */
>  #ifdef CONFIG_MMC_CRYPTO
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

