Return-Path: <linux-kernel+bounces-761013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93016B1F301
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 09:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C6B3B277B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4527D780;
	Sat,  9 Aug 2025 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8wl1XtU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50A279791
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754726267; cv=none; b=d7AzgwUKWKRm2OBIFoGrAhjnx39xhPgLNRTSY9VeJPVRPVm62vixP2vCgtx3rNTR75339Y7GijpfwOuLowz1/h3L5vMoZAHNz8mMrk9rAxpD9dtYqbJyrlkBw81jOgn8z6Jxj0WjO7lyxUOJxDehyrn0ekITFtJ3z/F4WYcVeV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754726267; c=relaxed/simple;
	bh=oh4gA+jRg2Y2t6H6ab0cfcQsi8u12BugRfmwasOQoC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5HOhpk1nCecXHB//kx20kDareCKn0T9cZjWstk+I3R6vxDG7CnIeuZ4K/Jg/tc/RlS+2cjl45IdW0jZn7hUXXYRztQxAi7raBSQBhTs9aR0IBMPNSVWFR96BK8RgRVKcUeuXXdkRHm0YKo7vIA+hRcuvQMRfcxd2VitgKt8hsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O8wl1XtU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794dlHB009287
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 07:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MHkzIZBShOGt9MA7UVWK7LV6
	yMeWr/62GPPAqQE79tA=; b=O8wl1XtUkJSIBTGAs/rXFxl87pMLaVNnIkGRT89w
	xJrI3wYmKWuqGHbRJHA26CqzQ2X+kmk6apjFQeQNWIkMMU5Uj3/d3bZ1WiHA6lTd
	FHOa7PvEjU+45J514LX8sw8Y/FJPFDWZeGLxlyQ39OlBfWkPiAm8wmVFZKli4sCM
	w1chfhIpK+/pt2BoMByiNpDI6YbLsm6lWdjrw370lZ0Vex6unAudKZecPZ3MVwqZ
	9TpZXPVN1MPHnKsq4jq1R3JMLiF6EiaxuqCglsqvMCp/2kJCa12Z7EZZlc1jtQpn
	NV/6NfntYpTlo3fkLIhX5QFk5s/NCan4EiJUvVv2uUcjeA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygm87d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:57:45 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b0680f6270so71915271cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754726264; x=1755331064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHkzIZBShOGt9MA7UVWK7LV6yMeWr/62GPPAqQE79tA=;
        b=aO7JdjzNrGk36LwcN6zdhxsTxPDGZHnYxVuwCPKsm/TSdbaoP0ihs9RAZgKgfKBGxC
         a9M4Drp9ojH0NUia92ahDcOMr4a1OkqY5wZn3vAPbj7dHgx4wdw4FQ7pacEI820a+Kdn
         LXHzOsEPIghlR8q3k15NVKtqBmPBRutu/917uASZ/XsdoUBqmdwdCMOM5w0jcL5bxZA0
         MWC8/lw0fYvSD26AqnqFhnPoY18Wt7n7/RZEg81fQU+sNYGS3apjL0AipSh0G6L2kSco
         hhvQQ9Tfu9OXnKKTs2K33kvDl7HLcFRK/ZMfMe4CrnsDifOqLqW0kYPJ1XrBApqeZMcm
         GyCg==
X-Forwarded-Encrypted: i=1; AJvYcCUa+IbebSY8hpQwEjk5EthgStb3j+HZ3jF5YdcrFvcx8mRbAcIvh54JhnblOk2CaEvHFEswXjqNA/fGANE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHkdf9Y1ftg4TpTCPHUO1LLOwRuwecwhZaE1Us4dxzP+tAdhAK
	EMNC0cS7g0P8Z2LBiFG7ZFXKt6kSG9/b3U7rDTEQQppYfhmXbLiRRoHCJkClMHanUMEUNFHfC9e
	AR5PTPVU9WxDZ15xtSzrX5aibwKvw/HK4SV1V77YQacXn4+fCVVvd6qR6VWoHzDJHQrU=
