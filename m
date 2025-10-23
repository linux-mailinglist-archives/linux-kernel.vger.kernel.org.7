Return-Path: <linux-kernel+bounces-866737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D1FC00879
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1104D50518A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E672ED14B;
	Thu, 23 Oct 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y5R5Zixn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22552C21C3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215698; cv=none; b=c4BFTugSgCHB79XVQ/FKEHeEIpxjYSJHO2s6Yacmv9rwPfgA0gHQglIIJltqf3rbSNn08ktZRor6yx1iO9DZk6La4I2R3KZqvvNTqbmESNuj53jkVfMQ8q+Or5oQ1TQ+IOPyiUWI7q0D6L4PJVB+3RWXUJKSeeIbWTioHx50O60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215698; c=relaxed/simple;
	bh=s6m32btQq5Nec6+zqQXh1gsBw5LxBYImgxIYHSV8yOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mczSqWjZTXFPMq2Gwh6hDanYFMGj+j8cjXBT6pATd0Feg18OQPcfGzhoFQH9EiDG9kRh/rzCkpJY80uQuI8BF1BCZh/+zImnyNVybG5OeCz0ZfHuK3ywTmY1lnSZjiid6JZ/MBhWhWOVP/W/BtA17vahGPqcm4NTyXqNFM8CTUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y5R5Zixn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6l47t015901
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VoIh0U5rWFRvf8asZ97I/ccs
	zrVP2zU7xtB7amxNOo8=; b=Y5R5Zixn71QkTZ4xnUVDUkHKtkB8KjYsgFuxr5bJ
	Rg+SspVc7EepdVqPCr7JCKbfAc//LN5uCq/XqYs/HyMG+hPE6JnSTnG2sDBilZwo
	ITdgwY3JYJz9wDCfHRS2h70/umY3JXDEl7OVBDf5WBMq5aG5DR2d5cO+x3xbKyqu
	eTHqoq6zII+M1uByFTJJJDbY+U+2RBYFuawqvCip1oqc7esv9W3wRIOK1BqCTttu
	JE1lOpekl+cX0nYMtI1vHUYixAVwsmpMppP7nhB1I8zDz1lReJ3F2HEHMzpn2a68
	XHcSQC6oQF5pa81y7HFGVZ9mEPI4sd94PV9aQZ4Bp12WjA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsdnny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:34:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso572708b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215695; x=1761820495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VoIh0U5rWFRvf8asZ97I/ccszrVP2zU7xtB7amxNOo8=;
        b=eOtDsEqxJtwDkxyI8pquFd1psBI661sBV3L9DWDrtHJD9OzntMYO89kmgq0+L0f1C1
         FJgwz5QyPXu7sP4zO+Zi4Ny8R3a8+ut9bYlWkmY2E5Qujt26UBOd/AfxqzhS+VYftG8+
         7wlDEBGiYWHIxMrSfAf2advjVlilR71/pJbJ5fsFCco5nsRxX9jMCDtq21Pgj4SbK1+9
         4+O+OIaEjlhRD+NY2hvTD74Xj1Ni3/SXdB0Sh7sxPuiBMpBnQ9tD8SMGh6DlWBLfl7aH
         Sif7rIjsoIupNsB1LzDGv9+C0tTqSYCmZU3IADTipE2tlH2AKjmdz4fey0XCLUfTHuBD
         ecGA==
X-Forwarded-Encrypted: i=1; AJvYcCVoCxm6T5F1kb9luaeuK3ky1bC8B/3O1UVCB+FihBp7Dcpui75hBI36TBrfBGGtdsBE6zRwkFwCEiy7oLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1apg87h66HflTrCLqj4E6uTYkNPFYvaQUOTObY/09yanTuWE
	XpBwxwSacyrZ6CaDiCswGOJ96cjW57nedLvBYJgtGdI2/TjrcIBc8oy+4hE643m7mP81UKldlx+
	vmdIuZrLPH6ch/KiKEAcQOLFphpvVr/fpYc+G90DQa0A0ZpiWWBVA1K0ExdJjlMvoipE=
X-Gm-Gg: ASbGncvbEkNjL4rxncJoKdaReJABp931LI2Bos1pIBLhvHFIU2nnuHE2fM/B5rEutR2
	qPztP7t46FX8+g1OXpHQtAhJ1OLgqHilCR0JZ2ItG9JAqqgbGIFSnxdO/XYztS0dxDnVFSyWzWE
	ObmrHJs3ooYJvVwcNx4z/oC1/L/1WgJPC3u4oPPa2jmzCt/5dWCUk5P8YgraPga9lMV1pqlYXsE
	IgpXP7ZdbhThYlkd/9D/3fP3c9tf6Q0zECs0a+EumY3iCBurV+GW/aqSZkTpwdR97/STzq6oWE0
	hIcR/urpqrQhV8nXF8M9GP9DIjndsanB29SZEJ7mUegXlUXweYfUVwV68VxMW319qhPnE79KoYr
	sEnfE3tdiuHrpOY6Dkf1NRlr/I4YreaT+ctIu4oJaNbFrMSwYL58WLwFKTSap
X-Received: by 2002:a05:6a20:7344:b0:309:48d8:cf0a with SMTP id adf61e73a8af0-334a8649ed5mr32786000637.54.1761215694813;
        Thu, 23 Oct 2025 03:34:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWOBu17jg3/QWcZyY2ZYMO6Vj+q35f8jVO9OOAt2ZnpujVRNu9Uv94N4LPmWI0udppxiCUmw==
