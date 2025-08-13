Return-Path: <linux-kernel+bounces-766528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEAB247BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F30B177481
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554B2F6564;
	Wed, 13 Aug 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wry3IkpT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319892F5322
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082436; cv=none; b=S3qB7n+X1bURJ+A0N70fCH0EDKt7mssqHNzcT0pL1qnXdjlUbv5kK4T8KXAMSq4G3TH6fHeTyAQVAYvhEtu+tHHEOjq9+x0FRt13BOI0SAShQ3sGstIofqYfDkCkPBUgA2oc0nKd9zzydGT1XC09hCW4yTHOd81EWBuj14Wp1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082436; c=relaxed/simple;
	bh=f6bhPAzulpBZBm8eJyq3oHN2cBWm1w6sm+gYxZ6GADI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia9M+2jrUB5HZSaCWtn+W6YF6pl3OseuOWfbNcpCeVDDixQfI1rbYzFrfqCUHXoM/1wKAQvTbJgYslBEyhvXcaecVRy+fjW2Fy+a+KcZ4dlU0KpthvPslN4Mgmnpc+sEw5a374/at4opK0clmMW8ieUr6v4XpuUPgNZS4hnRAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wry3IkpT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mRF6030142
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nqjEsIPEIdyvYPIHu3yUYsmv
	aNWq7Oi2Q3FARabnu8Q=; b=Wry3IkpTmLqnFn5XCZAfTOZ4dxGvi/Bi7lu0m9ps
	UczuTeUESdL22YOVck+NxtW5pQbgJaYZT3iKiDgBN4AiYuDwqpj7f5N6LD4MT6Cm
	C8a62VFRHxX4RsXk2tFq14hsXuuT9zkmEC8lk1WjX7WV7G2TGcfaMyej5m1KYbtn
	CUiNbah/LtHsCJ6oqxf5+UJRbCPFu9R7bfh1tlkiVYUXoSX7Ws/2zGrAgIxA1v8E
	dVYSEf3jJQKVCYS9yccnlMLOBiYMi7djtEo8wqiXxUu4+BAmWRz1ikxdtMjUSccK
	WkjyO/axBAlQ0QiGyIKyPU+N6lOpb08BMpnI59MhXPy2Aw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gbfm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:53:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-709dda08151so19123376d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082433; x=1755687233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqjEsIPEIdyvYPIHu3yUYsmvaNWq7Oi2Q3FARabnu8Q=;
        b=gk180QJtol22LKQC4/ke1YDEaMNn7JG5RU/Thl25DDSgvIWx/Ccn7x9E6inSk+Q2nS
         eebC8sTsTkDFA9XWadYJd0IT5imLiN7/r00j/CHpYuPmyX3s73z4mNnAbalPRUWSyKhJ
         Kn0j7Z/1O2302buBPo1HZse2fw4BUZGSAor2ncpJBqyLwT+/P26qPvksh9CjPOTT1eXT
         vbF9O1J5mg4SLAYalFiHsrl+W6cWqb0DOIvwRZLv9trice3e/NdGDm9xB0KIXOPctRqJ
         mnzXFiBrKaje9aagaDdwP7TFlmWlTvhP532xJX0qTemqNSTry9oC2fbul9KEvt7nP27U
         ApSA==
X-Forwarded-Encrypted: i=1; AJvYcCU3eTMGdHeiWmElGM4lpAiOgo7KVpeGKonmrBV51wv2J2hf1+xHwP68Y7XIYUgXs1Zi41J8MbTY1uqcxJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EMu1W2mYMQHqCiSc7HH7F48FlGmYc7cXd364WSYIk8zo1pEI
	IXjWS6Afs7O7W6FiwgrVqF1T7B6kbh3bfQrfgI5QYDhcl/r9rKJiwrln4EJypDVX/KJBtazKwsO
	xXOBtktitWQ1bPORmH7Mslve1bRV5bduEgUPqOyiREXGhsSCqpjo/HMwsQfI0bIuYsQ8=
X-Gm-Gg: ASbGncs+Ps6mFqr5IwOEZOVlsWyBxiSkLjn3A/Rr5qYESQUx7Jsa3MUDqZrnGpUe8p/
	eG9V9oY/6L4BbM6AxDoxGygm3roVyQG/KO98QJjGiJj/UgrfAaSX2dAr3fYeEBs4h4HBmLCod8U
	vWal7nPK69yUgqkakQC4rg4THSuQPZ8lCgW1LJVlVD+qgvdxSj49xBS1xi1EF7RLRX/TYwgyBza
	Am6OVyaVe0G/g/4vb3bS3ziwN2Rwtr9Gn4MrdHnRH0FscyR6yS0Si+IzpcLe3YVvRem1aPVVVjf
	LZtvnrIOgpUlwY2PluAuz+zHPLP3ZD2Zk6mx5CENGVi0hXKze6pm4xNVZe7tCfqDn3AHGw==
