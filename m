Return-Path: <linux-kernel+bounces-815932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B900B56D22
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10E218997EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703E24C97;
	Mon, 15 Sep 2025 00:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pc3IGBQ2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB823CE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757894829; cv=none; b=TfcMAUC+QbuecFVMtP8/ut0qia75qfsIILBsWGyYcVU3VID5RitqxAG0bm74vAPtrfrvhRg/wwvabuchAyY6GrtXI5gAQnlbYcymXFrI+g8LwcmYXuIQ1mqcJYrdrHAkrbu0j2O5TMDxRy2fTAcLpPNsAlrMU5HOrNtzPO98LTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757894829; c=relaxed/simple;
	bh=CzHNrfktlaS/4ODUMT4RaYAOMeg6Qil5XWqJ4rs6Ovw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgBqBq4Qc6juv9sPAIlqpy7BYM2uTapG4w1jmwAkZJ+FJAUENqpnKLdILCepD+mMA6nUGjUcFlEA+8NRU9fQIRtSdGBPl5xz7xUigAGoMODvypXu5p2QdpGypNi01kMMLJ7qCVPjGHz7kxaI3Rz/kFR/bquG66MaxRwg701fD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pc3IGBQ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58EMEq5f010953
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Mh5sherNX0Q7001jFm5e3R/a
	R9MYR1zMB5/R6VlH5zY=; b=pc3IGBQ2F+XOHk6PRzPPKJgl/CGbDJNc9BPjW5mq
	uWN5lngUkmgaMjIdxdaFP95j5HFm5cVAKvmgd76MGHTJH62XkHGKKrrsAmWOqyk2
	q6KYuOingaxaPdb/VrAaac4/klQmDkUODhkTfcbronq/Zp60Y9rqWf6GzhJcjNcO
	LIDd2uHkCRPqRGg/chmBi+2pdEw3TrppmTAl6d6ph5MWJJnwNVpH8SjFYROmGk6N
	DwXvlgk7r+iWpTKfcx4XLOwNuLxKJEf4x+OI8DMnEnbu/dXJn8+w3KgVlt7IrmVO
	aPu70eumA8CQNPbUrQPn3lPX5RVkq18JFCOwMyC1xQx1Ag==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yjv31nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:07:04 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5e303fe1cso81502081cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757894823; x=1758499623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh5sherNX0Q7001jFm5e3R/aR9MYR1zMB5/R6VlH5zY=;
        b=SG29vK1AELve2mnDYKw/0P/1RXtfghTZkGlBzTLgHhGi6ISnAIZ90EEdKzqMhFbEPx
         HjU6siqGqQrgJRzRaXzuIj6t+//NFZOovgPJSvxY3WEK0q3A8wXOPBLxGBH1p4lcYrpS
         Z+Rq98Swxym5PVzSFnfJggYsPXdbAjVBuBRbbof8Zm5lHphzGBBqH26dmaDtwGT9NSpD
         p4iGQkZX0KCbz5gfgwNFpV1+nIdbeWw+YLf9zyxt89dxhej1yRyHNL+NRN9/OldDo0ma
         Th4k/yHWH/FKHIytxXZ+enAw/r7jRx6ptNSrW3WOPXLMZyKz0eiFrvqH7WjPHgKYSWLi
         eoFg==
X-Forwarded-Encrypted: i=1; AJvYcCWYM1DGGznpT5nvjL/CxYwRYUI9jItJamVhLHCMP8uOJhE8zVoUDA7EUvcGt07DTQ+uYZowSs+WLdFx6u4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Bkld0K1p+PlSZpqP+aCpSi9OPqjUaG7MzeoC/MbzDLawLft5
	NVZek+4Ct7cCgvb2Ot1RxK8q8pkMG2WmeEV0DKlQ44dBtUFkCVLOEtYl6tjGQS6EF+g2UdObO4i
	S4tbDI52kZhuhL0W4Y4jFBzDcrPogh49elgxIE5m4MOB464BmiUn44BIeNIWj46rH68A=
