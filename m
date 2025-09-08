Return-Path: <linux-kernel+bounces-806781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DF6B49BD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AAD1BC057E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA68279337;
	Mon,  8 Sep 2025 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CAseqLXb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B02DC333
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366775; cv=none; b=T1fnr3gYh4fxs67+ukSGctJ88qQJ8A8uaEiWwmHsQ5HCfDzTMdfuAj94GDERKJvtcQSgiMh3HdIY1gxhSXj9L4VDY/NktEWIQvjTgfXorcXRD7OCc091KiURq5Dzz6PpfWNS6LB/rM5RkdQyo4wRJ0nyVKzgFStcYY0kUb6uzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366775; c=relaxed/simple;
	bh=0lbkRKJGiZGYmEhFGcQuZh1MmsainvZ02xYuAR9vExU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPQjzpxkgsUYBdEFfFn+ts4Co7YFhsbnJjRnc9aI6/HcJ6ngEXgwOFSQM8h+RTpghQilF4oaofeFTcJycgihV6xUSEuoNvo34Q8OlAQ9FTEaUoeZALLZiLuJHJa/Kh14fWiT+DFv6Pmk6PZCGjwPE0NvE8bBvDAdPhsUs/BwOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CAseqLXb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588G5OUZ009916
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 21:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ew5MG2YGxdvZ9dDI+UbP3xwO3aQkZtMmI4KUi7ex/LA=; b=CAseqLXbWnbuNaiz
	Zyh/nK1vgXCiGOfJ30Tn2i1riKNUXgoanNcoGko9iHRPCkQXX7MdvlJp6/9utbr+
	XYtGh9jTpWE2BZGWpg74jNEqRNq8Vy12nJN1UCCSSCkU/7ydrqZXBiwr5R7OCSmp
	X98Fs3niw2FqSe2w7D4JFlD3REOnXMm5CH9DmBD257Zr5ZCTsmUUmcKXzoRh52RZ
	MRI/ybhx9O/oFKAcCNSpgG2G3jK9usimPivLMI/AHrk3mSRt/SjIWAkSHGRuJKYk
	ILQrU81jq4WLMcBEqDt8JJ0SWZICc3S0oYR541bk47T6Q497Zi+99WHJAKdsi1fB
	TtU2lw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aape8ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 21:26:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b302991816so113762551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 14:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757366772; x=1757971572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ew5MG2YGxdvZ9dDI+UbP3xwO3aQkZtMmI4KUi7ex/LA=;
        b=OsUfS2i5Z42L3W7Z7n8TBjNU22vuEZeXprSIk0h3uXMxANO+CfnWgSZ5X+ZnkeFzyw
         yKZH4WYneh7Sz6L24qnlYK8wAXvDWXCICn3VQ8dAvtPkEd3tuarLTaONkLOWAyNpb4H5
         3zxuCHF40exBgVrhN/PFKJ3KsPsTIaGtE4DWdVs1kysg8KyZsUl7lbGkf3FN/D3W/DLi
         huCA1g9/h1HhHkqWZW81gbZD0GKr6tIJ+Wwh4yAj/rX/r2xSvxXcYOhca/Xjhm/Gn0Kt
         DVQnF26JpImeAw/Tt8UPNK3oa40eXFVBn5cg9OiqJlPXDQFPj3TfIXvh65ZdbjaRdSqh
         sFAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl6x+eMoREnEqOR/ArpJNHBmhZxuTNKUruDrNPfFJ7uH1ZD8fX0MEXPvkC2lsYjXpOd8Bb4ubvI1rjZFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnsnPB5yM7hSjxsIDHJIWUw54yMemlcDMPSrik9JapAoVl402
	k+Afu0A1TM9wLCCGkil7NioGe5+EyPJLWjzjczJXOcgGqheaUm3XjyhNPuXykQLrYxjaGvRwMVV
	lUMloDLqRGYfxe3hFgcdPkCdsRsTqTuzAsEit4IjQKXjfBUaQ02aQIuob884g3YXIEMM=
X-Gm-Gg: ASbGncsjPGaqSrV+oV8ruT0dUKN6IW9LO1CulyslBvvspWO6oDa/wwIepvXM3qh2exc
	KIOshvQS0RKOWRS+sVcOSl6pT3l9GawimJQvc65f4+436WmMZjl6y9Rgl766e38tuNZy4+85ShZ
	C0H+t0hEJkMcLRLgXgpaTndiEi9ok2r5ELTJ7wdgUXsj/Ho3bgkWmP+zaA2LojQylPj8KocZOQ1
	yHF8TDwMotVcwKDoJ6k0/tySXYrT3QtOVxq3Ln0omSlkLBRONr3sbZXr+94hpXhW6lpYic+dFuJ
	t/LChtxLFwsZ2wUfEFkoBJQj9ii9LY4bBkgyG0P7qvLUW+ay7wSZas9g5Jhvevhvze31nUhYK8X
	VgLGcnNySrWuT0QH/p7gKmoKzvu2psBG7oHGl3s5GxMAa20u0f3AM
X-Received: by 2002:a05:622a:24e:b0:4b3:6dc:afc7 with SMTP id d75a77b69052e-4b5f8589aebmr107253761cf.67.1757366771948;
        Mon, 08 Sep 2025 14:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqvSMdw2mnuWqudtOY9nHtMhpMBFO5TsecOKtwKK/b6W3wDjCyZDgaQNZbmDLC91j16XyVcg==
