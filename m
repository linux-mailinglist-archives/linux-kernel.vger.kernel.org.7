Return-Path: <linux-kernel+bounces-833248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA1DBA187A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C25169341
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D8321296;
	Thu, 25 Sep 2025 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rdh4RSoD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C240D31B827
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835597; cv=none; b=d0e0YTmaCS8LOQKEEM4WML1bP6VUbp+CO1Nvx5QvcF2X62qhzYepM5REAB1liLDVQXDatNSuFXFnezTtEJ5FHSmcLaQwg5WgQZOKoFIvWMqI22b1Zo1WJiDjacMKmEMfBYRjLKFszaO1fgo183rSSy9W0c72m825CfQh8M25SA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835597; c=relaxed/simple;
	bh=k0yjSh2ANN6eecUIqxnDtUriloBzJfvWyMx9nup5pZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUGz/vUhUdT11EGGpZwmbRsf6d8aFxS/yLdKsOHQtVtgZQG5MxScR8/MILyWuK6nFLKLrEc5yw7cuiau6R5vrsvFH/37sAWkfa3+Tprf1tCsrArocfZ9zfdUWbAoIGKPL+Q1k0rW7ewikzDrEZvpJAtqhWltCMH9XeZgVKmNaCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rdh4RSoD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPg56014320
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LNofiBLmX+3scjm7ESiysXbi
	J9+y7g4bNVHA/dL9wFo=; b=Rdh4RSoDuySpRfTy9imujpPKVMr0+/f+/vjmsEVf
	HnrhSNPCiLvE7k7sHTljl1qX1Ey0TxQtJzc23QhRNgWDhP5E99JRwsABIwiM8pBk
	I98IAZbXKeZocyZhWmK+T0vtFsDQYHW5VIdR08MtvzuSZ99n3e0zdkxSC8LPfCWd
	2Na39j9GFgmtb4EnJjmRgUMJT5TS0oN/d+78RRAJ74kRKvqca2hW8SSfI/iFvqrr
	3J8gjDySCXfCF+kjFHFH4iYjfGYdNraazRCvt3BnjNHp4EeH15clO7DDtN3B1eNC
	vCDvs3pufEoSfTWpO+0SjMVjEF1O34DvM1fga4mP6prMXA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rgeuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:26:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b633847b94so34244091cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835593; x=1759440393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNofiBLmX+3scjm7ESiysXbiJ9+y7g4bNVHA/dL9wFo=;
        b=FYxYnyLYxgyCIL78YjvErDWMc9JZ7sd+1dxL+0VX2OIYpr0ObjxQdUKyess6LrNUvR
         WOfdxNBEDHKJeStCVnH9VqaFVJH8LyTbehCcUQtLtC+e+14zJfBqQQLDUBXyAtu4ihUz
         Gn1ncZTawZBaqhDVATiBaUoy1rdbcjHTU7neppXfWNgGfaUmdSAbiarXPdSvXedxqPjO
         iCCB+F6Thqu9KuOXCrLsLSHb3VbcclUiJAP8cKc+7JzNBf7KbNXnSG7hSvLcbgaeZNX9
         GVbLLwwxn36JW+deLxAuRhY/CNrTGMs0bHPiM72gNvasNJimwNtrkP8awVUr21cVGiqb
         kl1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKeBxln9wnwm8ih3rLk7+LmsXHo8S7osreoeh+qB0KUA53Hqxl+fZmcp39Rf3XOeC+GPg4+TvGeX3EFN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0zK+zxXDZDs0UN9CD5dYRjRhQqZV5RsQRTugubaZ7KmfhqV/
	NU+jATf+s2OBs1Yu1kN17vyVe3/W45uRyoiPkYf6FTQ6Q1XE0nxn03MMojyC3OMthIu9hF5c5DZ
	wvQIgfoFw72T47ya8Fccnvq9VG7rGyMc90c8/TKSrKwgq0q05J+2riunWN0ckUEXXfNo=
