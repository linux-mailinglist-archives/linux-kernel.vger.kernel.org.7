Return-Path: <linux-kernel+bounces-818613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F7B593FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4269D16C893
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F9E2F90EA;
	Tue, 16 Sep 2025 10:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5NIFOps"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708B30103D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019461; cv=none; b=optBUFT1f14/69KU61nkJB582T7/bQOhBqTu05GGtxfsu4B7dgQbL4JEFvQYtAxj7hp3L2u10jGM6pLZGyhyjPoyinyvAAFP08j18LMgoA9KVDfw0ohOnFyhLPUWbVsO0b1ZpVgxdL1Io23yIWjwHnwjN9Oi1tChaQQGBiyLhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019461; c=relaxed/simple;
	bh=3gQpOrVvVs4QXfD/F2VJGGmlemBL3oZG9MO4lPULPEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmQSE5+4NkQMhEmn13AaSj7b+wAiwRiavRDAmIte5aLIkYaeFw4iCRM4B1IZaOgSdB4K37NBerX0pabL1VsWIFubANLAiQgW6XIKIuWhcYMqtZWbNtl0m3xRsauW0HeKy3wq67o0DNvp7LCLnOgSYHbFe1UVeCGzZNpTLQjfdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5NIFOps; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA8twp005613
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8wYensUaEHI256N+iplvY9UI
	jrhP2hMwlPOJQPQ6HPQ=; b=G5NIFOpshCViWqV8DwHOLnOjfM/8ROWAPMLVLCwo
	iys6HArs7KCkeXHwEvixveko/5pY3Pk/XvyDA9MNCWm5Bmi6AgZKEzgXz6EQ3uu/
	Yn5EXdSk0qIXjNObfM9MOGP2+zGdO5X4ZVm2hgepE4BFE/b/hCyOUjqFgX3W6RDy
	v2EiHb276JiZClNt4j88R0sxNxCIvbK/LBRXTaNzCCX3sMtZUCX4jPgNM7C4kAsq
	+gbu1Vna9XE+sMXpQHkI5j+ctq1mqiQtNux4nmgF2W0TEjcAPfBY+3+ZlCklnxXn
	tgsdVr8EjqAnmZR0l2YqL+XfteFcMZgi/96g6khCDczAUw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u58g4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:44:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7ad72bc9dso33199671cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758019458; x=1758624258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wYensUaEHI256N+iplvY9UIjrhP2hMwlPOJQPQ6HPQ=;
        b=WJoO9g69o8MPdXg2LoW8fa+wB7SLQ65qGkm7illfhyum63ySZ9pmtMRe7um21vTJhf
         gML7p4MOT+ERgYTX+38g6hKjXnvwieFPF8E//dU9hrGk6aLL8KnySRTXZ0syPYH97LV6
         q7+rN5n3xojWaSWEFZmDjR7Pn4NJpkIicLvFcR/etfxFNtpjEcCCn1NeJLAY8FCNbSjY
         InXdUh0RAq9e/+gT3+ZL5JUBfgMc6OAkx3T+9rKxCxSbrbtLOJDzs0SX7fSya2kNmzQi
         g4TDrSZnvi4E+zXVURysFK83Kl6BZzKFv5p0RY7fUtj4V/KVZFr4q4545b6AzQLzruYS
         lr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNgOE0ZaM5TiP5U9rClHa5WRDvknFI2MYLa3Wr3wadSF8iO0MOKV1UNPQYtxdx5TJrnhT84BrqsG0kkwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJw4WkAGrEfFv0Z5muHnvE9Nl4WpFCEeejVJvEv+ntNOBZZprS
	NRr14bUrgILBCR5VwBKvq+75NNdMbPCzap20spvrWeJDVgLNeE9Dxbv1wlZCGK9oSBrLEEw9O/g
	VIi6TmBqVy0cSO7ZG2BAdbAdhgZ8w+csHAG0LQJTTVhH6naL+by15EjDK43hBq8/5v+M=