X-Gm-Gg: ASbGncs5mcTOuflaMG/Aw9NzBckaTEAuGIx1dKtRjwJXd+6lC1SQRNVTQRwUFmIIvGc
	KZl/eIGSIdDW2DRxu8+a9urjtNZS5v7yEoC1+8tnRoC9+Ie3new7PW7FJVAvR+rixmhFJtEk7aK
	u2qQVM+ovcsZR30Cee27oi5iky9kysqURspzbRoZuVaqPWV7XFia6MMg24JkAWpfuwygI+e4Eq2
	35cAgFH5HbQNtyFWG0r89Hv7c2q8Lc0+TrYiEmNam+M4286fg7R4uZjUmiOoMM+oxhoD4oSoKza
	dstKrYAm5BcrMObrge6LzoHGnFV2IKUncNoCDj/Jb7PNXc6OTQVSbN5Oid9N31X0dTgDNlodUPB
	73GyK3kxwG9hpzCPAUsWxLuvv9IOgscKT+VkmoUNoLRgrNg7I9B9s
X-Received: by 2002:a05:622a:4cf:b0:4b3:4c51:6434 with SMTP id d75a77b69052e-4b77cfded57mr125964601cf.20.1757894822531;
        Sun, 14 Sep 2025 17:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsW542Cjhva67Azk2KlVPzEQFGIEU+WTmFXy6f0ObUGTCHrlb+05YBOXy7VDLH+4P8nX23BA==
X-Received: by 2002:a05:622a:4cf:b0:4b3:4c51:6434 with SMTP id d75a77b69052e-4b77cfded57mr125964301cf.20.1757894822072;
        Sun, 14 Sep 2025 17:07:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63ff4sm3220354e87.84.2025.09.14.17.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 17:07:01 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:06:58 +0300
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
Subject: Re: [PATCH 4/6] ARM: dts: qcom: msm8960: add I2C nodes for gsbi1 and
 gsbi8
Message-ID: <kiawbx7uoz4bs3esiyraeess6vva5f4fwwqh25xrgae6j35gn5@4eoereuoumhb>
References: <20250915-msm8960-reorder-v1-0-84cadcd7c6e3@smankusors.com>
 <20250915-msm8960-reorder-v1-4-84cadcd7c6e3@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915-msm8960-reorder-v1-4-84cadcd7c6e3@smankusors.com>
X-Authority-Analysis: v=2.4 cv=HcoUTjE8 c=1 sm=1 tr=0 ts=68c758a8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=wxLWbCv9AAAA:8 a=EUspDBNiAAAA:8
 a=t1JXzLs-izEPKbqAoeQA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-ORIG-GUID: pD9XMVnpSavt48MKihEDkewnl6Y5ikw0
X-Proofpoint-GUID: pD9XMVnpSavt48MKihEDkewnl6Y5ikw0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxNyBTYWx0ZWRfX0r3ncgIK5xMi
 Ut9eVHWVcQy684fEqAb+yEJkSef2kxmkIHtIoqG9nRjzn6Trz8/YVWr6GGzZ/2cNddip9yruD6n
 xRDyJ8UfhdqNtamD9/6m0vAt8lXDTgCqljwiUAfM6hdaTotFlNYt9uh3ht+WW7/tfaMPnv8hBO+
 i2syUKbm6GYOdvJvobI3Pv2b/CRPWedSk1iFHiEq2Su7wf/LrMWe46nC6N0LVjRwz2ISPwjC/ji
 IPCafLPpq4OBqGyvxUs+M42RdntrEsnywkh2AVajxiPtBVepFDatT9lYh3ar8zvL+cUGpLb/60d
 MsMp8BKV0iN5fWYS5Js4bRIP9/35U+93IGKYwV9GQT3zYvz9R6MLbAw8iALxlhUyegUFpzG1Pmc
 kXw8mNbm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130017

On Sun, Sep 14, 2025 at 06:34:55PM +0000, Antony Kurniawan Soemardi wrote:
> These are present on msm8960 and are required for devices such as the
> Casio G'zOne, which has NFC wired to gsbi1 and audio amplifier wired to
> gsbi8.
> 
> The nodes are added disabled by default.
> 
> Co-developed-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Shinjo Park <peremen@gmail.com>
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8960.dtsi | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

