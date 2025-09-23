Return-Path: <linux-kernel+bounces-829758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B48BAB97C08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9009A7A48B0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D623226863;
	Tue, 23 Sep 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYjD5ssd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4A63CB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758667718; cv=none; b=bPQtHu479cr3w+O9fViHJ1EXHGwAhXv2uMmJoHyAwI+4TvJ3V+nRFpf4t9YgtN6toyaoobeSzj0fwMdqAdSH6/L7FsJKyJFm1PDiEMT806/v1RTqKWQvwWjW1NDaJKH4YteyXYsSXP062o/qktQYiypbB8BmirQ8emJt3wi6wu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758667718; c=relaxed/simple;
	bh=KGYrdccxkJWz/NWcgi56AxtyIRez9CZ3n9EqSfyRTOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkpbmCHr5PxsCTdLNV7y7LnQx2A4VWMzbPMTaNPkChj75DOEfyde9FEpN7kobgniE5nmWEKcaUSaz5bc4w6Wcd6MND5KU12ckO8WzXNb6PzZrePi6nEBte0LbxVoavfmcnE/28T1PZZaGImmSCdwfddg02jDIG8Gz1jpdsFovgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XYjD5ssd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NFOWBC021317
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhTBs1uXxvVAGkh+Pb8xn+0DsTafgd8f9wM86mvWR0I=; b=XYjD5ssd2TIZMs4b
	KJOVFYCkUg9kb3Bser3VbMMsZsiZBfeTldoEOW3KslMmAg3wLdGmKJaY3J3wHiFG
	kdwytUulDNRhT9w0XqMg24YNnDTurVfRT1P1iyJqlwcsh1j9H/x/ehQLcklcWqjE
	YgYQY7SaBFWUHA0A53LGf0WhJXuZWiRZTIlhT8QmN/i3W7HMmYIo0VWTmfHz1Uv8
	pL6ttTnsUjcfRh9E9k9A7D0eE434QUlReDVv/l1AfenvIyQL9cMpvibRSy+U2wlU
	BSbd9EHSK/5LNTQrI6AtQQJOpvhRjnQPXjwaCphxq/ZhzQteZYZ32aKCqczu29dV
	d13xlA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjuk9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:48:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244581ce13aso106008875ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758667715; x=1759272515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhTBs1uXxvVAGkh+Pb8xn+0DsTafgd8f9wM86mvWR0I=;
        b=c1pPkLGT+gCtTZc5ALrSQ95kYFzTROtqAnBVhmLzbx4lhX4hXDHD3RaVLM1krj1vKi
         gkYQ+0u+GA/upj75UJSidM6KyywoBFSo2/9uWK4ATs1qaM4P+W8SzXTPrFtxWywxN/q/
         HJ40VZ9SNBd7m1/4q1QRT2IcYAvSBlFdI87CXZgb2o/OVzox6dU7nFeBR8ZB0GJXO4vP
         eJ1yxfVBZ9CETwFfVERNKiuLgvT5oTXA4r9mk26QRfFPZKwR/cuDo/vtKCTvHv5XGB/E
         2hwe/pqjEXyqGbQxSCtRBQFvLU9VYRu0VVwdKHWr/KR8y/55QJBWxHDLL3e0YpDzA4uI
         6CUA==
X-Forwarded-Encrypted: i=1; AJvYcCUxqDN8L0ZcXU7DEHE1IUk+8J9HoY0M62Ai5ZdtiFq+I9xuy8GeF1IjJCgqTomQOFtJfcJi9Xsf1xsXX80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyB+5nrat+BPYrqZBFNpYLS91ge7zshGhv5nNL3gQdcg3czdm
	Ss8EqSJXbQQmv7AYTyPE2KGxonRjy2egS/2ShKQkEv/1UQqmhJsOo08mM/+It8mdsBB8znbBf1F
	78RuzN7M/J6kK7D+3St2KM8nRREbUZrbZPErNgVZ9VQzJuAKmfJwruAf0z7lpI1ARXw==
