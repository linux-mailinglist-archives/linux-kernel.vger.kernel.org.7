Return-Path: <linux-kernel+bounces-831289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CFB9C48E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B35C4E02E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F1928980A;
	Wed, 24 Sep 2025 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7Cyc/G7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E85288512
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749867; cv=none; b=lW3Vd78wQY+pucixJCoJg+BSvJXqcorsQ6j0jxL2BQJgYSU/OLTUVN+6RLTva7ebj8LE+xkR7Cj/Qt/x346gaMS0/HwhWoKp/n2TgGfQZUurAjdFUnpAYIfx2gzcmSgJGRnsIXyzX1lGLDuCErsIsLEPZn+zdsj08qrIPjeFZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749867; c=relaxed/simple;
	bh=m8y9GiGiDLlEWqGmp4t+Rh3XokhbDAVR/aMl9X3kaNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmmC5XryyJi00qQFuYZXBVK/FGUA7CRUdDRbz7zW1CJNAzYV0PUz98FQyM+HyOaA7fdTHaZkFWdOExylLVKgPmTt63vZN0DYAsYiIPxg0ZDJpYgYcpvcqPDYiazIv12U5JX4W/iCNzMhaAbc4wZr1tnBIUotASZsz+xx5taa2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7Cyc/G7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCsePh002662
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+LWMcHOEBBSjIu6HjaNRoCnF
	ezg9WxmzMxfF9Ioo3lg=; b=o7Cyc/G7RBSpgg9BOs9QMX6PPXKdt628WBxpdfoy
	+D5exQ9zoKhoEKG5k8AGEXEN6ISVyvgb+lWeVpNAkrxW9dM2QZYbdyimEI5jLJD8
	k+Kwka3Lo1k4lqh8iJ1vV+nAa4xqRcBcgw3jSsFGOcnOu5vNne4cJzNc1Z2llJ+z
	ZVDBgDYt0ZcgH+iMIdc2x73fcswl1rZpyR3TlS9b4L+1mCRm5GwwA+J/dQ8SgUMG
	3qG1pe7FjdBEyokycMviTqrOupZlRlCyg/H/iYQExDlI+f3HbbsannJ02pIHtHHM
	wyK5oJyU/blI7RtIFwSdI3u4IxBGcDIkfY3pomhxfedvSA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf0cm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:37:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5f31ef7dfso30602701cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749864; x=1759354664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LWMcHOEBBSjIu6HjaNRoCnFezg9WxmzMxfF9Ioo3lg=;
        b=pYGOUnGIxugR2c5yiSQIe7CG3mI0CefhFe0H/ujtn9Bt0wL8mH6GkGBjyaIlgywVrZ
         TM8PQAlD9rRVw7ilwuJZSbOg78IDsVp0fIQQbRuvIIQ2xtS5YT6ZergSxlQgdPA6RJ2s
         GDr8RwRMg3//0UQR00wtrcXsK/wELNeVSA1Mh1Gd2tEh/cd+jB/wyLvE4tK9iZaYrvUy
         hgr+ZEbxL/acE36uf8sfapgeqatEh5iR4uFJhPEyWUgCv+xaW+yL3IZXwFIAenqpyDZl
         rg9HZ2VgqeWuQB6twTTulVgPiiKg6Isur9+EAzjX+SY5PXt5aA4swzlA1bYGdjHs7474
         +d9w==
X-Forwarded-Encrypted: i=1; AJvYcCXhu9Cp76bP9ED28CI2cQiiqq0xl6T1I6N1X/IDOvpvEBEAtIeRRz1IVBR3mqU01gzH40tzemSBEnz01TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYx8C6HiVI4mNCJHPiWTvTykev0mJYGQBSH7rge3JhejOz483
	4ORMz9PpFtvZ6RTpy8ZBKC1W0AQVflSJALh8aW8bzq4tvobtomtcJ2tfVtI4/qQdpg1j9xIySEf
	c5yjeH262NlW4Ak/FC8wKEKinKm5SE/I7VlLKoIABkIfTko8vYlV2suizp6xkx1zx7kE=
