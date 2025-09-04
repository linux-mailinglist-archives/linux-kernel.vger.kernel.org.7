Return-Path: <linux-kernel+bounces-800935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8897EB43DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C176F3B53FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C61305E05;
	Thu,  4 Sep 2025 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TD2e84ab"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB82D6621
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994305; cv=none; b=GE3MJESw71vL72t6TR5uzrkdjRUdHclxsF2/3GrF4jSpG5oKBlam0gXLiRgb/r74zx1Ysmfy12c/4cyjKQOwEFPVMAyW4EQIzd5qCPqJ2mABLjxK0M1evkmaoqbWjVkcQssJkSpyApGff1Y2ji7CgkpwQrm/uwUskpCql5BE7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994305; c=relaxed/simple;
	bh=8pcinqgMIZxfWHXEht2qh36JiGk/vHy4x2DTtHokKs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihvvghT/y04/YK+ytnbQCosizbl798C2dvzCuKXO7lsiVUDuEmN98ZimNc7eFX8aoWDQCF11vM2uQ4RfQ2L/tYLIl/ua3i0EI6njprT1o7v1RzjSqMB/wvLlPyhw4AXyHTNjcXTcjp1brpEpi2xdmqRB+6bk3Ytxfw7qWTYOo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TD2e84ab; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849Y4ho005051
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 13:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lk8hEdBosykMJy5XLeywfmQ3
	hkUqyOwk4iBgoodWgA0=; b=TD2e84ab6Uy7j1qvU3KxN7qsmVRvPOwf5dSF4mJf
	95Pm0uyl6IhgpqZ/iX+vfEl+KPs9g9LeLabUNy07iyrHwhMeuHk50WyrmFkptf4p
	jJrZp36gzZmqQ0X1b9bFJ2qbOBSQtI8mAYDu4bxKDYqzs7ZRTevExLPRpLSFzkIC
	W2wAMczzc9vGAC2R18tY+/VHCiPcvlXGveMXNFLfO5sDR7DaEeHA6Rqvm35bTCQu
	yRBMEdy/5eBId3ScJj8H/ilW/GoyTl33gjVAp28bAf2WUrmX658kdoqimDcFlSYX
	aBEYD1Z+0oV0HESYDE+hTRkelNRjHwsejDc6sp5ntfEwsw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s7ra3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:58:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b49666c8b8so20959781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994302; x=1757599102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lk8hEdBosykMJy5XLeywfmQ3hkUqyOwk4iBgoodWgA0=;
        b=GHs7fU5htvodXmYa4I/TJ52QockrRY8YP0A2Ba2T2BbMiO15H0tdWid0W8l4n2r/kH
         WlsWkTldqKP1DY3WIcjy5fxYYq+4OHrCJNidq30V62Uyr/kgxlNWwAUfcW+/0zRsBz8J
         OSRUu/BJ1zmC/cwXKXdMClAIM5tNrvonPgkFkDtm057dUl8q5WqbzLHX9sqvBwUsASt8
         eVqnAMpj3UpM9JW1xtvVFvnWn2m8zr6IzzfnK2UVuj3YG4kYun+RatTf/Wa7zZhV71Qr
         TUae4OjB/wgVILVMyHVQf2dO3csHJIZoHG2tvVGpsVlRZ1l9hVr8pP+l7VXHWnH/gLum
         wlHA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQLTvtShsyF1E+8y5qgGzrVn0E8oaqob7YGmQyzZonypWLJct8x3VAnL0gD1Ojoo5OeiEZP5Q4Dsw764=@vger.kernel.org
X-Gm-Message-State: AOJu0YznL1C9j6XC1AYFq7zhSBB3RQsxGfVfsp61KJ80EVGQc4cmWUCN
	ftnUxNdF+nBdb8qvp4Z5cb7xHok8B2ZrUYskMzjKxMOrn1x2+8hdqHottau0D20YblTJsOe8Fd9
	IR2j0fZbeyva/x1Kg0/W6BklcgCWkLb1j8ySw0skmi5ps89b194wKPcApI4fNK5BKCtc=
