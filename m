Return-Path: <linux-kernel+bounces-747784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA672B13843
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746023BBEC3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D98A22173F;
	Mon, 28 Jul 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DVDp0PqB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78983267B89
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695866; cv=none; b=Hw2C9WxTGRdO8+DCV9xbAKNPQ2hUM1Va13qLvdDNpNs9zMTredMh6DmQjPD5hA4UdXOMDsDW8IcUAKeJnwJ+lc+dOgqrTNo4T6dlEA/NVRqMG71yXa5+7NWZoEro2sNAe16uk+5gtX/BLyQZcoEWlcuNcMsT6acgucTNtp9gzvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695866; c=relaxed/simple;
	bh=x7T+LcXKIjMmy7Hhqz7r27F76rxlsf9DlWoE8pE2OAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCrqW2hcMkXsHdn5Cru3RpfivJEXEWmqPhp5Uo0z++UJqualxoS0Te91jIxML2oAdECIB6z5QUOxqn0Ij48lVwm/SiuRrJ/wZlWu42xbaEFoEiEc1Nwp0FWXaEJBlLkyLC88wpp+887ZgFa/tGNm/caa8zeIJxI1T7318DLgjKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DVDp0PqB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rr9U025512
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UOxjWi9b8eIAm2p2pRQ1nK3w
	CINCr+bSXTxNl04Iwns=; b=DVDp0PqBgLD+NF8qmIq9Qt29gBEp5VDIQCAjQkSf
	3npSFDhlHpICA5usCGoY5cfH9tM6JZAJKFp5NIZ+SX40YcKCBJx+RKv/7s0WBHQO
	2wm4egiX4/zdb3BsGuONb9o+82nOU4Y4lu3KDXkUuGRVZpxaNn9Gje7BPIfahr1j
	RS3K7QyhnL7MGGnWSPZs2zKd/XsyQ/lx8JBDYj88GUgwDlDH7wojIPM0aOR6Mgou
	O/LEu0laj17/H+dRJf59W+061sSkUd63Xwicjokp0PDYJ2R0w3V9TUhL73UpjJsD
	ox8/4YeovcrXExrxvfE2fS5nBkhQOwTDcnA3SLM/o4UlOQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytv7ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:44:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70743a15d33so19465136d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695863; x=1754300663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOxjWi9b8eIAm2p2pRQ1nK3wCINCr+bSXTxNl04Iwns=;
        b=YAMsRyNURGAWa9UHqfMmXxcg5ltIkCQKDrQpIjwwFLkNbJqPOs7w7ZVTyATbUGoZN8
         OQ+NK7gz97DhTW+wQ2obt/HkPtnIOrwFVIO7L5/mMKE46FDoJVhSceUn4tbWaoWGNdTe
         3gumkh7/LrOhJawo56++ZHmMrjNJi3e0gdwxN7q94+7hbJTykD2eG/TJKA34qx7qUSjD
         clEeh1JZdToari6Ksp1LX8qXkHUEJGJh1ZJKbHE7hxdctw2IbiT4yDRJAyWgb2YJYvvW
         zutP5NyAse8mEwtaMAr2K+WuDKwQ+7yFXArNMrtKpDymD1f2GVtNBR73GIJucqYtR+9B
         td+A==
X-Forwarded-Encrypted: i=1; AJvYcCXuE17L/V36TrNIprzPyAMD8s7AE06OeJUeFDtZTWQP+x0ts4bxk/bZc0/pfhEkYKOBTujlGazvyXqitQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKob7PYvkM7hq58dCLzm/vRAdo1g2Vx2s4IHhNYDGi8ZmWUcSr
	OyhGS1AZp8A71pn2FjED+T1oFkKVM561akuPU3X4DJuZ+ydthpHOh76UdcEy2liO081tSNq/rAX
	F44AMTKpE6P28TSwVjlE3P9M2RlExxr5ToQqUiTcvUx+B3xScybM6DxTGgzxZ8gW0UuB1x0+3nC
	c=
