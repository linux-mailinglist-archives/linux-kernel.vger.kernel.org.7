Return-Path: <linux-kernel+bounces-879417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89839C230E7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F554EFAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE830CDA7;
	Fri, 31 Oct 2025 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aLMrBcDK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jp7n3XvH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24FE30B50B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761878793; cv=none; b=FrA8DPzF280Dwv9vPbYTe0klsyWlbYxqaz48wi/DHbj4U69/xW1ozR1orllqA7KjQbml9R4Geiw5jCYIfcVGbhVsW3oKO3psjG+7v66BrpgP0P8Oj7w+TYPcaaLRlhGmYXZATAYgJ0yFkoNR/x1HWboxk91cmOPVBckkA+Xk/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761878793; c=relaxed/simple;
	bh=Qu4QSbV2XtSbfDV8VqAU0A1+l5WwqdMrJdktutHmg+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TERQAubPSvTMcF2GLYsIvO7iR6FYZdk+oPs/yjbanJEII0vSJOBP80OKVk8EGOLGEaVqn6T1xbCuvxvr/x8S6JIRWlw9ItdqXU4uWaIvxc6L2ib9NxGUypI/+vlqwW+zx5TBdQXNHc6sj4totTgHPcPpCulPoPIOD3BwdJxssIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aLMrBcDK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jp7n3XvH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V1mfCl1571314
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2NFGqDp1m2CdSv3QB44B0+at
	avVoajX3Ebv3PN+tFIE=; b=aLMrBcDKOkjo9SE8gzH3PyCwxvTqQ5WjlCsRsxeW
	iW3xYgoQk851uP+2iX+G41FV1D7cAI4gV9ETn8BGE/SaOUSdmL9/h0oeVrN4SwfG
	wJif2mVk1aWNplgPl2By+lnc/Xhl3dlxr5HRS4LZU9reWX8uD3GJAGfzbXEUFTpr
	RLR0jIHxLHt/sFREFKftMHn+kFGCcQNKu+q+KoFv6htWLPWgc4XPVKpZsJ0gB21R
	+YhrImjkAsXtJXjE3KXKS516VHt6mtAz9mdCvNDURHY9hNf4/JFo69UfJ343oH4i
	QdIYA9XeX+EoSZUZ/Qtkkuocb+UQ1SQiIDI1x/WmgIZ9bg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ksc046m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:46:30 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e892acc0b3so43843431cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761878790; x=1762483590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NFGqDp1m2CdSv3QB44B0+atavVoajX3Ebv3PN+tFIE=;
        b=jp7n3XvHDb0IV//fb1NAzVfcn/1irlQw7xBIg0ECclmVgBn53h+ZUnLERIJX1ZmB2K
         +jK1P9cgAkVegImq18l1GhRjq5pFJVI4R8QbzaLc/ZFLUcf45Bt+dnEHXJRzgNU3R2pf
         8DVsjuRmB68VX4QB0jboszN8VYpg9kh7hphLZwnL0MIAPDkl3BxZxDF5h50LV8MVU3Xm
         H9nndQd7w5pl2fMo6Dq8UeItGKVx69GYzqeYDxX7/EN8ZL1F+i6m4W4Yn1sF8s0JQ4Vr
         lX+Y0XF/G/np0YGYN8vT2Gz4WjS5nLlRPiSxZ1HiCYShlqSdnMuPWb5+LCNK9Jls3gMy
         Dp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761878790; x=1762483590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NFGqDp1m2CdSv3QB44B0+atavVoajX3Ebv3PN+tFIE=;
        b=UuWliRxE+AMQhqOZYdNUbqvp46DNLX9tFsWUAqUDERMtdinlAiczlHqVBqlJL7u740
         D6iqywcKo+Xdv2k18rst942G/ETjRypyzId9KVvf5KcSqPFUYgtEwMTvv3Nq+33/D04W
         7s/kOzBkPID56Kdl67QwSg85gF9IT8YWS2KmUO9r+J4B+grx8+2HyaOc7LpuB1sDD+0u
         bASQb1nuLKgdF+Nga1zus9DrxPRBlilPZ0LVa0jxr4EtQ80qUxe06B/MYYUQdvinx9Lw
         FlAKWNbM5YoSBUE+IeNNZDkoRF7/95clk2xYlv37GhaDR37Qa1FzfQqVbo06HV7GyKEQ
         7JoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtXmdAXFF9hFg/DbBdzy1IKxzsoo61knx34Qlp0O1VWG4djly9JDq+PUqrb0TvjmjEqj/lWdqrgArdzds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqGC7azxHa+UgllPPoi/jp2yGuZ7stbBK89vEsWJ9AwU8VslN
	82mkqg8BapqwH5Ycqsh7ZY4hoOaMR4VnaXVXew1TC5u01xLcdZLrql7JhDIN866fYAfh1eK0OXZ
	uytdGvD5FfYAzMN8MlxQdAhkTAwavzJkaiKpaPOdHoCwBf1Q9IV7bVlUoUu9pQeDpP4M=
