Return-Path: <linux-kernel+bounces-820852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5C8B7F7FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2332A6228
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1954309F02;
	Wed, 17 Sep 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HtRC0glf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C62308F18
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116297; cv=none; b=spaXl5d+XXMiMH614yF4xx5aZC4nHajrMqgLTPl6TixWBqvkBoYdNKBeqAZcoVh5DFBfZW72F3tW5UInyuKe7ng7MJbg5bFV4lxeVndzKRwPH0EeXWFohDws1WAq7DfugfGjMnF7s4V9kzPlQSiQB+ODcqSVnkJzjef/Tc4rrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116297; c=relaxed/simple;
	bh=9AWqLs/ayntfczwGA7UyGJrTFP6POWFxb5/w/HcMm70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK+0Z0AziUHlvnqk8ACdlIF58SaMQCHoU5Gg6h6ucRLZCl/9WLgK4RJpiYNTFuujDe7tiDUjzPzYvcFV5GWIriDFIRC6R89oOLLeEZJ/wiKqEMLcXMHLFrXcWOnYjWR3rbSZm4VoeOA1qtT67PcH1tySsTPHCFVwHXgSss1wG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HtRC0glf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XXm1027143
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+KFU62nDlSmYNsWvrE+F0DGQ
	RnG1HQg63ixfyZ2aRqM=; b=HtRC0glf7CNFzuwHtsfRwqyDgKhBlUsfksVgpfwo
	4AY3nqZ3sNJCHbd4/9QdZ5KLmArBKURGIsMT53j9fQYEXh5sJ7/FsMMK+jsdJr5m
	cie55z/ysOAmOiIok9+8ShtxBSLEmbhXe7kQm/0e3yp3pYySa60zpeHo4/UMGPfH
	UKh09MpJU0E9gFrGQ2VZhCIXWugpWVxwm20FnM8YbeEos+yPzxspl9VlJIvVcXjw
	SkUaMcCDvZ+thmSG3rP9Pgjm8zQSPBTkKV5EF9dS2NsF4RRY8JmJShR1WeNiBeyA
	tRYFyVkhIN/+6EUvFXUjVoojjIYbm38xREyr6rgSlhDz7Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwjhwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:38:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8063443ef8cso2273779985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116292; x=1758721092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KFU62nDlSmYNsWvrE+F0DGQRnG1HQg63ixfyZ2aRqM=;
        b=gddoVVQMUZktMIf3q4CGVbFUCBrYdNTaAq7tqqqZtwwC3bwBWZUvdHeclatMHI9H57
         8G6C8soH4POLDb4po8bl098x8GE/M+4UyQahvVev7Y7tsFBd9wWDa1QhYjDRwIpUhN30
         IvebYEceBDzxubouhz9Zo5yclva86OxaqsipoboNXLc8o3PNGs95DpsTmIOpDlOqxWzp
         PJ+WG7nNpEu9Tz1R1cjX8PkYOSiOrl2DE+ZmIX4sfjA+hOfQpDqVctmgVNRYoOPNuLru
         ynDYMb8Pxz5AVcm40kOaoWAwoTN/kQaAhAA3FSe9mrrqtZrORb2BV/bCra4pR1Z+p4Xk
         K5pg==
X-Forwarded-Encrypted: i=1; AJvYcCVxeFeekmPhpAcAnT3BqWR9HxE7pHjMRSqkfzwmYV7Hda5rvUbQoMJwS2wUBWFom8/oOpjSIDnW2H/PslY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyMDjUeTlSgY5fQ0bqJg9GQN/ovZmvO2EZA90pikWQIC/DQuI
	Q1qVJvVICagymRO8wrgu1tJMHOPodfQGGGZ4O5KJYvbqZZxmCFcnMuYrAIHwW9ThYvHOwm/kG6Z
	fz0yTrrokGYkYFLv3f/GS4etbqbs8XkLUXGYIiaDUl1tKDsdebcfYgiHXCP+MRzR0xlA=
