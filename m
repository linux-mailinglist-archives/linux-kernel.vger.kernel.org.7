Return-Path: <linux-kernel+bounces-836955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1EABAAF75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4F2189D459
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1F139D1B;
	Tue, 30 Sep 2025 02:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XaYFPWr9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AE1922FD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198527; cv=none; b=am7MKKxbuk+IvFhtWp29gCNpzSjQYhloiHeHSLkj3+chONzPLBf9dMrVp5+b/MQ6l6gWyZ1MiKTJxn7FocCqpKoiQawpHxR6Hbq/2ytcPSgRiCTWMfzMsu/eW3nKReF9ZB4zaB63bOPCLBA3bKI4UsDzEphUKYHZYVz+zgewObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198527; c=relaxed/simple;
	bh=qBkG6ckxOci/hIOZWn6tAh1jWLY0asoIoWhy9QpKN+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFRiFgneQwWQET4q1WX215LFAjw3290aj+LFHLCIC4jSO/GQpJzlN8CVgtm8Ab4eqURB0tSKQPqKbA1tyksjyfFTnZVawL4lV/+WU8josru4X3vk5zRRS7ND3qcn0d1SYX+I5YVk14A6lx/Ig/GZ1GUmaTwifRi9Aet/OTJajCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XaYFPWr9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58TH0Xi2029091
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=gz7NaVudtMDklwInvi7ETIcP
	dgIB3//c9/yNugVqZ8w=; b=XaYFPWr9M/E5StoOWhqpya47ECY3sWOey70kBhi9
	3jyxSrou/g566aojN76VzfXp1J52LNN0WVTiDfL7K2LvKmaV7rvnPvo1CZHxP8vA
	vBlPh/+wMeK4xN+cC/P3Ne9Esfjc9eW52nYC/4e5HUzWENjUm0Oj3ArZlQZEJh52
	elZk1NTOXPjRVZXEOXGdsB8AJ4u1df/BQA9USqOVxIVZ2+US2WV49a0HALCKZ/HD
	DOL6C+KH9EfsamxF+7qe+4fsWsKEjIj+eHvA//uXLujPNwmHsE2yfubwP3dx1GZH
	ffxLVhK0sNeFr5M/WhKn1o0tl8xWcWyD5IDCiHrC1QzQAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr2sx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:15:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de4fb840abso99089301cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198524; x=1759803324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz7NaVudtMDklwInvi7ETIcPdgIB3//c9/yNugVqZ8w=;
        b=JFQyNGbVvy4PxlIzTF+dr5akw3MJfTAs6VQ1HYREunT0ssCWxv07tKTJpKxVfYeBif
         1TSogiWw9hBIw/5Qi6hr2EUJHO20gEpnn4A+AenZJZc8snBVTYsO/TOEnCBnXZjRHKyu
         HpIvf5daf2L2VfdBt84eIUGVLmCVxwEE1oSreYfhgq+XNlUirujrnBBdt75CnQtya6kD
         QOxRK8Tffee3wOhmPzayutEeUZ5CuqJv+FqAxDt6pj/ENQDjde8ZBuc06WHlPGCaWELE
         GDMlMLJTXeNHymQyb+6vKsZl7scfWvcQv7/WuuHH3D2apTM+enqS+i96JGXK1htcxLv6
         CiZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8vAt+v05qWiRwLYCO7nnY6pkWMhAFlcK8Za433A1svSFIDl9SExryOoy9Sy0g7mhsVXjSvn2/3uXsANI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxc/5uxDWg81jWlAR7o6HUYCImKbTlLREXWRTGs9GYPj+PgaA4
	SjQXdP5e8bqvIEGjWc5kq4ptroSTYfJcvjX/aNFK43ah+lzH2LbDBnb1MHkSJP5NpVK6JN1RR9E
	UqGrj5IP3WHAskw/v6NOsA5k+NeO7TtERqIMEqoGv5Lr/vUXJkfzm6VesB+sq9l9Hw8A=
