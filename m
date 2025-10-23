Return-Path: <linux-kernel+bounces-866868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68583C00E43
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3897A3A49FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008830E821;
	Thu, 23 Oct 2025 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AG/7kiHs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52B830E0CE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219978; cv=none; b=QrYcPenM6qVn91pv+kC38KpxBVtgPG4ndl2SLFY7hF6zyan671/+UUbrZOPT8ND6D0M82GL8B5HBRj/yMJosbDU8fmVF0U+LfWz5MVolJg4bi7sc06oUaexrYy0Ld5LqA12y49cXGA4+1nskyTehXn+QtovbgCtfjW4NCcBZuxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219978; c=relaxed/simple;
	bh=wktu7qOGetTfmxCdZDCA++hXkuBC8rTbnXyIqghi7Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T96CALMyQkf6u/J+IVScAktwu850o/U7Ta35QarREWz0DwJ85UiwDn2onlAe/C0gh46u435c5pYusQi0HepBim4X1BrwRAhso3euWHj2Am/uZZNsSRORgW5uuoHHxjjKQ1toaeKGPqZbN43HGDdqwhUvptdm9aJln1N/rgvShk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AG/7kiHs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6jQBX032067
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MxuIotyBL55oBcMXr+JxN4AV
	8Gzau+khOnLw0uMLwiE=; b=AG/7kiHs7N6pOQg3k2714gtxaacwe+b11V+Qxw0I
	Gu3nGXyQXnnl2wcGdF4vMjXMe/9qh3BGYvdzCS0MsPOsKxCTt/wzX9Rq1tl2xrbU
	73PCUnFsHIskxPhes8UiAHznc8EZcKfCyUud6Wvtk9iD71ex9VJMS/PMvMgfMZMh
	nHr3826/BOjI8mxOxiIhGQJZKLIdayhTdzbGifxonGp2Ot/2dcR6VAqaQ5CPKyKx
	7OOdihE1qqqXk2t2Rtmgx0354pQ2uieNY437lT1DP0qdHgHr12jP8xDC1IfgsH+9
	fRlKxhSQ6lyIuk8OotssUFYlf49PYcTYFgoQbXxDp03SwA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wdwdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:46:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e88e094a5dso33349401cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219974; x=1761824774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxuIotyBL55oBcMXr+JxN4AV8Gzau+khOnLw0uMLwiE=;
        b=YHmzKVI2LaErC8fc3YiljMmgS/KgUx1gHvpuF7LK/yX16+EeKwC6GAySjT+ciE+MXl
         E800+9R5u8eWQf7sKkYIdJJfSaawjfPgXORQ5jJP6+nX9jBlmGeum2mA+4MWBgD1IApx
         j+wdlQ1PEOefCjTrUiBivwURoqQHkKpgnKLOwGZOk2JaK1HCCttWtFacv5mpRCYUGvYb
         AT4aB0C67HGv7NwOAUHEw2YXaZB0MB3EXBAqoW025pkktIU8Y2AhJdaqaR5tNeqplyuu
         5TEGINAKg1RxG7R2rqPYX08e6r9JCvObshoUcZt4yD2EmDUXfl5hw81qptJGBIU30jq8
         yHjw==
X-Forwarded-Encrypted: i=1; AJvYcCUv7svWMMSkivWsaQaBQDkybEeK/n37o6/43O5VkQ0LMqksl4+EHhtzL1nmygKQoyeBG+bi8pXy8l+4tv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+VYmeDdd6yfVspKfGpZpXQ3vv6k6zMrLbeLwgT5pqzV4gODgr
	iMsMU0yUWHlankeBVsD0ng9HyTzxx5KjTKnf0opKFiZVTFrA2Q2wku5WJCFeFL+5nvVGFInEaqG
	ZF0des8QnCZOUgKfdP+mVYrcWInxdPHuybb4s3T5s4FS1GC61lMPHF2kZkVT4u2U/5HElt6bq5A
	4=
X-Gm-Gg: ASbGnctEQum5vS7dw629mHUOKI8SbAQZFxWnXTRhMJt0E2UT6Hvuk3qtgcjvOG/GxnP
	jXkU7iIYwD6PG2pICN4VN6A/1TarXsPIRzk/BWxnn8oq84/90y7S4HcUMhjF3L2ohh4qowyg8yq
	9JsyDBAKrUG2469yeduSzl0eVLvRef8OEcGFJIc62Yg3vNiKxTCda92j/+hgGWsx7ydndPHEYHZ
	QCCuijIZlMsBAmWaPJEI6hi/uKkOpWxKoZjqwLrYoHTEW3RyQBBUvme5aIyKLm25iXAVoukkeN6
	Gq6iEDtkjjEFHQRnK0URKbv9wJB++rqDv8ErNKvWWZBt5ZWhAeL567D8a1sChdYQRBn9PplN7NZ
	jK8ahNdMLQKFxzX2mRqgzdGTD7h74cnZJcbvKVZd9sYf9kbZugIzwmbx+sMp4S7MM/Nf0MQcYT3
	2IFLVp+ENNVKrb
