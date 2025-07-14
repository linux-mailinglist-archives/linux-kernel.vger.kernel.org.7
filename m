Return-Path: <linux-kernel+bounces-729824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC9B03C09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2B83A6D57
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CBD24501B;
	Mon, 14 Jul 2025 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fhvsdayl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA2242D82
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489628; cv=none; b=nppl5SP8rH7cfChALUzFhZ8kWyhNFXhKEGMzPww6ya+CIyH5VADlsAbbjgBvYY7WeRyPcDCVAhgTnVU+Crmy/7xKlkyyUXcdGJNFWj3CllTuFad2PH9dtP+C1MLnthQqWh2NPday12aO1qwnM50bpVW2JAZWg3iPE13e6dAPM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489628; c=relaxed/simple;
	bh=deZbUNhBldTby3M4tmLgYzlvbCM8uzYYDc0Bw4Lpp40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSc7L9UO1R+HcLCdph71DZ6xHUFn53aCU3Kky2adpBpp6hJ40bqJH6AtgObqwCI2eKYgYeuVnAgZyymz6T6zgg7bx/8WaRtiQ8aDJhg18NSGh1Ab9s1AxiTjH1fR7p+72vXKk9kRoRCELXV78V7O11iaXLXMTIsVNLkHjQJcrz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fhvsdayl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E66tN8001883
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tB2e5ggL3fY/edqtAXsgpHxBwZZ4IBQnGq8lX0Jlges=; b=FhvsdaylWjE9WdO/
	y9Kqvwxd4vIrZXsI0F+phgyrnZ0TQRrAAhf/ecx2QOgtEhGcXx8FtjgdSm3+ABQ/
	m9TK1RSYL64LDGwcc80A0+7g2RQlq65ZDaV+i8Gigb+BvRMWzQMsstWUPWzH7R2C
	iwTFirkgI7kISQwbRFKW4mndZQGF9wuJLNxctbx9RRxH3vrKsKchDgBbHRFE+EMy
	k5IKBdLq9g5TDUvIBdYSIK0SJy1oSp9fHqezROJbd7Yfs4j9X8AAiBLJoAeb/sSy
	4aafdxsrHsQjOZQt2c0bJWcFbF1svbXYQrXrWPchvgxIAycUsdG1sZFvhCmC3q56
	dHj+VA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47vvay0yah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:40:26 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so943911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489625; x=1753094425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tB2e5ggL3fY/edqtAXsgpHxBwZZ4IBQnGq8lX0Jlges=;
        b=qqjLLXI/M/mo/6rqMWEZe7ybnHTHbD/nlF41JWUyCi2JZn0+/VzzCDq+FCydYij/Qx
         ObAbfsTWYX1HJFG0LJkO0J2497f1JM1t0E75pKhTwhzaenvhvkAXVt0i6XluffScMhnR
         dQlm6zqPEfNcglFYQwmeCb5NKc/kjcjVY7mEHpt1TmI5kqZzylrrveQds9taOcJ2zKrw
         gJVkvIV7FeDHCZUWGJwA4Dd2zEtrMeycTA7y1EPI80LHGeMdc93zBD7pCSr2BTkt/lKS
         3xbvCFYG0BpZZi+tyRDsB0ez8gYJHafvuoHnL1qAmboL0IGOntOHDg6jjHqHr3pXMG8p
         ehWA==
X-Forwarded-Encrypted: i=1; AJvYcCWhAj1nSUXW3ZHDEqIiiFsl+Jopyx42U+DAk9fp3h5Xd6CVP/IMPK4c6swRLK19/pgZMuPk0dD4e+RZibA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4by+3x6eWjktx2e9efUGhZWSBVwiCmGbyP9ouHJUv+6medSSj
	LDWRwPr0YkNtsyQDMcKDy2HlZ+9DQS+uu/zq8EsvLgjjhkiTM1JJbCJ7Fiw1kliaWoJUcyWo/5H
	YXLU+C/5Rx0U+9l7RBHoCWpZ4AfZIZ5MbzDCpj3FdPYSPkdTDtH1IUOgtCy5PY+TC0Rs=
