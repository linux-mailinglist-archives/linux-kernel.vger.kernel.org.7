Return-Path: <linux-kernel+bounces-721439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB84AFC932
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89321AA72A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7393D2D8DAE;
	Tue,  8 Jul 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kvsk5ygc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630782D8768
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751973070; cv=none; b=uafCFCyU070nUiS2dAJonS8q4nTmxAfwrI2mBraVZ+1AA7j7eAsWX6qZ/hzWwjn49r80oRtXuLvBfoA0ZWqR7/0Y/TSzuLg7X9aqYtdHUBCJSwFMovWBi+rhEEQYg8CAmY+Idorx8ylWGYPzrD/244Rz4lhs9Tn2wVdw0Hh8MDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751973070; c=relaxed/simple;
	bh=uBITef0LLUWU1/Zarh1ggIbbNfjwqfPSV4C8QCz3YwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBsf43n/0rjAz8qqzBb150McBAy1FdPXUzhAixuTEGx4KDZwMW6ps3V1ea0yhrcCPlc8Bi2INTpPGIrC3K5jr/+IgG5cEzPRAo1wM54ZiYdSJSRt5pOpgT5R/hA6TEIexSY30mpI+zvajGdF4VQXN05yellVYiYFv/c0lTrel6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kvsk5ygc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAPWa001219
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 11:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5lROYxN8HV9QfliUbHs8x/x9pgDZeMnRqOSq4a3lsV4=; b=Kvsk5ygcnt9/akyu
	FMofRbZVBpsZkckiqXO+c5N+mDYmwMDXAUXXppIRld+q9cuk+Y78ZnQQ1ifUzFfB
	nx5m2n0Jw/nSFah1+9GEP5nbJGwSOLA6BQ+DTgySr89IYmde81sxZKPilGVsbCGF
	VYXT8xraDsASOfmasSqJQnva3bHCnU71rSbQ/LCUU8X/CGr7C1kPDoqAj4Y6QjrU
	uWom8eFBD+CJTJZyOi0NQ43paTQs/kJgwciafNjwCbEAYfxhzudXpbrFHtt6Q6YH
	fzMiUcjuRZ9TxCKRY78uPYdu1MiJzXmyj5U9cPM60cfMKF0F5DdGA0MBIIUqZHb1
	vlGdyw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqw7rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:11:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3ea727700so25759985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751973067; x=1752577867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lROYxN8HV9QfliUbHs8x/x9pgDZeMnRqOSq4a3lsV4=;
        b=MWmdSsY6ZEd6QSg00UADpi9W0Moz+rkPGheTgHRqybl2JX60eN7qURmmGU8S6UfjW5
         HPHAdiueVa8oQhEvTBkha/zH51OWK8SaLJWjNG1A5TDt4CXc+sGIJBYfVCIgeeUHAAow
         Zyv5JCZ78clcJMT7zdA5t9uaoVJ3TG+RgJxY0I6cOUMV+OxyE5y7pomI+JQzW6dCjUEG
         ACw8uZYicqebDeuVC4ZczpYjzw3rj8x7f+7oXwL0q58Qq5+oNPjO2H3pcjafkH+VROJi
         h2BoA302OQpSHb5lfrUP7WCyIiko8vq5DS5tRXMY+Hx9zADH5cyVNeU6wcrAkMzydYEr
         RnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU58qFn49JOeTUZg4/pBMiHT1tqkkobh7zX1mvFdO6cFfQPWkVvz+2DgR2ALaPzFQzbGOn6WtUsa6sX1Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTFqZFMjqKuekCNxZv1Hk/TAU/XTbcQY/vwMLVOobDlXebJ529
	GLMJZf9Jtu7n7vduXwc3VjdWkRbaXT3R2oHDC4BulH7Kiztd7M1uwpgigbyYjnO6McwiPvfiCgU
	9Mbr/ZuuGiXksiCaWATAYYKOftVIhM4D1bUfxSwh7Z+wJRXlkmw0NtzaDSDBP9TXYW6M=
X-Gm-Gg: ASbGncuuegZ3Gko9/ZyLfLODUdqyePqR8obWKtVYWHZoSXRDjztPW8O9+y0q5wAIh59
	nTVeg5EAeXKffh29NUHq4/oscD4Zat6rVo3ampUE6oos5akPdjlLOGf52xmy+AJJO/yXaxJcub5
	7ix3AcO393KzqqpFeOnocGzdHkEFOaTTKMkttUoI97DFtvSih6acdpWMqmvR3MEDaFYPLVSzEI5
	My6nDxM6hdFeKJuLTXZMiW2laYzsHBBm8192yYNGJTeGCZ7QPjW7rzNObvJcDTuc3sWQUiYyaKa
	WPCXJQuOAQIriY2IQ6oncS/NAxzsYoRxiNjTtCTuaQoh7RGPoQkyHSjWJkHJSn3rmQ910DZ4jSo
	r7Fs=
X-Received: by 2002:a05:620a:2901:b0:7d0:a01f:fb88 with SMTP id af79cd13be357-7d5ddb60e8dmr794914885a.3.1751973067335;
        Tue, 08 Jul 2025 04:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuD4l7AycjpL00d8RxKHZehgSiLvdJXlcj5pe/WMgV1DkSD/H3bFiAzsi8MVn+uWHE7oP1KQ==
X-Received: by 2002:a05:620a:2901:b0:7d0:a01f:fb88 with SMTP id af79cd13be357-7d5ddb60e8dmr794913385a.3.1751973066933;
        Tue, 08 Jul 2025 04:11:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fa9b8sm6943484a12.54.2025.07.08.04.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:11:06 -0700 (PDT)
Message-ID: <c0694c1f-570e-4cf3-adee-86bddf684f53@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 13:11:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix OF node leak
To: Johan Hovold <johan@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250708085717.15922-1-johan@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708085717.15922-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686cfccc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=KS6flrhD15DKHPIahM0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VH1CkFTIkYb_gValiQlLLQi44ghsUNrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5MiBTYWx0ZWRfX5gBN+iIycrwS
 iF2UMCHMdbXESxyNmcjJexwuyUvaNnD7JDy3mM9BF8+i7k6+UxK7zHHOLjqvGBmDfr05ItH0KpP
 DVfU9wD0tSb8qX5GMwR9elUKjYfmB7j4HjdRcsF4zfTgIzboVnHgEz/5tPPeuRQm1Kmblty4sJc
 LdCyh7c0xXWodMygftk9z2KQ8VJpxnRuqfnAZOKH3WbOnaYqzf0zyD7EdEGK0qc5sm8VFRcf38C
 obb18BXf9fb/voTlFtMtKBT32f3WGaHYjrWy1RuzeV8NDPKtf6P0EZj8GIfGwKoZchk1M9xK+iH
 joedVJsY0n3xJdaJ8Tp3lnaAs31PaBcNW7ZHcVFyl0uva5abLYkDP8LQdH/i/47iMOAKMgLpNY1
 uctIzOnbPuk066yrUzik03CaYAf82lNbUgE/TG5+JCe0LXE7j/ClYzHTdY0AYqsd+lvggFp3
X-Proofpoint-GUID: VH1CkFTIkYb_gValiQlLLQi44ghsUNrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080092

On 7/8/25 10:57 AM, Johan Hovold wrote:
> Make sure to drop the OF node reference taken when registering the
> auxiliary devices when the devices are later released.
> 
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Hmm.. maybe the auxdev APIs could one day do this internally

in any case

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