X-Gm-Gg: ASbGncsa5lPu3WnDR0MUJpgyqWg/xDlMVFnjH7odQBairJQyCGLash3WzMaGhJ7Cw65
	S4PKDKT4Ke9IkVD6xXsGylz2D0JzqtYjGu7aRyz6ChOcv0lRrVt4zgmNIcC5kY9/eTydDeL1ow+
	OfGCWMl61jI9L73Vtsj2+NnBhpTMWaO/Vh2SqJ2oFBQoHNHEZU/fMA3p4oMcrI2/0E0NJ3oFRB/
	9+TmA88QqE4M9xT+F9wZQ5WZ8ibBdnpdIK5yhQ8jMRcOaMclfdbQRCLystcJzFUOEJ1fGtkKNWv
	USbGGmfCMGMGWWxhf0Ab1jPnh0RtHrrfTFeezFZ6Zh6b3/I8Kf901uHwuJdWEmS06F78nTar+P/
	vYImL8u/oMskL5X2WB1FvMBwvpBuJ8S7bWCUkiQ==
X-Received: by 2002:a17:903:32d1:b0:267:e097:7a9c with SMTP id d9443c01a7336-27cc92d6390mr39514805ad.53.1758667715277;
        Tue, 23 Sep 2025 15:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOe5Xvqff3pEzpF3RusBgGn/eeG6J9jfCttvo4aiBAfj9fCkj86Q7V5Xt8WKarN6JKSQIm7A==
X-Received: by 2002:a17:903:32d1:b0:267:e097:7a9c with SMTP id d9443c01a7336-27cc92d6390mr39514695ad.53.1758667714901;
        Tue, 23 Sep 2025 15:48:34 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c265sm171438685ad.49.2025.09.23.15.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 15:48:34 -0700 (PDT)
Message-ID: <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 08:48:29 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <aMvV4kK386Sni10i@stanley.mountain>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <aMvV4kK386Sni10i@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: G88LO0nqt3p2YTGBlKuJpjjURWPoABZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX7VJLSxVSYMAt
 CeT8dU9yr+LuzxHrD8cNhHV2VoZ147mc4u8I9clAKsC23zu7/NqnFMVRGyOAo+fDNxh3jIZJ3tu
 +AVnjR0ZYhcI21Vz3v43DZfslZ6LBedmZajsbxy1DpbstVotr2PYlUzsGAJCmXuFVb9Pbclu7b1
 54pmxOSd1xDtdc09b3sZEFa39hLPiwyV3p22MkpS6ddSIxnTGizOGpAfC/QlnczkyRYH4HvjkwE
 PGA1bFAh9lIWBk5+lmemPtBEZPqUG5VNBIYFY9w23qGB84p7S+uz4iB/4HSCAgaX+xgL7SwPsOY
 OuE0l6KWLUi0PDemmh65sUKCaxy0r5E1gi4A8hZbvbPcN8wpWFYuGp+CeqWMAAmXvKd+m57cjHG
 ge//XVqp
X-Proofpoint-GUID: G88LO0nqt3p2YTGBlKuJpjjURWPoABZf
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d323c4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=ok0EKaH7qlBqcbMr71AA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_07,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> Re-order these checks to check if "i" is a valid array index before using
> it.  This prevents a potential off by one read access.
> 
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/tee/qcomtee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index cc17a48d0ab7..ac134452cc9c 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  	}
>  
>  	/* Release any IO and OO objects not processed. */
> -	for (; u[i].type && i < num_params; i++) {
> +	for (; i < num_params && u[i].type; i++) {
>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
>  			qcomtee_object_put(u[i].o);

This is not required, considering the sequence of clean up, this
would never happen. `i` at least have been accessed once in the
switch above.

Regards,
Amir