X-Gm-Gg: ASbGncu+uOTT652kme/BqGmNhSIvtuHPbV8Or8FHx+9U9AjRMEngO7yfM44fV07E81r
	bqspCUpFeaKMgONgw7I/QH9n6bm9fRVKmDtANhkQDYf5b45uyvuQ4IeHzfZdtrtHkUaV1vlv0vO
	WclMVh/BG0HQbJmX6QMuELBx9FPnYEz3Su5egW4oUXkc1f8M/xHmvdVWRnzF+pc9KPb8sR7deC0
	J/Q0omFvirsBWu03fT9JrVynoKvN1/3wkdGdvAqNTup3jz6decTeRWqEF47xmuXoxt1esoE7Yvo
	qBzccztJyZcdyDypHep7XIKYJJZGkbeUAa8VcGUsJENeThBQUrcjQi8KRmX8jPl1T8ey0A8EemW
	b+xp2rpWMrIt70Ou8qFbJcV6Fsn2mk4jmL0FPYRpvyfF/HxPdlSGc
X-Received: by 2002:ac8:59cd:0:b0:4b2:8ac4:ef4a with SMTP id d75a77b69052e-4b31dd2126dmr208884801cf.65.1756994302159;
        Thu, 04 Sep 2025 06:58:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOwIoZdKCnb8w1m3GAfoE0S6ahe48XHy+4go65RZaBELSpnCxA4DhortdmwPw0TwHA5cpPww==
X-Received: by 2002:ac8:59cd:0:b0:4b2:8ac4:ef4a with SMTP id d75a77b69052e-4b31dd2126dmr208884421cf.65.1756994301497;
        Thu, 04 Sep 2025 06:58:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c503edsm15199401fa.10.2025.09.04.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:58:20 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:58:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
Message-ID: <eneg3nxaatpiqvujxnvfexwdgb7mufoi3qn6pjsxh42e4n3tqz@npvgjdh5cu5h>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-3-d73213fa7542@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-hamoa_initial-v9-3-d73213fa7542@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX2ayRuUzVlv+p
 PsMumH6FppeT/ukX4phjN292bqiAffwU10539J4iTWq5ylsbRMpZZ4rEopRyuuE67Qooi7MwB+A
 6aYGJ59AN2pmYaJN4WmTWY0v5jmqYsOWD9tXfUsHUOVYKUsxZ4NhoWN/cs+QULy+PiSp7iTfcDt
 bYUObyVnDxF7ELLNyNXCUxsQfnacmiIWVG92JaER4Ojg6JJspVCr/XmdEagjU1LyZYwc6/xHiGA
 KpKX4Yu6j6vvn2oRWs8aks2CV7CRWNCD+36l8Wjo7L5X2S53PPcMsQP5epiK5JDMOpTZMYIZk7c
 spMWUaKvgztLOyia1q8IJAn3rz9OSEtTVUsBTqHzmoSTBwxCgQw2yd2/ONkuuokl1kbZMvuIj+y
 CxWbYgv4
X-Proofpoint-GUID: SO4g-Kk5X78AHiNlumKh9OVBQgqo14CW
X-Proofpoint-ORIG-GUID: SO4g-Kk5X78AHiNlumKh9OVBQgqo14CW
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b99aff cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=kMu10WXGbiujYwnt40gA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On Thu, Sep 04, 2025 at 03:48:34PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
> the Hamoa IoT SoM and a carrier board. Together, they form a complete
> embedded system capable of booting to UART.
> 
> This change enables the following peripherals on the carrier board:
> - UART
> - On-board regulators
> - USB Type-C mux
> - Pinctrl
> - Embedded USB (EUSB) repeaters
> - NVMe
> - pmic-glink
> - USB DisplayPorts
> - Bluetooth

WiFi

> - Graphic
> - Audio
> 
> Written in collaboration with Quill Qi (Audio) <le.qi@oss.qualcomm.com>,
> Jie Zhang (Graphics) <quic_jiezh@quicinc.com>, Shuai Zhang (Bluetooth)
> <quic_shuaz@quicinc.com>, and Yongxing Mou (USB DisplayPorts)
> <quic_yongmou@quicinc.com>.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 1248 ++++++++++++++++++++++++++++
>  2 files changed, 1249 insertions(+)

> +
> +&gpu {
> +	status = "okay";
> +};
> +
> +&gpu_zap_shader {
> +	firmware-name = "qcom/x1e80100/gen70500_zap.mbn";
> +};

Why do we have DSPs in the SoM, while GPU is enabled only in the board
file?

> +

-- 
With best wishes
Dmitry

