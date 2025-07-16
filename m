Return-Path: <linux-kernel+bounces-733796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642CB0793D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DEA189BA97
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE926E6E3;
	Wed, 16 Jul 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RR+mmuEQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C262641F9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678347; cv=none; b=oxOHFoPAwWw5CbjX3LAp04lp88t0sTd8tutUcaHZC7+omHCWcHBTQJr1sKPrKgdVwJcb3+zUK2r7oWRq3KZfVvDiQXLi9sjTjg0X2gSXCuJhqyOazByMXtXsDDMeF/0Yn1ucCyrz4+2G+PE1ajX69eq6+dbmDq4HF+lyV4OqO64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678347; c=relaxed/simple;
	bh=95w6sP0+FjuUfliHxwFbWeg38I0fErD/c2V5092cCqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4/aYmxwnBhtadr5vGbhLGJaPGXiUbOpwTLfUhiBVFoE+nZNAjI2s/XjQOJBvFID7ky8KlnzKO4ac5T7TTtEziZff/JmrC7Z38Uwo5SCJLVWBHsGbE+mHK58eAVfZWJ4yLE4rNxu1QsUHxYiFoeSsbV17p6PlwqvVcrFOasALb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RR+mmuEQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GE9KKK029579
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c0YU6WYevdund5tkdGQl5yQ7
	OWFC47cHfSxZE2himRo=; b=RR+mmuEQzniwxLrkWdZWkEJngba+lUUiGn3haPIV
	vTIneCiat6EpBqaSeP4lljKwLY5vu1KLVq1akKgQNUcEnwXzKYSl9zBuVSuwYRzl
	WkOzIxlmjuO8otdIcWnFY9AQbLle9+g/+hhHQtC3zRMCr6Mu508qIbTBhdtRw7gh
	kT+LfEuoI4DHvSHIipdtHRLTuH8+emmgxKu8d0fwk70NZiTRQEyfnFwFuUboC+ag
	4ZwL3G4zompsNNXIL1ehq+uHxO6t1RH3fr4ee5wqvkAXmXke8t2qinDPQs5m/ih0
	U40ReDZ/wRvWrh2ZPW0baojWecqJHaY17YlVOJnV31K1Mw==
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb4ehu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:05:44 +0000 (GMT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3df2e89fc8aso59475505ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678344; x=1753283144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0YU6WYevdund5tkdGQl5yQ7OWFC47cHfSxZE2himRo=;
        b=uonQVWx61Likd8VFGRd8DWFfFHv6rHTlGe2I/OWFeXFQIEXPGrP11QrEx1YzWzGo4m
         vcJUFTdbNtaZdcyQhvC+meWEIu4XZweNsMG6zwxNeeBp2OzFw7LoWIGlHoZlMd5OLvIF
         CGFoKN2bX2Y2aMDfzVEUzF8JN0PsgqRvR+1Pkg0htsqXHiWRgqWNu+/E2KSTcHD2l6dN
         2vpuDzuvRUd2O9CDGZV0lY27xO8ka1NsS85PsoLnQad+L/6D+DRrK1GA+D7C9peXxKD1
         TScqvNWb8Pz65G15s6G/XQQ6is1a4swaubk7SNv8BtmGHZabxYtrq/NxK6fYhpFoQBLi
         T2JA==
X-Forwarded-Encrypted: i=1; AJvYcCXKfEbTwNXQMIu2XLY8jtWIOj1xdmYyjR2ng+8iyCNTjn+H8od1b9vimfdaEWSySNc01QNZM5UIMYOgo7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8RdxuW4l69A3da+XVY5KdinblPF6IlJgT34FsI3FWCK6CwZNp
	TFsNNFYZXB6bFQS91e7Q6z7wbKaJ9SZbflJaFeEEIoXbTTbHsOzC6FZf5CwMH9Jznq9IzZfXFJq
	X0jxftJQZBU2RJQ1NeexHlZ93Icd1EPCdrfx3oE37WgeGt+zxH8Elk+2AMrqMf9wQ2PM=
X-Gm-Gg: ASbGncvvO34kpRIle+i5FNyhEMsE6/orOuq84jdfVbH9j9dGBDEwYSdv/P+xFvLicBq
	ehCPbZYnSqMwRMPMsEH5ZIO+yhnJCJJTng2/CxTrIjl9Jvu0qftmE/aU2wEy6LMxTzSmbOQPIVl
	B8V2VxTZ2WtyX310CejGR2uvBqAkXvWvQLqEB8gF83QgUDV8ZjeEkuIAfDYlxUNFTCB8NwGyR7J
	FYfgN2R0VVsUFAelMXyVDONxbHuJZOLmSFKfGzXbY4EZyXBun+ywatj4ZZgkG/XNDnBSXApXMTe
	RLAhW1sFIZXEHuOBZMsoFokcNbe7bGypv3flm3fnaLR4pnSwhTN3/K8bz8wkVaWNkbdI8ZikScb
	Ih/dlcLQQkDWB+woN6RZUwrekqP+fHyb6ugnebVO0t8jIF12pfnUZ
X-Received: by 2002:a05:6e02:2687:b0:3dc:8423:5440 with SMTP id e9e14a558f8ab-3e2821f490amr29394295ab.0.1752678343425;
        Wed, 16 Jul 2025 08:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiQxVLfGJyjdQolHfpUghz4La4xIzw45yLU/Cq1KVO6NC9WigSlhiSYSteODSSlYkMMHWrdQ==
X-Received: by 2002:a05:6e02:2687:b0:3dc:8423:5440 with SMTP id e9e14a558f8ab-3e2821f490amr29393835ab.0.1752678342895;
        Wed, 16 Jul 2025 08:05:42 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b60f14sm2710525e87.155.2025.07.16.08.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:05:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:05:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ling Xu <quic_lxu5@quicinc.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v9 4/5] misc: fastrpc: Cleanup the domain names
