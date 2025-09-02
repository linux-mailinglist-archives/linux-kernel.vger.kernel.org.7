Return-Path: <linux-kernel+bounces-796525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066BFB40208
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1BF1651B3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8370F2FAC19;
	Tue,  2 Sep 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVk0WkuS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531942C11D4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818130; cv=none; b=QMMYNgaa+5QdtcABdCFAmSITMdkn4Ihc15qTdzjNbq9G7qrsrvXwsgU84mVv18CJlQoHcdD8SKiy8CmZRuQtSiuFi8GQaTPSn5gSR+RMR74MW5NDTgzk3s0Zzzz3XCyNZYAs0H3mNjHmbemv/bmaBNKM2OZ6tE9SBR9w6FL1Ke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818130; c=relaxed/simple;
	bh=3kmKkZjwyDSpW+F20e7OaMntgz7HZHV/pwjTc9DqUwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hk0fYTPkTDqeHzkKrHkNm4fIab7bhAKKgvvi0E4dRd+hMhlzENIm7gbRH0o+4qnzvxBMP2LKW/Ttt6BTlCmBdB33hoffP/0ioq6gaeZzqWbdB3UnKnr4/Ymmp6AQwzZBAM33DSdmdPpJM3zfZKrCumj+JPIidR8UrqvyNRalsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVk0WkuS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Aiqh2016289
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 13:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DI3pErojxmIjWUczxGnCciKc
	RSBlU9zv3W60qXm0b74=; b=oVk0WkuS9zYpad0XHNNdHabJFeXiPvZUPFdKCJO6
	HMdDXTUACzAEeFOb8gY0swD57tVFGIuhD6oKhMewG4dZB3ImivQ4Ha26EEwrl6AC
	590Zo/KrpPYQBQUc/3Q2ZYrVXCxpHawyi8QepRySbRTKeyp4AHX2bxGHnYAHA+jn
	4kru5a3dBtY97MJ967fzFVD+uWkS4kCjgFIc9IP4/wGMjGypufD4sRaXohBd9wa2
	to2ujfqfFyZb9cwEqcHJApvcd9YrFnBb3Bp41Rs5kqxWi14XHCxB4C+gPlHrHmfp
	EiWbz/xvTDhZkn6oyKOROSjFfXzDTCM08i7Rw8O8UigtjA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urvyyujn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 13:02:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e60221fso8878412b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756818127; x=1757422927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI3pErojxmIjWUczxGnCciKcRSBlU9zv3W60qXm0b74=;
        b=OofqEUvvkBTAZEtVawbvLC0obY30IYTscB2QT5DOJlb4NN802+C66qhz4UmYYkt7Nx
         FKheAq/vbQba72iTI0L/DhlFjJOnvFtzC5XNdcmEQnVvQYFxjQ6K9PY3G4fgMsSC8I+/
         8YftuMKTrgLuclMP0EthfVhSfOweu0xZ9ObrkM/B8eHQIsohYscPmmD8ZoTDnWHqEELD
         zAx/MpY7Cng+yMIKQI0kyhihdB6wmbM0VObdhr2QV3FuDDLcpHAGB4FgXroLqzaP5OKN
         nL/rdJgCPHHzzGWhpAggnh+KeKH4m9xwAJaDbHo5YmCAYR65oi+0bpwGbpkjoY2vcGGO
         fCgw==
X-Forwarded-Encrypted: i=1; AJvYcCWsAovHxVssTwQHe3mklEFo/81o/SwLIrkbUq2XsPRK7k7Lt6Aa4pnJaqmDjwnVLLiwCAsbzUTXfktF4Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDacZce9rv5p8hiLp9oIHtv8/+EQOE9TeDeqjpze9+bT5VmB0A
	d6bdWgIZri1bwjyHuH4SG/oUvUsbQVr9YcHkM2o3o0qoRaNGTAxdGXlPJcrmd3SP0riQmFA6UMA
	yFAicIcdOoqLHSkEGQIF+mvi0C/IJFN4ZcJEh8P4PKeEFAvOZtuf7g1L9PFhg95oRTEg=
