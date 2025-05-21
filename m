Return-Path: <linux-kernel+bounces-657477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E55ABF49D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 14:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A753BB572
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 12:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DEE267B00;
	Wed, 21 May 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdLtfyzm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53402265CD0
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831512; cv=none; b=GdEXnhOOJqTo97RnzxpymY5hF0sZptSa5DIEfQLbipuEuximPjm85bNIZx2Vayukw2T/94w2Oh8HhoRUi8eGGhJ78WmWEfxboWXxPs4g9qV3jweNjnXchdiS58+BsZlKfIb+oAA4eUQGaSdHmQCMd3lrAvO8o3Z55Fxe/v9DwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831512; c=relaxed/simple;
	bh=zkGUkrSlpCDvrhHcI1g4oFe3ljg20Lkj9XiFeqwuju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9JinmUKtouaUYRPBoE2o7HA9OnUlpKL5VGnELtAaE9dDB5NHy0+BeM4/DNiXvN9CHgxHo25GnTA4bUTqyPTt4ZzLvuD38imIxGj+mVTckyPszBCQbd4N64nwgYEmobB/5XIHwWqHkv6p0O8Jw25/Oo9FIdpbyde6/E+mNMxrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdLtfyzm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XIq3031676
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ks52ly5XzSYN1dVT8m4NLznvkKylPvB/qklENFGmQ+s=; b=IdLtfyzmj4AkBBcd
	pOsyTHt2WNba+cTJwRZHEVuXYR+0O+I1Sr5W/TCKfs9o6qFw2fvhKbTBZXvKtDag
	/hNxDYBjGD2CPh4/KDEBmc0nbU4jf/su49/+iaSwa2VOO1BeyxQOQkwpPTKE1AN5
	9JHzIPEd3XuQAzdZtvXAU7bXtHtamGCvjkmVr3jeI80PWOKSqX7lTFR0VyYLhL/c
	NLMSoz7DNf7BCtISBaoJqunJ1pAVv3nz52kDXW0bP+GmbeWesLNRJ/MfLkNgdsyc
	jsNK3TJ/J7oCI7uHeuz8aa2DWbNVeIaB2DM+vc8APWxbuWx9it9S+LXWyzgP0zTl
	06WXEw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c21fa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 12:45:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f50edda19eso100640256d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 05:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747831508; x=1748436308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks52ly5XzSYN1dVT8m4NLznvkKylPvB/qklENFGmQ+s=;
        b=WH4pK6RTUOoQPlGQWkxQD2KuW854gunV+CSqRcZjDQFNkB7DL32yCJ/zsf7NTcVrL/
         MEOXKeBfUnMC9gsGgEySSW0Xzl0xg5+Are95X6xrG9r6lVSfEcFhORh5WfB1hbG/LRLZ
         329y/eRa9RwvuG2VFYH1ZSjCamkkbgaNIsduW8epeioWemW0ZRmoTSfytkHaLtTX+Fzu
         ZEDoWk/uteCuaMzzu0rJwlN4/kDOQuyR7zsgkBzj2v+U2QbsISxmohUgRPAtJjVfXTH2
         DQFaH45tTq6haUgucLbq+hD+hGmAT4QXYh8v2twW/tUETftLL74cKUagfI0h+Gfg+ZJE
         oZrw==
X-Forwarded-Encrypted: i=1; AJvYcCWKxp6C/ddj0VycGSCr5iPDPQJBbvLlmnzrUwRUlDMZuqJNP5ElsA5htO8lhYZbKN56tcLPkjRQYlrEymA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Tgmsp647HJTmDQfAh06xG6Ny6tfJBTYODujKWmDQSHTfoMmZ
	hTyJZDlF0r2AfYUdCYmzNQkxXvsSI7ywSU5ccd0Y+0sAuPJ4tY5m+cq55I+2f3e0XCmE0qrI2cB
	lfYJ1NsuYhdapkuOPg1YEN11GjFBEuiRSwuSFZI8oO+2hEE4nLfo4tEPOohHfgt7sVP8=
