Return-Path: <linux-kernel+bounces-853565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E8CBDBFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D28A3A8AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC32FAC05;
	Wed, 15 Oct 2025 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WkHXfgjX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EB270568
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492121; cv=none; b=s2DU+pcV6MOwbk64uUwGPKdNF79pXp5ASIdbi62Nql8jF0lhSbUBmtLO9g4/DnAWpfkhwkM3ZpsZhngruWYTsJdPs4ADRf97xlq37N2H5dktHVTGWs7dG6O8mhOZTHaC74E+NsMMX665U1FzLR1V656mkfK2IBf8Nze2QY7hAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492121; c=relaxed/simple;
	bh=lGfyomj8ywCzIvERjBIWuMLzvtnAKZcUA5B+1/3dARQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxvGdnX1A3Z/QtKwXuzFS9WBd8zx/jn3KvTi/AWcNHUcvJYAkkfEJR4ExvYyAxyaoDPE6G+tunPOE8Qrycdobo3uoAe5UhXrajht5NthACAYkCFg2szWOHS8vgD01CkNDtaxyKfu4tJ+OLHdWzTovXEw2QkYCe4F0puGxNKqC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WkHXfgjX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKRDrd015537
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k2n5J3Jvlq5ovhLn5DGN5KkteKpvoUV0qo2PgJM6Fp0=; b=WkHXfgjXNdO/iuhp
	iSWmUM3w50cjnd4o7FH7Yc7dq20uzSaIAHKnp766ugBFJbUpt/i+WluFzWTu4wWp
	IcY1HybFxkhHF2Ck2kRyeljJhsliSzo/gkQe66b90M15G9LdbKmJSVU+ypnmvL7K
	01DcAPUvK6sSRvTnOIrZ3M2NwYI/fjUR2P7yMWXVmsohrFNApmm39hsqnGdjl+3t
	80PL6jhZGrbor9cqVMql3jDzipq6lT4iRFhUNOAzVDux4vW49Aj3Y990UlOOQUmy
	AQwd/2H2aETVxO1u6lr2RBDXcc+Q4My+zdZ9bCQkRgS4uR4+zampQ/zvEN9t0STt
	T7zupg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c2jqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:35:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-335279648e3so2840971a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760492119; x=1761096919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k2n5J3Jvlq5ovhLn5DGN5KkteKpvoUV0qo2PgJM6Fp0=;
        b=Y4BViWNJDJKzA5PWplOfmLtBpCfq56SWXCO6z72XWQ5DRs6vGu8zr5TyVFI71qgd8I
         pS5FzEi4L1TsE+spLfOC2mGGKAyg9zPKiDJSN9qDEkNabTzVvSb5CPafkeUWq0te27Up
         1G6yl44W+yH2LpionI1vhwHnHsrYGGJex1vXZMniscyLFdUPRr6YJN4JMV89gXg19FqQ
         39V9KjStnn3E1rZj2QodpaXj4z+70K94qGPgsobmZWqVUOsFswfXQrLjfRqFTqD3zzez
         Eu98cwWbrv+QolVWRGHVE3Aq6M9oYAhDv/8aNnShIhVVUgn24woguN1mc/ZRpAZ4yMqG
         9Z9g==
X-Forwarded-Encrypted: i=1; AJvYcCWV+dxFRdIrNHTAQHmNyeATNseLGn2MQYyefRu5EKLHs9EYWIzXklCL3NHwdS/dQrA+REyJytbCnMDre54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyu13g3aniSPtBA0Y1jz6H/TOKPGaFp9dwh+AsSGnbvaRu4b4V
	spSRA1CCkdVoiRpy7SmRXQniKaXOwr5lzqrBeGPB3m79yWg6ZdCYNZKRDkyL7xY4HBdcrdAmLvT
	B33oqdi1tyaMe7C2SmslRpfT5oCbUi3jbfJ5tTQx7dUiX81C3FOJiiVBrbPl+ueSJABc=
