Return-Path: <linux-kernel+bounces-798497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A0B41ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78339179476
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0C2EC08C;
	Wed,  3 Sep 2025 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jtu/IL2K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E02EAB93
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756902162; cv=none; b=tfz+OVBr4KSM5gRted7Aq9F24pt3vmmmIPbvF9J2mg4xxogHTBi96x3U5xxmJZ6/huF3TfuDoJ8w96V5BmyMQcDXqmFamkbWgcE1L2wL5RIgi3SooI7sLg1egZb52L+4JCmXpCrWA95V1MwhGp5zSpGZZmQcIrwhhW0iFHm0q38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756902162; c=relaxed/simple;
	bh=q2Zj0cl8lYA5N8WZHyQQlQ3Qp6xdIaxhynORgU8nFAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBZCNeLHy9CkZz+7NjckNPXdBKrHup274lOKR6FLRZgZ657WYdFbqGYjBuRRxJgIBRQBfrxHn3S6i9nUdoFFymoZ9W1z2D6gxt8kwkjziT6ufd9pZtY7kiViYOxas4H9/+F3O8xZMRmT2+/mc7eL1IYecHHkqUSagaHzVGbLTW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jtu/IL2K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEvlJ000723
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 12:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SKm1bfgXnDxPg9BzYUZi1YNq
	zOZXroVzr/NmpGjdi08=; b=Jtu/IL2KrkSx5TMbE/DFsgGnqMMy/E5AyajJJcOq
	FgX85h5Z/97+9giWQ9I7TucpxGr5mLQ61iWXqI+4+fHA1K7trWyYasLYxyTMhiga
	a9ADihQ1KpB9uBMeaMrg5i74/I2azN7Kf6cjB3phA3ilyxM1evqaTFCZFkDFyfJb
	9gyFIWLdbK0vnUv1fofqKb9ajWWSzeuNeDlCmuwHkbZlyU9X5SMQPtioi8YO+8Mb
	hzYO81HZ3T03DLXbWPfVPVADRj+tyNzYaNrK6nbFFGDQb1gRU1Vro/019bSMTsrJ
	sOIF9wmALbb//lS1iMQQ7TazP7pwxKv9Cy36XsgRJpod/Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush33fq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:22:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b32a58c3f9so78568731cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 05:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756902158; x=1757506958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKm1bfgXnDxPg9BzYUZi1YNqzOZXroVzr/NmpGjdi08=;
        b=eB/GoRF9qs2ESYSNAjIWu9yJTbF1aB+USXQyC/dcJPd50oJfYjmv98R5j4W2WESUvQ
         vn2EEiKOeS9gjqwv4bbPuU2MPYKNxXDIWLBPmHjngYx845cOua4we80XpP+1R3XQO5pQ
         86Oe1TvmETsgfjB1kM+fDrhgurWPuVhPn516bA4KGpdenh+m0+se0yR50KhF2Bes68DI
         KdA7WmkLpBx/AYo/f6LHFxw3k4KZTy0vIJWOKolaOLRxu/T/be45PQf5dyo7IOIHzB2Y
         Go0iDRCc0Ja2G2us4MDI/ysyIkNmTL81zVXbQwy1Vt8i4T4cmp8qxQAFBP8K8Z/Xhwjs
         srvg==
X-Forwarded-Encrypted: i=1; AJvYcCVi4qjNG3ZXQ/di4w0SUnKDwvaM8TtCE9AZv3tRDZ3+3jJvJP/ryWnXdsKWI/UVWie1YySdcG9Hj8Rt6CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRBdDdALG3/bYtyOYeWGQhonmvKu6OvSqxHf7UK0sRzL5fxvk
	X3tljY1ppkbGYSuFeSRwV9oTpMQwgE1iJW8iQ+OxAtXkDogSOYrwEDOMlwMWotxIgBX4cM6VNek
	5m72ZwU3HSlKLdIIuSv4mtPh2yKH811uh4HmxrR0iLTeAKINnt4m64crwUnXuuZ3Svik=
