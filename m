Return-Path: <linux-kernel+bounces-860480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57ABF0382
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5703BCD02
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB942F5A26;
	Mon, 20 Oct 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IrSxl8FR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A577A2F5A07
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953022; cv=none; b=CI6pCrFTkMXySJpe7DjP8xwlJtU0c6XHI+6EVa5gaX24ZLcoQUBUVsnouwJ5SHigFzXc9M6nq2H5QU60GOAhkT+SFITUzKsm0kzwEcoa7gqYp+RkzMCqt21d5iRzCM6qiaUztAVhpKpz4uBahBo8FsNsh4yVh3crOaAgSARGMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953022; c=relaxed/simple;
	bh=YZ15euOakiZvlVBPl9ruuc+yR3Sdm19aUAPmS9fXMQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0I2wKAlIOAeGUSS6l0jPqivm1UQB+9mIsDZfX+8KuDYmtx8MpAb8hnwX1pWaAZOSiP+c2waRadu3OgpmyEnC5EugF3XLlLfvxlwF5CTO9ZaenxzEwQ3vu+ZFVoXkdKHMyM4UcQTGiWsO/zU8N4ZoQOekbD792eCtQZ8mxs96zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IrSxl8FR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNj510017049
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XYPaCZK9lFZQfJrY95apWWVB
	R1MeyMyX9uhR2ZkcXEU=; b=IrSxl8FRH6kKCdyRA043TGfqLpLDN4huo60O/Dnj
	pj04nAsif/GWB+J/5Da/R5xaMxGJsIbmC64Sw5ysoWnJbWakGqYRYOW6v9xWo1QC
	IQshtwoXPq4EvoJUf4ae0atoTQf20D3TkrHm345U3D+IphKz53M8E1U+SyWwQ9E4
	7g0rqiFe2CZ3rEl2ccn/jrq4B++22DuLiccbnvujvEi7Gixhdos9OibcfH6jw7Xy
	MAeDgLNGiZG7ciRvNeOhiomIuMlrCDOYXdoMggTGirqxloyiko5fPuDWwpX5xQOm
	Dcn8D6+ViSuoTOharcjhgM+zGVTvMAibSnI3kJLrd+KWxg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k46xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:36:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88ef355f7a3so1864135885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760953015; x=1761557815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYPaCZK9lFZQfJrY95apWWVBR1MeyMyX9uhR2ZkcXEU=;
        b=naP9t3aTSyba6KpjpDwqeGBym83MHzA+notSqVKnCEgp2Hyz4OvVpuNa62zVScIZ5B
         xFxDfNNAkTbOXOxdRqMf7N7CFlvR4B4Q94RIRNHwo27Cc5o3qN4npuFhHrCLNaHifoqb
         CFankFeLuWQG7eAml46C1daXTqbG8YGItaL+nN71JxO0CVtpv8ydhpNAHswVjXyHPd1w
         5+sPJm7DCdZpe5nJ/5Ur1x3Sgj1char+WEBfYkQw//wINPVbuzmEcsDwVvgAh7eo2WYp
         hKDd092wbeuSf1dMWsh2Qi7o4rWZQBuxbED2bp8pi2ICg5CkBLlxOUHWe6Yws7lX2S7u
         49CA==
X-Forwarded-Encrypted: i=1; AJvYcCWdemUy4C+JYUyamosuZWPtyaozXNmnrsonLUoWxLP14GLwzFNlmlBlHTVixClRN/EHofQT8E/q/jr7Gjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVz6ok2Ik45o4Z1e9UznpGGsUIsy64UMKfrcgvcCGS0ftfWtuq
	unKTmMmdhMWt+Ejq4jevmPp4g7pcToiNBTCTZf6p3prwb7EGAsIoYFoEcAxbyChSYA5Z1b9Dpbz
	ASCs17V6uTFd7S3byRK91o/M7ods+998vm/axpR+DijsmDCvRNj7tlfqIhRN+zW7WvSA=
X-Gm-Gg: ASbGncsYnXvxMwBp8zpYL2dfP0ITAokj4yU150clHxUHsptfs0B0Zz48XTgJO/LTBA/
	0JzpuvBkvz9XbbS9TNFT+/A3bQpXJkRb/euo13W0eaT1Y3Zzzv/n3eWNIwWbeM6I9mfnkilPZsF
	Ln9wwsXeYNfntTeXOUHLYpfyap3xGpSIBRnug/yTaIurvEBNfzBl7NXhl//rtGCe88/dCEG4X6D
	gxOIbQ6NyE1B91ojgE83/szFa6H4IRM8P+2sGsuuWTldvwGEfVlqoCDgYvDsYU/a6MwvMkJYxY+
	8sQUmS97Ltyq0Hzna+Kq5VbQ7TpX2GXoSqQvIu0t3+M4fLsAmjPhMi2JsEQ+3D/DBae4fc/snDu
	6tk+mblq+XbC5lY0u6AGZFbhG6/Ozsfr+Y8HKCISYBTOY0EobNZOO9p+rcR9TKJ/ReJypfAboTE
	ToKv4SnnSANdE=
