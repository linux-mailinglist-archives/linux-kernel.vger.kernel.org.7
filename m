Return-Path: <linux-kernel+bounces-742585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FEB0F40A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9249617E350
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD532E7BA3;
	Wed, 23 Jul 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="be3mm9vp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3B2E7192
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277548; cv=none; b=UVtkYCbcKmhV7QALU71SHX+bQo0iGyZVnfl1WLsWbdM1BeSsUUmUABCA/QQhLEeQUDseJ0wcSgvTdgJiOoDNCilqyEMopbToWWQtXKBHi6p5xn0x2IuhxKFr77lpNayt2rWwcmf4Axg9iS8Dqm1/O98vadz0hWizqZRQvRaFyGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277548; c=relaxed/simple;
	bh=rDMsRExAhg+IKHg6jLoxGwz22w8pztfKeZb3nBhwGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYVQUP91eZPjb9E7UvOE9Mu6YlweNuhU/HW89/+AqWavECiYfwC9xEK0JdHkLZyTAoRwGYu7ONjz+2kN3oFUTCgFhgnrZhk8gYir6sMrw1bECzgSjC1s4PXbqPpA4h6jt8jUJyhXiEREPFBj95L6r5du1XxXFppL2E0YB2uTxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=be3mm9vp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N97sMQ009438
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=2bXOg94c4P77UMYH5aBqkxUK
	tX2QBEA8geY9+BQ+StE=; b=be3mm9vpNkezVmc8tMKVcODyOi3UfenRTm5h4kQg
	ygWE3bABfpQXTgd9j0w6gtG1LyArH8eD8pd4aAvnHySUx9oLo4Q0ZYKL0Urxcsvq
	AUxljNzdFSHR+yIzXGDuLGXnCy0HNdBbS+W9UB05UmNJtLuaY9cQPDwWsWacuHEg
	XndOkKjsh1dPYaueT+0Cf2o7fifnc7P9SgaO2Q37sbvljVqeBfTAK3OwJW1voSCL
	cqeDHTsiX7pQfKqdMkNzkdW5c2QLU1TSrSwEa9VbI3YdLp2j/0gPK7FAtzZ4KWYu
	w+iqw+G2XQ/B7GBuB6+kwAhCxGG6klrbh/OZNw3pbgNlGA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na3pq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:32:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2c8137662so1227204785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753277544; x=1753882344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bXOg94c4P77UMYH5aBqkxUKtX2QBEA8geY9+BQ+StE=;
        b=nZlf5jEe7u64QHX2SRPF7bdbSDJPvfnVEnMfI8HXogda3CyOKZsj0W4yyuRgGWMlC2
         mCZ7qhizb6CPYKH2kZQ6G2sXF15dfUb9QZIbJHQa43wNWwQ0rxul2dlawqXHEyJtjc/Z
         EHKjsvdQHu7EJ6wIaHLS+uIaC4XXKVTVYyFL046v7Q2QwBmqVvyj98zmyXo4daN+7liW
         9diKykuuubihyiG7/8FrryBrCQD7SPu6QEuWarA6iz8sNYG9Y6xsbq+oE9MOp4w5ZjFr
         SWrV/oCKynUo+xosWaYI/pKdc6zCUKRfU1fVmVB1ZrHTkB0oryl+t54FHFRlekE/wPCp
         lM4g==
X-Forwarded-Encrypted: i=1; AJvYcCU0pSImzDXY00T26CeyTP3wE3rNonw2diH2WOTloqbGJdkba1vIz121ivPul1WuwC2/AK1E9me2fpuucxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVV7BgLEm0CJQ9OWmEc7zgjDMUliEMb2TI0Pe97H+kPdy2yBAk
	D8BwQ6KUSXm5+tcI8LpXQ3ML+Zpz8KbJ36hzjsD28PtjC3ysZoXGmiafyLqn1XmP4EioZK74SLF
	tTK4cHmaqv/ZBfPBdIGIFJZM/42pd4/ssmnI4ugYNfzKr8QXDqHGZgxzy79Bvr7aZsjY=
