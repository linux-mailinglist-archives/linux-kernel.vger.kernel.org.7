Return-Path: <linux-kernel+bounces-795883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE7B3F8EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536242054E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BAE2EA179;
	Tue,  2 Sep 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EX9CkD6U"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E62E8DFD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802548; cv=none; b=h3b2V1n6mUF/Of/hHo/BWy09MD16z3tkIG7Ux0YI7MF0u4UXDV6NBEwwLSXWBA7RefV8liiBFDsHp3CDGCRGLktygeDZv7grFr3U7jwnB5u+Z3noFGiO3/wrgaTx7HARoVrSixQvywgfd4qGmssTMntadqEE/8kE7ClpASy6ylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802548; c=relaxed/simple;
	bh=jjltSi2vMDLnrs4e472dhEfxP5CUac4nc/YQ4+WGRUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M3dhaXDBs8NVmi8WRJZ0ieQQr+i72supxfwDMQyGrfOWw3R75UjCeIstBTvaRkOW1Qytql4BVcuX8q++OnHc4ga2E/UpLT+xw+EUhFllskB6u7GOw0Ak6G7POeqJhNARIUIQxV5qRAAqQEhozeVchUd+CCNiwbFVmqbNspa6Kmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EX9CkD6U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S4ZC013475
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 08:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DVOLDMkL9Q38mnjAuWvsREiBjv7OOxlteZXJWEZg7C8=; b=EX9CkD6UBxZldHPo
	aMWSQHjiaONNc/TR3XQosLHHh3KRri7SLMuP8UMVgu6ek3Zqlnlqv/KjGZ4Zg+ki
	lr79AIn+0vGCStBrKbv0sSTB9LazsW75KWxEWFYN5jhbBTQsznn3efvSO2Turcv5
	p61aQhe6PZYBjLpFWUvhtZ1do0ClQczZOyH6zpfhssWXwuIh2/U9oCpKMs9c5H4d
	7EFrbmA3Hiwtl7H72br/s25uQ91AL8Jh2XziFjxoaXc1k3zhwNfNPifJFwneKVV3
	d/yriKVzzkaWTY6sb489mCfVLNDnc454MalnKJ8Ggstlb52Ug1QV/JU377j5SMBo
	1RL8bA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ef9f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:42:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4f8e079bc1so942973a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802545; x=1757407345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVOLDMkL9Q38mnjAuWvsREiBjv7OOxlteZXJWEZg7C8=;
        b=GcxQCne0+q0qZQN1lvImbCrzNMEX5Ua5N3CQi9xfei09dRQ6Ka9/W8pqpiWwMWFjX1
         GY+cQC7mCCP9RV6g2F4qazvx7X/M83klYfSCYyOmxtPLCzTzsp6TvccrbviCgAUJRlfH
         rZBPk5/A2xS33cM9FpvZpnanEgyczDq0E9D0yBQu+MOSrJau/n6+KrT+rnfB5vEIucfH
         QJRqeXSYLwr/zZaCGIZK+UAnYf8RUrVboFemm9XVtyEVz6hPhIzIdDZPUsYskDrYpZss
         nUq0rcAGdeVT6QfwVfGzD83qwnzaQzt0fSG5CESmuSiHwunWz27BR+cf2K4CBLF973Gl
         gRVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCR/hg+qs7SYp2FKYyi2h3r0WvuGRUEbOD20MPEoeyt3FePP2EYXnN992K7Y9jjvNnwCO/1crMCR9Ry54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQs0T3vJQbhK6stwn6NLsLe97o9kU0QC6nuB0Y9Uhk1hEfWQkZ
	iW61WktrRcazLxlRf1h8MS/pGJaR18aXMqJcga7SOhE3tDmlsxmaNQRV/1aguYK1Pr7HpqL2RDR
	ERMIo8rfoous3PLH5lR+WPRn1hoCVT62tyQ4o1Fq8IIeaMh0FKtwCnmfeOv9Kk9Zo/2I=
