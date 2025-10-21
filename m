Return-Path: <linux-kernel+bounces-862914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52CBF6847
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240F7482766
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAC22DCF5D;
	Tue, 21 Oct 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VjBel/NZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDB32E73D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050621; cv=none; b=HRnw6WjzH4dVQIcRhlvvmzXE4tpxR4DFvJVDmMPrpH120jQVhhltPryqE5h6QBfDSpPHpURMFPfkf1EvOi2iIblVk0vF9BtijlnWjFlSV/jhCd6dWVZqiE2JNPm2VRKCaO9dhFwvBZezmVorlzlnMYpKh+3Nl34eQqZCOYCqesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050621; c=relaxed/simple;
	bh=AT4+gl0rs9961D+MpeA0OhT2iq24TBYLv/eyu4a5C9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbKjLBL63BuSm5odiYQimBACfGfK/NJ6dJ02eNkI4aFpKrrTwdHHhTzBHAl+WsTTQ7QU6DcpYv8I2YI3XppfHz2Gy/61MWCVvgSTOIh1FS+b0DAXahZQ0l0bKuXZAO3aoF7/+JAdKWXTz/hKF+FD2qO+rv9krjB2jDWk61oSoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VjBel/NZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8NU5i020896
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YrwiyRfZATb5k2/pvhzdB6tg
	/Ojvbxr5etjGnjqDZ7s=; b=VjBel/NZj/zkmkOHwg4E/r7pzy1GazyeBDSQayN1
	0ZcJhDbtMs1xD+GNdhp9Qqfr4IUMuMYuY1WZr9992UbH7fHDCcDseMnm/d+pJvzS
	VGRsIZi62G+QCopfkjzao2nK0j82YHubb0eRhf8VCAACsR/VFwvLTXdZnyoYXawp
	s0kdAwoHFohAx5g9wSWQc6gxOvauaGbxr5NSKNISrb927F3qpa8T+/OCagMx4kQP
	203SXo9m8AWCJQYKAFhJ76G4Z5n+6iYBeoHR69EzOkHTPlIV4yjvnEeUV4ozJVAh
	+d1voX+AREa+3V3c0jUSa6pTGY4qtk95gY/t9i3FnwY51w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469gkvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:43:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-892637a3736so1593334485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050617; x=1761655417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrwiyRfZATb5k2/pvhzdB6tg/Ojvbxr5etjGnjqDZ7s=;
        b=lluSLchCdtno0ZianvtfUr/W0NXR5o5QVWIM4hbV34csDPLPNG8lP9Fz8+Dmj3xZ6b
         6cOHp0M5HKSfsw2PdBfA1HBKQcSCGwdNiSUbT/U7EkXFvFygIQ906ZTynJsyc2T53S5Y
         sDZdvC9/q2xTMThbKtFLcu5UyZWGcPpnmA34KJvdMPimnZ4EVhWnDtCmfI6I8OdKSrUW
         HvyhSjbr0Qx0OPhwic6X2H5+fcdQIkkCct50DN5N5w5QJCgGMucfRx6OK2S03e81/ukH
         w9nv9rlXPmbkjl9Xmp6ENOgCR3Jat0pkClNRQjy0xkV0eLMTWEqjxLanj4lctr60iFQD
         GuaA==
X-Forwarded-Encrypted: i=1; AJvYcCVzgu2HrAgGoMrOLnp49TJauqMQTi6qe3NrwutPO+dTGxbRqgd2e+IDHxJ0wYd0PctagneNiUIS0v5OSkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAwdpaQ1loWDvX8b/sqBBC4RUQH+62HTLrZa3NMnPGN43e2jZQ
	dL3xa9ztTTn6CGRPlUgkRynBZRZfYAkhr8O67yrszTh4P5NDGQFPIqY79WlUR7nqcfn5wDR1Yl4
	d9t3RPdIlI665xT0AO7df0L34Ye/MnTK9hfxukTbaaKbj8M27yGc16FIJzh1+LhR03zE=
X-Gm-Gg: ASbGncsB++3aAUBciVRkpKOX+/HojwH5kNAHbsbWSKTqE3XbBXcvr1F7TjEGCkDBS6r
	r63nVwA8Av3PGH96VXm1vYkGwmynGGwwqnSldF+SCvs2U7DPJtYb5GSwpgMQ9MyTN3Owu7MOiZz
	A+Q4ly6OGseHKyU9ENoF0kdom5Tt9jKvkWvY7u62VynLF5sDDHMWssnVfMe2dUioNxwdYC73Aty
	sl2vQb5Ky15cgYGOBYV1+VkgGAYYbWx6w9Fj2IfG4llTePbARvCnoGDgf8XnSRIaVZtSaFX7IOl
	wSwhRgh71MCif+JW0eY0SGp8ZSqxUS/IUkIPkTM+PhX03OVeTLz0MXLDpJ67uPa+G/m4kUX+NTW
	lNy7Qp0mBj6Ipv6zRzXQNdClktRNedA9VCErQOAvE8U6dU1NKyLGLCRNa5ku/BriP4dkyDO+LHi
	8eOAW8zc5zx38=
X-Received: by 2002:ac8:7f54:0:b0:4e7:2626:3de1 with SMTP id d75a77b69052e-4e89d1d77d6mr181931741cf.3.1761050617310;
        Tue, 21 Oct 2025 05:43:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUPVtv6fqRAU0s5kXiWZo8BfsrvJSnK9mxysoo9yDRgK/Rw7l9S2aSKn0z4+RNQtpmmJBkRQ==
