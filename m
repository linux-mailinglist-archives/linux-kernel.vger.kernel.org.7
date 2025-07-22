Return-Path: <linux-kernel+bounces-740781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B668CB0D913
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2C189203B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180442E8E10;
	Tue, 22 Jul 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hkTa0ng6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5702E11DA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753186333; cv=none; b=CeoiOQSDuJtQhUQ9B4IogJwkgaCo9rd0PVNv/cohjN0E6FNv4mhu400CXEKfcZPNiT8in7KthEFMTaV0nuFwTTEaKlVAh/LZ/Np8iGr5g7mQHIAnpRBOiPs8fu5omyjQQBCQ32sYLnSZylkW7AJtQPwtabjbSbJgDiGhwifjeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753186333; c=relaxed/simple;
	bh=9AGfNi8Z3abxmCMBqD1ZTBLDwhONqppJromaTxecKAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2z3tbnQxGdCuMysuIo2KVLawi94MjQMBuq1HXl3JRbwNZQtGrCfo7BfyPW5CLSxedwt7jLeH221k9+FprqcOKdDrZ+sjwpI+7m3cyzO/F6fXawMByEBygeR5g+gePrpop2s5J/37kYEt8nXYZCH0FaFeQadTiNIzDnmmfbMLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hkTa0ng6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6uBgh020176
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NEHXuEGLvj8JYaMRceqywm7l
	bVVNFFO7FenpbK/Ukj8=; b=hkTa0ng62W9KTnRIW60j4zwvEN47S/Ij8eczohm2
	NeQ1eJ6VSSXcoRihBgFZmWtHSnKeQRkqCPvpz/S3UO65U393ytMiBs/oE1kCa1QK
	TrVETZTDKNF/nr2quSYhqrINE5oBAvJ8yHGAAt8rHjXvJgYBvq1RpWs+7dv6tH8T
	SH1u5FYTw5RxADVc7mdWdY0G2Bpb6HUDihhIkbKNBk+U8oLeNP8p0euRcdhSxNqs
	BeMPBgzM+QcziBkwdBmG7O21xC00c6C7Gw2S/CCb87Mtlvc6/6cWoFUhxdgopz7i
	RkFcOaPUdMWQ3pnwqXQ2M+apw1c4lO+y0GqVSN8NZ9On2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9yqma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:12:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e33d32c501so1249512385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753186330; x=1753791130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEHXuEGLvj8JYaMRceqywm7lbVVNFFO7FenpbK/Ukj8=;
        b=MBF1PizTBXEq44R/4kucSDKgTS1z/XBRAvHfosTwQ+iYxsqRmMOwjauZP2qc4peW6b
         LpodkxuT1BXjhEtTwDkFg3rQRhUruHb4hduMEoo9H3SLQrHFvqVz5CM++t3MWNboMVbf
         O0gintBgvCi/Y2vwtaeLP3dERhJg5BIG+ngwrKBRU1F2QYTP8KwPTgDt0Xvf0n3s8wsy
         G/m2H3aIdDxWhJ6Zwg3232mWitbuIyBNYbzrEgX9BocM4mcmT4clGFKO+Hq1UOZGYTCL
         cZTz4OSm/Bu4UtQsT4lloVh6I2xgPjxEgD6EVfmTVHsy5QMXlslE8bhpjseyd6xT6I9L
         /eXg==
X-Forwarded-Encrypted: i=1; AJvYcCW1UhuE6lC1bb8fkMZeblu088gwQmwCCuhH/mJQ1igR4TevA5AemQSz4QYX7sKzO1SBkmyYgcAD4SyGUYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQm/+2rPF3S0TiABqTFrx509+jmWr455Q02XU+fNon/gOuxSoh
	4dOLE4oyufvLff07zcJn3RpQn8Ob3gWpAq5p/KpU7FoPzcw4mw5NSkPr+NG6nTeaAlzrLitdt9w
	zi4pOHydEG5KOZUzZHWOZ1NBiSQsfbgsO3kTxJsAdoIuxUsUtey2wLDMo94eQKXMPlK4=
