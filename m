Return-Path: <linux-kernel+bounces-847495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F88BCAFD7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 020DF4F40BF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1C6283FFD;
	Thu,  9 Oct 2025 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QyUTD9rm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798FE283CB8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047010; cv=none; b=fjD3iTbLuRGJdciVPIA+FFIl/W0sannjDGayOYelDi52Fg7mTdWTLZ/FSV7znvpNCC6SZ8AzG3NNKhVmG7sXhzuVBcna74Cl7rbD9JdsrAOyxezeRqzcP49FfxJtfkdsAB662cDUAUZH6+g91GF3An5un7kx0b+ima6zWQS4/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047010; c=relaxed/simple;
	bh=0OgiVxHxuHOwZl1JtEffwi7VWDcOnNxQta3JJsmBPCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6GlgJEJOLA+2cNnssibPBdLPdbRHkh8GZIvFYnhZO6b2ksQ1De6bNxw3jkXIYI3bYvKKIvuYT+SLWmo30W3K2fTYXiddPdJMwYANC5sv6LZvcLmrUQbPAFblevjnyiMEklhpDCGT/MadCnGUagAeZTAfVt9n+9NcjqOIfZFIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QyUTD9rm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599ErWDO029225
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 21:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aXc6K5FtfcVXCLUBSxVt1McR
	pcSj+yDNhIZwNeN9Dac=; b=QyUTD9rmA8NOJa8IAHnoJvNHyfr1M5380oyJsX3b
	R4DqEb+ay1JHcls/T/Hh2H4+ZXJdFtqmUuZbM3/oG0sX8n8y1/VE7RONq8l0pkxM
	njzgs115RQ7eMC8o+DC2TcEU2zR9R3uDau0fRg2krkRwJeZLiVn/O/1WFFvhl8fI
	kCUPEmG2MuZLbuhYawhUHGsTa4mMmcVViUxmShgs6d0LcjAmRFeDcUEEhHAH1Y+Z
	7vLtyLuUScfZFMon3sCuyCuI1AlG8YCvgNEkigwWYn3euk+fIGWGGrzbCoULSYu+
	Lio6gXm17TL58qigBe2HL4DxdeEvdDXgXaXeg08oaBR1cQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nmcnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 21:56:47 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88375754e8aso382035085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047006; x=1760651806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXc6K5FtfcVXCLUBSxVt1McRpcSj+yDNhIZwNeN9Dac=;
        b=RgXnNvnCUhuQzcCmmyuONuylb4Np80yGa3nLTr347PASQrdbnEANQfPxis+hqVyWiV
         cQzI2qBb8ak2IHO/QWb+AE1SpbC590gaEBQqMS7G8VqTT9QU01VGdPiOEKcnv57Ejcqn
         Y9rJ+hy/r6S6ca6CSfB5sv4nlZs4GqTO8YYWiM4El/xJ/gsVCuj1GYGWNxUS0gCnQU8S
         hIEc3F9+Gz+fMKhsrZDA6EJXvedX4Goe8I0aHLqVsSxckhjuwIX+1Qvcf3CKcULOLGbW
         FsxjqmbyO13kbO4oD1528ItnT1qvQX+HBltntftGbdoZBnUwPTleLqpixDWCngivKr5/
         iFiw==
X-Forwarded-Encrypted: i=1; AJvYcCXdmui/lj7QtZERcq7fBdhOSOEOVEf03SP9OiJPWbUx4OpbT74dDfrZvhMRQZEarv+g6Nmj+re7Al0Vl64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEi8onWwdnUj3XAh4k/bTBUpsY8L6Y2ZcGPnxs/er/+cQAR782
	j+RcCFjkMWpb8Ed4iY8DaraZXmpVfQV1xsoxu1iBFyoW8oDRJpxHdlQuQuqWRd24mef7uo8NYsa
	eGHHRax4MxniJ6Miugsp+nHUkLjJSV2um0UdFSfmyfC87gvroqGz7lTQbrvcayQlz3Ak=
