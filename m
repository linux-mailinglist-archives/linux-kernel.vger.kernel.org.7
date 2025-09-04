Return-Path: <linux-kernel+bounces-800922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D51B43DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A9CA04E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557223002C3;
	Thu,  4 Sep 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJUAFgrg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FC72EFD81
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993953; cv=none; b=hdG2Gk6wsfEJwSrueln3HnAsauI85KMdGbuUW9IgcWHBwxiGWXEy53ALtuPBlMh0Pq9BNWh+wcxiOJ7odE0DW+b6UVYKrWdbwPdwRAUfrXCNZv4SZvctOGf8vEOiAKWZSP2VrYRASsn6i2b6c/rWoqaoY5FJ/PLx5akJN3mCP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993953; c=relaxed/simple;
	bh=HIX4eku98Wc54feYB0CQVeLO6u4tKzM8o896BSZOplE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC8SH56ycIos2lLY0R9DUqMVfBCPUquf83j0qzZ5S060S981bE3IQoPjOoYE8n1FDXzNUBONitFGn1KShghl9Ur/q7errJ/kso45uzfO8BJzAPYq5x6wywzazOlYOAJvZPgR7xwad0GQ3XSFaO0VOF02ytBiF4ICf03xiPTF+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJUAFgrg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XMDE022487
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 13:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N4tKvhnJISTCkWgQtCnG+ZlZTaMj9wRAoIAEATKuC6g=; b=jJUAFgrgLl1eO0XE
	H435B9ors58IzgB9fud572oJwSlLJJ1zz1V3r3g0JZEvX6XMeB1ezvMYv3sg7VFa
	z2pUlv8pMnc2ozaaGDPlq+R/FpPUsOgpYYjtzXrwO1hn9N1fAarSrjDbRGw8WqlW
	DiyKjciWFQsKfz9Lr/Ts97u+vGK1tzkJ9Jt7aYEzoaDvXEreEoQ+xiDt+UNkpysT
	Aq45yYvWMiQx+MzI4Nc0zdIYMeIvHSPDyBZo4AKIsgD0Fd5zDhYC7CP2Q9b3zhDy
	TkeuZAMAzzz5AogPNNg9YwuqPzXH9osD0I7LnHSsPuiFLxvmQW/yfnKV818qGrMg
	+fP6rQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk97gyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 13:52:31 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7296c012f6bso10656046d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993950; x=1757598750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4tKvhnJISTCkWgQtCnG+ZlZTaMj9wRAoIAEATKuC6g=;
        b=CQN7+g/RwWHVvOGR5NlY440aJj4yqkUl4JEjLvz/IyJfGGFpX6fBeyDfmrlsLCo1rc
         2OMLp1DRg6Ar9Im3P0rp4PJnIrIELhWLewXI2ZmgIuSuB1hCuHdTYly56YLmzFW/ypn8
         +hl45kB4VUHHOF5gfWJnz0582h508e19EucZ5xP45tvqrnsV45WODQemFON6as/w/Vvl
         VDbS96buzQ3J54yAXdEQ4PY2SrNAFNOm5H1SBRlYJLAydE3wSIDbxB7hYjXa07hyLTd9
         1Nxj+UaWpewQjL/LvIbOzT8ca2ewT6tWbI7yMbQKrTxj55YlsSsETeL0U/G6ws+GCq7e
         SnRA==
X-Forwarded-Encrypted: i=1; AJvYcCU/lP0+bv2YGU3lPhRr6h1IMcwJfjCCudHNyvCkIcTj6GmAHIki3wOhri8aQPXcepw5oH4LFRLTW2ViU8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6pDNjRW/NeHQbhDtbLpn/h7RJFHC0iHheGDgyq36I5m2CIKQ
	dGfHmwZAErsJVWo6SP4lD6+maRlcpBeaw1D3fi5YNRWLiQtfUKGM2vXQNmgzc2DitX5BpFPxcxc
	3N/40I8gDZDaTwdsMSHzUnNL4tW1hvtXAuw0eYS/44pk9bvN2NLNHqWAx0G0aINTBtxV8DlEOdP
	0=
