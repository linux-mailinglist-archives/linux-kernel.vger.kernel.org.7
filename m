Return-Path: <linux-kernel+bounces-730900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510BEB04BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 01:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2431AA1FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB38F27C162;
	Mon, 14 Jul 2025 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Byi6Oq1m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7696F1B041A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534672; cv=none; b=R/eY+ASG465NAqoQSyzbvd7fdGPJCimq8RHbofKF4rvfIqcSzEewMJmU8vQCOWgBsXgxInU8DhXW6mLIrK1krvH+xzBCq9QZK7x9AhV2Wjut+neUbEoedSIib6jeac5QfPJRf+fWNnJZ3OpQ/v0N91rr4sPo1F1mZ6JlUczaa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534672; c=relaxed/simple;
	bh=sP4SdeIpSUchjjIZMdqRkrYx1C+VnRkR1jo5U4lQz4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oce5x2uBc75bi59n6p84OhrJP+s85mkENaYo11K8IIYyupYvHldPgwQS0SerAiBnjgAuvCXCPyfxBMFyg7gLdnQ20CEbUfkd6pH8Abi9xM68nBj4Ooc7E19UQynq9IOAK3Lr4tVSvNkCNG7oshlrjpBKX3gMIMZcykgsO4vMqcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Byi6Oq1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJppV3032088
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=lnAbRsgM5Xpw854WTnr2PpxC
	p0fWTNuQo/r6LvQOASo=; b=Byi6Oq1mlQ2Du1UBtBznaIYzQY4p8hL5pynHWdSv
	aTDe7W6x/B7tNhEqPkO5Y+VCzcSxQOtr0SuJfn7PglX+uFZMeALZiw5WrQcMh9rf
	sJ/Mc7HQOsEFmM9uIhSp5TBa7YwgWQ1Y4TrG1gWWLFFEW0WjJs/h8KGUsIHfDcD2
	49jcgELppT87gxfGxfXrNE98HiZW3Wn2N2WeWsSdypESIKNDnuxrp27nFMZzD+bx
	yU9qvwOPSfNE3+VFAsukhHo6roMkV6ATzLPh7u6HFnfVKFPkYJtaWBlZlEnxipRV
	XPQa3LJW0KKZLLpv05ITsY9TLU5AbgQXd0WQ0ZKra56mOQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufut622j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 23:11:07 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-704a8024e6aso104749806d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 16:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752534667; x=1753139467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnAbRsgM5Xpw854WTnr2PpxCp0fWTNuQo/r6LvQOASo=;
        b=VYTMeR+8drB5kdfpSxq0s4KQzJrH6Z9KIiSLRcSiKD+vMdq4HCAquY+fXUOMPTw+2+
         zihz1TJBFFXbkSbgjGwkPREn7Kqs3OF+Zn/PtghgmtzmPBc0jAJDjCQeaAsnTnJD0zkY
         Fftw7pr38G4VYTvO1cbUjRtf110E2V3up8I+3N6mkBTy+kjNPfkBr+eHyZbiwSOPZ8Xe
         sn8Lhivi+AUpceUhiVCcxr/x9BEtPOUGrnkfizepvx4UmUkmSvhsfgwOz+OCPMvqFmfM
         ZykGJdt3f1K99UhLNp19fufIrwQBuK+fM/Yt+sVU4Z2I43LWidVjA77Fs10fhC7QplES
         8lRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCJtn7p0edSd1Kn24v5hscsQEucz4AbtrsJC9d7U+ORitYdK843DatVcXbRGaxxqtHPOBdoTgcQJLhG9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KM7JzfcaJN+jbTP8fB1EyUSMsudNbZlF21mlA/lSrS8iP4XC
	yxfR1bTmUJgLEnm5lq/lykYUxnfU2I2/00eIToVRsg/N+9Pi2SGLrmpt31Kx8Ni1yEQR4j1QNN2
	D3AOVcVI5sdQ1n3gk4Fj24wKVQnw8r9JZVduhnX1iLtWPj+ujLWTjpNE0cwYLe4VXwzQ=
