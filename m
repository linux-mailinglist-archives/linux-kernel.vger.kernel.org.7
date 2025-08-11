Return-Path: <linux-kernel+bounces-762905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C95DB20C25
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB63A2C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B322D3750;
	Mon, 11 Aug 2025 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/aRL8Ut"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F854286A1
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754922787; cv=none; b=hyE0y2qbdTFmhvjuWnE0wjfYGOD4vee4m6D3+CMatmroe5iwGupXuXtWYaeenv9oAKSdDJNEZ5SZ1q69tNK96BNZn/O6IeYtXodtaWQdsNfiFwifY5WpQ1Pt4nq40ZEOLnPkuqxU+ifDXmMMPnsNQ67jmh6EPaCZYKe4dLk6TYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754922787; c=relaxed/simple;
	bh=MMoSzv/Ppnp+PyjyWrFH8yUcQP0luZYiajrhmfSLHvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4ORyJ1PnQIz/QNWT5N9lF+gnEVAI03Tqxhim/RWhQG8Jp3Kumfa2ISjPAwLLxGzgl6HoHYWOnwUPokkXk97ri3X0Rh+y1x9zvVxkfUdozexgJJw0BOmvPe+/ezV+In+mbkOpHmvEQD/y87e7Sl/TgoH535MltZ7/Kg1fUII0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/aRL8Ut; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d9Uj019056
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=pIAf63LpCjEtK5+tOINf5iV8
	E0OgSuQPvRRqn5n3Od0=; b=N/aRL8Ut0L1wO922JSGqfkMJ0xq6k7FAE12fivHe
	BJB3Vuk7T4YmdMRPu1GBZCSpk3KJmfex08yv08v/7EANYIN6s5sKuBeYPeTZNxDa
	ZI0EYA790Lflx4kSJy+BVBbn3gxq8ma8O5p1k8ldJNxG8wyvJlZp3fN2QlWLrFDK
	ybpXp4ZSnCoclOmLvJJx2DYtmPzTFSvz/MlK49EvDjulerh6bPj2HOqtVf+30M3c
	yJu/takpCQOvpw1EWvxuCxJT9GYyV+104z4XQAzdJQjJzWigzLRyfQJdbeWklECs
	JwtnRzJeESHUiXUcVABoq0wFUtPrUbcMOik4grkU/z2+IA==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduvr17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:33:04 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6114c90e664so207250eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754922784; x=1755527584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIAf63LpCjEtK5+tOINf5iV8E0OgSuQPvRRqn5n3Od0=;
        b=KP/9qlZGJHdu0CbAEpAerL5dB6v//2iuOsZ3KN2LEM7G5oFqxGpLtu2300ZYYelURM
         D8wGei/EQGTiPzbnblEA0+fgNi38WygRF85kskug+Wc8+8k8x4MbFPiOxzaafLpfZibV
         NQJ3/j1508vsIDwlCURPkA4aZ9ub4tccFJapuqZfp8qP6LyLydiyHDjsSuWvc4NvAwji
         IVBLfqyBctxTya9nYhpi6AIbahTxRmNOn8FTa2Kiqhk1rx99trdTJfACvNmSTajalsJi
         WQTi3zmV9/gJ7THLK/wWIWQ1dtAcYV6xwACOwIsF681ncyY8CWegwn4C8VJk4NBGDUIi
         CGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrxNua3we5SDEO+g/U8uPsj6Je0ntaXT1AXV/3xNKBnOkTIiLbDiuSK+IP0xoL3VghcwjhxMaEw+ie5zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlN2CjX0ElSVOIsdRkA2a4ZXq1lsAVMXYt8JcoUw9IbZFHq5U
	q6fkwBTSAf9HJx054YdfKIl+hD85ZaEz/cXtBfsAnH/if+B6XZPFzwZpJatWnzpxXYcKP2xmnkf
	CF4kN3/ExrDT+EjMRK79AyO7Bw7IxTN54uMp9kkqjq//oD4VD7ir0pV33xZP3q87ATWg=
