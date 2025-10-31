Return-Path: <linux-kernel+bounces-879420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862FC23105
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B643A21E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ED630CDA9;
	Fri, 31 Oct 2025 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eveHNNsV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZNBpl+l"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3011CEAA3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879063; cv=none; b=b4pNvum0WN/hVhT7fRd7zGOiNszrZlQFT18jHx7JVt4/McHlbCOhTYfQI1m/eKn5MxQIbNeWKCaXj3hfii/nRmxpvkq/HSVBwySKYos/Ia72P1es0qmxunE74tCpub75YO8wfLojJZ6J9TYmQOnCpHcp+0+MGp5Xy5m1BN89IsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879063; c=relaxed/simple;
	bh=Or3vgsdXxa6Y0TNB6OsBk+vFfGuI2hIQ2144RQpNTqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMr/vkAJZELOvZp+03s6gb/OsL7E9NXdPbeI5YHOn7eKici1JprhF91YhquaHwXFERPfRiHikkX+HW87wCDueF+wzoN4HPPZoMgFS3G9FL1bdV6xwHRG/iwtRYdeb99sgA3zIhg5LKOmTD3VdICHc+6kCNIqUnkw/iVDN0ocacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eveHNNsV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZNBpl+l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UIcaif3116645
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DsJkS4Jj0YiOEfhK6rX+s7mE
	DdCGFC+Wm4+5HWL4rHQ=; b=eveHNNsVfcKDk2mAiXSreXJVEOwKUUuuY6Zts5Tr
	5AESW65mOBYtL7nwuX53K71yGXaxATGqw94J3pUygtlsJHBtQs81RuBEqqXujSe5
	HaabpV7FW9xwhAFIua679dZMrJ33wNgs+vyLMF217YN3vM0pgUl7AMiW04OYP+i4
	AbiiIOFpB0+ukr/+mnEcD/OmcjcNfZvn252BCCMeo8q1PSXQR3sj79AWm0IW6O54
	H3dFQj8yPtcC5X6W2BOPbu8TynatIJn1AdVwX7w3PQikCgIrdyFHyXmmZnAub0C+
	m1udYkR6Upz9OHJhQyQsc8hczsbEEAZYtUYVZ9xekJXoDw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a45b42nuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4eba10ad6e1so21952961cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761879060; x=1762483860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DsJkS4Jj0YiOEfhK6rX+s7mEDdCGFC+Wm4+5HWL4rHQ=;
        b=jZNBpl+l018Jl5Xjb7mVoOTRimo6FuQJZHNe4/gtEhOVCr2qHKOtw/uKD/MFSGsoou
         D5MLZw8Urc4s+6ZPjR8SXrbvWvFs7LQEdoVebRQ8mgcYEN5q3yO72ZVfXDg7RsiDC7Hc
         qCm0zfH35hmr7n/OOZArIBMmS6Z8nQuUJ/j8RXqQoyfTaHCd+HHFUi296I+SVPC3Iu31
         VJKHskgQwBsW/75iTCimcHY/MOEtFBAk55WI+h3SECmk5lSBxWpYe59fPV8hP3CKSUkX
         Pu+J0FVz97tTukKksu2HSti4gbDZtdveD5bAOXB6c4tBts0HLQLg36hxifV8YUmPRTma
         MrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761879060; x=1762483860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsJkS4Jj0YiOEfhK6rX+s7mEDdCGFC+Wm4+5HWL4rHQ=;
        b=UJGNHbAQw5SEAoTX8YlrBe5x0DXeaLMeS9ah2nDw1wQkgMPmW3jynCTt/l/W+GRFVn
         qw1q6kIu3u1Jk0HRqta5qcx26gTqU0cvknB+8IsGPhuQhBmoYvpExJks1m1chH34D5zT
         p4quQ0ZoO59nJVeQErV0LQ9u5NKaDrGYhPvyRbrlAbxKsi6CcT9yAdRjv4Flm3610fIu
         s3C6uCANilVhssFrE6bpWZbdpD2PL1usbgDpD5BPnFC8A6qHxK0t6rH71YrhWB3aG3ai
         4goQXc9rp+oHYjljKGlzjkicGUtDKEElMCdsjB+ZBC1d+ANRqsZ1KdELbnWNuDHV8GYG
         QgBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlPTIOr5r4ssJFGAlDbko3gl8/ZjYGgeJojOL6phiCWGSjTQZrHX86HoV0LzJfkBLWdiBkNvdXUVfRBgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOdC6WFssmWvTDY3ZJZhAGt3Jl2DvYBHLxmIE6SrokMcmL3LA
	jEcUw15o7vRhZ7i1X4bGJNLazbgw+Nu6jKlb/zZumGOSj1G4tc3pD58MDeSpPQrcDr6MGsoqa4y
	yqdGKOyzDxE+fC7J8zPBnolrBQRThcpofstOcaH1CwqSBOGrMob0uyh0/6dtMq2BwG1k=
X-Gm-Gg: ASbGncu1Ofzsmu6un39bg45V5UTvSHVPsXHN4joawv4OXJEJTFsPB0Amt5AYGjKMeUx
	ppBZDTWNrAc4RVnCMnu8c4saztwus8g+oKWcVdaKFDfu7CM8pNq2xQ4/rFjzWHr0P7yheEGJT7q
	QjTww49U1W8UmwRhWKD9CdDGFv83ABUT/KMB1Bpf00gfQSTMynCzAX56hpr2zEmIAVIwRhKfLCg
	Dfk8xczqAsAOuADwmVNWWCoWdz8Pw7HFV9zdBHCpLwG2GqOu6lSSTBLKwTYRCse96Ji28SDkWeI
	AKke9+9WAMLjyuFfim7KmicjuPgHtjj3bkv4iCb5CeGnYagMa9SeiVVFavyr6VExYlIqz5Wx74a
	oPAdkQZCTU+9RjPJ9evgPor6PokiwQC6GFFvpwkZM60/e0E7o+f7d/+CWnhvI