X-Gm-Gg: ASbGncv6w4KkLzj6nWBJa4QHUJ/IX7bEGW1OR7Rk6w5X95FdkNrIr+rbfZGr6SXDzZC
	GTH9D9EBJvMpRL+UaVgZZaGGHZCOJWKVTxvVQAeM5kX0Zh/klFoJdOrmwtvTlz60s2xqRgWeotr
	VWV8oyxpNv+3z4/T+jPldes4xNNNdxZkXJGEboc1FsQLZboxIKWJhsv6w1JlGk0jpe1oYH82+Hz
	HAIoa5wgW9fyE80ptQSBslnUvPsJDeDsa96cSnP/dB5yHe6zuv7vG8vKfWM9Pkf+esdWs22blfd
	N6Yf3XC/ZtXsByYD/F4pCYfLbP/y8PnSZD+inEaHQHcp9fFqLPFx6FyWPVXtgMcJpdGWGN0lI0R
	ZhPzCmIp+vguPRbvOnBZYPM1gbSf6lQbsO4FRrwxhB6vynR+GUKCd
X-Received: by 2002:a05:622a:5146:b0:4b3:4e8e:9e4a with SMTP id d75a77b69052e-4b34e8ea939mr65237581cf.56.1756902158487;
        Wed, 03 Sep 2025 05:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2FoqT0z4zyASuUjUeIGy8E5KMANVV7KhtQlJY8p5efCPL8u0tAS3LoPMY6FjYaebAlTSVcA==
X-Received: by 2002:a05:622a:5146:b0:4b3:4e8e:9e4a with SMTP id d75a77b69052e-4b34e8ea939mr65237251cf.56.1756902158009;
        Wed, 03 Sep 2025 05:22:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfaae4sm495216e87.99.2025.09.03.05.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:22:37 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:22:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rajendra.nayak@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
Message-ID: <hxwrmoyik5bzgtxufw2trjwz5oqn7jut5wsej4v5xqdk5ho6hi@jic2xbti5jn6>
References: <20250813065533.3959018-1-pankaj.patil@oss.qualcomm.com>
 <20250813065533.3959018-2-pankaj.patil@oss.qualcomm.com>
 <bdfb09a2-0053-4a07-85d6-5e15b8bc126a@kernel.org>
 <d35s5ldfswavajxkj7cg3erd75s2pcyv725iblyfya4mk4ds4g@hekhirg4fz65>
 <bbf60240-4d84-47fc-ae35-483e55968643@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbf60240-4d84-47fc-ae35-483e55968643@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3R3wsHBHjUnv
 44g8kPXGizYmmKzN0wKc9qUq1v6sDBMcmLllQml+iCkmKguP3SGvBdJz6PifzsLfjvs8VenALKH
 cH+UIG29DVHAbxUhWgeDsuJPWxBcr4qlpxQRZa8OtZz+d0tho/GTXb8OWQN2OSwhg2umT7SEDFr
 0eEFdEfeYPU/EFlD9igKPrUvB+tt95lSNEnNSYB6/8wPno6aqjmTlACqG26soderCLtpP3TjRwS
 8Yfcpu76djZEgeXNHVNpiDMRQ0MAoP9c7X9x188JmLdWa6KVEHyPVHFybaG3+9Ntho39+R8g/K1
 sEvPtsnd9INrVTSjywls2v2Tv7KNZlAuyTy1ZIyykUqq3YegWZ3aRIt4nGJaXIBO+4r+4SblLvw
 0oWVOR4E
X-Proofpoint-ORIG-GUID: 7DMhlY7H17a5EX5LnuxIC6fDSoUxH7WU
X-Proofpoint-GUID: 7DMhlY7H17a5EX5LnuxIC6fDSoUxH7WU
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b83310 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=9UiGzq1QuJPVDsM1CnsA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Sep 03, 2025 at 01:28:43PM +0200, Krzysztof Kozlowski wrote:
> On 03/09/2025 13:01, Dmitry Baryshkov wrote:
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +
> >>> +  gpio-reserved-ranges:
> >>> +    minItems: 1
> >>> +    maxItems: 119
> >>
> >> 124, I guess
> 
> ...
> 
> >>> +    properties:
> >>> +      pins:
> >>> +        description:
> >>> +          List of gpio pins affected by the properties specified in this
> >>> +          subnode.
> >>> +        items:
> >>> +          oneOf:
> >>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9])$"
> > 
> > If it's up to 124, then this pattern is incorrect.
> 
> So 125.

I think so

-- 
With best wishes
Dmitry

