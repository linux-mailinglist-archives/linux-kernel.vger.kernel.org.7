Return-Path: <linux-kernel+bounces-732350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA70B0657E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F02D1AA484C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D4291C25;
	Tue, 15 Jul 2025 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aG1/hpIH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1E2918F1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752602527; cv=none; b=hlVxToPI2xMPUtImRxolWV0/Aw3rPqvU1mbZwtmPbeu2QPlb1KDt2awFzV/bvDj/CayqqC4KiMkTVtTyfd3oMdScVEy6Pd5uDMPvWDojoocKDHTQxaZZCG9HedrjtytI57EUek1TKZKpsBxxx1VyyjHpRLepgy0wq9ma+iU4Hew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752602527; c=relaxed/simple;
	bh=cD6ekhB8hSQ7tGjkPWrprv+pbrgyURdbpYaoR+lgdFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvnvOgsLjZU/HH1gy68bpKqMCP70N0+TUgBCdzgsSGkA8yauY1LV6YNwZe2cqZGTRYZqYlPW4GVQhS5jL9i7c46CC1Br/I+iYJAJl+v9JdxdH/tJ/hmXJHCMsl0jQYnh3q+bpI8O4Q9X6N8waiGIf/z7GlFHa2v7/EGjU9P3uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aG1/hpIH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDSkl008209
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=K6mo67nJeO4KAf1LYP8QekR3
	w5EhbEb1kSpHda5Bk7c=; b=aG1/hpIHM1mntA5L//114BHhpyVaS3JbUCp+36cd
	SsGhKa9mxdsKCu+3KVr/jzVO3fcTKciUxI44u/mRkgTXO7fzig7N8K4SKeHvIqs/
	TK8VXaRXlGFS3eXm9lN+RbnFJ3AHxSzNKtd3jEP6h2FEOwELbe1ymUPwWvLmmcIU
	xbsVUHIT5jqnlBubMiB0aOzjrCgwzdYxXLb/S/u8cpL5YcahYw0aJJWRLkGjsH7d
	tofwBo3X+2mw2qfEULUV94QY7/zHHZtuZuVJODwRnTMkY/UJvlfF9YQtyEatk163
	vaUHgiWa+ojyjUuF3n4JPZ5lyxmhbWLRtlgcLbTAZY0ESQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5sc4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:02:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234a102faa3so44632445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752602524; x=1753207324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6mo67nJeO4KAf1LYP8QekR3w5EhbEb1kSpHda5Bk7c=;
        b=RDoHDU4w3DVbkGpOXC10Py0iY5ikQDKZoMlG4ZzYUEC+G9W6cfcajCfxF7cqsDynOd
         fKFlAf/45KEc27roTywNdDz1HsrQe4dokQXudmA0s8ce7NOul1QBv939Un+7oFacuTNb
         PshzhghmXAe8VLkawHFTP2rkD8zDqNgsODr1dvEwFZisz3zsFcYe8tHFMBnTAUCsaO+s
         Aq4IwehD30wG0b+cSmfhqqM5wn4loP3UsxKPKqiTzTxDE/JqVuwLqykM9pVDtyMB05SJ
         5Pwj2c3vnAsCWxcha/tcvv2zTx7Se2x4mfIvwib4B9ciVE5E6fjb3ntFMgWtIpRBbCpH
         D7zg==
X-Forwarded-Encrypted: i=1; AJvYcCX7E15P7LdbKS8G3c7qwhsSrJ0DEcwihSQdXkST2YA9YqmHCMKFxUjoXh648PSe9RMOjy3SZKUabP3VyYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbd08SlT2uWojLHFRlihp9tsyHYbcoH3LN5ERa8eiUaEklD/H
	0VfrGDWRveWHax2OLtfpIUxuZvezsfQPr9VdKe5AQHWxHYWcNykLV90Dcox31MvKRbAxvpgy3J+
	f7Ee0el7fqRtXm9Cx3MyzCSvX0Vnup+L91UBPJY37+mPLodQEiCsbo9v6xfPf3D8SYSk=
X-Gm-Gg: ASbGnctVLgV53uPF3uIh4hC15bbev2ah5JfuGPOB1MTkLazd1o4G+tphmqG2w/dy+yx
	zaVR6D1v51CFNjsOh+2MlZujtx6+WAyME/UJSXc0Gxw4EhJSD84XTABWj9hPCVfqHZJGlu6Ot5G
	+sk/KmUHNwVL/gGeS2F5ZP2WPAIEP+oFVxHU7w8yvr5W/gYu1Ig6S+2nhOo9b/npSIN9g+65iRS
	SRstCDHFBdy23eKZBtmmN9umxngZfK3U3ZS8x2GAyrFOF2yQUp55hHHYU9ptOfSoXx9akMqn4DA
	P5g6Cvl5DBJ1RJpcgM7S1FFk9lzZ9jA0xhewJ6yXKWr9mj7WaqqazEMhXqmZplEhpyssKzADajD
	VPJTG1KxJ04x0kM+lxZsrk0jD+6jaHBz9R5+cihouEFswH4rXXOwr
