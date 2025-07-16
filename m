Return-Path: <linux-kernel+bounces-733841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71949B079B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B08163515
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2496C2F4304;
	Wed, 16 Jul 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dSSaVcie"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E78262FD0
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679375; cv=none; b=d+Q6AiU8cVWx9a68EUT+OOJdpKU4bG8BD7WOkqc9tZDnewNN5OdHYt5u2y8agshm37mHjI/yC6jd78exkXZUl5c+KxpvtcImioPtLg5mjItAv9/sPo3eUFtgP6egoQSZNlybQJM72qy7QDQdaV6+NzSido6U9ZZl3Hp4O48HZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679375; c=relaxed/simple;
	bh=VhG9AzSZ94L0m4yTcIbjiip59GubrfIHNlb2iIofRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIFOO/BSWLn/CeW+EwAsI7SFLrgswxBwccsMH39OW12BFgLBI2v+HcvnVaEynPMJc+9h20F3Nfgi+k02eLqMbOl5JEL6aMK6btm3riWzy2YKyJu9tGcCkUW+yPKJYhOjQADJWtIyjxEoRqmo49Iw854bkoqToowGUBvWrTzaqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dSSaVcie; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GDCYQ5024488
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7RAbCb/hRdSzkV6VU4Ax2LJC
	ptbH3p1ObvUqjOpfe8Y=; b=dSSaVcieCjTUNUNkpJkqtkVSk94E/cFHICoovQwx
	gE/VzGj7JdERa2teTygJdcYjeCshwZOaR+43jwaTE3Lxl7CNsQ9KLYCF0zt/gtbm
	kpHsVVHEPRX7u1cV8UGxq2A/00PrSr7utW6CPekzYydJGjX7youv1Smy3nlEEPoC
	S8i7kEVF4IZmjeiUChnP4desk4Rairw59m2EJsZgvOnaDhZ/t3M9e0FW2AS9MxTb
	RuxGTjBMhgd1qwLAdkhuRp6FC2p8yLJKaxaB67w+UDZEIkTUq10lSFO1fFax7bV9
	Dds7L6oKZMrOcwir0B04LOtxcMyG+dVZVM/O2bwL+ELtSw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpfegn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:22:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e2c8137662so589765885a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679372; x=1753284172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RAbCb/hRdSzkV6VU4Ax2LJCptbH3p1ObvUqjOpfe8Y=;
        b=igvGNW0W210wkCRwoSAWFykR1O+GVzAYtsw56vpB+FCInjDAKKASBLMU0kYyS1dmcu
         fp753bbBpM30Q1qTzDsoPVtMrOwgx2+LxUdMkEeR1NPm6PxpoUAhqd3RQaTo+3t96F2D
         0c4Rbh9XLi0NvjP+c/TBEzyV8j3zCK7WO3WiSRV2l9RFow+Tbfk4S9upN+ryFbQF13W+
         4MKJjsi92IIcEHqkACfv++956QsH6d6js4cjsrpaHnQLfmHTCrgJpIPvenkwgTj35Qgs
         V82GlYMLhtL7GW8jj/IyVKJZdmMAwcZpAdrRtU0DmOajxrc+dTWxe+ZNhEIu0zmwlRXV
         ccKw==
X-Forwarded-Encrypted: i=1; AJvYcCXMb3f+aRuc6JVpCQ/0rBn5EaDqbso/92kMYuJXbimPOkleBOiTW+fyUtE3obpTVG8gPiGdK+m4KlZK6/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8SLHBTprolwKLAifWpL5Jq4CxYV23Kah5IBED9R7otSl6Ls8
	zCtmwZLCdy2btmugIsdOXSJOclH05QUirxJTd2esX0Pw5HvwSD2cnT37L2z+L+QJ4AjTvPAPcBd
	9nmATCTxwzEcwUTFlWv3uK8eR+lLNxT3t/eA20rMr+XAamUqMUblYRNXUact47ZQuso8=
