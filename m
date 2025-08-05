Return-Path: <linux-kernel+bounces-755926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C81F9B1AD79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD68518A344D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063620B1E8;
	Tue,  5 Aug 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lvfMhJFp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9B3594C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370446; cv=none; b=ez3kF6Z99MsfJJMvS3yWyt1htZ64jvt/8vWnvo6BSAdn+1WNY2QSNl6u10qOyiF/YmvPW6rXdyTRwzfYaJlFqPKiW+pJ2iIez7Lb/qgw0pkzeydzrGGFiIDw9vHKDeNoSAijrx7AD4gwTq+XtALgcthnB0nbtrUVAInpr4KewX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370446; c=relaxed/simple;
	bh=LWNz5BB8AB01cFChT1rd+gSO6AFmS23awzJOhwjdfoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0LkKwWDxub73PcQ20qqmQ55YwGxnLIdAigcepyL3ARVCZB0YRisQo6zQvF88IXPXdOPSDukKtFScNz7W3NgxM23rxocmqb41z+Ur2v28rEd/5DZBpzBhyPCxxG44WQkZEHju6fG30OVL2kYwRISAGhG7FjiJ1sONDidME1Ke14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lvfMhJFp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5751wPqd015920
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 05:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RGDGlIBOS8QFQQwkn/fuebKk8DgDBz/tM3/dLliE5IY=; b=lvfMhJFpd24bhbTP
	O0kG2q+A5fVGCkz3i9v56lGSGUPn8WnufnbPMlvV5MbKP57W5QtOAmWlaRmEBpao
	nSKDSuh8YmLPKjb6xMP+/Y6JFgsLDYIld9SJc3BZszmXWt34qD0hzAZIMyKdy4v4
	/zWjAMprFk9X2vSrNSKCNzfEMqIbqQw6/ZSropEZITO3K7coDCUoRPmnPSIWLCJm
	0SbZYz2l/2ZutflB8CkZN9UACsZ4A7JNNyc5cTXVZySLVkOVoyT0M/RcjPzsgpcW
	88eNv1NJOeFvXWtEMFRf2UREtFg4biDamrXHki0+PnxKHyErxtwsIBm/+z+ysfOz
	hZrJSA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48aqyv3f32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:07:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073f820d42so117967116d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 22:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754370443; x=1754975243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RGDGlIBOS8QFQQwkn/fuebKk8DgDBz/tM3/dLliE5IY=;
        b=Qqk58BEs1k5EmyaR30hfx1oyP79F8VkZ8TkB7QcReg9t04IClnmRWL2YXNfcKSya23
         iae63mDv6GFjK/o2kd+abnWDdMFjve0i/+0n1/4hnskxPSUhMBAj4F5BiLuQieSVrmdR
         JzKIcSE0CLn+iziutJyHzye8DN0kwlSqAJgmNHdlZcT9rCoeDoBLqAUDcspJ2NzD6SiF
         kV0TV7mJ7l44mDBTKSrtrsSCpUG4on73LwU1LKc2OmVlFInxmzBr7l4WbEQ/Xo/XnA0n
         URi2Hyj3fhJpUCwHDdsnp5z3T7k7PsCwEZyNW1BTrxa2CdN5lBtztUv5DSOu6l0thF47
         m/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd9uPVz6L6x/cyKDHFexmMXaEvgvOcXJk4K0yKDjTCtcwoQoFyu3Kykqe1YKzxRpZyHyc7ACfflPe5wbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvadQdtaabCRlZovyX8/VgJ42KQphmtMCRmDLaxQ42BunJuFhS
	be0Z2eV4/Ht70NMwwNKRrC/ik5hhZlS/D6P1bp71X5/K30NmrOsvpnnu7fXhMCZl2kH903GLfse
	rC8d8zzwb2sxxPESyfCSvYdbrH+ItBPxljVi8Uxbz6vsRvG44WOx13olu2DB8y+MJzQs=
X-Gm-Gg: ASbGnct64SxYu/2nzfVKIk7aCLafZgsIu+6NXO5wSrKN06fxxobX54LbPlaFn4GeUaw
	O6BZ/CxZgM685pRUUCpMHIMXcIxHffjVLa+uk6uM71z/dYBdNuJgI2ayIWE7GV05aYjkvVc/LFG
	tynUH2eGfvFhEgwbyMsHyVq6jWgSg1kvD0YiphjZO/nGJZFBqESB10muDly6elk40yt6PhSePfg
	vtj4z6fNGk0k4b1zhUpTboJQg7cU65c3kW67/uAHWXQjJ4d2yaT8Draf2ahUNkMNI6t/t2qP3ny
	tRPWzDvptCb7ntj+XvpPFmwyqTlWqUe31nN6T2fqwbbUPVckEC5Xwsmb4WYMCV5h4UVDda5OPIH
	IlfYVukbmPg2ebFIaqYY/SD8vvVfvmmoDkmJtUpCTSW1hfyEIKp+K
