Return-Path: <linux-kernel+bounces-815930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2BB56D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD85172ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CED18E3F;
	Mon, 15 Sep 2025 00:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pANlLx+1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C218B0A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757894621; cv=none; b=JOom04+6AbKbNoiYo6QaNOPbEhVjCLNPiYAQ77EFm2jFmpJQoig2CWrF7ObU6TJ9I2OzEhMwxcuSSViXYqRtu3hccqp3z27AQBwjn4+jo/fdXlcX1MVDWFRTimcqy21w0MiDmalnxC/ufqq/h7FYEDN2Wx8hPJqHLppmrBWdYcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757894621; c=relaxed/simple;
	bh=2Ljq9TrPgOnJLOGBCkDSJsvuJeZQmaKb9drSAQUZTW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppUSnqUl8O25Fmk6mySwhsUBr6tVHQpng/Ewj9wugkUFmPeRMcNMFWfh0cNdGoB6FzLmLJlEI9GMqgAbYFEcSXg8x8p94ERhdJxCvQlal02A8SUyOe0Lbv+Jc/AsNbzsNv+J4Dj/CNIkGCq5ExEvEW5fJOs7nD931ESta5c+sQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pANlLx+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EJmtU7016483
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=G1/nzps+RiSdN+G23dzIrLGr
	J3N7Ua8T6tj2YeHkdOw=; b=pANlLx+1g4xmrMy1/EoCSm09DRtxsj1Xh+nMO4GQ
	GnYXL1kJDM9co3FLyxH9Wp0UoXMsPe+vxCFEmb9eX+DeBpD43e/lMjA+PCa3hBnN
	sPWel+HEF5vpQRQP7/2AKkgqD89WKJpRZ1+dX/4OhZxT/mm6wXtt3PU3F/4PBTvG
	/QbPgyX3c9dwBUx8/wGD/Yte2nY1uDg5W3dVSzs6XYKg2U6IQg3uimBTer/5JLx0
	cdHG/0H87kbX1AH554MpickKh1YzcdpLAldq3RucyhuUTrHoCBUakN2GzmtN3+aM
	m6QEyXud7+jumx6pGkvu7c4ENORKd09HDa0pkeANYMwq/g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpsrnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:03:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7726a3f18a0so28417406d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757894618; x=1758499418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1/nzps+RiSdN+G23dzIrLGrJ3N7Ua8T6tj2YeHkdOw=;
        b=WTyl/UyVI9RF1cIebegG73gc0T+oamINp/pSHC28MJ7MpWwP/TPGz85G2zgL++aGuP
         SmU8nWDUUaPkHBjAbTxKJfnA1n4CHuqxuY1ksagOqlr2EInkbl1I0WfXQytNFDQ7RDt8
         c7tgggi3J1RV2inZzlxd0LK5p9NdKBsAbuYLqzQGvsxlP9SaJ/cadxeze74Dc2tPhFg0
         MlQjI9EgJ/I/1mC76hVd5hLOeNsgrLzdHSfcwrkuBlx/8MLQPtVMprEy/Jti795e5QpU
         djt0SUwshXm/UswYEX9r7tzERZmK1ZnQzJx60tbFEcaQ6ebM5nTxWCm+uoGFohTlQSP3
         2qbw==
X-Forwarded-Encrypted: i=1; AJvYcCUHO+M6zxq+6oetqh63le34kCcFcgJg/nnAefV1swrDU7An5tCKiqR36PDoy5P2LCC+lySToWJvZ6sxne4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweRakTwSvU1wBg0X9gnec/o+K1HKP5Gmns4mEIKkb6qNp8lFhk
	Fnfa9qkBNsZ7rjM7yMtZ8m6z99wipMfgUmfh9lFNUoxqjx8Rp6SN6658ytWAJSz/oA6ZkePn7nj
	vObuoplsfecQ6uHfbGPbB+G+ntnsUaYSgYf89vsMG/xsHQuFFlEGik9JdBkPnWzGaQzo=