X-Gm-Gg: ASbGncsve8zN9V6yHnf0rE7y4/am7fWZ7bd3S9ZEwz0jH9iDh9AUtErnkHy2zxewV3y
	iKSuq81U7zN4k7bWSCSCePDz+Q0E/RXQGRLKossidlvhLQ01zL/ZbJhllVM0evVssXe4wI8PniD
	P8LJBwRSrLKKBU8JcSr1MBigBhl71q4wLf2XF4I4FAyMbMVHGRx6Io0RBoBXOOETHR+kJuX91TD
	5T0uW60rX3Dh0ULDl3AaaPrPl++v3HSDeu0npZ+/bn9z/5D2o0edyfxs2hmwgqr9qHQQLrTqb0u
	pMNFXFYq6rvxTOmrVfyuoODRWPlJ2N0dDz5zA4aaaYp6MzghiJwBKrJT4kgdiPl/hSjLXQQX0Li
	U6z3D+e0PmfZ4mZ3mWC+kdtEnfUNlfwGhMajFTGy3li28oToEEHhs
X-Received: by 2002:ac8:5a09:0:b0:4af:12b0:57aa with SMTP id d75a77b69052e-4b0aec6fcbfmr80634371cf.16.1754726264335;
        Sat, 09 Aug 2025 00:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZcKxAQsU4y2qlurvBrtplQIY3fRhPoGV1bNNa+z2XGi+BVNOPWtwNB3/KnTtakgGNSGDEww==
X-Received: by 2002:ac8:5a09:0:b0:4af:12b0:57aa with SMTP id d75a77b69052e-4b0aec6fcbfmr80634201cf.16.1754726263912;
        Sat, 09 Aug 2025 00:57:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88caf6dcsm3327161e87.159.2025.08.09.00.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 00:57:43 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:57:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/6] phy: qcom: qmp-combo: introduce QMPPHY_MODE
Message-ID: <pcmy74pebeskhfactygabzjinpbcfhluhdx7rlbx7kds5wynf7@hdlkfpkg4va7>
References: <20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com>
 <20250807-topic-4ln_dp_respin-v4-4-43272d6eca92@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-topic-4ln_dp_respin-v4-4-43272d6eca92@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfX66x/W/4rl2Gz
 G3SKbWBDtMIeBErqiQPbHU0ZMY/oWCz+Smt4T8EiEE5b8jcdXV24VqxFlQcNpG9Z1sJXT7H1kdL
 MTDUpY5lMR2AuIFtMLwx2+b4VOCGpGtgo/awEblpzL2QBoJhQeOCRJQ2T8HEAsWdgY5YHw6QeM4
 PjDbuv+DvhjUtK+ZAfAuLp+FXIfNliz477Vyklt/ee8JVK7EqbmZwqHstSZn9ffjvwHzGYsNPkQ
 +HslhakVP1z77SXWDyB6o/grZnYxmTUohA8aTYUB3hjdvBzKoEr6SqhR16gNO1sTBxuWE7qWdHs
 jY5RCVVwlEclWfJRrIEQgE5QkzXGj8Fce571pR989qo6NdmTh2rfhILAhJMuTYhMsf6+On9vMgf
 uO0fGKjq
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=6896ff79 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ruQs36HUC5Lhap_3HWYA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dvg0k0c3zVqi80gxopNthqJPkdlmimyZ
X-Proofpoint-ORIG-GUID: dvg0k0c3zVqi80gxopNthqJPkdlmimyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

On Thu, Aug 07, 2025 at 06:33:22PM +0200, Konrad Dybcio wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Introduce an enum for the QMP Combo PHY modes, use it in the
> QMP commmon phy init function and default to COMBO mode.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [konrad: some renaming and rewording]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 44 +++++++++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

