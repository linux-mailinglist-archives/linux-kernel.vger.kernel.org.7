Return-Path: <linux-kernel+bounces-652697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEFABAF31
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 11:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04323B7FC5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 May 2025 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989D4211A29;
	Sun, 18 May 2025 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GG+SyGfc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8213D891
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747562326; cv=none; b=CP6ezipLPYiiZDnM+1QNvu1BVN2lw5rB/DEagpyEIdf5j3TQQ1rL1hDhYPMziMh//x/zBVBxwTjiqHSWhtuwW3mDrAR6Qu14TKNCBW+S7rwsZSShy5c3TDVQSoDjJnta+7td0+yExWOZ0326MMQIT/RpXQslt09tgx5ooooGc30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747562326; c=relaxed/simple;
	bh=FQ94QICL73GCiVpJEES8GagbaIZrpDcJk0qqjLcWKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1KdxNptBt28XJd0LagBPxu+0I7wv7leRcUY8O6GqE45MNBooYHlGyPdvGRoa3TY6se92oORI9b/+7DwAePuJS3RGb0M64wK7+bbCLyezoMMlONLFUOYjPCpoFcmXSZyEktsP+XASG39xYgfHqkwuNwl/B4EmZNmIH1TgLbzf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GG+SyGfc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I9vftJ010592
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 09:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ozyvimowPYeoJg2Gil0i1JAK
	q8UocZ/UUw/4kBdCVY0=; b=GG+SyGfcboPhTCPi7LA88aMspIO9T5QMS5DN85Sx
	EWB6WLs3EsETIgZ0FsfarrfPc6NZ2oq0XVVWUAv0jvxS/w1WE+hdxwQGjv3RhkrX
	IFbn6TKPL9HNeZ7Rs4uGf939/lM+POXUZW2ibYTZ098yLLLRCrxVkMP9gDqtI29l
	+Wo5DYzsem91sdvUcVAKGrid4PE6DcOQV8BpkxYn5DcehRdWrvwGJXZH2Bi1XNab
	FdF8+0WjWRTfg91RHeoHAbtklQ/yg1vnLEevk5snRpRKwpXPM4WD1pDWEMQSIVBl
	giSRRIWhkkkTLtFhp0YkAWuWGz07w7yGcVA6xOVtoydbgQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pkr9srru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 09:58:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c53e316734so681501685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 May 2025 02:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747562309; x=1748167109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozyvimowPYeoJg2Gil0i1JAKq8UocZ/UUw/4kBdCVY0=;
        b=ai3dyT4tnETdhCgilRP6GahAVJATZtI3/qm2ak0lLmPEAK/ccVo1hvCT8kN8qRZi0C
         Ydj3Ktn3p5qUwa4TbW4YvKJypNihgbwb8D+5WdN7qCYQdnVpEW7SIqtVtQj5Y4Ger+NY
         U33qefPzVIwiB1PO0UB8ZRO23GX4Dcnnk7F6+0C/GK9Y9kZZB4QBcoiWWi03eV6MpGt0
         HIVvQTA+cBWlOjXq9IDzGE9b2PhnicFPpZMN3e0hCWpseLn+hUvFRAWV0IToP4Yr5O6o
         9fI1C9falGSGMpA2cVUKqetObnUGIeX5cM5P69yUVQXeXI7DyylWvwzRsktOmI18Af3q
         /PuA==
X-Forwarded-Encrypted: i=1; AJvYcCWSMUPVMRvBCjKELq+jEqj7eKTa60kcA7aTKXyWgAKOKav0yOZSOpkJKXsLNLm/SMWZJkn7iZfTNr4pFF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjGmv+h9LQhC86oxp9Pm5ftC5JlgHGqNtTbXFv2HGHfKMbDct
	3/dP1FUbu/rCZb/KguXWe9EowM68rZOrfR+tzPCnAlHTiJI+00v25FtydVhGuF7ANkPKdyyGoFb
	S+NxK03dygaiuFc0w2JU4HIwsSYjUC2JkaoMOijQ9wsIRYwv+QKy26DL2YKoCg0D89C4=
