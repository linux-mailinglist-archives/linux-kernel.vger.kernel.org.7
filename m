Return-Path: <linux-kernel+bounces-859670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E40BEE3DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C485A3BA766
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A302C2E62DA;
	Sun, 19 Oct 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LUezUlfR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC983C0C
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874670; cv=none; b=MXVr+BPW+eFQH1NJh2VLyVOCE2AQq7ppUxuAF1E4xw7qIBAsiQRVrFcLTZUNjQnaA8kdDmEYIlQmxqWBMSv+8lBn89O2lAg+o4ibNbmz1hTNJx4Wht6wQnki3BK73BgMvoKXKS3xKpW7048EVu5jsqYuPXYuB88KAKONqqz7tPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874670; c=relaxed/simple;
	bh=cmumtuKzBnfg2R1nIGcWe4yYElE6S/ZvHRF/dQ/LS5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maB1SW8+2PnbRzevNm8pGgjeaPFan9CcVUavyoQ7n4XtUFHiY+GGt9EH8T/mCoGuXz4eb0aUIN15c4mMl3lS/cw8yQ5vGgzJEfqC3IT55YH6CMyAzE7WVyp6uFd0FCapMLVAH4VIJ1MepYH5jZKNohJmja3HF4XLur7mxToamMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LUezUlfR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J5t2Ng014394
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZUjoE3uaWfMa6VH/+WLd4NQm
	IGTWDScX0pmR3W98/kk=; b=LUezUlfRYlu8wvFCX5Lj1l8JwQrbeh73JWCNQM0c
	5198Ja6mfMrbyT9ZQc+sWzpP58F6J14h/S/3t4Y8QblivBNLOlvi36UQdOYKPsbg
	cLpY1TjVgklpexitsLdLW6HX0+rZ/AuknKlY2yGahp/ElKvO7RL+UgEVHwktr/wq
	rB9RdJO1o2xtZJ1tm0U+6LSAyfXzpxLAjFvTbeu/flu9SlsvF/F+oCqZcXpQnAbr
	L1le/fCVBjWy9RHzC00da/PuvuKf83CRxDKmfkvGgSva7CPZBcHu7/KKt1aK88nI
	6Rc8yUbikL8h4uF7+9kXiWJb5Zi70EjGdOi0sPwrigHaNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2yv2963-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:51:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ea6169a96so535184285a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760874665; x=1761479465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUjoE3uaWfMa6VH/+WLd4NQmIGTWDScX0pmR3W98/kk=;
        b=uiGyjneJ7Pyv8ZWTnoh53V9AsLUDoUqURUnvWPHoCL3+Kj1sHxXn1cxPXz6e7RCuEW
         zs9FZdj2i/h+RfOWmC2c8GYmP8w9jg8ro54IgchsYl3PWdL04/IogY8aR8/RPCCvEzet
         DbFdkNkucjSYr5Imago61q3/9cuqEjleOw44xHwdzBI+sbljka0murfnzY9H27Swm+RB
         YdyJf7HL+BcOJer3vuxyKbFCKwD3zqnv0baQcuT95fEdsGUKwvlQWGhNrYMrfQkjHcWR
         sJkqewhhFjs9bunlsqTrFPasS1/r0pwx6R2+V/x5XNrnuXFS0Ww030ISNrDfvmtiMI0w
         +PAw==
X-Forwarded-Encrypted: i=1; AJvYcCUlWdCYwYQlN6tiWB8Ej4qSofBPnJr+6n1HO5ezhqT4miAOJS1GSx+9uhRtfuTJX3qah3pgalysG+sjWkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW+ae7BdIpNEqsKSFDMczBKwlV3s1I0ZbdRvVJq0BULaizbykr
	3Rsh8RI6xbXfxtiOdSgjv95x17Vkji81njhFA1NjJp44NCBsplzDgP2SwhDHTjvFx0JooIwnBBq
	1iNq2Zu0m5lcFOGHg94QYyCY4DKHUglDOBAQ4O2z5KJg9SWRMZ0bkpO8tgInQXAT3Sz8=
X-Gm-Gg: ASbGncuJWowomZto8+6jXnTCqTwYBvdZB4ESYf3lWqvGKtewmLMu7+V2+xSx9N+cy/i
	cw3LRQSWTtmInoWoDOAQv9eAC9tN34wQEfrdljH8Vc2YBTb764ngHkdBxpfUgmXyTp97I92VOaH
	NxNu/jF7ABo9EEEjw4E9dhELSKAc+12D4ufQJdPcYWfnzpZLCc4VJTUxvSckwOPXDiOpXP1HQaJ
	GNBLq3w+gWr15hgGRckooor9n1gEYN8Vc0G1+I/q+xOh3v7rVAlP0P7Mlt9rNzd+Zem4FiEHnGV
	C5QcB0Jt1pSKAqDTwPHp8ChiZfNQTgZZYhfY/F0BxeqArUdoXfRb9/uAjnBa+TM5eI0MkIxLQZN
	+qD3zqzTNerDvkS8umlerDvdfdVeYzeAb4aPyEhUyx42kaL5rvJa6YkxI0jeNSy82GaOxUc3A7m
	FovEu2L3BEwag=
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr131268621cf.21.1760874664648;
        Sun, 19 Oct 2025 04:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgCwcuy4yEvCapeP0Dbyy4Hf4Bworm1xv+SK2OWkHb6v+nDIhLoR9n9zwArGAv5qtBmdl5lA==
