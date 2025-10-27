Return-Path: <linux-kernel+bounces-871863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06BC0E8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496A65606BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7296330EF81;
	Mon, 27 Oct 2025 14:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UUUKXjTp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1930BF53
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575952; cv=none; b=TVgQaQNbyX31OHpJVmgbps/lndEvLNWUfP6yQ/mLyYyN0ZalvI/ZGVPdhyHMmcue7UEQNS58FWUhF0J7pJ0xbNTQwPLUeODODZmJXqlU5XEOljJ9YGEnFDEERggE16QfvcYpFIAsqhnMeUVvhkxkY98xHw5XzkzYdTE3ikGuT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575952; c=relaxed/simple;
	bh=47HzZofMxL0ovAwgF2N0WwWZU4d7Fcqxln3pLvlcFrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oK8WcNW3MIAznW+mZWRWEK5/alTTWKxcEIoqa3iz5sjjdLcN3XMpCOd7jj8BKA38RLG3NBFVX28puZAbZt1AXLrbOIrOO73kMxHDKzcbWnShplp4cSTIUAON9TmD2l/Bf6DEQmoTOn3uHE7EkM3B7WzCOo7CN/DDtCMEnF1070Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UUUKXjTp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RDhFfi2962165
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aYCptxushuK85zBtS4ghGUMa
	UfbytrxnOA8EMRRHrZY=; b=UUUKXjTpHCKASlEf0rB5/nCagNQ/5xVg9fGr+oWR
	veStfZsybImG24joodx6e9Ax3C842i0HTslBXrUIkZu7+clFwnfeiuRv2LKIL0tj
	g2kt/2jJ9Que83VTHP10ve/RKnAG8+sMC/g+Hkn4vEhDiWKcbImHukQkelyt6a4E
	pKDmLwpqPkMybRiOq/rJkWvRRY4iK+GVydD543mova5ikhDcuKWXrB7pF6dqYfqn
	rbCwfRJ9Tu7qc5wA0fcVbm4FlblkcEJIx3qLFvAyKobBXtA43zky95lzTNx7azb9
	yhpP3OHVWlA2yNooWa8uvskQTf1LQmPjmsiomSUoSXG6rA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29v9r645-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:39:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e89f4a502cso142004401cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575947; x=1762180747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYCptxushuK85zBtS4ghGUMaUfbytrxnOA8EMRRHrZY=;
        b=lLl8883szrNsRlnjtg9c6YjjJzbQYTPeVQACstq5loIoTabYFZymoarcQEjMhOHoca
         5E5FYGM0b0fNJWUrnfSsuRq4AeiPhWGcXwpiDwYJ0YSl8itoCJJ+px7EukMF+DvmBgb0
         epsA76Fx1TGR6nEUYOkduVZyOIPrPYH617ETw9dNbNR3EAeqPOC7w2AFyoWelgBQsgM5
         mZ8rMvlhtPFi1BWibHUm+R0nImLFv+WhOeOedFZyuN/vZwrKQ5Nnt82hs8PXaSaNgfMt
         sZeyyDt2DHgkmjALh9rL72q8+2yccd5NkyYChmSc86ZwfoVZoT4JkkFNKgj1FiSTvPph
         NZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADpsZfEnF0ihF8ZsG0AmavgFs6ZqOwwiSC2G36ngMTgxALzxHJ2t8R4hFeuWrVR4DfMviNqiYGY/B4Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyotGvmebuis1y50B6iHWl6/bdo2kM02BbAV8P2riJr5AtjxKd
	xtMYcCbJJlakjxNJHRyemovAnLUqouzB/C4SklZ0cDC/cfMrgcjLat3rzMujHHPQq3sC3D1COmb
	DMVU8B5do9Bys5fYSJGzWfKTx7slwFG4JTqvlzV4Fq5rsRLp7+CFrqgH7Xson+rZxLDlnFenc0w
	E=
