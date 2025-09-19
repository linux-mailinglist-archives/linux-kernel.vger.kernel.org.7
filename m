Return-Path: <linux-kernel+bounces-825101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B5B8AF6B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BBAA01052
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9BE25B30D;
	Fri, 19 Sep 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKcLA+o5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F5259CB9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307333; cv=none; b=axESWYmijhvcmEglcziDhqdd4qC5Yp5IF2lBedgHHhg2kupPqSxdnh3Sp6u62cClRXfbunmAQptsEg8Clbz8bEf0wJEIrQ+p3IZFlSkEWibSJMPduoHU7mmnUcuLj4FJPnVQ2DOGtsaoLwhi6htQMz5R5RRM6CnCU/BwCjJjTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307333; c=relaxed/simple;
	bh=psO85OhviGYEKRSwPt9vKPVhsexTHDdRcMTrP/IAFbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dp3c+JdxCQyGRPqJHri+Nt2A1HUjxcTZ60SFcPh1ITy7TxTxEiOo9P4gCkigXhFxkzNwqMlcIV4y1qd2njqSRFRh5mJaTsX0boK+abl1meEmxG+7oWOKbUc4151zlrwH5TRPFXciR0/Iyj0KvUhwqxbGxuxh4eeRvSp0FI4OaHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKcLA+o5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JHEVoO027215
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X04daQs0/GOlbdwQIFR5tVab
	ojXc3GMFHaojbKi4+xU=; b=IKcLA+o5Fpr3sQxqhBg9BBKCSXhcI66u0QHDblww
	a+94BmfJz9SvdIE00ph9sTH6gB5RjBEHumfnAPQfjnQHKlmxq5XnTZsAvQOLGVjs
	6KBsDKSjbJpsFjMjLaw/qiKR/DKQIjNX2XmEigi+wF/xqCh763yw+ytvN/rpQyMo
	Z9YN7w6zNmA39B5GrPo/AUyDOxhYcmdiYMKKdN3ckv9x4p4cKu+tczpJ2xGtucx5
	TFhUZXhx5bKK6w8Ofij7/saDweOwwBCjTkF/eyG+j60rtjbp5Pl3hhdpAt+B+HZ+
	MNB3onauJNaNTUEe2JylgaaXyfpyFpQZn2xlveCVZKrt/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jhghp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:42:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8063443ef8cso760543285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758307330; x=1758912130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X04daQs0/GOlbdwQIFR5tVabojXc3GMFHaojbKi4+xU=;
        b=wQFkQ0Y94m0mhKb+ZAErXFzdnOmyb7EkCvIgv3QgEbVghbYNh8ceNewNOCRoPMAqTD
         wm9MN65TY3VjG5rvoHd1WRP/ufjub+zsfPf0SCp96OgOBHX0ciE0WBzD5dyCwjgfV8VF
         NDz76sHIQZLf2z3cL28x3Yqqjh+ogVC+tSoGP8kHtm+HcJoGWdrJffJmXxrx5+dptofV
         fXB4Rd/U+ADu0ON3s7Qt2FE+FQzfBH6qW18Jc5Wn2ZlcnYS+gItQZx5j2a9KKE6HYEWt
         fSC0GePmHMyFrnm52U8SS2rU4DzMOkBGFEWauf3HyoA0BXmZvJIoPjWeJR6tBwiRrrs0
         Ivag==
X-Forwarded-Encrypted: i=1; AJvYcCUJd5LkFcI0hWZheRF582fFoISijYyr2flxRauow0nEgdVwfUtjciy/wxjyIavQft0NBJ8IIbAJNH/2wt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpC1ryiMrpfrY4EZbn7HkEJRX8gSuUpD9d0Ty1uiLIeMV3iaMF
	F/b0LnYGPoGdlXesqAi8/u9N4hp8q7wBy1sg7JzMwLRaYdVY+jGyEp1SDMg3r16mbKaY1fD/qIz
	Fd5LgPi1ex3LgOQZdWdSx1wZEa57gAw16IqBPO5d6D/s6dgUUJ0bnLqPcbX+mdYvlI0M=
