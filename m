Return-Path: <linux-kernel+bounces-748275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A5BB13EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC914E3ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1208273D9F;
	Mon, 28 Jul 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pb4XQpKe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6122272E55
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717042; cv=none; b=KEv2GWIrfRgd0i6v014jt6rR4kDXZ+EDLIwhU2Ip9Ag0arZ6RRoj/IL7YnY1PqYhq5rOznX//d03RvqHsIGw29DrKLEWD3WQO2XZWuoV/J2eN0PGaTWhmE0krjUthXljCiTV3MdBLyS5mHar1wshymTvtlKL39XlA8i/H3ktCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717042; c=relaxed/simple;
	bh=jre8QM0W1aod+snE4SIPjcwGuvGXMCnAU3WPP0zFovo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUL7coTQdcMCy9qdDwGD6RGZwTcMIuIMygnZxdLbTPBj3t+uUn75qdM47aBUuGYk3MW6x6GLaPe0zHq+pG1cLhAPbSjC8awztlx/WCWN9U12P9L9DbyTJJ1eGp46knmhU5l5wUT8dLf1oKwIlgUlp3yEZjJItT/OvDXiwRCyfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pb4XQpKe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlOoQ023593
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SAVDu2CUO0GFbPnrkds994cc
	7fuJHUyL9s9URha4+gw=; b=Pb4XQpKeNIn4JwZo9QYgwyN8jt5WS7p27L9R+3Lv
	sBtDiOW2Yj3IWvwog0YlaLitsHCvtEERjgFKUEmhcM2VYrShSsoXJxVs9Lyp/qNn
	IQxNwn/xAdqBPLO8GpxMqliRmo/jkULpDDIACh9KEQSiD7oazMMV6NifxQTvnojz
	/PKWqbcLiZlWdNJKuyZQQv48DZQ/PpVLP4c9cE3NGZcSSU/F1JL59EoW0p26G0ap
	YCblv3wCsjP5zLhMFG1F0wPZfL/xiGBIXNxICmXZ0zayCQwUFW25an/BgEpyae56
	CTXQILbgTgVRaiCSFpyVsGFpnU+2t26xuAejBlnG8B20CA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qn0g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:37:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073b4fb53eso24844986d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717038; x=1754321838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAVDu2CUO0GFbPnrkds994cc7fuJHUyL9s9URha4+gw=;
        b=WClvMnxJzh9Hwo+K7D72dPNi8eNL2VSrfE+d58Fe9UGVf2yjoHIr68Qso4Oc1pAwHn
         8k8Lx3GbSxyesROympjjnpLBfkNDbS989W8L6J51svHmyvheYzhLo1cjhA8UGSFm9VI5
         Z3FMGIcNLeIhw/bI4hkI9CtuR1zGM4QhSvLLTMVoKvYeXXB3pUj9V5wsABPquf3ncBBs
         2U/41aydjSbLRGM5F4RKh5JXEaWBkURgdLCsgECiuBb0sWYqPf11UrkdLbDiaf2s3R4Q
         Jzhr8qVY3NugqqYf24QqnfVImUGPfkAEP8x5qWfENIf069ZiZFkGoaGQV6htc7Tj9Iea
         oWxg==
X-Forwarded-Encrypted: i=1; AJvYcCWgBHpUXHCBsLY7vUPhJkDPdZHWpn/xV08sFDZyIR7x+XxcGLPZ4S6SfauSIR+MOh6S5xY6qHYbxYF//2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSegU5cp4ks8x9gy19ejxu5MqrvrJiCN9AB6yH4O1AMGZnljw
	ySwp1iers0qG4Vy9M7O4hPAJ0JVaQ3/XQ0DoBL2BcGH4FwOPytOaVjkDPjtqzQqDsczPin83kgk
	eW/oGeRurKb7fY1lmwLd06tCPhXPaSGK3H/0q2wxrZkPSCNgTohzTmORNv/cFKIqOBrg=