X-Received: by 2002:a05:6214:4015:b0:704:9b5d:ef4b with SMTP id 6a1803df08f44-709367094c8mr164062836d6.26.1754370442552;
        Mon, 04 Aug 2025 22:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN3RBZkH/ni6lalhr3Yl6Hm5Hxp8OvzmpE/5Ch5pnBaCVPtzbmvTCMAnzgDBAbFiiWNiQ4yA==
X-Received: by 2002:a05:6214:4015:b0:704:9b5d:ef4b with SMTP id 6a1803df08f44-709367094c8mr164062496d6.26.1754370442018;
        Mon, 04 Aug 2025 22:07:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabb7fsm1838792e87.146.2025.08.04.22.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 22:07:21 -0700 (PDT)
Date: Tue, 5 Aug 2025 08:07:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Christopher Obbard <christopher.obbard@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v6] drm/dp: clamp PWM bit count to advertised MIN and MAX
 capabilities
Message-ID: <kg52pqpr5ygfw3usru4z5e6vniqiexiewyplpru433tilvwyzi@stwgmyxie4k7>
References: <Z-pTcB0L33bozxjl@hovoldconsulting.com>
 <CACr-zFAiKRTHyRAF5HkM2drCMD7Q_Z3ZUFAsSnevy38yD8XMwg@mail.gmail.com>
 <Z--eRHaYw_vbgK2f@hovoldconsulting.com>
 <CACr-zFA77ogDSNEOGd32Rdh3geqkL25T0BKtNdKzUdjrL0+9RA@mail.gmail.com>
 <aCw4EK_8C1KLb6MD@hovoldconsulting.com>
 <6612cd14-8353-4d3a-a248-5d32e0d3ca23@linaro.org>
 <CAO9ioeWeQ++qSaD5ukooqBg997=1pwwS80NHD_xiHz25ABmtXg@mail.gmail.com>
 <a9df2561-95d4-47a5-b5df-5874b71937a6@linaro.org>
 <5d86adfd-e16d-4072-b5a8-4f128a2c9adb@oss.qualcomm.com>
 <aJC0GLAeGneb3WFR@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aJC0GLAeGneb3WFR@hovoldconsulting.com>
X-Proofpoint-GUID: 7WSI5jTWDzzrWeXaPEj_XHI03QjD8tWw
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6891918c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=NwXsR5GU8CxyA_XcHSkA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 7WSI5jTWDzzrWeXaPEj_XHI03QjD8tWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDAzNSBTYWx0ZWRfX5Pd3t0RQO3gb
 5HjFMiV5FOpSlYnZDYMlDqhGKY2SbtNmgZTw6nEqVxxX+4GB+AeKCsrWJ8R/TuF5LZffrCGImCD
 VwPOn+wI5fXltyTUNKwAuiyEW5QwUiFUHqCSSzPgH05nwV5Y/IyCVEFlqD0iGzgDToPKp9L9DZZ
 bcAibKU6w6ccUpuihgNIVEZTqLS6NmpkhepXXsQDebiwGbfPXMINEaVNy/i13Jm7aIyfqZU38Rr
 jW91dRob6sl4y5dCV7lpwBmgBA6hCFnW6Wnb6zBWjGh19PqGV42nDwfTKiFb6fuPvwVIDSILO2U
 gqNHDMErdzov2Z+r36eyPKdqbkup54qq+ZPNR5B8mFFnXz8rXsTSfhRW41m5GpKrbP7RPI57gQ8
 tsIgTZvRQixrp7za1iA00nhZ6b4QSkR+77beG5jKwcx5iC9VzwnZzT8YhWMaosYO7pdLkCl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050035