X-Gm-Gg: ASbGnct4X4cnUhOr0a04fawYczqnufokmmzEgAmmMQbnRfzcLA8nU1zKTX+W++u7vvR
	HUdI4bPldtYmKX2z9jWHbccFxtK39GQsX3c1i4Vd8T4FQf+PpsWSVcT8FbaueDpOmsqRQgsYFfs
	wlbzO9X72CE66eLkoCD4Yyn1cQIoMUuRcefKmyVauhBW42MhAWbMncXCOLDk0AVpUlAuhpFFaoU
	GA7gZXXaAdypz52MH2na4hLzZah67UhtSI1SeN9VJhxRzxjZcxX3ierBsCyM6B/ncvwKeSSUbH9
	zH0aNNriJicwqI8zeVylTog9fbm9IqV7ZnT5SJ4LtibHpa5anlCovU/8tTiO8ot3y3VECteEEBO
	rQO/L1leqpgEhusTAaJLEdQZzi8Xgd9Xp+Lrh+AxwQ+u2A8vHSTRfSIoL5ZHv
X-Received: by 2002:a05:622a:1b8b:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed310a7896mr22748041cf.80.1761878789944;
        Thu, 30 Oct 2025 19:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW+R7k4Z+WWJ9w992LN8TRCm5lm7xZV0CFcN/lZYH0/QcEjNEF7RkEkCbgI/lUUmwN9IKgHQ==
X-Received: by 2002:a05:622a:1b8b:b0:4eb:e283:9262 with SMTP id d75a77b69052e-4ed310a7896mr22747661cf.80.1761878789388;
        Thu, 30 Oct 2025 19:46:29 -0700 (PDT)
Received: from yuanjiey.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed352deaf3sm3405111cf.29.2025.10.30.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 19:46:28 -0700 (PDT)
Date: Fri, 31 Oct 2025 10:46:16 +0800
From: yuanjiey <yuanjie.yang@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        robin.clark@oss.qualcomm.com, lumag@kernel.org,
        abhinav.kumar@linux.dev, sean@poorly.run,
        marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: Re: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Message-ID: <aQQi+KA7KfibvhBu@yuanjiey.ap.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
 <omlhiywjr46ik6bj2aiutgcf4aifen4vsvtlut7b44ayu4g4vl@zn4u3zkf6cqx>
 <ad906eb5-c08f-4b66-9e37-aaba99889ad4@oss.qualcomm.com>
 <aPryORKIuSwtXpon@yuanjiey.ap.qualcomm.com>
 <einog245dsbqtx3by2cojyzmyctk2fffpwndwoe24puwqq4fta@cu6iiidxqgr4>
 <0291d0f2-483f-48d8-8c75-f1bbcd1ab18f@oss.qualcomm.com>
 <ehgdx7av3jewowkvtsqrbnsphgxm5hryl6n5otnapi4xneldze@gcwvpssisv2x>
 <aQGHyN19/a/tl0BH@yuanjiey.ap.qualcomm.com>
 <mlhohop2uifsdo3qxxzmuxbkjo735hdw6xcosvkmsx4eskfufz@5otklefey5k7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mlhohop2uifsdo3qxxzmuxbkjo735hdw6xcosvkmsx4eskfufz@5otklefey5k7>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAyMiBTYWx0ZWRfX7i1vL5YwIefP
 20IutnESCxn+9gF0G1/A/FruNCq1i1htHAIlcNu+esGY1qe4HtR+aIanAu+BV4E5rEDZ6heQcM8
 Uhh1+G0wIVNqkHqZ/4rxG50+BP87IQ0JS41W+CINbwcO57fiogvy7RiJ6xCOJdnwkcvQRrzNWOt
 ymRoDmDxLNcwBIbjcON/pcjmr+CQiyvd2N4xKSXi5UKiHGMv8/uR1lpp0JQtm6mQpaOl25xQIa/
 2YnYcI0QP/0tYTEbWCnrjNw9nVxZK+oZmOi4CFX15sXMyL5KP2SF/5TgtwZDloA7drphOTmxxic
 rsssXVgeAtln2td5/etbG/Ok1J4xjHuO33NDEV0rS7JMt6Gs0vJzh2DHSQu0j6iWTyc2xOE/vTB
 jth8eleiFTnUEHbonU2wnsjtBp69iw==
