Return-Path: <linux-kernel+bounces-755150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C02DB1A22D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD41E7AC222
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350B26058D;
	Mon,  4 Aug 2025 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="McHctA66"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331B25525F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311581; cv=none; b=UNF6ZWDSkcW32PbfYGBI2nI9MJl2trGr96eEf5MGJtYRzY/3oclUWXEO5my3QGeubd8tSA+4WTFQgZyEIhlKcmb9AE2dgPTjcdkVAo5wkeLCwDeiDypUmoNqYdviZsgiRqs/SDg5rSBqs6dlJgR2JERJSk2WqpE50sNrmuQ3fzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311581; c=relaxed/simple;
	bh=rM6WUBKB4nM1bTFF5efRuiq2r6zvWYsDnKyHNwOgRp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDncfUyv05aWSM91o+Ld9ShfPCeKDLL2MUP+SDpamILrg1aybasRwZlDL3x/KcZGVXWLBYfXQjyO39opUPZ0RwhUUH0/vZLuilNvJDDXVa9uagsRq0TEs/DSZw14zDtBebJjSCufWb8st5GJQwZI+rS5APPqEs2QB1kQWXqfswc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=McHctA66; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5749GoXI030010
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 12:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=srJNkV8mi/T3+DZb93ch2hkK
	PbbG674MuA3RGQ20bB0=; b=McHctA66Bgs8D1rMerh7ta8TOsGMjNF74+GhUZNB
	iRmxL6EhwTlWsCSPQtSTe1PZ09+aV6cXYwFuO6s042TBIpTDdiIcwzK1n7oRxaPq
	p+TibN0ZEzGUfDJLtFM6D0D2ZTbaA6ycMyK8cr65uYDsgrDfSeEZzQNnJFpHk4zR
	Ms/mccru8rJ0kBSOeL7qxXQvn2JL9YB+ZWsx9bTGoMwfCN3pR8tSrK25VTsdF/oT
	ArUBgWyBDxa7GkqfNNh1fKTINPKXnVYNGFztFVEVHAnduCmPMgYP5hIVSvSrr08u
	RBckhVA020jcfoMSlC3wcGHGK80QlmraG5Ok9efCUqiqXA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rn88b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 12:46:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76b857c5be7so4403253b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311578; x=1754916378;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srJNkV8mi/T3+DZb93ch2hkKPbbG674MuA3RGQ20bB0=;
        b=TDHeE4luofmVhysUTgcGUO9DneF0IN3DwVK8hSHliCQ5pKjeAVz0aZM+XyPZlzP4/n
         gaLj4cMbQtujQ2lgVPEKQepVOLN50OITYUtXKCKN6Sj/ipH9s78UBzayw0tjxkRRXoKO
         3x/jvUv8RjFBQUguTRb29em05qj2kLjQmZoGNQTJj8Za8ytnDmg7oYsanXAmaOPjxMMb
         S6muG3fkk4LmMyGcCd5tsKF7fEuJ0QmlVwcHV2XOa+7m6lxPwj5vvKaVoBMOBASxiytE
         QbX0igUpkPgGbE7oczXE1RkKir1mpqtHZ56vpF1DRWfhQpawD8U00ONQPTGzfBzlGjJx
         eQXg==
X-Forwarded-Encrypted: i=1; AJvYcCVb0Fn0v1+KWC0sNBv75tH3dtN75duScBQ5P9uIo/psVhxBcLjErCgJSHqcRLHjxPNfNjy8sYYkA1zxVws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ndMWgmibllLTF9c6sR8dA7aQvo7a2q/ABaaF6ED1IusUkApd
	VrkULcGKPtL4Uk4Om9TtjYngIxaDCWSycAVJeaQnBXJ+3kzLP31EeSoED2nPjssXff9+WtDsQ/d
	yJAxjXPJn5R7weHb+9G7/0GBDv7LrAceoQcE9DkW/ebSk3qLcvVAkglrGXq49lKjLZvY=
