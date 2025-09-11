Return-Path: <linux-kernel+bounces-812025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3CB531D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049CC3BB284
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC79320CB1;
	Thu, 11 Sep 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ys/xrdkX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47D320A05
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757592920; cv=none; b=nzMxQAvTs5qTazZ8/iHwNLDP35WHzyddScp1ws4W379P9nWF3+JKE9tFe5K6x6U7y+MwzFZhAQah6pfiRBr6svqwPWKtMkj+v1RUUNJoplwK3PLSuB1g9+3qwVjC1S1C6+RJTkgbcJF025UI0MviarolloRZG0VXYufIzkWdEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757592920; c=relaxed/simple;
	bh=KbY+GfGU8eYAzle6VU7JlfVLLGsvLi8waFEDCQACGmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1iVjwXSTlLA4+s1aBcIbkTJ5dMJ/VauGbo7MoXaoOd+5Vk9b1I0SMVdDTAYX1Marp45ulxnFsN4CZZySN7AwRx2zX8F97ZbbmVbg7qgJsMKqDSjcdKO+UX+XelV94mu14pYgO5z3xq91x3i2hdtt/BQw7j/0HPyahK6NZqPDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ys/xrdkX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBFZnf025757
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GObnP9Nzl1ngqqfb5uQqTa0c
	8SykTYTzmwIuZSpc42E=; b=Ys/xrdkXQnosg3YlpDRWCeLeLg8FbSXtg8MsXSpw
	AN/92kmr8tSxNnuQDnjH90RM2cM45oDGUsM1XtOMJJ4QyxoSh+OX5LEaPclOInpy
	7cUtWy70FAMS+Kpw50FxUHBSOIYjgzYpjAkXoY3Sw5Tp8uzqwIA/DnbzsIfc+Pl4
	qdHmZA7TY50BaEvmDngVQNVmk2W85sovX7rsd+k9Ubab6cOghGrzgPMxl4NlhZ/u
	OybwRPheFSvquObjVpGuPY1n1e+1aAe/Smi86+jgQ6HD0k3pPUjGlZnrirbN7rna
	eLYBA5mkqen6XKa36xi1PSiJcTZb4t76PvIKuyodrh3pNw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0yg7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:15:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70edbfb260fso11965936d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757592916; x=1758197716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GObnP9Nzl1ngqqfb5uQqTa0c8SykTYTzmwIuZSpc42E=;
        b=MA7TiTjh3FuYs2+ElUOtuT3z+sOf6mRuT+fk5D8Iuf/FCDxbtRgonhGpqVMpqUCz8C
         7pS6X0nuNb0ztAkfCYuhgvi3pOx7d4fONDK0hOMtwRhSeJMqe9o7BkZWB42lx1S3r93a
         x1kv8jSw1H/8Mhdo6N+xYjWn0q4BAtOPOV9VrhVKL3a4pkEmKwQEPk6xxsKkh+gwwbcM
         ZwrtJpMBW1GUEvp7JIX++M2I5fj82HDmGgPKUEB+TFtNGSuKjx5KMhhDmmXHr0bRTv0q
         +IIvZjFHhK9Xs396XuSKOERdMnchkRx/yP8AUP0P+LauhqkKjZX4Zzv6mjRx/F8b9os6
         tqMg==
X-Forwarded-Encrypted: i=1; AJvYcCX+//q8Vw5FA440zj+nuSLxzxHVXtLMuGuwH/j2B3ydDTSRA2ZNKwS/IRL4qAJELwFIEps2HrRZSidxBnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLK+IGKhqPqap/q0ws97HNLY7WGC8/mK8s3EuwwUjApYQFhXT
	gHDfFgQ9W3/KcyPC/c2Gvk/sclKmSkWt+V75EUT8Iw2t7t48mgNzCf1mARqK8dQxJ1wif0QV2Vi
	QSw5BgvLyHAj7KplWN/S95XgIoVg46dQD3atQHwQvQJexPcXIFg3bCM0F0GQ/+QpY2uc=
