Return-Path: <linux-kernel+bounces-786370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B4B358F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7300B17005A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D503074BC;
	Tue, 26 Aug 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtYTmx7o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6530AAC8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200764; cv=none; b=rJyy4JIM8NOaazBZyfX1iF3AXukAPmnzhDKIZLKqmRVGiJuhaBlsC2tmqXDqieSPz7ljIj/Lh7rlsgxjwQ8Pb/MjWIvqaniPBIHXxulVbTERP8B5dbXEuQhnWqfDhWzvJUhyXXLdE+x7hEGEmiPNdBhZApVpBxkUZVezb0Teew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200764; c=relaxed/simple;
	bh=oTaKC1uCyo1lYnQ7uFQQm9lWFtm/uPvEC7t5hzGGpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNmC/xQkWPNMTaoowP0f/4j2U1f9/WSfEx+k3mXBfV4W53232n7R7Fvbl7jGkqJxCUXTTp8+KCRBo2XkbX7MwNyN170kFPtQLl8fHWD/xJbaFewyZdaYwPJ1zqxHvhwekQxN29Ejl8OMpm8ZLuHHOBJALhz1hJbKg17CjEFmrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TtYTmx7o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8Mclt000529
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yw7Fk6HJCJShlv2t9i0lzWI2
	sWKEgdH07td1ipZYTIs=; b=TtYTmx7oQltxw6Oc38y1ihdCLJNaDUO/XHkY7JlG
	iPA1iHeugl7VmWmaaonhvIPPK9qZhmH3WI8oZAfLk6S73i8tvYZMWCV7mW7fC20q
	IaQeEGyhU3G1TQL5c2DbLUz7AZBanjz1Np68EEFeS0eFhGg8xdw1GYTGR2umic8y
	1G6HQ3PHk5H7Cs7dQ3v7/oeu0ykQ3XwpRNspfepw1o7mEx4AfjkWALD8xJjhB0Be
	1GTW83bNMF8D6S9K8uYTymXR2Er1WkB6zGBiTEME2wLXtGn2wgrD86vftJh9rElT
	0pM1wD25Bi916ScgX4hSJm8Z5bNOk594j6DhyimubANMSw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfg82t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:32:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109c4c2cfso204327531cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 02:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756200761; x=1756805561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw7Fk6HJCJShlv2t9i0lzWI2sWKEgdH07td1ipZYTIs=;
        b=FVDGBMDElXZxdAx+ALfLVMWp0Lc1q2gdGXuWueOwFRkfkZHPRMyHYW01ETgPZklpw/
         F7uTGvtf+0Y5GFUG1Gd+kq9m0J6pJTNFo3/6BXlz5QwYe5gt1gToIojFOjYoc4qn+TnM
         hKSM8F42CFtgj60nLPC9F4sDqGGCnzhYturqsXoozGONPRlaRhE80mz8Gm2yvELWH/Nv
         6JSLBzEc1SIeuNdrORKEMpk2pQ1avjZmp6XZq5NbtMqZ3BfBw22VJMgeBIpKjB8wFrH+
         dGV8ELjoIcX70ejZ2Kpt4OBvehY+rwjn7crZXrwsqi9HqeY121LgkuYY8Gzl/3UmX0l+
         N7ng==
X-Forwarded-Encrypted: i=1; AJvYcCWTaGlLAMyuIV5ym0BoDOAsCfhV6TRvuj9nb3k8fVwYsL8Wv2A8U2yKTjgCsFDF8yWf0fBMXXWQVzKZj7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8YV+0N85mZF6pierLp3R8S3eW8mmVivGrkYIM52tFxT/Vt9t
	7HZOn+BQVFKDp3TOVhqqFGX0372Ux2cxuriv5mtea4YgkLtof6pBRtDzC/2sBp87JvfmiP/lQ4B
	x1KLKILdSQmn77pvl5+N8sBU05fSKEZA9boZGX3oUJ54PIZgq5rqa6ryxlQdRn3BrGqI=
X-Gm-Gg: ASbGnctC36qmn/uJXRT45g6hU6iKXq0mIbMm7YXmbxEqImL1DzXo2WzfgQeAflPMneq
	5wHY80JRWE6Fk2tj20Zdr3LBBOz1yJxZoGBlnenakvYmP2Fi4QuYnkYe/cLMMAV/lLPzpnmxLHC
	NvQT9H7J0BUbNz2hViA5YDpCxxus1cq+E3VLmp4gxzIOd0AWMSl4bgV2SmHOsl1ZKt3eBkyj8sn
	kgAL8CCjb1uObGJaBxrp2P2c44jGkNqJBYOf0miAZdhMv9Mq82xy8boIiDzpZ0u3dg9jbVq9uDZ
	BQoIasIS2F1qm9WgIxcgSArq0uwarWQ6cnIRYlUTRAScs+UHndWzD7GUYcnOEQV1DM++hUrqDZ4
	yejTfMzSWzvZgGGRb5UNrNtFlQPzC7U8TN2qX7satYTWw7x9HTI9O
X-Received: by 2002:a05:622a:544d:b0:4b1:c29:22d9 with SMTP id d75a77b69052e-4b2aab66b5emr196220481cf.58.1756200760483;
        Tue, 26 Aug 2025 02:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Pd9IGXO+XQ9K5LfqZoyJqKQgbNRBf/lZhXlh2ogmR33qnivK3QzAsXMGZxpxVrpfTu0QvQ==
X-Received: by 2002:a05:622a:544d:b0:4b1:c29:22d9 with SMTP id d75a77b69052e-4b2aab66b5emr196220251cf.58.1756200759935;
        Tue, 26 Aug 2025 02:32:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c9a1efsm2142240e87.118.2025.08.26.02.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 02:32:39 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:32:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: fix incorrect type for ret
Message-ID: <m22aqeeviic76y5dgo6xgvlc6y3nl6xa34gnznp66g4exkgtce@eu2ta774tekb>
References: <20250826092047.224341-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826092047.224341-1-rongqianfeng@vivo.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1tndUYFIM/z2
 VeFW2JcqYCLs1vNV40G6iuu0cw+VmaDpBaH/ljvTBZu8REnbTPAzhF2Kvf6fi8F9DkC6q8oA4Sm
 BLcSSW7OMCPZKZ8l7FTpRzrWlqUzxJUbPMYjvd4oPmxkikbmG0ENcCnFjaAcXp3970goic87UBB
 AVh5doISMWby/Z+ztP2WJPQDMIRVtkVS/OjQfekmmrS0e6cEUnk8ae4TiXpM03nsyXpliKTL5+r
 q1JMO+iIGMZPSS9bS2ecUVgu0B3O+7S5wAKG0KE3KdZWd7lkWK2e3eLdkYpnT8s1J6H5gs5hHGm
 9WCg/6CZGLY85fQhnNTMBW2dZPsdS3/9CzoSQjWKyaJMzksQk0mhM+7USdIrNUhTkILUh+qnw3Y
 WUeRRjnS
X-Proofpoint-GUID: jdx8sZvmN6q029jUA84Hr4HovlVe-GG4
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ad7f39 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=b381tfKDLOYfEgrzl5gA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: jdx8sZvmN6q029jUA84Hr4HovlVe-GG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

On Tue, Aug 26, 2025 at 05:20:45PM +0800, Qianfeng Rong wrote:
> Change 'ret' from unsigned long to int, as storing negative error codes
> in an unsigned long makes it never equal to -ETIMEDOUT, causing logical
> errors.
> 
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

