Return-Path: <linux-kernel+bounces-836954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33BDBAAF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C133177596
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE6214A8B;
	Tue, 30 Sep 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDqAC9vP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32620C461
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198474; cv=none; b=bMEGmklHoDq0VEpYmTjEW/GZ/aDqkR3GYOCoPFUc0eIXVVuqAh+LMvOa0AdiLRY5bxOQUJYOGNX0MbW45vkCuU9xalrP9xKC6mIjuCfoluEIgTM8MwmwAgLRzhwrrC0WWUye1+hChb07fiH55RCCezU+Xs0YsFRIpSZEo70JUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198474; c=relaxed/simple;
	bh=0ngWcEco0qDg9qk7bC4+kZtVSJ2EuBN9iRGJM8tgvLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6BiASajXRc37ITX4SlnwIV93Dj3P/7pkmNi5eLGI+eYkf6sceq06PkAX+hPQHCOolxdsEKwVZBy2dp69eTTxJH40jwIW+8I9qNY47g8kYwUhgbEJitJcLR5APeqUw6Iw8b9IcqyxmjtETHeAFGJ7Nu15THNYeVLcQJzT+P6R64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDqAC9vP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TIvNKq012767
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=67Xqvmd2uK3auGbMcyGYLT9E
	R5OLeu3AxM4ED8FfyfQ=; b=XDqAC9vPb0ZnrWQwWg+mjyZEHs3tTdrT3efg1oI2
	l8jX3Mrm4807UEADgFaeUO0g/pfhZDyrPGH5lBkt0IAoqT9uuLKbNZRUR17024iB
	YHSBquUnIIvHFVZzph/vsEEe6SUBW3KDRxQJbzDks/5TuOxUzlKpDitirYYPFC/p
	S7n7+mtRsyNy4MpHEtx2sFshuieQVfRj8Y/qECSWjR1nBUviCbx5XroCbkKN6nCV
	iR/KO2qut/Rl/j7GO0owgf9o1JGaX0U+S8bBwMBFbIaVZlWPdaBKIRvZSB40UROk
	NktQKVqyBNsQ4XHsjwc3KeyEBmjxcLEk3FqeEn8czVT9Hg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e977q383-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:14:32 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e002f413e4so26594071cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198471; x=1759803271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67Xqvmd2uK3auGbMcyGYLT9ER5OLeu3AxM4ED8FfyfQ=;
        b=Ej7YpfXcoZoC6OciaxAsH8bk9pcUDCB+reVP2ikh1RZRV9bsG6rfSIBQ4Jl8WmfidG
         9L1d9J2J2KZfn1uayjGnwm0wVhqVgcfCPfV9v/hnpwzHkAK/tuY98BWzlK1hm7saql0x
         6sFT9kUf18PvaQ1JUu8Qd0gsHBVNCpOUEwzXbHGqT7CuIMX/wL+MWrBausCAuDQ3LRkw
         C7h1zTXFSr9kslILuExkaSn/LAy9Xy1eb9WKpyz1ExDwSJqQAlmFJ5UtSQndjMA9KIUt
         hkdzkpGBZEdZeEfonYIwuxvGNzbShPQpVrj8MQ7Td+8RumDW+TLXcFXSQcyoq/n+CcL2
         yNOA==
X-Forwarded-Encrypted: i=1; AJvYcCUbDy8iWbEy4sITfujxZ+nyArUSJ0kCO5vNAFOPmGIOLvfwygL2pAxynJldD9rcXamavL7iZI/CRrp05MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfMuIyRe9n5VvTkLx7oWE3IFWjDbLmcQLd1MEaEugs8shwazh
	V8ZCxc0Mvx7v5ryJ8SdOZbY9mWR6VBRHwGLG+zLzzNe0cxQ5o6Q02wv0g51UMo01m1u52PYxWhS
	BNaQvKtOxYsELL6JwxUaNTTnysV9NPb8GwpWWURhVbcJ0YbM2i8wycOUG8Kg7bLychAc=