X-Gm-Gg: ASbGncvBhnZBWjIwZDpRIqZJ2sz0Jqh13tr/tT95lvjtq6xpzOjq84HbyqUajllG+k0
	k5/muKmZsqnjaRwHhj+D/ObTwdnJmQScdv2u9wON24pMb6ZDjiCyp9L2+UbO44P7uysnOeLiCTr
	B6jGn9ZbAnbVk6JomrrLXtW+KjkoJaexIHpgWRFjGn47KshanOLqmHwAfmXIVFIU/yCJGwQ33aJ
	31CYoTK57qH8H/fLOYQ0OXSGnaagZIoGdn35SxQpsK1i0B92Znl6hlSXifkZKv/yPmpzIH7KBug
	BlW6aGzyobuBYsYccQqjoFAf66hJxTvomouPGpHi3Iqaa9TUJfgDZPRUjdEB3XSo7wrX5GSYJmS
	1yWzwIuByFZ4ldq8+Gz2kWtmMhA30yzFFWEXKM1TOJe50XMwHg8vV
X-Received: by 2002:ac8:5dcf:0:b0:4b6:2efe:2f7d with SMTP id d75a77b69052e-4b77d013581mr209416121cf.7.1758019457054;
        Tue, 16 Sep 2025 03:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH04kzVjqBUejzNfxC95RPp6/N2Ck+VgtP766oUDXmmp5pGA1xivEPfnAa+GkL6F/7JU5Q7VQ==
X-Received: by 2002:ac8:5dcf:0:b0:4b6:2efe:2f7d with SMTP id d75a77b69052e-4b77d013581mr209415821cf.7.1758019456554;
        Tue, 16 Sep 2025 03:44:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6d0e20csm3122441e87.38.2025.09.16.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:44:15 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:44:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Pet.Weng@ite.com.tw, Kenneth.Hung@ite.com.tw, treapking@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 4/5] drm/bridge: it6505: modify DP link
 training work
Message-ID: <qh4owmpgeo2fyow7zlysef6wvunzr7n2rzudomf6iuujwgb6ew@i5dj3raq72zg>
References: <20250916-fix-link-training-v3-0-0f55bfdb272a@ite.com.tw>
 <20250916-fix-link-training-v3-4-0f55bfdb272a@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-fix-link-training-v3-4-0f55bfdb272a@ite.com.tw>
X-Proofpoint-GUID: 9fA7_kB8IR1cOD-tn-03DGflv6vRUdg2
X-Proofpoint-ORIG-GUID: 9fA7_kB8IR1cOD-tn-03DGflv6vRUdg2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX0uFDv9w5+dpH
 /3+Yy7nJoyS/VqcPfI8M7tKjtJhdjRljpwfB7WvAWowzoWyhEB06yR90oS0ls1mdl2NmqumZTeE
 dlfv5zFkmyQofTKc4vhpxlSPhTWXnEN5pHUlPHScrUdxyCz01VUvalw2fuLeCspWMOC7uYNli7+
 a742Czwpf6PGg3t5iPH5bW2CAlldAaekIjf9RbWMKAMDzjMOfjWvEhQw33g9zuiANVdzM4DIHxd
 cMzE35Bnro+AhuUUTofe0iqhC3k7ohVLWRKeHxsq+Sem7AR/UMRqrflymaDF0vO9sUSq7IlYoIj
 RSejwYf7/XtF+HO1SBe2CeKJVV4dcbYAutrqI8gWSGJw4BWziCGiV+YPamnq85+Kn/rW/kJUK90
 1gOeJoRb
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c93f83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=Ns9eNvu6AAAA:8 a=EUspDBNiAAAA:8 a=lEZlqnAI4VSGq44jjTwA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

On Tue, Sep 16, 2025 at 12:47:44PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> The DP link training work include auto training and after
> auto training failed "AUTO_TRAIN_RETRY" times, it switch to
> step training mode.
> 
> It will more efficiency that finish link auto training,
> include retry, and step training in a work, rather than
> re-schedule train work when each training fail.
> 
> Drop auto_train_retry from it6505 structure,
> and it6505_dump() is remove from link trainig work,
> it takes too much time to read all register area,
> and is not necessary.

Nit: please fix your editor to wrap commit messages on a more typical
boundary (72-75-77 chars).

Otherwise:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 40 ++++++++++++++-----------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 

-- 
With best wishes
Dmitry

