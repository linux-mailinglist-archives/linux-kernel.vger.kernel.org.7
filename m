Return-Path: <linux-kernel+bounces-784380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77AB33AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C59F484149
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3762BDC35;
	Mon, 25 Aug 2025 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ktg4b7N5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8B298994
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113731; cv=none; b=qv1Q83vXwGd/IFmcjJsxXU+GTapzRDxalaeumSut7h9/Sg1jaLTPXsgHDfrPPR3AwzGXoFBfynsU1PL1tBLMTuL+zt6w8kvkG7IO7J80ncza6dtZ6vmVm1PJ31xY/kNM4Lj2bQtoBe7OlbC5YO0fYrS7nP6+wQBZxeXRH8AAfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113731; c=relaxed/simple;
	bh=9bZNwRqzl8AWUYabscTcxNnDfMPP4awyOttaTxXW8yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlicirRobTvFZTVis3FwhRmnhwjq84wLnMX2+8EBMd6AQ5aZTf1T8QcNq0BYROBZ36Z5EUGzfYcXNgOE+Q1dKtviGX2jzlp+97b2nouYkBJBqHvDFRKLIYbBLkttEEWg+MQBJSeQr86ftGj5rhIdXBtYbLdP2pO0df21Uz+jsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ktg4b7N5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8UqAr025091
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uZhYIuZX4ATTadEC4VVuga/g
	/sTYW1yNnMJwGqSFpK8=; b=Ktg4b7N5GiovvSel0DzO72aB5pzfkvic3nIrgaPJ
	7d+zCHi/+NJ/DBhw4j+sawTKexH/VL/gLLN0XTo6m/OfdUtQtAzOzxFDjH7sMGES
	OYee2Ct0Tvxq3sMUxVdUHpr5CKlB3oca9wf0rrU45ulfemQnA68h+Ryb5vYz2tVY
	9sUKyZlF0jtDagdHlm6vvbKJogDm2ng2YeFkmFbddfDLADOJfKD0h2n7lfIkJb/1
	yGcKiN0qTBSZazOBWMz6ZALRaYtx8BpM1J+P10eA9c7zVmFwwiq0ay+/YXKulY49
	stjDXMNqTh6Krh46qHhsWYAmcDSwUBdwTq5KnPPG7xOonw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5um4kdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:22:08 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704e0264so1087684185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:22:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113727; x=1756718527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZhYIuZX4ATTadEC4VVuga/g/sTYW1yNnMJwGqSFpK8=;
        b=fKbKh40VDVJtUCgzbf0r4xSQHY3gtJJgMayjWhSxl2vQGXfFGGWu8WkRB7m8MUJFLz
         9RYjkzeTqiCQmXHk7CEW30ruVB676O7sr7VzmGS2CpfOxsTJsEV/hmKd70CUoAAjKgBG
         laCau8tqkYrbPx/RmUdo5lMV/ivOFHNUWmDFgnI7ocQRcgDek728368VG4NDSV7zzVR7
         rU+iJp+N/ls6Xw0DEVMX6sEWswC5i9P9iInqepFabQe3P1sPqJnARRnZWgv/j48NtPae
         0YbtQ3TU8eQG7kiGqC2QsVaSuyuxc5PUdwDeW0QpZReyeIpF2LwqOzSI4NKjejPRh7vV
         STKg==
X-Forwarded-Encrypted: i=1; AJvYcCVvAQjbmdO4WHh10vlBIWHFT8UjArXq0GcUx4zvazl0kSkay+oNwC7muuZBO5QoPURs+jDWRswaWQZGtHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfJCUsxfB8U+q4iOWqzS5SsoHHlxcThtXHkFlfKcesvHd5K3wF
	6F8SMO3CkpM9g+H0f1Hb0Gcmgj8Xcv4N9dQJMAHWfQzSEiW4TEV1bVosz0uVsf85IWhcyGsGy25
	o2TMyTFmMnbDEocgoAATDxGweHM+tEpO07gTgqPaLRg9q5obOoO9dWqbYlvi2TEJZlHE=
X-Gm-Gg: ASbGncsvdO6rAtdFcEy9MF65keKMN3s6uFEdSOsVzwNhPIlOFT2wb51JLxp5b7d27Yd
	px5GvfiEa67/SPD1H7F+DfZ/nGrBbuggIdMAQO7fSZj4Xstw0NJqRL+uY1DL024JUkCFSqpxMvs
	pLt7YJClZ4hKVjZiBbc+oWTXcFNDd9YjYFbBIlIidpXcrdo18meCg6Kz9s9dMdfm40z3BtxYphY
	5AP6VYaYv8ml8ywDh3ofIyo4AVzhk160bRnLmuItT09UKedQVVLRl5gt82PygcP8W3ofha43uUm
	qdsttdtha58U8B3FikzdpUQS8HqNqR8GtQj2qJaKCAbQJmi8WjJ/ZsFSasWDleb+W2QQ3ZWISHx
	K/QA12QKIYHm5b/OtI24owOZJvgs8pBBHrewE00NgnaVfnPijFxSU
X-Received: by 2002:ad4:5cc9:0:b0:707:4f43:eed6 with SMTP id 6a1803df08f44-70d97251887mr132407976d6.19.1756113727138;
        Mon, 25 Aug 2025 02:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3V/rbRFQBwL/w5qM/vQJMILCKP6viO2gUQG9twx32eTEgRqBXSWLUWk0D0/yPB9lV7rSK9w==
