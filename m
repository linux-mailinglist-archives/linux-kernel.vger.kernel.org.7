Return-Path: <linux-kernel+bounces-729985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9DB03EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C693BEE11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7F24729A;
	Mon, 14 Jul 2025 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iV0HXkOD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08B2472B0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496046; cv=none; b=QD7eBd9j7Hcm9mafIlrGUqLNDhXD1CHit63yHXG0CJ5Oc+FErieWNdvijDzX/C6ESFRwdZkZj6LLBiBDg6S/LNbpGA0T7DeHS4u8deqDhf9iQOVAX52S7WwhShH3Bk3Wwy96baOxzyWgFKffnnLH/FWyfGETfqsYXpTvsWWzyp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496046; c=relaxed/simple;
	bh=1L6R4wxjetxb/pWZk2A2ku+TcEAJsE2+TTcPhlpd8j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFNddkJCn4AZxuyxRhVv3+BUDqObQvS30jNmNG0zu3e1RQtXcTXsXRShSRBMmyin8Ww8uhAnakEH9fphhAM7KQ7xGE4S5Wx/JK62DcbldhJZETMeaXJA0WCEVejN6P7fqf+dQd4VUbmT7jqvikCworKS3QfplcZgLBN/RdPGVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iV0HXkOD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9wCBb021735
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6EgrQ6Evaclca/mv/a+/ccLx
	hAtqa936HRQUO/m+epI=; b=iV0HXkOD2VYKwXwBtVQRczeh4oiytnh9ytNquBSz
	x7n0Yh8bvnNPuGZPy28cMQ0sug9hN77RWUK6i7uHw6hEy9lwrEHYyVxjgxB+J1BA
	3HhiSlTLoetbOSZBja+g2C/hRrgykzfBtXgLb85ncyMlHhJ8gnRJQ8lA8rFE7DDf
	oFfOKQnx76lcX7jMZQ4dW5gV68AlN9sXSJW48UnR3unpSjC2gh9ip7TRceFaUNB+
	s/f+R7eomha1r4I5VpPkpfG9sJrvU5wms/ST0YtOA4SZY+EAtMGQ6s3TnksMubcP
	aFmdqiGz1gFuL6fml9c0XxAzp6hrfKgBC7IOis2uLjDIkA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47uftmcp5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:27:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e237c2f4ddso208181385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496042; x=1753100842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EgrQ6Evaclca/mv/a+/ccLxhAtqa936HRQUO/m+epI=;
        b=iUnMv8WiiZeGEYy9mXcGaFORgqEpf4ZnKl+f+8FCxNjLOEKw6TAP87vt0fCg4PCJZa
         90Zr7CihOax9Yn+GOC9NTA+4Im0qUKGqJUv1PgKNWNMADFQ333fxp8XpeUdy7e/NqqFS
         B6jHWTtW8lJyIH9NH3zyHfp5lJ6wEH+8kFwF1jnbq9HR/6aV2O+RvCSccfEQEVFaI9p5
         2/8R/mehfHcsyleDOIN+CULNzlbRlNUFF4Pc77+wHrsmnrZ191xG1vZ4fcZTqK9vMHef
         Vq6T7glMl4Hhf1b9TSXnW1qmD7VEb6gY2jn1ccKUnnaxQ5WHrm6awdJC3eyK+PTiW6sG
         el7A==
X-Forwarded-Encrypted: i=1; AJvYcCXDHrWP1oA1gipPiAmwt3qO44ppZwvCHTllvdTIs1DBBC9y2t0VEi0/sNHnSEGKK33jKb2ZMsTVagoJvY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlw32Kw7anwFNSHQgOu36YC6NXDucWDXOrkfJCPfQUHxRti8NQ
	sKSO9uDYiQM4tJPs2rVUdZmd2wBX1WK5F4kITbdhg5/GUUJYyjmuF4TI95KNADV7Sv4/C93JbfS
	y+4M8x1HogQxEq/cGrEBBIOtzbeuojEnJY4jN64tSJYw76FQ39nLPG0KcEnZiT8iFzpo=
