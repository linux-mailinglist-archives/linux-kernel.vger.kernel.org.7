Return-Path: <linux-kernel+bounces-890331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD732C3FD13
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751103BDA43
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139DD31E110;
	Fri,  7 Nov 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ncQf/rj+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N98ADC6n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC60207A22
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516208; cv=none; b=rzzSAj3Hf/esKswDuwJaABFvH2/M+ScS9byfVHnC+Y/Rf9fGiN75kB1YsRXRf7Ws87jeXpXagUShWxMBKe0DISElk4Ct2p0qvhJHcwZfWrogd5i9ne7qr8V6+aKDTQgx2RnziGjUMXKuQUnKJi6AEoJgtLbp2Ymtyzpnh0bWJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516208; c=relaxed/simple;
	bh=9zKjZpUIYk+itNggUJ5MlXLhe3sBQBIWHa35miBX6W0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYqQZ1scirwcGk7iTXdj4GX8ngc+a7sd2Gy/ysWBYxEZRLYSP6mwNr6v6m9nOR8VB4S9wit5Jhdun1MVueuzuIVJppAziyi9vksw2fpuyR5uhDxjjMeMJAPvW+65jI2ExXAplC1FGaR1BKPyyxJcB+kD89wPXdc8gm54a1O6Il0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ncQf/rj+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N98ADC6n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7B57Hc3174710
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 11:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dMrXAflLekSr2reWqAqWS0yB
	ySzoUwcO6ionW8M4Tzc=; b=ncQf/rj+sIhsA9BrBH/ZggfgAEiW/UZekYS7yKHN
	ojUvgTNPnIUixJvdLfDOzi1ht0SF46BR7ysoEvXFivkG+H8HVtpIMu0SH/emDGyH
	Ofd2ID5ytSt0xD+ExRDAVwG3XJMP6szhnHM/vW+KRcOD73Qj/XRu3qBwZPv+HKGM
	teW5F+LdC3DlEzzK45+FCOIGh/o99jX02KRhcB2G8sxPXr7XXVzk4ZMV0lw1LYU6
	+mB9fj/AyXUuu+xEkNLlNAqAhDT3qBcq/9KaGr0JWvYZjEERdrsV8gdl1SC3Sx33
	50yHxSA/31sAmJ4Dzba4UDCPCtjYTP/a7kkSyX+Wh0q/ow==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9fk803g6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:50:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso1028282a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762516203; x=1763121003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMrXAflLekSr2reWqAqWS0yBySzoUwcO6ionW8M4Tzc=;
        b=N98ADC6nQmt6QV1H5P6JbXCdmk/YrHkasEQUc3JMrpovHo71zSRop29W4Kqmf4FxfR
         YT5QueeTq2UyNHbjYd1lmL6iIY8PgB0kdyvSWmgtMJ/Fkbl/jvJj+uwPd+buLJKa+GO6
         8dqqyyOnBb2wyXMctd+d2RiR89j4K/ibMrslx47QQ284mI49HNjliSM//F/kzrtcM/qa
         jceqsVpM3BQ/csYWjPQMdv7U0KkAsKLrR6NJBgq1yHwZiIFYNQ2ibteJfeB4Y3XelKnd
         2jftdOYxSXTBq/HG3xIG8VN7hlmcaF9pg5Ouw7Wk9puhjSc9X6zVBMHOqbnvhSp3ekHm
         v8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516203; x=1763121003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMrXAflLekSr2reWqAqWS0yBySzoUwcO6ionW8M4Tzc=;
        b=KfjJsEtPmmFVSwLhsYtxhzchvB9seEsLvsM5Csk7+kxtiL+WgdJgmzFsSvAE9qpFTM
         3UtNgHxd5a8VFFDTj3nEOOrSsFXmmb74XZZAqDQNyPewdqlvEAIIlrvSR43LnRB5eyMY
         4YQ57Ri/OwMphOed6B+LQayJd5/TGB/NhtxVyD7caZPqPlMQ4DcuS/CmGClVSE1T4CPC
         hDTs/mn4ZI7+E3wJzTvqNpot0iek4tn4Yh31pzK6WhWFq8shFty0XxBC7M0eCoxwN9VR
         KCameA/xZ79gaFjY1LKeRdRUdW8H19wdk/Z2jz2R/8dSWRQN8hC8N4MaqtGnPzWfjTmh
         Y25w==
X-Forwarded-Encrypted: i=1; AJvYcCUHer+8XMgrKDRzBdIhyNfHFADqSeC4BCBEsHD0iYmdXAcmyqeAeBWWe86edw3ECSZxraAqDu6gf745kds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx32eQR/vuLb0JGaddQhVgpBWdLGu1TiT4Aqsb30AcoODfWwF5e
	H5Mja/RWQ+wvZ7ZF11C2hF3PI17Vm9Wm4Cg5D4QQ00TfE9nv5SpYtk2dbeO6Zn20DIOD2RvETEV
	fmfm5buuCDKbelUPtxUd0oyfawUITOU0bzdR1PuUEnwb3si4DaDRg7xhPBSfzgMtMIuc=
