Return-Path: <linux-kernel+bounces-823824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F7B87857
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F3817ADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FA1DF24F;
	Fri, 19 Sep 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XbwM6KZO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10001C1F05
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242523; cv=none; b=BsYg1irImh1Dt8VHf4GtB8xg16ez6d9unzz8NK0Rq9+fY8nK6SIvXr3qJD/ys7gowxESOP4sHdsjolXPcwgYYKQQTXv5he79C5yLQeHYpeqrq1s3tlge0qdH/HsMDB5N6nStkiXUswWtMtg7asV20sLFgGlbBcodpWrVqBgv/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242523; c=relaxed/simple;
	bh=0EAGajf2cJrbljMoqgZ0FXpF5ehXm2h77xZc+bIilEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqeHGwrwUVf4BDXjtnYJBYO46D+kxlz/VKhMkalo5hF3xVwOkPhk4cxRA0UI/EvST0oMqU6l+Ft+En+KEbTNSeZ1JwJq00syQSZRh11pNbSowqfo2sif1AATMqC2eok5CzfRBlMEA6RSN/w5H0fY0Nm/UO2qjtjJiga4MNtiRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XbwM6KZO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IIS56E021413
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=c7p3i6sjQr+k5zoECzCA+ef/
	jRyUe4RBthVRq4DMzXI=; b=XbwM6KZOqXzyEz8KzdDURzw2BB7Vu91bxft5NFC7
	x9zLq5LP2nmwrXoz80c1wonccflMEroPzX0qDuWKgegirFU/fri/lHri9hNxIN4z
	F5jGzy/BvQGaUulzCYLbZ9p2qsnuRiq299ObLf6hhzP90mGlSzlusGMGQNR7fUty
	d/rNh95cDabvbOEc42qYYwBva4YqgQh2gTpnUaRsDDmP96XV7MxytIP/dpr7EO9/
	zUSzhY/olZJlzomaKnecIHPGTlxcsYrAXPiJ2ZgdyU49X1b25As5tT8xZX3XpmuY
	uewp+VpwHCOz8wnP9nKc5h3icSQETxBMHkRlIr8BfKKkfw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5gjbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:42:00 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-773e990bda0so30569376d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242520; x=1758847320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7p3i6sjQr+k5zoECzCA+ef/jRyUe4RBthVRq4DMzXI=;
        b=T0waSEeSNRY7PkUrnJFUt1JKE8wq3C9y2GitU2c6LhnW17SNKlHcu3FAdag6yJ5MMR
         guCpLiKuXPL9GyCPqfJXVonCTeLThx2WbXXugzK8LXy9UP8FxwDykIQC3K9b7CdvhUEM
         EaYEBUvCIRAXOBOlpnFOVBc+/jP21f/Og84ppJSWNKwnxMNl445Qt9Ee3EQwNzYfMGRH
         9LbhKAJMdrPm+d3bJocrV4Vh8/l5eyDm2yQI2pUO4G7ClyEwriHylaopALYnwlC1mByn
         6ZLlB8nYXE9h9u8EFdAfsQaem317Pqh9w4wxQZeC4S/ubjJXNdkqf59uRkej0gri5Aos
         9evA==
X-Forwarded-Encrypted: i=1; AJvYcCU6/mTST0r5ge7OWO2RcjPxQT+FOfYIkENRB7krEmPuXXycMSLfb0uxJwzj0JalRtSezBUHnGsFZIFnF6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WaLHOVQV8QHtk4r2exFNfklUukAewA1xW+6o993Il/0KomGB
	HoA8IIhqOdy3IqgxvF1RTpFSnvZM0uV/lPlBojw/w5VF2qQ4IbYRjdTysqts4TB+s2ThRaJB/XZ
	PsKvT1gYxiN8AYdme69vyPRQ21SB3/qnyV+yfECPcc/PhU9FbRkFWP9zmJdvybbiwLAg=
X-Gm-Gg: ASbGncvwn6gCV7lWM/641O7oRsEeBJ/pKYEnXZC7y8nOuH5LzcfnGUMFogAH/FHiB10
	ns8eWg0j0Sq+ovlHQV5TTij41C0nLUqYIq1buy8chYMnAOC34jzEixBAvjag2qn/IE5IH7CmIDK
	Mz/O5czHTRLNPmQ2wvBKFyESR8Rg53YzHU9qSrpYEy4jBF8L+cV9rTAVVLEEpdOTJX1kOEFpOQs
	4cFN8fJ9/z9MtONtGhEvDwGBLAH+3+YJ9c3O0zmn5qOhUd6bLb+8h41W1xtZg8EZUUdQpvFo/EQ
	3+kDwMmj5WbZQMVOdGhCcvPlqwczB6vEpLKWIutBhNXrGmNvIDLhrd5jGivM5MeX7jjj0fCscxq
	i3CAB3QieQZPzsznr2/chF8k8kCqrYkrARRoK/0bpTva8iyLTGVAX
