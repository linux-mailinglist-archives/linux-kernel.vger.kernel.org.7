Return-Path: <linux-kernel+bounces-826184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B02B8DC7D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F808189EA3D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9DC253B4C;
	Sun, 21 Sep 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Os1m0O47"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547E62D238F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461960; cv=none; b=GIWOOiKaz6WNEdhueVIMRKmLm+/au3UVO0rq6N1pL7ANaNoJ0zvzlImI7uoZpV2e7YPQQlI86lWnGYoq7I7Of+tz4Wva964toML22g03T5J8NimYVpXC0MnXQT1FA9brmzpJyw3GVv1OBbwRIWMiV4rnUq9pVCfi9PtzEj+N9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461960; c=relaxed/simple;
	bh=YeWCF8IZw/rMgIpBjDDrdmysaeqgJv3xaxrThFxtTow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAtL0XPn+z1PTo6fKlDxejiwgdtHnquzPnVmZ7pod4RcoZAQEh2x5qtwmtLojfM4rbf7QoxunDwm212pZvgcrNwB0y9UnnO0ipBFRyf3Gf6kPNbYMu+qbyDdRFDgIl1JlP1uM/pTKklLfjsp+LfvUAgc/mw8n+yOdA2gElWVYH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Os1m0O47; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6IKAj006081
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=H4HGgDs5RVV21aBSEIYIUh0B
	LM1Dh0ZOLurCr/eNbm4=; b=Os1m0O47LdedXGW1oGkB8mXOJUqGunEcaHIebhOo
	F48QW5z3eRweUhxhjHGnnJJtml8KWFJruu0irJ4KVlEPCOjyEeipaWSh/NJ/LfUZ
	mOsfWjrPZwxgQsnMaT5v5JoM+R4Ti81uzHudth4n5kiAP4nsuormQFgEl8hUn/Jr
	QXhVYLuWkJsKd7U4YxPosbQE8S1zbHFMgFCBJ0aCoJyoE4MXoOG9gTA9UaTaMQgN
	vI7BqktrEnGYku8u4mZcw4jlVjm7dxqTur/xn8Zt4Wwzps5DNZqKRRob3HobIHvM
	cMctzUkFyiV6f+HCFVtPfaByIy7tdpgENtF59lvrXFt4tw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyejf58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 13:39:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so72367901cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758461957; x=1759066757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4HGgDs5RVV21aBSEIYIUh0BLM1Dh0ZOLurCr/eNbm4=;
        b=EA3bFFa6qGPn/iNBFnPWssxqwhpQjKj7fsCT5P2rcyCdzDYK/CUF4hyrfP6Keyj4Yg
         BIhg/8w17ehms4GOY2nzJ2hPzMjoSLhAfsB0hhwwx0AtQoV+TYqNQCY5EdLHlFFT2xig
         d7ZFNQ18ffdTYe1zaywBBc9tCWKDALIb4VxcxHtNbDK0Ri3Y+BIfsIYSmhycJhwbdSOy
         2F4tOGC6Y14bxEFRWYK6IFJof/vlROtJxjOEAcemCzjqa9ZtS2zprNoDn8nTXjSZM6ff
         iIpv3IdEYiJIcIn5MXE6qUlweCr6h0jjbXJnsT9rSrNWbwEf+p7w1uwsbtIrstTN6VZW
         KNlg==
X-Forwarded-Encrypted: i=1; AJvYcCXUpWoXIxddiN22dUH9Xrw0SD0g9P3h9CfwhV2tqU0GKrXuyuHDAUAEbG7LPIOefpBq/EHWKUFI05KSLBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynh0domDQc3wa/gD6z3g6NDz/qks2gawzPpORCyUcwbycDSNDQ
	iPplBBM8tOd6N9ctzT0yMSv/mjYN7ByfJf4OhsQd2zZhwb1bAr5uIGxt/NS3mWkHvPSVuX4TSRP
	MFl9T8suh/pXrb+qy/BzqHHIrhxnARIlJejpJSmXwf0+CiOBVk7iFj48ESWpSW3VvI8o=