X-Received: by 2002:a05:6a20:7344:b0:309:48d8:cf0a with SMTP id adf61e73a8af0-334a8649ed5mr32785967637.54.1761215694321;
        Thu, 23 Oct 2025 03:34:54 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb2fcasm2032529b3a.58.2025.10.23.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:34:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 16:04:49 +0530
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/4] Add support to read RPMH regulator settings
Message-ID: <20251023103449.vr6yccqua5gsgck4@hu-kamalw-hyd.qualcomm.com>
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <eivl52lqeurk3bcklnoqjnnfqv3tgmkh4ehf6jchbnf3j44ads@oogqwpvkahhp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eivl52lqeurk3bcklnoqjnnfqv3tgmkh4ehf6jchbnf3j44ads@oogqwpvkahhp>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfXwoLdoSk+jv+w
 G+s7ymo5dXE8i+4ce8ReDW1lZmpOcvAowNPWFPs9gHa5lj+D4fys4aFSZILl8xKNXAksZR+9ai+
 9p40g+pYgLw6Oq/XaHMah45TO5Wex24Tcs63+kS3Hp1iDpBP/BVh1xyM7KVa1BjQRCkmgpm5SPp
 pMQ6s1/nDO+xLpqJ4gjA6lPfoxLdt2XcN79n/dfopBEGJSiwaVbQ2EPJ73yNJBFH/HhzeJByCBt
 G+X4inw2/4UyiRp3lbe2OQ3PQJlP/b654McjaA6NFCx0elHoBD9lqAAYVKKRT2Fsvd8zXIeuGeL
 4YiRU6nnMerkqqHo5whLmfalsm6reK/vxALgjxXcywFw3nR0LPeupEzOEcp1uVan3kjX+C66WI1
 X7rxN4bzMoZdoNhK4dMdEXqp65l7XQ==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68fa04cf cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vG2EPF1CwbHkBR8eMh8A:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 0BH8G45Vb6P5NBd-GL8uIfNrvbFrynqc
X-Proofpoint-ORIG-GUID: 0BH8G45Vb6P5NBd-GL8uIfNrvbFrynqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

On Wed, Oct 22, 2025 at 04:02:00PM -0500, Bjorn Andersson wrote:
> On Wed, Oct 22, 2025 at 02:38:52AM +0530, Kamal Wadhwa wrote:
> > This patch series adds a new `rpmh_read()` API to allow reading RPMH
> > addresses. Also, using this new API, enhances the RPMH regulator driver
> > get_regulator* APIs like `get_regulator_sel()`, `get_mode()` and
> > `get_status()` to allow reading voltage/mode/enable setting from H/W.
> > 
> > This is needed because current design has a limitation - regulator
> > framework can only get the cached values from the last voltage set
> > operation. Because of this right after bootup a `get_voltage_sel()`
> > from regulator framework will return -ENOTRECOVERABLE error, causing
> > regulator framework to trigger an unnecessary `set_voltage_sel()` call
> > with the `min_uV` value specified in the regulator's device tree
> > settings, which can cause issues for consumers like the display and
> > UFS that require a consistent voltage setting from the bootloader
> > state until their drivers are probed.
> > 
> > With this change regulator framework will get the regulator voltage
> > and other settings, as configured during bootloader stage, avoiding
> > unnecessary voltage adjustments and maintaining consistent power
> > settings across the transition from bootloader to kernel.
> > 
> > Besides this feature this series also fixes:-
> > - An existing issue with the BOB5 pass code value. This is needed
> >   by `get_status()`.
> > - Code format/style related errors reported by checkpatch.pl.
> > 
> > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Fixed the BOB bypass mode handling (existing issue in current driver).
> >   This was needed for `get_status()` implementation.
> > - Implemented `get_status()` callback.
> > - Callbacks for `is_enabled()` & `get_mode()` will now be used as-is
> >   ie. v1 changes reverted.
> > - Bootstapped the read values for `mode` and `status` in probe, based on
> >   comments recieved from reviewer. 
> > - Callback for `get_voltage_sel()` has been modified to handle cases
> >   where read voltage is out-of-range defined in the regulator DT settings,
> >   this is needed to ensure backward compatibilty. Regulator probes may
> >   fail otherwise for some older targets.
> > - This patch is rebased & tested on:
> >    https://lore.kernel.org/all/176070318151.57631.15443673679580823321.b4-ty@kernel.org/
> >   to avoid any merge issues.
> > - Fixed code style issues reported by checkpatch.pl script. 
> > - Link to v1: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-0-ae583d260195@oss.qualcomm.com
> > 
> > ---
> > Kamal Wadhwa (3):
> >       regulator: rpmh-regulator: Fix PMIC5 BOB bypass mode handling
> >       regulator: qcom-rpmh: Add support to read regulator settings
> >       regulators: qcom-rpmh-regulator: Fix coding style issues
> 
> These three changes all changes the same one file, but you have 3
> different subject prefixes. This is just sloppy, please follow other
> changes to this one file.

sorry will take care of this in the next version.

> 
> > 
> > Maulik Shah (1):
> >       soc: qcom: rpmh: Add support to read back resource settings
> 
> I'd like to merge this through the soc tree, please put it first in the
> series to simplify this.

Ok will do that in next series.

> 
> Regards,
> Bjorn
> 
> > 
> >  drivers/regulator/qcom-rpmh-regulator.c | 184 +++++++++++++++++++++++++++++++-
> >  drivers/soc/qcom/rpmh-rsc.c             |  13 ++-
> >  drivers/soc/qcom/rpmh.c                 |  47 +++++++-
> >  include/soc/qcom/rpmh.h                 |   5 +
> >  include/soc/qcom/tcs.h                  |   2 +
> >  5 files changed, 241 insertions(+), 10 deletions(-)
> > ---
> > base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
> > change-id: 20250623-add-rpmh-read-support-3288f83cc20a
> > 
> > Best regards,
> > -- 
> > Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > 