X-Gm-Gg: ASbGncuK/X7FhxyCDDhpcy70lhWpSARptPMLBOKkUh6qun+GMhfPm1u9amYVAF4jydG
	Y4TqPYmA57LQO27nqeuruIA+DbDbo8CX9BelAoZLmVbZJVS9pHv8/TJ1nHqktHievab+KXLmQRi
	v+8iakxGx3tovl1E630lXRFzpEZ+i79+FqU0O/obiy+f3JiUIkzGjLL2l3MSJHUEhzmui1qQ9hN
	jhuXwotJRUi+gC5Y4X44flWiwHr+Od752qZA3VVIQ3z7IJroXsgzjOAuQ3SlwXSQ3hThmW7DSpF
	6+ByZASJrtbYrokQyUVv1P4TaT4QslZi/qUG8xzwsSZ+blxnxqrH08cvmeu2E9i7rZTqYoaEFbj
	RMmirc0cqF7OUzUmxkrTkEDJoHNwaXG2+d7Yhug7jF7I/0n3tWkA0H4u0pQ==
X-Received: by 2002:a05:620a:1a05:b0:84d:a352:1853 with SMTP id af79cd13be357-883502b5269mr1331695185a.10.1760047006505;
        Thu, 09 Oct 2025 14:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSe8X1c6l0Woc6nK1FL8k1XI8rlfvjiZmvEQKYodTgIRwNv66o2mRudxwpcphaC7lwUMm+yw==
X-Received: by 2002:a05:620a:1a05:b0:84d:a352:1853 with SMTP id af79cd13be357-883502b5269mr1331691785a.10.1760047005925;
        Thu, 09 Oct 2025 14:56:45 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-590881e4f99sm225146e87.7.2025.10.09.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:56:45 -0700 (PDT)
Date: Fri, 10 Oct 2025 00:56:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH] drm/msm/dpu: Remove dead-code in
 dpu_encoder_helper_reset_mixers()
Message-ID: <vipgohc4rdankw2lcitdeypzpnqicbpccqcs72e37itpxj6wt5@5govlfjwyqxl>
References: <8e3b2fbbf5440aa219feb667f5423c7479eb2656.1760040536.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e3b2fbbf5440aa219feb667f5423c7479eb2656.1760040536.git.christophe.jaillet@wanadoo.fr>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxTuF6lXZC5iS
 I00bnlPiJ7WrxFSeVro5C+1qDJLpxN33cNZXDeCC7/6vvyITEUSrBYiAGwfGbE5dK2Y6NP1bQPv
 Tyw49Pr6ypp2LgCwNZi34jsEJFPKcnaIeuvMw/S9Be30ge8UD9pUYdvzfry2PSMDCDWTJ3fu+F8
 hmERf7e7FPoqyLJpa0LICcGQ/uMS2/YM1kSm+ugKTU9uV+B1rizYIepnCkcqu1a/40EalkOGxMv
 yXKfPY5SGJWfhhLAA17XXJUT/uXD0VgmdeWJrL0ZijVqJDh9HGshhXNLWXXOsaD6uV5NnMCDEYP
 DNr0xawyI4Fk1Ui6jtkRZOkv8eFbTUOG7DylE0RjqjElzvTfsugk5g2n/0f5oXOW+EciBQgnSRW
 JEnEyrs/CVTipaSDxHAapTgO8Y1s1g==
X-Proofpoint-ORIG-GUID: fGXliYiH5MYmFmvbo-LUD22ZfB-elJbP
X-Proofpoint-GUID: fGXliYiH5MYmFmvbo-LUD22ZfB-elJbP
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e82f9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=_rVczFtdL_8dPuQia7UA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Thu, Oct 09, 2025 at 10:09:32PM +0200, Christophe JAILLET wrote:
> 'mixer' is only zeroed and is not use. Remove it.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

