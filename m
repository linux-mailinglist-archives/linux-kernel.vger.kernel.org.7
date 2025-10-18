Return-Path: <linux-kernel+bounces-859022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A83BEC7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64FC64E46ED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526D26F2B8;
	Sat, 18 Oct 2025 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaZG2Fg0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09961E32B7
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764119; cv=none; b=bVxFEbXyrnU0g4AbZ3LWs7O8M01ypxNEMKu0bAPZlFiaAz8AkT/4dsTvJSpGnRytSadoRPHvOTjQaMRvwLs4q2TrtkAwzwkeNL4COxrQiB1/CVRcmL9Vk2+7x/trzZ4jDWs7+dvtXgp+QlQsEQlpuLI3FPFXh1DsLQBfWaRKkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764119; c=relaxed/simple;
	bh=2vwmMK7vKk+2Uqpd3qlXNXx/Ocde/9oWTYy78ZUHsnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IatdawPceyejlfcP8M5bAKqe6tBRnnGGH5yIeejH95AVXvkh25Sk10DCbeYmQ4s61OLlgVacEoIQpmjjQhtsIYHibDxA0rx4HxPdipVgQMvye+W+WVWi7QQQuOeomTStD1fUdXgDv6HvuY7OYgjtfiaxGfLkfuT5E005dBPdYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaZG2Fg0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I4ldvw022380
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YFRfKHwNm/v/YfwSW1zeQumv
	JtVkPxZgZB7VyLM7YLU=; b=BaZG2Fg0D1KFGuIgHwuLjMlJt5q3iuphyXPi8t5J
	ltXZa/KFT81qf9IiLvx/g08r7OW3KDxvkUJlTRlz7EO2YIgFAVBld2GmyjZg8FKQ
	hzWRYYdPXDVQBw6FKx2FM8lObSZHcyjgVJKiE6hdWntzN5+WPonajEsvqPY01ozx
	i7auYX9+qZcAnLHrLsVFSC80MW8fXL+mhHTZdGQ/25OPGSMLKLMCeCLl9f8RvaNk
	huAwgNL0cMa7zUMfcVdfFCBrak1o4JgksDARLODRU3XVsGt4qcWqSuxCKvS3QyB/
	40+zufNdZML9mMqfAtDQUztzg9vx0vjT7JZOYMMmF86MAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v46980wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:08:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33c6140336eso2177056a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760764116; x=1761368916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFRfKHwNm/v/YfwSW1zeQumvJtVkPxZgZB7VyLM7YLU=;
        b=H10YCpAulgfilkMs8IJXTAeudLdjzJjEkINiP9PPDxwOegouH9maZqI7oL1ZDvH87X
         Tiw/dhqMSv6yRmL/EJ4Hh+nnxKFPt6M7lxZTbKJ1og+EDn92B4d1X3TzbwkGZuwUaJVk
         9FRSCIUXI6/V/Y/rjjxQvSpey6uy7w6URbJH3GSTSRn6taCMTny0jhI3VUcTpRWn1yL+
         LLF99iBlnxughUV3qL6hI5PDmI+zz3U7XgvM1OmvDpBsYImUHaIJay3crV7Klde8YVmg
         IuNUdNL6Ge91sFlGod1DRkBjR5lBWmP7B1SByJkhhoSfXaWsmEGqvFADmAA9iBd49Lfh
         JHvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3HI8ejjgzYY1sF+cwn8mwy54DKFfHKoVfLbfo34WkZCii/OOoryM1b8xAe7HPxbL/JbDleh3wOLa9EuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHcpg6T3QY5+FVvK72WnTZ8afESse0zCoff2cCN/sQqPeLbDAh
	5mqNWg7ZI1PAfMAL1LVJ95tAr2D9hsnPMkr93AbNdAirzAYdpjYlyqL37Bsa+JwdT5wedZ/RMwg
	ANeNy5imB2QVFeudbnEffTnltQiq4onmllGhbaxtdUa4DlrnaAtg49NjgLeyBjy4CCkU=
