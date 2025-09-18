Return-Path: <linux-kernel+bounces-764649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83179B2258B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4068116D552
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD562ED85B;
	Tue, 12 Aug 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ior0IhHC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E772E7BAB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996987; cv=none; b=PG0QmiQmEQ2r5YX+vn17KkpEH18nLm6E256+A6OY429SwAzqU5ICPyUd/i8pWm6DNopfQCPS+Ob/hzzljf7kC6Np0a8yscGxUZz8whX1Lpem0W1msXxdXGgk84F+kcLc+ngLuRFHZzsxzbmrd9UUw8fkNpB0pJfXFduNwzcHpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996987; c=relaxed/simple;
	bh=bhs3SsVlq+SxDs9XTMF9gHOZg1xIje3I0Vw3qVgPrV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8xp/IZ8iyz1Zqiys3YaGaQIJB3G1dskSlus9qex4FGlS+6u320vf0a5KHyDcjLWpMelOu2JXHL0A5wc9FuPKExNm27t9eFMMycCl4u+YM1XLS3sTWo9ns2zfpsVbpV9aQCdiohNE4iva127nYawYUswKw0q2U+0RKM1egz2Acw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ior0IhHC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvfaH012897
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=AIAxtRxEWQa+PoJtNeXzkD9e
	1EVa70dohZybPWb7a6w=; b=Ior0IhHCvawSNtfOMAb0wwO9GSsGgFtfbT0jskDn
	kTzsP6w7UbfARCpo2/GxPcqdI9j89kWyEO/N81jPJI82WfeznF1FUow8rbsZk5ur
	GJoSfB1suaiYS0XrwqcC/eVaeS6WBS9zhu0umIQ/Zi3OAKE5hewjzv/bWgppG0Vh
	xyx/Xpu1YnOCuQSCr5MksIW9e2krGMhlufmrk5Ya8Ej6rmzTT9KUept46XB1QS6p
	11iPfwxhTsawKwaMcQlII0jZhKl4WwBGIyVE5vjdx6Smqraf75621YM2dKym1PDF
	Uh50LrIr3YJBhjhP3sGw6KmC36mvYSI23PVp3Q8LQKllVg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbb0tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:09:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e69dbe33faso1248800485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754996984; x=1755601784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIAxtRxEWQa+PoJtNeXzkD9e1EVa70dohZybPWb7a6w=;
        b=uQ4BljPmJcHI806KwpHZg9rrbSH3T9j1Ll8TzElAstAJ+QvOiJUUhkCo2R7k4j3qIR
         xifi/SJwuMwSpsW9no3rYnhYcSyzCviBbtSIGay27+mRM5n6jSxlPNpprGQ05sjTaH9o
         hMy/lO61S2gWr8CWhBZjG+QbbBH+yVTxBL7/LN2Z3dleVPlgO29Og0albT6aP0QaZQwq
         988YgGo/i56HgSe6roAqtH1QautdbAB8fO3aQ8kkGhHIUd50lCAwX5TiEyqZAvG46Lsb
         zyz8FItQ5kPLLPDyEDoB+2q8bbcEkZZ+cXTTvdNONOZcibSwI5N7AArxiXq/MGSKQFUz
         cJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbS6ImyVP6YL1qVB0xn4YC/4jzc9m5L9spZhY4nzmC9BfV9Rv8zeWEfFqCjMUuBfnV2QJfYKNzZtg9eGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB3eIIKPJhwfGR18lJAaUWyUqqiUxZHOquzn1mpJhIvfwdw/od
	Y/04Q871rILsyJtuh6aXWdA8ADHIX0soFDYFIXjVtpzGDDEfyeXuKkxNecft3vqQSxNyVoAqUMK
	KTccVUwKwplFEwJ4xR6M3PT09sxXpPa5W3dD4b1i+KRm4qXEKMlZxcFWnCKz1IGQbsOQ=
X-Gm-Gg: ASbGncvaqdb0DubxOUX9M3a7yfoUTkV1hi2A9gbOytDctnshaH1BTBlwfcI/Ya0URGs
	0XjRa6Rmc+C7wS0sR7HVMjVI15GD1X1sU1lfTu+oRR/uPsteuRbzNkBj1nnM0mTlqp41CaBN8pw
	g6kuHOhNlfbk+lFF4ZCD8vyWMvqYOc+eUuhrspslp54fBnsF5s93Wf60Bl/WMrDO6wNW4PBvHE4
	feUwMD/YyNdE48ZTvQBpFQ/6F3eFc+FohZAAuZ2y32BpEHn/OAtRuwlMFsufhaP14UJhH7R86ma
	WzNZrop5imAfWMut4EPloi4BvHZggVX7bsPu3ZObR6/iLFmSVkfxaGe3YFZlRVRnVUkQUSziQEt
	3nyuUoQQZNJkhLMU9JHOIXjOElUzkcO0pGsM6a8FT4XbK3mCOx9sR
