Return-Path: <linux-kernel+bounces-762344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD0B2052D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8597D420A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F252226888;
	Mon, 11 Aug 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUMKBBWj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB81C1F05
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907757; cv=none; b=BKRJDyw/tBYjTN0AGK+U4e6Yxev0vJsGvmVoQiWNoUNm58RvUvXrY0o6A0JSuXpHnTBu+BzuO1smxaStZZ7qYN32Qq5zvFWGRgIPhdkgDpm8eK9GULnle0CNAXlP0pU0hQdEBqx/RFaZVCLMKJok1Dep+pm7GpvzLsCM4laW8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907757; c=relaxed/simple;
	bh=un9Iyg0ms5LHybq45L9Cp1rYThzSovHW6L+pntYST00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyF8aMQE0e3i2XJtNF9gehgJlN2nZs4eDhLIZZmxJSJVrdQyGMYFoJOiTHODZvm0o3AU+qG5ZHOHs3JKV/cTt6TkBmm2Rfvb6n3m5+V2MAqDTpThGB7aNYrubADJnTYpH2XN5ZeAgH/L9bHvj7xyFQJu+Bhqh5LA49lSWBUs//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUMKBBWj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dHCF005228
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=PPcIqJTmGqbCZt8ehrODmErw
	r7fSzpLsxZ7IoVmL2lM=; b=cUMKBBWj3EH5NRlROXLfL/zm1GMoUGSautoC7RSi
	1wFAYWVWYFr/14MQamSCXshR1yf0ddt7QdUlouf92lq6IqdPgv4cA9Us92bgpe/Q
	XAMtRfmEcewLgnxHI4mSVG8+gPnGySDiAUJOynQbjNbH9DGSd1JshvuIPrzNPJE1
	Tt3E/xNpMRfKdEnS3PHRhdYJb0Q0S+/jL9an1IMQJkAHT+fzc4i6aAy3O5pL8+Je
	Ul0IgWc8WON1I+6X9Pj7aCra3mBe6gCHvMslmeVu44jmA3qyjLdIINq8Aaz7E2DO
	udYJwqmIwSKNKk4/64boVtbG1TXvi972gfJNlnd8FlvEnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx27bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:22:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b092c12825so119483451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907754; x=1755512554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPcIqJTmGqbCZt8ehrODmErwr7fSzpLsxZ7IoVmL2lM=;
        b=N3xdXKDy7RlGLOb+Qp8XJ+euwBW6aMywWsvTfdE8Y213rGG15s0B2MOoZ4A3IZ0ZwS
         5qObPx1cxpk59X9KtGMrmu08n3YoZs+DCM0PhyXrPr6mM2q7T9zg4uFwZQ1ObilI96CB
         tRSmlDiB7LgziK08x3VxSNquNr6q3uXoNFgBJjMddu52TgjaxmXFf5Rp7Go2PIedF2eO
         f5cpoPBDCcunmw3rk8ZFlNC1LJNhsM+ZnmIag5K7ZF6MxnhWW2NoKyuB1wCGWZkxdmHq
         SS0jG+HqzYrHvDq2oTdMW+GIPBWuhuFNP3u/jypME/TkyYSrLP60UyRwnLx9H447dt2T
         CIKw==
X-Forwarded-Encrypted: i=1; AJvYcCUw8H2BMLCmRoojHPSaRiPhYjCegk22mW8Cw5hhhs2VIUMO8s7uY2iXkOIkyX/aXQEgvE81TXJ/7FcSvd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlkx3vzPm8OgbHEi0zeZmRzbrMm46Wn/xrbnXiDcar5r8fL/1M
	kIK4q+aAYcPS16Z/vXNDSaQyk65G5gUoJy0QVeigyVEwxCx+ADuOm95nlBMSQmKnu2W95Etiegr
	yMAwVF7n/BllggvjBiBVTw2YvQ1zmBBCo5datsG3cpFmccTByr47F9Q1hwxlcYEKE7ps=
X-Gm-Gg: ASbGncs5xX+xtVQOnZcuETPLuWOlcmcsOS4zXpy9oYxfjAJKrhLbGaI5Xxf4ZPvNsSv
	WC62LDSF2sWH5QAGIJoQwpImqXVcilCqqqyNZtKeyaK1+/RmVESwnB6FGmhvjKjZBpmteAti7bP
	HBwxVzl1X6qJl5C8RVgGu0i5a0EJOmaV7uVNspQ63dIa2tLV7tJim5EKFZ4nK8HZVO4pLw1TFAJ
	nP7iQKtWgS5o4bKQY8btVMDCRq+ShBZ279N5CWpQeDNsdFPql80zt73UgUxvk+ek/AodYp7OlOL
	eFKV2xFy6Q4S7wKL6TiuR7T24GbP4K2ntaVDcZ9DtiGcLGTR6UXOYBeZFl311JRA+KtCTXIJguA
	41CrSgpGidsG+gQQAAwrc+cK7LkJan29yeQha9j3BBOtxFwGfu2jZ
X-Received: by 2002:a05:622a:1887:b0:4ae:f67f:58ef with SMTP id d75a77b69052e-4b0aec9df29mr168325941cf.25.1754907753781;
        Mon, 11 Aug 2025 03:22:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/1O6odL8qEXPebSXBi5VVqvakd8Iz/cxzY+rK1t+2/oJ2Ljc14sGyM/aY/rldP9dMAv6Tpw==
