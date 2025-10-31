Return-Path: <linux-kernel+bounces-880379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F79C25A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C26404B36
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78E34CFB4;
	Fri, 31 Oct 2025 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="Ley0uC2w"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2F34C9BA;
	Fri, 31 Oct 2025 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921762; cv=none; b=qTy/g6xJMWMG0j/TfBlI4LVCF4skjtQPKh+CDXvfZRzOBCGUFfMbZUwSbU6qQWorUjLCtzctOptsJfXJTT5gr6uI/Od/CXH1TwwtdQj6Bf8Gc05oVbuKrBrGLuddNc8ILQ/nSvyOyeuvm1IIMtuEs0I2jSkRXHmu90MWykP6o8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921762; c=relaxed/simple;
	bh=Ahd5Rzp/+Rk/0orJlPIt31Pr0Ga2cuD8Fs7Too8CKBg=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=U8T4VU5SL2AjRw1K9QhwxH64YoSY8Xf1Hwq/On25dp5qyBXZ/xInOSiOYGdDqqi5m/alHr8+CIjSGkMM5yy9GSBUn3h8H+HvCEAxtUNkFzjQGCg6LQSFpRsgolNBJs+eCX9w3261a49EijMmaVbB4SXdzdaoKO8tB7pkHNXruC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=Ley0uC2w; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VDiHdH2882472;
	Fri, 31 Oct 2025 14:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=p
	VnwbKyAoM4XNHeszp6tYbSCUGRBg1M1CjmSLFZIMuc=; b=Ley0uC2wO7T5BzH/7
	zsdZ03fF91Z0sKAaY+PKUgpyLynJL/hCuL/Cj0w6CQqyfWAB8sklyj2qf0LREBbV
	jYXBhXSJaZBW4dHnhBbmkwPLUm5kWMO71DBmjpdT+/fpPfs52Vv6UUU1QeEwBkfx
	76sEFt8waK9u4kRCwq0WEj+4219xCK1KKyk66bw2D9CuVwH4CzIjCIIxh6jHjXy1
	kC04apRAM6VbRgTRn4oD2Jmb/LjzS3U8XEgReEEjG9iU9CnoYwB7XkjUfu6BP0Ih
	rg7Z+fXI/3OURsfnpuhot5rNDFbDFFuYDwhDxMaD+aUyODcTupb5Pt+V55JP6HrI
	tpG/Q==
Received: from hhmail02.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4a3whxsa38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 14:42:07 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 14:42:07 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.134) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 31 Oct 2025 14:42:06 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: <devicetree@vger.kernel.org>,
        Marek Vasut
	<marek.vasut+renesas@mailbox.org>
CC: Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
        Frank Binns <frank.binns@imgtec.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
        "Simona
 Vetter" <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>
References: <20251029194210.129326-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] dt-bindings: gpu: img,powervr-rogue: Drop duplicate
 newline
Message-ID: <176192172651.30862.3429730919575512889.b4-ty@imgtec.com>
Date: Fri, 31 Oct 2025 14:42:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: b0vaoEnKbzPb7F2e5pKIhGvH2QVMFCCq
X-Authority-Analysis: v=2.4 cv=C5zkCAP+ c=1 sm=1 tr=0 ts=6904cabf cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=0einROue838A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=r_1tXGB3AAAA:8 a=S9DGgefAEktgCmtaPdcA:9
 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: b0vaoEnKbzPb7F2e5pKIhGvH2QVMFCCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfX1brwmYvW6If9
 ummI8lS3/Xn4GLgQYIHAznz8T1D4izhA8MVzbD3MgN/CuOLmGox5EOIaj7OxFoZbA+IQyD7VXBM
 2OaFLGbiksNs9mByTtbs1BpIa36aV4fqdJJQBvRPS6VrOdTg2NLpk7BmAM5ZDYaxrC4zMs5xut8
 UHxyKr/v26iZoaDjuS3YG2NpwE0ujXHO3+vhnQjlFCZ8f+IFI/5yWDqC6mykHOmmY/+2TqPLKLm
 kgehE9EVr0N6ZVEzsfM1qBhQS+fqR9Kk4jYapY8LN9W9qyj/a/qaTeo1FCEPHV0dPv4CjJDOxY9
 7eukHjsei7+01T82r/et+0cZc37YuLZhMWoaNk1+grm58EtCnlw3In+rdB9u1DDbHpSCTVmMtl0
 unUxY343wAj++zFv53ywU6hcWtznSQ==


On Wed, 29 Oct 2025 20:42:02 +0100, Marek Vasut wrote:
> Fix the following DT schema check warning:
> 
> ./Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml:103:1: [warning] too many blank lines (2 > 1) (empty-lines)
> 
> One newline is enough. No functional change.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: gpu: img,powervr-rogue: Drop duplicate newline
      commit: 75d42e0351ac5ea080c33a15a92293155f51c9c9

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


