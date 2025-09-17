Return-Path: <linux-kernel+bounces-820834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BF9B7F71B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82C11C24CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E0B2253AB;
	Wed, 17 Sep 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAuYzaPm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61652233140
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115907; cv=none; b=rY57VXdwEQC+mS1+Vm+fdstBLL/wRbTMqOUmL3RuucOLaR8+EOZVPMvv2Jv1b/B57sCxRQ6AzzketzpGc6t/f1pHIf+6sCKv5pd7ZAlY+/0I6/h/wYtvES4nagUENs6kiK7RTiEg13PzPsRoz7FjxnhYWGfi5lIWwCNeEdpGwNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115907; c=relaxed/simple;
	bh=sSu/tvhqvGYLoATR4KdHdgOpDxsSaCXZAjYdozBlY0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQOt+2a5FdLum1XvvydSNp5P7BtkCgoUcdbFfcKyGhCZgzcy1w2v5zQWtjcX6p0wwwsUQzKhhNfbx/hE8xeO71pn4Zk3KIARe5RwaUGmaoAQfxrNS+w0rrPfsrm/2UmfhjyButOlYY77NYzlINZYkvKXgYvPn4X4/mq5UKDRLbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAuYzaPm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XYgU026846
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5i5EojwIc6UENkuaiTfVkmrr
	3rtqFyYb9QKR6qLAEmY=; b=ZAuYzaPmgQTm3NKy0jOaa/j/83FSQcTPNMOoC7o/
	G3pYVlkcAC7ke1zx+ByEiFljza24bkUZ/WZ+gZRNDfh9x/h0N7PkGYRfq2tuJbbK
	24y+oKCMX/0ce2j7ljlaW+lTzkRCJkBYRk4BBjIppWerbCkRziGmhX1unAk8mzJl
	qZTlIRaXKWU64ayFRaoKb38ahaN8izH2jYOiPiR9+PQJNnRyvyGciGmNi9D4phK2
	QyMitmiM6KoOy9jlbXrHUnQTv5IhhwTIi2X2af6U2e80/KEStcJF+SwxYxnFXLrb
	wc5JRuWWq/+KUoEILKGeACQ4ojesmUdc02il4mY75EPLBA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt2h0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:31:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54a2e947bdbso1278825e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115904; x=1758720704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5i5EojwIc6UENkuaiTfVkmrr3rtqFyYb9QKR6qLAEmY=;
        b=pRJn0zeSLExAnXO8KJsg8on+/nqLYhWDLAg0BjSt67DcTlrlt7E6PhUTCO+CH/HDDY
         AtGgeUcpnQzphG8hQzSgYft0zw8CHKPFgbNCx4OprvYCdwPXsENHiMvdpRug/KFreEsS
         Vo/QmPS5xDN69ud/QC5NwrHRF/1dtJ/gSEMtsTdqQ+5UOor4U5/vEp1y3P5tUCVb3Xbk
         ubboA6zIDpQSPk5MSyZTtpOpNykG4upZDzaxEwrUmM+XlSh5uY/su8v5dxjh5cBv3GHg
         tbeu5W/IiCdsQGqRLT0h6OW9+UmudtkkgIkhlHDypv1z8ZLdzcpPOK0U81YObc9zwJHt
         1YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXusA5suEAhKzw452nfkD+Zyd8spNZXnCNAbU2YuQFXRJSXJ8bfnHaaAuAdXMlp3IJEM7zZRsTyhLBMWSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYB8UfEbn9PpXhxfMgwt1iBdiG8mI2pw3iYdiIfGyZGpNyeG+h
	46+GJRE09umvIdLD/6YI56b32Whap3lGATuS1vjC/FGRo+3apPf5Snt5OW0X6lB7L8TwUX1gDEy
	rajKbxj0H7E3Upq77xSewyElXY+Fpgx+g99Wx5d6Salq67xrgraxthxrNap3m2/pP4V4=
