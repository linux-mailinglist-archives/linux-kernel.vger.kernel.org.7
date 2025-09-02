Return-Path: <linux-kernel+bounces-797006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC3AB40A9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C7B563411
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE183375DA;
	Tue,  2 Sep 2025 16:30:40 +0000 (UTC)
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B925524D;
	Tue,  2 Sep 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830639; cv=none; b=aOOyW/1a6tNhm5Y7s+P0Ct/9b5HVWmsLK11dc+yTRW952pU7OmbaGeO6r2PvKLNj6qqfIHtTctjW1xgslxpjp8XaotVtfHlr3cTO2qx5ZKZHbuuy7mFLvAnoAZQFFAqqNy3rbjlhg/o+456jqq2USEWXGrTClngLALMdlpGxN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830639; c=relaxed/simple;
	bh=uwFd+p+GiSTiDMNHNhyk9bMdamBajOD2KSyQ7gvsKMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdvHnR+P5kUmdpbb8SvjW2XCVCAZeWLRd27LE4jYT+sQSW1x4kENsVY4cK0gM8zCI1pzq78dB5tBMT89xhiIgL2dTdOBnWai91PDFHPAcAoQZTyIkG3k3P+Ey1ELTLUXURa+OV+HwVz7T57FB48T2qRjgLugvKTWrA6z4DXaBTU=
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
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: 6.6.104-rc1 review
Date: Tue,  2 Sep 2025 16:30:13 +0000
Message-ID: <20250902163012.4425-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
References: <20250902131935.107897242@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Broadcast regression confirmed fixed:
  https://lore.kernel.org/regressions/20250822165231.4353-4-bacs@librecast.net

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.6.104-rc1-g12cf6be144d1 #57 SMP PREEMPT_DYNAMIC Tue Sep  2 16:01:15 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