X-Gm-Gg: ASbGncsDMgY1EHl/3OF62CePNJL1EH7xKfnLZDfNoHUOjuiKPVtwo54hnx42SG7q5IH
	jM5bSVkDuknFDtYCjsNhJKILYRZeh1nm6kThCN23O79/HESI+cku1eV+ZNz/SAhFYusDP+xRcXO
	8fkkoxRv+77B6naEPGufzwHpTDqnrh1pBPQHPwS85SilNgdbu3l+VL3Q8iw0HL0LIfVc9dpp1u4
	Qs5JR0qk7Eo8fv+Ba3gG/2b4QjY1U6JHM8m7O3pmuSbrzxV4r4azgIMiIMCi2k+UZLMIAaRLhNv
	IP+byZJMFTonzCNF1553MuTJqfzBFQGBOLqOr2do2OWLM90wlOCGmHPpQLecPXRyjxFx4JO1kkF
	OTrCWKDhlnrk6m/TV1EqmSq9j4SWfrFZJplZoMZhCJZ8GT9yFabet
X-Received: by 2002:ac8:584a:0:b0:4af:36a:a60f with SMTP id d75a77b69052e-4e27f522f0amr32702861cf.21.1759198524299;
        Mon, 29 Sep 2025 19:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOxwWPpdXhUS0uiS2rRW4eHSCbvpnCIgFb8RnY0ImFf0SIFROCmO1BB7ICBoXC52mxtQW4JQ==
X-Received: by 2002:ac8:584a:0:b0:4af:36a:a60f with SMTP id d75a77b69052e-4e27f522f0amr32702781cf.21.1759198523805;
        Mon, 29 Sep 2025 19:15:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5879e9b81d7sm1369890e87.128.2025.09.29.19.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:15:22 -0700 (PDT)
Date: Tue, 30 Sep 2025 05:15:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: socinfo: add the missing entries to the
 smem image table
Message-ID: <nx7xossx3d3lz6ybon3nju46ivfjcsc5bpvfkdygtgdjb5qqhl@ygvdtkqjozeu>
References: <20250929-image_crm-v1-0-e06530c42357@oss.qualcomm.com>
 <20250929-image_crm-v1-2-e06530c42357@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-image_crm-v1-2-e06530c42357@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfX5dNjq1XTetuf
 4fhQks/g4NQ56iPTk7gu1f1bl3pPKWLP2oYeh0T6JcvROTLB6yDoqbO1CJU5SZob1nnr5tFuMRO
 dZXmqUpMYdvfC2+fCjiNlSXPzWniDp2a10iMD3QzqOlOucUcMPctgFageZ0JBfaEeIzFTp+mPA/
 9+a9j1ZAksYK6aknepR6RJqoqYHnzYfT7w2U2xDZM/xuPvs3QoT34kKf0Rc/jVLA9Puufh/6sib
 BXFufu6Vv7lVFl9yTeFUUQ8AfeWtNFpulpytkcfZ8K026GfBGT283szs5mBhdEeb3Q37s1nr6Zf
 4147Bt4WFXtF6Ojmz195cXHyQO+Ah5JNBFqgMAm3lOnT3K0hKnJXFyCAeH5xrbTU0Ywxy+OoC3h
 SNusz+HidtMrD/Ge9GJY6wnYv8xcKQ==
X-Proofpoint-ORIG-GUID: JpGEmQrjTD9j_DzYNlQy8rsDYa5OOgY9
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68db3d3d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_J3-MF0YoXTFZmabDV0A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: JpGEmQrjTD9j_DzYNlQy8rsDYa5OOgY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

On Mon, Sep 29, 2025 at 07:47:08PM +0530, Kathiravan Thirumoorthy wrote:
> Add the missing entries to the SMEM image table to ensure completeness,
> rather than adding support for one image at a time.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/socinfo.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

