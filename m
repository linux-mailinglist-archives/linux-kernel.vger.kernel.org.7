Return-Path: <linux-kernel+bounces-874607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15100C16AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D7356F43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5534679E;
	Tue, 28 Oct 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KbeHfU3J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MZGwyuja"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4B23A994
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681154; cv=none; b=hENpmacwtT4U3RNMVsXauA9Qn4PZ35MT7ouLwgRr49r4Xc3XoAQkee81MypfcH94KKdlF7sn/eox4K3QNDMyzVw00PewA22xQDlF1B96pgb3qwPVi1hfTTng0vQB3vnwQnnFJJFFCrOlkmnR34uqOrIrkdWveiDr903bDx4bT5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681154; c=relaxed/simple;
	bh=hCdmMYQdl7Bq1AVpiscrBlBESr4As8wc/YnOagesyLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUC1PVayg0CVu1jdVDKBNyr8QusY0XBOMEPmnXTMleQtjRsQzqI14GoY8UBtOF+t8YyK9xnTDMCKsnTsT8q1GlKkL7MXh2WzCjFzdjyqiD0B5pDIQh3XDa7jAapjKm02VvbTVuC1EGiFb6E2qzVmgKH0dx7UR4dyo5f8SVejo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KbeHfU3J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MZGwyuja; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlVIZ2554421
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YT9nBxzRwOGhdaFlMTQmBnzt
	oTUtZuh0+unpXnt98jU=; b=KbeHfU3JRqpFXUFIctk/erizrZMhz7eVjxQGiE9A
	bvCzEwUSm7lB1OBjphhTzRDHqidu+X0ysM8A4tysMURANiUt9yeQD09CqD24KnxM
	O3z/YNg+OKIb6LcK6BJFaO2Da8sqS54QVK3T7mIpKATTCeugFYpq35EUOb180KGI
	cmUNOHi8c0ZjgRZ9IjEbOS1EAdjQ0A+aqgb1026JNLsk8UxQitR4I+DeLUbb7iv8
	raPIwJSINHg61113g31llPbN6tWm//wTSire9HoemHL29OvtDDuf5no9qBZZlU5Q
	0s1K6e8VrUXG+fyb12VV7FL0Gb5F4Wx7ruvnHxU56PjSqQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a100aq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:52:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e89f4a502cso194248851cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761681151; x=1762285951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YT9nBxzRwOGhdaFlMTQmBnztoTUtZuh0+unpXnt98jU=;
        b=MZGwyujaTyzS7qIEZLRKYxlPKnDO1dxKdZWIitgedkLiJYwt+eVvOIRsgoZaYDRDYr
         iEGRcdeVloDJd093ALpKY6aT1jMQ0CK9MOn4DvlUDg4XbiYtJUuchjfbBClW69t9JPvG
         8seMoEr4v81KdBZ99tVkJkm0bvT2DkpMNDzCWBJMrnvwCQI7kQJseRsRlQaPNI2+CzsW
         RP8lykm59yh5tc2VPe6e44W0g3bz2YE44HICLawTfIgSTmZGkaY9RDC+oa+LZlrymNxS
         3bcTATUywskmEwO9M3okn2HisYeGSkgpLDE25LLBga+avsZEfn3zJvO8AUtUOmaKADse
         WoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761681151; x=1762285951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT9nBxzRwOGhdaFlMTQmBnztoTUtZuh0+unpXnt98jU=;
        b=VtewD2Pvjr8EStcFf0RNbNGKIiMVegeDWroEnYDM23KuwMVBzIyxM5R4v7kExaVTqU
         3RXXqoliRtOkJkJa1Crtmo9buyGAyGbxbo+8zULr0HtcKxm/AiG14Ji0jjisEKlmeaBL
         9pHSHtvITxZxEsVwCabPA3nGSWOVLibYBhYcedJlOfclzmcWMz9OirRiq1U5tQsWSZjr
         ukS7fXqxDG8dpk5SCRwVDrOkUdKfss1i0gndJCSe1ff15BTEuC+oS6FbEI6Nm1D8ZQiy
         GDTJCxBEWXBqA1IvOTNGeu+Pqi7Sm9tS1u5E4tif/mD6IyKkUYDtsIKhMVSOg1bimm0t
         NGIw==
X-Forwarded-Encrypted: i=1; AJvYcCVeHvxA0m2e7gLiKddAAZQx7OHLpCJU4vaRAJfvaH8QTZJM1O8hfyFafqkyqReAPNL6fjNdMuKjtt3PNTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8ly6jN3ZvKayPkZlhgtvHix0aUZA74Lcd6BKRMSbprHfEjuv
	EnQJQND262hpViu7HDJXgboTerZv2vMJrqtc/IQB8N7X779/LBQOKu5Fjh7UKHU9linuWoOQIWg
	YrtjZqUFylB22F4xfMuePsi2vi/gFqkA9D5c6GWson7f6jgOuCWyVWykV1sWF+tqzAF8=
