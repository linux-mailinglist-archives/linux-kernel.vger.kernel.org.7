Return-Path: <linux-kernel+bounces-580466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E53A75223
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60280188ED94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC711EF375;
	Fri, 28 Mar 2025 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dwf1xw/P"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B19183CB0;
	Fri, 28 Mar 2025 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743197948; cv=none; b=Gr20+9NPVtlc8Crdx26QTq82lI7A63g++k7Owi6+A41aNInDipsQXzh2l+IOpBJiF3UI+2ZZciOobrMLzJVrqlssvjgMAwvg2g1UJKKjwLjPQASO5rNOOxruov20XALr0R0AU5HVUWeyNPXt/d0ct6pGnAEToRAfnwUVpGDd6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743197948; c=relaxed/simple;
	bh=DQDTrQLhMzb6sR4+0c8ViHURa6KbmU20j1Ff8g1ZiWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j5c0KuA9/hJ4bj2BT+AfekADSDacgutORKHj8oPKmDNhwlKNlXm+NQzC4WH4qEoM7ooAG/YFzdfbB24BtwuD/owQMzOitSU/sy5xFbtF0ZFl0QPCpu9OzO3qJ66fGHwkgEWhM4HGYC85zEWk1V6Db5Cdjq2ufl0qi3rpgLDFUPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dwf1xw/P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 937E22025640; Fri, 28 Mar 2025 14:39:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 937E22025640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743197941;
	bh=NluN8Nh0F+jg+nys1gPR5DT7JxqFS9Cp+4hpM5K7JVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dwf1xw/Pnsxplv+nVKG1Y322FT9KrLyOnk0AbcH0+csZbwVdWhYl5Ixm1UFUA0HhD
	 tujHbXizKtwHiLgsLt0haDOlnoZgPviSSED9+LUZnBy4DWvdUsrrBRVA0F6agLH0mT
	 nthjtdsh/it6h9RPy/6tMbSQotoevR0zje108Avs=
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
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc3 review
Date: Fri, 28 Mar 2025 14:39:01 -0700
Message-Id: <1743197941-20416-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250328074420.301061796@linuxfoundation.org>
References: <20250328074420.301061796@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.1.132-rc3 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
25843869  11302614  16613376 53759859  3344f73  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
31266274  12543696  831088   44641058  2a92b22  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