On Mon, Aug 04, 2025 at 03:22:32PM +0200, Johan Hovold wrote:
> On Thu, Jul 24, 2025 at 02:09:10PM +0300, Dmitry Baryshkov wrote:
> > On 24/07/2025 12:42, Neil Armstrong wrote:
> > > On 24/07/2025 11:32, Dmitry Baryshkov wrote:
> > >> On Thu, 24 Jul 2025 at 12:08, <neil.armstrong@linaro.org> wrote:
> > >>> On 20/05/2025 10:06, Johan Hovold wrote:
> > >>>> On Fri, Apr 04, 2025 at 02:24:32PM +0100, Christopher Obbard wrote:
> > >>>>> On Fri, 4 Apr 2025 at 09:54, Johan Hovold <johan@kernel.org> wrote:
> > >>>>>> On Fri, Apr 04, 2025 at 08:54:29AM +0100, Christopher Obbard wrote:
> > >>>>>>> On Mon, 31 Mar 2025 at 09:33, Johan Hovold <johan@kernel.org> wrote:
> > >>>>>>>>> @@ -4035,6 +4036,32 @@ drm_edp_backlight_probe_max(struct 
> 
> > >>>>>>>>> drm_dp_aux *aux, struct drm_edp_backlight_inf
> > >>>>>>>>>         }
> > >>>>>>>>>
> > >>>>>>>>>         pn &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > >>>>>>>>> +
> > >>>>>>>>> +     ret = drm_dp_dpcd_read_byte(aux, 
> > >>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &pn_min);
> > >>>>>>>>> +     if (ret < 0) {
> > >>>>>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read 
> > >>>>>>>>> pwmgen bit count cap min: %d\n",
> > >>>>>>>>> +                         aux->name, ret);
> > >>>>>>>>> +             return -ENODEV;
> > >>>>>>>>> +     }
> > >>>>>>>>> +     pn_min &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > >>>>>>>>> +
> > >>>>>>>>> +     ret = drm_dp_dpcd_read_byte(aux, 
> > >>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MAX, &pn_max);
> > >>>>>>>>> +     if (ret < 0) {
> > >>>>>>>>> +             drm_dbg_kms(aux->drm_dev, "%s: Failed to read 
> > >>>>>>>>> pwmgen bit count cap max: %d\n",
> > >>>>>>>>> +                         aux->name, ret);
> > >>>>>>>>> +             return -ENODEV;
> > >>>>>>>>> +     }
> > >>>>>>>>> +     pn_max &= DP_EDP_PWMGEN_BIT_COUNT_MASK;
> > >>>>>>>>> +
> > >>>>>>>>> +     /*
> > >>>>>>>>> +      * Per VESA eDP Spec v1.4b, section 3.3.10.2:
> > >>>>>>>>> +      * If DP_EDP_PWMGEN_BIT_COUNT is less than 
> > >>>>>>>>> DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN,
> > >>>>>>>>> +      * the sink must use the MIN value as the effective PWM 
> > >>>>>>>>> bit count.
> > >>>>>>>>> +      * Clamp the reported value to the [MIN, MAX] capability 
> > >>>>>>>>> range to ensure
> > >>>>>>>>> +      * correct brightness scaling on compliant eDP panels.
> > >>>>>>>>> +      */
> > >>>>>>>>> +     pn = clamp(pn, pn_min, pn_max);
> > >>>>>>>>
> > >>>>>>>> You never make sure that pn_min <= pn_max so you could end up with
> > >>>>>>>> pn < pn_min on broken hardware here. Not sure if it's something 
> > >>>>>>>> you need
> > >>>>>>>> to worry about at this point.
> > >>>
> > >>> I'm trying to figure out what would be the behavior in this case ?
> > >>>
> > >>> - Warn ?
> > >>> - pn_max = pn_min ?
> > >>> - use BIT_COUNT as-is and ignore MIN/MAX ?
> > >>> - pm_max = max(pn_min, pn_max); pm_min = min(pn_min, pn_max); ?
> > >>> - reverse clamp? clamp(pn, pn_max, pn_min); ?
> > >>> - generic clamp? clamp(pn, min(pn_min, pn_max), max(pn_min, pn_max)); ?
> > >>
> > >> Per the standard, the min >= 1 and max >= min. We don't need to bother
> > >> about anything here.
> > > 
> > > Yeah, I agree. But I think a:
> > > if (likely(pn_min <= pn_max))
> > > is simple and doesn't cost much..
> > 
> > Really, no need to.
> 
> It doesn't matter what the spec says, what matters is what may happen if
> a device violates the spec (e.g. if a driver triggers a division by
> zero).
> 
> Always sanitise your input.

Agreed. I hope Chris will now post v7...

> 
> (But there is no need for likely() as this is not a hot path.)
> 
> Johan

-- 
With best wishes
Dmitry