X-Gm-Gg: ASbGncsSIz7DYgal0wcz7EL8wVLqLQQIcIyxudPZSdzbc/IOiAasCVUng7FmKqf6uQ1
	cqjsCgPkyCi3odutu25yLZ2w6z8lyVZ9j8aEEOfUTUxLyLWZNIjo/vhfGDOo2EnhSdh59iDNBU6
	geD+Br5T9le1WdEPL2pRhd7VK8/rSTJ6pM4htVX53jhiRwmLMfxlWSjq3nue8JVHXcYW9I3BH7J
	Mo5VQm5R3bD4OVFc8WPvXRic4fIGH8h7TcEm5hWtIOaPMCZ3m3WNIuLbnkSN7hEayuLcw9va4DF
	DmVeTfn9DbbpWmDCkJ95Wo/yuC74y0VCphHATuq09lX2jnPJqrGLedscbId7vSDBmxi2HKL2fHE
	Zz/8vdRTL5M1lyHqjxVQ/boNu00j0yXclGGeqKowdJ4wPxf0NE1BJ
X-Received: by 2002:a05:6214:ac7:b0:77d:bc4e:e0e5 with SMTP id 6a1803df08f44-77dbc4ee296mr35056286d6.14.1757894618565;
        Sun, 14 Sep 2025 17:03:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd9XJDUHsxXiEWsvt2wRNO48cVLBLKY5tingp0pyD38cgQv6RiAe8g3fhFzooP4xBQyxvz/g==
X-Received: by 2002:a05:6214:ac7:b0:77d:bc4e:e0e5 with SMTP id 6a1803df08f44-77dbc4ee296mr35055926d6.14.1757894618134;
        Sun, 14 Sep 2025 17:03:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8212d8sm23244261fa.36.2025.09.14.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:03:36 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:03:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Max Shevchenko <wctrl@proton.me>, Rudraksha Gupta <guptarud@gmail.com>,
        Shinjo Park <peremen@gmail.com>
Subject: Re: [PATCH 2/6] ARM: dts: qcom: msm8960: inline
 qcom-msm8960-pins.dtsi
Message-ID: <57nmwdragh5sw55ji26v3ao6ekxvgj4y2okbarlsw3646adjq5@zmlu5dg7huhe>
References: <20250915-msm8960-reorder-v1-0-84cadcd7c6e3@smankusors.com>
 <20250915-msm8960-reorder-v1-2-84cadcd7c6e3@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-msm8960-reorder-v1-2-84cadcd7c6e3@smankusors.com>
X-Proofpoint-GUID: FsArg-EhvVA29v7hq-c-7nzIsBDkRPam
X-Proofpoint-ORIG-GUID: FsArg-EhvVA29v7hq-c-7nzIsBDkRPam
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c757db cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=kbTPNbk5bq0GMcXo2L8A:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX3CKPx5wip5OZ
 JcDfuivbmndTTsd1MP+l4Hh404suM6lPJY8+5Dtc6S9HVUDtsol1HNXdbRbG/IRURBwvrWoZAJd
 dXSMK58AqGWSSuhnbhluGHrCbbUACXhXxNmH/5PGr+Bu2h0w9V/Jqz9UmDD5Hwbs3UqHWykKBUg
 ZmCRAbtfN4q/Kk3tV1a0knYPzX4lQI+nJl79iWwg9sXrgXjYE3Dk6W58TdoKN8PU4nlCn5pXbEi
 y8pY2MiXScWSxZ528sjGwOKJb5eAFWSXqkDohCD8b9h/dM6su73FjhOYonNxvtXV9l9cbZSUkaz
 IJrL8PVlf0V/piDITmleqV4KzgSUyz9aLjae5vDcbXitU7yN2WNZ7+YCafeOHiyZpph51aM7pRa
 /vzWIahJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Sun, Sep 14, 2025 at 06:34:47PM +0000, Antony Kurniawan Soemardi wrote:
> Inline qcom-msm8960-pins.dtsi into the main SoC dtsi. Most Qualcomm
> SoCs embed their TLMM definitions directly, with only msm8960 and
> apq8064 using a separate pins file. After this change, only apq8064
> remains split.
> 
> This is a cosmetic change only, with no functional impact.
> 
> Tested-by: Rudraksha Gupta <guptarud@gmail.com>
> Tested-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960-pins.dtsi | 59 ---------------------------
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi      | 57 +++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 60 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