X-Received: by 2002:a05:622a:250f:b0:4ec:f5cd:871e with SMTP id d75a77b69052e-4ed30d84c4dmr24792431cf.11.1761879060384;
        Thu, 30 Oct 2025 19:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXYqZxTVqoWzxiWk3B/+KdG7WVS4s1P0rx3pIBR/sRe6vbtf2x7h6Rv+eqmkdkShyGqNrA6g==
X-Received: by 2002:a05:622a:250f:b0:4ec:f5cd:871e with SMTP id d75a77b69052e-4ed30d84c4dmr24792241cf.11.1761879059921;
        Thu, 30 Oct 2025 19:50:59 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8803606f2besm3522226d6.23.2025.10.30.19.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:50:59 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:50:47 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 03/12] drm/msm/dpu: Compatible with Kaanapali interrupt
 register
Message-ID: <aQQkB6Ma2z3c6iyh@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-4-yuanjie.yang@oss.qualcomm.com>
 <nfekr4vi34ftxzyyf5xv4tsb5cr3tokiyfkerypqjf26dos3uq@42wcn6ji7nnb>
 <aPrre+WXogSZIE7L@yuanjiey.ap.qualcomm.com>
 <st53uwtdow2rl6bvmfitro2dmodxtzfnhyzon4xeeetkkwekxh@ewlzkelq25wm>
 <aQGAvLFkH80Id3p3@yuanjiey.ap.qualcomm.com>
 <br3aukcmx3p2mtowqglcuf77s5xfnfv3eisjexabxhjzigkjno@wk7sqptjn43a>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br3aukcmx3p2mtowqglcuf77s5xfnfv3eisjexabxhjzigkjno@wk7sqptjn43a>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfX+4IvOPeq2qBB
 l8MliDRTruGvx/BPd/WmN72XvCnW7qH8edwE+8fEimUlXcjfude7Wh7VrlYzoOz8Jq4Uho0Rfjx
 QcXShHerHLwp4v6GKeCPaEi9++SlTSo95SG3Y4THEh9He0XZPvhzI0+6Ewoj+t9U0qBJP8fCIqo
 LIbHo11IR24ArOJbArCP5Pd6sTOQCT8u8PjfSNTuuwzqVMYjVdF4eA47QbMNw1siYQb8vf27avJ
 q2A9xqlTV5NWLuFPJW+ROeMjKRw3w8IKgUZlKZSazmeWiCbGuHOcfMdxSuSQ4DBWNsf1BMrmAFw
 QkWlOGKtCoB+4epQ1OvNfsEiexTh2c/TPn0Jq43mbQaZGJ8yiTGHGqQNsKlDDE1gNTDv5Riq+QX
 1n632bhayI2noR0Uy7rwMOZIiCxGXg==
X-Authority-Analysis: v=2.4 cv=KePfcAYD c=1 sm=1 tr=0 ts=69042415 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=9FCQf4pbOLePcO8AN0IA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: NH-e9QUxRgfR8phe_Bl46g_5sNL2bFzR
X-Proofpoint-GUID: NH-e9QUxRgfR8phe_Bl46g_5sNL2bFzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022

On Thu, Oct 30, 2025 at 08:02:13PM +0200, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 10:49:32AM +0800, yuanjiey wrote:
> > On Mon, Oct 27, 2025 at 03:21:33PM +0200, Dmitry Baryshkov wrote:
> > > On Fri, Oct 24, 2025 at 10:59:07AM +0800, yuanjiey wrote:
> > > > On Thu, Oct 23, 2025 at 02:59:12PM +0300, Dmitry Baryshkov wrote:
> > > > > On Thu, Oct 23, 2025 at 03:53:52PM +0800, yuanjie yang wrote:
> > > > > > From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > > > 
> > > > > > DPU version 13 introduces changes to the interrupt register
> > > > > > layout. Update the driver to support these modifications for
> > > > > > proper interrupt handling.
> > > > > 
> > > > > So... Previous patch enabled support for the platform and it has been
> > > > > using wrong registers for interrupts? I think that's broken.
> > > > 
> > > > I want to express DPU 13 has different INTF register address, so need to add new
> > > > interrupt array to let DPU 13 interrupt work fine. Maybe I should optimize my commit msg.
> > > 
> > > Make sure that patches are structured logically. You can not enable
> > > support for the hardware if the interrupts are not (yet) handled.
> > 
> > Kaanapali Dpu interrupts: 
> > INTR_IDX_VSYNC,
> > INTR_IDX_PINGPONG,
> > INTR_IDX_UNDERRUN,
> > INTR_IDX_CTL_START,
> > INTR_IDX_RDPTR,
> > INTR_IDX_WB_DONE,
> > 
> > are handled by irq handler, so here enable dpu_intr_set_13xx. 
> 
> You have enabled DPU 13 in the previous commit. And only now you are
> adding support for interrupt registers on DPU 13.x. No, that's not good.

OK, I think I should merge this patch into the DPU 13 enablement patch. 

Thanks,
Yuanjie
 
> -- 
> With best wishes
> Dmitry

