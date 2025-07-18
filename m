Return-Path: <linux-kernel+bounces-736734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240EEB0A113
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DFD3AEC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020FD2BD024;
	Fri, 18 Jul 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQ3fnn8K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2A7295513
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752835938; cv=none; b=cBdPu7I0Yy/xDHdY3uqB1BSjx4WDIgIw/M3P82+Uht4sEyhUbzvhEzrpw6yXfVf/n8V0rOY29OTO408smOvIRrKBk5yZWS2Fp/GdJszbHTnptM82+CeBmb1+Y4AR4H2t9yt/L8dGNlAJCzd2+5jKs94D+GHoPDVMOJydjdtidho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752835938; c=relaxed/simple;
	bh=JTw4ho8gPONRFyF3/gD6HJRo/r9ISc5JMn6DPjK9wo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnfqAHhEigSXho2PIsRNdlKr53ygI7qLLAMLQosKpFPeJ5PdZ8inpJIq8gkaeSFTjB2YJHQdQP0Rc3e9a14xUjhufXl+tet3lDq4ucyN8b/JC2jkeAJvRPuTUwJAIMHmn/lJpy6WB0abG5LnYmfSCGHwIg39o/UBP9EtsigxQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQ3fnn8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8U4xO025183
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z5VSiGr2ZsbWALN5zUGrP4LvnTpKbEmqDudeNgwiofk=; b=XQ3fnn8KWQnlFULU
	5L3W73USuyaN7s2dXbIcdUf6p7jmGnYi+oke2do1OxoajZRizQRTxrENbqmhs2Hw
	GYvuHVhwEm8qWnR56XeNF2cuT1eRtQ3D0HZ7PmoP3fhHB+StAnc3DDP/30xVU2+h
	Bi+OeqluFL5oHg1PycnzPfWSVOJl5Nqqrg6hHQfvskCZsQKbpgD+7/TQISiMldkB
	RflRK94JMxxC8YJLNfsEcyQc4ez8zmq28wM3y90BXwId2VNXTM2Dj5LL4b1OehHE
	AWstoSXfcxsCwDemu8BRjgxb3GyFCYPFBL8S5YwYx90GYdPU1MW6p9BplYHZTiMm
	9Pe8vQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xbsqfd3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:52:15 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704a8024e6aso50193516d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 03:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752835935; x=1753440735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5VSiGr2ZsbWALN5zUGrP4LvnTpKbEmqDudeNgwiofk=;
        b=p1ts2qo3Mteq0Bai/EzplNar6uIRvM1C/4b7t/8pM+ahHV2yiT6fjS35cHoLn7INmV
         k6Ez6SDHNEhcWTsPBKHmlNoSHKqhUpDpjaIG4PcgjJNLQ2S0EtIvKjVS0s+NLRyIUafb
         TY5F8Nuxtor2C63YBivgPaHAP8k4Y49EhWQZqDtj4J1p4r1vKP5CpqprZu+JZXWjpj83
         dMlW+WLsNemCwqZN9EE010lhETXxO+T7oTac3Qlt3dPxuXxvZ90pE/lCJU/dtm5Ik3gr
         WsRHCJ794e5tCzrWAk35u+QwBStv/IHVciH5B3aEevZn7tJaGmLuc1XgbxzzXr+yAD/f
         qcmw==
X-Forwarded-Encrypted: i=1; AJvYcCU5kofR3WJJw+PBIU5lldu56L5u5O3G6xxX+SkrNu7bwCP896p6wLFdV1g29Opi757SGC9Jdlb4SXLEmxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyg4FDnlvsrHOUblaXzAbvQ3g8Uf/m/sBeGRv77O4dqGISQHwm
	6MeptmVvLTgPgvKNY9FqLnvXZ2XdiFDlDsNDwvJ7GZfIVODqNxfgqj1Co/MFYcsVmfMsLr2z93a
	bE1BDpa1h/bwNBcVftNrDFUeOznklsHePrT8/GkDpyVUAubXnS/rMlIqEy3bTOswREts=
X-Gm-Gg: ASbGncsqgPn6VsuLzqqnh0kNf+w/yus5VlrOca3CPdNj3lxuhjCno8vlKJxaa94v5U1
	AA4JAIw67Ss2pdvQayE6GH2p30TvWpN0KiGcM27+YTCMHIdjQf++zN8l6+o9UV12CtlTW8PaQxM
	jXbebliMtPtNLjc6eDfmyo8ogmnSH+/ihZ2i0MCFh2nek21fvUsaC+5Byo7hdpoLE50CfngOpCj
	x0BALNa0rRCh+P4xVt3/YiGcOJrnPeBe3Fv/KiYiHeUMOjaL/MCzgkHhFMriaYFxxNJvSmCKsU1
	K+Gj0hGwBJvP94h3ijkpKj2sXt32mPa1SKPxl8aVDbGP466xPg0VKwT5LlZH6XV1ZHY0oJ8dYnU
	QRcFM2ljvP/s9Qs3FhWb3/3fqmRZvr4iy/he4D2oUwkRRgSKGTfPZ
X-Received: by 2002:a05:6214:e8f:b0:702:d1aa:46e6 with SMTP id 6a1803df08f44-7051a113c5amr35693486d6.28.1752835934550;
        Fri, 18 Jul 2025 03:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKvAUe8ztGpRE1cKK45MSgMouCPAT64Xsgug+JyUGRTY/H140Uw/uocYvI3w9Cr7n97LJF1w==
