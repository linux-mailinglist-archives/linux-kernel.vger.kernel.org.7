Return-Path: <linux-kernel+bounces-895117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A491AC4CFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC684275CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63142FD7BC;
	Tue, 11 Nov 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kdxipmD2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KcHA58FW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF62F7ADD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855857; cv=none; b=IMCdj1XpSMFXdWSuya3BI2az5GQJ3lLE2QTqm0zh02ZTeLCbsahor+eQdm4G7L3wEDnm23h1/oc7bish5mzHW77SYibfQ2FOUirvRWoLySjmbkwv8dbMRvAbStbIPdzNxlh0IYB7BaPLoVAhA6wgphSpISbA3O5lw3EG+Zy1bKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855857; c=relaxed/simple;
	bh=TejEKnzU93oFfxQT3rclCnjWmOCh9dC9wwXYu5HP1Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2YauH3d9Ozr/3HZI7ujLl/rYZxNI+fMs3vQ44lgbLCQkUxYv3qBCXHxvYod3OrGkkevJD11cBOdS4cOHfsdpEhXfG0ZLDJaovClLx1RQt9uF+DjXPhJ4xKkKfBD157CjoSmQi/muyycFqIspuK/4XrO6/K9OUJjxPb0Hw6CQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kdxipmD2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KcHA58FW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AB5N6j21480266
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ShINux+CX6K+oVQkRJuCUkyY
	Klot/zwFGjn2wKGKgRk=; b=kdxipmD2fg0WFq7XUFXXN9u4M5Hz8BqpCRhkgU16
	jtT0eFRCbjustifVZOHMoL0AILDQtCyw/YWFzOtscDCB+bTeOG0VwmzvvynRgz/r
	HHJhLfTcKmvG4BsC//n8ROD1/7V2+sApfd4dsDbPtjBRHFlieRUeeu+y3EVLXAzv
	WYIQDPvw4T27OAqInVX5g+0ikXUBDmx3urXba1Q7FGmXLfXMd3V6f6axTkLVxJiR
	usnvGloL1LKI8/OJBc8Y1yUPdDvhXmT47dT6kQeOQoYDKS+QXVjv4wW7bStiKBjG
	hZQLw4EaYqczNPXEiLd6c9KIWhqt8/YROE1ZMSEpY2YXuQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu8trh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:10:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ed74e6c468so56276501cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762855853; x=1763460653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ShINux+CX6K+oVQkRJuCUkyYKlot/zwFGjn2wKGKgRk=;
        b=KcHA58FWjEZEoZeM71cMTdBkm2DGaHKtkwcYmbW5E/u8dok4VFlZb2ZCZx1EmeR6Yt
         DdXfcgtrill2nc9l6P4iOJNQ4wWqcQW+Dw+sqA4Yc/p0TqltALb44w7q5Wzk6HupJFXe
         5f6LUFg4PVI99NDpdzUqoYDdXoVEtSUnjTcqVo5z9R423DtUd6mFqGYpndKvRn4ft4aY
         KFnAqheoERJvAiQOLA/7jLGYShCuaENAqHj8U5NTTxL8d8goFcX52++RShzCiJ8cYnja
         SA2dPRwKSFbwSW06NRF5RfOpZQeUo4fN0vSS8IIsW+hQtRXBP9T86CgPA7kOWkW3FxWl
         TdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855853; x=1763460653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShINux+CX6K+oVQkRJuCUkyYKlot/zwFGjn2wKGKgRk=;
        b=MsPjvbuzIWNOqElqmtzLIf0dn9e5J8YKdOqXI8QDaj8wXsBI2jTxjW3N8mbtPe6agX
         2k+1G+dnzt3lCE3m8OoEneM3kvNxJeoRVbWiCKfPNvwCzgBo06q9dtu+Qs60hO+BL4hD
         6NEOtm3fxVrPMlZuKKnWXHUFRqMScL8/jjivQPfzzNGQXZXwbAt5pDPQL2iYNkiI0ZA5
         ydjuNDMM8HVQfU64tYGRMydK6FxwAxUV0E91LZs+jR4iin938UcHtxOCY+47e6+m/ysz
         wFDslfJG3itUJYwR7TqJsfExGnk/TWAyBzBgrI+HtS/7Y8CvkQM+BnYl4b17BhBXDKLN
         bPTw==
X-Forwarded-Encrypted: i=1; AJvYcCVr77eRg4XpYBUPcERKH79wlLVj3eyjOye0wPiAyTEkWQg3a/Ddvyus/wbz52KDkJIsQ08Vm+e8Si/ID5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqijYU8iorylgb/5tnYTb5cD1u//xDGUG2P4xnQs4gkcsL4sI
	GpBI/LB8beMZ3tXtvim1PK8gIWIgbCi/U6BKVJQ6ZCreiqYfIco+rMHn5ISDl7TkujVFvoG77qz
	4Z3nOMahMS4czpRmp/NsGeOJOMN0LAW5JOXLNY3t13PBwrM61G9dhqcYaNeki5CF6vVE=
