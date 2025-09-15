Return-Path: <linux-kernel+bounces-816956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE32B57B47
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BD33AFC27
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313A30B51B;
	Mon, 15 Sep 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCH8gLQR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07373019CA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939935; cv=none; b=SX8Er50pWVy+zi6rYsmF6V0QXqrD2pbNn0nZpaBnsddBKXwh6/RrqTGtF254hr986l5WhVXkoDLfQcOOTe921KVahFaYqYO3NlrCNuKHBwyjklxCIs9PY+eHbj2Io+IUZBxkBVoJ3gVF1sMQvpA5XXQ6aHAYQH3UrHI9Tnph8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939935; c=relaxed/simple;
	bh=W6dMFmWzD1QXZl7PwQPC0i3LVEeYf81dRJdikE9rIKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elPxe2bp3CF6TBX5cuCJo5DilITh/3sHqLJpcVi/LhV7QL013jZBbgN9KnFOFZ2I31IbhhnK0u+yqKZi3j3yhwH7SDlGIQEVw3bfRQvo1oZDPU8QZp5KjsIpPy4pwQtZkGjZFkykFDfN/gzVtpG7wCJ7yJOaZE+4idD2gDBkjBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCH8gLQR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fi6D008264
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Fmb6MUpiP+yHPdu02ocRwcBu
	vBIq20AZnHMtS+w4EwQ=; b=UCH8gLQR4RnuhM13UUbEDCFo0LFUiCeSDngCZNC6
	FhCOriPOEeljmMUTgd1lQA3lE2lsPd3MK7HKlDZ48Og7FI4FFko7Eb3Z58MY42bN
	5QEoaY+3If7yGjsug84l8ZpFNnFXFU8bcEtKU7c68fXSAkQIskrexRaHJG7u7Oc4
	NrARAjnSBUYD7c1ZDbGt11iYZ54DaWINQg23EUHoQM1lWloY8jP44S729E2TDRHG
	eg3Yx/o5SCV/+hnr6EvtLd6qE0RetYZzpEK4RfY9PX0/TBtLYcfB4ZD2nFHW8X6S
	FMZ9eVud1PwuqLLqKkhH5dj91WMkpAUrtcH4iaV+gwDxGQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpurxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:38:52 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-776164a4484so45431206d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757939931; x=1758544731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmb6MUpiP+yHPdu02ocRwcBuvBIq20AZnHMtS+w4EwQ=;
        b=qypwpENII25rep2nMUa/TPk+g5WNXA7u4WxudijRKm9t36TNLiBYWu6CMCIu/AZ0+8
         Cl+hdGkB42xX/xNcOTfF7ZNW4hcSXf4batYU9TqYIQqTYsYOg6QX+xCUFdALyJWHwtdF
         FhQsHacIgKEM0CG7CkfYx0qtQSRRVHuTOXOentmkt93Qn5D/XyODqhCECfv1BZbxR2Xs
         QwvcM4p57igz7iztxcwIoUZbh4o7X7qrRslFKkqQtxPj5o32ecLUMxrEG+CcVxRqVAYz
         SmPgDCNiOw7kbpcc+5AMfrAdrt+Fqd1TXGvL0WpV84kl9cI36yDCFv8SMZVv0DJAr1We
         3pbw==
X-Forwarded-Encrypted: i=1; AJvYcCUTa6bZcMVB7fWTaEtGO4Ub0wN/k+ZtA/rGmXGKwKgp/16hg/vWsnbbycD45hYqRfpkQLjeyVB0sqHZeag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YOkr2gEKqCtn8hUtx2fk484NKGeQGHrug94U9KkCdTpN1s5E
	pd08KhXKE6lsnm5z+WAYvW0fvFXwDz9JkyCrelwrTGRo51h2SJuqRzAv+YJZgfsyWWshPEZ/uW0
	InTBNkoZAN2k4P/06QjcVD/87aid+RZFh979mvdSqy5Sb3bdQd+OWBdY3lZgYkVrieSY=