X-Received: by 2002:a05:622a:138a:b0:4e8:947e:16ef with SMTP id d75a77b69052e-4e89d265f9fmr131268391cf.21.1760874664134;
        Sun, 19 Oct 2025 04:51:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377aa5cb527sm12977911fa.3.2025.10.19.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 04:51:02 -0700 (PDT)
Date: Sun, 19 Oct 2025 14:51:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: David Heidelberg <david@ixit.cz>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for Pixel 3 and Pixel
 3 XL
Message-ID: <st7oizyyih3fnsi7jgcp47pl7s6n3gz2rdcv7iryftol3bqvxk@buam77hiqnl6>
References: <20251005-pixel-3-v1-0-ab8b85f6133f@ixit.cz>
 <20251005-pixel-3-v1-2-ab8b85f6133f@ixit.cz>
 <n4xims4y5sssqxkchg2tikc7idkzds5ru7ayidcgxdfx77je2d@qo34qucbebnn>
 <a5da8d40-f194-4fed-9118-037bd39ebe2e@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5da8d40-f194-4fed-9118-037bd39ebe2e@ixit.cz>
X-Proofpoint-ORIG-GUID: cOglI7cPxAaiLkyBPUDKWcmh1t0l8gzj
X-Proofpoint-GUID: cOglI7cPxAaiLkyBPUDKWcmh1t0l8gzj
X-Authority-Analysis: v=2.4 cv=f+5FxeyM c=1 sm=1 tr=0 ts=68f4d0a9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=viK3g_hdjgQu3jI_W3oA:9 a=CjuIK1q_8ugA:10 a=dK5gKXOJidcA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX7PFtd0QbkSHR
 eACNqMFAkt2q91WpKJkLYB9fSWv4mLD5lTw7tfBfS10sJFQgrwJTATVBA8Q5WA7S+mNfkad3n64
 ea97N25wY9wEnx7HEuty89ZqqlhEhVocFhlFfdh7sUb6xQvNU7LCkc//+ilfcsLmWG4AZOMHSmw
 LgrgTwju/MkSN5GLENnxeZrExcgbp+VueWklFEMcwBI1zB+EicY1ZN340piMYWWSWS9qR0hJ7Uu
 dUYhAOGKPBDvxweYHjJq8RJ4ml496RqB7Pcul1A+UcK+MtuPNGw8+RLi/afcQ0uTGGdGnytAniV
 +HC+PFQ9DrcS7hzWjKcuCXgfDM13wv/0dyBlQ6qV4hcWVkZc1FpstvqchtqSd1cXk1jzX7XJvIj
 /4Sz+hw3UxHcG5E8nqdISY3vMKvtBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180023

On Fri, Oct 17, 2025 at 06:59:14PM +0200, David Heidelberg wrote:
> On 06/10/2025 00:03, Dmitry Baryshkov wrote:
> > On Sun, Oct 05, 2025 at 03:16:29PM +0200, David Heidelberg via B4 Relay wrote:
> > > From: David Heidelberg <david@ixit.cz>
> > > 
> > > This adds initial device tree support for the following phones:
> > > 
> > >   - Google Pixel 3 (blueline)
> > >   - Google Pixel 3 XL (crosshatch)
> > 
> > Great to finally see it being submitted!
> > 
> > > 
> > > Both phone boards use the same identifiers and differ only slightly
> > > in their connected peripherals.
> > > 
> > > Supported functionality includes:
> > >   - Debug UART
> > >   - UFS
> > >   - Charger
> > >   - USB-C (peripheral mode)
> > >   - Display (Pixel 3 only)
> > 
> > No remoteprocs / IPA / GPU / Venus / WiFi / BT? The firmware is
> > accessible to download from Google and it can be further repackaged (but
> > not redistributed). See [1], [2].
> > 
> > The phones share all firmware except for the bdwlan, so hopefully you
> > can add 'Google/blueline/foo.mbn' to the common file.
> 
> Would it be acceptable to use path format qcom/sdm845/$codename/ e.g.
> qcom/sdm845/blueline as it's used elsewhere?

We have settled on qcom/SoC/Vendor/device/ long ago. Could you please
follow? All upstream Qualcomm devices follow this approach.

bdwlan should be sent to ath10k ML:
https://wireless.docs.kernel.org/en/latest/en/users/drivers/ath10k/boardfiles.html

> As I'm looking at the Google scripts, I assume both blueline/crosshatch use
> same firmware (which makes sense, as only the battery and display is
> different).
> 
> David
> 

-- 
With best wishes
Dmitry