X-Received: by 2002:ac8:7f54:0:b0:4e7:2626:3de1 with SMTP id d75a77b69052e-4e89d1d77d6mr181931391cf.3.1761050616813;
        Tue, 21 Oct 2025 05:43:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a95789f1sm28675421fa.41.2025.10.21.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:43:36 -0700 (PDT)
Date: Tue, 21 Oct 2025 15:43:34 +0300
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
Message-ID: <nvyjnmd242h3muahzkyii7o7yssrb3h4gbqdvpjytu57nfu46h@s2fdz3tnq3f7>
References: <20250925040530.20731-1-liujianfeng1994@gmail.com>
 <658446d1-5d3b-4924-a446-f26a1a8b9be6@kernel.org>
 <942989d4-7a2a-4087-b761-ac8d8bea4d03@kernel.org>
 <wrttwblmgfrey23n2cik4to47ls3me5wq4uvxbj4cwocwgp4k5@aageyrmajo7k>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrttwblmgfrey23n2cik4to47ls3me5wq4uvxbj4cwocwgp4k5@aageyrmajo7k>
X-Proofpoint-ORIG-GUID: 4Pkb9DrvJ4S9SuTUBwMW85nSnZJYNt4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX4EsXoEZouhUW
 8JwXG8YY0GuJ20LhRaFTy21Q1XJLyD9XylNsB35i6lBNXQslGrprmS7mRiyneRhTCfChkMqY0Bi
 0aK4+/L1P5cKxjeyZbPBfPDJQYeq86+WbXgfuybO0BQlAtGwLCDMg+sFelxsZaEVMrIEBvRESv4
 S3fCVeifgQf7yaWO/Iz9zwTkFyKxneI6Jv63pPeJRAkhlzPNA5N2RbPJUxrBmhgRMhFhMjbpMK/
 PNYKb+GbqYs1lZ/NBqeryWCIuswkqerV6J1eyZMsyVnVX78+tFxUKBFILR+z1K3jMX79DoSiizf
 sdCqwgZN+HeuLAiWw611otccZyDvBCfmDOngK/Xt1dnXfmXDdMEKIzk/iXpjjvnkiD3QQYM9IC1
 VsT9gJ4Kn0NG0SgQQZOk9uccWLX8gw==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f77ffa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8
 a=hZVqz41iNrEH_Q0D6mkA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4Pkb9DrvJ4S9SuTUBwMW85nSnZJYNt4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On Tue, Oct 21, 2025 at 03:34:26PM +0300, Dmitry Baryshkov wrote:
> On Tue, Oct 21, 2025 at 01:12:14PM +0200, Krzysztof Kozlowski wrote:
> > On 21/10/2025 13:04, Krzysztof Kozlowski wrote:
> > > On 25/09/2025 06:05, Jianfeng Liu wrote:
> > >> After reusing drm_hdmi_audio_* helpers and drm_bridge_connector
> > >> integration in drm/msm/dp, we have dropped msm_dp_audio_hw_params and
> > >> use msm_dp_audio_prepare instead. While userspace is still calling
> > >> hw_params to do audio initialization, and we get the following errors:
> > >>
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >> hdmi-audio-codec hdmi-audio-codec.0.auto: hdmi_codec_hw_params() started
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: q6apm_lpass_dai_prepare() started
> > >> qcom-apm gprsvc:service:2:1: Error (1) Processing 0x01001002 cmd
> > >> qcom-apm gprsvc:service:2:1: DSP returned error[1001002] 1
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: Failed to start APM port 104
> > >> q6apm-lpass-dais 3700000.remoteproc:glink-edge:gpr:service@1:bedais: ASoC error (-22): at snd_soc_dai_prepare() on DISPLAY_PORT_RX_0
> > >> MultiMedia2 Playback: ASoC error (-22): at dpcm_run_update_startup() on MultiMedia2 Playback
> > >>
> > >> msm_dp_audio_prepare is not called because hdmi-codec driver only checks
> > >> and runs hw_params before q6apm_lpass_dai_prepare(). This commit will
> > >> add hw_params callback same as drm_connector_hdmi_audio_prepare, so that
> > >> hdmi-codec driver can work with userspace alsa.
> > >>
> > >> Tested with Radxa Dragon Q6A.
> > >>
> > > 
> > > 
> > > Missing Cc stable.
> > > 
> > >> Fixes: 98a8920e7b07 ("drm/msm/dp: reuse generic HDMI codec implementation")
> > >> Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
> > >> ---
> > > 
> > > I confirm this fixes the audio over DP/HDMI on X1E laptops. Please apply
> > > this for fixes.
> > 
> > Forgot:
> > 
> > Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I'm still waiting for the response from Srini (since Oct 3rd). If you
> want it to be applied quicklier, let's resolve the question if it is a
> correct fix or not.

In other words: from my opinion, the correct fix should be to make sure
that DP part is ready after .audio_enable, rather than depending on
.hw_params vs .prepare behaviour. Otherwise after some changes in ASoC
or qcom soundcards we might end up in a situation when DSP's .hw_prepare
is called before DP's .hw_prepare, ending up with the same issue.

-- 
With best wishes
Dmitry