X-Gm-Gg: ASbGncux5SBkzgghxCLNOQD1DEdw4kMcGs5cFW7BQfd7gXnq8KtPfPoHmsygX5qHn4X
	SDID4eQ0uD0e9V8uAT6Rw+mIPWOg4jYjlrVrVcm3R+3nicRay0a4Fb6Mi0KaHLrirMDiEoa5aFq
	JlZzz/HxLRJhAzmp9+Rw1SH2Ql5Zf/g2FE4YFPVk2roPkOLT/AMs24WKJMTvKV+VcI0Qi/CJlg2
	0N0o2IdC+ug4BPrjXyfFUdUj3ZvDaSROW+tkz5Xova9r6wCTaBYjc52znhnpWRpgOZyOOwSSTJ1
	3l2DxCr42fqw3sPXHVLlgULlUG+VJgznahVApj9BrhQDg6DoJScfrta3+/ob3lCeJLqTG3ECv3Q
	Qepy+c1zpyTrn6CptriPJAZ5oFrfrKQ9q9PeBKOXgGypVnVXMrLig
X-Received: by 2002:a05:6122:88d:b0:53c:6d68:1cc9 with SMTP id 71dfb90a1353d-54a61017505mr680083e0c.15.1758115903905;
        Wed, 17 Sep 2025 06:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwq4q64y9pQGinUlifknWoYSXhEvB2/AvQo5VNejvkufcP3u8FaU2REsxspQMlZ5mlOaHufQ==
X-Received: by 2002:a05:6122:88d:b0:53c:6d68:1cc9 with SMTP id 71dfb90a1353d-54a61017505mr680052e0c.15.1758115903272;
        Wed, 17 Sep 2025 06:31:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63f61sm5088913e87.71.2025.09.17.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:31:42 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:31:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Flatten usb controller nodes
Message-ID: <kqqaeyul4us4el7zog2gaob52o2gdji7eeiokozylgxk2gvnua@4gcprzdyhfty>
References: <20250917123827.671966-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917123827.671966-1-krishna.kurapati@oss.qualcomm.com>
X-Proofpoint-GUID: eUX5RRWtWVjP7G0h_poBQEK4-4s1IYrT
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cab841 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=J2N_nXOhfcilw9lcM9MA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6ryHV2k5ZWf0
 j/0HDJyeskox1xo1fCunjduoAF4gzfvdT6wDJhbvOcdegwgBRE0wZORRC+Bx/MOhiJxbSxFa9WB
 JzfuEaUEJLphVN3sbnwjNv6WVzViRKVcio2gHKSKAiuZBWO9LUM+fUxWfWRs8VdgAHjp5SE3ZBn
 5HI+WoaxK+tTzt54UKFUlijZ84Gg5KhL++6EKtAlZiI2CM/o6EwuODrtqM1SiZKkPQeuhQ0TZta
 BLTeE5u0S4OT8IkoR1MoLoW56d6vA/T2NomtBYt0cvcsziAzxMp+53UEUhPQZw1VJvwpUXldFKY
 odu5V0sxo5qrmm1fsbzF6J85cZcCvVkCYjUKMXiWLM35LtZsE+/A/hiUt/JDmfhIN4E5Cq7bwY8
 tBOrcdM6
X-Proofpoint-ORIG-GUID: eUX5RRWtWVjP7G0h_poBQEK4-4s1IYrT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 06:08:27PM +0530, Krishna Kurapati wrote:
> Flatten usb controller nodes and update to using latest bindings and
> flattened driver approach. Enumeration of ADB has been tested on EVK
> Platform.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts       |  6 +-
>  .../boot/dts/qcom/lemans-ride-common.dtsi     | 15 +--
>  arch/arm64/boot/dts/qcom/lemans.dtsi          | 96 ++++++++-----------
>  3 files changed, 44 insertions(+), 73 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

