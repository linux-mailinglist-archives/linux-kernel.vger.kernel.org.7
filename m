Return-Path: <linux-kernel+bounces-809161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF7AB50968
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 01:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144165E561D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAA128CF41;
	Tue,  9 Sep 2025 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mXAAWBXj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CC28D83D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462166; cv=none; b=YGB/OH4Sdci6t5wRn2Adel6zfgIur4I6BPWUCN3fRLiongO3r6TXvM7cOSmyLYixqO9ciFvZr44HMLxuzwu0rnqjudPRnELG1kYs0olI6oTD7iOI5fVmB72FM23ETPr9tGfm1ZE9kIpHDhv65mrJZowAs+lgFkFI4vgwn6IFRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462166; c=relaxed/simple;
	bh=icD9gdWPAJJWeEBQEpTeScQSiYNChrtZNid4ligZQ7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhlrhQ+sEmi6NghThkaTGj6krw7kZNfdsCyE2QjL0IstsyMXGofliudGB90ygzBwlIC/VbkKDnFa32Oq0jGMLB2Mvobif5cJtGm3EFHSnX1mFj+yxEJ2OUyIfwa+tGj4Crl+1/VkRu8Xyp3JGmeY08Y7K0/5voXccswXTngQgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mXAAWBXj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HbRRC032042
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 23:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DOgS6PiQ/hnHybpp7vuDXCDS
	oK5LCMPR9NyO/JUnO1I=; b=mXAAWBXjLX1HxJ54WRna3AxQJL7zH/dZiqOT6/Wi
	rAFtu8RwDTdyNpY+FNLbMAIbgcqykd5u4egWc11FoTpNo3ShwkbT3JZ+/cDnmOUc
	qmg+yBuPjxNnrbrNwz0uLTuTNASiaBQVqbkqUkNWYGH2kF9CwI75178tFkuVQ2C8
	IuoZ99dxZRlcJE+hSx3q6Srx2qVtGNvCbnmgIoKkPfoxVvuj2AV8mhT8dfcV/UdP
	5q7RusnOqQ0OVP9nCMW9m0g0yZF+IKJMk0qek+t3v1haUBSRgESgPb5enGx2UmdS
	kZI5r6jbUfDTt3H6JmPXHRT48RaOB1HVQ2wyPCUoHkUG/Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m1vdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 23:55:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d7c7e972eso133666886d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 16:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757462157; x=1758066957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOgS6PiQ/hnHybpp7vuDXCDSoK5LCMPR9NyO/JUnO1I=;
        b=QEzHAHDtY6dsRNsH5LDSODd6lGYDzb0DociuxqfEynPg14JX5XnNp7JGUUoNPmJRiS
         72AdupSDtFa9oi85wtSfjdzap9PLF/o6nc7x0y0kWJRzY1IEFlQ9Z2aihDD0MvgwwoOz
         da0aCKMWaCiBpF3Xgihy1PjfiwvVxdYrbBH6iRnCCofG7DqoBQosiSYR2pM249dfYzUW
         zFiH7cZBYhEj0ebEmgHOIctb3SuplYVUxn//ihF4LguDSDXvsRiAV3XQJ7IypbpsMETl
         a1nkr6hCuEVJCLz/MyUQ0cE+0yCB1MZXM9q3q7bQi7wmBDolzZwKMvH24qceBXw1Nkol
         NnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhR7qO80ilGbQfDwD4kxchGzqXYUoU90wk8JcYFPQl1JLw46OtCNth/IfcfLLohtfvLY1+5nxm17JxDxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGYtuEteQJE4ZJO+POyAb6aT0M5iBW+f1kOxu5rh4jlY/LUo3x
	znxBqikMO27wVCaaBvTvsfO6ecS1XwzRQbSE57nmr+am+gZUPO6Z0sAqG8RRsUz8Hk11ds9I+aY
	mtm8Z5z2dq7cNMZZ4gWUVZ4yoOaFYocxCJRe7jMrWqwI8SAUTVlRL2obaNNt/gB97nOE=
