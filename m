Return-Path: <linux-kernel+bounces-737685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E410B0AF56
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 12:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B911C167A2E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 10:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AFA23536B;
	Sat, 19 Jul 2025 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P7qGKWCl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F4148838
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752921160; cv=none; b=cJXRpbEwGEbT31OZ0mEkyAbRPYK85fL5TGLBNA5RTWBVLY4zl1I2JRcALZc8kTqFoxdDH3CEth7om65I9Ve6lqM7xBcJgMguODWbLWYfHZunogPp6UmUFY7kNJcSvshk/71re3YA32GcqBIjCO99YGoF8wO5OI/T4drr8zI8dJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752921160; c=relaxed/simple;
	bh=T2ye2l75Lj3Lleb/xuoPqhp7Wl0OEMA5wv/bIJGwIgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhASatedUncXwjlWZbNTficBzqlYMIEAWtmT570Ww8qMc8e6t9ZY5JSIvsCYT8aH9Z4XeiHlKAsq17DzNVJoxlVFC8FMPs05GlXPtiAnnX2492nloHStYt79cJZ0zwpgt2H5V9YnxxucDCcnZG3WdYn1CjaSfqA92Fulon19qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P7qGKWCl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56J4eFdg004402
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G06iwEutK3GO5lHqQU1Eqf05
	c4jNYrzpMWxGrGkxhJo=; b=P7qGKWClADMSME/mv2lvSzusTfdruXgsRvc8STfH
	rN6Byk2gxnN+etDjq70KR41ths+fuho2v3STtqSh0tp4lPiHC9fiMDYUD0aJI8DQ
	+djVqF4dCoPsjS4LP665vLNdGR8FbtRXYnKmH840WfZwIIpMKyiaVMPIqJedoDZJ
	16o4k0CoW3k0c89dJc98bnuZTsoZEzm5N0Y8liCwMh5rhLZhz6hg/wt8zyRUBudw
	8uoPAxubE5n0sraVoNcJKaHkjB1m6txCpveJJi6P7+oP2TL/mZg8xTZXQFzG/hGE
	KBXTCnud/NFFzGXHBO5eHH+UtheMEshZtHfkGpVi/4joqw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804hmgepx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 10:32:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5cd0f8961so532953185a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 03:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752921156; x=1753525956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G06iwEutK3GO5lHqQU1Eqf05c4jNYrzpMWxGrGkxhJo=;
        b=ax+SOprlpL6LkVvLFeyw5Y0NyDCs1wtomxLqFwL7Z77rsp3LUJnYu4gCd1S6YyqjKC
         hqeCbRyZhrGlXQgxxsSJ9K18hEIzSJoZeQt0OT98B+KZRG8ncD5PCC+DO7aMDXKilg4l
         sEOYiVyYFNQdXYZLOcgEIZxhp1rVWkH/f7HX3ceGj8nzWrXzEvRgJYFWFiL9nqRK6gOn
         N6oYbAa7qQ73fLQ0eVjcl8DaxqILY3wjvFT2JOv0xok62nqHZC+EJNKb6MdTtdNWYgJG
         AE+JLxOGksww6OlogRnicHWGaUA1Eh55Kccz9jMT6K6WsIfCOUmdYN132n2UjSXQGCpy
         VPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/QAXkOkBagmbASxb3iMKiiC4Ewb4nXoJDjl06dHX+sJWtiyBwnAr7htTjU6EbcgdfymHXLtQOIiHYXMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MpLMwTEbJLVjy/ooNw0oQQHxLDCTNrS126qBVuFwS862jpaC
	p/rni+t7FURi/jEDfZ252fFBqtxYJxsfZinkg0vBTEfUVlJda505csLRU1lSWKpKPo98YGX4sem
	1xnqenW5i2c+LoxH06TSXwEeiz8BuB+3k2/o6D6stj/RIPx9MIE+4NnmHgBReLXJuHVw=