X-Gm-Gg: ASbGnctpHEK/0CmdOKgqVDAMPDn/PZuPxkKVnSLbYA37mnQMYkOdrsi3B/OduskuV04
	BDGZXZOcWHxIU5HPYwBwc0ssU+tI1kXtF8ZlFkQMVcL+UeMQUD7O9OFiiFOKX5cT/a49syOHPSj
	QRWxAyl3+ELgwJFZRSAfD5v7/S0eyarL4yaq9LmsMvFdKVhAc+0TpAIRDp7NgBijM/x/d9CtFfm
	4AOXVmtD+RXhsiKn6ThxdoJKTAKmh0Ukhv906ugtge5nxxdEZQQiJT+ycz09b2gpbv+7iViqLuD
	Un8gLuiEZ+Lwhv6AQgcEShsYH0+M0at6xLsur5zPvKPwprVG5U55EqyxQDCWpQT7mT+3pRLkWqP
	s74isX5pn0XvDXeBVnpsx
X-Received: by 2002:a05:620a:472b:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7dde9953e8amr669329885a.3.1752489625140;
        Mon, 14 Jul 2025 03:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX6K17hMp2/ulIBMK4DVmm1PgjYLwQeegXlJ+Ljh38oeuRNcCU+4bDQLs8qGgRUtnPnOjJTw==
X-Received: by 2002:a05:620a:472b:b0:7d3:b0a3:6aa7 with SMTP id af79cd13be357-7dde9953e8amr669328485a.3.1752489624756;
        Mon, 14 Jul 2025 03:40:24 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9523b5asm5919012a12.23.2025.07.14.03.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:40:24 -0700 (PDT)
Message-ID: <03b0d4ba-a1ec-4196-90bf-0ba38d620815@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 12:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] PCI: dwc: Add ECAM support with iATU configuration
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250712-ecam_v4-v6-0-d820f912e354@qti.qualcomm.com>
 <20250712-ecam_v4-v6-4-d820f912e354@qti.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250712-ecam_v4-v6-4-d820f912e354@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cOp1B3IykoPz2O_6s4oKFUVb61HotzeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2MiBTYWx0ZWRfXxe55Ec8r+UAv
 135wyS3+saRTk5mLI/JJ5wNkUvy/Ed2lguPpI41NixxsDDwmw4JZJWuE2g1Dz03aRUeLMfEUvyB
 fzQ+Cq1oDTXKpzottQB7k7jHD8BjPUnNYjoSULj2ZRSftYDr4VZW+DCX//1lxw9ojF4juZJSP2O
 CqTsnyn2yfd6ssdJAioIA3636Ln0COeN7BqYDkKqS18uolomAt3lAZWEdssLSIhOXpINJIRPS1x
 ODCwjb4/gLzSLkNMRLQQY4vsYDbaRZy3GsGCv+yQYButraNBXo6P1gjlmXyegU733Oro7GYpBif
 +o0CieArgSXpeUAaccB1LmADwJPLNoWy6d7eTnaxQhsY9CKNWAyv5XdYQ5rtkvI28TqUcQKQKnq
 r3OC7KQWvb+YTDNQ+SM5h0sjgjBznJv34mnAShKdfWS+f19gYFh2hStyCi4b7yS5q/jjI34j
X-Authority-Analysis: v=2.4 cv=GNIIEvNK c=1 sm=1 tr=0 ts=6874de9a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CBJoKf8DjQ7nWtifRjsA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: cOp1B3IykoPz2O_6s4oKFUVb61HotzeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140062

On 7/12/25 1:42 AM, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> Configuring iATU in config shift feature enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to achieve this.
> 
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

[...]

> @@ -430,6 +433,8 @@ struct dw_pcie_rp {
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> +	bool			ecam_mode;

nit: 'ecam_enabled' or something? I don't think it's necessarily a "mode"
of operation

Konrad

