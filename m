Return-Path: <linux-kernel+bounces-818641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8875B59480
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74BF44E185A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5502C21C0;
	Tue, 16 Sep 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iyu5PinM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437E2C028E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020367; cv=none; b=l4+hkalbAAEqaPLADz5ZAXo01OH78ZargM/+BYgd6dAVVW9KPgoyUNLsA7PFLAjMzK7flajeV/koPM5+F0odrKKsBNG+GNiFOiEnr6mk2Ay5e8wV5P9KfnaHqwPMSXY4qwBGT7cSMK8PDCJAdfApcXmsElpPPjbujl4dvhfdUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020367; c=relaxed/simple;
	bh=3dM7vJjkg5Mx5e5iRX613YlVuqKV1/6CMF1mfmG8ByA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjb4Kwh8XAJTUioAc1NSY7+EygPeN6/suRx5G2FTHzfEwemWewcPhpGTQ6KgUODYClAx2oN14TXKNYlLjL4E8eOK3FmnlLXwZFaDqSouigyBQXFGqqu0f2UNBRD7aCt+UgClN1kriRqfS+0yA2YPAbUlqMIDTSzGdl3h4/RVPpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iyu5PinM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GARIGf010985
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mFiDkj+L3cwYNIifGEmZEYEZ
	JXhnfzx+t8PT08ZFf5U=; b=iyu5PinMriJk0GeFWONK3k72LxXT9dlRpzDlwyID
	4isrTtlsPWxGcINhGfRg2Gz5klPHcUspF3zgrVQ+seHHm0GDEZbC3vFJAlvWN1W7
	J9KZCeD8idbZDwUHjhannikKtAwrG4llLAVfqxzB1vfwixDftMI+ZtJQiHpQ4QiD
	vHkr0TDI/RcA2d40hH0TN3wDURsxw6x0VSyS9ieY2/L75xobUQ7HFngo9mMaOdit
	hv6c0eRkZA67mzRSBZQVbHCoSgiDq1QDbtnHZjhaa6JU5Jp3TObH8SJSkVPB08ir
	56dC+5seyG2nJwTCZcx+QaWjJ2DZuxXjJPFFCr5GokZ8uA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951snrd8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:59:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b60dd9634dso126820391cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758020364; x=1758625164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFiDkj+L3cwYNIifGEmZEYEZJXhnfzx+t8PT08ZFf5U=;
        b=xFINCB5fW5pCeHt3Aad0kSC3L4+E/V6lMrfR1BxU/in6NGuAlGo7guiaidMmUmkRZ5
         chFPTq1MJCqT5qp5iKU3efwwCFL3jGH/H4fNAP8O04xbQuLrCGB45JkV71XrEgLoot62
         uKL0KEdCI2tLE79wy0PN7RU36VXBz51uwmWd+oSqnYEshVCtJA3FZ4yZt78AzWy3dYR5
         bChIbAS+ZLZKZFv8jCGsApGC3uJcO6/5nNs63FviKepwMN/qAYY7SChjuC3yMqJ+fc43
         MzGfwSd4GzAUwBo/+wdY66qVSImloR31pJtfCmsM5d5/MiW8Wmbi/dJd7Lf3uquNZ6C4
         4rAA==
X-Forwarded-Encrypted: i=1; AJvYcCXPXo0dkWhDTRLQiHyk7O9wsj2D2SxQzHnRMpzZBXAGTIW0slL41wGIDAdQTi/SrBiErXEdM9cqzU8+b2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZTUYnWhDaGTOMWOn9Pf7npgpsGAcunH7Xy/ZxuPkIRN64A99
	p3tgUYspL/1iHojGEahRlC1EG1+yT1rsz8+L7xDlySb5hS7VhEqssL/o8//+1R3qPZmSRpihhbh
	pILVFCZ93Hp7bBM12LF+5VMg/dymlphtR1GpZcto/1gq1wHMaQWgq/bnqhM4FqI8ItI4=
