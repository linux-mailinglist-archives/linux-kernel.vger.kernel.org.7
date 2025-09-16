Return-Path: <linux-kernel+bounces-818551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8A8B59341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F9C3B616D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE987303C9D;
	Tue, 16 Sep 2025 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EtLbXwhP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B4303A21
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758017966; cv=none; b=ohF2zFLTZwkJxix6gpBYe7E6X/ehjyu2SvukaQR0c8BkCG4Mmwu7yIuabYZKtfpSHdQSHOLzG4hi6O6Tx+SDR0kzxoWNYMPAYaC07gGzyFr7g572XrCPWQHFtCoORyFzpYfMPHaut4gWnqm50uFMwOcvHx12z1NOkeGJ8niyJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758017966; c=relaxed/simple;
	bh=0FM9OkE2a0680o9LMFE/4uvss6jn9QpaCDiB+I50lPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPC72qL8H6PwFbHLwRaXRMtAQsPi3gPdP7hT4cLiKTPx6OPHvaj266E7AvMxDY0fInQpPvVD/nXtUMnFZMUOpFyJk/jK1ZMaZAr1rzGLS270drQMY+FQiH6wc6o1kGSLJ6IKD7gsJgaxIB9RTwM/+ZRkOzfJfjypnWOUk6TE9e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EtLbXwhP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9emwH001535
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=sl2TOog3kB9QFbelgSf5eIFg
	UTi8GDmmk/d1oNtHYxc=; b=EtLbXwhPk6zfkjc8UtKVO/aB+5tuueVqBzcWHv/n
	ywQeLa/Pz9TBq8bpIjMlt9FItt2kfsEzIMDS0pXE8GkgJfeeE//5uZWeABCDzAGG
	blL5pJ7zTQf0GFenVwvXXVNmPSLeXxlTvmIkN0GlyUrcvZo2LYfCgmGpqAmfx0Nu
	9FZJhfo4DV0KuUB3Ywk/dPRsPUTWhz9yDTtBv6ui9JrZzIr1GhCSopEC8eDaxsQd
	snmSLLHSqP+2xAdIQUoByYSOjNgrGJvfTI8jO6d2VPtvrV44b8XXafnFYq2UIjQO
	6F1nwo34SrUK0SdhfWniNH4sIyQMunJ4S+jtXcHN+Cilgw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpyfp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:19:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b60dd9634dso126291551cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758017962; x=1758622762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sl2TOog3kB9QFbelgSf5eIFgUTi8GDmmk/d1oNtHYxc=;
        b=HFUxTCG345GzDyf4JW8WJvdFUr7s9FYFI23uOB/BqedRhVWm3Hv06ldGQxsh39euB0
         xx16IhzUGl8jPlioP9RjME3/0cSuWy5QvqueDSWQzzUjoGyPvkyc1Ntl2ljHW3LwR7h7
         gH8xGEfl2+ty2FoNXx9NwV1vcPsriYgJOuug7Q1ATJ+ecFB65/k+S1N6MiSuw+zJV7gG
         vvsMOQgid5sWa950vQalwCBwzxYf4tyI8IpHLxtQWvBwoQDu1euBKrYMwJlKxYE6T3gj
         iCL7BIWeumh4oAAB3gjYUu8zr4qH+SHkTV1hlgvXN+TKQhzlMqRoGg+KfC5kR43vExpn
         4zrg==
X-Forwarded-Encrypted: i=1; AJvYcCWZkXmLV4LOa6vusE5RzcKrgLEoJ7pXw9RAx73XuKAcGN0Uz9vlqGzy28IVb7I2K5KfgMqAGduwTZOPEYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4rQMqVWRo6X5jF7bxtqbxziaDp8+MHIqPCcmhnE78xIBw48w
	9NmNlY81xdofHzzenK4gv3wM+c1BjS+vnkMDedqttE7/+cxLNdRkWYQXHiLFU5CGVVnKZFKBgMF
	NVE0VwiXqbigS9q4cOnLyNMZ48FzFu0QrCmNFsYz8W0j8ZGRDQ59E+6hfNLlQ7vSHv0c=