X-Gm-Gg: ASbGnctGf46EiHEEGmaSyHKaomHg8qfsUq5Ix/r5l4GjURZ5Nfc5iIXknSnEjppXeJW
	2HiJsrahr2rOCSq7nOEVUF6n/YUzCI5utdmyrcu7IjqNwRY1pdEPyEUP1CqPSwo6wrmMaBvLtfe
	zdT7uA3nadLFL/+NXu9eLtnT8kllJ1S6frUeR5fLwaJTgHkY+2AHUafFpAhC+XPwovKvYbw7DMG
	nGjHoeaJIzRX6VYg3od+5yQDFP81rUxWLmpFyD3vhGDH27i7CnDdBR2WZLyO4ElW4r7KteyWSW3
	et5Fa+r5zCJR0TCLKDVH9TnyOj8d8MRSbDIz3W6qTiRiE0YZ1rpg1pe/FwtxYuE8RoW0U+G+Ror
	ezRTM2rmh3wo/RsV6HekEQ0U0OYy950iA8sayzFVr055H/O6xaYDt
X-Received: by 2002:a05:620a:4413:b0:7e3:3417:8c80 with SMTP id af79cd13be357-7e3435eb5c8mr1843006885a.31.1752921155724;
        Sat, 19 Jul 2025 03:32:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPks1HjgTCMsnblTK4TjsiAlwy/vjObFV82l5OdaaO+bcfhs7Bu3VSA6ZEe50HuSOATIjNgw==
X-Received: by 2002:a05:620a:4413:b0:7e3:3417:8c80 with SMTP id af79cd13be357-7e3435eb5c8mr1843003785a.31.1752921155315;
        Sat, 19 Jul 2025 03:32:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31d7c226sm658791e87.85.2025.07.19.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 03:32:34 -0700 (PDT)
Date: Sat, 19 Jul 2025 13:32:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: dianders@chromium.org, tejasvipin76@gmail.com,
        diogo.ivo@tecnico.ulisboa.pt, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v5 1/4] drm: Create mipi_dsi_dual* macros
Message-ID: <arbdzp3r726vvfwds65cw7thcvxu2hpnwbjwdb4u2rgm4irir5@w25kvujy36kf>
References: <20250719082639.307545-1-me@brighamcampbell.com>
 <20250719082639.307545-2-me@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719082639.307545-2-me@brighamcampbell.com>
X-Proofpoint-ORIG-GUID: EjjE9XZXFTLZbOuYSsckRj1B8WiQJnR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDEwMyBTYWx0ZWRfX91k/aTDF2yFx
 ZxMFANyYidlsh4QivrC76glqDjapaoFeAzsIkoFx7PHHPxv8hpitfzn8wybN69D9RVAEIejbWeh
 QVFgCoFFYTL4t9YiYuKPwdc+JETjb5R/F8VVvM3V2KRk3dReV5t6KiwzyCMVJXD+D8dT/0oyY1s
 joMSi8rsoZyvKRc8ZBVkAmlBGTSy5UjHBzo0+tW/QQhkhnz9V8nI0tvOKknK1wmoLV/ooM60/Uy
 8Hhakp3ZDC+kXMTEP0ArzVd7oRI6UR4Hk+e5XvtzuFTbHnZUcP46Yf9zsnsafbtG6t7VWiVlb9s
 sE9OXEmjEw7yg0NvKVBSCQZyNkPy9mog94wSAUoSaLQ8OS7N22boVuXCUoZgvDHMS6g2DvWHE42
 xsx0vCLJ/del0naQEn9jzyYOD6gkfVQqqfAe0cRtnLTd+PwYGF8G3+E/5M4RBXmHBtsPWHMS
X-Authority-Analysis: v=2.4 cv=Navm13D4 c=1 sm=1 tr=0 ts=687b7445 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=wukD7SXyAAAA:8 a=EUspDBNiAAAA:8 a=n_CNi66bQm-mhO-RI4YA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=n7THaJik3DRP1sDdJiGm:22
X-Proofpoint-GUID: EjjE9XZXFTLZbOuYSsckRj1B8WiQJnR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=665 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507190103

On Sat, Jul 19, 2025 at 02:26:35AM -0600, Brigham Campbell wrote:
> Create mipi_dsi_dual, mipi_dsi_dual_dcs_write_seq_multi, and
> mipi_dsi_dual_generic_write_seq_multi macros for panels which are driven
> by two parallel serial interfaces. This allows for the reduction of code
> duplication in drivers for these panels.
> 
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
> 
> mipi_dsi_dual_dcs_write_seq_multi goes unused by jdi-lpm102a188a. It's
> included in this patch for completeness and in anticipation of its use
> in other drivers in the future.
> 
>  drivers/gpu/drm/drm_mipi_dsi.c | 48 ++++++++++++++++++
>  include/drm/drm_mipi_dsi.h     | 89 ++++++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