X-Gm-Gg: ASbGnctitAZr479eWWHvbOFYfX/+9NJsOkam+yAQDdQxgQQfqjkwJBnLgG+krf61wHN
	nkHnU9ySS6rxl/uyspKXLhfBfn5qJXwdQroNSOAzJPSrSxPxmwCN6efZWc7avM9W9k5Aq++VuY6
	SVYtfp7pM7DThDFI7YIjw2DwbclP1KGg+DuQ/HgCWcx8dAMuZRjTRYFSfxoX4mfc3UT5uOHATjW
	9ZuzhKSVw1hCtz7QoxvTOTwvMl80x/DWi1o0VbQeVzObzda9VVVr79uyJm6vWlcSfkCzmUfdvhl
	g7s/nFcIarYt36zB+Pv/wBzDhwqjAsvoP2liERPF3NAsfgZd1pEcl143Yalfsy90uff14yj4DWk
	mYFDz/X2pwoimr1JVkZfreQtmUBYRRV9qRec=
X-Received: by 2002:a17:90b:1d10:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-33b95dfc275mr970072a91.5.1760492118748;
        Tue, 14 Oct 2025 18:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc+CZt0xREG6/4LPwJm/Rd0O6qubFBGwHV4l8y5dMCUoHmdZH14Lg5AhY6jiw29nPPSwGWyA==
X-Received: by 2002:a17:90b:1d10:b0:32b:dfd7:e42c with SMTP id 98e67ed59e1d1-33b95dfc275mr970028a91.5.1760492118252;
        Tue, 14 Oct 2025 18:35:18 -0700 (PDT)
Received: from [10.133.33.159] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df7e1d1sm13305597a12.40.2025.10.14.18.35.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 18:35:17 -0700 (PDT)
Message-ID: <fb83f6b4-019d-4dca-86d5-87ed018153a3@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 09:35:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs615-ride: Enable DisplayPort
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com
References: <20251014-add-displayport-support-to-qcs615-devicetree-v3-0-74ec96ba8144@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v3-3-74ec96ba8144@oss.qualcomm.com>
 <geh3pbatv53bnk2zgyalnwvumvcsqaz6n7x6dniohsfk7r56sq@mpflfuye62ly>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <geh3pbatv53bnk2zgyalnwvumvcsqaz6n7x6dniohsfk7r56sq@mpflfuye62ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kf540hKF5u4kgqzSegOoHrbSTGqAqt6E
X-Proofpoint-ORIG-GUID: kf540hKF5u4kgqzSegOoHrbSTGqAqt6E
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68eefa57 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2THbcKMbQ0HsdItsycQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXzRQn+wkR/VcA
 ywPQhJolT51A6p7s0ko2EXo+3AC3gi4HSBw4umiJmkqN/AEQ+uLxmwajODz/A/vpJwZinWLRexZ
 rl114JVlVKsU5YW4LLBAKpWoFpapHnsQ480L/EA3SQJArvD9APk8q9HxcGgSYUzNpooXnwB+yD+
 2Yl4qwGx5lyP6PF1mE48OT5ijUV6eQbzDJvc5AG9LUVm6IieB/uL3Ik3GOmxDfvWIjO5YoOU+zd
 mxMlVZIw3exfwz8NdhzeX1NtwCBcthwU9Hkz3PM89V+Ra7iQwtkBZc5FvJyQfhCFhsZnMPSd5lI
 zBH6mZWlrYC+gUPM2VG9Xyol79rT+EQ/Nnz+F3nQ/f2RK0QUXLoHD04Y5Q7ooaOUVvmjv+Oa9HR
 c4lwKlSq46NKFVtt38SrKGgVbq4TPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022


On 10/15/2025 6:16 AM, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 07:54:56PM +0800, Xiangxu Yin via B4 Relay wrote:
>> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>
>> Add DP connector node and configure MDSS DisplayPort controller for
>> QCS615 Ride platform. Include lane mapping and PHY supply settings
> The "lane mapping" no longer applies. LGTM otherwise.


Oh, I forgot to update the commit message. I’ll fix it in the next version.


>> to support DP output.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>

