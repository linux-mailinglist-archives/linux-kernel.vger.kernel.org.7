Return-Path: <linux-kernel+bounces-829204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DC0B96840
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293FC18A2C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FAA25949A;
	Tue, 23 Sep 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P44L1ZQQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665A199FAB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640428; cv=none; b=eHUJGx18V6mU1+6QxhGHzQY8JiomFHc50/tqVsXpo5oTqmvPx+hrmsQZZdHTZVrq8xJmg2HbBqS6HZFjlnpAFAWrjeOD9S3GFXOg6SVMGCXeGYv/nMhBCRX7x8iczSPUVsYGTAwnL9glMYWGl7NaVPg9ef2UuTyhDv2/rdm/m4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640428; c=relaxed/simple;
	bh=+dxVN03+NxPH90uxGPxmu6JMAYvavCbPcOumQmBHgQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxzNweA2lxrRmeS98Bl1d8oLGXTIjfkHZKWIfUrPGDVwcrNasoRYzUhnSVu/09CPw2Jp8v6jfh2QPQ+auf5jWNgevvnAj1A5ggDQNOmiWSstREDG5LT6EkdoDmxjNU2TCFljd2nHrJSXoc8S2OsLU6DQTpSH3uud78G4Gvv3F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P44L1ZQQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NF4RWL020711
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=BZIisvap+FMPTsGCcwwpcVKM
	6ffERfcfiaukHo8ByiQ=; b=P44L1ZQQ86VmGbeAG4spLI6pSWhWk1eU+oqMNxJJ
	1M3/M+9IfaE2wxbTD0fnkUMOvZafERizlFmcHEkJ8n5E2hy+xQF0tYnUq+ssma/z
	obF+5jvceDpDKd3h4VvEyCB/UndIBiNgUSLqfQnHFA+wdeRP3zG5Cjr48tM9SZ7o
	UsCXAxb1NKiXbGU425Rn6krwp0nOQxWrBAKI0HxuhVDLEK2VKCK2ld7ku90Pd9L7
	2+Ay/3Unk1kWfz7+RdIql/BZqaIZMQX052KyoyRXPdAKBS3TAYQyyOSrN7FxmAvP
	FViUz6AcwR5jEYOqz3GPJJvcwOm+cV05pL7wlWoL5IUhtQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjtd3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:13:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4cce66e91e3so50407251cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640422; x=1759245222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZIisvap+FMPTsGCcwwpcVKM6ffERfcfiaukHo8ByiQ=;
        b=oEQ/+cXmtS6UVJMrBaxDxNIebHzM4mgUIyIEE72Gf2AQfDgGixJpLFSA1Ti/VxpegK
         LspaOsYmf/mtSO7+bD0RlRC2Ws/Z3UeRO1BDyVoSe0k06nBnvd97o+LS2sFFoi100zSR
         uT4yG17BZyQtnO/cN0jIutv99rWVlPDT416XhaHQBKFteqUIXLJerPVC1KxiFpKFglFz
         sdC4ztwuaOtVtGi8jBeAS/taorln3jvPgP4AsJOJTuGLlgeuGkDTTfg5kaZu2pETns/H
         D/6knlammWZI7bO8Thafz2IeRmnprUXrQCKF14/e2q6Vz6PhaGMESeD8ggpBFT/B/w9P
         +TDA==
X-Forwarded-Encrypted: i=1; AJvYcCWa09aU3ULzXG2UG+rnirwoPQ0ZVSG1n5ww2jRs5jvVKqQdadSQuq+E+rCHswwSAvuQKiWxvVLs9Qbe/Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7SlrtmlcIPwEqa+IZF7oxuHgv/qo8gdOaT47STd0TK7EYbHN
	ETbreDDCl3blThbVrLE8Pxard9vLrkGK5bnYcfe4Vcbw+MsbQdu8Bqiz/IDf+JbUWzqfA4PRJ9Q
	kRc1i3Cd5t3sOSrnXKT/LZDknqPrVhM5of91kmA7D33PooRwaY8YDKCKdFxBmfebS3NM=
