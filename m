Return-Path: <linux-kernel+bounces-815117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C5BB55FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 11:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578AAA6573
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916D12EA464;
	Sat, 13 Sep 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S83XC4X4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E51191484;
	Sat, 13 Sep 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757757463; cv=none; b=nUb1duB1eGofE0vszBvL5W5/xb7tlFNsKWFY4dphq4lou1COK8iB1orRRNjk/uYumEednGQifo4D6gL96KY+Wc9ZhgdgtOGaSTjogbP1UvdOtZQjd7EWm90bHDF0SCuDyzsaktbqe3pc+S0LJnxIFGkKX13IPytWt126s4AaHco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757757463; c=relaxed/simple;
	bh=yza7JFGaX9vBRQZcuOq48cK+gvm5yc1dgw+LqxHe4fQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From; b=SNHChLWxtuMdRj6SiJXs2GVsKrYTq3y7dmvDa50WNW5k3peYcvAXTvVqLnkl8rGuSWmBiwufRPTHeemOJQCiqeR1hBwyf8JkBAKn/9gtpHK97NBCstvux0PvHEOB78P21ovaGjVw99tvnpYbPSFLSM5mFqdrYCxtgu0WWbO43z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S83XC4X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9A4C4CEEB;
	Sat, 13 Sep 2025 09:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757757462;
	bh=yza7JFGaX9vBRQZcuOq48cK+gvm5yc1dgw+LqxHe4fQ=;
	h=Date:Subject:Cc:To:From:From;
	b=S83XC4X4UOfztUS3ItOguOMcrsjk6tmbTLVGzWrbPW/I5FvNUNAzLf6oR/ScKZ9sm
	 E4ICBZ861QopSC2Vz9cli+NUAYVhnJakwg2bcG/KNrGRKzAQXoc4hLkTvOWV/wpdru
	 1PIUmVunKuoMG8D4JrpL8ytAz7S19PA1vsDm+mi4yhMpZvs13D/o/SgFjmUltr6BjO
	 T1nfD1S8U9FJdtNUQhYmdYm9ysIB8aCXQMRXUddVg75o+NQDxDy9qDelxQEFkAZhMC
	 B2FloCCvjESbHqVkVOAPT/Mlvob/cBO5bi043+9MwwJkWsN4Dw/Q+OXDJ43GUzApsQ
	 RT3/7FiP0cKhg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Sep 2025 11:57:38 +0200
Message-Id: <DCRL0KY7TS19.3SDABYFHZWQ7T@kernel.org>
Subject: [GIT PULL] Driver core fixes for 6.17-rc6
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.20.1

Hi Linus,

Please pull these driver-core fixes.

All commits have been in linux-next for a couple rounds; no conflicts expec=
ted.

- Danilo

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00=
:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
 tags/driver-core-6.17-rc6

for you to fetch changes up to f6d2900f2806d584303db689d9e18f0443610514:

  MAINTAINERS: Update the DMA Rust entry (2025-09-11 22:09:22 +0200)

----------------------------------------------------------------
Driver core fixes for 6.17-rc6

  - Fix UAF in cgroup pressure polling by using kernfs_get_active_of()
    to prevent operations on released file descriptors.

  - Fix unresolved intra-doc link in the documentation of struct Device
    when CONFIG_DRM !=3D y.

  - Update the DMA Rust MAINTAINERS entry.

----------------------------------------------------------------
Chen Ridong (1):
      kernfs: Fix UAF in polling when open file is released

Danilo Krummrich (2):
      rust: device: fix unresolved link to drm::Device
      MAINTAINERS: Update the DMA Rust entry

 MAINTAINERS           |  4 ++--
 fs/kernfs/file.c      | 58 ++++++++++++++++++++++++++++++++++++++---------=
-----------
 rust/kernel/device.rs |  5 +++--
 3 files changed, 43 insertions(+), 24 deletions(-)

