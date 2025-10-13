Return-Path: <linux-kernel+bounces-850074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A0BBD1C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198FD3B7451
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CDD2E88B6;
	Mon, 13 Oct 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CktaWn0j"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA212E7192
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760340450; cv=none; b=U40ezRTjxu1cITC7glYsQLnn4RfOas9Bx007wR9KKYrUaAfV5pOu2rtccFQWYOw9wn4iwq+eb0yKJdMn9cuE5qc/mow+H5Xv6hZ2VD0TtkNnMI+oCinhR6pyIOGWCtOEIYPmVxXOYieKE6PxqR9ZUB8NvzEGmSHZivdSocRycwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760340450; c=relaxed/simple;
	bh=4pYwMMjLxKjKxW07zzwySt1Wyqgpj7uiNUdODjN8rMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2LM9ALi1TowMsS3cOpaTout2jiU7lf5a9C7K2K/uZI6tYwz2mH6xhV7c22C4PZpKgUt0yft7KPuiScyllSmckBaNkzUCI8D1UxflNzIVkL6hysCT+UNmDZEkOR22ZjI90aAd0MI49GCbjMryUA56AkTJR0hnWfQZA7169w1azs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CktaWn0j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D1H0mg016744;
	Mon, 13 Oct 2025 07:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bTiF+B
	WsP+sAuwRYEFqVZgkw/cidH8/ZLJVrg0nDFQo=; b=CktaWn0jx6la+uEI8TTx9e
	MUjU+gy66aapApShNo6+p+tXGn4lsfqNzFUOAtmHwwYViQVM5rCL72TrJu6xP9bs
	duiFsnKeAu4FqkyaHZPD/KZqGeBJSm+T6F5y6WFXQ4kNLDdDvPGMiozkKp2uKupg
	x4E0efOkoabB2a7SxL2oBNfmFSAT/RaSRVvfVHk7EFS03Ms4BeFXlw5kvgIQ/3V0
	GJVQ2dVrkkNgVDfHhu8pDw0kKmsjJmEJzIHf8EVuazTXVR8fN0vAndBrlb+N/a4G
	PgktbKeEAAV5EAs+GF7IMWquMg5fd1rSKUOsa8nhYaf8td2pk4u3TifCn+IekODw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8fjkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 07:27:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6R46d016705;
	Mon, 13 Oct 2025 07:27:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jmk0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 07:27:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59D7R8ZP54723032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 07:27:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6005620074;
	Mon, 13 Oct 2025 07:27:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A9662006E;
	Mon, 13 Oct 2025 07:27:05 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.21.93])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Oct 2025 07:27:05 +0000 (GMT)
Date: Mon, 13 Oct 2025 12:57:00 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
Message-ID: <aOypxKMzsLR5tAtv@linux.ibm.com>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
 <20251013040148.560439-1-vishalc@linux.ibm.com>
 <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b4a3215-1620-40c9-a00c-ca833ebbb7b6@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bp2bZu6f2BQTPTG9kZ1gxrm11KIT41L7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX8vblzQT9rLVU
 7mdtFcJ4Dx4yJkBKI564BPd1idWly6W/VdNzzylF/RLy1OPPrLggdD+vVaxC4H9625dUJonK41d
 BWkUAjmNV1pm9kTXzMx+sHYKWg5gWtljrDeVCHtKRg+Yy+h19gOfVf5jsOOr5I2qSCwcvFzEszk
 61w/aV4MPaugCS923hzffW9Dpvt3itGElkHKWzvvzOfzF1pAUBOnTXePJo8WlM4QoE8TnwbB7nx
 Q6OW/w12EjKWUdlGWi4lk2XLKxNDUiO5d09HKfNWKr3AMsmPYYoNg6y+qXq2DV4BySKCL7qGmMz
 /AxJpddzhwIKP60h4nivBJUPdLUmS600+WogX2ZEljWi7ID8GaTnNAkafYw+FKDL41vEd2pPzso
 7AcI6uK6kkMRplOhngvceTIaWu25pg==
X-Proofpoint-GUID: Bp2bZu6f2BQTPTG9kZ1gxrm11KIT41L7
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68eca9cf cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=CCpqsmhAAAAA:8
 a=-ktxzAwryNFT6qpDX-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

On Mon, Oct 13, 2025 at 08:46:48AM +0200, Christophe Leroy wrote:
> +CLANG ppl
> 
> Hi,
> 
> Le 13/10/2025 à 06:01, Vishal Chourasia a écrit :
> > While debugging a ppc64le QEMU guest on an x86_64 host, I observed GDB crashes
> > when attempting to attach to the remote target:
> > 
> > (gdb) target remote :1234
> > 
> > Investigation revealed that cross-compiling the Linux kernel for ppc64le on an
> > x86_64 host using Clang produces a vmlinux binary containing an empty .interp
> > section. This empty .interp section is responsible for the GDB crashes.
> 
> Which version of CLANG is it ?
(i) ❯ clang --version
clang version 21.0.0git (https://github.com/llvm/llvm-project.git a80bccc6847be104948f46d313f03ac6b9ccb292)

> 
> > 
> > This issue does not occur when:
> > - Building for ppc64le target using GCC on x86_64 host
> > - Building for ppc64le target using Clang on ppc64le host
> 
> Is it the same CLANG version ?
# clang --version
clang version 22.0.0git (https://github.com/llvm/llvm-project.git 2f755c543ab357bd83235592fcee37fa391cdd9d)

> 
> > - Building for ppc64le target using GCC on ppc64le host
> > 
> > For details refer [1]
> > 
> > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=33481
> 

vishalc


