Return-Path: <linux-kernel+bounces-896567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E1C50B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5481898F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4FE2DC77F;
	Wed, 12 Nov 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D8Qus7B1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SAhR7Q3t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07410942
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928746; cv=none; b=qFCsXhBUvRWr6RL9nH0VEc1R+JkaPbZ83Wt70u+iZzFujS0tMgnsovh0KVL7PJZtwgD1f0DjoGnFLWYIBdhFWdsdkk+f+Fb5UzGqGLmw5SR7jjg8TLGOXvaGoJSXKf+jSX2w9OmNtxof0Ti1f9hwbbN9mZHPOHm8Ti3o2DZyYMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928746; c=relaxed/simple;
	bh=RDA4LzPk3maSgQAGPSWxx/Jhm7JGlhcxeaMTKnnn3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMHKsIbsk8MfwL2/N8/StGpFi1QXs2sZMpQbTQwID4VAuU2/Ns8aAnaJZyAmjHZ0lG78ueUsaVKrix/2F399Pfqtp+6gF7Gky/9uNCsORoKf1hGNyDHwDY/BXe8mLiyMwTacc9HPNBNt3HFiVU8QitueQM6KH6/U3Ec2l/Kdux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D8Qus7B1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SAhR7Q3t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1iCGC4076902
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZwTrPuuqQ5kUNPyeNuPlDMBg
	Z7FIia6QmEgvCuHsG9w=; b=D8Qus7B1RGEYvtVDlN2VKOXHMyXBYbUmEvK/aNEp
	XaVXd/NooKZiSJavgJZqlLReiotKGBekBbbvtwnNyX7JORN2XAMOm4Un2LRJzbtH
	8tj4kLy8He4AMBMvseb4C2dBvVEgABuvenGs6q9Kfb2udv15rfCetOWArWQ0JEmn
	dF2RZhcESxkQxQ8vJE9oAvE571wAHmJjlKBG4g+lFGvhlZm8SIAv7ewbOGO9PQBn
	1fC6Kof9VrbOBOhW9KZQYzfh6sgWuJi8hsf3l/VUWSCFdqJcCsah/2ZHzlBpq1Yk
	UgfEcpqujR7IMDzkpYzNlRvfdZHyTM2941tIYr+D1pPNnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acguagnq5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:25:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b993eb2701bso482732a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762928742; x=1763533542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwTrPuuqQ5kUNPyeNuPlDMBgZ7FIia6QmEgvCuHsG9w=;
        b=SAhR7Q3tIY7xydQXJYTLHyFIcDLeqWxUBWcw9MpCNCBgjYSzDn/CIJHeyiMLoXZyjz
         1odmV5bsqloakuJreNJUjuMBbPQOgABY7yEr/t+69XGyLYiHnFTXfh0FAymskRg5EI9/
         AgemSoZZVQwQJzClNay0ZRybEg+wBBPTgf+hPkBzYabD+7KUZnzBzxgo56rQ6RftQ1/r
         HG+iJfyosLt3IBTSRY2W7SaHdynhssWkwhcTjxJYcm2sEL2/y8wnIIJ0kznaoB2bgqr9
         yFmgahdabwD218/Tbhpg5qfRVU9cyI0KElFPsCeL5tM+/9OkfOUn5zRTjVukowZGo2Sy
         b4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762928742; x=1763533542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwTrPuuqQ5kUNPyeNuPlDMBgZ7FIia6QmEgvCuHsG9w=;
        b=BAllVJL3pKDR86BoxD8MtOUheAvfSUL8KECnoM/UIyzNf/Qoet1otxamWw5vvB432z
         lFbBCio0cIBkPHQRuTpGfUn6JlzD6SLGWklbrw+FDr7grSCOgtkpA+iLANsQ7zDiTucB
         asO0n3X1zMIJXLU1ejl3US+la2usNaUuOHFv1WmEh/eqm74GQF1nU4AiT64WNFOWWG4D
         boBc05LDy2b2zu1bQONovgfXwmBFjN04g0t4sM0mfDq0soDhn8mvF05YeLMOz7DRWYwC
         0WM0aBaQ/RCdSbFyTX/FwJUqJlc/qFWFErDViTfOY3fR7+sUPomi3QYgB1JfZe+S9FvF
         q55w==
X-Forwarded-Encrypted: i=1; AJvYcCWvVEsn5QSFVYUN1w96QGVXyJZvrdqwFZ4qZ78ENLLZ/9/B+ZIFGijHDrC8d6Spc8Igl1NoHIZU2pAr6Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivoUl17woS//Duol7dnzT2RNgV07woh4D9+uLqGovVIMrbmyn
	u3QIVD94rWs8j8U1WerMT+tES5sJb72KJvNRo2PK9TuBxWE8T7iZYw8KuqWvqhf/sUcX+Uj5XVN
	ra1+xz81cphu4De7nruoCXcdX6i95smv/Uzh6xvFLH+Bqz1CLVsaN0CeUy0KLxHA+UZI=
X-Gm-Gg: ASbGncsHsiLaklpp/JV5KLEPAbWisj0rQo1D6LcULe2INd5WzrOgOR8FzHKHyVCmB62
	LMl2LzWHBShGgg4D0fVxj7aI5mgZ6gNWgVrH9B3T17/a4qUGWPdEhnbgaj8LwF/t3M+862s55mI
	Pcj4TV+l/ScLJnSkf+E587ymmb6WQpiHDQaDh6Vc1rc3z6CwWBtSl+XTETwTZ5ByGYqNR1Kl1Bl
	McJjDgD9aCJj5Tab9ywAXAR8XNG2zn+eSC1t0YTa/TEDKdsEdZZO3psCKvnFwL17yxikhtSlRUa
	342xc3QQRFZVp+bKFDSe9yboLXwRXv7lGQKp4xAnqzodBb3BMEvqjRfbDF6jmvKsgRiOtt32pO6
	aHroyVP8kFH8UQ/qgnuaFxQ6UFvm7aQHvhKUa