X-Gm-Gg: ASbGncsfehY88UYpQz016vgEUthzwhHFa4PLVbAFwF1Q5e2x/8MkvCy/QoVJ2j2EGd2
	2Afan/E3tjAFI351idOU/obiDw+HY71ID+rUhwohKA8DT5ZOs5+zjK11UHn+5PDXtgwY7hOtDeK
	3MPYQFOG+ACondJohpWSTGxba9de7V7ml0nNcjl2B5DJfeVPRujg9Nw4x5VGWFH4/NztuO0O6h4
	jIhO8Yo/D8ckdcotKGyx9d67WyhJ7/Emh9wozGyQK2XzWWpeB/O2CsvAkOWNSPTea6knckau3F5
	XhPzNw47w/0fO7Ea3zqOZNgvf7yY4FB7YbqmRe8wvw9Oj6m8ABW3+U9U6ta/ehOYXOa+pkyWQmX
	lyKeO/rCKXWyZR8bIoCx4BLsoW11IBn7UrxvSOHx2ooxyRc7zw272
X-Received: by 2002:a05:622a:14:b0:4cd:fa3d:9c0a with SMTP id d75a77b69052e-4da4c39d3b2mr69916561cf.63.1758835593345;
        Thu, 25 Sep 2025 14:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJSdxhuD1dfzzIzvxJqoo52XPqJp9hoPrRGGFcB4BT/HealsuaBlfh5g8fOW/NRvXrmYui7w==
X-Received: by 2002:a05:622a:14:b0:4cd:fa3d:9c0a with SMTP id d75a77b69052e-4da4c39d3b2mr69916241cf.63.1758835592884;
        Thu, 25 Sep 2025 14:26:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583139fb60esm1142055e87.47.2025.09.25.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:26:31 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:26:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
Subject: Re: [PATCH 6/9] clk: qcom: Add support for Global clock controller
 on Kaanapali
Message-ID: <jfcnilahauqhinz7mlsyjcqpovy2bspithahhotqayfxjqbtlp@fzkqchygd5hd>
References: <20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com>
 <20250924-knp-clk-v1-6-29b02b818782@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-knp-clk-v1-6-29b02b818782@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d5b38a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=F7eGajQwVCTwq7oO_cwA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: soHNQZtGbowvwVypvJ62OqtRAh4-vH0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfXwXqL1xqQA7/I
 6e5pzp8dylOAejIbS5JVM8MifeUigNyGyvGS6MJLz2DW+/gacpt3KkTzi3PpY8b+yNJXpDqR8M1
 gF3B8MnGE8rNIpIbZDkkZ0gLM/nQl0wft/cExgdkl9dswPCdwCrmJh+iBcFAcCAkt64gFLyTzWq
 QwIkele1lwTopMOwS1TKQPnY9wRRtSYGZdGXOtPlmazbmQ0PFMqomYVq4qfbbHq4hNfrp/OVggT
 zbinEUTYXSZRzG+GoX/K2MvlJFSYbvwR39YFP3K9q9ZSlAUxn9NnHwPGIroOpabt3sHjqosSKch
 44Npb0Eh1gmd6fy5I5EILgKBBYoKpr8pglakesG3IgKr+RWxt89bVWpcEmxuFgD8pZmB6mw8O23
 w0SUtmD8/QyKzzDOkC1vC+ifO/GjPQ==
X-Proofpoint-GUID: soHNQZtGbowvwVypvJ62OqtRAh4-vH0K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On Wed, Sep 24, 2025 at 03:58:58PM -0700, Jingyi Wang wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Add support for Global clock controller for Kaanapali Qualcomm SoC.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  drivers/clk/qcom/Kconfig         |    9 +
>  drivers/clk/qcom/Makefile        |    1 +
>  drivers/clk/qcom/gcc-kaanapali.c | 3541 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 3551 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

