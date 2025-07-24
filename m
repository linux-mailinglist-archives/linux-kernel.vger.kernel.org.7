Return-Path: <linux-kernel+bounces-743487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08981B0FF38
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 05:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431F0580285
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874AE1E1DEC;
	Thu, 24 Jul 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d+/RUftP"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8CB4C8F;
	Thu, 24 Jul 2025 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328813; cv=none; b=pIXuf39REkQ/LBvqUyjiP+gYo8YJMvqxbvwDe2P6TMAJjll07V3KZpaMaUF+fAbUiSXiWhZShqEn6MOzn5+H/9BceOF+yEHzYrcsVNAbVZelsR/CE+uxB6TQf9dkdfgP10jd2kw4h6ISAUFHksWN6Sx15eKIKBL7wQHfoDd48VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328813; c=relaxed/simple;
	bh=OZ+wUYEDiPPc/eauVKaCLzYZv1JB58LsririkIbR7Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ctg4iGyA99NFB1E9a4qjtr2JFebDyCAJcGgQ89ppkp8gFIeDNIPyFY3ol4QSQQWrvStPLcBx0ioxzLqm/ohWChPcvQDPUCMTDPtTZGHTCi+Y5THo6+0IehI52vyQeOfUhOoiPXw1VBJPMz2wwx8fk0A6Qa9140R9GnuIVH7giMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=d+/RUftP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 5C2842120398; Wed, 23 Jul 2025 20:46:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C2842120398
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753328811;
	bh=aiQAVMS+QCHqgf7L4RUucokaXJAR6PElZPtqVeQtAKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+/RUftPjjNuHDQX10RS+0csvxWknDgq1UdZ8a60KAbMvueu/6BGdChwE7Pe8PFS6
	 gwxAUVjey47qYNDfxoOADGTdaGd/MFR0Z4woR4NUia77mKJTf3saLPbpPjVIXgaJ4K
	 /jrmOvwjINQcao1bdlDeWgjvo1qF+Ci79Ztfg+eE=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
Date: Wed, 23 Jul 2025 20:46:51 -0700
Message-Id: <1753328811-17253-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
References: <20250722134333.375479548@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel, bpf tool, and perf tool builds fine for v6.6.100-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
27324638  16736514  4640768  48701920  2e721e0  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
34724208  13857266  970368   49551842  2f419e2  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

