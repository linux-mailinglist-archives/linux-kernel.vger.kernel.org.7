Return-Path: <linux-kernel+bounces-687141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3ACADA0AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56493B5A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jun 2025 02:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE693A8C1;
	Sun, 15 Jun 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KbMrHXAR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48835979
	for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749955202; cv=none; b=Jxk69lDM9O3PnmgncWKWXb4TZWrvQRXq1IiAdP9UBP7q2jSwF9vU7NHSr9B/Te0Lpqm2fRTqWKZ+07bzHCBln9GQEto4lYzztPIRdUJpO/cxZjnyVpMtfqwZiiEp7iQ+aKJ28q9vefEEzlocJgygd8sMovZxftLvq/Uv8D6QiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749955202; c=relaxed/simple;
	bh=qJ1VnWCotHhWxHbfyKtE3MZu1GnsNsg8IMEtv65WTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r18+J5Ga6vTzMcggsz4ZxWZ/Vv4zTJWtkFe0SrrRqlknuPwX2dyRYG3s4yMeRd5+Ap4nw8xPFbGi3FnECDxuLmv6Fme25Xcsao8BJbvx3Z56dpmqdgEbOmV1hEEC97w8nQAwzRGKFTS5sxbteZT+zupmaVrx0akBz1g+UrMfLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KbMrHXAR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ENQbku001713;
	Sun, 15 Jun 2025 02:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hUGjMA
	UYy4wu8n0OUXNcHylAwMp7JmMIoslQdQbE/Yg=; b=KbMrHXARhOooDP9Aiy92gb
	sodxmXeE6GilY2dML2VN8cUwW0TjeahsdA8C6E9E0AfA3T1qo/xaCJv+0TlETlIw
	/e1nQxjsG4PtrjobuxhxnBSyO3jondyIXwPTXnDigslOS1KpQ3QtM++GMnZIaRX2
	B/ScQ5p7YcVxwWrsik3DyUsoCbwhOTR2/hBBxLKwnGLUJpKnI46zI+U4mV/0e/Sh
	RnDa6iRoszVsIIlcWjlmWiD92esf6GwqZlunOPD3SOssrer2Dyz92gmlqN2GyfAf
	BXE3q48oI/JP92vjX97Hom/fPAephEQqCqwQs9p9uYnuzfDVG+rfe2WqC7KzaqUg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygmurs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 02:39:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55F2dTfY013396;
	Sun, 15 Jun 2025 02:39:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygmurs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 02:39:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55F1rM7d005481;
	Sun, 15 Jun 2025 02:39:29 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 479mwkr52q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 02:39:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55F2dPxg43975104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2025 02:39:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107E42004B;
	Sun, 15 Jun 2025 02:39:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AF8A20043;
	Sun, 15 Jun 2025 02:39:18 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.64.23])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 15 Jun 2025 02:39:17 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mahesh@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org, agraf@suse.de,
        vaibhav@linux.ibm.com
Subject: Re: [PATCH v1] powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery
Date: Sun, 15 Jun 2025 08:09:15 +0530
Message-ID: <174995502358.107804.15093806320062799032.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508062928.146043-1-nnmlinux@linux.ibm.com>
References: <20250508062928.146043-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE1MDAxMiBTYWx0ZWRfX9vAKVCGVL9TX hAc/KyA1ai4sGX0cQw6WaQlVyrAuFZnaeCACtHbLgK6swZbYZ9hqGep7xnrXA/1R62MpCokKvD3 sTDSQLIz2hGWcU2g894HBsz0UaNkdBeFyR7PamuoKkd2S4lmKwJQE28pr64DCb2T6+Iv/kkDnJ+
 QeVsq+EDKx5aQsODNc5i02VbpDhjIYo48f0ilfLCJ9y9n+ObRzWKFIdnp9A0OSTt3TqfJ1aQsEy p4GsZ6YLWsSvZfQKKABzaMYeG0njUmGsp8Lg6bZvvP7rNYapUUpArecHeNhWmXVjJV2l/GRiRcI EyEDjn+rowclylK0MLUxx4EfPTXbwJi8gbf2JXTA8KzAQTK91LmjxBvaVxSNQcw2QdkljxsAB+o
 b4DOj/XP5bDUcLADQK+IeUyi1jA345f4IYvzAfRVB39zhbJPJZp9TttZLjvtS8Z+dhikgiF6
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=684e3262 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=giJ742wZMMcE2DLqPy8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 2uUB5_iAxcxn8AqaFhb8WcrvLTioQNus
X-Proofpoint-GUID: Q51RZxXKa5-8m08omSAXjP2Tav_LF4Tr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506150012

On Thu, 08 May 2025 02:29:28 -0400, Narayana Murty N wrote:
> VFIO EEH recovery for PCI passthrough devices fails on PowerNV and pseries
> platforms due to missing host-side PE bridge reconfiguration. In the
> current implementation, eeh_pe_configure() only performs RTAS or OPAL-based
> bridge reconfiguration for native host devices, but skips it entirely for
> PEs managed through VFIO in guest passthrough scenarios.
> 
> This leads to incomplete EEH recovery when a PCI error affects a
> passthrough device assigned to a QEMU/KVM guest. Although VFIO triggers the
> EEH recovery flow through VFIO_EEH_PE_ENABLE ioctl, the platform-specific
> bridge reconfiguration step is silently bypassed. As a result, the PE's
> config space is not fully restored, causing subsequent config space access
> failures or EEH freeze-on-access errors inside the guest.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/eeh: Fix missing PE bridge reconfiguration during VFIO EEH recovery
      https://git.kernel.org/powerpc/c/33bc69cf6655cf60829a803a45275f11a74899e5

Thanks

