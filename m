Return-Path: <linux-kernel+bounces-859080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBEBBECA04
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36B8E4E13BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDAB288513;
	Sat, 18 Oct 2025 08:38:23 +0000 (UTC)
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8084321578D;
	Sat, 18 Oct 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760776703; cv=none; b=Yxfnayh+8nbh37iw9wI5a/ZSk9yTyLbOns/YBqE+PkJUCzAiMaZl0Rb181CALQnAYPf3Nki8aF0TL8kmuyKmd/YUZHzRTp+LintPQ+6JW/AFNhikY+EfRAcoDS0/WqD/RQvCRi/hVW9BQKzzuOyZ4mXGHzNbInggMFZE06XI9WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760776703; c=relaxed/simple;
	bh=M5VJ12+bj1LPd5AAHXPmMp+Tu05wiT2uPQtbSc/Bcxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cwbu0AjFkj0Z0gZF/bOuDMUSSKsyCF2yXSB2GcnBDK4RC8xQCdu2LXiFSbnJe9tKv3re7c0jl8PXn4u47vk2EbWp8DuYkc4/qHCt7BTtgpXjFTDn80iwBSuzMVOFeVZ19Li6SPlt+G2ZSn3il5XaJpeX7Ud6NUHZG7mA+6AMYH8=
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
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
Date: Sat, 18 Oct 2025 08:38:04 +0000
Message-ID: <20251018083808.15527-1-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
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

CPU/kernel: Linux auntie 5.15.195-rc1-00277-g06cf22cc87e0 #114 SMP Sat Oct 18 08:32:29 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