X-Received: by 2002:ad4:5cc9:0:b0:707:4f43:eed6 with SMTP id 6a1803df08f44-70d97251887mr132407726d6.19.1756113726479;
        Mon, 25 Aug 2025 02:22:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f39de534bsm1393060e87.127.2025.08.25.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:22:04 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:22:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, cros-qcom-dts-watchers@chromium.org
Subject: Re: [RFC PATCH] arm64: dts: qcom: sc7280: Drop aggre{1,2}_noc QOS
 clocks on Herobrine
Message-ID: <3i7pdzata6gxsc3svb3eygubfdfmnetlekxdd25bb4ljkdrlh7@bvufiwmdusqz>
References: <20250823123718.RFC.1.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823123718.RFC.1.Idebf1d8bd8ff507462fef9dc1ff47e84c01e9b60@changeid>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ac2b40 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=cm27Pg_UAAAA:8 a=XzfyJc1qPjP2x_x8poUA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX/Ysazlfk5TX7
 Q0o3xZxn9zTjKWwl95ks8TZKOFePfuTEGsHCtr2guj7+8bK0cveAJp4uIln5xzKag3K1AxPZOaw
 a8pbL65qaEPibEaYsg0LoD4w2YnlE/W0IzOo3Yh7DGi/MgmNtvAkdmJU2HOjPPtPbzqmAYGDPm5
 YC3D+1IQDHk2McunmImHRYQpENkOLrwWA14vwmwAyRP89EhXas8sGJuUJz/c+gPm6nd0FY23kq9
 u3CBGWMtexQw3OgdAJzpKbFX/WqX8z/WF0U2u255V+/dbIZOL0QhrbvgbnjNu0uIw3wknZ/pKX7
 KG9lAR/TJ0n7HFrpVtCKUc0896qpYclTwebbz2KL9Nf4KF9uTzh+ioJtQWqf9Arkep0D8Msf7x3
 FA33IU6L
X-Proofpoint-GUID: zuFXu43WphkWEa9sbRhdqEpX9nlHp7YQ
X-Proofpoint-ORIG-GUID: zuFXu43WphkWEa9sbRhdqEpX9nlHp7YQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Sat, Aug 23, 2025 at 12:37:18PM -0700, Brian Norris wrote:
> Ever since these two commits
> 
>   fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
>   2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
> 
> Herobrine systems fail to boot due to crashes like the following:

Nice to see somebody using these boards!

> 
> [    0.243171] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    0.243173] CPU: 7 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0 #1 c5464041cff584ced692726af2c4400fa2bde1db
> [    0.243178] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
> [    0.243180] Call trace:
> [    0.243182]  dump_backtrace+0x104/0x128
> [    0.243194]  show_stack+0x24/0x38
> [    0.243202]  __dump_stack+0x28/0x38
> [    0.243208]  dump_stack_lvl+0x28/0xb8
> [    0.243211]  dump_stack+0x18/0x30
> [    0.243215]  panic+0x134/0x340
> [    0.243219]  nmi_panic+0x48/0x98
> [    0.243227]  arm64_serror_panic+0x6c/0x80
> [    0.243245]  arm64_is_fatal_ras_serror+0xd8/0xe0
> [    0.243261]  do_serror+0x5c/0xa8
> [    0.243265]  el1h_64_error_handler+0x34/0x48
> [    0.243272]  el1h_64_error+0x7c/0x80
> [    0.243285]  regmap_mmio_read+0x5c/0xc0
> [    0.243289]  _regmap_bus_reg_read+0x78/0xf8
> [    0.243296]  regmap_update_bits_base+0xec/0x3a8
> [    0.243300]  qcom_icc_rpmh_probe+0x2d4/0x490
> [    0.243308]  platform_probe+0xb4/0xe0
> [...]
> 
> Specifically, they fail in qcom_icc_set_qos() when trying to write the
> QoS settings for qhm_qup1. Several of the previous nodes (qhm_qspi,
> qhm_qup0, ...) seem to configure without crashing.
> 
> I don't really know what's unique about Herobrine systems vs other
> sc7280 systems that presumably work fine. I'd guess there's some
> conflict with something configured by the boot firmware.

I think it well might be that Herobrine's TZ doesn't export QoS regions
to Linux.

> 
> I'm submitting as an RFC just to get thoughts from people who hopefully
> know better than me what might be going wrong here.
> 
> Fixes: fbd908bb8bc0 ("interconnect: qcom: sc7280: enable QoS configuration")
> Fixes: 2b5004956aff ("arm64: dts: qcom: sc7280: Add clocks for QOS configuration")
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index 2ba4ea60cb14..59203ce58c61 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -394,6 +394,16 @@ &vreg_l2c_1p8 {
>  
>  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>  
> +/* QoS seems to have conflicts with boot firmware on these devices. */
> +&aggre1_noc {
> +	/delete-property/ clocks;

While it might be enough for Linux to make it skip the QoS, I think a
more correct fix would be to remove the 'reg' instead / in addition.

On the other hand, having those boards used by only a few people it
might be easier to just pick up the simple fix rather than implementing
a 'proper' one.

Nevertheless, this would require changing the schema too, see
Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml

> +};
> +
> +/* QoS seems to have conflicts with boot firmware on these devices. */
> +&aggre2_noc {
> +	/delete-property/ clocks;
> +};
> +
>  &edp_panel {
>  	/* Our board provides power to the qcard for the eDP panel. */
>  	power-supply = <&vreg_edp_3p3>;
> -- 
> 2.51.0.rc2.233.g662b1ed5c5-goog
> 

-- 
With best wishes
Dmitry