X-Received: by 2002:a17:903:189:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23e1b03a4e7mr56603695ad.0.1752602523925;
        Tue, 15 Jul 2025 11:02:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa0R0eUK09CX1ZPe3FlchxOBqEKUBDbKkYIiXgDyJtD8NdGywD3J+Ab9FcocEpLDaL0QBm1A==
X-Received: by 2002:a17:903:189:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-23e1b03a4e7mr56603105ad.0.1752602523425;
        Tue, 15 Jul 2025 11:02:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b713a8sm2363064e87.194.2025.07.15.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:02:01 -0700 (PDT)
Date: Tue, 15 Jul 2025 21:01:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: dwc3: qcom: Remove extcon functionality from glue
Message-ID: <arp6ujd3463lzrpi77e6sb5mwie3uzsyzildct3hkgkni7ozfb@zxomg4beii2b>
References: <20250714044703.2091075-1-krishna.kurapati@oss.qualcomm.com>
 <2025071518-aware-tipping-4e27@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025071518-aware-tipping-4e27@gregkh>
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6876979d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=x7q9rPTPxxJoaMhJE5IA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: spVAxgWbynd2pjP-a3u6RhMyjOmavr6S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE2NSBTYWx0ZWRfXx98vu7xprTeN
 G0/HHbSli8u1Oo+H9fEEQ/b7DXbpmGw0qFtN/3pKtChMbNILVesZ64XgJPAsMMyLidlwomWU4EZ
 hSAZVAWcYoPtS2mMNKlaByZVahdsGTm/H8Np4tRkpd9K1DBC/kvBhb6eF2COQq5VntfkTayI0Ob
 xB5Vm+6igRk0rzzLVakimKG2LCqVhdEZVqc6Gy6EDq6GAYe0jjSPXTOesVVaVB4jwVPiu64933A
 fmq515Aq9EHg0nqh+fQamupnCeL0f5TpGLbJbmltsUp4yHjymx4K3eQxCrEGAbZUrCJ0ucg7sWw
 iypQewMBZwNKKlWoUyfaC6g+SYH2GKmOUVNEoJ7gFmX62uht8dIwV/SQbY7WfZPwe673CwXN+w4
 1jAOu5CLL/QWZUFhso2bgqaGbY95KmosIkKNwIsaOZZdhfMqugO4lCtDtrwG9Gwzu5KtODS1
X-Proofpoint-ORIG-GUID: spVAxgWbynd2pjP-a3u6RhMyjOmavr6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150165

On Tue, Jul 15, 2025 at 07:47:20PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 14, 2025 at 10:17:02AM +0530, Krishna Kurapati wrote:
> > Deprecate usage of extcon functionality from the glue driver. Now
> > that the glue driver is a flattened implementation, all existing
> > DTs would eventually move to new bindings. While doing so let them
> > make use of role-switch/ typec frameworks to provide role data
> > rather than using extcon.
> 
> "Deprecate"?  Looks like you are just deleting all of this code, what is
> going to break when this is removed?  Are there any in-kernel users of
> it?
> 
> > On upstream, summary of targets/platforms using extcon is as follows:
> > 
> > 1. MSM8916 and MSM8939 use Chipidea controller, hence the changes have no
> > effect on them.
> 
> Ok, so those are fine, but:
> 
> > 2. Of the other extcon users, most of them use "linux,extcon-usb-gpio"
> > driver which relies on id/vbus gpios to inform role changes. This can be
> > transitioned to role switch based driver (usb-conn-gpio) while flattening
> > those platforms to move away from extcon and rely on role
> > switching.
> 
> When is that going to happen?  Where are those patches?

This should be better explained in the commit message, I agree here.

Krishna, please point out that existing extcon platforms use legacy glue
driver (due to using legacy DT bindings), while this patch touches only
the new ("flattened") DWC3 driver.

> 
> > 3. The one target that uses dwc3 controller and extcon and is not based
> > on reading gpios is "arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi".
> > This platform uses TI chip to provide extcon. If usb on this platform is
> > being flattneed, then effort should be put in to define a usb-c-connector
> > device in DT and make use of role switch functionality in TUSB320L driver.
> 
> Again, when is that going to be changed?  We can't break in-kernel users
> :(
> 
> thanks,
> 
> greg k-h

-- 
With best wishes
Dmitry