X-Received: by 2002:a05:622a:1a21:b0:4e8:ac66:ee44 with SMTP id d75a77b69052e-4e8ac66f4a4mr250238051cf.39.1761219974198;
        Thu, 23 Oct 2025 04:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8+pCnO8ZvR8ffZYHTiXBpe8PitkiTaa+bMCiZZSPHl7XKSC3gu/++FOyxZx7Quca27fB8MQ==
X-Received: by 2002:a05:622a:1a21:b0:4e8:ac66:ee44 with SMTP id d75a77b69052e-4e8ac66f4a4mr250237771cf.39.1761219973768;
        Thu, 23 Oct 2025 04:46:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d39b96sm656447e87.110.2025.10.23.04.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:46:12 -0700 (PDT)
Date: Thu, 23 Oct 2025 14:46:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
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
Subject: Re: [PATCH 00/12] drm/msm: Add support for Kaanapali
Message-ID: <r6kjuxajnimaqazeimzc5gscv2qxudjzkyooxumzakjzojibbl@2jiw6duxfbtz>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: U8PL22ROEFbpqnSu9akaXZAw4LUbGx_u
X-Proofpoint-GUID: U8PL22ROEFbpqnSu9akaXZAw4LUbGx_u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX008+9/NZHcfi
 25YO0uqMu/X1q5D0rhXMf6bnlbYSjpI1GatfM6ZExCsxBU22qDE5qegqCAsyEeOvRLBqa9WQ8zW
 xIEXBUqzckxKWq2hpacjx7m5XZm4TeNP/UL7Rb0JO2iseBXacllbyBPh/Ct8+gXzu21rRou6HFT
 ADih87AAIoUpUwlJe5UZTGI4ILCciGK9ZIFD7DdJJsrgAyJTfaN0WwedYzRprvCpWsA7DufKCkz
 PWTKD+IHFQjR9RWq5jCF7OZDs6qSGQp8ivsN5RQ2KZDK1cVSW3nQzvFVTuDvqbokNd9tuBYdldd
 iQcS43CZ5N9GWDaxp/+jgOK5ndcqAbHNKuAnVNle4vPdldwaMbpO5kxzRqbD4ufdCgfSiqRxJ9Y
 gd2AnROs6dT93+eExYF8M0muaJv7YQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68fa1588 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8
 a=PFSzt4Q9d-Ge22CFuaAA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On Thu, Oct 23, 2025 at 03:53:49PM +0800, yuanjie yang wrote:
> From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> 
> The Kaanapali MDSS has some differences compared to the SM8750 MDSS:
> - DSI PHY/DSI base address have some changes.
> - DPU 13.0:
>   - SSPP layout has a great change.
>   - interrupt INTF layout has some changes.
> 
> This patchset contains DSI PHY, DSI Controller, DPU & MDSS bindings
> in addition to the driver changes.
> 
> We have already tested the display functionality using the Kaanapali-mtp
> device on the Kaanapali branch of kernel-qcom repository.
> Test command: "modetest -r -v"
> kernel-qcom repository: https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/kaanapali
> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
> ---
> Yuanjie Yang (12):
>   drm/msm/dsi/phy: Add support for Kaanapali
>   drm/msm/dpu: Add support for Kaanapali DPU
>   drm/msm/dpu: Compatible with Kaanapali interrupt register
>   drm/msm/mdss: Add support for Kaanapali
>   drm/msm/dsi: Add support for Kaanapali
>   drm/msm/dpu: Add Kaanapali SSPP sub-block support
>   drm/panel: Set sufficient voltage for panel nt37801
>   arm64: defconfig: Enable NT37801 DSI panel driver
>   dt-bindings: display/msm: qcom,kaanapali-dpu: Add Kaanapali
>   dt-bindings: display/msm: dsi-phy-7nm: Add Kaanapali DSi PHY
>   dt-bindings: display/msm: dsi-controller-main: Add Kaanapali
>   dt-bindings: display/msm: qcom,kaanapali-mdss: Add Kaanapali

The order is wrong:

- bindings
- driver changes
- DT changes


-- 
With best wishes
Dmitry

