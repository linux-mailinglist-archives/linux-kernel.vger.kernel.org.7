Return-Path: <linux-kernel+bounces-789976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02907B39DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC57A4E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752130FC36;
	Thu, 28 Aug 2025 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7fRh+kC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AB30E843
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756385314; cv=none; b=fvo2M2z3Qt30NzCMD32qky8ASA2qe46Agex4cHWnCxdLQq+dLo7JJfPABCmR17zMXUyIG6ZatZtj7HBAv34lzxdAux9RqWi8PgQv3Gh06ypqk/TcJ8NeeQf6SR42JOvPoVDmAgSmI4v2hOO6452OwKYI3ssLff+iB3prlJfxLwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756385314; c=relaxed/simple;
	bh=eeV/gtq8KypLeVlPryvG3QV+5gbRa2UjuJuMEtXSZCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVng4qqB/fMs2UJfxqMNgovaHWlB5YKK/icBfnzpeAAoHBQSNrJWxUAGrwxvWn/7f/bbw6kXOYmx+jSMpdMcfn9BylFuUB1PHkajkKcllz9RE/V3jA1sQrXHhaU7zu/yAZ7JgnUxW/hHJeTc8k4A0diZbPrHm/aj1qkaNL0TefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7fRh+kC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SBLTne029865
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OWSgUZDBbRRXs5XueZsg+EXB
	RZDVUC3PcZsLkywc4rM=; b=c7fRh+kC6V1+is+MMLPsca+M8pYXKhQ7fs/dQybA
	YtFh/0xzlQ56+tTa8zGzDIqTzMUhntFC2MmEpnF0eW02L4g/rmWA1Gfr6XFr51EH
	pLfKRnONraCiKonRqh0jqudYPy4joFF1b39PKTHkrX/ya1CBe7raGO0xaGZol5Kb
	Xm2fh02qOTHvE+Fr9BvUZrk6KHZNAUqTc2YEaZuf/+L4CGgezjjuoeEotebMBfYW
	LboE/narpYsG6R2fEsxzhqyVjRKtOG/uoFmVHL2tOK5Gv5puhUGh4Eb1aZkNZzkT
	Ie1X8ObIEyHDR8d7pbP15Zsx14LM94J/h8XYOv5p5gaFIA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tp5k06pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:48:32 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70dfcc589d8so4420506d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756385311; x=1756990111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWSgUZDBbRRXs5XueZsg+EXBRZDVUC3PcZsLkywc4rM=;
        b=U/HFfNJXSX6nTV2o27lh9hXR0xITVgRCE7FVurKB0mF3+1WUOvAqbAxYcKkvyx4AkI
         1PhoEng/dimeEZ1gOk07nJS5a4/yh+Hm6oth9hdvqnZ9tShFIokvUA4yft9kJgqR709z
         omkwbOKIX1p1vuApLGjwzqnlX9Jqc5XrmfTXKxmtyIr2Jb0rqK2NE81D7BDGeGFQOVgA
         mPAMg6I7+o5aVoYBpcjSGxRy8IttAPuigJIRLGZO4NrNKdZhNylwZV7VEn4oFJCzAP3Q
         r+dmYir9+amy+RtNhpMSOfjGvqQT4hfEfAEeI4MINDgaWHue4FdetCDZgIilxnhgFi7D
         r5WA==
X-Forwarded-Encrypted: i=1; AJvYcCWXshMh0sWrmDEXiN7mIjkwE46c8z9OqE4rFIwWV16j3M+i19LCrRJfEiUDlSBBhZHdZSayMfZ+IbrU324=@vger.kernel.org
X-Gm-Message-State: AOJu0YzttQL1v5Z9b1Y71UsUlDUyj8Zc5aB24Kk87R0ubl3zrC385ljf
	nvyv1lQgR5GD4CYCmYgruaHgyu/qJuhK1QcqzwgVfy57NexYhFPgxvBkQuth5Oef00QR/E8M0e2
	cnVw7YHL6W65lPVLARiAlPxF6meKRW4L2deq9OFDxRxSFqcq3sdYUdwA/m5H1f7XVXFA=