X-Gm-Gg: ASbGncsBFazZAdxRYnss1W2pJ7fjoX0UPNU0DC7wmNf1Gxo2qNDai5sWsV0vc0OcVOW
	T4wTvyDfgnNUhCy6ZNU9mqmbR99CQ+5Kng5B9Jm9DRvwNUBdkvraL71UFtmUM82N8FM/JPkKFgQ
	t3DOE5jU7RblI2aGq6enDgYfLD6nxZbRNzA4lsiRDK11VV5Ze5wNMQ7tp0khb6uWK8b3xHTR+2O
	4jzQ7nD0kBgauq5xpbMzZII/KDMABmPGyYAGcc2uHtyLP8gk6rAXk7/JtpKDqjFxlkdb55bDSyC
	oqSdGqhH1ToLEVcx3oK4Bbb/5JTtux4rnRRxOGZORgwad73+jn3yF+92Gay849a5JjN/fH1qSoG
	1gjqe8z9h8KDhS3VjVE7F64DuKd8Mxj6UX8rFqW6I8kJcmOmLPcWm
X-Received: by 2002:ad4:5d63:0:b0:70f:a874:9838 with SMTP id 6a1803df08f44-738fd44e4c7mr123779846d6.0.1757462156562;
        Tue, 09 Sep 2025 16:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/+l4IAg1ke/qBgFq88M1rFWuCS6rIGDcnBc+blOxvMw+WiXtyVyRKy/O3bA1dxeMZYgKWSA==
X-Received: by 2002:ad4:5d63:0:b0:70f:a874:9838 with SMTP id 6a1803df08f44-738fd44e4c7mr123779656d6.0.1757462156128;
        Tue, 09 Sep 2025 16:55:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56818a11806sm831373e87.129.2025.09.09.16.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 16:55:55 -0700 (PDT)
Date: Wed, 10 Sep 2025 02:55:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sean Parker <sean.parker@viasat.com>
Cc: andersson@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: qcom: sm8250: Add egpio support
Message-ID: <don2dkb6wfi2g6o2lwwjk7khnptiauvzpnxie4qzt7bfy4xona@sf33md4bqqwj>
References: <20250904170613.68855-1-sean.parker@viasat.com>
 <20250909205248.16169-1-sean.parker@viasat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909205248.16169-1-sean.parker@viasat.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX/lt6Opub7hL+
 nMPAinA+OsLkdEvzJVjwiIkJ7etrNhtEb7+AghN4PZIPe5ZZl5ekvgGswrDeF7WDbXGuVBmeeyu
 gYZB4n+nkRg/UPb23HdWm+13ODWPKirEGgckUySN1/sMUr6qACo0scpSyqJgAu25fEO1cYxmStj
 CUe1adn0dlDNVX5kvsOMbG9pmaS86+phg7+VlU/cj6hnbXinr+HG3koyztwgFHuh11EzbM1teow
 vVo4y+qCIhTzp9FdXsQ0w8xXIMZfZMnUYLKV5uzX9Fe71xalYXPZmb4S27mF+Qkya5UR7ozV/QR
 9l7hH6FQK0kCTr4y0yMhWjNyAkDUcbGlml0YS3mXksDRje1jpO+NOapEp8RgLAaoCvHEH5Sma3v
 HRTFLKVy
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c0be8e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=B2zXoFvHAAAA:8 a=EUspDBNiAAAA:8 a=HbEANjnKo7ABX2ZL8B8A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=VYVPV9JAioCtC5HZRjjr:22
X-Proofpoint-GUID: jiNhdVI0Fs7aJfBCVqJu4eFBCa9xmPn-
X-Proofpoint-ORIG-GUID: jiNhdVI0Fs7aJfBCVqJu4eFBCa9xmPn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

On Tue, Sep 09, 2025 at 01:52:48PM -0700, Sean Parker wrote:
> This mirrors the egpio support added to sc7280/sm8450/etc. This change
> is necessary for GPIOs 146 - 179 (34 GPIOs) to be used as normal GPIOs.
> 
> Signed-off-by: Sean Parker <sean.parker@viasat.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm8250.c | 81 ++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 34 deletions(-)
> 

In future, please don't send new versions as a reply to the old one.
This messes up reviewing and can confuse some of the tools.

Nevertheless:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