X-Gm-Gg: ASbGncuwQdcMh3r2cI0icsx6leubEtupPf6FClPVtSFd/UH+bo19BYBjobTLQFxlypM
	/p50RJ5MMLwQKPkO+E04NAqdwKo56OKpRNC++hMJw8ezZFHh3qRQpJ75Hqp0FNiQY4bylyqG15V
	qxJrKw8iCgmuYWGfRu2aNZU4UHelQqGUZcEncOYAHZvXUw6Cyd/2mzPpvVGCoTJzT8D+SLZoNxw
	cvlJ8KwM+pAJJgCNMSAEry4c2LnHQs2/Vm+7eT2wBFYApkOqkcdlFES0Tb0O1Go5Yj+8cQn32S6
	ISR+QpDJ+16CMT1hdCFLzOkasBgxVI4afnmJ+nr7RzWSxqswMyatS+5AG78azfXhbUSGJ4fT9As
	fO8LGdfgWw6XnVOBLlHMu3u7SH9IZMADr1G9tBUV/M3RgfnRPDhLa
X-Received: by 2002:a05:6a20:2446:b0:23d:d9dd:8e4f with SMTP id adf61e73a8af0-243d6f02e27mr13224777637.28.1756818125505;
        Tue, 02 Sep 2025 06:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr2WgYJlX68yywgyWjPUXsRjYvXEYtyzFO9iJAKUUUIjy9ijeStIweH2qG+cpUesIk7rFkhA==
X-Received: by 2002:a05:6a20:2446:b0:23d:d9dd:8e4f with SMTP id adf61e73a8af0-243d6f02e27mr13224650637.28.1756818124529;
        Tue, 02 Sep 2025 06:02:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827901eesm672660e87.78.2025.09.02.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 06:02:03 -0700 (PDT)
Date: Tue, 2 Sep 2025 16:02:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] drm/msm/adreno: Add a modparam to skip GPU
Message-ID: <zmaphb3douzah5m447naluu7cjrwieb36uznjb7uamblxduira@xhtklqmy22tu>
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-3-f3ec9baed513@oss.qualcomm.com>
 <a701e4f9-57b7-46cc-b42f-f1a4a902fbbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a701e4f9-57b7-46cc-b42f-f1a4a902fbbb@oss.qualcomm.com>
X-Proofpoint-GUID: XhUPp5Sd5h5-ug8zHkBIHCPuQ1Knr8rk
X-Proofpoint-ORIG-GUID: XhUPp5Sd5h5-ug8zHkBIHCPuQ1Knr8rk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfXwsXQTaFijI0v
 vM9sfK4egY1vZaMnrQ51XTTsUjb4z8L+yuKfThaBLtXNSvilufpL8dPGMJ7Ve1oa3JJu/NPqTGC
 R06m5SNEFFyE4iIbJQ5nxO1eRoq4jxN/BtwKDXSnVYdnbqtrwdW+XGDhDiEdmaLDquW0z38HDJL
 bIBKKz+9vRjfOycJDPQgbr6E0eLk+8+D2Zn6HfrnldPl+zvXPz/4T+PkblI4tebTPDXU10hLFvX
 xEhSN6N/sq40Y21fVbg1hW9jEDD00Hflkl7neHQ4hZnAo9BxTX4pmunk7vCVqVgR2McGWAXgc06
 nYyhBPSDkxMTLQBpORYMzO+7GvBIUY2VEvtzLN0ouInRIFmoNY+5Q+OBl1P2vaNJNalTwAD8gvI
 SAhfmNIT
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68b6ead0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=PxnZWOFFpC0IAZjruz4A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On Tue, Sep 02, 2025 at 02:30:48PM +0200, Konrad Dybcio wrote:
> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
> > During bringup of a new GPU support, it is convenient to have knob to
> > quickly disable GPU, but keep the display support. This helps to
> > fallback to 'kms_swrast' in case of bootup issues due to GPU. Add a
> > modparam to support this.
> 
> I'm not entirely opposed, but slapping a // in front of the compatible
> in the dt works just as well

Which requires rebuilding and reprovisioning

> 
> Konrad

-- 
With best wishes
Dmitry

