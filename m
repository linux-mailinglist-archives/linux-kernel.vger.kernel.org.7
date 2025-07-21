Return-Path: <linux-kernel+bounces-739536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C7B0C77D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A5037A93A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC92DFA27;
	Mon, 21 Jul 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPpXm3ZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345A2629D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111463; cv=none; b=XEAwXSu0owvFalsoJuxTTTjJ6AD6nW+aSXDSOXkrMlUQT2G9Nx0pSQtTwEvSHhM31bcxXNQzpnM6ZlaUJuTsA8pO3SVPUTa3yQmdAQxZP/awVZmzREQUvbBSvl16Gi/2PvAPuDx2LZHVMp9cewQdzuZsarDcTOprIMxHnc4mLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111463; c=relaxed/simple;
	bh=u7kadqgEuZg2AIfHSsFUPNGoFSwQ+kvDr9zi4Pzt0jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhORohnKgJJQBPMVXD/GoHRIm88Gg1QUxfJ1EAJ6gWIxDpHh1GfItrwm6FzOBk0rdi6dwv9+2ml9/fJHaGmUOpJnskwlc8MXr67dpqK1jBLO7j2iQ//BVjzJZA/G0H2YTDw8Y9u2m6llDu/yrS3IJ3HCaDotU5Akjgrol9XGIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPpXm3ZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2A3C4CEF4;
	Mon, 21 Jul 2025 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753111463;
	bh=u7kadqgEuZg2AIfHSsFUPNGoFSwQ+kvDr9zi4Pzt0jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mPpXm3ZMxx5I5hLFD3D4uhlL5wluYO2VkUikYsnM2qrE+pE9he1Ptl/L5PUIPPHwr
	 ZxbGds58QlLrXXlXqXIeNJIYSi5YitNsrlNdLdUHBJKBmqLh6Rp6bZdSYRrl5sIOC9
	 9PUVxDK67XTMS5Mv9DyoW+oRbID5559061lwjaHZJUqU/7CwUpZP1fZilcJ/v+qYz9
	 WM+22iXDj2o3W8X1/aSQ1yUfBnbjNhrKa7DMzYjJidbN3D0ZU6OeIL39AJuDCIo3rK
	 0E7Luqvqj/RJr1QeGJOT1XI+40tAKwszjijs2lciUoxwmX7si4p5sQx7GWcQR4WuSL
	 jXbmN2nP9X9Fg==
From: William Breathitt Gray <wbg@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pc104: move PC104 option to drivers/Kconfig
Date: Tue, 22 Jul 2025 00:24:00 +0900
Message-ID: <20250721152402.716262-1-wbg@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721062630.3905668-1-rdunlap@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=617; i=wbg@kernel.org; h=from:subject; bh=u7kadqgEuZg2AIfHSsFUPNGoFSwQ+kvDr9zi4Pzt0jU=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDBl10XlnP57Yv+TPIn/nGY9XHP518Bvn2pV/DrQeMstyS /qUVNk+uaOUhUGMi0FWTJGl1/zs3QeXVDV+vJi/DWYOKxPIEAYuTgGYyIE0RoZbSa3n9lZuOvhK VP1jVuLbZ33Lcp2COXttln75ahm2qlaP4X+cyY2rqtFmj4Ru/WcP3jtf+OM2pqn6sW3rJ27S3zO d7R8LAA==
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, Jul 20, 2025 at 11:26:30PM -0700, Randy Dunlap wrote:
> Put the PC104 kconfig option in drivers/Kconfig along with
> other buses (AMBA, EISA, PCI, CXL, PCCard, & RapidIO).
> This localizes PC104 with option bus kconfig options to make
> it easier to find.
> 
> Fixes: ad90a3de9dd1 ("pc104: Introduce the PC104 Kconfig option")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

This isn't really a bugfix, so it doesn't need a Fixes tag, does it?

Regardless, I think drivers/Kconfig makes sense for this kconfig option,
so here's my Ack.

Acked-by: William Breathitt Gray <wbg@kernel.org>

