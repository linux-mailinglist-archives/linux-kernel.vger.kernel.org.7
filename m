Return-Path: <linux-kernel+bounces-761006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BF5B1F2E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8937A624174
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A227C17F;
	Sat,  9 Aug 2025 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fq17dNGB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C531E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754725001; cv=none; b=OeDyV4O6ijCzubCDujiMVx4vvelMiOLmuDtDZ3cuwFE/ttqWKj76OoXbsLLI+NQD74G2RHof1vfRqrE2ojRWvB5fquvUilDImt3yrb74LUrz4LLu6oPppxWNLNDGtTbIm1PpDNeCnpyBc2mqYq4+tvFKrHEs16jV4o/L55WkNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754725001; c=relaxed/simple;
	bh=KV+nbotmPaioDUnvPXisviPPbgOFzIExIt4xbAI+QB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MX7IuxbcAK8+3L+601j+DJixthZYnSW5iRbz/jlXuAwDI4lNr/2ozQ3AWbKk9QGp8X8hYkDssnAB1DzvqAgAmOb6vKcWOnz6b2a4spddWv6VMYzCHLu1K6j0ddlU/yQQniK8cyd8if7oym/G+6+8rv7KC0FjhfTVwKgm1YEuRL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fq17dNGB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794ftoW013556
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aFTb545D0EnqrmPmVub6t9kx
	Cv83ILSV+GDMnaszhak=; b=Fq17dNGBacqviGWaJFSjXGQRQfwJ/Q/jYxDp3HLs
	nyTcCfLkOck38U9EreOOEv/8r0yXm2yQ+b2H2VS3nnm2h0p/JFJxbkqdnGXirhc5
	eoG3zV4VBm5Bo6c7HbcJkx/PUZSveIRy8rvwqwO0OfwFzCwe0wcayohuBQwzlfwC
	FU+D8P9RjW2qJcvHQQCxtLyjihevvDUV5RaSmor5u09jyxLcEFB9AzxmFS2xSwZ2
	R+gA/u3xKW0EbcIMReykp+O7DfaCNALn/OF6sOcuHjTqxD5UFgmd1tpaV61/PwfT
	J2VLv5JUukQ/7A//Ig6QJ4K/szHuwf5V3WsPsr0WciMD6g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm86gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:36:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b08a2b3e83so80289661cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754724996; x=1755329796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFTb545D0EnqrmPmVub6t9kxCv83ILSV+GDMnaszhak=;
        b=bNuIFQMHVgvbxeYoCu6QOgTxCqcppZvCHj7Yt4HPo9/qh9JPW1z6sIQOqFOaVq6Xa6
         6ANHOk8nPB9RnzEUarySg/+xGxHXm0GIFJ+M4+cy3l3otaJ0Y/Gyp6xP4b70MAbYV2pZ
         nqd1wrhvmlPCME5z/28gqDCfgCpzi41Wj7fB7d0evEJ1t/iyT2x3/4vSDSIh/2/Fn3x/
         Qum7LrhSH4i3Q1gLDxhUvHo7Mw/ckT6CVFLCvhy3Yu+N3TLOiMiuu2OG7ix6G3tMWZsE
         N50YNpzofN0gqDYWW/2SPXDt2+Fg88a+dNLZKUcPw/K7p9XpzVuotUr5gcgoGbsGD/ZB
         Nbng==
X-Forwarded-Encrypted: i=1; AJvYcCU83Ozfvf63b+U2+0sn4be04VTu60bkJHj2C6JWcE7/2rQ1/XLVXlhbQ/zLeKcbx69fXhpUM+1UiD5y58s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwydbbX5mLhiQPezmRm5pJUhzb34/6DKMY47UkVreNXJNFtki6
	Mlu6xPNcJchVvtMOtBwbSMAi/KoF23DpUx8FuMP9Ks2Qc7XpiD8PfVkxgXaHxnzHsxg3O+D+gJR
	3iyvzoa6eMGAQLHOeW+XeJJvdEkbJaDpS1Y/7UiRwj7h2KvaiMUz10JQ+WUfC7BSHnMo=
X-Gm-Gg: ASbGncvm6FdksBrurbeDwhZ13TYOV2FE3PSP5yUNTx1mvisiW24OBR3Ptf+/cWpmiSM
	5qux12SkfMGyGEjImbMhioiC//6qw1kghl+jZarpgBB9BhzW6PWJgeYR/sYgzqavi0/ajnC4W9e
	NfkdTCdSbvWpJ519HV69phDpW1y4unVnSPRqvrNJpcW2q+F3Qd39k0kSEvv54IS1Fsa5wbL8kIt
	5pxV3AXCcquSeu+3ymO1TveZuHpnFY58VMdxTf6zTylNoI6z5Q0dXLDtiuX6ROyQBv/hkKwHx5u
	qsWrh89Vo+ROyAxVu2ck3Pnh+cjJ85IlZKznBsOR4fqXqyoQ2AKO7s9AYtxuVvMGKXJiUzo/sd0
	fNqCNy9MXgn0sDz/MLd2j83bqv0pWazrlCmf7+Xivj3Zj5N9Ikw46
X-Received: by 2002:a05:622a:5590:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b0aedd7cd9mr80306471cf.36.1754724995868;
        Sat, 09 Aug 2025 00:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXEneZ+bObkvykBsZKTcd6gDIK9QejwdLRYsOVtihnF52Hii0pS/IlNMrVnQLjwaC1m/b2yA==
X-Received: by 2002:a05:622a:5590:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4b0aedd7cd9mr80306271cf.36.1754724995440;
        Sat, 09 Aug 2025 00:36:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889a03acsm3288206e87.51.2025.08.09.00.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:36:34 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:36:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add clocks for QoS
 configuration
Message-ID: <m7pqgeqzpqdal5yyukszzbkniyijiji3khzanwjfqxah3prgij@ucgndrn5smwq>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
 <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808140300.14784-4-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX/IFxIy948fIb
 GrnplWxludPk1BLuCEuoXsYS7kE/tuBdQB5fXjS7mTEL7KBkEU9P/8IztjQ/mJ6w2uyCRbEmCyE
 wnOIxMQoSNUYF2rZhQcWy5+xowHUtucqz41QtIS9rK54v3ocl82lkKhBQdhdOuYPrXjCF0DYtYY
 jEVVZtrbs/G4ryei2PKE9j5smeQ7chMGZsNvUNco1R+KsuOzLbb0X7k1VH4wIWtp8d/9ZhV1o9E
 LBOM1s/nBlvQJ+f7n9X5fnnfgfvrbPDFC+4+KpfwoA9IewT3CoB9qEboWYbJNA23nYCYhFu9G9M
 +xg3v74sVndhHWbT0UZCwIdihh3IZniiIZUS8WG/jWIbEAKJEbpYnYUtHAAAUf6/bTrviFboAWj
 raDdjan+
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6896fa85 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=M9tGKf1UEhd6l-wMVe4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: hGbwLtkUzWCa4oqFXfHy7mH6WNdlwe2-
X-Proofpoint-ORIG-GUID: hGbwLtkUzWCa4oqFXfHy7mH6WNdlwe2-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Fri, Aug 08, 2025 at 07:33:00PM +0530, Odelu Kukatla wrote:
> Add register addresses and clocks which need to be enabled for
> configuring QoS on sa8775p SoC.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 163 ++++++++++++++------------
>  1 file changed, 91 insertions(+), 72 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

