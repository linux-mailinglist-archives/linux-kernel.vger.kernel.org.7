Return-Path: <linux-kernel+bounces-862894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38DBF6787
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52BB44ED39D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD8F27A465;
	Tue, 21 Oct 2025 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgMYy2vd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46C28A1F1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050073; cv=none; b=RRsSt9flFHGh2eI92LT2EW8k2mZkjnewj3Hu4RoWZJZkjvDNI3YJJ9t62Rhok+yfDrTeGgPjyx+t7N0nv+Ll1G1v0jEj0f8s8nOwG923VkC2S1+sVjtLzMScI/j9xzqR0wih9M4ymPK2HSF8/W2hMJ2RwwTcHyoyXdcSuyBu1gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050073; c=relaxed/simple;
	bh=aOI4bJelAXaWfewQrn4VyRWGdHmmw9QRKlP8hfwWG9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPjDlhkVhABXkWsEm35LNqVsmdGrD4kqr3R3v1bz1LykegqJfNCGOHBXmLmf7CJoJ9gT2Z6EicihMf0VZP79dby5Nz3ao6bs3xworHRDw/u8GLIu1fphkVL/brLemfl9ja7yEC6gKCO44nPQcVUcMkszGwhdnVLysKu2GKk7gY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgMYy2vd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8RjLA026856
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JiM0XYOrFQ512EKDfSy47FN1
	IW3pchq+uQUmcduTE64=; b=mgMYy2vdsL+0tuZCKHpBveYaNf6XwSQNqrdr5zu+
	cEfXSAtFbPcBPCeBxSo9ckTGE2RKTZrSjI2Uxw952PE8+A1Mm1NXEzWTKVcUUDHi
	GfeTdE/RuVddRqiU8vUn9ZZeHsIRM/LQOoTzW4nksO6M6ETEy8i8b8E0T8xrXy1b
	62p0WYek8QgvkGx0G2mswg07IsD46Sy0TYAte6p4eXxZNvWzdtYfmUSJ+Z+cvR18
	RlrX8mJqgByxiojUwl7LIokO/auHrG9q3C7nuieqinRpD2y4b1wI4o6zaFKYas/c
	q2eFP+O3F5prt9hzRbqhYux47Kciyu7hcEkcHicvZZTo1A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j0q1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:34:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88e133107adso824232985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050070; x=1761654870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiM0XYOrFQ512EKDfSy47FN1IW3pchq+uQUmcduTE64=;
        b=Qqp0QtYZYnJo6XrZPGS51pnx+Zt3Uk39F4KjKCN0uS4y4p7J7iBpMHFTIIkYkPIzPb
         FhT1Xm+pTYHQKrCUDY4vpOg5wV/jh3hEPhdM4FYzazyfV+RnPNKr2OMXeZ8WaI3/OzHb
         V4u9ij42MTUJoe+ZmwzdhDpoyb3PW5QySMQW6Gtjw01yRMf1EcNQfuELVv/i8VIZuwCo
         Q3yOjmExLJFBVtezyv1hz/aLUg8ImLMpBFCNCtM6+06nF7tmPQoaRmvo8Jcaao7fdHJT
         BQRRKR+kdS3SNCC6w8rsTLYMw8qUgwSf7iXriTS0JTv+TVmWoSoVZ5MaaPfRCYcS6A58
         1RSg==
X-Forwarded-Encrypted: i=1; AJvYcCXUecBQr2BL9ZRAY7uB0gj8YI4EDBWj4C7xsCmOtMeGkYMBoVofJXiuAw48WQbB0A3E5yLs8eWioXWp4E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwDjVsGnQZO1EJUFoKX3AtMqaz4dlf1QMbas0EycJdC/rPBj9
	i7QNGFZJ5zu7Gq1D503R7EVOA41E1VvIXVx2gtonjCcdDH7KNS61xyC/yE32N7RuZ/6GTAfEmRV
	oEvXLphN8ywbHZNc+mMbHcSZJWC766DfsjwKTa+RBxnOGMLrIXp2gUCJafixVXEjrVUc=
