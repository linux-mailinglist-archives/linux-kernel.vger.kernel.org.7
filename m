Return-Path: <linux-kernel+bounces-826647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B1B8F09A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4528F4E023D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84751F4E4F;
	Mon, 22 Sep 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K1ER9r8Y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5E722DA08;
	Mon, 22 Sep 2025 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519876; cv=none; b=vDkrS1q1Ai5SU5/hvW5nzs9a28E6ZvsSMgXqqhrhDsw2pkWEh+IBSak2qhbqdj+l6YCpVtbQTKnpDHQkDpdxxR94t9ubywtk8gRMEC6xCm4sDej5ypOP8vr5HvFnHEw8CSblAhMtrp6SgoARuKmh8fsaLdyX8P2xxNIyxZJPSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519876; c=relaxed/simple;
	bh=+wdBvFncN66YpFBetbmAcr+kqGmkLQW3T1NqA9oUx5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwAO1wBmGLXS4RFNGT8aXCzbADwdGNoo4c8gtptDWW25lpReOGauRulGpOO7oVwn4XmsQ9rOQQVKFfH2HL1Ldmu+femWx4FP11ONQMB9TglmjrGtwEifSO/0a6cmIHGYJb5VxWh92+w4OmyHB+s6E/6v/H71wG/2dB5eoEhzNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K1ER9r8Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LLScAe010687;
	Mon, 22 Sep 2025 05:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QbQ8d6
	ZFPfmGcu+ol74QLLCNjXaKPp7g57kM44CXFvM=; b=K1ER9r8YnEI0hLdOqI3bNO
	Sdgwj7AUyWeQGukSort8CZktqsCUXsAvxdipfwelXxUqDna01YJRpftfJDif2BvY
	Su2SgJdBPrg/CJYatsrwcKVWcGorelpYhw+h22juD1epRcL13JwaiNlxEbSUrG2T
	aiNLj7/pIfSSDtz6k89/Rc9wctOkWaY9ApOilti7/v4QIzimsYNvcMmqigeiQ+cV
	6pV/E23ivyd0EIDIccW7qIOVyHo2ooBU+p360LgYU1lEfPIJiPt32EsmoAq0YNit
	vFTZQO6N7ZYPrHNvqzQwfNo1f/7KLXRgYOIKkOCGDaCWiFChM2SF/5vtEp2Ty5Lg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbgu29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58M5eJcW021833;
	Mon, 22 Sep 2025 05:43:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbgu26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58M5Risj013605;
	Mon, 22 Sep 2025 05:43:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tj4cjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 05:43:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58M5hk3A30540206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 05:43:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781B320043;
	Mon, 22 Sep 2025 05:43:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E389620040;
	Mon, 22 Sep 2025 05:43:43 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.82.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 05:43:43 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Aditya Bodkhe <adityab1@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
Date: Mon, 22 Sep 2025 11:13:42 +0530
Message-ID: <175851974398.1538174.12018336075108815728.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250916044035.29033-1-adityab1@linux.ibm.com>
References: <20250916044035.29033-1-adityab1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: raCoTZ1iYBpM5o1pOW0jmdzaXwbZekDA
X-Proofpoint-GUID: f-UDlgEkKy2mO7OR_gMWkHxRBlYjWr57
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d0e217 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=rfBYtj7KzXE0Fmh1LW4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX1aCLHuIUn9Cl
 jCZO3jxQaH/syOSf58PZ6f0wRdtAnqekn0pB9yflwhmOhNCbf7kT4ZlOpLkh3hg5RXdFf2cLiWm
 Tdzj61jdH+YvYttNthaR3Yjv7ujT/La8dOqSzSy1lnLtMdC1GwEaV9D5P+3AsYUHEb4NYcmCXHQ
 FyMdmKK1b52DWgTJL+lMUSjYsnhT+2sVC8EKGy/BD30oknSt9gh7KsuH+teu7eJrO3vgf8PzfNJ
 CGkvf2TGlLLnbzy7+Fi9pahQWuexvhlnJ761yWxTIQN2iDkyZWh/rHks2FrhgIdVV/jVIiJq7Rl
 Meo3CinPzUZb4xyp8+3Hg9zcUQip2H0pmQn/Cfk7ztB9Akmvw46UY9qEieldH7VzAjZqc8qwIzj
 ZVHrEKUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

On Tue, 16 Sep 2025 10:10:34 +0530, Aditya Bodkhe wrote:
> commit a1be9ccc57f0 ("function_graph: Support recording and printing the
> return value of function") introduced support for function graph return
> value tracing.
> 
> Additionally, commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with
> ftrace_regs") further refactored and optimized the implementation,
> making `struct fgraph_ret_regs` unnecessary.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/ftrace: support CONFIG_FUNCTION_GRAPH_RETVAL
      https://git.kernel.org/powerpc/c/d733f18a6da6fb719450d5122162556d785ed580
[2/2] powerpc/fprobe: fix updated fprobe for function-graph tracer
      https://git.kernel.org/powerpc/c/7cec88bfdd33434d62d4d5ba664127fa175b50e7

Thanks