X-Gm-Gg: ASbGncuj7YVR7HoXATLHy26+9pWxP+4D8aLOCAZmr6n3xOxZ7zNXG5HlL4Li7MeZLAs
	EfFDyPntF9y/VB8j21H2Bjzw4qRdJMNEYFWZ9MyoU+0geuGTVC8LNArrkJ+7Z5XpiUGKv93Jvhl
	d8eOPAZYmYBMUAeOGUDTvs8jjpYEqU+lJivObZKz8GLm5hhYomp91x41/BNRWSpe8Z9MZNxuw+F
	2zTvh9deJTWF/hGZjOu8yg2jn6g+2to+hRLrlu22i9zEX2QpWCDtP6NS0ovEn8u3vLLcdeqDsqP
	uFl/+KvmAkqPGD770Even5Hjbt4YZuw/zTnLYe05KTpUSkp93Fj8JwwVZG1OQ6eqbUdlYallqfo
	=
X-Received: by 2002:a05:6214:14ec:b0:6f8:c23c:5257 with SMTP id 6a1803df08f44-6f8c23c82b2mr198868626d6.11.1747831507828;
        Wed, 21 May 2025 05:45:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEShz+g9YiDU5OL+/RiZ6SU1Z6wT5YO4aHSX5TPMnkQqGJbcSQrWsL19HoCgqDtp3hVG17QAA==
X-Received: by 2002:a05:6214:14ec:b0:6f8:c23c:5257 with SMTP id 6a1803df08f44-6f8c23c82b2mr198868336d6.11.1747831507432;
        Wed, 21 May 2025 05:45:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e7017e6esm2826955e87.136.2025.05.21.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:45:06 -0700 (PDT)
Date: Wed, 21 May 2025 15:45:04 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v6 2/2] i2c: i2c-qcom-geni: Add Block event interrupt
 support
Message-ID: <w6epbao7dwwx65crst6md4uxi3iivkcj55mhr2ko3z5olezhdl@ffam3xif6tmh>
References: <20250506111844.1726-1-quic_jseerapu@quicinc.com>
 <20250506111844.1726-3-quic_jseerapu@quicinc.com>
 <qizkfszruwcny7f3g3i7cjst342s6ma62k5sgc6pg6yfoti7b3@fo2ssj7jvff2>
 <3aa92123-e43e-4bf5-917a-2db6f1516671@quicinc.com>
 <a98f0f1a-d814-4c6a-9235-918091399e4b@oss.qualcomm.com>
 <ba7559c8-36b6-4628-8fc4-26121f00abd5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7559c8-36b6-4628-8fc4-26121f00abd5@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMyBTYWx0ZWRfX6slzIZ/gK3BC
 gh0nKdd37G7pZWqQ7HryFpy2/Rdf9vS3tQ/EsaNRcboNbdPYBqvI+8f/5snXxiEamdD8mw5WYkn
 eZq6RO1gFdhwSQFN2Wd0POBBKrG/wQETA9Yfh9UDdb88ewxWJSij4EXlLC+OZ/vm5ryUUGvMMxa
 xfC92bysEckuwa1xiEXli8/vkSeZ4BJmu3ROTFFj2SlgN0MzWVXh65CVlpWhfwHhIOtBwzJjPNE
 R7vwPlgFdVcMN/RneNkQBbjyVnb48kIImHk9kYMFS2/AsSJttbPP53bUzGHrmMjUENHXycmFwyl
 MOzlRfTspmOjuDzFvuYQTSqkOFn3cIAoZ5/Pp265Ux4ubtG1X6+IA6rqbNl+qzYVvNAsky/OnUA
 y4V85ERGqYwLHzJ0EPlCN2XRd4VmGcVmfCajBRuCuDNRgQI1deLrjuAxGaSzENYYv6N+X9Ra
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682dcad5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=O67JBuyAYGrhvE3k4OkA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: kqbo_3xatEf_pjdHtr1YUK9c9foTMzFN
X-Proofpoint-GUID: kqbo_3xatEf_pjdHtr1YUK9c9foTMzFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210123