X-Gm-Gg: ASbGncuqGyPwyzlpkl5TdWBYEvVT13qUjR7fOv6C7Go0ES06p03Ywy7mWwz1oPTpL2/
	iTzOhpAdAm+FZsUj84jAOzE/Uj639x2XPCLNms/4e74oZuHRsuIsZ1HJRZIF7is1Pbd8auN1mL+
	mq3PURyka8PI1F5JOhoLdxy8jaeeTDE+21w5L0UttZlTMVquPSP6dd6tDLsjR9NvRKuq4Ms6xz7
	QWCGAg/iQPwym61hAAW6rNaIfU3D5EJBol6CgXErunuEmHEryWDvV8eE2sbcKk6QA0ltoYj4otT
	qLAVooNV1UHngCw+QdKep83bjjumYKCv9b3wgPY1exo992nbb206QKplIhbi4dR4Xo/vLHVFSpY
	2yy3fMHsI1gCbkkVEicfgWMd33MJent8TGUIGzy3YTeIRMTnmtoxu
X-Received: by 2002:a05:6214:194f:b0:704:a590:196 with SMTP id 6a1803df08f44-7e70381db98mr36059126d6.21.1758640421730;
        Tue, 23 Sep 2025 08:13:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn2M7oZxGMkVEQaCn+SRSpsX5F/BSK5zHO+MDSoD3rPA267omvOKyq/PN7wTc/fndNNH78+Q==
X-Received: by 2002:a05:6214:194f:b0:704:a590:196 with SMTP id 6a1803df08f44-7e70381db98mr36058356d6.21.1758640421084;
        Tue, 23 Sep 2025 08:13:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a9573541sm4264921e87.108.2025.09.23.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:13:40 -0700 (PDT)
Date: Tue, 23 Sep 2025 18:13:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, luca.weiss@fairphone.com,
        --cc=mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
Subject: Re: [PATCH v1] arm64: dts: qcom: qcs6490-rb3gen2: Add firmware-name
 to QUPv3 nodes
Message-ID: <cr2ehxr4udit6ddzp3pspsdrhtf4rpl5fzo6jakw2uo3gm7r6a@v3hwvkya62hx>
References: <20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Y5BfPhoBPXrc7sFHWz_JieV8TkL9cmrr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXwid8kWmzALhd
 jBh9TLXwG0ucjIjDhMIKKlEl36GvD8HUG5T/3naQv233tPdcYxWzsnwJ21bo4f5IiU+TOJbyTIQ
 EwL42afT6nwshwo1fM3OhYE6GtYKYZrn0TkytWbHikx3ZIMDgVGxwnx8Y3hJT39+fn+14UIePGr
 DGxbDrmSUaLgrdp5JY7E7i2zN2saHtE0DZ6+Ba19fqB/cCpDI6wcP9fln7dD5ioer6A9e+Mi7Hh
 vVna7URb1fl7jnPMDKamm+KK1REzkkHZz5tqJ0N6Pv0qi3BYrJjUyE7PlTUhLKXnmyOFA4jCLs6
 wzNdX9KERsoSYS2a8gszkpidTrbbzageOCsxO7P6NaC32O8JnAVlOxoydXO6XEqmGcprWY7JmXa
 asLGdB5P
X-Proofpoint-GUID: Y5BfPhoBPXrc7sFHWz_JieV8TkL9cmrr
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d2b928 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8WW2uxIJbwZ2W8HW5oYA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Tue, Sep 23, 2025 at 08:04:31PM +0530, Viken Dadhaniya wrote:
> Add firmware-name property to qupv3_id_0 and qupv3_id_1 to specify the
> QUPv3 firmware ELF (qupv3fw.elf).

Please start by describing the problem you are trying to solve.

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 18cea8812001..4e361580ddf1 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1009,10 +1009,12 @@ &qup_uart7_tx {
>  };
>  
>  &qupv3_id_0 {
> +	firmware-name = "qcom/qcs6490/qupv3fw.elf";
>  	status = "okay";
>  };
>  
>  &qupv3_id_1 {
> +	firmware-name = "qcom/qcs6490/qupv3fw.elf";
>  	status = "okay";
>  };
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