X-Gm-Gg: ASbGnct56QofLYj+CG7zDMkFA+C1FQmj0Gn0XSuftl27XNHxsV3rZtp7xxMr2ekDFEq
	699/bHeBL60o5M+hODezge3Awx8IKdfGi4wOIaO47KN7J0v+3fv00LFop9KSYXCLcSka4z0AdVn
	q8S48kqKYJuF/1IzJ1qPBAGejznlkExfIWRafVrodNMqRLL9CV9agH5tJun2GoJ+TqcDpqZkC3I
	t3vGwh6F5v7d6TK6Ib3F18cUfbV56AgD9MVo9askf4uGdBdtuZUQeZwH725SxuoPh4hnNhpBhYd
	FpLrtF0R9swtNL7itmvAIAxZiO6DI0oh7/ZsoOOx0cZvpgrCNHY+AHbM6m6W8TZqjyOyG2K7S03
	NmaddCUpsbUhYzxL3oZxjuoWrTcjVr6eopQzXriiy+f+g5qUH2dQS
X-Received: by 2002:a05:620a:3704:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7ddea81b3ccmr2041494485a.25.1752496041897;
        Mon, 14 Jul 2025 05:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DL8IYvSTdgwjCn0jn6ALMNC2tGNJGfPy5aqEL2dhHJ1me0Kau9nI8+0T6UE91J0zx/Y4eQ==
X-Received: by 2002:a05:620a:3704:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7ddea81b3ccmr2041490285a.25.1752496041286;
        Mon, 14 Jul 2025 05:27:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b6b821sm1945844e87.182.2025.07.14.05.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:27:20 -0700 (PDT)
Date: Mon, 14 Jul 2025 15:27:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH 04/19] drm/msm/dp: replace ST_DISPLAY_OFF with power_on
 in msm_dp_hpd_unplug_handle()
Message-ID: <rmlgjr3fzb7dmnwmthf5bj67wb6fkcksmn3ouchzsvhhgxiv7h@vwcieejcufr7>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-hpd-refactor-v1-4-33cbac823f34@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=AI4FyeZ1 c=1 sm=1 tr=0 ts=6874f7ab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=JFUgQLFdXU3b13EZuZoA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: wcTgib1ySvuzcIcUYOA1ENmktFTA6uAb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MyBTYWx0ZWRfX6UquA3jDwJaC
 x9Pm8J4ZdmjuVh5XQhQ2sKoqkoArQF8LIPmErUJhh+oo2u9rvHdG2PNWz7Kmx1uNIF3jpYVaI/6
 lGyRuAkHUjK2tG5HDt+96MTp4eLHNXbxpbYcx6vkgR+5AK23+7FvCJDbxCg0VYok0nPPVp05Hc7
 LQYFdshBEtqrDV7J5aARx8wsskMnKSfFtuhdEGtz2G5Cq9+a6miprPEQ2apEs2VNAbqChVFjN02
 OKXGVNnLPfTXAzhEkW9FEz8FHovlNAMGpeVmQAKyCyJEtUvFQCko3BP8tcLZ9NG07Wn4n88kQPS
 xtv6eChQ69nHMLggWTyXmbyKx1LRfVS1yIOG5iUHvX61IqdmRIyP9MX+QKKB+fJ+WYVpvouDcqC
 sZ0uTfgKTzdOScXVMBqrLfUuFPxNblyE2xJ62T3en4QhcP8ZcDcKRaaOlu8zTlphAYYZlpiK
X-Proofpoint-GUID: wcTgib1ySvuzcIcUYOA1ENmktFTA6uAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=680 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140073

On Fri, Jul 11, 2025 at 05:58:09PM -0700, Jessica Zhang wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> msm_dp_hpd_unplug_handle() checks if the display was already disabled and
> if so does not transition to ST_DISCONNECT_PENDING state and goes directly
> to ST_DISCONNECTED. The same result can be achieved with the !power_on
> check.
> 
> Replace ST_DISPLAY_OFF with !power_on to achieve the same outcome.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
> Note: Taken from https://patchwork.freedesktop.org/series/142010/
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please squash all state-related patches into a single one. It would make
it easier to review and more logical.

-- 
With best wishes
Dmitry

