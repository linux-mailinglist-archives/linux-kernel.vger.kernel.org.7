Return-Path: <linux-kernel+bounces-777331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C54B2D828
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276E1727C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3B32DCBE2;
	Wed, 20 Aug 2025 09:20:59 +0000 (UTC)
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC1265631;
	Wed, 20 Aug 2025 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681659; cv=none; b=XmqLfPeUvS3Jfwvw5dWZFjffXJ2z27GQm6fIxYOrPS44ninHci80rDxOB+Vne00tYEABZ/7i5hkBJbJRja9RvTHC7tNIM4OAQervkkBvWIsojCiV4MCpIFheTIN98+Jgk5kWSGVfoorUSdc85W1inhzw9WZqphELY9bAE6qL3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681659; c=relaxed/simple;
	bh=ypMtHcUI+ZIwt2sZkzkb/1Pogv8l3yFCqPeGbVdSgt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTKQ2qP3my21iPEDtkXN97n06QG/VQR3LttXjuXH/GW1qA1075BqFdTwSS6ZuP1XvhPcL7xQR5Be6UY9FIka3Qm+GQKuI7kG0E6aC7R/Z5gS7tzId9NAJyvPtdtu28nb+aWSI1dLHLUk9Pa73728DPkPSr2IeojNebLP3V+LF34=
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
Subject: Re: 6.15.11-rc2 review
Date: Wed, 20 Aug 2025 09:20:05 +0000
Message-ID: <20250820092004.29784-2-bacs@librecast.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250819122834.836683687@linuxfoundation.org>
References: <20250819122834.836683687@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Librecast Test Results

010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 6.15.11-rc2-gcf068471031d #45 SMP PREEMPT_DYNAMIC Wed Aug 20 09:16:39 -00 2025 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