X-Authority-Analysis: v=2.4 cv=Q8PfIo2a c=1 sm=1 tr=0 ts=69042306 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=EkNEsoD3ZKdRnMbS8bYA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: RhX88uu7x3npjuZDStrtHLU9oNfwP7WO
X-Proofpoint-GUID: RhX88uu7x3npjuZDStrtHLU9oNfwP7WO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310022

On Thu, Oct 30, 2025 at 08:01:10PM +0200, Dmitry Baryshkov wrote:
> On Wed, Oct 29, 2025 at 11:19:36AM +0800, yuanjiey wrote:
> > On Mon, Oct 27, 2025 at 03:29:40PM +0200, Dmitry Baryshkov wrote:
> > > On Mon, Oct 27, 2025 at 02:20:26PM +0100, Konrad Dybcio wrote:
> > > > On 10/27/25 2:14 PM, Dmitry Baryshkov wrote:
> > > > > On Fri, Oct 24, 2025 at 11:27:53AM +0800, yuanjiey wrote:
> > > > >> On Thu, Oct 23, 2025 at 02:02:45PM +0200, Konrad Dybcio wrote:
> > > > >>> On 10/23/25 1:48 PM, Dmitry Baryshkov wrote:
> > > > >>>> On Thu, Oct 23, 2025 at 03:53:50PM +0800, yuanjie yang wrote:
> > > > >>>>> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > >>>>>
> > > > >>>>> Add DSI PHY support for the Kaanapali platform.
> > > > >>>>>
> > > > >>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > > >>>>> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> > > > >>>>> ---
> > > > >>>
> > > > >>> [...]
> > > > >>>
> > > > >>>>> +	.io_start = { 0x9ac1000, 0xae97000 },
> > > > >>>>
> > > > >>>> These two addresses are very strange. Would you care to explain? Other
> > > > >>>> than that there is no difference from SM8750 entry.
> > > > >>>
> > > > >>> They're correct.
> > > > >>> Although they correspond to DSI_0 and DSI_2..
> > > > >>>
> > > > >>> Yuanjie, none of the DSI patches mention that v2.10.0 is packed with
> > > > >>> new features. Please provide some more context and how that impacts
> > > > >>> the hw description.
> > > > >>
> > > > >> Thanks for your reminder.
> > > > >>
> > > > >> Correct here:
> > > > >> io_start = { 0x9ac1000, 0x9ac4000 }  DSI_Phy0 DSI_phy1
> > > > >>
> > > > >> And v2.10.0 no clearly meaningful changes compared to v2.9.0.
> > > > >> just some register address change.
> > > > > 
> > > > > Addition of DSI2 is a meaningful change, which needs to be handled both
> > > > > in the core and in the DSI / DSI PHY drivers.
> > > > 
> > > > DSI2 was introduced in 8750 already, but it was done without any
> > > > fanfare..
> > > > 
> > > > I see a diagram that shows an XBAR with inputs from DSI0 and DSI2,
> > > > and an output to DSI0_PHY (same thing on kaanapali - meaning this
> > > > patch is potentially wrong and should ref DSI1_PHY instead?)
> > > 
> > Yes, I check ipcata Doc, I see DSI0\DSI0_PHY DSI1\DSI1_PHY DSI2\DSI2_PHY in Kaanapali, 
> > addition of DSI2\DSI2_PHY compared to SM8650.
> > 
> > look like I should add: config io_start = {DSI0_PHY, DSI1_PHY, DSI2_PHY},
> 
> I see DSI0, DSI1, DSI2, but DSI0_PHY and DSI1_PHY.

1. From HPG MDSS 13.0.0 chapter 1.6 Architecture
I see DSI0 DSI1 DSI2, and only DSI0_PHY DSI1_PHY 

2. From ipcatalog memory map address:
I can see: 
DSI0: 0x09AC0000 DSI0_PHY: 0x09AC1000
DSI1: 0x09AC3000 DSI1_PHY: 0x09AC4000
DSI2: 0x09AC6000 DSI2_PHY: 0x09AC7000

Look like there are three DSI_PHY, but only DSI0_PHY DSI1_PHY work.  

Thanks,
Yuanjie
 
> -- 
> With best wishes
> Dmitry

