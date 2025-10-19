Return-Path: <linux-kernel+bounces-859678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4651BEE429
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E22114E90CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 11:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1472E7637;
	Sun, 19 Oct 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lVoVWAA7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD622A1D5
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875041; cv=none; b=uNgiAJZ53z+U7GdIVN4drHYa7DH6Y57l9DYltAKiN9kU4OBy6EE24x86HJ7FtIy/X70qlsigj0EOtc4pk2gE1biSELMh3fX5m+Df2GDY/qJw4BUyd+8KxTwGthEVT5nRASr2UWnsexsN56g4qEEQ+hsLX15XMrpRLAXW5MO2K8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875041; c=relaxed/simple;
	bh=uDfMWTWeRD+ipeRnmX1KcRU97w67iC3Ok/q8BFKqbdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsZM1/wXH+oLuFGbl6RnoDjocE5BEob+wvPmhlx80MmW8mlMIGib9siosY3MB23ov4HYC4CR4iWLxZD8bVRaAcnS41q+R4AYB67uD2+JC+Z+REcVrB7lCi7qqHJeOOqaY2jPom5w6j9y/AXJdBiRWPcSVoT9L3cNYiZ/+XvKiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lVoVWAA7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JAahhC020381
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fGQ0MOLcCnQuGNFEws8tSgmj
	Y6Cq/DDB5jiuxcA7h9E=; b=lVoVWAA707Wxc31l/VYGNTxdteth2GASXjMSBSdy
	+zoc+/PCElxn2YJnsllNtvhJmh28jb33bTb9sYU2NBMcWV/rzUITNI6g+GidLXEe
	AdSNGUi5kwcSeulH2s5IHbgyN/AfR/t+9Pxrixs42WGQ7VYlbkZ7JyoqWkhCTWhB
	ZjuvIGKsAayNOthmF3gubpaan1ODBJSpQPWvb25PfXcMn5bHqZbscUvVcEvFK8ID
	jmqBEg4BtNflagzLYxhz4sjSx9ID6BDMo0xVXK83JXTj3z5D3Nezl/H2I/ohLVwM
	c1cLG2ffTJu5gLu/5Y6VPTc6KhDGxAoEw9V4CbW/exAoPg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1usafgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 11:57:18 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c1ed305b4so98062036d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 04:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875037; x=1761479837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGQ0MOLcCnQuGNFEws8tSgmjY6Cq/DDB5jiuxcA7h9E=;
        b=EQJIk7D0Vlkh5tEBekJkRQRMyOwg4676yGc6zrTXHhoS1EZ4k7HPhzxWsMsVzGcp4Q
         Ow8BlOMNsYPO4oWvC7Eg2NDNrwIB6aiQMagwl2LQwTBDYrBbB7FaNaPYyBO1h0Jf4pK1
         4sR2oXTsBtY1zSlb6nzBeelySK1p+jtmJwQg5/RlhArTqZsc8pymczrY3W4oAvncKLf7
         KnkLRTMd5FLwvaSaLnyJj+xcVElDCRLR9182tOiXX7ncB2QRBr9RXjJbS8p8T49Te7fS
         9C0wMUOxKJC8QD3iWsrgGnNb2v1HpbXDRfDWHe4UIqhwE3A6Kc1gqOCOLE4b+10MPDf/
         Ihwg==
X-Forwarded-Encrypted: i=1; AJvYcCV5z/mtyXX/JsrSN0vbNQUvNKkc8TAaXES13f4h6y4e79DfgOIWIMyWxlbWzMd/gk5+JOwk2bEvlnL+xks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMRNPL9RZo0x9V0e4MfaTfETAnP2zInrgNslEUE7dp5zEOtYQ
	hvv3SyXJBHmjaegf2I/OYYp5RHAFgN6S7W6t+Thny3/Z5W3J/Pax/WL8VdqLC84h9f+63qc69cE
	JPubAl4Ykc2o4kplrTdy/QSSuZgEOqyHh6R2micODKJFNPwQ0vTmZOgS9+4p79d5rY6I=
X-Gm-Gg: ASbGnctTQ5ggENrFJP89tb63oQjtkMNRbfWOrnZ2uXJXt9ENRLdKDyBqd6k61Ag3nNk
	qrN7SYPV+mdizORitl3ozXQmgxdGk1QXTTv9EO1UZyYPkvraMCLTFlHijxeoGsDgBPXf34EXC/g
	JmGPmWJSqCBjPqXQFDuhp2L693Gq+XU1hOJkhN0BAjOuh0ENOPMzvwWs0E1eNj/64ZI8xe7lPGe
	fIJDkxW6Hr63/Dl6XKK12zniMo1Z27XaUBB4Lt1B8aZLv21P08lt4/v1sF3dXr9n87OFF9NvtBI
	zPNOK4x+q7CZO7HghW4Q6vqXif2aW3KbbTCa/ef59rY0uBxxaHwjQ7G7uAiTUoJ9/1cms9+gXFV
	TzFvIkCp/920gyjE31ZtLxx8fPRvMvkTLBkcXgCw4fZpMHvxP1w4/ruZ0g9p/6OLxpSv1GQXWiG
	8JbpedUGC8Sz0=