X-Received: by 2002:a05:6214:2aa8:b0:707:4b47:9b72 with SMTP id 6a1803df08f44-709e8834e1dmr29971376d6.12.1755082432833;
        Wed, 13 Aug 2025 03:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH47b+mJ0uCpko6VXGUy7LfVcwVFUNwuMG6iAYYnK7TgjODRvBwuaRlczEPmStrUd3npamlaQ==
X-Received: by 2002:a05:6214:2aa8:b0:707:4b47:9b72 with SMTP id 6a1803df08f44-709e8834e1dmr29971036d6.12.1755082432198;
        Wed, 13 Aug 2025 03:53:52 -0700 (PDT)
Received: from trex (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16deeb9asm25383705e9.19.2025.08.13.03.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:53:51 -0700 (PDT)
From: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 13 Aug 2025 12:53:50 +0200
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Wangao Wang <quic_wangaow@quicinc.com>
Subject: Re: [PATCH v2 02/24] media: iris: Report unreleased PERSIST buffers
 on session close
Message-ID: <aJxuvm456i1PWOIM@trex>
References: <20250813-iris-video-encoder-v2-0-c725ff673078@quicinc.com>
 <20250813-iris-video-encoder-v2-2-c725ff673078@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-iris-video-encoder-v2-2-c725ff673078@quicinc.com>
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689c6ec2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=RE2RRPQ2WZmwf3aAuCMA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXxSgVSXH2kgL2
 OUQE9pqr0pgxQ/LUdZDKJrzfmgUz4Zb4enshs46VfoNdXhTeFXg/IB6T6HxcPRSw6+leA3uanbr
 TDt459vyJN6qbHcnAUsrP4WHGSdAx5bMYtX1M9t74K2P2iUbejBS7muxCfUT4hMSPvNqhyY3JFM
 OWWqwFZHVuiZ3tTM2J1C8a8R7KLWiUmgI9KcxTlQNWU5opsc3gz7oI98EwmFy+ajS2+LbLtFiEP
 rkyBo8HIEjKYiKtmG7kY6no8YDIdpCH/J8giKI4YH78DPcgwtglnrYjYOGWx54jg9NINWOXFFQ3
 FfM9bsAT9k+pDd8+HamR9Gobbt6qnWbTVqnvGywplupCRvciAN0RXfUPIwlMFDbwzXq2mUK48q1
 LCostQC3
X-Proofpoint-GUID: IaK7axpTRo3Rj2dW3RAodvuA3bF0sAXE
X-Proofpoint-ORIG-GUID: IaK7axpTRo3Rj2dW3RAodvuA3bF0sAXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

On 13/08/25 15:07:52, Dikshita Agarwal wrote:
> Add error reporting for unreleased PERSIST internal buffers in
> iris_check_num_queued_internal_buffers(). This ensures all buffer types
> are checked and logged if not freed during session close, helping to
> detect memory leaks and improve driver robustness. No change to buffer
> lifecycle or allocation logic.
> 
> Fixes: d2abb1ff5a3c ("media: iris: Verify internal buffer release on close")
> Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> Tested-by: Vikash Garodia <quic_vgarodia@quicinc.com> # X1E80100
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vidc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
> index 8285bdaf9466d4bea0f89a3b1943ed7d6c014b7d..96313856a026efaff40da97eaaa63e847172cd57 100644
> --- a/drivers/media/platform/qcom/iris/iris_vidc.c
> +++ b/drivers/media/platform/qcom/iris/iris_vidc.c
> @@ -247,6 +247,14 @@ static void iris_check_num_queued_internal_buffers(struct iris_inst *inst, u32 p
>  			dev_err(inst->core->dev, "%d buffer of type %d not released",
>  				count, internal_buf_type[i]);
>  	}
> +
> +	buffers = &inst->buffers[BUF_PERSIST];
> +
> +	count = 0;
> +	list_for_each_entry_safe(buf, next, &buffers->list, list)
> +		count++;

I believe at this point is not safe to dereference buf

> +	if (count)
> +		dev_err(inst->core->dev, "%d buffer of type %d not released", count, buf->type);
>  }
>  
>  int iris_close(struct file *filp)
> 
> -- 
> 2.34.1
> 
> 

