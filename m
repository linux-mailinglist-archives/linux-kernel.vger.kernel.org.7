Return-Path: <linux-kernel+bounces-873891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357EC15047
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D683ABF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4962571C3;
	Tue, 28 Oct 2025 13:54:55 +0000 (UTC)
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025BF21A425;
	Tue, 28 Oct 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659694; cv=none; b=iUv9vR7jrjHnrNXiaGoP2jpxTqsSD4E5rJLfCkS4hEPLepjh2YuaG/wNw0GzZPt7LCuBnQ61BRqQZJJ9Nl1U3HIpph1aF4b8FNdXq7dm4IpbP8gLtweGwltlgvutOdHtcWlaIIBpA5ok/9P/ZVyeYcz1tF7KriKKFsOhmCkYHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659694; c=relaxed/simple;
	bh=31bW4LWA5ao9Wm9OsnLzLur6IKi8BrgSP8OGDYxXdZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDQfWudkyiVWKZw9SyzZgBm+cI1KpkHTUaGGFtGpwjKi5QiqWM9h+aE5s/fV/U9LoWNIHWJY1WRC1vhw9LkdohR61thB5Tc+229CeMGLArdppZbUU8fFHgeekmjczbVwU4HBGR2G9KuGsVU8iCivuekfvg66m7HZEW599LsW7lw=
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
Subject: Re: [PATCH 5.10 000/325] 5.10.246-rc2 review
Date: Tue, 28 Oct 2025 13:54:44 +0000
Message-ID: <20251028135446.4004-1-bacs@librecast.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028092846.265406861@linuxfoundation.org>
References: <20251028092846.265406861@linuxfoundation.org>
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

CPU/kernel: Linux auntie 5.10.246-rc2-00326-g98417fb6195f #123 SMP Tue Oct 28 13:41:25 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