X-Gm-Gg: ASbGncvJN2HkjMc2x8blSYJZScqGNUmFDeLVlcwsy3NMMElY3qhqA17M6CYHWVdTpx6
	QkAL/yxrUchv8MDLnC9ep/GXjimtpAp8juFRin9iqvB+PmHOvt0drbG4iPDEYLlj2diOWU49/R4
	smMzy6ZZ7XxJWC33a24IdbANEOGxHmuleX1Ccz/11MpRJ+PqO7no0i4wG1NzeBN0HXa918/dOSI
	RikWeEnxCxV4Dgikesy6ydr2Dc5fYhUVzazuCFXmx4Fic80WCTEOeaDyt0IndQAjDiYxFik5kfN
	lRIK9BARkkFFs+paiWYNxyE5tEx+3QvIeGRERBAiF9kZTPL2tDURlrgMK9/gmfMbSyM=
X-Received: by 2002:a05:6a00:1484:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76bec4e1e63mr11958345b3a.18.1754311577866;
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpdaJQ7fVIlE18tUxW2ATQbF3hPhP2gMHXpqf5ai2xxiI+sZ1i3HhvTdj4U6zAvu2H9FbzRw==
X-Received: by 2002:a05:6a00:1484:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76bec4e1e63mr11958312b3a.18.1754311577464;
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8b5basm10399198b3a.41.2025.08.04.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:46:17 -0700 (PDT)
Date: Mon, 4 Aug 2025 18:16:10 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Subject: Re: [PATCH 0/3] EDITME: cover title for mdtloader-changes
Message-ID: <20250804124610.xqioktl6lbyvv5qb@hu-mojha-hyd.qualcomm.com>
Mail-Followup-To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-mdtloader-changes-v1-0-5e74629a2241@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 601QeZ3V_ueLi3PBouYuZWl5pWRuHo0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA2OSBTYWx0ZWRfX9PRyjrOMJBzi
 0lr78dmls4FV4To1bRtr8PPxNuj47gWw364TjlCSrG4CyJrFqUuhXPCz+QgBrBtEUCOgZQMCglc
 5BrqRtfkyXNBjVcirdwWWi7vKBkE9fe/xheyIPa13GvYjR3Gkj/qxXDH4gnvRy4Uay9q2nuyzR6
 YnWqHSY9CkBm2deMbTqU75xIV/SL6sQitf+yW/Jbj+7pjmF0+kM5uXNA+sk7LkA8qyjNAKA7/lS
 BNr6xuVQH1fzVDx4kHUyeT2UldQgiuPyItgC1R3F1nBQgvn76u/THhlyWN2YOR4uLJADhUbmu8r
 5Kyu+cSkw1rxvRJxyE7C0cbjcO1EiUjQoIf4EdXRYGam67PyjjbPKbgJk3yg0eSHQQUkiv3HF9N
 7o0jd5rwCvuh0Nkl7YBsq3pHlrGtLcNXw7UcBPUDVs3ECHMSumPrs/KELLH/M43j1yAZbPw0
X-Proofpoint-GUID: 601QeZ3V_ueLi3PBouYuZWl5pWRuHo0Z
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=6890ab9b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=ICuFGErgaGyLqr7TlXEA:9
 a=CjuIK1q_8ugA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=949 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040069

On Mon, Aug 04, 2025 at 06:11:48PM +0530, Mukesh Ojha wrote:
 
Please ignore this mistake of sending empty cover-letter to your inbox.

-Mukesh

> ---
> Mukesh Ojha (3):
>       soc: qcom: mdt_loader: Remove unused parameter
>       soc: qcom: mdt_loader: Remove pas id parameter
>       soc: qcom: mdt_loader: Fix check mdt_header_valid()
> 
>  drivers/media/platform/qcom/venus/firmware.c |  4 ++--
>  drivers/net/wireless/ath/ath12k/ahb.c        |  2 +-
>  drivers/remoteproc/qcom_q6v5_adsp.c          |  2 +-
>  drivers/remoteproc/qcom_q6v5_pas.c           |  7 +++----
>  drivers/remoteproc/qcom_q6v5_wcss.c          |  2 +-
>  drivers/soc/qcom/mdt_loader.c                | 22 ++++++++++------------
>  include/linux/soc/qcom/mdt_loader.h          |  7 +++----
>  7 files changed, 21 insertions(+), 25 deletions(-)
> ---
> base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
> change-id: 20250804-mdtloader-changes-9aca55e8cf37
> 
> Best regards,
> -- 
> Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 