X-Received: by 2002:a05:6214:cce:b0:709:76b4:5933 with SMTP id 6a1803df08f44-709d5e65c0amr39757296d6.52.1754996984094;
        Tue, 12 Aug 2025 04:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED8N/fj/UddI6LrtMKrLtwztZPaROzzzxE0FNZZIfFm57zKexaJ8AF75jAWjjfPAFgK3Z2zg==
X-Received: by 2002:a05:6214:cce:b0:709:76b4:5933 with SMTP id 6a1803df08f44-709d5e65c0amr39756786d6.52.1754996983646;
        Tue, 12 Aug 2025 04:09:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898beeesm4777002e87.17.2025.08.12.04.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:09:42 -0700 (PDT)
Date: Tue, 12 Aug 2025 14:09:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,mdp5: drop lut clock
Message-ID: <r27jcfvpnsyi7eqtmfrmsz6mqnvkevt6dgfqlsxen4zd37fbec@flsgd3mctkoe>
References: <20250809-msm8976-no-lut-v1-1-f5479d110297@oss.qualcomm.com>
 <0bda8e0e-4f86-458f-b55e-c5b0d6cd5c30@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bda8e0e-4f86-458f-b55e-c5b0d6cd5c30@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689b20f9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ywOSQKh1gFCfJaF_E3EA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX4NYy6mIKU59d
 bLhmmCpUTQH08cKU+k9x0XPhBj0Jm2A6hz29am63Ns8zdyKm1M+YWE83fEmsAmvh8Ierv3eK64k
 W1VTJTtJLRBdsqDk93j/a+et9dAIZi7/0T1yw4L3bJwIK0gzlrtkmThhY7+N2CsipG1HS/3fX47
 VKWkmZTN/sZNOY1OGvxTLDjPCnc2oIpkNs8naOwNZ/jjMUqTy/kF2uRELz8aOsSXNSSQA56Sxo7
 Pgt0IKmWP5Ib8fn/qW8XamZSomS806413DjKErma/knjkL9nJazRyqI8j+8r+Gw5QIX+OaiaApx
 zbWsTh3E/eOUdpz4udYabwmyjhjL3jQ0Hau1FVqyen8rBEDzjgyKAooTOikXtUJbHfk9DnYVlcn
 jNklHnab
X-Proofpoint-ORIG-GUID: F-Pr6-SYn8rBJo1BYzUsPEBi_MgmWH6W
X-Proofpoint-GUID: F-Pr6-SYn8rBJo1BYzUsPEBi_MgmWH6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

On Tue, Aug 12, 2025 at 12:27:14PM +0200, Konrad Dybcio wrote:
> On 8/9/25 10:36 AM, Dmitry Baryshkov wrote:
> > None of MDP5 platforms have a LUT clock on the display-controller, it
> 
> 8974 and friends seem to bind it to the GDSC
> 
> although on msm-3.4:
> 
> arch/arm/mach-msm/clock-8974.c
> 4197:static struct branch_clk mdss_mdp_lut_clk = {
> 4203:           .dbg_name = "mdss_mdp_lut_clk",
> 4205:           CLK_INIT(mdss_mdp_lut_clk.c),
> 4609:   {&mdss_mdp_lut_clk.c,                   MMSS_BASE, 0x0015},
> 5118:   CLK_LOOKUP("lut_clk", mdss_mdp_lut_clk.c, "mdp.0"),
> 5387:   CLK_LOOKUP("lut_clk", mdss_mdp_lut_clk.c, "fd8c2304.qcom,gdsc"

At least it's not used on upstream (nor could I find relevant docs in
the HPG).

> 
> Konrad
> 
> > was added by the mistake. Drop it, fixing DT warnings on MSM8976 /
> > MSM8956 platforms. Technically it's an ABI break, but no other platforms
> > are affected.
> > 
> > Fixes: 385c8ac763b3 ("dt-bindings: display/msm: convert MDP5 schema to YAML format")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> > index e153f8d26e7aaec64656570bbec700794651c10f..2735c78b0b67af8c004350f40ca9700c563b75f8 100644
> > --- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> > @@ -60,7 +60,6 @@ properties:
> >            - const: bus
> >            - const: core
> >            - const: vsync
> > -          - const: lut
> >            - const: tbu
> >            - const: tbu_rt
> >          # MSM8996 has additional iommu clock
> > 
> > ---
> > base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> > change-id: 20250809-msm8976-no-lut-4b5100bcfb35
> > 
> > Best regards,

-- 
With best wishes
Dmitry

