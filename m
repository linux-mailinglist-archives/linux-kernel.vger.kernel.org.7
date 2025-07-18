Return-Path: <linux-kernel+bounces-737257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D0DB0A9ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8013AA6384
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC192E7639;
	Fri, 18 Jul 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RlBv1BDj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608871A7AE3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861768; cv=none; b=QqBRtFu2h+LROhpz39+RsX5H2/8NDfwqM5N6dIDpSTElYh/3JxPneRHmdkpGZUawdHkBM7iDfyi9cOmmVJ7MXOYLWkh+7ongQZowrwodZMGqHLRoXo2x/7U8iSJK7ipHFFsBv4qcVctoeanzwqmX6kTbRzhJK8QNMI9CWVSOMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861768; c=relaxed/simple;
	bh=ZMQVxjcZ4u1K9IUYXf5lFTqRw0TDlpBU1zJv1xX7b6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXFEXretCYm2D/2rMXDLR/wrZpmONRMYOTF8tR+t3q9SPP7M5k+7y3smB4rVX+CYxPSsdE6nB0C/zYepcHA0LSrIjxpFUyta42dWo32SqdrKAd8NBx2SmbekVjO2PxqAl/cPE12ew5116lnl+t6CQuMp5NsF88X8N1B3rbU+bmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RlBv1BDj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IG16RO009576
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SFlicwMuaMl9H1w874hFttUH
	ryovYPVC6D6myUsxgMw=; b=RlBv1BDjcFuXbXDYbk6FXeHa0StMwFFzr3+UP3RW
	08ta8xXbk51wb60bVnp8nk7grsSwYVcvlsJLwwJ7k6bC4TQ09iuYljD8xJJbB2XW
	A1/877F2AV9yjN4zUHokhRfqfZdCz0oV6h5nm7W/QkpaWNUOYTEUgwrRfJQscOJU
	/C/71/roxi++lqtMUXC4jQKrJF8OE0wT3sYXBF29hq4Tmq9OVHHJRY6V2nVLygcx
	x/Pu3DcIIBehojMPZ7VDVRsoeTe2S9Qjb0RHnwP+0KBVIAiF1jbzttRrvW7AjjsG
	md9Mbx3QSt+WmS8o0//bayF9mAp5uFYhhoYCXljWDp//lw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbchkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:02:46 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2e933923303so2177966fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:02:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752861765; x=1753466565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFlicwMuaMl9H1w874hFttUHryovYPVC6D6myUsxgMw=;
        b=HqQC4bnRb/8mFTRoNZ5+GxlD20GVc+K62IP9Fe+P85yC4zHYYOKE+7yt6umrdAzi+T
         8VWdHObuAN0WkQyEqxkRnQcPKkpb++Px6OJztqNBV2ZJE0faW+T21gKottydRVJhqD0D
         JJJJ9L/4Bko03/piWYPQPmUHJMlkPFZUARFQjatjGliPnRaK4M9a6V6Tv3UrKOqAhErg
         jxJ2Yfnt0AVQHxtozbS2OqhTUAUQeI6dy3bAxU+zBNmwy9BsUL7lx7s6Am810BlelG36
         ctwPzgRrK7QRdR/isJdJ0dC08ZUOjTvg95Vb1zAOYTcyBA5veOt8fFhA9NzeUsGGxMnC
         9vZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWemAKktWmS4Zrk19MkSBZ8yETwJR2KcG42uMB0DlYRyHJD4eXQ5w+KHPbzRiCb14hjmxLf4uLysnaqPgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyen9BGxSDGWMj1LuN2oC8iMrYydGy3BBArfOwGDRwxX/f4AI1Q
	WsIS52fnK0ffCWrUdU1TT1NIE+O3frY+8PwsZ4d0w6TkVGqTtI3LjPvwVEdHPVFTIzZQtKWBD36
	fupuI4jbyyOYRIh9sS+gUkSeIEN/ylzzMa0R8DRrn0BzDDJuYpOEjNcYnSvBkk7ZweUY=