X-Received: by 2002:a05:622a:1887:b0:4ae:f67f:58ef with SMTP id d75a77b69052e-4b0aec9df29mr168325461cf.25.1754907753078;
        Mon, 11 Aug 2025 03:22:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332389409f8sm43713731fa.76.2025.08.11.03.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:22:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:22:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>, kernel-list@raspberrypi.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        ankit.k.nautiyal@intel.com, arun.r.murthy@intel.com,
        uma.shankar@intel.com, jani.nikula@intel.com, harry.wentland@amd.com,
        siqueira@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
        liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, robin.clark@oss.qualcomm.com,
        abhinav.kumar@linux.dev, tzimmermann@suse.de,
        jessica.zhang@oss.qualcomm.com, sean@poorly.run,
        marijn.suijten@somainline.org, mcanal@igalia.com,
        dave.stevenson@raspberrypi.com,
        tomi.valkeinen+renesas@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <awtqznhquyn7etojonmjn7karznefsb7fdudawcjsj5g2bok3u@2iqcdviuiz2s>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
 <20250811094429.GE21313@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811094429.GE21313@pendragon.ideasonboard.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX3GkLyq1Wf/7z
 UD6SeY1I7VsQEH/XH5rz3Q47qT2p8XbTjUpbmqEN/ydIhv2sdtsqQO45vBISnW7J3tgjjicQJRg
 YIRblqLxuikUqJlKWA4s1hFTrwPPhWOTBdT2F0LhQJx31fkKk5A/waS+xKAHhLIyA51Tk4YjmjJ
 sdqPUrhLmE7QJ65mrhk6PrJROHSIzKxCYd5zJUOcDDa8l5vDryQGr5Z8cS8ikyAVYqUpMkP+Gbw
 nr8w8PLcxMoB+dDOjEvHkMpaKkv6xuvpGBM2UTq72BENB8H2ru/cw694HsHwKFpd0EncmsSycNg
 jWRrcIwCFqYA+U6Dcz6VjfdbFtCjmhllK7+/+2ZAixQPPWDMEmV2dSpQNjttceXASyvUv7E7Uox
 Rw/dXi3l
X-Proofpoint-GUID: 0simSlgJj_MaU2htJqVAoG_2kT9BrlgW
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=6899c46a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=QyXUC8HyAAAA:8 a=-rapNmeMCNZ-4dkNsN8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 0simSlgJj_MaU2htJqVAoG_2kT9BrlgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

On Mon, Aug 11, 2025 at 12:44:29PM +0300, Laurent Pinchart wrote:
> On Mon, Aug 11, 2025 at 02:57:00PM +0530, Suraj Kandpal wrote:
> > Some drivers cannot work with the current design where the connector
> > is embedded within the drm_writeback_connector such as intel and
> > some drivers that can get it working end up adding a lot of checks
> > all around the code to check if it's a writeback conenctor or not.
> > To solve this we move the drm_writeback_connector within the
> > drm_connector and remove the drm_connector base which was in
> > drm_writeback_connector. We do all other required
> > modifications that come with these changes along with addition
> > of new function which returns the drm_connector when
> > drm_writeback_connector is present.
> > All drivers will be expected to allocate the drm_connector.
> > 
> > Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> > ---
> >  drivers/gpu/drm/drm_writeback.c | 33 ++++++++++------
> >  include/drm/drm_connector.h     | 60 +++++++++++++++++++++++++++++
> >  include/drm/drm_writeback.h     | 68 ++++-----------------------------
> >  3 files changed, 89 insertions(+), 72 deletions(-)
> > 
> > @@ -2305,6 +2360,11 @@ struct drm_connector {
> >  	 * @cec: CEC-related data.
> >  	 */
> >  	struct drm_connector_cec cec;
> > +
> > +	/**
> > +	 * @writeback: Writeback related valriables.
> > +	 */
> > +	struct drm_writeback_connector writeback;
> 
> No, sorry, that's a bad idea. Most connectors have nothing to do with
> writeback, you shouldn't introduce writeback-specific fields here.
> drm_writeback_connector happens to be a drm_connector because of
> historical reasons (it was decided to reuse the connector API exposed to
> userspace instead of exposing a completely separate API in order to
> simplify the implementation), but that does not mean that every
> connector is related to writeback.
> 
> I don't know what issues the Intel driver(s) have with
> drm_writeback_connector, but you shouldn't make things worse for
> everybody due to a driver problem.

Suraj is trying to solve a problem that in Intel code every drm_connector
must be an intel_connector too. His previous attempt resulted in a loose
abstraction where drm_writeback_connector.base wasn't initialized in
some cases (which is a bad idea IMO).

I know the historical reasons for drm_writeback_connector, but I think
we can do better now.

So, I think, a proper approach would be:

struct drm_connector {
    // other fields

    union {
        struct drm_connector_hdmi hdmi; // we already have it
        struct drm_connector_wb wb;  // this is new
    };

    // rest of the fields.
};

I plan to add drm_connector_dp in a similar way, covering DP needs
(currently WIP).

-- 
With best wishes
Dmitry