X-Gm-Gg: ASbGncsDGKsfWjOdy/Cq9F5yVb1Xv2GhI7IxbIa+msOL2u2HcCnRsK4ell8ceF25Ubm
	vr3rslwiWeB6IZ2/wr2o0MXJ1v+BzMXqDTMfeC7LacDiZOHZ31kTkTCAZzgaJJBSz2Jh1KJhq8F
	kqa+bd8jVStkUBnDFRa+dIhAuIhiDeAHeOnW2DdArEiToVPqShftNiPS8aBD4NAnQHcHTyWeAq+
	5KKj2ZGW9rjUQISlv1SAj9/uBI3VstrcE6c1fOTsnwM0hA9vFbFZ5YQujGCX4VDyVBl/B0Z54dw
	l0Mxl5Uw2lF//4oM9cMw1s+wpDD9F2Cc946tY429miRCmN7cDS8FiEEUpCXStlfjCP0Jd1z8WtF
	ml6cTOky2RYqBCM5Nd2kEdDbzRjiPu6s93SYGoLIXAJdchw==
X-Received: by 2002:a17:90b:4f:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-33bcf93fbd3mr8844249a91.35.1760764116150;
        Fri, 17 Oct 2025 22:08:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnsOvzqMJgakJpAFi012zqe+RaSnCnO9z16vlR2YEX88fpBKQknf9LBuyAwqHvhkV7oX6kWA==
X-Received: by 2002:a17:90b:4f:b0:330:6c5a:4af4 with SMTP id 98e67ed59e1d1-33bcf93fbd3mr8844211a91.35.1760764115714;
        Fri, 17 Oct 2025 22:08:35 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5de2f933sm1263261a91.11.2025.10.17.22.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 22:08:35 -0700 (PDT)
Date: Fri, 17 Oct 2025 22:08:33 -0700
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 Kaanapali compatible
Message-ID: <aPMg0f+PaT4xscGE@hu-qianyu-lv.qualcomm.com>
References: <20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com>
 <20251015-kaanapali-pcie-upstream-v2-2-84fa7ea638a1@oss.qualcomm.com>
 <32a14a2e-f61e-422a-ae77-f60ea44581eb@kernel.org>
 <61b7d2d6-6c53-4934-a2eb-8d92b50e0405@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b7d2d6-6c53-4934-a2eb-8d92b50e0405@kernel.org>
X-Proofpoint-ORIG-GUID: BLq8T1Ts3r3EJ5X0Nv5tdYRbGuTp5yru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfXzu3N+WWY4qU0
 5Fw220WbxrTv0cfpiwQOmIbz2DFCmzkZOFp0wYAprtdHl6k25pAwAZAktYAYsSln/tA+qc3YBM4
 ao4b4sSgV7CaPYPlkfGiC5iin0FUrye80qLRSqP1LEHSlBdxHKgj7RSuMOOPb5L+Q70ByIHAfng
 5M7VgC1TcZs76tDbiJZJJOR1e/WSXnr1+m/q0QYGQC2Rv0L8EF3t7uZUrdQ7LFUlSvjD+ihtOyW
 ib+uuv+/R1CtS3L2FIcvX2Ko8OEaeV/CSRiKgf0hKylEQEisCtS1BI0JQ47pvnCIwbI51f8hsC/
 IL8V1c8RvOtHaQeoUPtoWBmP6Wadiev7lFbpN0zqRh3cDCKse6Rt7VvUeTMtuPP7hm8AWZIwIwg
 S0cIin3Fyjdj6QSDfgCJScvsOyP5OA==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f320d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BVIdy884nh2c1f4nCNkA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: BLq8T1Ts3r3EJ5X0Nv5tdYRbGuTp5yru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

On Fri, Oct 17, 2025 at 07:00:32AM +0200, Krzysztof Kozlowski wrote:
> On 17/10/2025 06:47, Krzysztof Kozlowski wrote:
> > On 15/10/2025 12:27, Qiang Yu wrote:
> >> Document compatible for the QMP PCIe PHY on Kaanapali platform.
> >>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> > 
> > 
> > Don't mix independent patches from different subsystems into one
> > patchset. You only make it difficult for the maintainers.
> > 
> > Really, really pay attention how your work should present itself to the
> > maintainers.

Ohk, I also mixed phy and controller patches for glymur, will note this.

- Qiang Yu
> > 
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
> And please adjust and rebase on top of patch below:
> 20251017045919.34599-2-krzysztof.kozlowski@linaro.org
> 
> Best regards,
> Krzysztof

