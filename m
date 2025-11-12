Return-Path: <linux-kernel+bounces-898213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E889C549C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB423A4F50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8722DE70E;
	Wed, 12 Nov 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YD2SZpP9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AKCvxGLq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BD28C84A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982225; cv=none; b=K1HW/BrzINATRdMfxaOGt0OWTrXOAWOZGF8QUzlxZTs89p8uTq/w5uj87EIGv9Vra+ASiQQTVqElln7Gy2MloiF70N6DQIQ4Um3I2ea/8gHtGxnSy3JPlDUAleXuucD2DJ3XAwmA6ebrDuXij6wZutLsU/LcRPgkLW/LqMIgVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982225; c=relaxed/simple;
	bh=H1Uoy00p+mpjYySb8hYZmCgXX+v91D1LelskMLIkOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+ko0axvKvRY1oAx/4CoPChaj80GGVhyKm3dt7Q3NB78qiN4xmqPXMlGLhde3+yRkH2aiyDtMky29XoxQDtsisZC5pE9Qh2SaD1k2os5YIkkqNwAfINBgRPZI4IQ/xu0BjXPkuNzoYyKlg1C/mDEChU6WhUu9r+vCX++ln4PQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YD2SZpP9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AKCvxGLq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACIPTKH2087276
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HzuIoUBS8VbswRplTInLT2fk
	Qljjik4GJUFcI7KziZE=; b=YD2SZpP9HxI4xd8RSogOLslROFGk1bv3B3g0qNlY
	U1nNwWs6NZjyNomvg7eIn/Z9E7su9vAhT8oP8VLEBW43Xni/lVWdb0c1Br8fX30I
	L5zyORK39ylhlHzgg23rruyWS/rop6H8NztWHE49AUQjp/8S+fCMIxyl9dczaNmD
	1xeRW5ZvANN11/eevndnQEnqJsEErYOGhTE++JilTvOKO/oYEM4hJPPwJFHff9zG
	54mgabcGscUaFdhFDyLPpwEoeDXHnQQ8pe3CXSfkjBkdSWA7K/gLkyikzWeT/qyC
	AOcplgixsdeccSbdFH3QdR2DsJS3KQdaaE4fX8t5Djz31A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acygm8eme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:17:03 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e88c912928so2754751cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762982222; x=1763587022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HzuIoUBS8VbswRplTInLT2fkQljjik4GJUFcI7KziZE=;
        b=AKCvxGLqU1H06mQsd/ngI13jCKl2VtwQFQ3pt55tuIVO6kEwukJT9acgmZA9y2hKP2
         8kqx9mmss7JwCwr09k9K1bEKDs7GKKH41Z/nXs4+Gyrv4Wrj+gNLQmpyrZPCyRB/X9uv
         ukpmwAkD9YIEef/ipBpkdFjnUoS22DzUH1qg4MIOQhDXdhPyyeCXAZiqJHWxOLdJuj6b
         //3VxHRDuBRJ9JNArK8kk9QbgsBiDh3AMKzIws8zM1Y/Z9+0SkWyLoRhJL+VkXZZhEmz
         Vl0a4bXQDWDipm9vQm/bJ03XrskeL85crc8BsJMGsSl2CkPOmtMbdeLXWml6FkF/kgQy
         UqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762982222; x=1763587022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzuIoUBS8VbswRplTInLT2fkQljjik4GJUFcI7KziZE=;
        b=C5H8Fc/x4Mek8/rd1IBYY9vBbZJXaaY5dWA82hvbdIWLdn42brJmJOMr9OlpcpMBfc
         ZONtTm9WzG52GsklK8l04XMmBhsMeW74+Y+wrzNSVPy0oA79mMTS3j7H7ZfbnjG7YsLf
         ljMYE6Gjpq4Fc8hD4YRm2WjVh3oJL4mia3PffabFU3SgD7qyDX0F7Urpt51JVVQhFoXW
         gGfXv4obWztNgFWK2OgM6RdSoGM+jtWCLXxp5bu4FJyugslsV6cTsYTbEobDF5H4egO3
         acEDNEQ1E70h+JhCzvDXAHRqGthDcgfjkJEFgT58PAndQ9peuQwxjfSzoUHpO3IUKnjh
         Ws+g==
X-Forwarded-Encrypted: i=1; AJvYcCU4kTpsKGjTou/5svlJpmsZS59nL4Coqi1dM9yTvc3fW5Fim3id4+nm4CwCn66cZUcwUlVu/Obiqav6diI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYInHDeoT4ZzpFqMmdtK39LWh/WaUlLpnhNQfnvkR9Fq8po4vK
	TlQk5EJjIUdMTTnLO4L2iAFU33Tvg8sN97YVn5Hu9vELWFf3YZXPwxsw+2eGoeCedakcq/O91o9
	JtR8/qWblF2ANWXjkS2wc2rMJt3sH8sNZ08bjYV4p02zS9Bh4y/b1GnUXdasFyXD89/s=
