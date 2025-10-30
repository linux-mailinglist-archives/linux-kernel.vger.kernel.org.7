Return-Path: <linux-kernel+bounces-877323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB052C1DDBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEFFB4E489D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2E77082F;
	Thu, 30 Oct 2025 00:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SkF5x2/r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TgGNgoal"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCB45948
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761782878; cv=none; b=DARLtgFsMdf6i3V1ObrJGlKbiSTGLgcoQGqTmJeCBzQhDlCAsgdAaTQXv9bCHegwAWvU67/at+WNFvEXzgfWOJzowXfCB2clZMVzmuyq/+xbSOA9Lbn/10dCBpc7gPbTX0p5zBVnPMyybfWvtBSBh2DTtNBWJO2NX6ni6ZehX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761782878; c=relaxed/simple;
	bh=4SGK36zFajssmUp5z75EdK9orsWAZH8YqPumzDLphis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCyiexbxr/p55lY0t78mpuVXGBzoPTIUkVXyqy1adfAME/TED5B+5a+/tF9fPFjJILpwH5eGQTV8zSVWeowsT0j8/HGUO1KgWaBQJdT4B7MY7eW8U0QO6vC5wi9xMwX6Nm+F1eCywog5lWxCKFdY9osvfKMGBAMaTjtb2f4A3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SkF5x2/r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TgGNgoal; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U046gm818057
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=X+yVsydLnIIHWGZobrur1ZEJ
	jdp8Ys9U5JrzQcVNRyo=; b=SkF5x2/rAGjr9OGmuCb1OIyJ8rwlSMDamA2dYYxn
	C/+GgCTLf63v69b6ZErBCihG1e9PGHMn4wU2sX94bWPba2ysjELX0YBNLFKjagJb
	rIgyEJbaHEF4udqAP/2XIVdtn1LQ4w8wc52yhAcfTYROIfcDd5/fuTXe9u/dr5Wd
	6ZH/HFCRIP+9YvSOonagH5cy5WbE2WoO9fZWPj0VSamQX1IwZJ8zMpFCVXpmPz5J
	ycLXFMvBSKGHCsLez4fVD+QATmeXh1/quRQ4yCdPtBUn9hdT7IwdGKVeqCNG2Aic
	JSnYNQKy32xhsxuOvIVkEgmR6XBVpL/uCd75833MaxbGOQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3mxghnsj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:07:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8910b0fb780so62896885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761782875; x=1762387675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+yVsydLnIIHWGZobrur1ZEJjdp8Ys9U5JrzQcVNRyo=;
        b=TgGNgoaleZKZQP2LI/FW1viy+Ye/+mD25gNXbEKqOoigbKCC9i4iVNfF2VwLXeicWm
         OQVi1OmqB7hdhNiwLK/+Um7ynCr3MLy7lSLWBHTsyQ+moxiAsjtDPwOxiSFYVGlEUZiL
         d1leHDR/VZoAYHvvIsgX09PZ22QAAyCuef1vZQypkHIS9m2Xd7G2Wr43luTI5XPNcwKI
         TWF2c4scYQpvg5RVUghMCBmacRTwwnYvqqM4R81T0Szxppxh74S6gGrImSfIfmk3yg/x
         g42O7SbRQBKEthruqXMIY8mr55MtWr/k6IVxavyaIBuASH+pjKQKmXYjGYR6W/hFiS03
         WKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761782875; x=1762387675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+yVsydLnIIHWGZobrur1ZEJjdp8Ys9U5JrzQcVNRyo=;
        b=D/XoJE82mvguFFQ0is85injY8H3oa53W62ntO9tP7iyzMghHvt+MFZv8i8fUImlGa0
         g61VrPPHhfJnDO03jbYtcty9ASmQ6WdyTvpI9FNuzoGHAuy5LiKiBilhSXmjk+gv0YLD
         diHDjLQwLfxA6s09Cmk2njboTWDkYRQsFTOp7brp7+HM29oMt4a12apucNiY+sgbwDXP
         gjFgh4ZZemnZAH2xZRTlamte6yWlz7fw2ePtqAEfB33cM7wa4owy1GScNuBUhKJlnWlO
         +otUrEJeF5qmu+9TQf/BRNAtc0YhHKdCQbXFgGxdOUHVcRsZ4H8D54G1VwvtLjpnnHEI
         7fvw==
X-Forwarded-Encrypted: i=1; AJvYcCUWhMaGDA9tjVuv7nKu2Kb9yPWawJbPM5RuIyuf6POTNGg+GXOl0qMtKg31+8z1U2TY/dN+8JfkcKF5dSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMickQelW+TA7rVk1ekBTlaEXxCwMkLechD9WTOvHChe/jr9d
	oN1df/u1shrUA7uMpzEbgSHaTMS0nrU+SNLe0P0pC8ojocIBLqTJZkMtB5KZAw6lJSoxXewf39F
	ORxOCmuRV3w1g8hbShrLxRdpNMc94wpmEQ6ewh63xtMoeqSzb4PgkAp91X+nHsXvObHo=