X-Gm-Gg: ASbGncuZpj3x/MJwr8hwKzuGVz3RZy6BrtWw9BATTMvwA75S/UYpVKaYV6aWD8FeaQa
	uiibLF/tikP37kH3e6doQ9A6RUrHv2hYAGxQVbTIFdzCE5tEKP3ZoF68PTZ2ty5wdaclxwD+ijw
	nU2bJTN+FUlEGx7Wa3MjZKfPkT2RH/aWMau/2knly9kIFZ1VpXjVE5Gd/7NOiJ6YhZzJ9MMb7j+
	vAoPKhLUv61BM8jHIohdjEo2GsNMCVvetAYhR3E9wnMzJ9U7huFyb58m6IYZr5Ay3HsRKQnTJXh
	j3PbjhN/q1CX4jhXCckIdBCWFqGjZ6bQrVzVWlm8d3KKda315GXq6cCaXH+b/qIcbntspv8jgYA
	xgFUEBEpkDrePWYTGTe//pBPKcBO6dWVTVgC61KYPqdz/VVN8rxFE
X-Received: by 2002:a05:6214:768:b0:707:4aa0:30b with SMTP id 6a1803df08f44-7074aa00690mr43615886d6.42.1753717038045;
        Mon, 28 Jul 2025 08:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BWhOHv+VJeM/lHL4P6XKb8rnJZC+uPnNDX7+Ov1b4lYzmfrK08Z/Q+Kn87HxQgfASQl2vQ==
X-Received: by 2002:a05:6214:768:b0:707:4aa0:30b with SMTP id 6a1803df08f44-7074aa00690mr43615016d6.42.1753717037278;
        Mon, 28 Jul 2025 08:37:17 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b73f140fasm21169e87.113.2025.07.28.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:37:15 -0700 (PDT)
Date: Mon, 28 Jul 2025 18:37:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v13 07/10] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <mfxfi3blmebuua4rwdppbaiyiyqh7apkh4xxlwqm6t2ishjqfa@i26nvsduy5wm>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
 <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
 <bcef34c3-98b4-454c-8138-c73729e17081@kernel.org>
 <5e2caeb7-360a-4590-a36f-ff1ec4c20d31@oss.qualcomm.com>
 <2a39c0ab-edd4-402c-95a0-a6286f03102a@kernel.org>
 <20250728-exotic-armadillo-of-upgrade-fbebc1@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728-exotic-armadillo-of-upgrade-fbebc1@sudeepholla>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwOSBTYWx0ZWRfX5o+LSlO8bx2+
 K07VyX9g2SXMLSTlEAhAABgE32k7Xd6rtM3A0pwf9hpMWa3qo1JKNg3oJIUXJxNvjtCpc1yrnAm
 liNZuGyuCRJVDm0m8htUG5OqS/4JQc9h3w+oGJN81DG4fgdymtqDYy3X+AGDaw6YR00tT9JNMks
 zhdrs6DiuxwC8nkUrRPegu0V2pTJgssjBqTQvIvsQo2VOB2Pb+cMZTPelXKomfJi56/NiOTRP/n
 0WcHes5CAZGDl+lud7/3KD6YAkF+uoFHWmcJLRkuS/1GecujclKxWcvdnic0zSLJWBUSo4RAZS0
 OwD9TQ2rIDZ6v0ziusR7F0D83Ymoy3dU6JaOVR6cEYEv+hhHb8VUSbIP7h+zEiotJ6/wsC3L4G9
 ChSIZeLHQRlIC2gJnH6e2H0exWikVfYRu6TUUZkYAVJD5g67e+Ofo7fVSlL1Pz5k/9ltH8DA
X-Proofpoint-ORIG-GUID: K-ENGclnnkdRvCMHbcOsQi6cBaXnxYzD
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6887992f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=-6XmDZydnhzWYMP6MwkA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: K-ENGclnnkdRvCMHbcOsQi6cBaXnxYzD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=678 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280109

On Mon, Jul 28, 2025 at 02:23:17PM +0100, Sudeep Holla wrote:
> On Mon, Jul 28, 2025 at 02:23:14PM +0200, Krzysztof Kozlowski wrote:
> > On 28/07/2025 14:03, Dmitry Baryshkov wrote:
> > >>
> > >>> and the reboot-mode is defined in the
> > >>> previous patch. So, I'd assume, the path is defined.
> > >>
> > >> As I said, path is not. only psci/reboot-mode is.
> > > 
> > > Do we have an _actual_ use case where PSCI node is not at at root node? 
> > 
> > Yes, many cases, because it belongs as well to firmware node.
> > 
> 
> +1, I was about to make similar comment. /psci predates the formal push
> to put all firmware related nodes under /firmware, so /firmware/psci is
> equally possible path and should be recommended one so that all such
> firmware related nodes are contained under /firmware.

Ack, thanks for the explanation.

-- 
With best wishes
Dmitry