X-Gm-Gg: ASbGncvArz3pui7bMlN5Cqk0AtnP6R2Xkzlb2mq9irI1IqxQT8Sddji2M1TM/kL2iwG
	PG+C/xIYhEJCE9sXcmBxMJ/wPDZKWUx8WX1bVi79gAccA1kvcA3Dy1+ZFe134U6kuoRTZlk4Khr
	dqzqnlmq/eNLBxFC951B1jcSbmY8DR5EQ4a/wViCWo++bnPKUWOippqqHmUEwtt5mRDltRzTmPf
	NVs8P5FTz8hBmt0mkpsz31x7E4uGkbXdVjLpzp2nxEMqqYQAXbiG2pcwGPmW0wYclLAGtYxoyfa
	GvAtOyvi+FyrGdWoyjauQf2dFzqiEem59bW1l4JfRwLekIW/evSG/396fKn77tPPGVlzyl0Ztem
	vcq+XShgqjQbPK1tfXj+h3lzrNiAT4cOneJcQbZNd19H7EP93aKwR
X-Received: by 2002:a05:6214:5004:b0:725:f1c3:2ab with SMTP id 6a1803df08f44-767c1f71efcmr141751116d6.43.1757939931362;
        Mon, 15 Sep 2025 05:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQ/ky4PMlA94VBI8Y6iP+p4utCJhLTah33pyYzU/Wknu7JOg31Xy7D9L0TMZRcWSzS6GnLA==
X-Received: by 2002:a05:6214:5004:b0:725:f1c3:2ab with SMTP id 6a1803df08f44-767c1f71efcmr141750666d6.43.1757939930802;
        Mon, 15 Sep 2025 05:38:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a547ae5bsm2588322e87.19.2025.09.15.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 05:38:49 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:38:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, dianders@chromium.org, m.szyprowski@samsung.com,
        andy.yan@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Reuse
 &link_train.training_lane[] to set DPCD DP_TRAINING_LANEx_SET
Message-ID: <cen5nir6tn4ah5z7vgp6k5lxy3cobgzjzm3xmx5hjklr2fsrb3@cx3n47n3ji4n>
References: <20250912034949.4054878-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912034949.4054878-1-damon.ding@rock-chips.com>
X-Proofpoint-GUID: jP1wFbIV7j-QfGJv1P98vRhnNeszzhxQ
X-Proofpoint-ORIG-GUID: jP1wFbIV7j-QfGJv1P98vRhnNeszzhxQ
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c808dc cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8
 a=plrDVsGnED_3QBdGXOcA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX2Rf4cvoVEgYT
 cNmc0K+lk103qe2bmxweJ6AshtZvlPqEvOX0PI7rMutfIHui+iyopFhylsie0JlIaTi0j3g6ply
 pBfpubx2/Pa+MoyAt6QZcPjCtQtt0Q/OurKE5qHedB1N+kkk/48hSfqVVg4Dy2XkHPFxT3pj2b7
 fqIjL/7T1U2+e9gu16Nge9cYWbtEghKRjJUFkjZ5+UrkIBiD8WbHvbA4IH2uv6ceAHgyBFhSQ53
 B+WfezNixTvSw2DWq8iWnokoTR2YWePjE0ANozxgf4v/Hl8X06sYYCGw+9uLYDbKse+5ddXLEB/
 ePB1NZAgBvx4sCedsAOyX3AmYMvJthh3bKuPWRWgVkQt/ddQX6rkMOwqWIkPtsPxG78UM+iwVfl
 FOfQEvcN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Fri, Sep 12, 2025 at 11:49:49AM +0800, Damon Ding wrote:
> In analogix_dp_link_start(), &link_train.training_lane[] is used to
> set phy PE/VS configurations, and buf[] is initialized with the same
> values to set DPCD DP_TRAINING_LANEx_SET.
> 
> It makes sense to reuse &link_train.training_lane[] to set DPCD
> DP_TRAINING_LANEx_SET, which can remove the redundant assignments
> and make codes more consice.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> ---
> 
> Changes in v2:
> - Add Tested-by tag.
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

