Return-Path: <linux-kernel+bounces-738139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB33B0B4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F11E1890B92
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6101F3FEC;
	Sun, 20 Jul 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKTWR9S4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067311EEA3C;
	Sun, 20 Jul 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008381; cv=none; b=HCmv5clXm2LkESKdhiNq77QMVad2JCIlbn3UDvS9J4qs6+K8BP/8fCL8zlBfKczENI/aq8BMNxhFWDY/iLXMI0R6n/Fc0F6kGzAP/ZcoiAyts0s7BT8U0r2WdxtxpyuCjJOW0JdlEWXePFiTjFueP92CKgh5pl4IGiguZDJ7elg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008381; c=relaxed/simple;
	bh=5mFPOzEa5FrjQ8IgOfWEqNd15g9Y38K4J8UtW6H9pwA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=serJIIqHsxsXvLherdAyaXbyTGjTUMlxAXP6nkS+8748KYmJjJiJ1uJrWaV8Z4DzDkOCesB9aVqDZAZ5sYUfcb0wgWWwHh/v+WBKHqkCWDCyv2VfgzytWdx+PA8GcAgfCbEyWLhyN6/B8PsfDG9p4nApkSDTDg4R6E647/zgXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKTWR9S4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37CEC4CEE7;
	Sun, 20 Jul 2025 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753008380;
	bh=5mFPOzEa5FrjQ8IgOfWEqNd15g9Y38K4J8UtW6H9pwA=;
	h=Date:From:To:Cc:Subject:From;
	b=MKTWR9S4Dt8Y17k7HukH31gDHbSNbXD0XkUFap3ZQ0Av6klqV1RIATCJryLoiCR88
	 XK3TS8I5h3a9GCFp0jBxyLfjyaWETVH97yQTfEZjlSR7vNQxWzcQYaYsfqnkrAWChG
	 dsWybNiYo3b9uRa5gkKaI5oi5p9Iy9LBm1m1MRFU=
Date: Sun, 20 Jul 2025 12:46:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver fixes for 6.16-rc6
Message-ID: <aHzI-b5Kiy_Nu6l-@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.16-rc6

for you to fetch changes up to f2b8ebfb867011ddbefbdf7b04ad62626cbc2afd:

  staging: vchiq_arm: Make vchiq_shutdown never fail (2025-07-16 09:36:50 +0200)

----------------------------------------------------------------
Staging driver fixes for 6.16-rc6

Here are some small driver fixes for the vchiq_arm staging driver:
  - reverts of previous changes that turned out to caused problems.
  - change to prevent a research leak

All of these have been in linux-next this week with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Stefan Wahren (3):
      Revert "staging: vchiq_arm: Improve initial VCHIQ connect"
      Revert "staging: vchiq_arm: Create keep-alive thread during probe"
      staging: vchiq_arm: Make vchiq_shutdown never fail

 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 98 ++++++++++++----------
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  1 -
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |  2 -
 3 files changed, 56 insertions(+), 45 deletions(-)

