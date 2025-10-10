Return-Path: <linux-kernel+bounces-848084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CDBCC789
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232874F08D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADE02ED87F;
	Fri, 10 Oct 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kGZCA6nr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB92D027F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760090921; cv=none; b=uaQQATn+xj7R5345xV6DP8zJGQ7bXBpqoJM0YwcsjGkVecVTbQZySSkY9DrVvoIeXBW6uo6jti/tWeYksrX5EAclPziJU/3hEcSRSmLnypCZBeH8hSfouHip3jy0X2hylfhSsw6aQI+2djqd4rL+sTp+rNGMyyErIIZ/bU5xfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760090921; c=relaxed/simple;
	bh=YOnQtEu7JFWMhUYj3xy66VgJf7TBh9ulmd+/dQCONcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM/eT/Z5JV6S+IJ3TYVkHRL5QA7BfXK83zznP+nkg7+TOeA2utQw27d0eeoKh3ZZmqdw9TJBPPbjC+Y+NYXuTMM90s10G5Qb0fKWCVK0jz7AnCIZBIqdz5nC3rtysTcwI1HRhZJIHvAnOYQBpTny3GK9IKll/zsJWKWvbk6R9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kGZCA6nr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6WuDC002164
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FPvDh1+4NyZCubXd1ngtnPbpp/8IVN3Nsyy2TEjNtns=; b=kGZCA6nrmJWuTDoy
	NUrRwFyWeoJ2caE0NBseoAF2mTnWDaXEDhgHLpEukSRYuLCiYlsf9bQl+YSHJO0Q
	ckUDAywT980Hk6mAiNoh12HuSzTV+5dioGf4A9v3YWXtlWzHddWOQPiR+NYKE5Ja
	6ziNzZb6zmPwB3LkSO7dY6O2aENUVDNL0xe5DpzVJYgtmDH6VB/SXjj0DVuEjDE2
	U1J/7GZ7y0ryU5HkmSi1Cih4HaRvRk/yfKDH3U9XAXGce115EaW4DgwJ6xfW5B5f
	V4r6ZaiGDrdQbPk1zWn9Ropj4CdWci4gx5S77Oe35CSQ1KueNOwgtJO5YsKEPP0i
	rwNK/g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u5yfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:08:32 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b646768eso5103983a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760090911; x=1760695711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPvDh1+4NyZCubXd1ngtnPbpp/8IVN3Nsyy2TEjNtns=;
        b=JJ5GtcN2286h5k0PJuiTa2HXe1MMUjTqlezPbSmXkudxA9sZS7iCzYI9F6sHXyZoBn
         OOOLLj1JLVZzRRk/BKIb0Vbnirp3MrD6EaLIo3IpXWcet9j4O9jtTHPuxKeHeU02TK4Y
         iRjp0YL7hARfFHsxrX3n6hGyrvtW5M9JCXwPd92sbABqc/qOH5Tzko+GnXIYxV7tI9iZ
         0H5sOB0Dk2VVdbIHX22MhjfU4eutlITIiv/3eKT75IHaxffdgDKsAAEu0IIqE3qGKs9Z
         L9vwHyln0WHm7gVSJglmgRvij2PKFoNRf9hVUwA0e6drrWTdRYDE/J/PgaH/9YsKw+dl
         0D+A==
X-Forwarded-Encrypted: i=1; AJvYcCUhJG+42rQqPNWQEA9+Rs0aCQcqw+SkdnSsdimc18rcTdkwGB3VlDOITAAVWTgzoEzbrqf8WiH5p2aHzkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzii0Sn0JyjT9JLvKf9CM5N1UNe9ORr+mRvNCc3+FqzUZihEYhS
	LWdQ2aC1wCtBTfgvN2lovFaYVE3XMOnePvdWX8aqNxktdu0x1qPrxgbmmgPwRKKxiFRpfZ1VEfJ
	gInMaPT+9LajNX/C+iprxTGaDn7+C+8G4rX4ViPGQ/ukStWWGldRu2PhX20n6voKp7FY=
X-Gm-Gg: ASbGncttn2/DB0zClerg/fa/y37CPCuJOy0Zod+9TAjfGWbHbe/DDsY+ur+yFAyUaXA
	gtGbRkMr8EwoIn6X7j0W32MU4cwErYITIexQeRtvoY34+T3LbmSFe4dPhQgFb/H9kQWDaiymbl2
	59R0bYHgL3v3qGIsqLJTUj5v+SeGMq+cFf8UA80J/SmVDT0k5z65NyfZtlUTPVEXEkIWgRNBKu6
	uLZgODxjEhbeedM6tkq3fSTAYBhDEGBLuR03GMgG4u+G5CP3B2giDxgM5doYOq2P+8t+pT9hqge
	BWrTQMQtejF2Hg1Ub5AlImPRCeHbDOSWaiKts19j11cUcXnhGXA4gdAqsKEPAm/+M1A=