X-Received: by 2002:a05:6a21:3384:b0:355:1add:c291 with SMTP id adf61e73a8af0-35909095f95mr2684089637.10.1762928742231;
        Tue, 11 Nov 2025 22:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7S/HbpcFUy6Id6iVkQsaUPl6jWNJy4+2pSyvWNLTMUPGF56hhKNHEj1W+hDgz/gITQ8wsjA==
X-Received: by 2002:a05:6a21:3384:b0:355:1add:c291 with SMTP id adf61e73a8af0-35909095f95mr2684069637.10.1762928741682;
        Tue, 11 Nov 2025 22:25:41 -0800 (PST)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc769e59sm17159899b3a.50.2025.11.11.22.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:25:41 -0800 (PST)
Date: Wed, 12 Nov 2025 11:55:36 +0530
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
To: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] ufs: host: scale ICE clock
Message-ID: <aRQoYHsOuCNhBmzD@hu-arakshit-hyd.qualcomm.com>
References: <20251001-enable-ufs-ice-clock-scaling-v1-0-ec956160b696@oss.qualcomm.com>
 <20251001-enable-ufs-ice-clock-scaling-v1-2-ec956160b696@oss.qualcomm.com>
 <d31e4bba-5438-480b-8d3f-229ac5b4ddf4@nxsw.ie>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d31e4bba-5438-480b-8d3f-229ac5b4ddf4@nxsw.ie>
X-Proofpoint-GUID: 3nhBQMYL73jSx-j_HuT76yJpx11RJJx8
X-Authority-Analysis: v=2.4 cv=ao2/yCZV c=1 sm=1 tr=0 ts=69142867 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=0fylSbPx36-Mud_k70YA:9 a=CjuIK1q_8ugA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3nhBQMYL73jSx-j_HuT76yJpx11RJJx8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA0OSBTYWx0ZWRfX3IImAn2Nlvrc
 8SUyefvMtNfotPHZsoo7aqXHO4gknhmGr++9Ubn7KNVUu/7tv9xh0MuUPBLpznyMKW8CcYtUCcn
 ORa56YTZVJNtlJjonsjzHajchCLR9UYYdvC174Uc2mWqwSb2JSitFnxuIuCF+hp9yry+gSZfmuo
 mwe6c1/55y63iJMLMIsmjGterMxVOBxcI41BLtMx3n9LrCPYBTaGlYciNljHWvSSYWaCr9Fc+K0
 Yr8/sSd8Axi2iHuRrr1G4T4ALFvF1NowSweaBqioaR7iYdQnsDL4rF8o5QPc+dQetC8SK5t/JsL
 81RuNTZeZ0KMc834G45v6cBt1Vm8yiy/Gh0UeEJgbkj8HozAwkHS56PrAAuzTSwA0uz5vU6qgsr
 qXwCJXUAQryJ2V9eDS9YFi2P88eC2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120049

On Thu, Oct 02, 2025 at 12:23:37AM +0000, Bryan O'Donoghue wrote:
> On 01/10/2025 12:38, Abhinaba Rakshit wrote:
> > Scale ICE clock from ufs controller.
> 
> UFS

Sure, will take car of it in patchset v2.

> 
> > 
> > Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
> > ---
> >   drivers/ufs/host/ufs-qcom.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> > 
> > diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> > index 3e83dc51d53857d5a855df4e4dfa837747559dad..2964b95a4423e887c0414ed9399cc02d37b5229a 100644
> > --- a/drivers/ufs/host/ufs-qcom.c
> > +++ b/drivers/ufs/host/ufs-qcom.c
> > @@ -305,6 +305,13 @@ static int ufs_qcom_ice_prepare_key(struct blk_crypto_profile *profile,
> >   	return qcom_ice_prepare_key(host->ice, lt_key, lt_key_size, eph_key);
> >   }
> > 
> > +static int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
> > +{
> > +	if (host->hba->caps & UFSHCD_CAP_CRYPTO)
> > +		return qcom_ice_scale_clk(host->ice, scale_up);
> > +	return 0;
> > +}
> > +
> >   static const struct blk_crypto_ll_ops ufs_qcom_crypto_ops = {
> >   	.keyslot_program	= ufs_qcom_ice_keyslot_program,
> >   	.keyslot_evict		= ufs_qcom_ice_keyslot_evict,
> > @@ -339,6 +346,11 @@ static void ufs_qcom_config_ice_allocator(struct ufs_qcom_host *host)
> >   {
> >   }
> > 
> > +static inline int ufs_qcom_ice_scale_clk(struct ufs_qcom_host *host, bool scale_up)
> > +{
> > +	return 0;
> > +}
> > +
> >   #endif
> > 
> >   static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
> > @@ -1636,6 +1648,8 @@ static int ufs_qcom_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
> >   		else
> >   			err = ufs_qcom_clk_scale_down_post_change(hba, target_freq);
> > 
> > +		if (!err)
> > +			err = ufs_qcom_ice_scale_clk(host, scale_up);
> > 
> >   		if (err) {
> >   			ufshcd_uic_hibern8_exit(hba);
> > 
> > --
> > 2.34.1
> > 
> > 
> 
> Once fixed.

Sure, we can bubble up the error log here. Will update in patchset v2.

> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 