X-Gm-Gg: ASbGncvEIp8zMogFeXzWAI8X2blIDNmGDzfJVGkbkAsYCJ/d+NJ5Z9aPHCNaDWlptXv
	zYTwsAtq4pm5fjjmod7AKcoEuz6v1WHXAzkujPb7gBVgD5OwzRRzZsp9beMgVFmYh6bt+GsqoVI
	cjfPyhL7CIGeYXbyYhz+2dGNRF+LGtdTpW3D/lMIyiNLmSroiZqhgH0KSAGhhs8eJCcXcQawFmO
	vQvmVkLhEoQ6dXkSzcfn6VnSmBhmlLeLVM0LuVuGMGs5SIdct2cMTio2DMll6o2f9sq63zcwv3/
	bWmT/f6s3gkCt0xWu4vjMQoCp1foPYWlEO+qMjhOvZwFPJDUr9vOwc3Re6PEV6ED9ActaF+/ORs
	+deu0F2hIjaNflVvCmzRo1kMxhXh9wwE8AUuUrBqK7r4GkDsxpPon
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr87539331cf.82.1758017962612;
        Tue, 16 Sep 2025 03:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRX7VgG6Mvq4kDoTzOqcrX9aymRenqpozVFQTu+puYSIYn8Xg/8lhSfWflWu0YJbAs1S+Zjg==
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr87539111cf.82.1758017962162;
        Tue, 16 Sep 2025 03:19:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e65754ab0sm4211645e87.132.2025.09.16.03.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:19:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:19:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/4] regulator: rpmh-regulator: Add support for new
 resource name format
Message-ID: <yjal62st6dx3x7jv7lz42xfkw6xyzc6b4sfcvdzigcf6ivkyp7@xmwy647h3ohm>
References: <20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com>
 <20250916-glymur-rpmh-regulator-driver-v1-3-bb9b00e93a61@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-glymur-rpmh-regulator-driver-v1-3-bb9b00e93a61@oss.qualcomm.com>
X-Proofpoint-GUID: 5KPeUXUBkf1vCsUzJToiUFiRNq6HOMSs
X-Proofpoint-ORIG-GUID: 5KPeUXUBkf1vCsUzJToiUFiRNq6HOMSs
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c939ac cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9nMCXy-jIdBvRpzB-YEA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfXxFtCHpO/sePp
 YykA5NPwgb24Y+4KN6xqmAL2ePz8OQAqgrlTHDatL9VYcCB1uC2k9QxSCi6ys9X22ebc8wSJn/I
 y4+2fFtE94mlaGE7ELsPwIvr9c0unKRnY5S3fWJdBYoOl6yOTrRxYs2DAa3w9JYkenFr0+L4D33
 C3RWQpM7YAsFScm6LlKIPXcBjTzDNmlJ92cjUJOHGSMv1I8fNS8aXmWYHQ/IGL3ghkpY+tuzyq4
 +9+sk/+sc3UNicyhJD54FVKfI/43tuKh9NhHZ0Hzs9wTsFpHeZghVO2jHID1XPF8neEM51SPYXu
 RkIKEX8xXc6Gdoo4Qe4/2zspCBoCdRr8SYM3dSuz/S1dTENOTJeCU5bfgfyYcHr6SbiiyY89nDx
 +x6OEMlb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Tue, Sep 16, 2025 at 01:28:17PM +0530, Kamal Wadhwa wrote:
> Currently rpmh-regulator resource name follows this format:

Mention that it's a resource name inside cmd-db.

With that fixed


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> `^(ldo|smp|bob|vs)[a-n][1-9][0-9]?$`
> 
> (eg - ldob11, smpa2, bobc1 etc)
> 
> Here `[a-n]` in the resource name signifies the `pmic-id`.
> However, newer firmware follows a different format that also
> includes the `bus_id` as well in the resource name.
> 
> New format:
> `^(L|S|B)[1-9][0-9]?[A-N]_E[0-3]$`
> 
> (eg - L11B_E1, S2A_E0, B1C_E0 etc)
> 
> Here `_E[0-3]` at the end is the `bus_id`, and upper case `[A-N]`
> is used to denote `pmic-id`, while the regulator `(ldo|smp|bob)`
> is replaced with their initials in upper case `(L|S|B|VA)`.
> 
> To handle this properly, do the following:
> 
> - Remove the `resource_name` member from vreg init data
> 
> - Add `index` and `regulator_hw_type` new members, which will
> contain the index number and the regulator hardware type
> (SMPS/LDO/BOB/VS) which can be combined with the pmic-id read
> from the devicetree to generate the resource_name.
> 
> - Choose new resource name format if `pmic-id` contains `_E`
> in it, else fallback to old format.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 1134 ++++++++++++++++---------------
>  1 file changed, 586 insertions(+), 548 deletions(-)
> 

-- 
With best wishes
Dmitry

