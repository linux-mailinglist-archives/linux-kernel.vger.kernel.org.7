Return-Path: <linux-kernel+bounces-806447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89F7B496E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC53B0328
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A253312819;
	Mon,  8 Sep 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kNExVKAC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB013C8E8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 17:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352278; cv=none; b=c5d9fSIflXcjFJ5JyHt1WaMNw51L2DfqCOwY3UW/MI/hVMZPgU6Nyb3BspuH+xiYSAn3k23HAOweBn/bTjahhVpRA4Nn5LSomFIg89TTlzyOuuvwyRUGUx6gBYTlTVbE1uFb8+IESR6X4uZUhZadGN8QA8aHp4/Kjr5s2gu6PLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352278; c=relaxed/simple;
	bh=/NaatLCxwu4jxpeZRKwI9kVL/Y4rraEkUqgeduPIw3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6X7NsfM5c4NWzr9EBFp+qJaSIh1g8RC9IWB7QU5zQcPtC0X/EyJIK9hi/OzT0IgdmycNA3MrCojnuPPqzI7Pd0yGTeVK5Fi/66f54oIULuZO+7OUZ6Jl4n84d1iw1jCetJElmpVwgkcad0iaMQsDRZPcvhtQZFu6djjWq7Vc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kNExVKAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GI3N4003936
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 17:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C0cWDImZ8z70BOaSp+butwsw
	MvwnEMiQkgeS6sxwcOI=; b=kNExVKACiI/8ETgDMI31lk2JxzI6rbCTpVc70DAq
	hs7Q9p17Co3kdezKORaRmp0hcRQY/ZSC/KknqKWQWQLxzTlkEGTv+cWYb5zTv2Ic
	4pbmVc/ZLlBw3nWg1kb06Yr97QsM/43pMQ0QDDR3Wg/amim2c7Jmke3GM9r9gybV
	7ba4pRa+5gM/lTJYfrWIgtiIZAT0LRKEadLPHMHQIvmTxWOFQZnoylbcWncToReD
	DUbQSvuTYgl+SPfZlsmNywoTHbRC2BbMTKk2iJ6fr9MxdVgB53Cv8nEIb0X6e0Ew
	cqteyTo5TeGXcntclkolad0xK40rcPZ0Tfmtpst557Z+KA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8dfen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 17:24:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b302991816so108397051cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 10:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757352274; x=1757957074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0cWDImZ8z70BOaSp+butwswMvwnEMiQkgeS6sxwcOI=;
        b=kF8vBw0v6XRtV/wHFyHbmOetxosxRMJhf0aTNnFQ3+jD2FNf6BVIqrYYU79LApm561
         WJL2ei8fp+zNTu4YDakjsHNOrlaL5Kf/tjc056myUnewz6BzP7kxmHMQt6AR/Bflyiea
         wLKUHx4Uis7yEzKNZti82LIkBoGkr0p2bCS2kAFucb+C0is+0EHWoGVdHrW97ALFqu++
         xsrIq4IgiTICz66BFhKIIfCkFbgF3vv8mZ2CZdUKkVJY+d8ds9pJfER4/dVqjctKNsTE
         7dTsk7kz4ceYI5KZoAVEMlVRL8CNgjnK6KA+Uc0efNJDK/FWCCzN7v5droGx+RBADo7o
         1dqw==
X-Forwarded-Encrypted: i=1; AJvYcCVDvS/duMH4LuuLLHgElbFCe/CS/etN7vxo/XCls+2doBZ5ACuZxD6xBjM6n+1wGk28XS+N9T6rGEvfpdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBx8rqg628LgrQK8wLw1yGrcqppmupQM04gb4cfJ4SGIRPGdGt
	V1DIGyuQ1pRpSSrztrPvYVMJERX7b1wFfI7Syk1fia1vXI++ZyxSrNpxJ9u7p+z4+94UrNEmOYr
	/d16C6LpaHoloz41ihKUugLRxlsTNqKRFeT0kHeboElh6VhHyFbbPuwkm4e12TSRcS4c=
