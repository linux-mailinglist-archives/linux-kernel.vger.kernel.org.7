Return-Path: <linux-kernel+bounces-764445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B617CB2231A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3401856466E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5002E8E0A;
	Tue, 12 Aug 2025 09:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AAdFQshg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE5F2E8894
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990670; cv=none; b=n4wSDySEQ+PBecO7OCe/DPStz6qBdfv+XFjtmXjIFlFI1HJXAAnIoELqHmUV+oXXBNsbFVH5Q93W5dnuBw6X9oXYj4vvCM/T2Azcn6HOlnmSuHK0qZIHoQ0lZgvaSVhRgZTiSHY2/vgXSw9UixIa3QJyLYh5Mq4LcNVTzmeFdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990670; c=relaxed/simple;
	bh=DQcGFfWnXmbY3cGH+AQhW2Dqz8CqmcsACn1g+EsVxDo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wghoh3Qziz+mD9eFeOfjUd8MxdWySvtcgdHdRo/HskAxK2AGZ6zJgs6Vq/mT9FqvTc5nSFGqzMuJoCBNRejwZA4/WbSlerESF2BYH5nhfsIAk3I+DUBgDKwhKTc4te2xhiciFlIlk3xdS2DThVIGLOpcwGSflLRQYsegkm3tJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AAdFQshg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5YLaJ029264
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JbNwrBojJxdkzYo7Fd0J7AxB
	G4xLKOGzvLpUDuXINjs=; b=AAdFQshgTrya4uNddpws/falCZqWiVjiB3wp709T
	hqK/l+OKzCDqECVJmi5VUnAOoFQ29QPPnjlawlhaIXSu3DiyDv7Aqk5Y0zF8A+qg
	TBrEZ95ztA4HDn8MWi51oMnOSPEUw1vJXwhjMflpTofmWqA7GsAYgtZgADnfTBTM
	KnoDovPt3ZZ+pr4I6pA+iECQUzz9kPmlyL6lC4VZWlyq+m884NAYV+cwhewG/qp/
	COnGsU1+VqCQBliGvPPwiKOayj7aSNY0CxaVhwmfMal68V0/ImTMJQjw1I0oMt5z
	MhSi9gnNaTmTQRKovuDOdKGmcvcUCQNM7nXnXdxJ4Ppm6w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmfh7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:24:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0a3557d05so111536011cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990666; x=1755595466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbNwrBojJxdkzYo7Fd0J7AxBG4xLKOGzvLpUDuXINjs=;
        b=XpACANvcz1TkxIzk4qrIBCgShKPw672TTY9epB0iUHAhbRKJLjBQYCgoqJHlsF6ztS
         SyOLPrVwsBQC2GBsz5Y0VL9Eec0zqDq2kHalHvicZVH8DJ9QxEZucoVdvEakE9A2D9KK
         GGjw5JAQko/aErZ2kLy80GXUvIiY+SqUUokV3TYrJB2XOzeVM1qo0E4XoHVdqr3dcZh4
         Hbi6gxd2xzvraN0ZBYAA6ztLtp762v3GAG3KytOaD9L9aUtGVBLijsHB2wsD9e89yi7O
         mJVz7nga9CtX0dl/kNd+dc6MeZ/+A+Q87+62w/d3sMvgO8Akz4+FqIRzSyK11TO25nnn
         8mlg==
X-Forwarded-Encrypted: i=1; AJvYcCX8BZCBjzy+FQxCHRPXL/3jKw2hBnL2Qi+Csq+XS57Mp2a0ztqeXXEOiTMM2qLfJO78pXjWMZpwGMdTTEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws6pfeUNh9EerYrvS4nphjkj90QzsgvfBYmxXiHzifqKqRKiWJ
	uEz39TG9Xy9G5VD/Ik8JB7c1Z/ev11amZrl5jqoqD/Iun9crUv95Cj4SjKZKqf8qWFd91ZYYDQr
	1DgUWyLD/xZIentECbhoenFiWYgT5FyYBOrYIOPY8BX1o1cCvgrb5Gy/yR/boJeXJuj0=
X-Gm-Gg: ASbGnctHXE573nIwhFwErjkzd+F8T8O3l2+eMInVK3nRziHgBrldcFhI6j0UNuHQJXF
	Hd/w1XRPH9I/6BKLPn3VXXA+Ek8ZzibwJ1zur0oq2XdKqhvi5w0OMageAvhbbEAr0A+e/7PZJWk
	C6cKpt4+IY2v7H634zRhUrL8Z8Comd1D1VLwiMZVx+MxgkLS7J/I603j5RKHlDg1RTG0LYwWQNm
	4xUDrYhvP6Wktx/oAMeT8eIdVru/vIvQ038hPg5XktNBAy0gsmh2+SIESApgC3vCqOFiBS/RHUH
	DLNfSgTmnsC0hGEK1joe1BgPJwEBocP3Fjb0o0Lt55hQWlc1y3ziOqR9PHMDdXIq6+k5zQ==
