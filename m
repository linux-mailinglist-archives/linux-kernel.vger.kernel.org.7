Return-Path: <linux-kernel+bounces-822307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3EB8380F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8810F2A029C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF52ECE8F;
	Thu, 18 Sep 2025 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tcXKsxcj"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD81B423C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183755; cv=none; b=dzGqpvmL15a2a26XBcVA9SrEJdRMnBrq+ftgeY3DovhhHv9uRwufwcmb+qvgNe9sI7SfdOV9d+8sRhJyxEZXKmxvJJe9E1Ga0TkKqfVSDAsYGnrYrd8HCzv1VRjLn0dytOotcX0xTYJqpbpS/r7Z6JW5F3/pUiYn0e4uAb7+yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183755; c=relaxed/simple;
	bh=qlkwNzsofuE7MSMJwaMaRPDvNpxz2VjOr9bqDTuv7kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qskLJj7xrvSx0M2Zv0vad0rD3OT10QZ8eh2RRZ0XSKNPTorQspid+7BDHqBZEaMkivyqGuAScynSDUJ0D8x/lMHLBe/SHnkUG5HuFwCvkBe+fghIyLD3Vr1aZNBU1xypnxiNNRi7YtoJ44QnlZtlR8xsYDeedUi0FTPjcCkPQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tcXKsxcj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Iq4mMU+i+i800xk3CHLuHmJu8rG3VMtn4q43wrwNg6M=; t=1758183753; x=1759393353; 
	b=tcXKsxcjxswKdfEIc0K/Q2IEEVhdas04h6vhMn8yunldwilFu2XqGAOLBvnZfQu5+ymeMqk6ZJb
	EICBzicvZnnQoxFzeHc+RSDOXtcEG88/KBYCr7S5CwhPZGybiPJbtFVLLwPtFzYN4STBTv18vkAEW
	tIcFiHWd6//eInMwSpj751+eMmZSa4Di+vvI4ce5zUgZpTjdYBbdWedh1pdIXz9lSFhvj7btt7BsU
	Zu+19qMibRWPA6yQ4sn92DiI3gcHkcNx7b+KIvAnjHWagjU0/2vyPVdoGcV3yCIgGoZm8hBPPMmrv
	pECoUu83WdXLF7duVdHj0HNaRWmDCm2adEog==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uz9uJ-0000000D8og-3mcZ;
	Thu, 18 Sep 2025 10:22:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml-for-6.17-rc7
Date: Thu, 18 Sep 2025 10:20:47 +0200
Message-ID: <20250918082219.6652-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

So we still have a couple of fixes for ARCH=um, which I'd
meant to send earlier but then forgot. All of them are
pretty long-standing issues that are either not really
happening (the UAF), in rarely used code (the FD buffer
issue), or an issue only for some host configurations
(the executable stack.)

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-6.17-rc7

for you to fetch changes up to df447a3b4a4b961c9979b4b3ffb74317394b9b40:

  um: Fix FD copy size in os_rcv_fd_msg() (2025-09-10 14:24:19 +0200)

----------------------------------------------------------------
A few fixes for UML:
 * mark stack not executable to work on
   more modern systems with selinux
 * fix use-after-free in a virtio error path
 * fix stack buffer overflow in external
   unix socket FD receive function

----------------------------------------------------------------
Miaoqian Lin (1):
      um: virtio_uml: Fix use-after-free after put_device in probe

Richard Weinberger (1):
      um: Don't mark stack executable

Tiwei Bie (1):
      um: Fix FD copy size in os_rcv_fd_msg()

 arch/um/drivers/virtio_uml.c | 6 ++++--
 arch/um/os-Linux/file.c      | 2 +-
 arch/um/os-Linux/util.c      | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