X-Gm-Gg: ASbGncthxRf5jaZuZQ2QhoqiSHZ+zew5OzcP1HoohD4uPvzLiPSurZs4Uk4VPjUQ7OC
	DhRoU7wTV8yNvEBre9Y9uoMiuzX0cDMEGB6GjHoi7GpvwyzVZi9v26kQyQ3Y3qFkNauEDDBrvjN
	xsEnQPAerlHKVktTHS9+/F8+Qb6CoM0+QRUdizibmNsShwBHzKQ8rIBmwaOUrDOrBOUjpwI8b4d
	D9ru8qgA/H9xU1S/MV6S7YGHxfFTzn8BjrBX3IwguWPrUghTfYLnO5nMPwZNxqX97xvNPYF7LND
	1iVZ5ZzrwWKXAuRP+ag3tMo950Ryl07FZbRxjJG7lFKX4BJa0aGdMiFPXwJZ8Yh6mqUzI83EDPZ
	1iVz74C0K/lP/x1jupQBR8NhnKAYYG/V1G19ZMuTFonlGfo8RIrdL
X-Received: by 2002:a05:622a:1a05:b0:4b4:9773:5863 with SMTP id d75a77b69052e-4b5f853956fmr84823221cf.48.1757352274043;
        Mon, 08 Sep 2025 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHroLAl9V5JPPOY6AI+HWtJYULgdQbzIUd5r9lNqCkQrv5cWCcgBxu9k1K4dRxOnxNxznWegw==
X-Received: by 2002:a05:622a:1a05:b0:4b4:9773:5863 with SMTP id d75a77b69052e-4b5f853956fmr84823001cf.48.1757352273562;
        Mon, 08 Sep 2025 10:24:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfcd18sm3718116e87.108.2025.09.08.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 10:24:32 -0700 (PDT)
Date: Mon, 8 Sep 2025 20:24:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        lumag@kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Subject: Re: [PATCH] gpu: drm: bridge: anx7625: Fix NULL pointer dereference
 with early IRQ
Message-ID: <alk2ovpplncgr4qf4l37wt74olqs4zpu4pddveml6wpny5jlgg@5kqcrpsk62z6>
References: <20250709085438.56188-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709085438.56188-1-loic.poulain@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX9ZnByKAeqcfC
 f83HW5W3ZckKX5xmrJeh2sN3Gq0wSIchgjwhUYNYj15BkEWhQmuNhkrPL1e6XXcmWsb+CwTYF04
 +x7GQfCqt3vBjB3jwkbzj8kD/GJSQN/E0bEfbPJtzv0cPcoGSn4rVis/l+XS3X3stCgi9iM8NaD
 Lt7sAejJcejFjz5Zl98iZyI/NH4QuOtoOm3yXolEsKLx9ymX77cTU/uX7bZnebqL5HOmciONFRJ
 m+nwfgTXhXbGcS3/oeYOTAwFaACASsQcztF8pJVgt9u11lnmF7DNoUTi/SCBP3hkD732Jna/naN
 58aPx5SvT6VwjqjKD/KqQDmx/Vtk2ivanLIK03Zc8WZy7gUGou6OcrJ4np7UnUSrYfn2PLhnHm6
 IAe0FNcz
X-Proofpoint-ORIG-GUID: deESqVIW13DVDMk5O14FgoLPYdhmyyue
X-Proofpoint-GUID: deESqVIW13DVDMk5O14FgoLPYdhmyyue
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bf1154 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LWE9zbpONBY6LCXfEiwA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On Wed, Jul 09, 2025 at 10:54:38AM +0200, Loic Poulain wrote:
> If the interrupt occurs before resource initialization is complete, the
> interrupt handler/worker may access uninitialized data such as the I2C
> tcpc_client device, potentially leading to NULL pointer dereference.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

I will fix subject pick it up for drm-misc-fixes if nobody objects in
the next few days.

-- 
With best wishes
Dmitry