X-Gm-Gg: ASbGncvdgLz0OjRW364+PVuwPnQvKQAPrG28vTwnCDkk1BL7ymt1XVsIrcWWbb1Ld9y
	nYhzftyoHFhqkFhhkX2+nMGGFXCA3Am7LiyYSiP/3Ov/gjgIvZVvQf10uRc39il6aRQUkmWG37m
	6SWRAhfk1/tHKS2Igu7/qOUgrLDsClAlFco7a9qfSW1t9Cl9x5o5NKXdPdQYsbZ+AvLkDKeOQHX
	tsqvv9IGnA4FMRZm/j7kMqRZuzqS5Pm/7WndTfwZMsl8QxmV+tBdZV7et8IGQqERdgr3uYP3DtB
	0Wa22Rqs9dAnaCC/ulFGk27LKu0dH9kXH8UKcLAUPxZ6z3P60tEWzRD0mza0aezb/bFYqIhJWqM
	3BDRzLRFJbNmTRlYTx5XQoYYEHBpASMiEv8ECEsVpnkh3LO/J9NVq
X-Received: by 2002:a05:6214:1c0d:b0:779:5204:4916 with SMTP id 6a1803df08f44-7991578ca2dmr53799756d6.19.1758307329643;
        Fri, 19 Sep 2025 11:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Tk/CHfkwfvHsGusufr2dlS6ih3vdDiyM2Ldlo0VTKbs973sYQp68Zd+i6oMsC0C4qDrZ3Q==
X-Received: by 2002:a05:6214:1c0d:b0:779:5204:4916 with SMTP id 6a1803df08f44-7991578ca2dmr53799496d6.19.1758307329170;
        Fri, 19 Sep 2025 11:42:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578f06bf6b0sm1360169e87.74.2025.09.19.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 11:42:08 -0700 (PDT)
Date: Fri, 19 Sep 2025 21:42:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH v5 11/14] phy: qcom: qmp: Add DP v2 PHY register
 definitions
Message-ID: <bqgcuch65lczmc3asccgddt46h7ebcioyjs2pwsco6wivyjc6z@lehfge4cj3qk>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
 <20250919-add-displayport-support-for-qcs615-platform-v5-11-eae6681f4002@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-11-eae6681f4002@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: R6ZFbRXcF9GLO8T1SHRyjprOIhs5w6-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX6aPpInJhVTeS
 nob+baBhUDuttPVKMqKPBdjn/3tVMPIiNotfesEX8ibpWDOTgC0xUWPTk2leT3zdz6MT3mTf2XI
 dvetTnzzGjUL5mUseyYwLUvTAbFWjyjA4KPP8xi/9z5DXXnK5W34YbYFpww+dBQCzU9Q0mX0uge
 ltz4SDrBHlIWVS6tqGTYD15tDuDffk4qNwEsSbz9IJmGMgF54uK5ADEO4pDLcYnJK+Eqcav5W4x
 bw73c5DeptLZ9CE7O731DmVQvW3jZeoo3POLdlQyHXrolBce4Ft3ghpFRnyx6t7mE4weBmDUDFr
 ArtzEae18322nTe9vzwc/5GNElRuDn33Or53DX1G+k48L61I3laucwxsw1J8Ze2BDPnntTg5/gy
 nD1mF/st
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cda402 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=R7-NhU-lAAKmNGUam_4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: R6ZFbRXcF9GLO8T1SHRyjprOIhs5w6-O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

On Fri, Sep 19, 2025 at 10:24:28PM +0800, Xiangxu Yin wrote:
> Add dedicated headers for DP v2 PHY, including QSERDES COM and TX/RX
> register definitions.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |  21 ++++
>  drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h | 106 +++++++++++++++++++++
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h    |  68 +++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   3 +
>  4 files changed, 198 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

