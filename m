Return-Path: <linux-kernel+bounces-798164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974B5B41A32
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EF7B1121
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A90F2EC088;
	Wed,  3 Sep 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsQoZwdU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923C71D432D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892164; cv=none; b=Hfcb5N0LzBhkv9s0fUI3OhoiJfWytrKbUQW6HeLMHYJIOK2lUu7Bzv1H16N2wguOtJMwvijgr0ZuzcH/ZpBXkju3wwCH65OidGtv1+o7L0gvI3f7TXw43KmtmM9Com070jiXkBaB8vDFWUckL5tUeuTgjuvD6gLJBp+vaG9Z+hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892164; c=relaxed/simple;
	bh=OJN1kckVzL5kTW8Z8v+NbbA8S1FdVa0vxS0nn8VvgoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHhxD5bRwKHkpaYaREr2OKSMPw7HGGyOBuvgC8t2elqiQWfCxnrBQSmbma9vvPJzg2bfv9SL8i1Fgm19d8aA9HKYaoNzgnmT/Gm8lWY0Op8sTRglS825ClCTM0mRJ6deOuB780diApCnFBqCS0lTtXetbW2aa/aZHrKq//v90y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsQoZwdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5831xltP012685
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 09:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vSerlDJpxvfSadnBQ8QnDpTg
	YM6Q1KNBUaEKDfGqWbs=; b=UsQoZwdUapKoi6LnOo0SvJ8QMQCSFB4ulL1jZemo
	tP37+zgMx8Qeu8cV8rZvtJHoao4gHv+iZkAkGPF4XoSq+zTsG58FAkH31LnWC/Jx
	cmEtdiaPd78FUUhKDe0zjT9Wu8lE6f+AYIVMvge5i04FSJUqNMu+ptgfaD925loV
	RoWPad3TPZewXw4RHTjDdnAtVlv22ltQIYBYGgfrWhvUVPQy272YqsXIvnNHGrVL
	p3utT1gxYNBL+fEKtH4jJbZtNO9y0zYb0zyCWIe3lzV6MhGtd1+Ilxb/5FW6uQ+c
	FpYQabteem1iWJAxECYcd4IzYNxycDC5UK88myah5tFJ+A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk92ukn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 09:36:02 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-721094e78e5so17529056d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 02:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756892161; x=1757496961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSerlDJpxvfSadnBQ8QnDpTgYM6Q1KNBUaEKDfGqWbs=;
        b=nsiaWqb67Y8Q6ZBU4Cb8vVt/e7ZpjnxKMwpd5fWIKVM0/PtVmqsSONZc1fHkJaCDLq
         20uqFrbKTNinoPAyqAikEfUIGra+bl5I32eEmEFeqRDschwbxKzGp7l9+xctfUYU9tKK
         A/NSLOszxwkHNUBJOkeLzFHaBxlmc70kUt8n3E1YwCgTcTtKHjbLCgcbxdB4srdMMkWr
         AYOabrHjw97ck116DxRBqRawqiY2D+bOQUGy/17kAz2+KECJvykiv1LDYEmtIDIXOYZ5
         hoHucR86XP/x9SN4R/XC3B5q/sM8UKoDgVj4+/5p9tyvzqLaWoIwRXbrU2UKSLv8JOEq
         Jdtw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3h6BkBRHGCjJbqpbKcBx/1adyr2z85aIcZRK6obiTupPNfLpZqqtBkjr00ZSeLJRx86I7MMzo8BY66A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeckz+4f91FXJFBS6kAWiO3nVNsdVy1bL71y+E0i3Xqm28bd1
	7QUO4mJwvpKIsyyAnPEpARu1TQn39NV1oSldrnd6kqrBi5MnPrYm8TmmlQIkx9l0hHePyPZwwwl
	b6BSp4wkPGbKXYAQWxntcsP0C2kvOilBqHli5kUZvYpF+bj3RcGtzkRkyaywqwBPK0NA=
