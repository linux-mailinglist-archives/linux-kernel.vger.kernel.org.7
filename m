Return-Path: <linux-kernel+bounces-796005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62524B3FAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AB1899D65
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9FD2EBB83;
	Tue,  2 Sep 2025 09:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BYvIywrX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C6B2EB866
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805788; cv=none; b=FLVli6bAQCPIWzvSKjpqpw+3woaDwJoznVVqeuievnhMhoLMdE/rqrkvqoEgh5Ykwc6yeFRwpKTb+MDHwDbYyvtVxo5mywijAK+gwZ/rv4BXCdx1zlAJtkfzePhZyhcDMfUYJGUFIcMDs923Lm+22TrRzWC60oIYy7MV/jU31KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805788; c=relaxed/simple;
	bh=YYBOJ0SUlz8HvGAIGlmhlyEV4PWBo+R1ZBUAuZZS+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q35HNGYiJxlQDaYWr3BTM8uW9UIflXoUCkKNh3ryb4f6+ltF/gpvPdZxjchXzr4ZEbeXfvyKw91KeGyKBbPRnBwN+GTJw7ReXTYoWjU0+n6B7nPiZJVLHbpmUDI3Ovkz3Ev/0KxiudR6jf/Z6fMnEI/K5Vhh/dwRBfloPCRpank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BYvIywrX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SaNk030840
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 09:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zwxseqR+TZhAlHd8nXn4rEVr
	gvLiKS1QfDCvUia9uDs=; b=BYvIywrX3heQ7ne5hRRZ5urv5nl4T7xAfnc+SZM1
	/i5UPcTEuA/pByNJR0mc3t+cw+DdPg8mYjpo8RAcOSuTkTWvJhpcr/BAuzYDC1x+
	rnip3mPByRZc1p/LcON3dNibvaAyzY99svf9HnmOiKPDPJleFdLGcTrDpp6oVQYG
	YBtCVvI1NloXtXqOOqMAPQwzgQVMWt3pOGGwo2GLlWkLvNsfm7A40wUSt179x/1w
	8joq2vla9hDBamSayx3Gjl0H/Mr0E1kpSqZSBgBke1+VmT1z00xLtZQb+j61CVRk
	Iua3yEjZh4VDVx8jhku+r7DMkHn+VWS04c6zZRYzguMKGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8q9b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:36:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b2f9e8dca6so113303451cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805784; x=1757410584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwxseqR+TZhAlHd8nXn4rEVrgvLiKS1QfDCvUia9uDs=;
        b=nlIaYnxecUx+7cZlh9+2aWIS5difg3h6PZ4nH3DWwGxxDGFDlpMnkTmpl3ZzvQxBxz
         +GFO8drQRPqyQvhP3ttmBBL72dAQ9mReejRYLyizWRB4soqKV6srqFm2JJn/PKfIHJA0
         5MHOGZRx2Un+9zv0AKQ2j9TP+RRNDO96xbM2RzPaOob9kNQCXhBoyq3Jf84JRXnESmew
         TBB+ELiw1AHFvd7ffjMa3BBoeRzKeoaUwpVsOfgBzAiGEtF+YmxROj5jCulNhier5yok
         vyVWuIuhF4LFBEK66jt9v02TGJWMZjZ8STzwFzRzjh8OxESq6mdPv6gtT4pnKY2hRzsD
         GCSw==
X-Forwarded-Encrypted: i=1; AJvYcCVm5mg0vnGP6Q0Sxv7mmUa8PYmVJRnDv7fpgwBGuUE2Ra02GYLxhDsvcN79+1HtbBKmCkd3jwm/r57Ycdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWG30FnY75GeHSMiy9H6mYYjIuUyrZ6Qc8JUR1gwpVp2FWrai
	5wFlKMzVyuTARO3HH/6d1GVkhqevsLg3GHIMzwz5YIFY8Dk4Srmpdxof6hp5k3tAJNzIuk51qU8
	cFB74Ua+i20j03Lv47AHi8dMez+JhW5tem5sfrhpd4+ewm27WUjnYDvG3EXrwDlqDxhE=
X-Gm-Gg: ASbGncts7VqHMdsY1q8fcuq65U0Z2fuLgbQWwxbm7NuoMTXrlZKYIDAthf33+OEg6Hr
	FLlrOL+2MIeLD657LOWggg90dLdi6gwLOqNlnQQdtB4hTUjRBota1Kj0EKpvTtzI2KTJ1NKBvU7
	5BN3kROWNrONMS/2VMNL9AZLJvVJodcdHDfN7v8zNMPp0juCAE8dxXE2+XjlpVka5IixBFIb+6m
	SD3TXdsBxwlTprh3nYvTj1WkM556YynV0LG4Gm1vPbVOT/qBwbAkf0SuWl1qEQY2+Fykg5nlqu9
	AXaFq8+Rhn1rlEOcKnraiN09GzSOlxzD5GM3QxbVYH33xS53Sdc7slhbpGcuHhuvAHSjDclO/gE
	oytcwYYxn89gfjM6RktAOfyIgbrSucX3RJU2an7G7AOYFHxo9uoWs