X-Gm-Gg: ASbGncuMycdK/Hbny/BIHx77r8N0nD41uqhcMDNrb/Azr1AYNLidsAtU45dwPYnMRJt
	0Bd9L3kzu7ElO1kH3bna3N9qKL67TguopXYBGDsDbPMO1a39MNnG9MeW4l31mkH1pnoOkZ6m4ov
	8rXoiEhyM2KavEbZ7/+e5afZmQDGb6OgH+GtvEqi40C4CvmImC6OyxOgLaXMyfQe81blynyC3ch
	8MLRhyJy38KBa7H9W2OdhZELE0ySyaAPffMyNmyg+OxJalaZaQnDEDoYj7faTEXQaQJ2QA0HZEV
	SyFB2Zfl+pG29lmoSZ0gzEXKY8U6lqj82zB7AE2pjrVVQuKmc2/kI5abwnU6mXMoRoXxGUsdX6s
	ugsdIEmjINo4Vwi5vZFH8wIaC2plCQg==
X-Received: by 2002:a05:6a20:3ca1:b0:240:af8:176d with SMTP id adf61e73a8af0-243d6e0624fmr15800442637.24.1756802544547;
        Tue, 02 Sep 2025 01:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkZmtURUQXjUEaZAkZwa5KRLpMqM9mF0V2Pb31KG4aIt0jLndUPkUWRig5iFl5PBDxItRWsA==
X-Received: by 2002:a05:6a20:3ca1:b0:240:af8:176d with SMTP id adf61e73a8af0-243d6e0624fmr15800404637.24.1756802544055;
        Tue, 02 Sep 2025 01:42:24 -0700 (PDT)
Received: from [10.133.33.25] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4d96829a66sm9992321a12.6.2025.09.02.01.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:42:23 -0700 (PDT)
Message-ID: <5b142910-81e7-462d-8933-70705334ef0a@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 16:42:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/38] drm/msm/dp: remove cached drm_edid from panel
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
 <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mpSyEDNjFQxnchA5TAqmE7JrZDAfxECN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX/260rV4LxCY6
 RayJllP5O4YibGiCnNO3v/vdIE1Ad0zhmYZTzxKrGf+P4FVTeENyej4kTW8adCk8him1ixdAADo
 zresxQuNIK/7lM0lqJASSdZ2OYu2yxYFiSPZrR9zJeKEhG06z6qJgyMlIH7l8HDzwCa2HW/3Vok
 roH+NUKjwAOXh5GwHPO3RLgoxM7+D0pkRv5XfQyCXYU31WdU4GEKZ/V014oLgrg/i/ER+HPFNCj
 Xe5BXxCxOSfi+QFkAENhzSL7mi7VtjzYCrTsZJJhzujxg5BTD4bwDUKBbQwFfNY8wCkmy3IGDUO
 cWPMNPkbyhEwOWZQO/EYdAziTXvg7LfPz5Op0TmeK0bTNvxnoWUqTamRN9/2P1e5v0Rdv+p/8wt
 BBN2qRRY
X-Proofpoint-ORIG-GUID: mpSyEDNjFQxnchA5TAqmE7JrZDAfxECN
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b6adf1 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UzQ1Ta3AV69qgWW9qvUA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004



On 8/26/2025 12:41 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 25, 2025 at 10:15:47PM +0800, Yongxing Mou wrote:
>> The cached drm_edid in msm_dp_panel was redundant and led to unnecessary
>> state management complexity. This change removes the drm_edid member from
> 
> Please see Documentation/process/submitting-patches.rst on how to write
> commit messages. Please use imperative language instead of describing
> the changes.
> 
> THe patch LGTM.
> 
Thanks, will update it in next version. Since the HPD refactor series 
are unlikely to be merged soon. Can I separate out some patches from the 
MST series that don't have dependencies and send them individually to 
make it get applied? This would help reduce the number of the MST series.

>> the panel structure and refactors related functions to use locally read
>> EDID data instead.
>>
>> - Replaces msm_dp_panel_read_sink_caps() with msm_dp_panel_read_link_caps()
>> - Updates msm_dp_panel_handle_sink_request() to accept drm_edid as input
>> - Removes msm_dp_panel_get_modes() and drm_edid caching logic
>> - Cleans up unused drm_edid_free() calls
>>
>> This simplifies EDID handling and avoids stale data issues.
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++-------
>>   drivers/gpu/drm/msm/dp/dp_panel.c   | 47 ++++---------------------------------
>>   drivers/gpu/drm/msm/dp/dp_panel.h   |  9 +++----
>>   3 files changed, 26 insertions(+), 58 deletions(-)
>>
> 