X-Received: by 2002:a17:90b:4c07:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-33b51114ec4mr17421351a91.11.1760090911003;
        Fri, 10 Oct 2025 03:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6t323CK1XKUt3kCAeKmlXD3F1oo4fJpF0gTwFVa06YC+kIJzq3zfGNifAphNavHFinjSPDg==
X-Received: by 2002:a17:90b:4c07:b0:32e:a60d:93e2 with SMTP id 98e67ed59e1d1-33b51114ec4mr17421300a91.11.1760090910355;
        Fri, 10 Oct 2025 03:08:30 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d284bsm2362830a91.18.2025.10.10.03.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:08:29 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:38:23 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v4 00/12] Peripheral Image Loader support for Qualcomm
 SoCs running Linux host at EL2
Message-ID: <20251010100823.wc72fle2psf6r4wi@hu-mojha-hyd.qualcomm.com>
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <b6akgk6nymtaxqak2procz4gkq6hrj2ao2yaw3axo6yjn7ekuk@g66xx5vd3fcp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6akgk6nymtaxqak2procz4gkq6hrj2ao2yaw3axo6yjn7ekuk@g66xx5vd3fcp>
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e8db20 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=4W5d78O8fA4mGIgYuL8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: gtegN6G4nIIiFPIrdKXaX7iev6MYFWoj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3AyKENfyA9FZ
 rf+ul7VHudJ3Gt1aqPy8Z0cYPBgxoVPd57Wh/GXHgT6gv85rc9Wkt7WgMuAuGhEJBA8gzFOXKwB
 wF6Lh/d5K9ngv4ycrFeXxX0fDKVwQZXPr4r0s1z1XNHiGoP/lZZC9L4ATgfyZsTgjkT0xa6FV6U
 vnO/DxcapEaPlLaYvujGacEVx2/x1KDHoJgaaNIQ0LrgtNkv7iMQLQ553wFHvvgpDfqrKTMgUX9
 v2GD9syBbYGQLO6xzIBtZBmjk+H105trMXFKeyTqTK/5F6PrMj5JtbN6D8nGnAFfg7Y1uTivo2f
 sH2bmq8Zge+1n9IuujeizRItcfU8fytUxz4Gn058EUmov9DN/apcv5V0qk2bKX0ZSDomnEsv8Sb
 /pYzeWP/Mue8V/PcPrkKDBEDjsF1Wg==
X-Proofpoint-ORIG-GUID: gtegN6G4nIIiFPIrdKXaX7iev6MYFWoj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On Tue, Oct 07, 2025 at 02:56:13PM -0700, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 10:18:45PM +0530, Mukesh Ojha wrote:
> > A few months ago, we discussed the challenges at Linaro Connect 2025 [1] 
> > related to Secure PAS remoteproc enablement when Linux is running at EL2.
> > 
> > [1] https://resources.linaro.org/en/resource/sF8jXifdb9V1mUefdbfafa
> > 
> > Below, is the summary of the discussion.
> > 
> > Qualcomm is working to enable remote processors on the SA8775p SoC with
> > a Linux host running at EL2. In doing so, it has encountered several
> > challenges related to how the remoteproc framework is handled when Linux
> > runs at EL1.
> > 
> > One of the main challenges arises from differences in how IOMMU
> > translation is currently managed on SoCs running the Qualcomm EL2
> > hypervisor (QHEE), where IOMMU translation for any device is entirely
> > owned by the hypervisor. Additionally, the firmware for remote
> > processors does not contain a resource table, which would typically
> > include the necessary IOMMU configuration settings.
> > 
> > Qualcomm SoCs running with QHEE (EL2) have been utilizing the Peripheral
> > Authentication Service (PAS) from TrustZone (TZ) firmware to securely
> > authenticate and reset remote processors via a single SMC call,
> > _auth_and_reset_. This call is first trapped by QHEE, which then invokes
> > TZ for authentication. Once authentication is complete, the call returns
> > to QHEE, which sets up the IOMMU translation scheme for the remote
> > processors and subsequently brings them out of reset. The design of the
> > Qualcomm EL2 hypervisor dictates that the Linux host OS running at EL1
> > is not permitted to configure IOMMU translation for remote processors,
> > and only a single-stage translation is configured.
> > 
> > To make the remote processor bring-up (PAS) sequence
> > hypervisor-independent, the auth_and_reset SMC call is now handled
> > entirely by TZ. However, the issue of IOMMU configuration remains
> > unresolved, for example a scenario, when KVM host at EL2 has no
> > knowledge of the remote processors’ IOMMU settings.  This is being
> > addressed by overlaying the IOMMU properties when the SoC runs a Linux
> > host at EL2. SMC call is being provided from the TrustZone firmware to
> > retrieve the resource table for a given subsystem.
> > 
> > There are also remote processors such as those for video, camera, and
> > graphics that do not use the remoteproc framework to manage their
> > lifecycle. Instead, they rely on the Qualcomm PAS service to
> > authenticate their firmware. These processors also need to be brought
> > out of reset when Linux is running at EL2. The client drivers for these
> > processors use the MDT loader function to load and authenticate
> > firmware. Similar to the Qualcomm remoteproc PAS driver, they also need
> > to retrieve the resource table, create a shared memory bridge
> > (shmbridge), and map the resources before bringing the processors out of
> > reset.
> > 
> > It is based on next-20251007 and tested on SA8775p which is now called
> >  Lemans IOT platform and does not addresses DMA problem discussed at
> > [1] which is future scope of the series.
> > 
> 
> Could you please add a link to the modified TZ firmware for Lemans, required to
> make use this patchset?