X-Gm-Gg: ASbGnctM6QwwuVkuMbqy4rkuzfBtgBxnqliNNBk5qozPo9lhptIP3PoUESwRrB6d7lA
	WPxYlqkqwEk0P2CMJpIIoYqZ0/skU+qxT2AISzlDn9qjGdjHsYYImg5/297P/NHNq0tymNXeU7e
	Fqjnq1PqKP+aUXpsQ2IGNdgUJZW+kR16YT1oqXxHu+qAHmnDArTmZWScMZVNLD4WlBazE1/ayrc
	z5D1K4RmsO3sCrP2Ci+aDwzowhODpB0fUHDVx9fcekh1v8qRrYDWdTlitwa6G3uIGbiB0VWPV0K
	o0pR10Y3+2L+fLJU8mfQdJdvnIwYrvF5RjO/xEp4fd/0ylJ7R29AbGBcs4cnxS6sh6bw3kWgMLO
	kFFv9PR40/OghaasMG1M/1+90OhTk32VpP/CyYh7zu1NaOTW85tuF2D+Anw==
X-Received: by 2002:ac8:640f:0:b0:4de:3960:948e with SMTP id d75a77b69052e-4de39609bb1mr134148071cf.32.1759198470885;
        Mon, 29 Sep 2025 19:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoZE271MUjmzTd9Ph7H9oimXFoXuH9FPUmIkhkdYnBZBqrJ5NhepXLT0DpKosAl+lJBDbZHA==
X-Received: by 2002:ac8:640f:0:b0:4de:3960:948e with SMTP id d75a77b69052e-4de39609bb1mr134147871cf.32.1759198470283;
        Mon, 29 Sep 2025 19:14:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-586b0c1fc85sm1897636e87.64.2025.09.29.19.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:14:28 -0700 (PDT)
Date: Tue, 30 Sep 2025 05:14:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: socinfo: arrange the socinfo_image_names
 array in alphabetical order
Message-ID: <hb3ia7ltrr3qeqqj26xm4zfsbkc3wc77juzstisgultcdelray@fzc5p42xeqnb>
References: <20250929-image_crm-v1-0-e06530c42357@oss.qualcomm.com>
 <20250929-image_crm-v1-1-e06530c42357@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-image_crm-v1-1-e06530c42357@oss.qualcomm.com>
X-Proofpoint-GUID: nHN51EMM_Z_B12xDD7Jkf3aNdxHaiJsZ
X-Proofpoint-ORIG-GUID: nHN51EMM_Z_B12xDD7Jkf3aNdxHaiJsZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfXwEC4svw4r9j/
 a/0QX3op1mM2wJq8JPOuGPVl+kZRMs/S8SWXEgNhWDESHMjftVW/dZ5IAM5FUXb2CPSnw+1hrmD
 HXvPbPzo0rBESuQWSe4Y8kngqs8uvzeGjomYaCY3/BOLmDe9kfQ2nvhbUfopktE66AWoLoB6swS
 0NAnXuyR4t8w7TSL0Etj4YGWIeuTJefooGmjihTydWVf5gxyKVm5J5XbKWgj8dEvuhBrNth9JEq
 87M3Lom6lp6WEs4yBMCPU+Of5AjVqUFt3ah/sOH3l+Qs55G09/IvnqNfBqYFz25maqbDAtmeeQl
 Znvq89TBb4auBdlu0maWZl2p9qWkIUWm7CYtixhfXYuu1Q7jSgN2WoZcRLsRdlYFI5wjqHxvWB4
 ER/5QlODnxEBoyse+gd5xkON7zb5IQ==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68db3d08 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pb4uCXql-ON9smFTI5wA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On Mon, Sep 29, 2025 at 07:47:07PM +0530, Kathiravan Thirumoorthy wrote:
> The socinfo_image_names array is currently neither arranged alphabetically
> nor by image index values, making it harder to maintain. Reorder the array
> alphabetically to improve readability and simplify the addition of new
> entries.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/socinfo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