X-Gm-Gg: ASbGncsPCxPy5rvfT8K2/AjOCc6DYt1AdNZkj3fHJZBjEN+z+7ya77cGo/eAZp+ug6t
	Htbq+KAulF63P5j4idkA4CMIAYLpTeZ6Kjum5VbrjQo0U0Ad+5dqyFk/BqTahYlHLY8NCp3mN3t
	bMkJrvh2C5ndd++sm9EoNl6wOzcNfzTgyjQtzf7XbYpAlU4KwrdQFouhV4VL8jElbc8trknfWHy
	XpcIjllyb8etSfxV/Oumn7rT8xUfuhoSDDjp7rADO0vRBIZYLWVvMM7yq0ONdWaehC+RlYmBYgk
	OPT7OgVic1XENrtRI2+yWgdv9j+JkCu5LyW8XQHy3DrMbUQMbw/dJWWIhOvvb94udbDpfuC40cH
	17gbmxqGEilvoH0vxJzIx+knklsCvJEdoie+Njt15IYB076d8LHOZ
X-Received: by 2002:a05:6214:1d29:b0:71a:5b14:3caf with SMTP id 6a1803df08f44-71a5b143f14mr94106756d6.42.1756892161131;
        Wed, 03 Sep 2025 02:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqgDTlX6V0CHb7DNRDOoeNqxg6UWnd6OmRx0Se3MK3/xtEY2lCzdiwyL/yLPFBz7pz69sN1g==
X-Received: by 2002:a05:6214:1d29:b0:71a:5b14:3caf with SMTP id 6a1803df08f44-71a5b143f14mr94106496d6.42.1756892160620;
        Wed, 03 Sep 2025 02:36:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c503d7sm9027131fa.11.2025.09.03.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:35:59 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:35:57 +0300
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
Message-ID: <oeecjgt43z3pgt7eaxat32vk4sch2h7hp3ibpvvw2cb2mognyx@ft73uzdyiq56>
References: <20250902-assorted-sept-1-v1-0-f3ec9baed513@oss.qualcomm.com>
 <20250902-assorted-sept-1-v1-3-f3ec9baed513@oss.qualcomm.com>
 <a701e4f9-57b7-46cc-b42f-f1a4a902fbbb@oss.qualcomm.com>
 <zmaphb3douzah5m447naluu7cjrwieb36uznjb7uamblxduira@xhtklqmy22tu>
 <b7a1b89b-54dd-4d02-afcd-0144df5a6d57@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7a1b89b-54dd-4d02-afcd-0144df5a6d57@oss.qualcomm.com>
X-Proofpoint-GUID: rUIDt6NWJGMvTOGErace86vovR0hMSE9
X-Proofpoint-ORIG-GUID: rUIDt6NWJGMvTOGErace86vovR0hMSE9
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b80c02 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=TuRy5nDU7s93I7UbW5wA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX+8xdCxN8gq79
 KZHZrkqcwWEF5N1vjujbut1HqNXE2KqmQthR3jn3DKOFnF6SX1WVZ4J0emtSn8Wefkh7Rj9aThl
 m2wbYFN4y8XiVTw9WiKOFPF4BehVqEVM2uEC71QJDiRopQhxt/yiZnG1ZF4OIf5RXmCCpEALx2E
 HQVnkYV4ar2xSdQKg4VOX/2qU+EJg6lt+eQQazQCc1/AfAQ8OL4UrpH0BY2wZBcQH7dks3AKgza
 ihBdduQoyB5wT24lRjaYgW3UWtBc2Xe9bD+9A6L8nBSykk1Sh+fYW/bjgvLsTBKW9XROlHyMpyE
 WNYZ3din8Y9Eaeags3yNAjjKrI3mhdaaB1Iwhoh3rSM79xzDflG5zor/rzwenrQj4m+2JNM1ZCT
 I/OgeM/n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

On Wed, Sep 03, 2025 at 11:25:49AM +0200, Konrad Dybcio wrote:
> On 9/2/25 3:02 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 02, 2025 at 02:30:48PM +0200, Konrad Dybcio wrote:
> >> On 9/2/25 1:50 PM, Akhil P Oommen wrote:
> >>> During bringup of a new GPU support, it is convenient to have knob to
> >>> quickly disable GPU, but keep the display support. This helps to
> >>> fallback to 'kms_swrast' in case of bootup issues due to GPU. Add a
> >>> modparam to support this.
> >>
> >> I'm not entirely opposed, but slapping a // in front of the compatible
> >> in the dt works just as well
> > 
> > Which requires rebuilding and reprovisioning
> 
> Fair

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