It is not yet available in public, but I could share you internally.

> 
> - Mani
> 
> > Changes in v4: https://lore.kernel.org/lkml/20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com/
> >  - Fixed kernel robot warning/errors.
> >  - Reworded some of the commit log, code comment as per suggestion from Bryan.
> >  - Added support of gpdsp0 and gpdsp1 and disabled iris node.
> >  - Add R-b tag to some of the reviewed patches.
> >  - Rename struct qcom_scm_pas_cxt to qcom_scm_pas_context.
> > 
> > Changes in v3: https://lore.kernel.org/lkml/20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com/
> >  - Dropped video subsystem enablement for now, could add it in future
> >    or on a separate series.
> >  - Addressed most of the suggestion from Stephen and Bryan like some
> >    remoteproc code checking resource table presence or right error
> >    code propagation above the layer.
> >  - Added leman-el2 overlay file.
> >  - Added missed iommus binding which was missed last series.
> >  - Separated qcom_mdt_pas_load() patch and its usage.
> >  - Patch numbering got changed compared to last version
> > 
> > Changes in v2: https://lore.kernel.org/lkml/20241004212359.2263502-1-quic_mojha@quicinc.com/
> >  - A lot has changed from the V1 and a fresh look would be preferred.
> >  - Removed approach where device tree contain devmem resources in
> >    remoteproc node.
> >  - SHMbridge need to created for both carveout and metadata memory
> >    shared to TZ in a new way.
> >  - Now, resource table would be given by SMC call which need to mapped
> >    along with carveout before triggering _auth_and_reset_.
> >  - IOMMU properties need to be added to firmware devices tree node when Linux
> >    control IOMMU.
> > 
> > ---
> > Mukesh Ojha (12):
> >       dt-bindings: remoteproc: qcom,pas: Add iommus property
> >       firmware: qcom_scm: Rename peripheral as pas_id
> >       firmware: qcom_scm: Introduce PAS context initialization and destroy helper
> >       soc: qcom: mdtloader: Add PAS context aware qcom_mdt_pas_load() function
> >       remoteproc: pas: Replace metadata context with PAS context structure
> >       firmware: qcom_scm: Add a prep version of auth_and_reset function
> >       firmware: qcom_scm: Simplify qcom_scm_pas_init_image()
> >       firmware: qcom_scm: Add SHM bridge handling for PAS when running without QHEE
> >       firmware: qcom_scm: Add qcom_scm_pas_get_rsc_table() to get resource table
> >       remoteproc: pas: Extend parse_fw callback to fetch resources via SMC call
> >       remoteproc: qcom: pas: Enable Secure PAS support with IOMMU managed by Linux
> >       arm64: dts: qcom: Add EL2 overlay for Lemans
> > 
> >  .../bindings/remoteproc/qcom,pas-common.yaml       |   3 +
> >  arch/arm64/boot/dts/qcom/Makefile                  |   7 +-
> >  arch/arm64/boot/dts/qcom/lemans-el2.dtso           |  41 ++
> >  drivers/firmware/qcom/qcom_scm.c                   | 415 ++++++++++++++++++---
> >  drivers/firmware/qcom/qcom_scm.h                   |   1 +
> >  drivers/remoteproc/qcom_q6v5_pas.c                 | 187 ++++++++--
> >  drivers/soc/qcom/mdt_loader.c                      |  32 +-
> >  include/linux/firmware/qcom/qcom_scm.h             |  36 +-
> >  include/linux/soc/qcom/mdt_loader.h                |  16 +-
> >  9 files changed, 635 insertions(+), 103 deletions(-)
> > ---
> > base-commit: 68842969e138d9ad3e3aa2bbd65d514df1581b5c
> > change-id: 20251007-kvm_rprocv4_next-20251007-5e4ea5a978da
> > 
> > Best regards,
> > -- 
> > -Mukesh Ojha
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
-Mukesh Ojha

