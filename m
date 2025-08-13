Return-Path: <linux-kernel+bounces-767360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3AB2534B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102091B68A18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35C62C375E;
	Wed, 13 Aug 2025 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ENkavh0m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDC2EBBB8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110928; cv=none; b=FiEi8FbJ6E568ZHimZVfza8kdqYGEl3rm1sXQmvyhcKQOFsflcr0ISecl5P4rEPuxpzmEIGCgqmIjmhaPLVs8QdudbIkx7Y083XAQ7IHCNqFTJkP3/mTir+uBPEx4jEDhN+VFuP/CmX3aj4DRWYYUYZzgV4eMQx2buSqEaS2B2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110928; c=relaxed/simple;
	bh=3XlHQrrJ9pI6NtpfqVGWx14HfZDZKEzToBZSyzUBuvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5pvKYGENec4LNLrhgtnRcTLyYk5qqoVKM7yLA4Gk3BUbX1E1bkWmf8rUO8z9y0vWLs2aNCaEasNnkkowEgHJ5V+zuk+/CHVI/7WU60PFd9ISPo/ahY7Ul4BMmNF4Oh4ARMkgHmMxfneyRqitu3/gcD0cxw/np3Va3hN15WotMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ENkavh0m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBLdP3031942
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nzjG887+TpcpPmgncHFaqwjK
	5tO/uMDuLQd9TmbYrLA=; b=ENkavh0mabML7ff8x/WXpVF6Riy7+2enLJ8T1NJb
	f8uueFqvBSa01rTEoC0t7WxQjJ6Odt+KNaFJzAzxPlgkAWczkZOdmiNcMFeqdc7v
	8fb9kW5J5lR4XGmWrJ6/IOa936ttVF3KS6/zdSIY3djLlUZnQEBJR55gEDlp5y0U
	acTf9upXDmjmmYM6DksSt4GroChBSNB54XQwQXeXFAD2b7eEYYCax6yMjYffMj5S
	EyK6MhcMf6pPOveP/sp5L4MQBICW0/eGSB2OLNx38pq/tDAOcXLZ4Q1Qklf2hFUL
	Feadq950mZF2wA8vy3Bzt+jNQQcyWFSjOLxW9icf84fRFQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4gx3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:48:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109bc103bso4329851cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110925; x=1755715725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzjG887+TpcpPmgncHFaqwjK5tO/uMDuLQd9TmbYrLA=;
        b=vvlKFPTLNvMPZ6+q60eDp36geNspZDOlB9kljS86Qp7RTDToTJxz+pZodbWuuK7JII
         kdyjvrtz2hMcO4bWwgsjzNxD8yAkWbq0Rn9abfPzsX96brUDe/fpIyrYzkNdSpT/UzOd
         cQSgZNSuznpvlEXdfuYqspkrUU2HbJKodTUsssKOhiOGVGNDDAjgmKnZrZFyLRL8WA3I
         FI+NIk5c7AlKFPciIdOLwU55ZdW1yImlOj+TCobWYtQQS+nxDLeUxIinQq9ksEAv2mSm
         iLh1bLFn892rAqFMIkNnA6pWqtNVegbSV6YVzA/OyujwrlTm8BgnM1VrqURrr+lXbuRA
         0paA==
X-Forwarded-Encrypted: i=1; AJvYcCWutTYYEjyAW58PeLhnma1ldHERpLJAHZgBhmIE5sbeLDR3cco8WzFF6Qw+KEe+wW+TTSEHf1MErxLw860=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoP7vKJyaTlXk6PfRSJuCrgEROHtHVJKceb7XBXwdZmYr4Z+bp
	kpyrctmMiItMRe7Sj9Wo5LlJTNN/Q3Xg5tO6vDwnDN8O62It5C1jGhdhKjr6RXN69BR40wOzhKh
	ezQaa7bcWNkEbslj88JqRoDf63QyXOX+np24cq6jfj50FN76Hiq89MVrWhThQPeb+K1U=
