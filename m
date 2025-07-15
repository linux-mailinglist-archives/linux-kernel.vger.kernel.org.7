Return-Path: <linux-kernel+bounces-732157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA008B062E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9D917184E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64223BD0B;
	Tue, 15 Jul 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKCjbXG2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C22822D78A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752593119; cv=none; b=b8VfycZpzydhVnvOkdNg7t40d5gTz8Rjx0DBp4NbuoJpao2oGgxVpLx1Ib8ykP5jlDlHf/aZo5ZZApM522/uH87EJVcuC3mlZjV8ydq9ZVXDn27LDu90E/SxcI/SBOGLtT8MTf2J3j9CNrY48F0KKJFSuYS0FwMoZs4A9+LK+hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752593119; c=relaxed/simple;
	bh=mPJyAhsQ1gIInbi/HYGKxy1YLHXpf2GMIaJ0aDNv0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qtGxSNUC4R8Dl3vQUn/5WvVYiV3iTPlOYIvKkgHLl63aN8tQSQnJLYfsdacdIWWOzOzwsphc7s68Ya/DdJ2uqYyZravQ1pzqAiHWPw3fzUfISgsojiwxRwQ0vtgtYCe1mi9mddJAkLVcOu4DkWJ6XGCK7BoECWsSXaZqWJKG1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKCjbXG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D015C4CEE3;
	Tue, 15 Jul 2025 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752593118;
	bh=mPJyAhsQ1gIInbi/HYGKxy1YLHXpf2GMIaJ0aDNv0+s=;
	h=Date:From:To:Cc:Subject:From;
	b=uKCjbXG24My+haaT5pqRewnZwn3FaaQ1A0LtU7wwxQvsVCa1sABdxCTujAYq7WN1q
	 MEu3+n9lIudEKaZnje+tLXAmByowbJYKzE5LyZ/Wa1S0JpFZGV69H73Tpu6bRacwM+
	 ohaRWaMMYBs3JiyahYYBNy7SZBNonRqNWJ0OzKOnqwr1vqLijx862LbXJloUD6q8hB
	 LuJ9Ko8iTJAtZCiHSk28rie9eIfVKA+dPcPkz5vIG/6DJrNomGhZBtNOE6xilhME38
	 nLPlvgSYHhVy2D4UQDYF46Itp35oCSlfc7ahs523DvJ39uTrRKGmGZt+xPdrTbfNz7
	 /hbB2gkU/5SMQ==
Date: Tue, 15 Jul 2025 17:25:14 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <gui63ajjn3vv6yvtvo6xcnejeylzltozxgudy537jbp537lrdu@k2qqwl7cgxcz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025071501

to receive HID subsystem fixes, namely:

=====
- one warning cleanup introduced in the last PR (Andy Shevchenko)
- a nasty syzbot buffer underflow fix co-debugged with Alan Stern
  (Benjamin Tissoires)
=====

Thanks.

----------------------------------------------------------------
Andy Shevchenko (1):
      HID: debug: Remove duplicate entry (BTN_WHEEL)

Benjamin Tissoires (4):
      HID: core: ensure the allocated report buffer can contain the reserved report ID
      HID: core: ensure __hid_request reserves the report ID as the first byte
      HID: core: do not bypass hid_hw_raw_request
      selftests/hid: add a test case for the recent syzbot underflow

 drivers/hid/hid-core.c                          | 19 ++++++++++++++-----
 drivers/hid/hid-debug.c                         |  2 +-
 tools/testing/selftests/hid/tests/test_mouse.py | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 6 deletions(-)


