Return-Path: <linux-kernel+bounces-859029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B4FBEC82F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 07:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F050D4E85C2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7962773D8;
	Sat, 18 Oct 2025 05:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4fRehD6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F761FDE39
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760765658; cv=none; b=lkZs3DX2HN+NhWYWkk9KtNDX7gIhDiHvqVAv1ocYScShOYuMbyOul0vPosgUA0iCQ2sbz+P+eNsjIPfiEekBLGOgcUTImF+lwZGhGBn+oPYbsdsW41HEzg7kshqON0Gq6gfUpMYPMfS5kLMzRVvcEiPs6CFWDtUX9dkDroLTOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760765658; c=relaxed/simple;
	bh=3wWYRY8lHMFlIsMgMXZz7Ax0r0b6Q3jCNmTO+YYi+UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CpekgrjQQ0jEAYxJwGRG0158GN4TIuG2YCDJykML2PHNN/LALPuNw1Ts7xHyKgRt1ZyajO9bisuPrpE0p4KJ1XnY2MGYMLy0OLl9H3hQApWDBctvmzw0wrkfgC3vsn/lOW7a6/59mucXwFp0FAbvVZeTWUxJ5ehoZL2zB0eUSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4fRehD6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I4Z7bt005199;
	Sat, 18 Oct 2025 05:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1a2xqC
	PKn7Yfe3qT3m1xrGTlZho+TG3RTSnggotxZDU=; b=E4fRehD6nrArxKtRSPcC8s
	XwOgpkALWloeWT2P3I85t1bBmhJpxD3NIcl6cSt3+L/7I1J4wQWHSz0viExo3EPW
	K250BDFvk/XEyMyo/gDUSC6qvxiqBjieR8lt4TJtroiD3fHCzKyg77f+X22PbS2C
	PN7omG0hahQGp63OV9kpbCXZvUC1nsrz1Oh5bcSpe+fCuWWQxc+tr7a4VeT1qrhR
	n0JQbQw7u3FpjhedFcqxvesDfPzGYF+fANqJfDE031uIOqtOhBdJuM6jD8/epfX8
	uDccN+vAxV2PRrrK/AGk/TT2ogJkMqJ9/RE13ZbUSWgHgt7i4AgBZ2tlQkWUCToQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33erb77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Oct 2025 05:33:57 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59I5Xvim027400;
	Sat, 18 Oct 2025 05:33:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33erb75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Oct 2025 05:33:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59I3hrIM016742;
	Sat, 18 Oct 2025 05:33:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32kgt8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 Oct 2025 05:33:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59I5Xs9T27394348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 05:33:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827E220043;
	Sat, 18 Oct 2025 05:33:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75F0A20040;
	Sat, 18 Oct 2025 05:33:52 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com (unknown [9.43.69.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 18 Oct 2025 05:33:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nam Cao <namcao@linutronix.de>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/msi: Fix NULL pointer dereference at irq domain teardown
Date: Sat, 18 Oct 2025 11:03:51 +0530
Message-ID: <176076456872.59904.2831569431349537120.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010120307.3281720-1-namcao@linutronix.de>
References: <20251010120307.3281720-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f326c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=dwpbbf9tRbJM_blNvucA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6yZP38Vl89LVXNHJjfBlkkslVXp2LRqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX00aPiBFyr+W6
 WG1fJ47TtpUUnVAfhfra8RUQA3B0SoPDQHhmEWV6msPpW5k+IRtwb3abCIYW/8iyqhDf3IL5m+R
 kHwFgPo/9LSUBEjDoJfGTJ1DP8B0x9TtoDPVk2seqhI5dxYFhHxbcLfbHK4WESe867CBKZOlVR9
 1TxTCAcC2HTN85lQOhr8vAHOyqW/swQyyeBQhIMt6lSWB3G0aLYPDymYyaesotHZZXpkoyGqCcV
 1vv+h76Qf37K4LdDScNEYWxhluEqPp//F3JYv84St4GBvvxxNzqqWPQDAYYVjKzHDtfHhhBP72s
 +GdLVwLXPH7PkfD0Q87PyQRmeoOtWj0ouzTkC1IHArWOfnPwW3AtlBp5VNdIARS3Opt6YgQ6NIy
 sThR0QCp+dH1dCNRQbXbK7F+vwILcA==
X-Proofpoint-ORIG-GUID: VICwb4uCS6y3HdMBRqjtsqusEBH2C9o4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Fri, 10 Oct 2025 12:03:07 +0000, Nam Cao wrote:
> pseries_msi_ops_teardown() reads pci_dev* from msi_alloc_info_t. However,
> pseries_msi_ops_prepare() does not populate this structure, thus it is all
> zeros. Consequently, pseries_msi_ops_teardown() triggers a NULL pointer
> dereference crash.
> 
> struct pci_dev is available in struct irq_domain. Read it there instead.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/msi: Fix NULL pointer dereference at irq domain teardown
      https://git.kernel.org/powerpc/c/ef3e73a917ec7d080e0fb0e4015098a4fb0f1cff

Thanks