X-Received: by 2002:a05:6214:e8f:b0:702:d1aa:46e6 with SMTP id 6a1803df08f44-7051a113c5amr35692906d6.28.1752835934062;
        Fri, 18 Jul 2025 03:52:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c6b2sm212215e87.86.2025.07.18.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:52:13 -0700 (PDT)
Date: Fri, 18 Jul 2025 13:52:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?SsOpcsO0bWU=?= de Bretagne <jerome.debretagne@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Xilin Wu <sophon@radxa.com>, Dale Whinham <daleyo@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] drm/msm/dp: Work around bogus maximum link rate
Message-ID: <jsynzhzzt4drqcrvbuprjnvu33go4gow3l3hxgafuczdn67uhm@2eq7c5rzflr5>
References: <20250714173554.14223-1-daleyo@gmail.com>
 <20250714173554.14223-7-daleyo@gmail.com>
 <A9DB4AE061FD8BB9+3519a519-1a29-49c1-a07d-28a0577677cc@radxa.com>
 <CA+kEDGGaKrYO9Pu3un_Nq_6AOZC5L9sG+CEwh2ZEzWFeHGqtEA@mail.gmail.com>
 <eb0f5be5-3a6f-4969-affd-c01a6216ad0c@oss.qualcomm.com>
 <CA+kEDGE1kb12pW_OH1n4LmB9PVtgEsft563p9Cx_Mxev9Em3Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+kEDGE1kb12pW_OH1n4LmB9PVtgEsft563p9Cx_Mxev9Em3Ow@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=ad1hnQot c=1 sm=1 tr=0 ts=687a275f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ksxQWNrZAAAA:8 a=pGLkceISAAAA:8
 a=7PkR_4yZ3uwBbB41sqoA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: YaLeiDaHDFVAP4Z_BpCyZHGJ-Fa75V35
X-Proofpoint-GUID: YaLeiDaHDFVAP4Z_BpCyZHGJ-Fa75V35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA4NSBTYWx0ZWRfXxTyYsw3MnwvX
 LjZFOVO3ui+wQ7Qx+u1MB02O3M4QIZXD6nyc+M28+KdWknj7nhO/OTZidLGJGIWvnqayBPCA76f
 UygaRyJaDzLRkJ/p14C7zQ63RVGSFKjD27plSO+xdih6tDtmUmx6M3kipLQsczXP4+Kw2J0bhYr
 TxzRthH7kxF4npaOkyAgGCz73PUG1tgKV23Wt5wRtEDTMVBn5ZSFSNvwWZXzAGp1cA6vSPAQMZV
 f5Yh06PxhG2Q6eM8tRkkQsDM+yL63APBjF81jlzrnsSvotzdj0AbIdQqYjQZKzz2NIyGP3CFwVS
 LPj813KJeSkvqyS53HFMEUpnrOQR6hZ/4PYZY7pZaKgDwkGJ4FKVvJzT+Z86+uYszgraREbAhIQ
 Tzea7dHAHNYWkFn133u6WmRabEJVB10aC+YQBEm90ItLlc2HDc6rX30WYZdWx8xL7DhBIXRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180085

On Thu, Jul 17, 2025 at 11:36:38PM +0200, Jérôme de Bretagne wrote:
> Le jeu. 17 juil. 2025 à 23:10, Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> a écrit :
> >
> > On 7/17/25 10:27 PM, Jérôme de Bretagne wrote:
> > > On 2025/7/17 04:21, Xilin Wu <sophon@radxa.com> wrote :
> > >>
> > >> On 2025/7/15 01:35:42, Dale Whinham wrote:
> > >>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > >>>
> > >>> The OLED display in the Surface Pro 11 reports a maximum link rate of
> > >>> zero in its DPCD, causing it to fail to probe correctly.
> > >>>
> > >>> The Surface Pro 11's DSDT table contains some XML with an
> > >>> "EDPOverrideDPCDCaps" block that defines the max link rate as 0x1E
> > >>> (8.1Gbps/HBR3).
> > >>>
> > >>> Add a quirk to conditionally override the max link rate if its value
> > >>> is zero specifically for this model.
> > >>>
> > >>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
> > >>> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > >>> ---
> > >>>   drivers/gpu/drm/msm/dp/dp_panel.c | 13 +++++++++++++
> > >>>   1 file changed, 13 insertions(+)
> > >>>

[...]

> 
> > >
> > > Is it a feature planned in the short-medium term within the MSM driver?
> > > If not, would a quirk like [4] be acceptable upstream in the meanwhile?
> >
> > I'm not a display guy, but this looks like yet another block of code
> > begging to be commonized across DP drivers,
> 
> I agree 100% in principle, but the 3 implementations are different today.
> 
> > so I wouldn't expect it to be a big blocker.
> 
> Well, it is for me :)
> 
> > Adding a panel quirk doesn't seem in order, as the panel is /probably/
> > very much in spec, and it's the driver bit that's missing.
> 
> I agree that a quirk shouldn't be needed. I guess we'll work on
> upstreaming everything else and keep an out-of-tree patch for this
> issue for the moment That's a bit sad as this will block regular
> users from easily installing / testing via the Ubuntu Concept ISO
> for instance.
> 
> Or could the quirk be accepted temporarily with good comments
> then reverted when the driver adds the missing support? I guess
> it would depend on the time scale of this support landing.

Unforutunately, there is more than that. We should also be writing the
LINK_RATE_SET register. So, just setting the max_bw is not enough.

-- 
With best wishes
Dmitry

