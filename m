Return-Path: <linux-kernel+bounces-762329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E209CB204FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6D420B05
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9739A2253FD;
	Mon, 11 Aug 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FDwP+B0O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C473223DFF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907222; cv=none; b=Lh6zqMcN+hT5oxFIignbGdVQWHwemcMGtIyhIy4WwoSpoR3C8HKz00dxrDRvjoNjmgc/dlfC0/UlHxzPf89X1mmoRrNOI6ZjOB6px1h+rGtCdh2lnFQ80NxkQ5icub8W3bgVYlzu5wfL949Twxoexh/w0A4AU2PTZvSJTqfy/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907222; c=relaxed/simple;
	bh=l9bwAwp+otURd9HsCSu4lr2vMqpgTZAdByA4pdGWXJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMEtsjFlaofMc0xCMgZymz1V49Nn4iEFudhLLXBfOpYnBclKHkpCjVciw2cr7VVrDEU1YWzDAwITP03ANWPvb+ZqyBDCUpzIlfWXOMt8MGAqknirlfnZwsHahw8vlkVpwAlLS2lX1Uxq15HLv+OVzEkcjv7GchC30RS1kYPYjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FDwP+B0O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dBRn029232
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tQBekwLY985lR0kL588BU9IYUYSsm3EJi76WLENqjaQ=; b=FDwP+B0OX5UBuh1A
	yaBnSgBA4PZ6KYN6UyxgXDpyNLwikqLtNO6NVZchMnFrdq1fHAr9zI3JLW/AKlB5
	nxIdKbXb87PbAZ2UiPni3kloNPTITgFmGv6lF1CH2AdwpxGy6DNhc7/lMRaa26ok
	AXFCp45EK0v4y/nT5fwiGnPWYU5wcC6mTKy1VYu3ol63+TOPdiuiJhcv9r7YqKYs
	RQyuqXukejuJ37d/tRE8V2Cn/2VVJ0n0OTxLwyvmy5rBgwi3p4b6oJM3S+Eqe5Zd
	9GSCTxs/jeBsJi5cJ0uWNqxOvHZKxGtVOz3gUSCF+MmelO9zM2JtUXFL9SlErhyO
	3BHiYQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmbwt5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:13:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7074bad04efso94474456d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907218; x=1755512018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQBekwLY985lR0kL588BU9IYUYSsm3EJi76WLENqjaQ=;
        b=YwJhzZtn7+8xJFdd3rn39l7pMC8Hkb1Qg91tXRrk61Q0KT8Ugvn5aNJFyZuym+CvS5
         ND5Z1FSan+FLnBHs2kSKkI2Sg9Kws6nui3JwduZrq3WBxon5qWX9JeEPj6F8xsosbVcS
         TOIUVcsAAEGLJdCTEGCerpUcGYdY48zx56Hlbrwk1bk06L9AfcPl+/FDEEa1EpuHe3nW
         rJx7+EecUTrWES1GbhyRaoK0ZIBfTsKhOnPTaV5o2Z4oh9FejjJmT7MwCdzgiPuDHVWH
         A5PlyGTI5DE4pusmAw9URKomvdgX2lD3johun+h3dYkphQGav6RfmtJh3Sxh8tF2axbO
         2ZqA==
X-Forwarded-Encrypted: i=1; AJvYcCWPT0EdGpOyxNne9TzPV4c9vkYTVv/b4QPcmWNGGVZ/WPuOmixCFDF8IUxRX3Zu75OyoEIoLGcCn/C960s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEF3T0sXtujwc3DVNDZqGN5y+UwhHkZ2LR5p04lyHZ1n1vi45S
	WL/74R6c/QrTzJHfoBI71sYB7rWmbPx47RUojuW6yqvSwGgOn5whEPzKSIho6EcJRxo30HGG53r
	+/R4cUBN3ndAHHiOBHbjJ6cysHdOh2sBg+qt1eeE4MQlgJgSIn3O1coqOCb1SN/ggO3Q=
X-Gm-Gg: ASbGncuV0041UsmpdfYRmWX8FlUOiRJw/R+zE19pCE1mtGrGd5qPCDmrpx4B71fFws4
	nF/UNWqq72XCt5PVHGbpVLM+dBrYkPIOD9zXxM+CuE/nOaWOJwalZmMlQpJJVk2FvZVOmWZ0OlZ
	4JwiLnJHWOUuGVX1gWVJmqsXqpp/uwmOcST0Lvp3lQ/lJXyYXYqjjQnTIefEjpwxscmDLU/NCr6
	IPjg/e3NleMT4oueS9/Su48Z706bp2KcKftIUkzmPw2YzkGTlYRLWmUEmgfRl2//4Y99CJwkzRc
	10YSbmZkz5DL2f6K6m+OMH3XDVR3BRl4T0gE5otyUU0tEWagqLDUNs3/PaMXz+/ToePj3rEDx+N
	9NR7qbdh5ta880Igg61dtaAZs9zJ4FhCFDO3CyFm5Y72OtEMKXKt+
