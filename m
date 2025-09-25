Return-Path: <linux-kernel+bounces-832304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 827BBB9EDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921931B20D50
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882712EE60F;
	Thu, 25 Sep 2025 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KjaQk7P/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCB2F49E3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798577; cv=none; b=N3u/8TAJK+gDqNighXGQ1ayMjWNm/vnuovBaDeAM34gqajwRgsXiWXRkKDwDUwtnsGRwrH/Dmbxu5XJcODXLT6S9UipG1yjgFmF5qF9r24VDkWY6HxLUDp6bRcNK8Fesh+b1OGabT4eA+EMmCRbinq7qL4mF9lQEAbWwDd8ErkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798577; c=relaxed/simple;
	bh=o0w1GjVwQtKKp2NQc8WIpZmZwonlDjTJQySGBM2xf0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IWXhEN0odPqXa0qKKT4qVaf9Eq5QzciObkhAiJlSkyv+2SOotBBT5hBE9Ib+CK4hNZvLu5VkDPTg8eKS8g7+6nA/nHey6mkobZhAypN4NjBY44zBQY06Q5tCvwMRBDHLrRe3kjxcTs7+UKWBxtZkNJhOEeORJTqFeYr/1ceZMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KjaQk7P/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9xtvJ002802
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M1MCSGjsMB0h6le6F1/XzmUDgIWqplxEauOTT+PDP2c=; b=KjaQk7P/O8uOYVp+
	5euhxmq2QNJ5VND2syvxJSJ4tWNE7wrrWuNFApVh1stoYnLio2fLzXpZk4XiWhcv
	OULupd+G7LcNKaZTJny26lkx8MiXsH2WqtBbjoVJym70KbjdNjXH46w9BKreC5Ve
	cJCRnIO9grt3gh5dWYsQeHGlK/fKWYnNwKKGObtnn1lwLAjaQ8dMcYjTCVjeHOKs
	KsOsm3JTduhVb1lPThxnkBQQHhYWiUvMj+lL4CS1A14NHn6gj9aVhoGJKXwaXpT8
	zmM72mY9WCCt3pmVw46CAJ3sVb9lJApw3J8VENRzj3qRpU25qRXjh9PaUDXbxk45
	mQrrAw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf2d17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:09:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-78df9ea0c9fso1800166d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798574; x=1759403374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1MCSGjsMB0h6le6F1/XzmUDgIWqplxEauOTT+PDP2c=;
        b=cvaHzFJRGlqkaC0ep7OSxRfWU9aFPykcuh9cpEx9H5ZJQVknrSR5oK//fW7q3EPmdY
         WSs9ffZiyRJYz2Inku+1C7geDqS3E5x7ED8fZhfVNAfZLKcX3Z+l/JegGVhEK0p1yzXa
         9eu/h6o816uzooPbUDEpbK0sfmix3KO5CAyoDluTNs1POE/PWruEHx8KnMg6GPjilQPA
         94BJ8IUXFkH5x9RgMa0VW/Riogtx6CjfJ5U1gszhcomTeQ8LYNWmAfRAPNL8zgw9e44N
         kiwYC/ZezamzhfsqLdZGbdJLS4QgYVd8K15UaTjpwCpKyR6va+QuZZVlzpVew3G7i8HS
         QS+g==
X-Forwarded-Encrypted: i=1; AJvYcCVsNHYZcy1XYCczaauXLs4FDxM+nECN5VHigHJ3jQs1PIdom6s09CapJL9uxSd/FTS4iYESAenuLosC1/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYCzfsPplKmTntvBVtocuJwfsVQJLd25A1UKQibRa02t6+27v
	L2pk7qVqRtv0tdM0mel+2QW0+A8mTiJHo9P2ZeCYllTZH5dx1woEf3g83oyyJZMlYu4pcM05LlT
	c33awxhS0Tx5kcoF0UxQWC/2mMiR9YzHnkVx9FcLeZfCZMUzr74zATULL74GxUkFHcNY=
X-Gm-Gg: ASbGncunCZa9XSDCOW3wFGP/NK+bNGliH6JSUQtefJhU8cTr7sRsD9FlqijtkTrLkfX
	YEvs1/QuVsGoPUu6fKkv0s8RE+aKGHOwnXLC3Oa1ItjiDUtKIj0Hcg+JG3h4Co3hArEkqNp3g/F
	dV9mXGg+PsnAv16F2Y1RY4k5S/1ZggiBQbjCVK49HO350dmt2Pt3h/lMI4NqrNnjYqcfLen6Vff
	b3vWL2lweaoo91QYY8Lj55+r6oNRxy9lAtg1X0v292RolLZTBjDGsGfXxp479Q+QZPXGBJYyzgX
	GUHiNKicf5YoR7HhsCqKKvyEeyYzO1blvReBF0eWGRVQFPa53837ozxnVTCHvWXDY0xWuLikxps
	pE9H5k+n9M8BReGyEkk5u7g==
X-Received: by 2002:ac8:5fca:0:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4da473524bcmr33527731cf.3.1758798574348;
        Thu, 25 Sep 2025 04:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7jli1zBEtFvmlXFlURWL9SpXADy7yTP8i5IQVq1uMTl48RyIBKvH5PvDY1w7lojOowXBzSg==
X-Received: by 2002:ac8:5fca:0:b0:4d8:8b29:228a with SMTP id d75a77b69052e-4da473524bcmr33527421cf.3.1758798573979;
        Thu, 25 Sep 2025 04:09:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af5721sm1018360a12.43.2025.09.25.04.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:09:33 -0700 (PDT)
Message-ID: <1053e541-4f35-4fc3-9f57-2e6cb9c61f9c@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:09:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] arm64: dts: qcom: glymur-crd: Add power supply and
 sideband signal for pcie5
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mOR3iK6hwGtaA-_HN0frKwOddZUqHXsk
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d522ef cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LDvWB-EhgdJigILL0XAA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX88JlDz/VmSka
 GcwdXI6naiLmsW7EvO6Ey7Enyrn+8vySO6kLs2UzAQFTi6fWoPmHJmktnl7O71Mb90r6+ZETAWK
 jK8IxXwBI568o4FlZoErMmRlwV2RbGEiYMGNCoPiGE8PwtnA+zO0al/n86ot9cN5QzpsbwxUpD/
 mTytNbvHB++2yDG4XHMERfS990nOKvG7gJOGXRnvZlU2QXPaY7YXR7RY/kDO4JheSByPh6FhlH8
 OWKTljUdsX6X/HkSMa3T1df+zrmEn3W4gYWBQWDjySnp3laYKcMU1rkkrgyy41UUG16ILKygEUp
 dvU3bhOvJX8/01GvTw0uWzmK429G++id0LkCx+HDG3mtTuDykhSM6sN0Yj7dZso0VhiJMufrTdo
 otm8fS0N
X-Proofpoint-ORIG-GUID: mOR3iK6hwGtaA-_HN0frKwOddZUqHXsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> Add perst, wake and clkreq sideband signals and required regulators in
> PCIe5 controller and PHY device tree node.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