X-Gm-Gg: ASbGnctd5+oLRWI/bEhn5ZpJPUt4yf5iCDw3/zpverYc67gub01eiN5J75iclUEe71T
	hUMlk8c+C2kgFYnatlSydDGcoP10sdOo5n87MjQCBuQbygoVfbm96XIHG6W0DtS1IgxQi+ij3UE
	ujHsEzntGXK8e4YElrgkN+Xr/wIR8WnUR6ThxVgkF86pvIZnwV4HbZwvKVW8y0SiMybSR0rZ1R5
	eEPIfirz/xvUXfu6w26cG0cvEGvCS0m2x2ANCVE+Zgbfsp/amXlJjx0YnCBFUSOiivvdKdB56rC
	qbwmy1agzaqb5CKFzRvhoT0A+FcFsGXi6VEfSQUg0A6ViPPEPBu+m/XzALi2Mm1fcI6rB9w0dk2
	hOgxr+qCGjyS2WfPadgFaVbiQP4AKFh2TtaR46E42tlmgbUZevXfp
X-Received: by 2002:a05:6214:401:b0:707:419d:2e28 with SMTP id 6a1803df08f44-707419d33aamr57187476d6.41.1753695863262;
        Mon, 28 Jul 2025 02:44:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSFwEBe/2mm24nadIjbBi00JjeMT/2cBqpF+9f5PXZDrO8IXpWYX2OiIxMU2L7zeyH96PryQ==
X-Received: by 2002:a05:6214:401:b0:707:419d:2e28 with SMTP id 6a1803df08f44-707419d33aamr57187146d6.41.1753695862738;
        Mon, 28 Jul 2025 02:44:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b63394014sm1183804e87.180.2025.07.28.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 02:44:21 -0700 (PDT)
Date: Mon, 28 Jul 2025 12:44:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Message-ID: <3gtlf5txxtioa5bvo6o467jupyoam4hjhm2mdiw5izv5vbl3tz@drndgp3tcrgo>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
 <20250727-arm-psci-system_reset2-vendor-reboots-v13-7-6b8d23315898@oss.qualcomm.com>
 <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b81aa592-a66b-457b-9f42-df4505b28508@kernel.org>
X-Proofpoint-GUID: 1hhCgDsa0W4XVI71xnFGjrYBqqySyy4h
X-Proofpoint-ORIG-GUID: 1hhCgDsa0W4XVI71xnFGjrYBqqySyy4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3MSBTYWx0ZWRfX2kZ96x/UIwDp
 Rm0vOxR+p5PT4/xEZEe5zleslmmgeQgW12tk60wzPIaQsYn/QakcQBkkALtti44x31gGLkzudQI
 WQ1iGKcASJVdulQY6cllriKnacay/V/OCYs4wUy3TX7I3pKxd9LE/OeCTT+EBglXC7XayvbeijQ
 UXQNdfKubEc9h8GaSWixuF3N34nZVsALDemOhQzDFVrQxNnNYS/9rvUr5j61FWU+33mfoChax1K
 R8gbYCHJIh6xDE+qkJ5Y0n05L41ha4+HO4Udmrx/95sVFzyeIcLFPm/U+jyo+HGYjNyP82F82Sh
 8ayG75z8fAjk01nCdIAK9scmIxdhVEvXkGx/iiw4wUDbJGu9BGRxDYCtGHOqKrKS6aBta5fEoqV
 XXHrtVahav7BcPm7E23WkBojfYA8OggPRKvwY6HRvcZk3BFqecFe7ZuFpa/dLW1drrisZO7Q
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=68874678 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=fdSrWZEoeHojn4nDOlUA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507280071

On Mon, Jul 28, 2025 at 06:53:14AM +0200, Krzysztof Kozlowski wrote:
> On 27/07/2025 18:24, Shivendra Pratap wrote:
> > +
> > +static int __init psci_init_vendor_reset(void)
> > +{
> > +	struct reboot_mode_driver *reboot;
> > +	struct device_node *np;
> > +	int ret;
> > +
> > +	np = of_find_node_by_path("/psci/reboot-mode");
> 
> 
> Why are you looking by full path, not by compatible? Is the ABI - above
> path - expressed anywhere?

PSCI node is required to have a node name of psci, it doesn't have MMIO,
so it resides in the root node and the reboot-mode is defined in the
previous patch. So, I'd assume, the path is defined.

However the question might be slightly different: why do we need a
separate initcall for reboot handling? The reasons for that need to be
documented in the commit message.

-- 
With best wishes
Dmitry