X-Gm-Gg: ASbGncvdgvm1lf9wcBp+QfJ53Y7fpApUB4oUDZliJ+Qs4a1ubJMJlX40IPblZWLyE+a
	1kYh1L8Jwfk96oYS1QUIeUrQmIziIlhDIgWrYxo/EgoJahn3qEi89oX3q7B0WvEb3I2XopPJHkx
	G3BMYfCUYCdL4i22zCyNq2A+codoIsUlzCjaeSKGkQZrfBLCuQkvEacE9M0x0bytY07pKvQrYCQ
	eI1vEfRNGcClKtiDhN8Kh73BJdsPSQ0F2Gak7YonYGlrndtGRJigzJvoV7VYiAkSV1sV2NQbj5k
	HwrrKw8SrMYw/TcNRLUDHUc5SO7kXS6uuN4VDlqamhUDZkbIT56DUenySXQm5E1M1NaTHyC6VpU
	=
X-Received: by 2002:a05:620a:8017:b0:7ca:f454:8dff with SMTP id af79cd13be357-7cd4672da8amr1575055185a.18.1747562308994;
        Sun, 18 May 2025 02:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzojClQz/Wnouf9iM34C8OJswOvQ1S2U6sryF3oPNsosWvXicZvKebvhLPbHpURtKz6Vy4eg==
X-Received: by 2002:a05:620a:8017:b0:7ca:f454:8dff with SMTP id af79cd13be357-7cd4672da8amr1575053585a.18.1747562308697;
        Sun, 18 May 2025 02:58:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f2fc56sm1364685e87.64.2025.05.18.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 02:58:27 -0700 (PDT)
Date: Sun, 18 May 2025 12:58:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH RFT v3 12/14] soc: qcom: ubwc: Add #defines for UBWC
 swizzle bits
Message-ID: <jgf7izei3ry4wutplvgxkfqphxhrzx5ed7zh4u74mnfczahaq2@gnloying4et2>
References: <20250517-topic-ubwc_central-v3-0-3c8465565f86@oss.qualcomm.com>
 <20250517-topic-ubwc_central-v3-12-3c8465565f86@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250517-topic-ubwc_central-v3-12-3c8465565f86@oss.qualcomm.com>
X-Proofpoint-GUID: R-cvoEGh1WXyYL2VLcWVBeFk-6Tse3bx
X-Proofpoint-ORIG-GUID: R-cvoEGh1WXyYL2VLcWVBeFk-6Tse3bx
X-Authority-Analysis: v=2.4 cv=DdAXqutW c=1 sm=1 tr=0 ts=6829af53 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=jAo0UdJAClyBKZLzlD0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDA5NCBTYWx0ZWRfX0E0y44owWA9h
 cIpgl9UsoOMqR/V10HjcjurqHUgmVC/YIFA+wCaFWb0KQsCOJEasdiR1LbJVsfmZsgu33FmwbKF
 JuRXg2G+mo5Wci2530BfOvF49NToWnVPYQRGfi9iQb7syyMKp1GPoweBy2Ge3e0zp7uil0mh7y0
 4cl4m/BTmNTHLllfLi+wQ13AuI0qA+i0KrArY8nN1t+k5j6T25HlJ6LVBmiRS4En69pk5LAVK5h
 2ILAI0nG443DuQlxDGPo+MSskNJAQAFKXJ1DjuhTp3mp6xLHkQTwstoD7YnOp3V6SQwv62OIGr7
 ZCZI1iQzMQfKRZYlQbv3J0b5kJecDwIP54Zz+9uVHr/qYgYgiiNezSmboEFqOcjs0ivIDYjFaMG
 RZK4I7rbKuhipG+GS8NPBeSV1D3pQKdwcYckGZJYnC4OXrkrY5CqHCVlV8wzyzURkSG7+fLK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=929 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505180094

On Sat, May 17, 2025 at 07:32:46PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Make the values a bit more meaningful.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/ubwc_config.c | 37 +++++++++++++++++++++++++------------
>  include/linux/soc/qcom/ubwc.h  |  8 ++++----
>  2 files changed, 29 insertions(+), 16 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