X-Gm-Gg: ASbGncsE6rVABi8wKL1rwlyJ0cKQbG8wdVhp7anqSu3rTVxxC7ZL1xNbIoFi2qcaju/
	5zHdvNAAxfRwd7QxTmuwuUqTqGyftKb6QM23+Ptiz1eP5cyUy6s//rh2N5UNs613G8mnU50YyR0
	dNRNuaDBgJhlr7O4e5cLMYAR75Z4aUfbA8/FRvYYzV9vK7Gv7BvMXhxd2GMAlFANPdbCZDZVaFo
	brO4zlp7K8nl9zltExgH6VXoQ6WTeTAHfhSimrb0xG432ae00AftSSeWu/pzaV2IuvEW/1/t5+o
	x4ED+h/bXrSM8GWY8AYSOpvACfw2T8+RN9sNy8B6DJSjoGnNkk7JSjbREURuv2bLAY59G4J1cQZ
	dICEyHo3Bx7nuJH4PhjyxmucqJBheMXopxvUta7plqVvJuYyysqu8
X-Received: by 2002:a05:620a:8326:b0:7e3:2cad:a101 with SMTP id af79cd13be357-7e62a0e49e2mr333553185a.16.1753277544206;
        Wed, 23 Jul 2025 06:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEydExjA33+4H64rlfK+rJ8J7FY2kUP7yS6AWx/bNwbVHySO1mJ19QUA1ra95IE7X5gFHrmMg==
X-Received: by 2002:a05:620a:8326:b0:7e3:2cad:a101 with SMTP id af79cd13be357-7e62a0e49e2mr333549885a.16.1753277543623;
        Wed, 23 Jul 2025 06:32:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91eb927sm19151641fa.90.2025.07.23.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:32:22 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:32:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] soc: qcom: ubwc: provide no-UBWC configuration
Message-ID: <bex5yk2trx4ko2ibg6oa4dm7rcud4wypznjsielf2rc6vogss3@m3rle4rp4c4v>
References: <20250723-ubwc-no-ubwc-v2-1-825e1ee54ba5@oss.qualcomm.com>
 <242d4174-d01d-4a65-a4a6-1f4d4e2d4fa7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <242d4174-d01d-4a65-a4a6-1f4d4e2d4fa7@oss.qualcomm.com>
X-Proofpoint-GUID: vGRJJUYLtuCVKCqz4tY9WJLCgwWGssIh
X-Proofpoint-ORIG-GUID: vGRJJUYLtuCVKCqz4tY9WJLCgwWGssIh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExNiBTYWx0ZWRfX5kwJuedfIQRV
 uIY572i0IdH2k0sIL91V0LRvgxo/nXFK66FECkpSa5FNkOnFLeZ+5/IURFseV1XMHtJELeSjrPQ
 IRMz55fGBd6S3uVbmakbgz66mdosznIScyE7DiPQD766Bco89E60qzq0CG9s6kRuz+9cjBXugtO
 GhfJCS4ZH2wEJdQeHt9s29qAoqbQ9sCdug4thqmGbx9Pr53osnHsXvrJCGP92qH8AMyctnEitkf
 rHnm1l9YHs9VZtO42CC8TrjSqX2O3df57WVyTLYfGqq4Oi0OaLvJDhpskeGMwjVL6825XmktMzr
 HG+vlg1SjwgmkeNE26zHMe+zNtEjBo9PGVt42Y4YShDQRgNVspdLnRRty/s2NI5/t3QpE9wkANQ
 Lkq7oxFg/6hb1t529Gn1yRvbVn4rdUCIez7hP2SUPVYWHV8tHTSdlK+lCpJ3CZxRdjT8u+4Q
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880e469 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=xD5xa0Ad2uggg-ClYCsA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=772
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230116

On Wed, Jul 23, 2025 at 03:26:51PM +0200, Konrad Dybcio wrote:
> On 7/23/25 3:23 PM, Dmitry Baryshkov wrote:
> > After the commit 45a2974157d2 ("drm/msm: Use the central UBWC config
> > database") the MDSS driver errors out if UBWC database didn't provide it
> > with the UBWC configuration. Make UBWC database return zero data for
> > MSM8916 / APQ8016, MSM8974 / APQ8074, MSM8226 and MSM8939.
> > 
> > Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

And I forgot to pick reviews for v1... I'll repost it with all R-B
tags...

> 
> Konrad

-- 
With best wishes
Dmitry