X-Gm-Gg: ASbGnctwxYEkB0rc5i2HQOfXnT2rieIRqaeIQIOnvqg/QfKHV5fD/ha06G4nJ+qSGSj
	n7J0hM7Rt9A819GicHsnDLiHKWSLW2DyZyEvVXrjxDvJoWE9tf+QcqcKNMmggJyj4Cze/VyqmYU
	4/8iKtTluFnoHj2VQiZ9r9O2HXLHx/AzwQRI1vPITnFcq5ZV8oBkLyzpTVObz/DDaLTFqi+HgQz
	6t8PyFJ3wTnQFWTiivv9CUOiHfeyetkRXF8U113ZJ0+eCmyFpCJVz0vkPOZcdaRX/35x9d0tQUO
	GnPdNitgRbEjMi/sWHygYNNq+qfmEByZM5kIaJEbadvFsIXUZaPbj6RYoVjEq2/6Lgu/H4S+jtL
	sXB71s07+hhg1XfQBvl2L4/fADf5sQqzKmNJj/VQX5sgQGTXnJTjf
X-Received: by 2002:ad4:5ca1:0:b0:766:be67:3e63 with SMTP id 6a1803df08f44-766be673f37mr367826d6.18.1757592916337;
        Thu, 11 Sep 2025 05:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaS5hb658YOvULqbl+MwDx8ZfHggQ7H5w2l6Z+qTVeR5//f0vC8RYh8k3Hi2nLpn+vGPE7Qw==
X-Received: by 2002:ad4:5ca1:0:b0:766:be67:3e63 with SMTP id 6a1803df08f44-766be673f37mr366986d6.18.1757592915639;
        Thu, 11 Sep 2025 05:15:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1c6ca914sm2605981fa.67.2025.09.11.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:15:13 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:15:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wenmeng Liu <quic_wenmliu@qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, vladimir.zapolskiy@linaro.org,
        todor.too@gmail.com, bryan.odonoghue@linaro.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: lemans-evk-camera: Add DT
 overlay
Message-ID: <ex5oojf6lqti45joyjxpyi2ev4mjcitw4lz6cszu6lustrby4j@zzigwnu4pbxo>
References: <20250911-camss_rb8-v5-0-c078e4e22d91@oss.qualcomm.com>
 <20250911-camss_rb8-v5-3-c078e4e22d91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-camss_rb8-v5-3-c078e4e22d91@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: oTMayM0A-zcDc_rYRWmWsQsI8Z0TC3w3
X-Proofpoint-GUID: oTMayM0A-zcDc_rYRWmWsQsI8Z0TC3w3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX7W5/mxx64Nr9
 9g+AWx4I/1FM6T04s/U/fdyW5PdvfCnWBG8sguA7FywipXN2ybq4hnB3DzRA1p7fVscFlQvgYWJ
 pnKxVmXI8qcy3cDzDnF5Rq2BwCs5RaK/c/loEUmhDiDGWhP6hgpUCCZESV1cZqsRPq/Hx3KfNI+
 a042MBcmSKDXNcx4RZizZBLZU9fbfLEnHDx6lGo8Iw/r4j4rLke/EIkW+0kWT1YfrsoeHl/WCwe
 WPRoNHWWQtA3GsS8JUR+wFfJolNkFMvmnA2qLFl7GGo2umTN+WbeHKa/q/KUNFcWLnAeNKvpz4A
 ltTkuuomn2WKbSB8+sYrLiCL/zuUwjwBvo/UZmuMTqIztaNeVFqRqURtz623Lve5VfcFIPMIAMy
 Fdriex00
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c2bd55 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=D9gf5YVWuHi62kVfqNsA:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Thu, Sep 11, 2025 at 07:55:16PM +0800, Wenmeng Liu wrote:
> Enable IMX577 via CCI1 on LeMans EVK Core Kit.
> 
> The LeMans EVK board does not include a camera sensor
> by default, this overlay reflects the possibility of
> attaching an optional camera sensor.
> For this reason, the camera sensor configuration is
> placed in lemans-evk-camera.dtso, rather than
> modifying the base lemans-evk.dts.

So, is it the only camera configuration that we are going to support?
If not, what happens when we get the second sensor or second set of
sensors to support?

> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Wenmeng Liu <quic_wenmliu@qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile               |  4 +
>  arch/arm64/boot/dts/qcom/lemans-evk-camera.dtso | 97 +++++++++++++++++++++++++

At least the filename should mention that this is imx577.

>  2 files changed, 101 insertions(+)

-- 
With best wishes
Dmitry