X-Gm-Gg: ASbGncs+UU4EFkJdI/dKCXfMXaHjGclUEXVbpen0pZMT8A/LRnoomLc4EljPzIeT+2D
	UR2n9FQ/Z31lb/6O/2GNyvssbH2Hvtrm7YIWUe4kMwGtJ3ayvguTCVFTLC+vifKH2lO1/U53zPX
	GhQj3yz5Pzr8Hdgv1OITQ4hmfsoaekPpJnWHE7tiWicTN4FS7gELq4RsLdDLhy6kbFU94qWjZIY
	hEHk3P0lLxzWf+pdBm6YVBHxoaEWwCNc8SAqsjpLBk0BGQJpFGs2zLe9GXqcfVW/BRPpLXayqRv
	J8O76H2f7AJbJlvp9MBsi30SzySZtaS7RHCo/0qJ+ZB8l3g2PJeipe7CKrldaIvRLdSLCXoJG1+
	HMWS9iz2gODRvJePUS6D9PEu55XIHIqTeG1E0cxCtYJdQvoaZYyJ/JnNtR1wetrYweDgSSeLzig
	xAO3wO9zePZa4=
X-Received: by 2002:a05:622a:18a1:b0:4e8:b18b:6b0f with SMTP id d75a77b69052e-4e8b18b93a3mr135499501cf.69.1761050069845;
        Tue, 21 Oct 2025 05:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF4sae4/F0/n5KKexSlPmPvtAvbiOc081SrO+C+Cpbx6Ztk7aNXlSzq8qzHjHjdWz8bhc0gA==
X-Received: by 2002:a05:622a:18a1:b0:4e8:b18b:6b0f with SMTP id d75a77b69052e-4e8b18b93a3mr135498931cf.69.1761050069292;
        Tue, 21 Oct 2025 05:34:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def268casm3564753e87.104.2025.10.21.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:34:28 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:34:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, linux-arm-msm@vger.kernel.org,
        Xilin Wu <sophon@radxa.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/display: add hw_params callback function to
 drm_connector_hdmi_audio_ops
Message-ID: <wrttwblmgfrey23n2cik4to47ls3me5wq4uvxbj4cwocwgp4k5@aageyrmajo7k>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <658446d1-5d3b-4924-a446-f26a1a8b9be6@kernel.org>
 <942989d4-7a2a-4087-b761-ac8d8bea4d03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942989d4-7a2a-4087-b761-ac8d8bea4d03@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX7BqjPX2RqyHM
 jWi7b0/8yo5wxp0ZJKh4r9pLiwpKRrlBNDn9piEKBceEfJLtTN6PDXT8hjjy/+jF4tLwGkPeVL7
 MWnWkz7Ij3bY6LY1LyfXJBTyfj5dfMxo0ajXHSSIZTzjmxUX87q2Qh01ITjlj2fZaolVR8GPZZ0
 55UuLmDIEfr0uknEoi5skM16sFDlsv0gcKm7suG2qNBuMTp+8mDK7l2375Nzdl+G4mRrCcd/3NR
 oqYsAhuaSOALzrGBT2+XBAgfqMj8BSUnuozGBKLAWOyi8oZ9MyjNoQB1mgm/x7gfRv+bKbFNtz7
 Czu5IKjpDaZXoRgbQcpGy8Jie3wQIza8liuEnUdQhKPShNP+37P8eWeN67dRbZyMYswIGUau7G9
 LfBPqunZfNAdbTNPcAVnRAPZRD5eZA==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f77dd6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=SZM-PPiLjDIjgASHbv4A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: FSbouGffI2m_6HbLWc_WecxlVcczHWMp
X-Proofpoint-ORIG-GUID: FSbouGffI2m_6HbLWc_WecxlVcczHWMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On Tue, Oct 21, 2025 at 01:12:14PM +0200, Krzysztof Kozlowski wrote:
> On 21/10/2025 13:04, Krzysztof Kozlowski wrote:
> > On 25/09/2025 06:05, Jianfeng Liu wrote:
> >> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> >> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> >> use msm_dp_audio_prepare instead. While userspace is still calling
> >> hw_params to do audio initialization, and we get the following errors:
> >>
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> >> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> >> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> >> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> >>
> >> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> >> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> >> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> >> hdmi-codec driver can work with userspace alsa.
> >>
> >> Tested with Radxa Dragon Q6A.
> >>
> > 
> > 
> > Missing Cc stable.
> > 
> >> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> >> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> >> ---
> > 
> > I confirm this fixes the audio over DP/HDMI on X1E laptops. Please apply
> > this for fixes.
> 
> Forgot:
> 
> Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I'm still waiting for the response from Srini (since Oct 3rd). If you
want it to be applied quicklier, let's resolve the question if it is a
correct fix or not.

-- 
With best wishes
Dmitry