X-Gm-Gg: ASbGncvBGYKMV/nLP3FByMgqzo1ja9bkfkQIYBI21nWqo3fDTtG4/4MattwITWPLJTN
	x1WQray+oAmS705NUQqDCU+mvR3663skd0byIECHUa/d0B2WBuWvhDy7zpWAz8pbov5Xdzh3rdj
	ZdBwrrURWJreeZWek5htqBVchs1iJY3n/5h3G0b3k3xDSLly6hcjqfhzVJ1hm2KX9ZNI2i9W9lv
	8mzXlr7Z/G8Zf1I69VSvDGn9pacKp6X4mJg4OpLTnvDUlQhQSbF8jeVQ3pnGNkukB+DdymkuYb1
	JF9IWUVvC6/ZL5Yaiy2Vo6qEfWg4vF/14OyYhp/Z1NQHi9Hxfsv8J1w8MOCawAfMNGnQH72Im0b
	XOUyqmymPRk8LW1xf3DXQLWAKHXc5rL5h3lsKwKsYeldQSOcWJyjfIs5C6+tEzOjNAS3FReyfL/
	eFTRWpqs0XT54g
X-Received: by 2002:a05:620a:190a:b0:85e:24c3:a607 with SMTP id af79cd13be357-8aa2c658c8dmr184601185a.29.1761782875037;
        Wed, 29 Oct 2025 17:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpq1Z785daIgWtET+m4a3vPVtJCGVXN2ghxTcstoNKd4N7NLjFntKsQd9dRnSm1JqYmFTcFw==
X-Received: by 2002:a05:620a:190a:b0:85e:24c3:a607 with SMTP id af79cd13be357-8aa2c658c8dmr184598385a.29.1761782874559;
        Wed, 29 Oct 2025 17:07:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0d3d6dsm37248641fa.38.2025.10.29.17.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 17:07:52 -0700 (PDT)
Date: Thu, 30 Oct 2025 02:07:49 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v7 0/8] PCI: Enable Power and configure the TC9563 PCIe
 switch
Message-ID: <ocmd7hcplxd66xsy7brg66v5htagv5x34hcmq5seirnjobvkbv@3i6niot5sufo>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029232323.GA1602660@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029232323.GA1602660@bhelgaas>
X-Authority-Analysis: v=2.4 cv=AuHjHe9P c=1 sm=1 tr=0 ts=6902ac5b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hGzw-44bAAAA:8 a=YSw-D0X56moLfQO0M-gA:9
 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=HvKuF1_PTVFglORKqfwH:22
X-Proofpoint-GUID: Hqh3EBZarvddTYDrYXrBlQM2rhtEWJ1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE5NSBTYWx0ZWRfX+ga5B2Du2w9A
 E/ZrMVPVUM2ia8A3+cO1tQ+O9+ITvXYIYuFNM9fPkgM0DnZFZMX1waJb5WOhNx2R343fIqVnl+9
 /GsH3v5ZvWVPB2oSTaEsnJUHljB6aUF2hx1IH7UOqi6k6guVWbEEAPI6dKKpZAouhuZypUMdBZ+
 4TAn9gLYPOLZJ186KQyPq1dia9Ha1Z861Uil1ZNKduFj32bZGFLejC/dHRamQVmUY5T0eSoEh3D
 h5yw/NKOWw7gOtzrQEu87TJEM55ZW2Y+FEq+uW+I209kB6O3DthcN13ufVxVDamQIEitEGJ6iZi
 mX8xEHu3wyMhfSZSLJ3wIpS4yj4lVXRjfFLIVwW5/j/qYsfXcrQU/ZD7c4gVz34Zoy9hMlmr1e0
 2VRdOlZIRQ/nYYj8RaFbOU3xQPxGHw==
X-Proofpoint-ORIG-GUID: Hqh3EBZarvddTYDrYXrBlQM2rhtEWJ1T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290195

On Wed, Oct 29, 2025 at 06:23:23PM -0500, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 04:59:53PM +0530, Krishna Chaitanya Chundru wrote:
> > TC9563 is the PCIe switch which has one upstream and three downstream
> > ports. To one of the downstream ports ethernet MAC is connected as endpoint
> > device. Other two downstream ports are supposed to connect to external
> > device. One Host can connect to TC956x by upstream port.
> > 
> > TC9563 switch power is controlled by the GPIO's. After powering on
> > the switch will immediately participate in the link training. if the
> > host is also ready by that time PCIe link will established. 
> > 
> > The TC9563 needs to configured certain parameters like de-emphasis,
> > disable unused port etc before link is established.
> > 
> > As the controller starts link training before the probe of pwrctl driver,
> > the PCIe link may come up as soon as we power on the switch. Due to this
> > configuring the switch itself through i2c will not have any effect as
> > this configuration needs to done before link training. To avoid this
> > introduce two functions in pci_ops to start_link() & stop_link() which
> > will disable the link training if the PCIe link is not up yet.
> > 
> > This series depends on the https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/
> 
> What does this series apply to?  It doesn't apply cleanly to v6.18-rc1
> (the normal base for topic branches) or v6.18-rc3 or pci/next.

Juding by the base-commit in the cover letter, it is the following tree:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6

Merge tag 'v6.18-rc3-smb-server-fixes' of git://git.samba.org/ksmbd

Not that I have an idea, _why_ that tree was used, was it really used or
why there are no dependencies mentioned in the footer of the cover
letter.

> 
> I tried first applying the patches from
> https://lore.kernel.org/all/20250124101038.3871768-3-krishna.chundru@oss.qualcomm.com/,
> but those don't apply to -rc1 or -rc3 either.
> 
> Bjorn

-- 
With best wishes
Dmitry