X-Gm-Gg: ASbGncsEQR6yannAkX6+HE6Yn9RGX0d2/XTXbPok7UOGOgb+A5xh0o6KSozzsIAZwzb
	O9HxJPhbYY2u/qKMPqEy/l8fqF/scaQMAjD8Y2qRlv/31H+EECSJsU4rW/YVNIcZDSiVxXrTX6U
	36jY6a/eK+x54Cet10rPYWHRQr2z6yuzOPE2BiVwZDMGyl7f1DLhxVIqxWvK0y/Oaso1gK4KKpk
	a2cwMwG9613NJHmBoMI9XVw234K+2RuEl+ZtWx+CabT8ClOnQhtmgItnUslgrHNbgcnHtQfLjYO
	XljpRsAHUzA5U4DZEzLLX63FUpkq1UMuYrymfPeLfv4+6DTgXTcIxs5jhDBS39McFjN4pqA5/Lr
	eR4SQEX1ql8G0ApdKUQ8HcSOsZl6A7CsEYXekzkSwnnmqH2CMUCjO
X-Received: by 2002:a05:620a:394d:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e1f16c171bmr1319841585a.8.1752534666737;
        Mon, 14 Jul 2025 16:11:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgcpRDGfh0tTeMaTiRAOLif3PtbYVlsrcAaMwHK8S/xvzLSUZaIFYJ4fcz95Qmvjsb6mBB+Q==
X-Received: by 2002:a05:620a:394d:b0:7e1:f16c:16d6 with SMTP id af79cd13be357-7e1f16c171bmr1319837885a.8.1752534666331;
        Mon, 14 Jul 2025 16:11:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b73366sm2094948e87.211.2025.07.14.16.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 16:11:04 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:11:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Andre Draszik <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v10 01/10] power: reset: reboot-mode: Add device tree
 node-based registration
Message-ID: <5zlix4hfxkz447g6e6imjlatmnf26pvunnsmfkol7mhvropq6o@k7wr6h4hyqtg>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-arm-psci-system_reset2-vendor-reboots-v10-1-b2d3b882be85@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=e7gGSbp/ c=1 sm=1 tr=0 ts=68758e8b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=SZ81-B_MNtUeYvdDzSwA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: HfClWdKNjYAasAQd2F-GyjorOl5sDGv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE2MyBTYWx0ZWRfX/cGujzspdKoG
 WilxJ3doKqdkfE2/jxX+y7fiUWiC1O6w8xzP/y6meir5k3kSo+2MXy/6FGHpbX3V9uXnR7MBily
 hki1r7rQUbTyxuxPIDcjGrTQrqJilZV/mB4wuQfrOwkDnL7Mwij0O/csTGwvMv2uj/+fuwUjRGr
 XY8cQgIzHeOto7nB+HpcsZKbUFp93Q36+1uPAQfGH9AS3OvqLAwTqXUXcLcC/uFkog85nEDaXKy
 0RdlFhDaVLQ46e1krBgRQ3IgZQGzNFRG5KMQLfhdSIiSQGvEACY63ojV83B5nH9dfs+MV8t4q3B
 XNNY0p7tokAOqIFKxARiE6KYIhMGMexObBVJF5qt8yJBrvbUcR36QRv/TvdryzljsjLEgDsQhZ4
 41UNJCt/CZRgZ7Id1iLvx1uubLqznpcBtY2uYtBcURfhAu8A2c6oq0iGfIiQxEEkqY519SBn
X-Proofpoint-ORIG-GUID: HfClWdKNjYAasAQd2F-GyjorOl5sDGv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140163

On Thu, Jul 10, 2025 at 02:45:43PM +0530, Shivendra Pratap wrote:
> The reboot-mode driver does not have a strict requirement for
> device-based registration. It primarily uses the device's of_node
> to read mode-<cmd> properties and the device pointer for logging.
> 
> Remove the dependency on struct device and introduce support for
> Device Tree (DT) node-based registration. This enables drivers
> that are not associated with a struct device to leverage the
> reboot-mode framework.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/reboot-mode.c | 23 +++++++++++++----------
>  include/linux/reboot-mode.h       |  2 +-
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
> index fba53f638da04655e756b5f8b7d2d666d1379535..61f647b23959789a313f3af0bd967abcad45fa43 100644
> --- a/drivers/power/reset/reboot-mode.c
> +++ b/drivers/power/reset/reboot-mode.c
> @@ -12,6 +12,7 @@
>  #include <linux/reboot-mode.h>
>  
>  #define PREFIX "mode-"
> +#define pr_fmt(fmt)	"reboot-mode: " fmt

This wasn't really tested. If I remember correctly, it should be defined
before the first include.

>  
>  struct mode_info {
>  	const char *mode;

-- 
With best wishes
Dmitry