X-Received: by 2002:a05:6214:248b:b0:721:7749:5a1a with SMTP id 6a1803df08f44-79912a779a9mr17102286d6.20.1758242519518;
        Thu, 18 Sep 2025 17:41:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHw7U/FdFUi2wArZIvt0T4wFtimMyyezA0YZtnzCSrMFgWPiguKlZZ7p/fkDAhwAWXS6MQZA==
X-Received: by 2002:a05:6214:248b:b0:721:7749:5a1a with SMTP id 6a1803df08f44-79912a779a9mr17102086d6.20.1758242519072;
        Thu, 18 Sep 2025 17:41:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a6507462sm1052227e87.46.2025.09.18.17.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:41:58 -0700 (PDT)
Date: Fri, 19 Sep 2025 03:41:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jun Nie <jun.nie@linaro.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jessica Zhang <quic_jesszhan@quicinc.com>
Subject: Re: [PATCH v16 00/10] drm/msm/dpu: Support quad pipe with
 dual-interface
Message-ID: <lkpcsed5wkyztbysmiks5xk3ojr3dw74ef65cpoycclxjmbnsp@5adctm46fc3z>
References: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-v6-16-rc2-quad-pipe-upstream-4-v16-0-ff6232e3472f@linaro.org>
X-Proofpoint-GUID: FE7cPTzpTtKPwTCE21SBRAOWVVmhRDR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX88YqrTsgluAZ
 l/wPuFsLmdChgvzjuel3XtGIpYwmlpCHjX6uzY2/D7uyUy0fg/t1w6h54j0KWflbi4kD4UEeV1H
 oNrWMi76/yr6Iyzvlsznlk91cER6wYNDNZVF74e8ABP8ky/YpgLh7hftc/7TVvbptQ1tiOcKdOb
 +LpENZf/JNlsrQy8YmlCpRZyWif6IFaJvabODfOmNKjUW5ANU7TwYTtFEcLJ+R1sebb8j9OyAUr
 IWiZE6knvou7k43bKCIi/fRV2PG2ebS+KcRaa/lAB2MABjq4ZjEy/3feGKqTpn3h3qnXBDx6QRM
 JBmpVrpvNTG4oinjiIvlwbDlZMjnSFPqsVigeKlEZBRLEQ5/K2RfWql10IyL7pSijeq0ioa5ugu
 jUZA40jO
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cca6d8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=e5mUnYsNAAAA:8
 a=SLu1AeIDhlxv97n4O6gA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: FE7cPTzpTtKPwTCE21SBRAOWVVmhRDR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On Thu, Sep 18, 2025 at 09:28:52PM +0800, Jun Nie wrote:
> 2 or more SSPPs and dual-DSI interface are need for super wide panel.
> And 4 DSC are preferred for power optimal in this case due to width
> limitation of SSPP and MDP clock rate constrain. This patch set
> extends number of pipes to 4 and revise related mixer blending logic
> to support quad pipe. All these changes depends on the virtual plane
> feature to split a super wide drm plane horizontally into 2 or more sub
> clip. Thus DMA of multiple SSPPs can share the effort of fetching the
> whole drm plane.
> 
> The first pipe pair co-work with the first mixer pair to cover the left
> half of screen and 2nd pair of pipes and mixers are for the right half
> of screen. If a plane is only for the right half of screen, only one
> or two of pipes in the 2nd pipe pair are valid, and no SSPP or mixer is
> assinged for invalid pipe.
> 
> For those panel that does not require quad-pipe, only 1 or 2 pipes in
> the 1st pipe pair will be used. There is no concept of right half of
> screen.
> 
> For legacy non virtual plane mode, the first 1 or 2 pipes are used for
> the single SSPP and its multi-rect mode.
>     
>     Changes in v16:
>     - Rebase to latest branch msm-next-lumag.
>     - Fix IGT test failures.
>     - Drop patches that have been merged.
>     - Link to v15: https://lore.kernel.org/r/20250819-v6-16-rc2-quad-pipe-upstream-v15-0-2c7a85089db8@linaro.org

Thanks. It's too invasive and too late for 6.18, but I've started the
test run at https://gitlab.freedesktop.org/drm/msm/-/merge_requests/191


-- 
With best wishes
Dmitry