X-Received: by 2002:a05:622a:5e0d:b0:4b3:459c:6eef with SMTP id d75a77b69052e-4b3459c7a6bmr18165901cf.47.1756805784107;
        Tue, 02 Sep 2025 02:36:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx6nrwggqsOXBxF3/OABMklDbP3IK5x4SRajgGDGpPKXyjhgzvQjkfyqsdwZoBMZXal4NHjQ==
X-Received: by 2002:a05:622a:5e0d:b0:4b3:459c:6eef with SMTP id d75a77b69052e-4b3459c7a6bmr18165671cf.47.1756805783493;
        Tue, 02 Sep 2025 02:36:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-560827aabf5sm544368e87.137.2025.09.02.02.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:36:22 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:36:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/38] drm/msm/dp: remove cached drm_edid from panel
Message-ID: <yarnaujunszlfrbduakodv7n63wjgh6og3t4qowhu3n6tz6fmn@4kb4crd5rqq7>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-1-01faacfcdedd@oss.qualcomm.com>
 <otmy4kttxflsxkvacwdsqynck4nqeww7jsxaq2xwjtlooxnhvx@gmpezdliskck>
 <5b142910-81e7-462d-8933-70705334ef0a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b142910-81e7-462d-8933-70705334ef0a@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: m1OiHQucNlvvO57r2XkHfaXEDbZgEOV2
X-Proofpoint-GUID: m1OiHQucNlvvO57r2XkHfaXEDbZgEOV2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX68/siw2eRcNf
 xz2gg3otL28sU1+6PvWYEgnpL4HRKkuWozRtiip8G3/7Dbw0oNbvxzYj2auhGw2Q6SEYCDeiCSt
 4SO4GPneOLFC9nXX0v5NJNS5ataYirek0xx7HYUa02nXHsE9X42J3457KDljM35m043Z+/GU49B
 uVuO3b4BXu3U7Q7QQxwvqZ/jtI/dOsQbOvNBxCP0UFCeCQy7v7Z5Mso/oPTxYorQk8ObYcAXyZU
 j7UpBTJdO0OCi7GPpJkMgR6kx+ZGgZ/G9uGFNnSQq1tsSZ4m8KBglnzZlQ5UyLb1fq3eVGEy+9Y
 VxSx4dOKtbrq/ZcdbGmIq2D0SHtxkhkcnBa+yDtJhVoYFKNU61jkKkQAUmtu7BnoiBqyFHx8AWb
 kKQOc4S3
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b6ba99 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=kpPRz-UtyBwCQlaFug4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

On Tue, Sep 02, 2025 at 04:42:18PM +0800, Yongxing Mou wrote:
> 
> 
> On 8/26/2025 12:41 AM, Dmitry Baryshkov wrote:
> > On Mon, Aug 25, 2025 at 10:15:47PM +0800, Yongxing Mou wrote:
> > > The cached drm_edid in msm_dp_panel was redundant and led to unnecessary
> > > state management complexity. This change removes the drm_edid member from
> > 
> > Please see Documentation/process/submitting-patches.rst on how to write
> > commit messages. Please use imperative language instead of describing
> > the changes.
> > 
> > THe patch LGTM.
> > 
> Thanks, will update it in next version. Since the HPD refactor series are
> unlikely to be merged soon. Can I separate out some patches from the MST
> series that don't have dependencies and send them individually to make it
> get applied? This would help reduce the number of the MST series.

Yes, of course. Please keep version number monothonic for those patches
(e.g. by telling b4 that it should start from v4).

> 
> > > the panel structure and refactors related functions to use locally read
> > > EDID data instead.
> > > 
> > > - Replaces msm_dp_panel_read_sink_caps() with msm_dp_panel_read_link_caps()
> > > - Updates msm_dp_panel_handle_sink_request() to accept drm_edid as input
> > > - Removes msm_dp_panel_get_modes() and drm_edid caching logic
> > > - Cleans up unused drm_edid_free() calls
> > > 
> > > This simplifies EDID handling and avoids stale data issues.
> > > 
> > > Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++-------
> > >   drivers/gpu/drm/msm/dp/dp_panel.c   | 47 ++++---------------------------------
> > >   drivers/gpu/drm/msm/dp/dp_panel.h   |  9 +++----
> > >   3 files changed, 26 insertions(+), 58 deletions(-)
> > > 
> > 
> 
> 

-- 
With best wishes
Dmitry