Message-ID: <vvojztwx4bus6tpgcj5s2uzy6pfrmoj6msdjmh2kq3ym57e7pz@nxnob4fffyzk>
References: <20250716132836.1008119-1-quic_lxu5@quicinc.com>
 <20250716132836.1008119-5-quic_lxu5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716132836.1008119-5-quic_lxu5@quicinc.com>
X-Proofpoint-GUID: 8DTSF-apiRh90Hpl_ejBMDF3UA4jENbi
X-Proofpoint-ORIG-GUID: 8DTSF-apiRh90Hpl_ejBMDF3UA4jENbi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNiBTYWx0ZWRfX1mZU/2jZP+qR
 OotvisBSW37KHIGBUtg1X8WlWXEKKPlNmCmzgfcIr1FlksIiaozQYf5ZN90FhfMtdeRJStaLk8F
 bqGdkd8k/ryzveDveUE+bvvQs/Tg4yXxazXCcvAkNe+RqK+6by4CRAIo7+Pzu+ZzsiuSIDDVI1W
 hGSRe6kDaWFMzd2YW4kKKZNDDd+/SXwA/UZlwfpsBNsbngplhk7OGLL8QnLx80oSP7yac5NvoqU
 WmDMX7DEz7M+S2CEhz5rqH0T74qWmDJQ0EI3553SAhhk/KLre+UEoYltFO39lqupWj2+dQbRcM/
 ezn7CXk22qHxKguDl3RXYc8udHk0eI4Gs9jaQL888+7wcI0AXA9sa/Sf1YJegNSGvB97KKp5gLd
 HDPHubtYm5yQCK3pJyACXnv5SjdDk0VWMzPCGT3H+kFP4THW3NrBUc0nNOHMw/OOiyKjN0KS
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6877bfc8 cx=c_pps
 a=vy3nvQW9C2dqy/lMnN3IYg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=7U_eyDcXjddG1dUirncA:9 a=CjuIK1q_8ugA:10 a=mHQ74H5e8mo-RpSg_uaF:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160136

On Wed, Jul 16, 2025 at 06:58:35PM +0530, Ling Xu wrote:
> Currently the domain ids are added for each instance of domains, this is
> totally not scalable approach. Clean this mess and create domain ids for
> only domains not its instances.
> 
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

