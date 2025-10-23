Return-Path: <linux-kernel+bounces-866671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1706C00674
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8FC3AABF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E012FF14A;
	Thu, 23 Oct 2025 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdmkTEjh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74948301704
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214267; cv=none; b=pe2+RCjTx5hFO29a9tstWi449iVTtEgOnjbpH3aPloKLG4UCRnRCQsFi3UYQD+ST/+j52spqNDU+e/BLamY+TYrxh8wBNBh9YwQUHn3ZN37tgZv+Is6EGrCXu2PO5fZOBzxb8Hy/RLcEjMlnxfpwDEBkHCihz6MsBw5/YskRH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214267; c=relaxed/simple;
	bh=qLVWI4esBCBNF7xpWlKAqG0GmKGFbIZLAfCdcS/Z+MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dd4tXnzcS1SQ4XZZKSBsX5jEaSAPil6PgBEQg8dsd1gSjgePXTe0MisCTCigSdG1O+D31DzNEgJ6U2VxFlhdQW80XuhkqMU+ivqLksR4agd55SEAcVMUa3+FCgT+HrqPb4ACMi/42FewRz1uFT+exFU+yt0Hxjt7F8vQGa8IuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdmkTEjh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6rG4k010394
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UML1yqzrbQrPry4HepC8vV3t4zwpEH9yK9wTNqr1R0g=; b=PdmkTEjhYy74Piku
	o/rzY2pZzaSnTfurWYJ+nMcD+Z2vSvrjfeWbD4+vNPJSsQoWkHb1imjoSeyPfnl5
	f06t8xeTjJthYrgXjJW5Y2oMwqKVvH1dlT+3z0/llH9F+5ObN55oCURUAni5hd4w
	fDl7g98uzQAGvqMzhFcFSIm2LFrqhFGI5kdKNFKOr1n4nufjciODTzfkQ37ioaUc
	dWMAc6/JSX53oeo+AzNXxb5VmZiAFFDOg2snxx3hVVUpxykogKesbpHcfCM4YSDF
	F5dmXoqOArVJMPvrvgTR6Saf1pmRHf05Vpzkis+de7/jvmuz59NZaj0F6iL6/kkZ
	phdTnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v34481x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:11:03 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6a33319cb6so474081a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214262; x=1761819062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UML1yqzrbQrPry4HepC8vV3t4zwpEH9yK9wTNqr1R0g=;
        b=oYCp8TxAID33RbBrFQmR72pJpseNHHJ0fOdTBFFiEryIzHImZQU0ffnk20B/6syDVx
         qu9u9fyvWNtI9T78kRvvEW9LyCMk5mlepULP2GH9YHeh4+GXfGsFwWUeYOzT6ZPNp3ES
         1V4V5TkZIm773eCeng01AjTiWQH/IB5bOuJ3RD5suh7JgKxRCN77QCQFAq7jqX8urpjf
         5LOIy0aVIXGn04I31JbtpIQZBJaVW57qCju/+eHOQNnxILZOIH1vvimxrOmEfafaZTfc
         6gvNa4lAVGkfl7znpSj4jG4ruYT2KoyMyKxHDdSa6pydWhsRhQONpThmszYkCzc8sKGp
         Ba4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9fzGIgISmD/9qGCvC3aO6hGIU1SXE3bZ3JiNq1N7KFxCArYoQ6iasntxuNpV/3rIi8FVMmjSPuF4oR9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8qW0k1loRuzEDA6BPrgQlm/TNBKTjRybcFY57ULSwIdKMbdd
	jdx7yS9DB0N7UpohPpSNLW3mxlTGHZmHywsGWqTeQqv67YwJcTbsdDkMPCwvF5EgBMOk5fLUI51
	Oiw/Yge/9cy8tGF4MDGzADqDTt10zhrylX9fGv9x6auPxDuF4QPcyLyp0YDspieiX51A=
X-Gm-Gg: ASbGnctaeqbYHrH6G8WIgDL9Dxc1OylaZOtwGB+9/4gAHUckookd/XkFMTGO41KTDSo
	Xo3SKtX1HBwF8Pv81ksCj2xLiw4pKnmuzUKlkl+5c50TB1AANIxZi/17n5B4kzW5zrHCbhYcgkH
	BbUS9LC/kBQmqWBhdr8jhLLFfbh4rwtbjWC/9YpWvFVh/8vD02CuFjqFFnzUhX5HtudltIzkfBk
	QiYg04YLmSbfN8AsFfZHOpyTnB3xT6pL+XFo0LWWRocxDLtBeu6lWmgNHFbD41jfMVzHARbdeQM
	uJvNBEveKJwMLp+r5RXEfkjn+KuwvPwjRPt0t6tgV8ZcT8nKbcSyVwi5lpbkpSoit7oQlByJy1Z
	QzHrg9a9g67qq6KTS+Id9cYU2FbS5s+t29UL5VDMr5Dfa3DVKbSarKHvxKI8pToElMA==