X-Gm-Gg: ASbGncv9iFuo/8QFqAyMsGxGvF/oXwyAm5UuSypDgcKyRddCmH74YWbhzxsRikV4xTz
	4xiW8vvE1uatyPkfJaCKjvUPhU42Rg9jjQya1uW8XRKR9ew1iELUBV4xpsM1WK+wOG/Bu5lr0KZ
	2ABw1VsuiYPxxUOITr+d9jvNHfqjgxst+puFhjl0jsDYBz8kwrX95S4z7ml+8FMfoTujxD3qDSF
	Ej5JCG8zqevBLJbuS58XcVJA2uy/w2XTib7lSkHQKGhFhADt6Tzz3IQ3A7VvnbD742pd6vraAEd
	5NXUlBPjL9pBBv1IUup4VoWr2plM13NaPdNbMOUnCqQhteKywoXMTmTaRCz/SYwsszZS9FChYJQ
	9yhMRBuuUz9THQa2PRQoizsBtFt18jrt27s+obSwA2OjjBRos/J66
X-Received: by 2002:a05:620a:178d:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7e343643fc7mr486070885a.54.1752679371701;
        Wed, 16 Jul 2025 08:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGENloaWvoY9ZjMi7UqKHYublujFbYKx4L5NxmeqRfowsOVGfz002Oq2YrzRud/wdh7lvrpMw==
X-Received: by 2002:a05:620a:178d:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7e343643fc7mr486061885a.54.1752679370921;
        Wed, 16 Jul 2025 08:22:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d086bsm2710587e87.139.2025.07.16.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:49 -0700 (PDT)
Date: Wed, 16 Jul 2025 18:22:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 00/28] interconnect: qcom: icc-rpmh: use
 NULL-terminated arrays and drop static IDs
Message-ID: <k4zbxmhgcphpsmyjtvobmjcogblanvvujyxqdalx4melhiqahb@rup7xg2mb736>
References: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rework-icc-v2-0-875fac996ef5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzOCBTYWx0ZWRfX40JSZcjQT8Jj
 3T5/oVslv67sjqI3b6hMs3RpVQ0jiHQ/MjMkQThhZXOfLHVgo87lHgcXgIb0UaHMa4c05xqDxcw
 bb7hlwsXgnAvVLSDn5IIaEpRMMOIxmj+gNTzRrTNEOCFNZT25jfYtSn8mPxhpFNDLTKdWVs4Lwy
 g0gOnvmymAhrwfIzFS5aHA/fWnioYfvd3p5Qw7hllvwMm+n+LJNUXrId1h9/QhFxi1Zy/uPAq5J
 R1XJKA42MlZ/gRT1b9o3l5LKxUIduh4aJcNYq7PT6AHUQDdda0XftfhIv2vu4AHEyIq5tDEksRQ
 AvIn+CWf2EV9qXgSys9t9pZSoMhpwm2/92SLq3qmuuAFwc/AGgf1BKaum7EbZ72VFpGLLwm4Slh
 QxzLXv4NDJM5j0DyjiV64fQWtWU9AHAQUX018TK1zjae1KQ4iHnP3A3b6ZDYG3Zpqj9xEA2A
X-Proofpoint-GUID: KSimCQvQgg8yPvo6FGfrCmstWWRCjN1m
X-Proofpoint-ORIG-GUID: KSimCQvQgg8yPvo6FGfrCmstWWRCjN1m
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6877c3cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Zi2BZlG-iNg0ZsKB5K0A:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=640 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160138

On Fri, Jul 04, 2025 at 07:35:12PM +0300, Dmitry Baryshkov wrote:
> Qualcomm interconnect code has been using .num_foo fields together with
> the arrays embedded in the structure, which results in hard-to-notice
> mistakes if .num_foo gets omitted or incorrect.
> 
> Rework RPMh interconnect code to use NULL-terminated arrays for the
> dynamic IDs case (as now all the arrays contain only pointers) and,
> while we are at it, rework all the drivers to use dynamic IDs and drop
> static IDs code.
> 
> This series touches only RPMh interconnect drivers. Corresponding series
> for RPM drivers will follow up shortly.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rebased on linux-next, dropping applied dependency
> - Link to v1: https://lore.kernel.org/r/20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com
> 

Georgi, gracious ping.

-- 
With best wishes
Dmitry

