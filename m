Return-Path: <linux-kernel+bounces-775590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83DB2C11E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59FC15A043F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338332C330;
	Tue, 19 Aug 2025 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BwveoB+w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777A322DBF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604068; cv=none; b=tjzkuWBvtdQ/NlLe7xZ261FgZdtyyNLzyS96j5mG1Xhr0wJoGiwa/Sa5HdRpRXYpUmYLabOalnxAlL7iWD/LmscG6MSEnQqarAg5c38wghewjAO7hwbncKFztC6wpY6VVQ0ed7xxHkRYiu7DfLh+/VNKrEyiIkLQg9eGiEhbdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604068; c=relaxed/simple;
	bh=a21opQrx6FtgjxLAH8msEDeK1LTD9NhoP7uXufEvrZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCJztKYuvoG67z+Vq70vaHOeXUvomf6R9qmUjYjH1QgevUxFPN5LRTvZnmfQsV4G1GAnmKrFtNF5qC6JsbUdeD9lu8KO5t6JD6NXnDwYF+iMqLyFVgT5Sr386vFF0XdPaNtpzUQgOfjdNr9R0AsuycvQhYd1+2SR6OdmpZRPkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BwveoB+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90X4V007209
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eTLV4pbAiALqLWMe9z9+F23m
	6/Z57HSatoPEldwbxjY=; b=BwveoB+we/C98knvJ4KJIE+TpFVSfbPzdCUk6T1e
	sS9viKkbTE8osTL7y8p/imthlQwonXoE95UXx68uVipXP4QGdCJwmP9YyQ8Ujhlw
	b0UJrSEinRKtJN5+MSG80XO3u6cmKIcl8BKDHsnwkYcwW+bouG2zuf4joQ/v1t7Y
	H6gJk/ydtNvtMcvLulX3Pfb03SW4mj2hE1qFpD0NWuVPwhab9OAYfMh5d/leUHE7
	e7JzUB0jjgUR+lqT6Gpc9ZiXvd4HYafno5PloaWMhVPp9rnESCkebPRYwgT6zxlI
	ABcj1gErNhi3Uzg5uNZrgd4GIuU0JnH1YOxELZAKcB+oVA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj748dgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:47:46 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b134a9a179so25257501cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604065; x=1756208865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTLV4pbAiALqLWMe9z9+F23m6/Z57HSatoPEldwbxjY=;
        b=U2TMNxhKVGkSq2KOWr2Z2rbYKxWPkIbx96hNDhV/cpMkjO5HlzH4f8hFEA48UgLR4f
         inQgLDbP1gvRPWatvHzyQQ18h2hJkRz4srMGFv3svlVD0XgCLiC4R9wHgekwIaA1zlDh
         Bm0muwYNGS6cIM1VJvuBxKOmugsEaWfk5OALQRNh6Rg3rTCt1XAs3lxpMVkZlbt9s62+
         0PftScw2sVkDcyMQay1O2trFbR9nRf4EFfRAj09O7VoZ9ByQJdWEjep8i6SJlN7S5h8L
         U0YFsFgD5tYymz5XAlQpWhfgJwo3JAwTjz1sn4Ng69HDsFo9PVlJ7vMnjblQvVQFr3+I
         gCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaPgb56PuXpxWEynZSt9IUk8ri3k3RHJCbc1B/qv3WjnjkBUEKIgpBCRwBQX5o+dTWhUmxgOy0HeNNhqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmnQGjnpvw/OHDo2/qai5yCPfrL6RtK3XtGHW/LB1aLGbs39P5
	8tGcOHptniQit0gF3mOqSyLtpSbktXKxA4RrXKiCVIkiuzkJ8phx9RvsZiiiNrtGQamgobW6ipa
	4//PW0f5hsHTxyo7xknzmXiAH/Zi0SR79Q877DPh3RoxcDdGMb4xHPyt9xYV8U5uKUBM=
X-Gm-Gg: ASbGnctIUG8IatKS6NnhN6Re1A/AFusv5J+1KKb5RF1V9oDdeyPAtiWu9TPYk/bMKlD
	2s0uFh+y1JJ85uuUbWE+1c56GY7zm3CtDA8KOlB0bD+03xAuTv738zCktnCrZIBwNL1FhoY6iCs
	Y1STWXbnepPcYgfmdVDP5SbCOutDxBHpZQ+p0ilArIaTGS77XcERovKEXfh614GnjtqCmeAuJrv
	WZEfsOHixVpidk5VojTG0VQsOqI+ANZUyf5ZpV7MSbO/vwisw9pxIT5uVsUlJ5hpT/gN1YLJGs1
	trCaia0W4kfNWQZUITC5qst3omb6onSS7AGw0WA0cAJIE2xc7jbuuuM+N+vghBBBUwX7BgOuFCA
	58jnjFwwGzlBojz1DxIzT1A5vvN1GP1RkgxYykfFyg52fCHAyAdRh
X-Received: by 2002:a05:622a:4896:b0:4af:41b9:f66a with SMTP id d75a77b69052e-4b286d32b7cmr27661331cf.26.1755604064593;
        Tue, 19 Aug 2025 04:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUsM+R5H5wwSDp0LniUfNSxIvrGeWb7sj9B7rqdTJ3m7dL4JTwfKGIh+GVqeo5+ljeA2NF+A==
X-Received: by 2002:a05:622a:4896:b0:4af:41b9:f66a with SMTP id d75a77b69052e-4b286d32b7cmr27661081cf.26.1755604064113;
        Tue, 19 Aug 2025 04:47:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3ff916sm2047292e87.131.2025.08.19.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:47:43 -0700 (PDT)
Date: Tue, 19 Aug 2025 14:47:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: use kcalloc() instead of
 kzalloc()
Message-ID: <x2fao6hlzdis6pqucfqwrjtv7xr274cdkjpz2jhz7iglbpcbei@y3dxedn2diwf>
References: <20250819090125.540682-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819090125.540682-1-rongqianfeng@vivo.com>
X-Proofpoint-GUID: eZq4Ot0BjNR16Awq3enMQSSrTWFwWa5G
X-Proofpoint-ORIG-GUID: eZq4Ot0BjNR16Awq3enMQSSrTWFwWa5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX7nV3gxxTvpYW
 jL54S1asOMeWN/83B2PUMqK6g6mWv2s7LNbjod7zZu+MVSs0HvDHod1ox9Ru0RZdIHu9ZH70u+U
 ta3ROd1oH3dFpyQ30675UiSMEoqn87+pn2iD1lk0fJ17FOZ/J7I5li5SJaNX4c7tUhulZrBP37A
 Q4NjEN5VcdB0mzYS/spUKg6270R/pKoPjgXaaCqp4juLvHRSkOU3CMpox0PkuDht0f3Y1Ee0+Vz
 DljN0txQe7iZAf2OY5vmsz9ds/9XvHrGg8Urg3mE69121C3vbvAgvemFRpkctoVQ8JjygGCixvt
 XSb13WmzBzDus/u33XYlA0f0/BzIUERxtLe10Li8n3QsVRtSarP9GQlSKdYQ+6yasgNQ2irq23c
 0ffArKqw
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a46462 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=KBxqgXywe9IIF68hBIUA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

On Tue, Aug 19, 2025 at 05:01:24PM +0800, Qianfeng Rong wrote:
> Replace devm_kzalloc() with devm_kcalloc() in qcom_pmic_typec_pdphy_probe()
> and qcom_pmic_typec_port_probe() for safer memory allocation with built-in
> overflow protection.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 2 +-
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

