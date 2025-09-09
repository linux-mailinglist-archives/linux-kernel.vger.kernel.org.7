Return-Path: <linux-kernel+bounces-808405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2EBB4FF5D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D831616C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E9C345743;
	Tue,  9 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prmUN5Zf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F383451B3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428029; cv=none; b=L3z9JioBAxnHsxuMIsAqYrBzKL2F4RsA9V/2fcXZWNJZUreqkiANjZXeLJnWoUilPzfl+GTOFUAEqJkbAhlJS8qJpSSa9/lpIPWAtLOGJ1dPkeeQUUFJEDGTTRxHRQnmPFzri8G3Ozy1GRJQeLepG3ReunrqHQe+gHJqnsWwBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428029; c=relaxed/simple;
	bh=oTaKC1uCyo1lYnQ7uFQQm9lWFtm/uPvEC7t5hzGGpb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgzYHKvz5SjFRW/1QYNs8ZeXiJ7ZjqbRUT7XyFzB7wteRdxw6ie+b/VBnmAA56/LMINuza0lF3lWW3BN8vgbXR01O2x9acbCqPYRv+J7V1wb5BVK1K1cvXMwicGwe711qBe+QuAZu0m4paK9Kgs+mx7noWWtmHS/LmJpCWU4Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prmUN5Zf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LR88020094
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yw7Fk6HJCJShlv2t9i0lzWI2
	sWKEgdH07td1ipZYTIs=; b=prmUN5ZfV2hLIGaofH/Lo4W1DdveSATzHd0W0IGY
	+iGzvRjaBZOviw0JVBOne0VMAa+xYjaJQiz9CduoXpnnMFj8myq2+RoJJwkIZAhV
	h8O5fVMVFTMO9/Z4xQZYjxyatQhApvQuM9mcX6EnlzOCQE2RjLGjogxOdG6jS3NP
	l05BHSwOiOV+FnYoz8oU0Ae9nK0DM80ZrlCHd2ufB6rkDVUabBYAJ/wSquyw6+jL
	5sQFL8g1g4VpunkQnD5YzaXkVu+xK5+CIKr3OeCm916HqufXxQTKUYcIUSiZIZvp
	JAzoncmj6INosJaksQzgooREOCMWW2wTD+y7Q4VS2pmuIw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc24hfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:27:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7222232859fso111748846d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757428026; x=1758032826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw7Fk6HJCJShlv2t9i0lzWI2sWKEgdH07td1ipZYTIs=;
        b=cGWCSfbVMIQOFTZQfS1ltfg2vNt1AV80IDsOzNF8JtvFoHLFXyjXZX+MOpIVe86Qog
         /vqZq2tHbxkjkxMjuPLDtQKcZJXGrR2AHKo9+S4D6A6ex5znEAZQHZGjrSgltRo6OAh2
         bALpgeFYufcahN3w957vsM8vSC/U8INNd24k+KxWXNoJQqtvpCA2Qc6CKxxYXyAED0Je
         pIo31OKPW8zvlQV+jqaa4C4GUoJVUQwOAlW8I7XJWqCAwwGHefUvcJg4TjLeMqXUS4UC
         juFTlssu16MeEj9gCeupt9Hx9RfuAjNyM5L9XxpjlDQjZOZ07Mx+abvua3vjMiMmHkh8
         3ETA==
X-Forwarded-Encrypted: i=1; AJvYcCXVtzFwOc74iq5oo0fFWF1xOd14VDWw/NqQso60tSQmuzyfA9rwJrYlSIG4tMEtYJAk5+MXhu8h1JhKlrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6DeEvUBN2mIhr4S5Ob9w85NgPR4GHgvlhQKcIH7aGyUNfeEoZ
	drEGt4Gv3lykgcZ7KFgOLC7QoxkmgOul9u+ZBaKs1Qb6+QSSgrWuG/nPnqGLa79vt9qil2qpmX/
	X5BwZOKjizI6X7u1KXIBVrE5XhRRTpWX+rsm+EM3UudpUQ4nogDaIavQw/Orr5rRlaQI=
X-Gm-Gg: ASbGncuOHNkYN/FHNJmFGPgWs0ZOacxVjxSF/+CkxtleNtAW/q96zHwZd32AGAq9qhq
	Nv7M+jyHjUBLJEQEEj0U3vRflIxIvuSXLzPvTbvB7ZlcqsMBAS8CVZhTLuUbr+TaStlLbek0mKM
	8GnrE0yGGQGNtmvJ4JhRynLOA6ikmqjyLOmfZ7oDknjkAMlP8jzGq0PBsIggd3ttb/UfiRkuMZk
	oj4ybapvPEsw89kRwrtM9sPyT9RFuz7TqCz35d8PYRBpn9xHdY2PKR9l+2D4yKR5aBYNTr2YP9L
	3oaQTNJLA2ikZbXgcwO35npn4UkkUTojbc0OkOClx0d9BG+LAGoN8GThzXl4yogx7Q9M/P4zAVt
	b+rBfFuuvAj3aurn7y2XtZzoUGjJTxroMWId4Gpg/g8FyWHUudulA
X-Received: by 2002:a05:6214:1c82:b0:725:1035:1dc6 with SMTP id 6a1803df08f44-73941de2c95mr112160736d6.64.1757428026205;
        Tue, 09 Sep 2025 07:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj+Rvfz7tyFBU8l4QDVUaGg1lYtPx2BNUi8Rc06dcrMp5ZpK2kuCy0o8urhbMPnh2qES05Fw==
X-Received: by 2002:a05:6214:1c82:b0:725:1035:1dc6 with SMTP id 6a1803df08f44-73941de2c95mr112156786d6.64.1757428020517;
        Tue, 09 Sep 2025 07:27:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680d0d8435sm560419e87.63.2025.09.09.07.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:26:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:26:57 +0300
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
Message-ID: <6g7kftcagecmbal2oclxtmjjbi7wc365nb5wv7jhvyzbttcjz6@kxr6oojsvg6k>
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
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c0393b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=1WtWmnkvAAAA:8 a=EUspDBNiAAAA:8 a=b381tfKDLOYfEgrzl5gA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: EZ5NmVDxVf1JFFVQqcjLN_ZE4ZLHRSQf
X-Proofpoint-GUID: EZ5NmVDxVf1JFFVQqcjLN_ZE4ZLHRSQf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX5J7V0848UeGn
 949s6ZNuBupGtcuiSOdXos6MMEl97fptvqaKzVOGbB9qMuTMxODHDXlHgiPQuIG+iye3qH/HnBO
 +DQbDTQwTuVw1B8oJKPVbnQ4DWeQnvpPjtYnBOntxYNNXdyYraBzs2aPMFfEhjYus6Ywc7w4Rv+
 xmBukhC39BIuApQExR7wA/XYVvp5+Pmw6QnUMvgDmjbQPm3rGPlCpliPqBdvhUn3kEoMOT+a9uD
 rdMZxBq+Cxx0B6+oi9TolYIkKSHUJOI6KKSU2NY8eL4/NQ8NIbAlRs6BX2AxlMYqv76rgyCKVLp
 HZyeITl7hgdvkcq/CE/hZ2uyeMXUXdMIqdm5tXX/Hp0puc7AeAPAhN8HCtiZC13bb3IfF6o9iPT
 CZm/1uZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094

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