X-Gm-Gg: ASbGncsNNCSnKuSfjEIl1vAAzTLthtoZiNmklScRccSV1V3nFp4iN7iUwf0+D4XvPvZ
	ZOAG9FN46JJNHE66qBom60zXkUrWP94Q7nWw7fK04ef4PLKngJdARA941QtBzgyCjDk9tYKzQMb
	hh+hKbmOsyIMWfoRtRw85vog503pB1sJ94DMp7GfzkYUcqy+8aX4xLzNJ2jRPosrkjeCig5M/i7
	HJLv1MyoRIOZ9Eozsj1D8X1DKLuIZIFGQEBdIGU33W+IurTrRAUrBfuz+G82n819g8lMJT8LDdY
	G0bj2Mcf3BZqwdMo7kWuozvPBMrvltqVKXiDBkL5CZ85cjgHismhpUXFrQFZ3+a5TIbk/ORY7aH
	/t/29ShwlVeLiBYii8q2LEDt0Wg==
X-Received: by 2002:a17:902:ea05:b0:295:73f:90d0 with SMTP id d9443c01a7336-297c04931d3mr39770175ad.50.1762516203079;
        Fri, 07 Nov 2025 03:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhNAjO6ANvx/Ku1ZgGqWvUkOpsCN5R864El2BfAS5aa0p1YaTkf88N9laM4ZHwBOWafYkMdA==
X-Received: by 2002:a17:902:ea05:b0:295:73f:90d0 with SMTP id d9443c01a7336-297c04931d3mr39769635ad.50.1762516202345;
        Fri, 07 Nov 2025 03:50:02 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cc1907sm58007315ad.99.2025.11.07.03.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:50:02 -0800 (PST)
Date: Fri, 7 Nov 2025 17:19:55 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/14] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
Message-ID: <20251107114955.zprgt2peq34im3ji@hu-mojha-hyd.qualcomm.com>
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-11-7017b0adc24e@oss.qualcomm.com>
 <5239980b-f74c-4458-a7e3-a5e7f6927449@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5239980b-f74c-4458-a7e3-a5e7f6927449@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: c2OaRfltXIk7Z1cVcwMFjaA3JReiv2-t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA5NiBTYWx0ZWRfX7NjmxakC+36M
 S4V0pUhltkKXh9DSFoebXSyKEASeoa5Ez08f9xrJOP++ZdS7KCRTcYScCo7AwgD3DxEvkkpgzo3
 eRGGH+UKVX0WFzWh7kTnga3phIwRtrn6VPD/oSulTBokky0CaMaMpwp9sOSF2yrB7nnGdg/66xH
 qWIHumXtmf17rFE3J/Uyv0s21NQQ1D9ik3V+JRRaq7oyLZ0dL+f8XehmERfB8gZyZimeRTRDeiS
 TXsy5N7ubTzy4WPgdAlwL1cTvPnfeZZNg2oIt+fBK3zf4qiHPb+tgzx9whPsi4bsfGpoOk7GjBx
 bd7oxlkafbD/ii8CtCdA2aFNwxV+0gHn60oRDpR9zkaUoSWwGa2+W1f+gcI14ccX2l3Qmc1meki
 fglDstorPK+jt1yiP/kMFr7ZwKBhNA==
X-Proofpoint-GUID: c2OaRfltXIk7Z1cVcwMFjaA3JReiv2-t
X-Authority-Analysis: v=2.4 cv=CPAnnBrD c=1 sm=1 tr=0 ts=690ddcec cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=g61vSUFNigzP7AYlN20A:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070096

On Fri, Nov 07, 2025 at 11:20:20AM +0100, Konrad Dybcio wrote:
> On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> > Qualcomm remote processor may rely on Static and Dynamic resources for
> > it to be functional. Static resources are fixed like for example,
> > memory-mapped addresses required by the subsystem and dynamic
> > resources, such as shared memory in DDR etc., are determined at
> > runtime during the boot process.
> > 
> > For most of the Qualcomm SoCs, when run with Gunyah or older QHEE
> > hypervisor, all the resources whether it is static or dynamic, is
> > managed by the hypervisor. Dynamic resources if it is present for a
> > remote processor will always be coming from secure world via SMC call
> > while static resources may be present in remote processor firmware
> > binary or it may be coming qcom_scm_pas_get_rsc_table() SMC call along
> > with dynamic resources.
> 
> [...]
> 
> 
> > +	/*
> > +	 * TrustZone can not accept buffer as NULL value as argument Hence,
> > +	 * we need to pass a input buffer indicating that subsystem firmware
> > +	 * does not have resource table by filling resource table structure.
> > +	 */
> > +	if (!input_rt)
> > +		input_rt_size = sizeof(*rsc);
> 
> Would the expected size of the received data ever be any different
> than sizeof(*rsc) anyway?

input_rt_size != 0 and input_rt = NULL as input to this SCM call are 
invalid scenario.

Expected input_rt_size would be greater than sizeof(*rsc) if remote
processor firmware will have resource table section.


> 
> [...]
> 
> > +int qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx, void *input_rt,
> > +			       size_t input_rt_size, void **output_rt,
> > +			       size_t *output_rt_size)
> > +{
> > +	int ret;
> > +
> > +	do {
> > +		*output_rt = kzalloc(*output_rt_size, GFP_KERNEL);
> > +		if (!*output_rt)
> > +			return -ENOMEM;
> > +
> > +		ret = __qcom_scm_pas_get_rsc_table(ctx->pas_id, input_rt,
> > +						   input_rt_size, output_rt,
> > +						   output_rt_size);
> > +		if (ret)
> > +			kfree(*output_rt);
> > +
> > +	} while (ret == -EAGAIN);
> 
> This should at the very least be limited to a number of retries

Sure, how about 5 ?

> 
> Konrad

-- 
-Mukesh Ojha