X-Received: by 2002:ac8:5883:0:b0:4e8:abe4:9d38 with SMTP id d75a77b69052e-4e8abe4a39emr77390891cf.41.1760875037438;
        Sun, 19 Oct 2025 04:57:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX+YQp615nB1m9e4OBBL2rDPwe9z4DG6TaUYbaoSrZe/rJKku24BCoQyPFtL21NMa605kdaw==
X-Received: by 2002:ac8:5883:0:b0:4e8:abe4:9d38 with SMTP id d75a77b69052e-4e8abe4a39emr77390621cf.41.1760875036915;
        Sun, 19 Oct 2025 04:57:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591deeaff12sm1501803e87.34.2025.10.19.04.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 04:57:15 -0700 (PDT)
Date: Sun, 19 Oct 2025 14:57:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Taniya Das <taniya.das@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to
 y
Message-ID: <s2u4wktoi26b5yjfl52j4y53r2bgtwsryacjd22smidl4kbtsj@ahiqbwgrcpif>
References: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
 <30390038-0f90-48a4-befe-475cf88ba1fb@kernel.org>
 <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f54b76-a274-4ce2-aaa9-88ba0eb84199@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WKG8HwAZy-MQMY86RbrV_513dWJ1rnhG
X-Proofpoint-GUID: WKG8HwAZy-MQMY86RbrV_513dWJ1rnhG
X-Authority-Analysis: v=2.4 cv=XuT3+FF9 c=1 sm=1 tr=0 ts=68f4d21e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7rlisPeBpEk40MJsvS0A:9
 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNCBTYWx0ZWRfX8meAWBTN7CPE
 5UTG1iFfaxMfkeI6qAKbBHcrtxfEZAK/eUIoK6stknKnxR0PM7kpSeVmiu/7CMInVbiaXcIw1lR
 +8380guViyM70h/E9uZpb7EcxPUlmadhFnamcgha3DQXj9EGz2Y6SnkJCl0KmAcIp5eNeK7rO/I
 GKEmhgV3gif84vBT/eCUoHkw2SrCoHrmZXFFbsG7ndQ0ASsC69nfm+U9Fh/RFfi+ShesDHglw9I
 4uQfHCToSL5649Y0IPHg//eVsxAtb1jYghr2e+kUUkR/4EQ5fXu9/7aDCcVdKqenAWw/O+Ws5v9
 1fyVjjLSQ6FkFJQQz7LcxfSptUOkxa2ZWMleKgceG0mqe8ya4a8Fglm2W2kDaEjNeF+N+1AW3xN
 pRs5qdGVG7qwfArOk3CV+vXw82PP7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180014

On Fri, Oct 17, 2025 at 10:46:43AM +0530, Taniya Das wrote:
> 
> 
> On 10/17/2025 10:00 AM, Krzysztof Kozlowski wrote:
> > On 16/10/2025 20:53, Taniya Das wrote:
> >> The TCSR clock controller is required  during boot to provide the ref
> >> clocks to the UFS controller. Setting CONFIG_SM_TCSRCC_8750 to y ensures
> >> the UFS driver successfully probe and initialize the device.
> >>
> >> Without this change, the UFS subsystem fails to mount as a usable file
> >> system during boot.
> > 
> > 
> > That's not what I observed. UFS works fine, especially that it is a
> > module, so no, this is not a desired change and explanation is not only
> > insufficient but actually incorrect.
> > 
> 
> Krzysztof, on Pakala MTP we are observing the below issue and it
> requires the module of tscrcc to be loaded explicitly. This patch also
> aligns to how it is on all other targets.
> 
> /soc@0/phy@1d80000: Failed to get clk index: 2 ret: -517
> [   10.496570] ufshcd-qcom 1d84000.ufs: freq-table-hz property not specified
> [   10.503660] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
> find vdd-hba-supply regulator, assuming enabled
> [   10.514548] ufshcd-qcom 1d84000.ufs: ufshcd_populate_vreg: Unable to
> find vccq2-supply regulator, assuming enabled
> [   10.565955] platform 1d80000.phy: deferred probe pending: (reason
> unknown)
> [   10.573078] platform 1d84000.ufs: deferred probe pending:
> ufshcd-qcom: ufshcd_pltfrm_init() failed

This will also require you to set CONFIG_SCSI_UFS_QCOM=y (=m in
defconfig), CONFIG_PHY_QCOM_QMP_UFS=y (also =m in defconfig), etc. So, I
doubt that you are using defconfig as is. Please extend your
configuration in order to pick this module.

Note, defconfig is supposed to be used by multiple platforms and
multiple defice. As sych we can't enable all bootable devices. It is
expected that the users either change their configuration or use
initramfs. Only "working console" is expected to be working with the
defconfig and that's only because systemd doesn't reopen /dev/console
after probing modules. If it were, we could have moved all pinctrl,
interconnect and other similar drivers to =m in order to make the
footprint smaller for other platforms.

-- 
With best wishes
Dmitry