X-Gm-Gg: ASbGnctV61emsbXAkO8eIvDlANiEYRPXDII6o1JT6RC1IOH29DH8esN3v6yCEIF9agg
	L3uNcSkUNSp92xN/AtGfWOq32RGVqbJMNEn0eG7bRpcuc4DxESxd+sgrBYktcjFTVa7ZRYpQk3g
	Au+niuqbautSvM6yxPG+223pJO5UPOdj3bmhBBiKR8XI4nfWKNF7OiE/uu8Ig9GSkDkcHP+nKBe
	dKxKOxPOFXFrIemS6ziL+ZCxOEnMEbMRbfm9oWCbGMTXPpX+Fh68kAtxCsyaEz593Xv4Txu+1+z
	02EWNqLWrBGCdBweILgjiU/LOjzatu0QW/dxAWtlSkHIOKD94vaDrKp/lI81PYxDcqEi4XwpXN/
	Cu41YmoRMjDrg2JXSEsmtbHOqL26qYANx1iSDymUIRUW/IVHHK7M7mtiCdhBPZMsXMmOY4DnBs+
	H2J5wSZuX4yaah
X-Received: by 2002:a05:622a:284:b0:4e8:9f18:6e50 with SMTP id d75a77b69052e-4eddbc90f1cmr59530391cf.27.1762982222427;
        Wed, 12 Nov 2025 13:17:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCwXv5uKswVvfqtUeLVRLnBHhgpN/Be5is8xuttmJyNNQ7C9loD59anpFc707xQWQ7uyj2qw==
X-Received: by 2002:a05:622a:284:b0:4e8:9f18:6e50 with SMTP id d75a77b69052e-4eddbc90f1cmr59529871cf.27.1762982221892;
        Wed, 12 Nov 2025 13:17:01 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm6237915e87.1.2025.11.12.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:17:01 -0800 (PST)
Date: Wed, 12 Nov 2025 23:16:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators
 for HAMAO-IOT-EVK board
Message-ID: <rakvukrdsb3vpr4k22hgvbr2yc65me32uezwrqgn2573kblirt@7q7pgr3nkvso>
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
X-Proofpoint-GUID: VNVL-7CRxtPqTdyrOX2NVX626xcyqO3k
X-Authority-Analysis: v=2.4 cv=E/fAZKdl c=1 sm=1 tr=0 ts=6914f94f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fmVD6mvdgdatrdQPAe4A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: VNVL-7CRxtPqTdyrOX2NVX626xcyqO3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE3MiBTYWx0ZWRfX1CbLdIIzi9pi
 3AsdHl/AWzaLIXjhQs6b4pfGuB4fgkj3iouG0pCJVw2lFThei/vR0+zc/3RbM2ZS2NNRvydBy0n
 la2ULFvRqAJ984yBw88Aij6K9Xx4itS7OBLKNgUG3c0g1I5amDMslVNb9jhTCAjE43zZx5XnlpC
 5gYzu5xvmxgU593mupU7TzmwNrjkmjFzVlWP3irFOd9j40ns5IaMV/jIUFMHWx2PmChCzgxkG9y
 2UiLD2CYyxebeNtMI2YliaT6eUTed6svILLvsJl8/jK+2VmYYxQUOwSvJ7BLlHQoGY0TCj8AMLg
 2ExO7c9BB7Gqj9L1dJZiJE7I3lzChDfPSilBnqIbq0dnF+mnakTvgKnIvrL1I6cLZvjYb3BxM13
 cwfnkF4xCnTDYIYENj3lUzc78KEpiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120172

On Wed, Nov 12, 2025 at 05:03:16PM +0800, Ziyue Zhang wrote:
> HAMAO IoT EVK uses PCIe5 to connect an SDX65 module for WWAN functionality
> and PCIe3 to connect a SATA controller. These interfaces require multiple
> voltage rails: PCIe5 needs 3.3V supplied by vreg_wwan, while PCIe3 requires
> 12V, 3.3V, and 3.3V AUX rails, controlled via PMIC GPIOs.
> 
> Add the required fixed regulators with related pin configuration, and
> connect them to the PCIe3 and PCIe5 ports to ensure proper power for the
> SDX65 module and SATA controller.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 83 ++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> +&pmc8380_3_gpios {
> +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {

What is sde7? Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> +		pins = "gpio8";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +
> +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		output-enable;
> +		output-high;
> +		bias-pull-down;
> +		power-source = <0>;
> +	};
> +};
> +
>  &pmc8380_5_gpios {
>  	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
>  		pins = "gpio8";
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