X-Gm-Gg: ASbGnctShn+f+kLnryWzDLCEWXcnFdZgWlb0vYmwhX0nL5VvT9NCVzKmrpF6ImosfIu
	Qn0fMpsai7I+8tKDi0Bz1wvFk8Xk+omL8Fc9I/FBUlqsA6UjWhWlg1HzGe2zCyM9WSz7qtFnPwP
	4H05Vg6m34gJbtHd04KjHX778HKIp7v+WcTYqdWbeUlE92RAJUfik45D5flWXHreRds1lizjp6d
	9lOJmfbn/BTMWtrjvFfAZRRdN0Ydfz5yIVIQyqtoS1oCPp4z6YfiH+3LNo4rKbZMxei0kL0/4/J
	M/9V3yvw0Jxo5tQ8Ny0YOCvqrVvlvZcxc8MCB19h85hwN2+XNeOExotlZLy2O5DFo5HOTYIurRN
	I7aoADB/CQ6LN4HJai9E9MEAu3X7xbKRxxYm/6qF58sRStNUEV2QFgkS0iSlnPgE+1a6vEFOb/E
	jRZmSv1D9/DBLo
X-Received: by 2002:a05:622a:210:b0:4e8:b739:6b5d with SMTP id d75a77b69052e-4ed075af157mr2499691cf.46.1761575946945;
        Mon, 27 Oct 2025 07:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE25V05R9DFD8UMFppmwdaHhnps1+EhW4/tRntEoJQnX+uPBq3zljmulhRuh9PeNVhTxFxKCA==
X-Received: by 2002:a05:622a:210:b0:4e8:b739:6b5d with SMTP id d75a77b69052e-4ed075af157mr2499321cf.46.1761575946421;
        Mon, 27 Oct 2025 07:39:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f41cddsm2320354e87.17.2025.10.27.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:39:05 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:39:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] slimbus: ngd: Fix reference count leak in
 qcom_slim_ngd_notify_slaves
Message-ID: <ke5p44nthtwvmptp374xtkkc7giwvnxwheyx4ohz6fugdwinta@w5timotaxhkq>
References: <20251027060601.33228-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027060601.33228-1-linmq006@gmail.com>
X-Proofpoint-GUID: gDK0ZPvkbzZvK3ToleoxigZEOpGfOaQM
X-Authority-Analysis: v=2.4 cv=D/VK6/Rj c=1 sm=1 tr=0 ts=68ff840c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=Y9G3A3km2bKrLaHVutgA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gDK0ZPvkbzZvK3ToleoxigZEOpGfOaQM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDEzNiBTYWx0ZWRfX8vRUmu+zo3L9
 ToeXyi/aP/OGMmouCqy6mGGb9WcKL7/3IxCGm0ySfMKUWgAPe9IPKV3A0AuepUm+kzUxzpwolEj
 XzZHyDX4FcqniI6a2ZKn8kavOcFZaJWUcRi40izIMafF+Au1IOH6UsyXXw5Sm6dJ6ljcxIXiPve
 jNlU/AMk8z+F6EuJ3E9SZ4+8//6utZ+mhmOgCkb9e0EDmNo88I2aqxa9NDy9Quinp8OV4T1u/Ke
 BL6ttU+8Oc/JKkgSgxy0vEhDYwOiyw8JOKZAMBuB/EQIWvcnlUL+36nT5UD9Hns9WRTGsO2Bxt+
 6yx/FXo4eCAgMuB49+erpY+q0+3ES3Oo8GzKlLTxFkseRu0TQBauR0Us3+iU1j0PZfyVE0oQxkJ
 mbt9gJgNHQXYZ6rXStwgR7YaGLQ0ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270136

On Mon, Oct 27, 2025 at 02:06:01PM +0800, Miaoqian Lin wrote:
> The function qcom_slim_ngd_notify_slaves() calls of_slim_get_device() which
> internally uses device_find_child() to obtain a device reference.
> According to the device_find_child() documentation,
> the caller must drop the reference with put_device() after use.
> 
> Found via static analysis and this is similar to commit 4e65bda8273c
> ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
> 
> Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