X-Gm-Gg: ASbGncte4qsrCNLsAXlamNIBtbOsMPpsgkxJMw4B3/ARqIS1HOkIdL2ZLEZK0EIsdaT
	xMMYa/Fib0jpqEXoQlQA4nXy+9myznntmxlmoEUW+qSaJQS3Wa6W0scHCF2YoQK8FCXL24jzbmE
	r3riSmi7pCC6fnOJzBqkzdjFDoz4NQS/63TwXgCxRLHVPGkolc03hyEG0mEswTzWBBPnSg60CxW
	Ru1aHKwOTAAmcCeS+7dnBNuM8TXmW0rV3b0DeUweB3w57FWwGIJajcNJRfC1xoapLEiVFyyK5wO
	Tyx2qtiJKiaz2Izu0yqwd46CS0fRLZ5kVEhl6B46PfXVkmVMA669lX1NGubNFv+7NYAF8kGz55m
	EHXbiWig5poqajTUawCvhoLI8uLucvZsvPntLlGWGDP8buuZjKJGb
X-Received: by 2002:a05:6830:34a8:b0:73c:d14a:cb0 with SMTP id 46e09a7af769-74366934d7cmr38908a34.6.1754922783916;
        Mon, 11 Aug 2025 07:33:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeSjeed3j/kib/Z3P1RZJqE31ka97P3s6ayDf+50Yn9aD74UuHxmWDqa8+pHyEyFQkASbDRQ==
X-Received: by 2002:a05:6830:34a8:b0:73c:d14a:cb0 with SMTP id 46e09a7af769-74366934d7cmr38886a34.6.1754922783398;
        Mon, 11 Aug 2025 07:33:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bfa4sm4383837e87.21.2025.08.11.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:33:02 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:33:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] arm64: dts: qcom: sm8750-mtp: Add WiFi and
 Bluetooth
Message-ID: <k7mw7rj7cno3con2t57nps23y7evd3da6gahyl5gnrxss7e3s4@qncnuekxr7lb>
References: <20250811131055.154233-2-krzysztof.kozlowski@linaro.org>
 <l6u4y3suv3dpylexbiiznhcuyanlc4ouizhzj2cchblaf6o4wg@fe4laxrioaj5>
 <481985cb-fa84-4b09-9b95-948ee70b557a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <481985cb-fa84-4b09-9b95-948ee70b557a@linaro.org>
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899ff20 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=LhWZ5_tqvYJhwomtTMIA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-ORIG-GUID: mntTBTSe0CWtNtjpFGzl7hYF7GbUA90A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXwzb6ofuecnGA
 u5o4C8ufUirhw0Bh6cAHqeVqtJ1feA2sQmju2gTC+OBZ1RPEBtjmybTdZzmW8OpXS2hOfdOahKk
 oSEGJkABsG0n08sBwd+6+mJEtZ/tpfbXjZ9Lu2Xw2oDWsUKEOV7WKQ3Ovrn0DyJXMRQNg5Hm88I
 mqJ8E6pgU07hJRsL5HBwgwCLfbe/67+X3nvsG9rcl70RJTtRnAKdKG9/XlO37BlMS6D8U7vZddV
 +39Vc7J0Pmh52AzXVd4beEFHhYCZltFIz/ms9T/KsY6L57rBPKE5WMTZGEaMqVeOap6Z/f96YnX
 /GSDwteFc/JROVwzWr+vMvZpYCUvTKvqhx8ZL0mzhLc+ORJ6V+MbeOmZPW5Ra5gt8RF4DSLB04A
 QT5tVcvc
X-Proofpoint-GUID: mntTBTSe0CWtNtjpFGzl7hYF7GbUA90A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On Mon, Aug 11, 2025 at 04:25:47PM +0200, Krzysztof Kozlowski wrote:
> On 11/08/2025 16:22, Dmitry Baryshkov wrote:
> > On Mon, Aug 11, 2025 at 03:10:56PM +0200, Krzysztof Kozlowski wrote:
> >> MTP8750 rev 2.0 (power grid v8) boards come as two different variants
> >> with different WiFi chips: WCN7850 and WCN786x.  WCN7850 is already
> >> supported by the kernel, but WCN786x is not.  Both of the board variants
> >> are considered newest revisions and the difference is only in MCN
> >> numbers and internal codenames.
> > 
> > Are they soldered on board, installed via add-on cards or installed via
> > M.2 slot?
> 
> This is MTP, so same answer as other MTPs - these are replaceable parts,
> just like you can replace display or modem.
> 
> > 
> > Are they going to be somewhat compatible (e.g. on the BT side?)
> 
> No clue, you need to ask Qualcomm people - it's their hardware.

And you (hopefully) have access to the docs.

-- 
With best wishes
Dmitry