X-Received: by 2002:ac8:5751:0:b0:4ab:751e:9d97 with SMTP id d75a77b69052e-4b0aed720a2mr256867391cf.49.1754990666372;
        Tue, 12 Aug 2025 02:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBBYPf5IiNltyvzhJjTZ4jKDXmmEi9Yg+eQEVvuuplz7NeEAprCbyMCK3NFdwyFBTEoCSfJg==
X-Received: by 2002:ac8:5751:0:b0:4ab:751e:9d97 with SMTP id d75a77b69052e-4b0aed720a2mr256867161cf.49.1754990665913;
        Tue, 12 Aug 2025 02:24:25 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459db3048bdsm390721525e9.29.2025.08.12.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:24:25 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 12 Aug 2025 11:24:24 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: iris: vpu3x: Add MNoC low power handshake during
 hardware power-off
Message-ID: <aJsISDlgx1EZCzKn@trex>
References: <20250812-sm8650-power-sequence-fix-v1-1-a51e7f99c56c@quicinc.com>
 <acdff7a4-bd9f-45c1-b620-25e667d1f628@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acdff7a4-bd9f-45c1-b620-25e667d1f628@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX7CLL/SMTDtkU
 M6ZYyNQBip2DNfYLe92ivF1mUdoQUt8WQCVa8Y4wof4uapNaG2pDd/oNwBu3zeI9r1z8nn7AyZp
 G/lmV2YRg9YCWeSsEDSScgJ/upE+KUopSLpy/wn8kuY3UErIKwx/MJzZT6LsGaxBl1FWaVea+ee
 m3+S4l8q0hJLS/Yfx0UBCmzHQ9LTPffcHEGAgGEPwdKHEwBKiqprfZRO3ikSpRuL3yURJyaG9eX
 eRJeUr+vIwoghkdrDyWnKMzxujfer+kR+Jw19ghzcDuT4MGO2a3bKxGoMW1wBBohExjA94PyPMs
 5U7fJcEWGCNcvbHQ0MyUYfVc20LcWG9UJ3euGxumB1wxCEH50+/dxr5A8q97blfrSC7Oct5zBSJ
 JiK4aSb7
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689b084b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=Ovw8jLjI9PxWGIGDV-AA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: eBB-VivFDZplzDxeKV8if3CmTqbBcU6v
X-Proofpoint-ORIG-GUID: eBB-VivFDZplzDxeKV8if3CmTqbBcU6v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On 12/08/25 10:06:40, Neil Armstrong wrote:
> On 12/08/2025 09:48, Dikshita Agarwal wrote:
> > Add the missing write to AON_WRAPPER_MVP_NOC_LPI_CONTROL before
> > reading the LPI status register. Introduce a handshake loop to ensure
> > MNoC enters low power mode reliably during VPU3 hardware power-off with
> > timeout handling.
> > 
> > Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> > ---
> >   drivers/media/platform/qcom/iris/iris_vpu3x.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> > index 9b7c9a1495ee2f51c60b1142b2ed4680ff798f0a..c2e6af575cbe4b3e3f2a019b24eecf3a5d469566 100644
> > --- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
> > +++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
> > @@ -110,6 +110,7 @@ static void iris_vpu3_power_off_hardware(struct iris_core *core)
> >   static void iris_vpu33_power_off_hardware(struct iris_core *core)
> >   {
> >   	u32 reg_val = 0, value, i;
> > +	u32 count = 0;
> >   	int ret;
> >   	if (iris_vpu3x_hw_power_collapsed(core))
> > @@ -128,13 +129,31 @@ static void iris_vpu33_power_off_hardware(struct iris_core *core)
> >   			goto disable_power;
> >   	}
> > +	/* set MNoC to low power */
> > +	writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> > +
> > +	value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
> > +

for readibility purposes, could this code be restructed a bit
differently? maybe all the write/read operations in a single do while
loop with the exit conditions assigned to variables with an
identifiable meaning?

maybe also check/report errors outside the loop itself?


> > +	while (!(value & BIT(0)) && (value & BIT(2) || value & BIT(1))) {
> > +		writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> > +
> > +		usleep_range(10, 20);
> > +
> > +		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> > +
> > +		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
> > +		if (++count >= 1000) {
> > +			dev_err(core->dev, "LPI handshake timeout\n");
> > +			break;
> > +		}
> > +	}
> > +
> >   	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
> >   				 reg_val, reg_val & BIT(0), 200, 2000);
> >   	if (ret)
> >   		goto disable_power;
> > -	/* set MNoC to low power, set PD_NOC_QREQ (bit 0) */
> > -	writel(BIT(0), core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> > +	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> >   	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE,
> >   	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
> > 
> > ---
> > base-commit: d968e50b5c26642754492dea23cbd3592bde62d8
> > change-id: 20250812-sm8650-power-sequence-fix-ba9a92098233
> > 
> > Best regards,
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
> 
> Thanks,
> Neil
> 

