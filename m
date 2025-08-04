Return-Path: <linux-kernel+bounces-754694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72103B19B0E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 07:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4D1175E63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 05:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA6229B12;
	Mon,  4 Aug 2025 05:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFZ/CBCY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25E226863
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754285264; cv=none; b=dt7GxRhN3LPy7Xy8h+FMWRqMn8uAnN30GOgf9FFscPCBJ/hTZiQERUJI5c2iqA4ZJ6adpbWEfhSazuvDHptDrpZNHs0OGV88aIKScx1SZwURkd5qkFBycSSw1GYxm/iVgPCTnYXXypfo6Kt/YcZMZl8dXEf69NZg44uAiKpyq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754285264; c=relaxed/simple;
	bh=ZYomnzTI/gqMaAWNJDB56qa6PtOYj1KGLdXceeY1XL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nacSzEeX1WuJtlTgwMzjXp273bTTUSoouNOeUFyOA/2MvUjRYx2RIPMBGI5KTlpLIXhiOrA7LvI+W/jpL0M99UvwYaKokusoXhFI7BLAiJnXeISAoMmNsP/snCyY6BNKKZvVJhqqeminx7JSca/5uf/+8iv7aCnE4vjDr5gTHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DFZ/CBCY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573Nwfal012892
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 05:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+PcTXtqzA8go/oZD84ti/MPc
	iAxuBsczUeBgnZ1pTWA=; b=DFZ/CBCYzlikPei4IMoDe1V5c0bih3np3LkDKmt9
	gKPZirVsMp9wvIf6hIA3tkHmbXlC5InTlqX3vOwGyZoTHq6qb1t44HKbAAzQU1Ay
	cWZYA1l0q5R4BS1e5pyqDppXp42ahRxihq/rH8IBMbl7P8K0YSPwErpI4KhtPSku
	ny6Z5gDR1uRLn2E3LVoq2HvB1KXK+d8Re/z5Nt5T4LkuwNLPF6yEnfWQGkWHRcl1
	Z2Kz8GW6T8oCjLHPam727MELMhn03H/WlNBj7rTz5c6OngqvmzQElpZEDY6Cv0iu
	/GfgcTXu8XSBSleL+RGI4xOpgvbi9k7IPQ4NzRtDgRRBLA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pabnev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 05:27:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e69c14e992so262646485a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 22:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754285260; x=1754890060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PcTXtqzA8go/oZD84ti/MPciAxuBsczUeBgnZ1pTWA=;
        b=K13V8cTxzwS4GmSAjXayHiOKfwpaNxldG1zC0UAdv+yeb4Waosz05pI6n4fG/1kCro
         VYWbFJkmALzC9hgCdPq37QPbQwUoYpP8D17KxtBCtZdYkfn0mViNRVKW8+TEd2InZaKs
         tRlAKr9FYQuLGLqgfBQ8LWbn51FpknmBaEvp9EGtGD5wm+YwyV1w+9eTMyXjqHi0H8Hs
         x1xj+yzIkeMAa9m4NPEUoKYJIuuRxA+bqiikrxK3Y1i7z4xjdy0Gjwobf/pXFI+AiRar
         nC3eWkyfko8T8SbftOTIK7M31OyjdoErgPR4laVklMxnRItLR6ClFJMVu5PWdGgvGW0/
         t0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU/9BW/PHY9oGS/F+BR7O1YKKq8SskOanHyiU0VKsuqv0D9g2xc9MXAaiF6mILN18YTIlriOrpT2Gel7xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuZs/VmEFFY6YVrXSctvS73RogMAP7b80YtmRLTl8vYnfVtb6/
	GMD5eGAseXcmA1RH9qdzzv0hJ+n7pnQj5Osq2+Ah7Uxr+QoJUINabkfQH2+UGUwfEBIy6HwI/I2
	4cF0VV8YjI/aNXtpJ+ZxXr2rJKM6gg2UuPUn/75sDiRR1fMNzrglJlWgAAr1qFpN5lhQ=