X-Received: by 2002:ac8:6909:0:b0:4e8:a0bd:c198 with SMTP id d75a77b69052e-4e8a1fd529bmr135724021cf.28.1760953014512;
        Mon, 20 Oct 2025 02:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo8EW4nY48rPGkdRE2eIPwUX0Hj7L1IKDd+bQqSs9NGqsF11BVsarC6cEFEV3KWRpIJvSYUg==
X-Received: by 2002:ac8:6909:0:b0:4e8:a0bd:c198 with SMTP id d75a77b69052e-4e8a1fd529bmr135723771cf.28.1760953013983;
        Mon, 20 Oct 2025 02:36:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def288c6sm2327452e87.111.2025.10.20.02.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:36:53 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:36:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
        "Chen, Antony" <antony.chen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fedor Pchelkin <boddah8794@gmail.com>,
        Andrei Kuchynski <akuchynski@chromium.org>,
        Venkat Jayaraman <venkat.jayaraman@intel.com>,
        Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Detect and skip duplicate altmodes
 from buggy firmware
Message-ID: <66gkc32hdbzdxpnx3r56bfzt4znw6xj7m3j6363mus4nf47kf6@3f2hj5qwsb46>
References: <20251016055332.914106-1-acelan.kao@canonical.com>
 <aPX-ZxwaweJjtv3J@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPX-ZxwaweJjtv3J@kuha.fi.intel.com>
X-Proofpoint-GUID: 4cPppndfqqHysI0btQxy3AouolfRs7DP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX7dRJFb7TFu9j
 ipJGK4BBscOE0wKBDDWxUK1cbsm369ElKptTZ9NuFt/kQnHXMCwuGExcGhLMY6zMCXkhMOaUdDh
 /hdy96CIRKU3Wg/x5g55lF86DewGaLz2ZFbU9nTm72F98qpAhn3uJyNX7i0E9ZJP3xobPPaAWEo
 LnNtwsLccKEKZRGt6BFQcFB7AJcXqq8/9fAEW5IhGI/CPAQ10u2GZOckOIsa9CXaCuIiUq2d3KG
 UjNZeN3kzHsk4BjZXmH58P/3fmRzeJhNYm4a0FJ3sf8Cs1eR4K0DCZVuL5xKrIDBTg8Ia1zr6m1
 RzSfNN7Fhq+EZ3pxJUHihmSVzrXDCS/Yl/hOi1l35opKJYf+StRg85NTj+iXxd6tHi9MS4r4iCg
 pBoObtkA1syifROMjhUxb9DCPiKyJQ==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f602b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8
 a=boHE0e0CFg1F-sOyiqoA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: 4cPppndfqqHysI0btQxy3AouolfRs7DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On Mon, Oct 20, 2025 at 12:18:31PM +0300, Heikki Krogerus wrote:
> +Antony
> 
> On Thu, Oct 16, 2025 at 01:53:32PM +0800, Chia-Lin Kao (AceLan) wrote:
> > Some firmware implementations incorrectly return the same altmode
> > multiple times at different offsets when queried via UCSI_GET_ALTERNATE_MODES.
> > This causes sysfs duplicate filename errors and kernel call traces when
> > the driver attempts to register the same altmode twice:
> > 
> >   sysfs: cannot create duplicate filename '/devices/.../typec/port0/port0.0/partner'
> >   typec-thunderbolt port0-partner.1: failed to create symlinks
> >   typec-thunderbolt port0-partner.1: probe with driver typec-thunderbolt failed with error -17
> > 
> > Detect duplicate altmodes by comparing SVID and VDO before registration.
> > If a duplicate is detected, skip it and print a single clean warning
> > message instead of generating a kernel call trace:
> > 
> >   ucsi_acpi USBC000:00: con0: Firmware bug: duplicate partner altmode SVID 0x8087 at offset 1, ignoring. Please update your system firmware.
> > 
> > This makes the error handling more user-friendly while still alerting
> > users to the firmware bug.
> > 
> > The fix applies to all three recipient types: partner (SOP), port (CON),
> > and plug (SOP_P) altmodes.
> > 
> > Fixes: a79f16efcd00 ("usb: typec: ucsi: Add support for the partner USB Modes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> 
> Thank you for the patch. Before going forward with this, I would like
> to make sure that Dell is not using the GET_ALTERNATE_MODES command in
> some customised way deliberately, and that this really is a bug in the
> EC firmware.


Just to point out, we have had a similar issue with Lenovo Yoga c630,
see yoga_c630_ucsi_update_altmodes(), the EC was ignoring offset field.

> 
> After seeing the trace output when this happens, it looked to me as
> the first response to the GET_ALTERNATE_MODES fills the MID field in
> the response data structure with different SVIDs for some reason
> (maybe with all supported SVIDs)? If that's deliberate it means we
> should drop the first response, and start registering from the second
> one.
> 
> If I've understood correctly, we have people contacting Dell about
> this.
> 
> thanks,
> 
> -- 
> heikki

-- 
With best wishes
Dmitry