X-Gm-Gg: ASbGncvk5b9s75SiC7agtZbAFcOimht57B4U6rvUGSO25mMhVtY77F8kuFWbJtJrPTM
	9ZLmECvbeFPQKYYfs4KS8AueIi6LR7Lmfh3EGB/rjw2EKcdhKS5gqqFvpswTk/uSAIthMEpSoCR
	P4444xyqvXasrC0zeKs+lx6QwmV7Wy8wr/2Wcs4h5frqKq5DkmNSJJmeV8RmdRCP1dlbX5BsqUr
	QtPjjGIehuIrqtdCHxOZDP+LbsX2keiO8rgKYNxzwRVm6kQDrM1B7Ima7IOjQhdrPEWq+S2cDnE
	wl0P7G2JGCl9CMuJzA+Lj1VwRhE2YXbaJ21YpQkj8+nqoi2Sn3cSuLQjQ7efvxLGGCfaZEkiR/K
	Va6p6XtA9S1fULqjyF7hsuBhNB0nRQIzWv5wiv6Ira8meAOy1s6bu
X-Received: by 2002:a05:6214:21cd:b0:704:8f24:f03d with SMTP id 6a1803df08f44-70d9722c764mr136205756d6.16.1756385310737;
        Thu, 28 Aug 2025 05:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENXnZKSLcZXlBr0d0ibJP90HPFaIblcFK7Jg6EkmV9LMI3r6LN3MPNyS79lCEXAK7vPq5+UQ==
X-Received: by 2002:a05:6214:21cd:b0:704:8f24:f03d with SMTP id 6a1803df08f44-70d9722c764mr136204916d6.16.1756385309971;
        Thu, 28 Aug 2025 05:48:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e2687acsm32396121fa.32.2025.08.28.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:48:28 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:48:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v6 7/9] PCI: Add pcie_link_is_active() to determine if
 the link is active
Message-ID: <r2bhgghyunfcy5ppjcvxm746kzh7vyhsnbphlw4pj52wxtuxru@qzy7earmlnjf>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
 <20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com>
 <aLBMdeZbsplpPIsX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLBMdeZbsplpPIsX@wunner.de>
X-Authority-Analysis: v=2.4 cv=V9F90fni c=1 sm=1 tr=0 ts=68b05020 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=DLE-xEQoUa54y48t:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8
 a=i8L4npwzgB_v-bGXBacA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5NSBTYWx0ZWRfX1NoQLufNqhSp
 qrUfrxgmY0EeOu2RvxlrIt4IX3hYwkSYzOHgDBr87FxI1dgSyWYmpBWg735e+F+arVo1spMNT7p
 OBz98RpGjVhY4RikF5Qd7t1HU1P//LslPf0klGd2H89CxSXVOPniBZ+zS5xl9ZFwTMS/cGmXdJ0
 LMMZr2NtZ9z58uPx/90+c4cej9YAoErNCBqLS3lEL03O3TgWaF+B/O+6/OcYJVAh/n0KVIcExmu
 aNAu+RY16dfLY+JcaRhvxPmRMjVuez5KpNEKNmyu5XOjysQK6yIl+ZMNTOFq3kd9X+kWwNbxsCM
 hJF9stk25+kS8wHp9FwX1U0j1BSlb7cVR9opQVb5KDFs+3sNxvI8yr2YdGFUsOHAZyoJKDIafx6
 x/ikT57t
X-Proofpoint-ORIG-GUID: 1c12RFhuEc8Tgs-vpYh4Dvv4czJwXQJy
X-Proofpoint-GUID: 1c12RFhuEc8Tgs-vpYh4Dvv4czJwXQJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280095

On Thu, Aug 28, 2025 at 02:32:53PM +0200, Lukas Wunner wrote:
> On Thu, Aug 28, 2025 at 05:39:04PM +0530, Krishna Chaitanya Chundru wrote:
> > Add pcie_link_is_active() a common API to check if the PCIe link is active,
> > replacing duplicate code in multiple locations.
> > 
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> > Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> 
> I think the submitter of the patch (who will become the git commit author)
> needs to come last in the Signed-off-by chain.

Not quite... The git commit author is the author of the commit and
usually the _first_ person in the SoB list. Then the patch is being
handled by several other people which leave their SoBs. The final SoB is
usually an entry from the maintainer who applied the patch to the Git.

> 
> > +++ b/drivers/pci/hotplug/pciehp_hpc.c
> > @@ -614,8 +587,8 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
> >  	 * Synthesize it to ensure that it is acted on.
> >  	 */
> >  	down_read_nested(&ctrl->reset_lock, ctrl->depth);
> > -	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
> > -		pciehp_request(ctrl, ignored_events);
> > +	if (!pcie_link_is_active(ctrl_dev(ctrl)) || pciehp_device_replaced(ctrl))
> > +		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> >  	up_read(&ctrl->reset_lock);
> >  }
> 
> You can just use "pdev" instead of "ctrl_dev(ctrl)" as argument to
> pcie_link_is_active() to shorten the line.
> 
> With that addressed,
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

-- 
With best wishes
Dmitry