X-Received: by 2002:a05:6a20:9186:b0:334:7aae:c43b with SMTP id adf61e73a8af0-33c600ad4c9mr2446152637.20.1761214262562;
        Thu, 23 Oct 2025 03:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFy40H0MW5NZRQSkKA5Qh1AhBvaXks0B6kqhFazrM8IjeVicGOuL4gdISqwRAuDa2V1gGJ8w==
X-Received: by 2002:a05:6a20:9186:b0:334:7aae:c43b with SMTP id adf61e73a8af0-33c600ad4c9mr2446115637.20.1761214262075;
        Thu, 23 Oct 2025 03:11:02 -0700 (PDT)
Received: from [10.133.33.151] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb9c8asm1654060a12.9.2025.10.23.03.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:11:01 -0700 (PDT)
Message-ID: <f8c315b9-acf8-4085-ab10-0d6e60ef7c39@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 18:10:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: mtk_scp: remove unnecessary checking
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <aPi6eBlFLH43A4C0@stanley.mountain>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <aPi6eBlFLH43A4C0@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Gja5OO986-jPi33vlSaYN2o_eyb7m_GL
X-Proofpoint-ORIG-GUID: Gja5OO986-jPi33vlSaYN2o_eyb7m_GL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7rmM6aM76H6Y
 32DdNxpw0TtyZqoFx8Zah5H1/fhVGY2c+2eKsMM529WImNcVaqih7kVg/u01dB4c1IKa0E0Ajoi
 lKJKPISBAcxdZhskna9i8ikl7VtZujbYpSfmxP5gn0CGg9b7wYRuqazmz7jLvKIIjvcwiNnlDUK
 oksLD2UcQwvYPDosYrUmtEaFBaE8igq0XT2/SpHzzm4tmIPFwZwuo5SQ3xLZMUHuG3frjti2eUo
 12NsJfiX8KP7zh33PIT9+ljvwR8wTdwtS+amJEvf44zAiZIr/u/3Zx97u1EdFtC+qjagawCV6mc
 lM4zlpJ+blOiyuA5xJ6uQfJ9d7ASPPNeXdE5LaQFbCsgjfuXk3VRCGTAluBy7RXaqoKA3WV9xli
 Qe9RhCfTVRm2fkm0W+15PJd/TSvI/A==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9ff37 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=IDcGV2vxZRipFm0qDp8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

On 10/22/2025 7:05 PM, Dan Carpenter wrote:
> The kernel implementation of snprintf() cannot return negative error
> codes.  Also these particular calls to snprintf() can't return zero
> and the code to handle a zero return is sort of questionable.  Just
> delete this impossible code.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/remoteproc/mtk_scp.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index 10e3f9eb8cd2..9b624948a572 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1127,11 +1127,9 @@ static const char *scp_get_default_fw_path(struct device *dev, int core_id)
>   		return ERR_PTR(-EINVAL);
>   
>   	if (core_id >= 0)
> -		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);
> +		snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id);

Hello Dan Carpenter,

The patch looks fine to me functionally. However, one concern beyond the
current scope: if core_id >= 10 in future extensions, the
snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp_c%1d", core_id) may
cause truncation.

scp_add_multi_core
       |
       v
scp_rproc_init
       |
       v
scp_get_default_fw_path
     char scp_fw_file[7];


To guard against this, maybe should we consider adding:

if (ret >= ARRAY_SIZE(scp_fw_file))
     return ERR_PTR(-ENAMETOOLONG);

or just expand the scp_fw_file[7] array?

Thank you~


>   	else
> -		ret = snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
> -	if (ret <= 0)
> -		return ERR_PTR(ret);
> +		snprintf(scp_fw_file, ARRAY_SIZE(scp_fw_file), "scp");
>   
>   	/* Not using strchr here, as strlen of a const gets optimized by compiler */
>   	soc = &compatible[strlen("mediatek,")];


-- 
Thx and BRs,
Zhongqiu Han

