Return-Path: <linux-kernel+bounces-881524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBB4C28662
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 20:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC88A4E7F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7082C252910;
	Sat,  1 Nov 2025 19:32:10 +0000 (UTC)
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2824113D;
	Sat,  1 Nov 2025 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762025530; cv=none; b=PdCceS8uiqcgvtNrBjoeiiLWvqyxF8FA8GkXURQQzMhaPeuwbyasCl9wOnfg+1YbN+StnSLPN3DXAHL5zIO74p3lOYb7moE5TDH14+1EdkDyhRIKC7Z7iTgXtzSKyFq9jHndw0N0150N3Zz99mHla3OtSk9JxT3bHqpDcTMfyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762025530; c=relaxed/simple;
	bh=BlgfTmFNGpHdeucRtPcLAOjpEZoEMXU9E29l1/s/JRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GN/sW3TAA/Gami96UbVztlCa5nsxmqyY8SNKfRHL0PiFKSAce7ewZrPuw4cRzzPkekFzyjudwDZU9JwEWAV4v/NMXieU4RgZ5gW4w+LUg7DUlxEIqbO3po+sWrvQP6opf6RL05/3FmXMIjUlDZO6G16aGdqHMW/IWGHhQUuxYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
Date: Sat,  1 Nov 2025 19:31:48 +0000
Message-ID: <20251101193150.2322-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
References: <20251031140043.939381518@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

020/020 [ OK ] liblcrq
010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.12.57-rc1-gc3010c2f692b #126 SMP PREEMPT_DYNAMIC Sat Nov  1 19:20:43 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