X-Received: by 2002:a05:6214:2422:b0:707:6409:d001 with SMTP id 6a1803df08f44-7098943a0camr242700406d6.21.1754907218067;
        Mon, 11 Aug 2025 03:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BY/zT1y+b3ji4GZxhC3ZVhQrv/r/mWPNZE1y3jpndTSli2Cjg/bMQSHGPbSf9yhMaetFWQ==
X-Received: by 2002:a05:6214:2422:b0:707:6409:d001 with SMTP id 6a1803df08f44-7098943a0camr242699906d6.21.1754907217606;
        Mon, 11 Aug 2025 03:13:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382a905fsm41770471fa.21.2025.08.11.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:13:36 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:13:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, ankit.k.nautiyal@intel.com,
        arun.r.murthy@intel.com, uma.shankar@intel.com, jani.nikula@intel.com,
        harry.wentland@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
        liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, robin.clark@oss.qualcomm.com,
        abhinav.kumar@linux.dev, tzimmermann@suse.de,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org,
        laurent.pinchart+renesas@ideasonboard.com, mcanal@igalia.com,
        dave.stevenson@raspberrypi.com,
        tomi.valkeinen+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <gvshpndrbnojzwewwa3icd5fjwecqj57jj6gfgoips5xq2oo3l@3dsebzcjwr7t>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250811092707.3986802-2-suraj.kandpal@intel.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX+6wCo0+8f1a0
 msGj+4joY6XU+bmT0Wp+ku/sS9x1tTMUS+TGek6q+rfUUOBGsrqUi24eVjUIp2V5nNKQ4N9riU3
 OAYQo2HpB6aXQrFBhvb9VlUx2fz6LHu66ehUy42YVadBQaeFyFUnI5WXEU2PiEdvcM0B4BM+sES
 FunbEZEsnWHtJW76U9BEeoNGZdqrRa9Fmb97swgq//AMZQjvJdv1HQuey9GnXBTHZjvLYFyZ28v
 FP2Q1Ze2Mc8tJLm7VrIzuJsjEta9F3H2/0/QXwzz8avXWHTVYwIQ8kNAwkZ/OMIUzik45rASByx
 RcDDDh+cWw2ae0cxQFtno/ymqBn+FzQwG4tHMyFBzJhY/DGXFdN3V892zsGE7efYfBcKG/fJ2iS
 fj6jcYmf
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6899c253 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=JhAXgKmwuo5aGy_CkLIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: LX9Pl54rBPb4FQ-3o3ty3EpSQ-JwH2rg
X-Proofpoint-ORIG-GUID: LX9Pl54rBPb4FQ-3o3ty3EpSQ-JwH2rg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Mon, Aug 11, 2025 at 02:57:00PM +0530, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not.
> To solve this we move the drm_writeback_connector within the
> drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. We do all other required
> modifications that come with these changes along with addition
> of new function which returns the drm_connector when
> drm_writeback_connector is present.
> All drivers will be expected to allocate the drm_connector.
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
>  drivers/gpu/drm/drm_writeback.c | 33 ++++++++++------
>  include/drm/drm_connector.h     | 60 +++++++++++++++++++++++++++++
>  include/drm/drm_writeback.h     | 68 ++++-----------------------------
>  3 files changed, 89 insertions(+), 72 deletions(-)

This patch breaks building of drivers:

drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c: In function ‘dpu_encoder_phys_wb_prepare_for_kickoff’:
drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:487:36: error: ‘struct drm_writeback_connector’ has no member named ‘base’
  487 |         drm_conn = &wb_enc->wb_conn->base;
      |                                    ^~

Please perform step-by-step modifications, making sure that on each
step all the drivers can be built and function as expected.

> 
> @@ -2305,6 +2360,11 @@ struct drm_connector {
>  	 * @cec: CEC-related data.
>  	 */
>  	struct drm_connector_cec cec;
> +
> +	/**
> +	 * @writeback: Writeback related valriables.
> +	 */
> +	struct drm_writeback_connector writeback;

I will respond to this in another thread.

>  };
>  
>  #define obj_to_connector(x) container_of(x, struct drm_connector, base)

-- 
With best wishes
Dmitry