X-Gm-Gg: ASbGnctJrJYe8DB4a09s85t4MAdLnIlEtA+/uIcqL9Uj4gUS/XAmwBuKTt+3bv+5LSQ
	b1D5DajOBEVg+GkuYTXUcbxr5A2cYww8zbx/kgtPejiCDDLPZrM8tpICNgsnpPLBf2JpTCPdFgc
	cIOuj2oaxmFxktfkDP6Z/l3XmskdakMiQ7Ab7QmoLS9rozcLOmewK341jBklzM8dwUyivTt+bLV
	YY7sx8eTIEgA0Tn2QnlfrVftfAAeataD80/IImCTDFFfqq7UgKwzRMto9XbTgc+c77kbtO2xIAp
	DgBiGMp9MNV0qNq5IIp6BHOtVdGCQ0A/W39fyMjuTFHbcL1nXqX4m66iGCdPnhl3AgrIfNBrUQt
	yyLX2p9s2bLXWKg45ypsi6gocpj6BygJ81UcOniYw2rlxOhZ0d8Lr
X-Received: by 2002:ad4:5be7:0:b0:790:551a:a689 with SMTP id 6a1803df08f44-790551aa6d1mr5920916d6.26.1758116292400;
        Wed, 17 Sep 2025 06:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1nPyxnUe1a4SQooIlckIH9ZJqLc0nczYSng4R3dxSwdKHdCFNkmzXBw6/lVvnS5Wpi8xtJQ==
X-Received: by 2002:ad4:5be7:0:b0:790:551a:a689 with SMTP id 6a1803df08f44-790551aa6d1mr5920226d6.26.1758116291647;
        Wed, 17 Sep 2025 06:38:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5777bf5ec93sm597011e87.23.2025.09.17.06.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:38:10 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:38:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: qcs8300-ride: Enable Display
 Port
Message-ID: <osd5xcw3cdbrutwokggs4y6lg6aqc6ywyl26ujy7wfzi66wssq@5d5sau7xejsq>
References: <20250917-dts_qcs8300-v6-0-5c862aa80f64@oss.qualcomm.com>
 <20250917-dts_qcs8300-v6-2-5c862aa80f64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-dts_qcs8300-v6-2-5c862aa80f64@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7dXobP0gBD0n
 qWM/fb+KD0bwDu1xsaAJwLVKzm/6YW2UZ1rgd/QWLXq+ZwpWrMzurgiFDtdmk0/wiBPCvhGIf9G
 UvAbFa+VsdKbxeDjoQLiJtdoyTpjOBEt8je8NIcW+XZoAV9lNKYC/XHXIyzP1rPEJGNzAKzNMHm
 qdeneXD/pluQuCSn5AeWtk0eSM3qlJooqyQEFkJy5PhCeTB+aXQikYdiyhLauOVuGY6rBHyASLv
 9l/cu7kvf1c2/S/jx3tDl8wfKlSS8Rc2z+M9crvc8zddSGbwJXfc8n0mXZjZKvC3vSCfL1XSFdL
 d6OT8T2ei0Z250UUh8gptWX6YZoO3+wxUDspbtuJizNoVJJpCoNrjY5DbOZr6ISBgbimq6MH6uC
 Vno7xP4D
X-Proofpoint-GUID: j9uEQwe3rS1w7ekLVUmVTsZwXACPP4Yl
X-Authority-Analysis: v=2.4 cv=ROezH5i+ c=1 sm=1 tr=0 ts=68cab9c5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ejZKuhsRmfo8bG81SBcA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: j9uEQwe3rS1w7ekLVUmVTsZwXACPP4Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

On Wed, Sep 17, 2025 at 02:09:48PM +0800, Yongxing Mou wrote:
> Enable DPTX0 along with their corresponding PHYs for
> qcs8300-ride platform.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300-ride.dts | 42 +++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