X-Gm-Gg: ASbGncuK2j4x/ue7pQ5WIqCvAMnAfYBJ+ySwCYYlWmR9PnAd3Jliv7BYQxKrV9b+N0k
	BXwXvMv+q2UJFEY79pEsZ8y0BNQfRNIu4yFX1lxGCbTK4apU4CXfakHFFmcigTg0r35NOiw73BJ
	6lN4MttKhMUWxF4WriA3cA9iZ3F3XwXL+j5UyuD9CRmqdgYER6Trn9HyptOwKWtXRmAkTSn5vfB
	UgkV+doDmi8ycg0e0/kc3Y2D1rJKg63GHpXvc0+uroXBfI7qr2v2bpfBlVuoT+/uj+M3AJmtVNX
	qhHRpqCYjYT+pPW8K3aaGmeQ85mNFC68W5q+j8Wmlmz3OtNZetFLDbLvkVP6t5ORNGwfk08ltqA
	UYxctwK2jRRdFvAJGezErvuXRLyO7a2l+xAqa52Ad8x5Q5yVFoAIv
X-Received: by 2002:a05:622a:1f18:b0:4ab:4d30:564f with SMTP id d75a77b69052e-4b10ac25797mr3389731cf.47.1755110924661;
        Wed, 13 Aug 2025 11:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtZj7q2ie90roefmuQxk12/j/f20h198XGmN/KkyYOEK/ni5a3exApphv1+GAMIRNZyzAErQ==
X-Received: by 2002:a05:622a:1f18:b0:4ab:4d30:564f with SMTP id d75a77b69052e-4b10ac25797mr3389131cf.47.1755110923983;
        Wed, 13 Aug 2025 11:48:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cb9cdesm316421fa.6.2025.08.13.11.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:48:43 -0700 (PDT)
Date: Wed, 13 Aug 2025 21:48:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/dp: remove redundant check on ret and return
 statement
Message-ID: <l67rsnpd74uge4lz2tm4jbrwmn3acxt6cbrj5yasz3x26mt4su@2oqljbabkj2a>
References: <20250813151243.2055798-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813151243.2055798-1-colin.i.king@gmail.com>
X-Proofpoint-GUID: eI4bgT5AsLdqt15xrFSx6Kc0Vd6smlwL
X-Proofpoint-ORIG-GUID: eI4bgT5AsLdqt15xrFSx6Kc0Vd6smlwL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXxr1LJE7hnNnQ
 KUQcCU7m5Bss0eQ6SxUet0WheG0ioZbkowZCCTEMmLiL/8c1SvoEgcZjzmk/XDTfJMa0DpQZdm/
 ig37Ze+kDE31Kw/2rbMIG9qPzpusGFkT1w8TzddONFAC8lQpUSy2j+9hqPawcc3YuJOgE1ZD8Xw
 qNNLC3oK71SbCAm8PDkoxFrMxGdkVZY3KiEOwOHCdqh5mU4GGcuq7/S6SwUEZKpPLEvR7lBGuQp
 0UTEIB8sYtHOXQ80eN6Fo9yhlzDgx59P54W20QHV3TijEs4OwaTvFeoCi4anQhh2bokWVlQqGyg
 R/JI3sWiHjng23qgW3I+7cimjiAHFz7KprkV1I/7yx2gFwzXsz9PqTqg2UHY27+YtQ5Q3rzXnD6
 gP9yNMFe
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689cde0d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=HYx7VuEMISGMiPhQd08A:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On Wed, Aug 13, 2025 at 04:12:43PM +0100, Colin Ian King wrote:
> There is a redundant check on return and a return statement after
> a previous return statement from the call to drm_dp_dpcd_write_byte.
> These statements are redundant and can be removed. Remove the
> statements and the now unused variable ret.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