On Wed, May 21, 2025 at 03:58:48PM +0530, Jyothi Kumar Seerapu wrote:
> 
> 
> On 5/9/2025 9:31 PM, Dmitry Baryshkov wrote:
> > On 09/05/2025 09:18, Jyothi Kumar Seerapu wrote:
> > > Hi Dimitry, Thanks for providing the review comments.
> > > 
> > > On 5/6/2025 5:16 PM, Dmitry Baryshkov wrote:
> > > > On Tue, May 06, 2025 at 04:48:44PM +0530, Jyothi Kumar Seerapu wrote:
> > > > > The I2C driver gets an interrupt upon transfer completion.
> > > > > When handling multiple messages in a single transfer, this
> > > > > results in N interrupts for N messages, leading to significant
> > > > > software interrupt latency.
> > > > > 
> > > > > To mitigate this latency, utilize Block Event Interrupt (BEI)
> > > > > mechanism. Enabling BEI instructs the hardware to prevent interrupt
> > > > > generation and BEI is disabled when an interrupt is necessary.
> > > > > 
> > > > > Large I2C transfer can be divided into chunks of 8 messages internally.
> > > > > Interrupts are not expected for the first 7 message completions, only
> > > > > the last message triggers an interrupt, indicating the completion of
> > > > > 8 messages. This BEI mechanism enhances overall transfer efficiency.
> > > > 
> > > > Why do you need this complexity? Is it possible to set the
> > > > DMA_PREP_INTERRUPT flag on the last message in the transfer?
> > > 
> > > If i undertsand correctly, the suggestion is to get the single
> > > intetrrupt for last i2c message only.
> > > 
> > > But With this approach, we can't handle large number of i2c messages
> > > in the transfer.
> > > 
> > > In GPI driver, number of max TREs support is harcoded to 64 (#define
> > > CHAN_TRES�� 64) and for I2C message, we need Config TRE, GO TRE and
> > > DMA TREs. So, the avilable TREs are not sufficient to handle all the
> > > N messages.
> > 
> > It sounds like a DMA driver issue. In other words, the DMA driver can
> > know that it must issue an interrupt before exausting 64 TREs in order
> > to
> > 
> > > 
> > > Here, the plan is to queue i2c messages (QCOM_I2C_GPI_MAX_NUM_MSGS
> > > or 'num' incase for less messsages), process and unmap/free upon the
> > > interrupt based on QCOM_I2C_GPI_NUM_MSGS_PER_IRQ.
> > 
> > Why? This is some random value which has no connection with CHAN_TREs.
> > Also, what if one of the platforms get a 'liter' GPI which supports less
> > TREs in a single run? Or a super-premium platform which can use 256
> > TREs? Please don't workaround issues from one driver in another one.
> 
> We are trying to utilize the existing CHAN_TRES mentioned in the GPI driver.
> With the following approach, the GPI hardware can process N number of I2C
> messages, thereby improving throughput and transfer efficiency.
> 
> The main design consideration for using the block event interrupt is as
> follows:
> 
> Allow the hardware to process the TREs (I2C messages), while the software
> concurrently prepares the next set of TREs to be submitted to the hardware.
> Once the TREs are processed, they can be freed, enabling the software to
> queue new TREs. This approach enhances overall optimization.
> 
> Please let me know if you have any questions, concerns, or suggestions.

The question was why do you limit that to QCOM_I2C_GPI_NUM_MSGS_PER_IRQ.
What is the reason for that limit, etc. If you think about it, The GENI
/ I2C doesn't impose any limit on the number of messages processed in
one go (if I understand it correctly). Instead the limit comes from the
GPI DMA driver. As such, please don't add extra 'handling' to the I2C
driver. Make GPI DMA driver responsible for saying 'no more for now',
then I2C driver can setup add an interrupt flag and proceed with
submitting next messages, etc.

I really don't see a reason for additional complicated handling in the
geni driver that you've implemented. Maybe I misunderstand something. In
such a case it usually means that you have to explain the design in the
commit message / in-code comments.

-- 
With best wishes
Dmitry