X-Gm-Gg: ASbGncuAAzyLuw0VupOAjuOOmgrEQrIfCJEgI3PGNn4GkDEc/J726xxYU5/Lw4d1Ryd
	QdpIO9ibBqQDamHfIcvW9OvJxxUZoqCeKvq4VoJaXq9D7sF62nZxtHj2hWvi5BdgMU+5T4yGIne
	mcDF4SBKjxBUlY0JWkqnhbgue99UwXT6qsmPXcm5eIyUDRnoDzqPQfwuK4xSN4MJR3RoaafTuAx
	lXXrRBcr4Cs6Go76DE06jFk/88j0sq6N75cplgYiCbIpkHojx/S/NunjpDaUsGeZ/my9rE6QtoB
	rGaYm9cENq2o2C+PrwLwIBMbTygxg4LX0D0sCJos0aoGLZgR7xHG/52TttP69rqwbkqiwpcTCOJ
	1uKcYJ0rQQU+deedf/baGYqwwMJgLck0uP5CaygZSVxW8tqh//N5+mwbNdHaAXEqz+79/ntApUL
	i5iuJdkJv4Ua6L
X-Received: by 2002:a05:622a:418e:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4ed15c47484mr6705161cf.66.1761681151369;
        Tue, 28 Oct 2025 12:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+B3fkJotoYf8TZDvTT6DmG2RnwhQUDzDxIYeTjOWl0E+DhG6+DrycpxzJ9puTyhByx5+Rvg==
X-Received: by 2002:a05:622a:418e:b0:4d8:afdb:1283 with SMTP id d75a77b69052e-4ed15c47484mr6704761cf.66.1761681150785;
        Tue, 28 Oct 2025 12:52:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f6856fsm3240936e87.68.2025.10.28.12.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 12:52:28 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:52:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Rob Clark <robdclark@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dpu: Filter modes based on adjusted mode clock
Message-ID: <da56lghirjcwesz4usdlfpttwcmvoql2h6bvjommoyfskjdkgk@hrlgx4ukt4aa>
References: <20250506-filter-modes-v2-1-c20a0b7aa241@oss.qualcomm.com>
 <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6381550a-4c1a-429d-b6c1-8c7ae77bf325@linaro.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NyBTYWx0ZWRfX+HarlH0L5q36
 11q/BMZNfEZKAKn2VY0mvSQy2a8k/eLXdUCy/BVBwXHnRfXqK03zuwXYt0VmKVTymV8fZiWW/XC
 WN9lF1vghn1ZX0dNWoWtpdIyqlQvQiaDZQmiKCzjtzI5rTLbI3kZpmdfeZf7gMgqwSyJmCVSCwD
 1s4pkgJfgcniSezw7mBh3Ya1FzVQQlMsajMl/xCqK/uIDqThxo8SpiG6NL6Rw1WQ6c0FuGuQuDJ
 1NHDXn47xYRVdg7lWVmzHnkwI2I2Xcgf5kudbWgpP2ELcDNO0kTjBR3rA2h98Wc0HBILZ/v2ptm
 2A6nXleO++Ns1MfadIx3aRFiE/yckV9zKkDZzxCy3MVRpLBCQ8dqDAdBN1dmrV82yTpgC7KJKFV
 Gj8eY5A8nHPppb1S0dtRTjGwHqPMWQ==
X-Proofpoint-ORIG-GUID: PYB8tMIzY7gKWmDtizjafWLd5jbVPTQN
X-Authority-Analysis: v=2.4 cv=EKULElZC c=1 sm=1 tr=0 ts=69011f00 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=VtADSE1--9cgGQuNLtQA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=d3PnA9EDa4IxuAV0gXij:22 a=TjNXssC_j7lpFel5tvFf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: PYB8tMIzY7gKWmDtizjafWLd5jbVPTQN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280167

On Tue, Oct 28, 2025 at 09:42:57AM +0100, neil.armstrong@linaro.org wrote:
> On 5/7/25 03:38, Jessica Zhang wrote:
> > Filter out modes that have a clock rate greater than the max core clock
> > rate when adjusted for the perf clock factor
> > 
> > This is especially important for chipsets such as QCS615 that have lower
> > limits for the MDP max core clock.
> > 
> > Since the core CRTC clock is at least the mode clock (adjusted for the
> > perf clock factor) [1], the modes supported by the driver should be less
> > than the max core clock rate.
> > 
> > [1] https://elixir.bootlin.com/linux/v6.12.4/source/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c#L83
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - *crtc_clock -> *mode_clock (Dmitry)
> > - Changed adjusted_mode_clk check to use multiplication (Dmitry)
> > - Switch from quic_* email to OSS email
> > - Link to v1: https://lore.kernel.org/lkml/20241212-filter-mode-clock-v1-1-f4441988d6aa@quicinc.com/
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c | 35 ++++++++++++++++++---------
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.h |  3 +++
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      | 12 +++++++++
> >   3 files changed, 39 insertions(+), 11 deletions(-)
> > 
> 
> This test doesn't take in account if the mode is for a bonded DSI mode, which
> is the same mode on 2 interfaces doubled, but it's valid since we could literally
> set both modes separately. In bonded DSI this mode_clk must be again divided bv 2
> in addition to the fix:
> https://lore.kernel.org/linux-arm-msm/20250923-modeclk-fix-v2-1-01fcd0b2465a@oss.qualcomm.com/

From the docs:

         * Since this function is both called from the check phase of an atomic
         * commit, and the mode validation in the probe paths it is not allowed
         * to look at anything else but the passed-in mode, and validate it
         * against configuration-invariant hardware constraints. Any further
         * limits which depend upon the configuration can only be checked in
         * @mode_fixup or @atomic_check.

Additionally, I don't think it is correct to divide mode_clk by two. In
the end, the DPU processes the mode in a single pass, so the perf
constrains applies as is, without additional dividers.


> I'm trying to find a correct way to handle that, I have tried that:
> ===========================><========================================
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 48c3aef1cfc2..6aa5db1996e3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c

-- 
With best wishes
Dmitry