X-Gm-Gg: ASbGnct5GxWPCy3ahJ8nqChpigUJuryVwSeRKQ+ndFupzg4QrqQG4vhObN5uOcEtT5e
	7mmbYRge5KxqhRoFn5sBNcfCCYQZPvki9Xm1svxTDgCoQy+Y21SMvBsHT+0sdBeMpBFaxp0jkdq
	gZItvlTI4naHhBULtD2mPm8Vk1ttE8liJ4UPsSl3SypM1M0abkNUthmJq6A2vy4P/cDEjU8Kh4f
	bSMuYkUj1qcnyDJR5uHUoX/2YcWo9VYBj6PddL5PMcPz0l2XsBWJ7s+OMPK33RzJMak4/v2FCAw
	uQhQgRTR7+Lbi7rDFvH8U42rURr2ATpekpqrR1oMynKYEXoJtdiflooDcY/w47aXbK1O1zxEnp7
	QP0vx60PNBJlpuNGlFp3K5kSkOXhpmPlfy/RwlhTqS70VvhKFzV26
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr71502026d6.3.1756993949801;
        Thu, 04 Sep 2025 06:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0EbzO3RGw4eqBINrGkwEPKwOp5hhL8Lt3eiyZMY3NmrRXVtmOrj8S+YObl1fR76T6Vkoa2A==
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr71501656d6.3.1756993949282;
        Thu, 04 Sep 2025 06:52:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608aba7e15sm1241448e87.52.2025.09.04.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:52:28 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:52:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 2/3] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
Message-ID: <2o2ypmxo6wbohrb5edkj27ueqpgbqhsnqu4ofzfubtfwg7vyri@mdsu4ca63fr5>
References: <20250904-hamoa_initial-v9-0-d73213fa7542@oss.qualcomm.com>
 <20250904-hamoa_initial-v9-2-d73213fa7542@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904-hamoa_initial-v9-2-d73213fa7542@oss.qualcomm.com>
X-Proofpoint-GUID: 11C1z9ota4OPUBs9QnWwrEgU4EqFIZUt
X-Proofpoint-ORIG-GUID: 11C1z9ota4OPUBs9QnWwrEgU4EqFIZUt
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9999f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PhgHo22kut4TJJxNvVMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX/1qbOT9pmkFH
 5LJ8+3qM/r6ynnJSKdwFiJrkHT/s31GYTrAYAjM5gRqPBnObzDdfiNQM18TWzKUj3pkOlYCMNqW
 4FB8z9E8jb5qgZB0o3XPhKTqDWSf4fFg12vtA2vb93EceZmNulcZ+3WgfgT2VkK9ZVtVvuzqnqG
 yiTxcqu6zYntb7mr+nvayGJIhMDuSva982/U0jbYH5bM/CVJERMzjIq9K3PhLAabxBu0aCpi9vp
 UxSLZvyd2xDlvHRBa1aDglukgtzYPn706E2aue4dizsOMnEFA3y/NpxO3SBJzSsnIRii+YKYlgD
 CW6lx54wPFJdy9OFs0W/kaFvAY/a1KFrkgFTi/fRSdkkvZHLpsR80c0iy2U/RS0XZn9c64Vd5Ui
 0l9r1GTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On Thu, Sep 04, 2025 at 03:48:33PM +0800, Yijie Yang wrote:
> The HAMOA-IOT-SOM is a compact computing module that integrates a System
> on Chip (SoC) — specifically the x1e80100 — along with essential
> components optimized for IoT applications. It is designed to be mounted on
> carrier boards, enabling the development of complete embedded systems.
> 
> This change enables the following components:

Documentation/process/submitting-patches.rst, "[This patch] makes xyzzy
do frot".

> - Regulators on the SOM
> - Reserved memory regions
> - PCIe6a and its PHY
> - PCIe4 and its PHY
> - USB0 through USB6 and their PHYs
> - ADSP, CDSP
> - WLAN, Bluetooth (M.2 interface)

No, you don't. WiFi and BT are not present on the SoM.

> 
> Written in collaboration with Yingying Tang (PCIe4 and WLAN)
> <quic_yintang@quicinc.com>.

Co-developed-by, Signed-off-by.

> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 609 ++++++++++++++++++++++++++++
>  1 file changed, 609 insertions(+)

> +
> +&usb_1_ss0 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;

Please check with Johan or any other X1E8 developers and make this into
a platform default.

> +};
> +
> +&usb_1_ss0_hsphy {
> +	vdd-supply = <&vreg_l3j_0p8>;
> +	vdda12-supply = <&vreg_l2j_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss0_qmpphy {
> +	vdda-phy-supply = <&vreg_l2j_1p2>;
> +	vdda-pll-supply = <&vreg_l1j_0p8>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_ss1 {
> +	status = "okay";
> +};
> +
> +&usb_1_ss1_dwc3 {
> +	dr_mode = "otg";
> +	usb-role-switch;
> +};
> +

The same.

-- 
With best wishes
Dmitry