X-Gm-Gg: ASbGncuaTF8NqqfwShXWiI+S5/V+kN4lyPGSp9/lCS6T7jWbC9j7XqL43ZTccRVlLV9
	nlyfJIlzAzUOKfibB2khknAltPBDE6VRay/AlfPbACOSEzGgy/MyQ1bIx2IU1KS19YTIQ0NbKpN
	Me8q7KvzPGWXPWPJJPxGVLWlXmhkMSPugoQrSrC6pOlYkIsaz7w10/iHpxQ2o8yWm0MIsDnnpgg
	JvD4xgbf0DgHgFnlIEW7Zd5HHLfr/PGCEYPCkNaCTA49CzG0mxv+J2BXdxx/ZxpQK/zZN3YTvFR
	10vGoe9B9xqOQ6FNF9IxKn7panMzufUajRY+6am/eBiztSmTjUzmLmtP9DK6tI7bnJ/4/+EXDlY
	ZX/5FOfrj+LPBLE4y0tYGpgkBoZKd4TVlwDrK8gbBtXPOyONOIjcx
X-Received: by 2002:a05:622a:1a17:b0:4b5:d6db:eea1 with SMTP id d75a77b69052e-4dace86a5cbmr4251741cf.39.1758749863876;
        Wed, 24 Sep 2025 14:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPfyIi2ayPb/sO/lv0mAYAzgDsHeJzF67rIJ9gVVx+aqAsQhGtcbFiIHBvkxUQvaj+Ma8akQ==
X-Received: by 2002:a05:622a:1a17:b0:4b5:d6db:eea1 with SMTP id d75a77b69052e-4dace86a5cbmr4251521cf.39.1758749863458;
        Wed, 24 Sep 2025 14:37:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb4772ca2sm680451fa.12.2025.09.24.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:37:41 -0700 (PDT)
Date: Thu, 25 Sep 2025 00:37:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/imx: drop unused module aliases
Message-ID: <rtzqwhocoa5hd3qxepuyitimlvrvecvcc57v6kynrnwbnwrfec@pnslpeadk3mr>
References: <20250924092643.26113-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924092643.26113-1-johan@kernel.org>
X-Proofpoint-GUID: Z-P934-d8GNNmLJUB99MYg8mL4LpNeMk
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d464a9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=biaaIsZr-oeAOlJ4UdQA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX/2kqyzNGd2S5
 IDIov0Yc3PxnKX+63Pe5gYDVWvXsepargCRnCQx84ecgKRVgmATTEWHbJkOtY8CL4oxbljFS9TP
 l3kk8C7uRdoqnvpy++PqnqJdb4wrI1/nrdCnfEg6m5y20jkZ6SG4DC8F8r9ldAejLwZ42e19OrC
 AThDbPIkvpEx/YFBpO6y+QiT2y0YL7z7qs8pPwbR+Ogq2AW5mntz8GKQ0zsMPzssmBkcinqvPfy
 wUX06+Ks0kTBsdw4EclmqvI8C16zUPiUhP/NZSrvt9gCvtxGXvlpUmCyz/jGTw3Lz48ZviR0pBw
 zIPpvxcrSFQCbeGnOnsq83yRF3/9nFRzNr5y2ZVEWXA7Hp4ELvDpcJux544BMeh3Q4Z47qnO3x7
 JIMmpzcl
X-Proofpoint-ORIG-GUID: Z-P934-d8GNNmLJUB99MYg8mL4LpNeMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On Wed, Sep 24, 2025 at 11:26:39AM +0200, Johan Hovold wrote:
> When fixing up a device reference leak in the tve drivers I noticed it
> had an unused platform alias. This series drops unused aliases from the
> imx drm drivers.
> 
> Johan
> 

For the series:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

