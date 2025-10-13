Return-Path: <linux-kernel+bounces-849928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C493BD159A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 480BE4E0566
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D03221282;
	Mon, 13 Oct 2025 04:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="soqAXXct"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AD1CA84
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760328126; cv=none; b=QjJY0kvNETna3KgP1VQKWrsTXftyeMXFGJvxUVamDUEz6UrlQBd92MQ4lm5YeKn0M/MGj1fq0TDo7SoDswgRwZHVbtrRAK4iS517hSM4DYY4n0/4jhOOO+vbGRpko82KPxLQo2CoC1z8WkaTOuTz5C8PEnCPKeRZc3/KHO0N+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760328126; c=relaxed/simple;
	bh=vgJyBWbrzFQsluMf3HzboruVyOvSXQjC4vkn07+mhMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edi4IelTjgc0yRELLLrTuSYPQSJ9rKx28RQfyarjynd4Ylt0eD5MGvylI7cZgWxD7YLKb7UM9xVggBo+QkI5eTCdRLsGk92XTkL4FdvCo6JcfyOnLn8RJyXswyU3Binr1PDAweFQw82ONXHkasW65hsgIT/V+xOeVjBayah32Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=soqAXXct; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2REhd021104;
	Mon, 13 Oct 2025 04:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zFf4X+S5AYm9vMFCO
	XAZTHoGQnipWU7aASbF2RURilI=; b=soqAXXctqINhDTklErHNsOnAg0JdHf5Fb
	9yiA4Ccgkh+fAEc3C5i6obgDoA+zGsBJLN3wsI9N+NPN0pQDkFI2EZ28ttyris9H
	lbDIjKU3fZ2xmCIOrY1qnXu6fh/DLa5bkcfnCls8ayJboCH+rJHJThj0Ps8bsWNu
	r2rskllxVqp6WxPnTQVsAafepzwN0bjZS9LTgU0+WHdFSqT4ALZ/KfLeLcORxQu9
	z0t2/OKs+LDUdklN+wbaiG2nGYWd41lqTOj3pe/hlWr3QHUYTQd9IVktKZ/NsNAL
	QpHvQz3SgT0IUd5jAbeSmoTt+vFrMTRauihyuupE30gGkjvJQCADw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8ex5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 04:01:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59D26aM1003812;
	Mon, 13 Oct 2025 04:01:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r490usdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 04:01:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59D41pFw31129940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 04:01:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5E620125;
	Mon, 13 Oct 2025 04:01:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3412D200D8;
	Mon, 13 Oct 2025 04:01:50 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.21.93])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 04:01:49 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove .interp section in vmlinux
Date: Mon, 13 Oct 2025 09:31:48 +0530
Message-ID: <20251013040148.560439-1-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
References: <eeaf8fd6628a75d19872ab31cf7e7179e2baef5e.1751366959.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pETyR0XVF2t6SoMCl3aVmamFlGqcLSiV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXwEUQ+m/Qex+7
 U/B51HwVWIWr+NMN8uCrZLMNexcZSP9vKVcnLOlkqwyhKVDJOH9w+AwUTC1sPNl/B8m0AaSFobQ
 ozgEYP0ydcoTk6U4ppdTOoY47ugEs/xEbwAlvuWe1odd82JTYm7aODD+/i95nVTtQU/a5ZZ1jBT
 t5+xi/MNuvVz8BHGcufgrGe8snXAIjOIrIZtuQDx0hF8PD5HQwexC2o3N6CI1ztum5YG8iE2UGi
 w2odTBcHkIp1cA8ERA6DHQsmaVidbdAd9vvO1frgIw1qVSZFhLQgT/a5YadZhmYtPvFqSXyQoUY
 A4hSSkBD2mTF6GthQaYTiTVxRbrQXHX4CJgilQNoRaupuhcQ7zeJELpDtnGoREl2WyMZUaJ7nux
 De/ht6/kT9SpbAixfQ8+CLcwzUE/GA==
X-Proofpoint-GUID: pETyR0XVF2t6SoMCl3aVmamFlGqcLSiV
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ec79b2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=CCpqsmhAAAAA:8 a=sAOM7heRkMNWthvXo-4A:9
 a=ul9cdbp4aOFLsgKbc677:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

While debugging a ppc64le QEMU guest on an x86_64 host, I observed GDB crashes
when attempting to attach to the remote target:

(gdb) target remote :1234

Investigation revealed that cross-compiling the Linux kernel for ppc64le on an
x86_64 host using Clang produces a vmlinux binary containing an empty .interp
section. This empty .interp section is responsible for the GDB crashes.

This issue does not occur when:
- Building for ppc64le target using GCC on x86_64 host
- Building for ppc64le target using Clang on ppc64le host  
- Building for ppc64le target using GCC on ppc64le host

For details refer [1]

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=33481

vishalc