X-Gm-Gg: ASbGncuTTneBf8c9Xf4lL+pp3cAuE6iYOK863P2FAJSu/pEzZ2zi7Xa8VOAr3ipH+3v
	9TQcLHB35DRNJcIEBdZM+w4lt7++6REBkCl4hmlXXfZfJEbAt/pMWdQIWs83LAQXY73Wt2XhKC5
	VJr7DlYpeaGMNfRDQG8WrvC97e6RJI34jerHkJJ6MltmGhmNdlZfqJtWbo6bdmGxD9v7jv0mMXh
	mEyPjUbOUypygc0ygEax7309C7TR/tOTTdOmAuUQVwoMiPJeJ6Ahe9djJu7fMgWBb02BoxTsB2c
	M42ayMmWfZuBMEwnL9zzZsipbgu+GRsHehxEwNYKgCn2kP6lfq5bo6DZgTVjnrNCND1ACq8OIDU
	gHeOsJRN8LXWz0VHfkUwCFoYQ48ik3McXhYWob42gU9uAXfE7g+DX
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88217131cf.82.1758020363427;
        Tue, 16 Sep 2025 03:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDj/hhJ5O4jQLZi/UnXUBCLpKD2mcKKa7z5f6/+2XEQQYMmtnF8am0LXMBESmcmRpgg7zgUA==
X-Received: by 2002:a05:622a:5e18:b0:4b7:8cf8:21a1 with SMTP id d75a77b69052e-4b78cf8257dmr88216741cf.82.1758020362518;
        Tue, 16 Sep 2025 03:59:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e663c5005sm4331812e87.149.2025.09.16.03.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 03:59:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:59:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: Re: [PATCH v5 02/10] arm64: dts: qcom: lemans-evk: Enable GPI DMA
 and QUPv3 controllers
Message-ID: <n4p4www37qz4hw75l6z2opeqks4g3u26brceyxi6golam7f5aw@raandspcihi6>
References: <20250916-lemans-evk-bu-v5-0-53d7d206669d@oss.qualcomm.com>
 <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-lemans-evk-bu-v5-2-53d7d206669d@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c9430d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=E-8pkxSmLjkzrIbgvO0A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 6erGgZaP5LflRsxwnmAlODmuFMFmgEsi
X-Proofpoint-GUID: 6erGgZaP5LflRsxwnmAlODmuFMFmgEsi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX54QqSm5RGgD0
 +0An/jK3PldkuJ8jaqHoejM++BYHbs3lkfAViDfwSu0pJvgWnsM6mdmk6vWt9XBTCvrVsFHkHqJ
 Y9FtgD7zFG341V/M83GZueV3UhuuJ169Gu7oNOTZKLZSTzZ1LBllyvvy+OAQWKe6VdnUjwykDGJ
 Gho5UeR4HW85/OlajN5+WTtDkD7nApPFxyvONn2JpSnrQFaNfw4vqr8Tn/eN9hVlN7hpU+G59Dh
 fBAyugrG4buGetOS7MT0w6pIPBu/2xw/daHtJNeo4S9Ym0MnWMh4dG9pBg70ryuLcbxQnARVb9I
 kfzKgU/n2f5F1nMTc3TVVmxHsnOIvftPGYCPkBumuzxhMZJ2VjHU70E5mETLq5d1jJpVc1J3VHc
 lGcYTLvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

On Tue, Sep 16, 2025 at 04:16:50PM +0530, Wasim Nazir wrote:
> From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> Enable GPI DMA controllers (gpi_dma0, gpi_dma1, gpi_dma2) and QUPv3
> interfaces (qupv3_id_0, qupv3_id_2) in the device tree to support
> DMA and peripheral communication on the Lemans EVK platform.
> 
> qupv3_id_0 provides access to I2C/SPI/UART instances 0-5.

Nit: used for foo, bar, baz and slot ZYX.

> qupv3_id_2 provides access to I2C/SPI/UART instances 14-20.

Ditto

> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

-- 
With best wishes
Dmitry

