Return-Path: <linux-kernel+bounces-804148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FCB46AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386945651E4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6F2E888F;
	Sat,  6 Sep 2025 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gZdilHPI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93352E7BAB
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757153269; cv=none; b=XRM1whV9nvmkq7l16FkXo1nfm/0hRnJekXAMK79h7r8n64MJyxs4VhvoK3Y9TP0jL6x2pCOfztzQOvXiX1SHA4DrvZXwy0R5OrEj6zogot/ZYDMIx++bfD54svdGYGPnveUaLNs5I6y+ZKi/KVO7tJbHULv8Q50lZxVmZK6jimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757153269; c=relaxed/simple;
	bh=2F/wzsEsFPGdDEvDj+PLAWKU5Kih+BTlFqkH5lYu+BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOLdmGDimzg9VIeWJv41iBpNbDG9sTLrr5itc3YYXC5r3BDPjEBgXd16JVzpK7DEVYCuGcDNMLYaVdmC5NPvXOPLpXJEJ/s2/d9BsOAHeH8xllaY/hSVpaV3LcUjvfSbX99+LR/vJGX89RFyK4gH6v6Lfm46rG7z814qFnpt2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gZdilHPI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5863ofLC025614;
	Sat, 6 Sep 2025 10:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CZNn1C
	8CL/q+WGmv+vcch3PsxrOMEvOrvNkL1/C4qU8=; b=gZdilHPIyTe+0GxEoyHNr4
	RNs2pmrNXTGzC/kPL97lBgMx+gC0fVEPe2V/V8RrwsK6n7xXdQqIZYR1M0lPTWK5
	nf+bFcxYiOmyVC2X2bu+j9DYDCLZA2gzNanBZp2ILmq1Xw2N+zIsIkiMwXkTrubm
	HVvafHYC+J2FTJzC7MUp3f90feLzXJE2noK8v1q05EGbs9Rco/vKvBjcHXrbfBLI
	TrseXm2tsTqAeGaouG/T7XzWCEpxyJ/71TXGzP0+RoAZ1ZoqAiPA/zWeStU30MTQ
	UClqJscyQtDtoc2KMSXOyWhpTDfk+kbQJ2Ntt5j8PUwmhtCsLu7sxTELn4old/Kw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfes4sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5868QaqR019363;
	Sat, 6 Sep 2025 10:07:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4nd9w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Sep 2025 10:07:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 586A7V0j22217152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Sep 2025 10:07:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830BA2005A;
	Sat,  6 Sep 2025 10:07:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763632004D;
	Sat,  6 Sep 2025 10:07:29 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.107.45])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Sep 2025 10:07:29 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Huth <thuth@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in header files
Date: Sat,  6 Sep 2025 15:37:28 +0530
Message-ID: <175715312004.95031.8015199240329986989.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801082007.32904-1-thuth@redhat.com>
References: <20250801082007.32904-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: We6pR1ypHcundy0I6w2ZJYLChoqwxF28
X-Proofpoint-GUID: We6pR1ypHcundy0I6w2ZJYLChoqwxF28
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bc07e6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=zwY7vhdFYRJvcIJZdwUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX9K7J0/NLjj7t
 ijCllUkn6w09quDCssmPwXZ1c7yHqmhSdJY3EeBUy5lbUpHpD9Y0Ck2MoctxpcbWUixm3WgZLTq
 jWP5wVD5tn5BZCircc0nAY1WThSCT+JeqaW1cwa97BKSmOOWZr5EjfQXQ4QxCDIelD6Za5eL6je
 y5W+FHSGUniZwmhgySIiaTnf8rgOhdRSGYQdNaegh/Voe47EBMSS5FGpnkpfokUgRZRCp8IKd/5
 M1KNoP6Wbbbf0XPBcrZP8l++SJaz75Dnn3GH7qKdQcWDWNP2PjzoyqFGatwKsOeoEYV/x1d3NBw
 9zNcbYVnJ5Ztc7fK7uewkmcpRwidFBc2gGXitY+6izJhFBNVPFrrli/jRz4ucOmBhYfaeEehwCp
 fN/Z5InZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Fri, 01 Aug 2025 10:20:05 +0200, Thomas Huth wrote:
> The kernel Makefiles define the __ASSEMBLY__ macro to provide
> a way to use headers in both, assembly and C source code. This is bad
> since macros starting with two underscores are names that are reserved
> by the C language.
> Additionally, all the supported versions of the GCC and Clang compilers
> also define the macro __ASSEMBLER__ automatically already when compiling
> assembly code, so some kernel headers are using __ASSEMBLER__ instead.
> With regards to userspace code, this seems also to be constant source
> of confusion, see for example these links here:
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
      https://git.kernel.org/powerpc/c/8e0665eb85394ea9823fb965a73ae9a6265af4b0
[2/2] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
      https://git.kernel.org/powerpc/c/74db6cc331b0da5c48c62b7af68d747ec9af1984

Thanks