X-Gm-Gg: ASbGncvS9bK5IbOvFx5yRcwwJ0a6fdjXO7wcT8bbV6SH8UQkNP9BoG0JITLNn6ITXjw
	9Dpzc63bQIloe4Dj4cKPC6xVJMCjBW4PXw5Dm7vaP3xeCKB5WMuS4z0no9N62dNdNx+baspDEwb
	annqsWQntfYsvCRVZxNUlHXrBZdGUtPsibjT/7RlJcyBni9/7Gwvu/N1gh2OTdEov+SoGnzL2/2
	nylwMfG2q6MLDtdqZAzPb0GkO9jrrCjemIEtg1Zf2Q82cKpXKc8TV2kCOzXxN7JS2J38azc7RSn
	NuGH1kS2Ffn+OOmmVN/FWRz/zCoBPrnYm/E5cSLrhYeSG5ZMZzCfJ5o5vJAsK+DuZNqO47Gh1KY
	TQGRVDsMFYD8aNK/w8rggX0sjUQNfwpt3kzhQaPwyJVzq44voOCb+
X-Received: by 2002:a05:620a:2681:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e34334b831mr3210688085a.4.1753186329647;
        Tue, 22 Jul 2025 05:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGJb2jv2fOXgaW5Cyx19ZEkc07TsYWKVZzz0wEH2xiSqbTtW2kvxt9F0BnrHo0cf4Ck6Rp6A==
X-Received: by 2002:a05:620a:2681:b0:7e3:16b7:bf26 with SMTP id af79cd13be357-7e34334b831mr3210683885a.4.1753186329106;
        Tue, 22 Jul 2025 05:12:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da2eedsm1933882e87.187.2025.07.22.05.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:12:08 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:12:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: ipq5018: add PRNG node
Message-ID: <omokqkvpqalzwbc67iblekuiyfg6tnob7hpjh6ka62mbsaltla@7ifwjugxpnl5>
References: <20250721-ipq5018-prng-v1-1-474310e0575d@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-ipq5018-prng-v1-1-474310e0575d@outlook.com>
X-Proofpoint-GUID: sDw-puQbVm3vvqql8ieQ8LBub_yCIwKN
X-Proofpoint-ORIG-GUID: sDw-puQbVm3vvqql8ieQ8LBub_yCIwKN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5OSBTYWx0ZWRfXzdmrMsIpeEvj
 9BE0Y5sFX1PTOx9XgGJsFpwqaeKDnkRDyX36vQDJPVU1BA/X7XYnuPmq4QXSOgA7PZAYQhPLDuq
 HAgDc1Vd4mHH4gC7YEej+X0wrQ1XLpbXGEunAq0bD9oFHGLaZYZ4SaLKD9kqwTgj1OkPqgxjf8w
 og9LGa/aW04gwLH72S5gj/Hhf01thf2WdQj6GR23ufkCTz2CtWTLmSHUX1GPAgun/yMrTd3YjY1
 xrGJYORNfVCyWsfcogd8YpuCxVurJetY0rfSbb/0K40l7TifPdAYmZbySZk/wn6WLGt3/y9FDh0
 oq9S2J+h9/pl1keeNqg7hK501pDnOyrovTAYTfDepPePMUsHqo90eVqTdhpcfWf9QhlFM8N6APw
 LciT7bAJDu+vd7YUFM3cvvzQtdez5O+TA3BSFMYK9KkI4HA2bSt58/FR8m/O8BA/+jMJaf+W
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f801b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=OhTC08-JUxoFBRQK_kkA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=690
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220099

On Mon, Jul 21, 2025 at 10:30:46AM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> PRNG inside of IPQ5018 is already supported, so let's add the node for it.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