X-Gm-Gg: ASbGncvtbOD7ftkwkwVd2fy/JETXXKs59dHxrGe9uxDvKsYTYCC3R8ccuBkxgNNAZ49
	Jrbd5J/OYjbJ52pX+WGf1p/XWfdUujpjWOic++wns5gWjv8f5C88ZdAs2MrCGQWLlgQcjOo1TH5
	vma80lH4NdPehFAZ4HgIdtyOUNHeyjUv6p6HgPLacSvJIRlP3TkZhQKFD+0ZnBQfTFbkRDc04FF
	3SUJEeJ4Um5xIXT7BcXFMpwkzRZqprW2SNi7BMZBCXNlwNuF1FsdJxdhfgw+jklrhHzpCPQD/mp
	B6njvJwbjlYh0piX/w6d+XcMtaGE0AnniOHWIBCq9F8QDONxLqmMWEh08MK29PwsahutEm2jVDE
	ollYwSE+BAC2sYSP7UVTebiZhOkAU5vsbCgcjKS30MMVL9t/ZsDyZ3cELXrPEPYzHzoL1057Ud+
	LEm4MBf6o8wRkL
X-Received: by 2002:a05:622a:1995:b0:4ed:7f5a:c6d8 with SMTP id d75a77b69052e-4eda4f7a99cmr156689661cf.41.1762855853461;
        Tue, 11 Nov 2025 02:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo8so6zfzeKqDr0YJ7J4ugxf/uG3RX0MJkGPgGDJofMTNH3tXu7qk8STLn9rrmFkBrD2mcWQ==
X-Received: by 2002:a05:622a:1995:b0:4ed:7f5a:c6d8 with SMTP id d75a77b69052e-4eda4f7a99cmr156689461cf.41.1762855852986;
        Tue, 11 Nov 2025 02:10:52 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a0b76ffsm4729648e87.62.2025.11.11.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:10:52 -0800 (PST)
Date: Tue, 11 Nov 2025 12:10:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: mdt_loader: rename 'firmware' parameter
 of qcom_mdt_load()
Message-ID: <muri5tcu46ee5ilokspc4eunbobq5yrfxuxsmw5odamdwuuiga@wlpowv5j3xtv>
References: <20251111-mdt-loader-cleanup-v1-0-71afee094dce@gmail.com>
 <20251111-mdt-loader-cleanup-v1-2-71afee094dce@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111-mdt-loader-cleanup-v1-2-71afee094dce@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA3OSBTYWx0ZWRfX9NvEnNhaVJSL
 B/y8NBF+iTn7BVBNoxO1oO2F7wqhFPYOQ9z5Z3cTmG+qSHBKcE8Lnq6wGErZv8KnRKTTR9qa9HC
 n+h2nYqlm84htHv2WY/ollxAe3bv3oVpRp3WV9w7+qXj2nuFDomAxtGNtvdPzOQ7dbqkcyFjJb9
 38JKt5BgNPax+jWYc65mNreUJ7NC33iB1xBKe/4fTRLL6faBfjY80HXcEtLY1GjGFBD8BACHFJw
 nOYRUPvn7QmE45MaAAEQU1Vyiu8BsrLEfhuA8W2SnwpZD2AevI+mDSwaRCL1GRjREHZO/GZb42b
 dqdtgtVB9iD5SxeYgufJl9Pn5AmmuBFPqJWcDBTH5TMlk3FrKsEGE12EuUfb0Z5b5cNNMBXFcj4
 8YGntokeVVcjUNdHi1dRIW+QmY18Lw==
X-Proofpoint-GUID: ip0W4kLB-T83Sb6TiBSclgi1EzRZ8nC9
X-Proofpoint-ORIG-GUID: ip0W4kLB-T83Sb6TiBSclgi1EzRZ8nC9
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=69130bae cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=cbnKOLyo8h1vxEnvzfkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110079

On Tue, Nov 11, 2025 at 08:40:11AM +0100, Gabor Juhos wrote:
> In the 'mdt_loader.h' header, both the prototype and the inline
> version of the qcom_mdt_load() function uses 'fw_name' as name for
> the firmware name parameter. Additionally, the other qcom_mdt_*
> functions are using that as well.
> 
> For consistency, rename the 'firmware' parameter in the implementation
> of the qcom_mdt_load() to 'fw_name' and update the function accordingly.
> 
> No functional changes.
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/soc/qcom/mdt_loader.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