X-Gm-Gg: ASbGnctfdjO3bpnDOd0KrXCVQU8kxgkGeJ4uEzjgCEPsLHU5x2W5miGuZnVDmDRa7uS
	zY44TZKu14teb311QyuAXukM9vMQMh5twFlsJGARD1hu7HcsRTyzysSBlZKlvfpb3Y9grFg/ItI
	PkOO2obqO3Sqs9udl25URHi2PuSFLUuqBKRzzhZOgGubEnRisLow8lBCJgpmbE27hxdMU3aNGmn
	YkvCqF/2ZqzVlUOfDRW4Gj8pZFN6BDV7sXmhvFOwQSSohC2r2L1i97I+LsG/RHa0DfOqmNiv4WH
	WCa233P5oMa9Ufoo8i57Y8p2FDektGCwO3wvzZvyd7zkjUfQYTT2pYK22uXmcwJpYvx1/vFrnON
	8JK+MmnivjpzFqmaS8RrSFujCzaSFoGvhFcAL3rmI5EwWGZ+1TSJF
X-Received: by 2002:a05:6871:522a:b0:2c2:d2b8:e179 with SMTP id 586e51a60fabf-2ffb223dc4fmr8946934fac.4.1752861765180;
        Fri, 18 Jul 2025 11:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEVjjKezrsu1NYnvqFe7iGQyTNkmq+wUMu6RiaT0vvLy+hq3N4akMOiv69zLcknV3GFGKHFw==
X-Received: by 2002:a05:6871:522a:b0:2c2:d2b8:e179 with SMTP id 586e51a60fabf-2ffb223dc4fmr8946814fac.4.1752861763913;
        Fri, 18 Jul 2025 11:02:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91036cdsm2993051fa.26.2025.07.18.11.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 11:02:41 -0700 (PDT)
Date: Fri, 18 Jul 2025 21:02:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Fange Zhang <fange.zhang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Li Liu <quic_lliu6@quicinc.com>
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
Message-ID: <qedgprcfzy3uclerm5atesk5wvzjchgmh6wztcibkpmbonvyzz@rgbc4blhcgcb>
References: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
 <20250718-add-display-support-for-qcs615-platform-v5-2-8579788ea195@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718-add-display-support-for-qcs615-platform-v5-2-8579788ea195@oss.qualcomm.com>
X-Proofpoint-GUID: gblyDg4fEPJEV9QQhRjJwxYcXftDKsCg
X-Proofpoint-ORIG-GUID: gblyDg4fEPJEV9QQhRjJwxYcXftDKsCg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE0MyBTYWx0ZWRfX//yMc+Xna4c+
 S+FXErO1My4Em5QL8QIv2x/VHQauh0haW7TWkolZ5V6bhkVfk95hiWqRD9wZBEx/GFARlA5nifK
 hSrKUYCWBZ9fN66zf4Cw3/u+UgmJqNuCqcmSCgk0EPbrDm6CYhKLsdrdZ0GHpoN44OVe1TaKuB/
 fGqKGldHYrHjZX9rPnM8/JDKLltTIPr6jkRaWi6Mf5Uj6yrgmIYR/s36k3mVxzYOCtp4BpX+vU3
 +RWe8kH0hdW4eYjV2W/+0C84n5gaRQJX4IuPukUyqKenilV981o68nFPcPE8AkbCoy1rmtDNFo9
 hU5xSoxgVaBXeOBpRqGyv0q81Bzrng09ZdYIfAkOc0yDevcfCiAN0h9u0OytmGlDS3j28yyPS7p
 JFsGbYIbmaaQKzopPRKnq7VCxtwNjhr0DozCpWUJK5cyWhiI0IywB5qIe8rpUHGty4c/lPOS
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a8c46 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=b2IyaSue4eXt-_9sqM8A:9
 a=CjuIK1q_8ugA:10 a=y8BKWJGFn5sdPF1Y92-H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180143

On Fri, Jul 18, 2025 at 08:56:33PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add display MDSS and DSI configuration for QCS615 RIDE board.
> QCS615 has a DP port, and DP support will be added in a later patch.
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 90 ++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