X-Gm-Gg: ASbGnct8+9zoT+HD5dn4RfCJWnvRMqWVl7pchWCsi7mS9sIcA97m4odcXXTTCrgiD1o
	kDj0JSblv2/J2ldWTS7YOwMcoxXKpF6PIyzh7MdEafb+wNcScwZX1MTTUesKPd1u6502LMrHJai
	skv3MHCfSyt6vJolnKA+hzeF7y9Pfm2j0bbXJdFgpAJEkaqyR9r57P9qpng1y4aJXCLhxr51c39
	1MCqa8U/b95CwdT1HgAu+fOK38MX7kknsfGC0BAeYsCDnf7jr24w+pFZQ+aYmpglrEFU5cUC7Ue
	Zq9lNTsNrW8uOTveSkQXo6Yumsg7UmJep42zuw9i9jVMZ2Q65Ws2D8GTcwkOTlpp63JZQUsbzST
	gK4EMuqQ6p35APmiNBeKnB/cAKcAXVrcHE67/EYex8TUG9lejur42
X-Received: by 2002:ac8:5941:0:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4c07248787fmr112419131cf.58.1758461957143;
        Sun, 21 Sep 2025 06:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7DpKKzR/QW8716kTc6+qam5WV5kNx/1HjUdqz4fbjPbZzAoC02SPHlCMpwr//qQRmzkLaxA==
X-Received: by 2002:ac8:5941:0:b0:4b5:f1e0:2a6 with SMTP id d75a77b69052e-4c07248787fmr112418871cf.58.1758461956701;
        Sun, 21 Sep 2025 06:39:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-579c258c7bcsm1890688e87.128.2025.09.21.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 06:39:15 -0700 (PDT)
Date: Sun, 21 Sep 2025 16:39:14 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Heidelberg <david@ixit.cz>, Max Shevchenko <wctrl@proton.me>,
        Rudraksha Gupta <guptarud@gmail.com>, Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: dts: qcom: msm8960: add I2C nodes for gsbi10
 and gsbi12
Message-ID: <fkksrn62h76626x6avxg5cls23yv4j23nxtprjvwlo5xjm2do6@jpn3vs6pdzqr>
References: <20250921-msm8960-reorder-v2-0-26c478366d21@smankusors.com>
 <20250921-msm8960-reorder-v2-3-26c478366d21@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-msm8960-reorder-v2-3-26c478366d21@smankusors.com>
X-Proofpoint-GUID: xzXY1-lbpli_oy2DYn1i-PiA3RVZDx_J
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d00006 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8 a=yphT_XpnuJS82ywStm4A:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX3is2U3Ff0eQA
 RRlBwSvGTv7EUhenM7NG2NOAAKyOwZ+NB7eIRb+7y1PGOsY77EjDSZG4Dm67cXJC6zjH1jWWw1v
 4dyMcMaFGJJYjNSRYuAKwyb9wGek0YKnYQfUG0Ut+SogIU2kN+VDHh6kq3zxCJmtV4y6AC4L4Wu
 yz1DPAqoEC6kKPaBhnaN7dA83Gcy2PKkzOO+JGrDnrPYErRoRZHJ9Q4qrV7pzUBT7hzdAfgvOJt
 BdbYNnsTVcBOm7XhnGhoxYj2FHqr80fFH8ljJI2i48hnea03SPWvm8DBVI3TznZUSGqYGLug1V/
 kO45mSSpzZnRuSO+37VRhGcfcYI0VrWzKDbSHgeBQtczUKrZJdxPAS63h0DO8oJPrM0hkMUOrAy
 NFOR/7LD
X-Proofpoint-ORIG-GUID: xzXY1-lbpli_oy2DYn1i-PiA3RVZDx_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

On Sun, Sep 21, 2025 at 03:08:08AM +0000, Antony Kurniawan Soemardi wrote:
> These are present on msm8960 and are required for devices such as the
> Sony Xperia SP, which has NFC wired to gsbi10 and various motion
> sensors wired to gsbi12.
> 
> The nodes are added disabled by default.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 96 ++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