X-Received: by 2002:a05:622a:24e:b0:4b3:6dc:afc7 with SMTP id d75a77b69052e-4b5f8589aebmr107253151cf.67.1757366771278;
        Mon, 08 Sep 2025 14:26:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680cfe2496sm38381e87.61.2025.09.08.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 14:26:10 -0700 (PDT)
Date: Tue, 9 Sep 2025 00:26:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: abhinav.kumar@linux.dev, airlied@gmail.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
        dave.stevenson@raspberrypi.com, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, geert+renesas@glider.be,
        harry.wentland@amd.com, jani.nikula@linux.intel.com,
        jessica.zhang@oss.qualcomm.com, kernel-list@raspberrypi.com,
        kieran.bingham+renesas@ideasonboard.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, liviu.dudau@arm.com,
        louis.chauvet@bootlin.com, lumag@kernel.org,
        maarten.lankhorst@linux.intel.com, magnus.damm@gmail.com,
        marijn.suijten@somainline.org, mcanal@igalia.com, mripard@kernel.org,
        robin.clark@oss.qualcomm.com, sean@poorly.run, simona@ffwll.ch,
        siqueira@igalia.com, sunpeng.li@amd.com, suraj.kandpal@intel.com,
        tomi.valkeinen+renesas@ideasonboard.com, tzimmermann@suse.de
Subject: Re: [PATCH v3 4/8] drm/msm/dpu: use drmm_writeback_connector_init()
Message-ID: <zw23hgjduxgijown52jyiomungxx4cjyv63qixtnx5nbm3w7xb@2yy65777ydnj>
References: <20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com>
 <20250819-wb-drop-encoder-v3-4-b48a6af7903b@oss.qualcomm.com>
 <78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78c764b8-44cf-4db5-88e7-807a85954518@wanadoo.fr>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bf49f4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=TSbVqHtbAAAA:8 a=ieunMBFP7PMWw6OMX0QA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=NJcUIoPEKLAEIzHnl83t:22
X-Proofpoint-GUID: nBjmsVM5lqHWUHyJOIxiiQEejtfYcmwX
X-Proofpoint-ORIG-GUID: nBjmsVM5lqHWUHyJOIxiiQEejtfYcmwX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXwGBlJFQUAjJq
 Chhz21xSIrSQc9D/ipzTLr8nQjQ1JrnnvY+oLDqKnbC/L0ARVwvBTB7p49rww7Haa9Zb4hRBtIw
 JEue+umISb1A1SZndIg455n2QIgEuVfdoELRHQgUGNw2JTNABD2HvbzIy3xBsx0CPoecRDaph1m
 zH9pdaogtdO84tIbVWSNYPYbh41tGVUJMwA6UQAUHDCqEGQHjMad+eRDKqyPOjd3nsLUVo5iRGL
 XIcu6/K61nCvjQQpzoRG2dERolW65yHaO+inDBCwPWF+/WLdrrFeCZPvxICG0Q0B8jhEEUk+poZ
 c46dHXnpvZnDoQqk6gJ+4ghvgPrr/ZJzLVy/+5rq1awTBFXDHbfkeRmv5TBMKSmr6W4VCOylati
 6az0jqcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 11:09:07PM +0200, Christophe JAILLET wrote:
> Le 19/08/2025 à 22:32, Dmitry Baryshkov a écrit :
> > Use drmm_plain_encoder_alloc() to allocate simple encoder and
> > drmm_writeback_connector_init() in order to initialize writeback
> > connector instance.
> > 
> > Reviewed-by: Louis Chauvet <louis.chauvet-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
> > Reviewed-by: Suraj Kandpal <suraj.kandpal-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Reviewed-by: Jessica Zhang <jessica.zhang-5oFBVzJwu8Ry9aJCnZT0Uw@public.gmane.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov-5oFBVzJwu8Ry9aJCnZT0Uw@public.gmane.org>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +++-------
> >   1 file changed, 3 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > index 8ff496082902b1ee713e806140f39b4730ed256a..cd73468e369a93c50303db2a7d4499bcb17be5d1 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> > @@ -80,7 +80,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
> >   static const struct drm_connector_funcs dpu_wb_conn_funcs = {
> >   	.reset = drm_atomic_helper_connector_reset,
> >   	.fill_modes = drm_helper_probe_single_connector_modes,
> > -	.destroy = drm_connector_cleanup,
> >   	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >   };
> > @@ -131,12 +130,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
> >   	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
> > -	/* DPU initializes the encoder and sets it up completely for writeback
> > -	 * cases and hence should use the new API drm_writeback_connector_init_with_encoder
> > -	 * to initialize the writeback connector
> > -	 */
> > -	rc = drm_writeback_connector_init_with_encoder(dev, &dpu_wb_conn->base, enc,
> > -			&dpu_wb_conn_funcs, format_list, num_formats);
> > +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
> > +					   &dpu_wb_conn_funcs, enc,
> > +					   format_list, num_formats);
> >   	if (!rc)
> >   		dpu_wb_conn->wb_enc = enc;
> > 
> 
> dpu_wb_conn is allocated a few lines above using devm_kzalloc().

That's a valid point, thanks!

> 
> Based on [1], mixing devm_ and drmm_ is not safe and can lead to a uaf.
> 
> Is it correct here?
> If the explanation at [1] is correct, then &dpu_wb_conn->base would point to
> some released memory, IIUC.
> 
> 
> just my 2c.
> 
> CJ
> 
> [1]: https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/gpu/drm/xe/xe_hwmon.c?id=3a13c2de442d6bfaef9c102cd1092e6cae22b753

-- 
With best wishes
Dmitry