X-Gm-Gg: ASbGncvF+odQWlfCBjT9d2Cn1gy77Jb6oQLwspkiM4RW26guMLR7cepiIRXRqfYLgW+
	7Zm5+arJ+uU8Pjj1k1MKmrO6V+IBvUTEc6DH9N/21EQSMc/qL+fPB96QW9bN5y1p+D7V0eYo7+c
	qR7ieNyILHimNnFVly+DwD2yeEqO5h3GNXpNdjMeKvi9NQU02A7Nuk3z/6+E5ZakXw56YcQw0Xg
	krAJrdwutizcX+AwZvCbv9Rwpjeh1/xwbCnBcriFwzXCjrac++3bkNzDsLYepEzle4ENoG9NRch
	CBI75ZNhUySPLkb7gKOPKkz1hnEyHvUIRSvg8ALGpwg1urhhPrZ54nb2xpF3jaqOWnj98ncHR5w
	ZeLIv2Khn9En5ojgFXSiWceZHWiw2WA3lqRQ2U6dM9xnaVbCFhEHg
X-Received: by 2002:a05:620a:5ed7:b0:7e3:30f4:fcdb with SMTP id af79cd13be357-7e6962dfbb3mr978589385a.18.1754285260396;
        Sun, 03 Aug 2025 22:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMxoOfzknCZ8uMmy3YY6kqSkPaQ9xTlPrcxG3f/lbgV0kvxmrcKW8Du96Of7dM/xfXukyUdA==
X-Received: by 2002:a05:620a:5ed7:b0:7e3:30f4:fcdb with SMTP id af79cd13be357-7e6962dfbb3mr978588085a.18.1754285259948;
        Sun, 03 Aug 2025 22:27:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88ca3214sm1541878e87.126.2025.08.03.22.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 22:27:39 -0700 (PDT)
Date: Mon, 4 Aug 2025 08:27:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Imran Shaik <quic_imrashai@quicinc.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
Message-ID: <45oycvzjogctsoi4jiumxtastsrjzqrls3wc2vap2eryq5kcgq@leirtq2vfvxi>
References: <20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804050542.100806-3-raviteja.laggyshetty@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAyNiBTYWx0ZWRfX8TXszKlr4q02
 ePNvvlmXtP9I6PgbYjMetjwel/iH1opAaEYWlhHcSZJPRTZm8gEC2jhkTLorqzNWTjRjyW/+JiI
 FmFkOvisv0xyt0U0QckhZomO1SO9TYjM2Y2ya0Hkas3azy7UEatT1eX6MLgq9j8lbK6po06VbpO
 jhJeP66VBLfiPHJPJXfzQ33rOpD/00gFyOgLVqUX4VOz2Q2BJEqvsJrOQrVxnT5U2WKBCmrzU7Z
 obaZpdOxxXSDmAPAICgW77xeHYdOpehTnKEASB9AI2xGHYK7XpmssqwI0lVOh6cR3bMgzv0mfUc
 EmHWL+g1o8sfbCR7iM89IjHuzeJlVbi9Bj0w6CNEw+fv1JT6h6+tY/fWb+peOqClMsdHi1aJ64p
 /gMf/mK5uUjJljbhbOdBJ504SbeZKg6y/mh5OicG7XKOLJ/ZiVTiTGYPKxOUQblxo9Ybllpn
X-Proofpoint-GUID: lT2LGUZMc9C4frPSj1yIAyenLogDidtS
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=689044cd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=qnWTwb_pmrVv18jEe2AA:9
 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: lT2LGUZMc9C4frPSj1yIAyenLogDidtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=815 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040026

On Mon, Aug 04, 2025 at 05:05:42AM +0000, Raviteja Laggyshetty wrote:
> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
> compatible as fallback for QCS615 OSM device node.
> 
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>

This SoB sequence doesn't make sense with you sending a patch.

> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

-- 
With best wishes
Dmitry

