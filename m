Return-Path: <linux-kernel+bounces-739849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA935B0CC04
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77200546936
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 20:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC6123C8C9;
	Mon, 21 Jul 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/cdWwoY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFF4155CB3
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130252; cv=none; b=tlgcFipzTRmEZIQtZlJAgMLqEwZGmrTNn2dGCqPNlUDKl142ydcFVkcgxFkLJgMmF29jwjd0JssEsg4b+nOV8BWBHKrjiMD/B0l1MLXwkgOedIoXbpnZI8DZhhH1rbaSQF6lwFeYk/0jvWMEiFnEzeyQEVFhpx2lbbohKJcQlBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130252; c=relaxed/simple;
	bh=Z1gP8TWJmUoOc+E4J5MIPck8JZYfl0EE0ttwuQyHXoA=;
	h=Message-ID:Date:From:To:Cc:Subject; b=SS+z69UFwPwXFwgfQrX18+HQRqmjv+WyG4N4kmMoEUUo1BQBJ2aZFyhmKJCw4vxyUSF8eg1ej/mDSDSlxMJoKTlwCbVCK3LNaXmw4tiZabkWrAqpLYLXj/xbv9gBY7ury0bp5kFzsRFCW8i//qeCPclpVskhmCdhOaDdwQ0YlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/cdWwoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DB9C4CEED;
	Mon, 21 Jul 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753130252;
	bh=Z1gP8TWJmUoOc+E4J5MIPck8JZYfl0EE0ttwuQyHXoA=;
	h=Date:From:To:Cc:Subject:From;
	b=M/cdWwoYamy2xXJZPYZlNl47wK6iNcuofFkiA0/X3m166/j6v4x2P461qzpTH0EsK
	 HmYL/m17MVbvlOnynjjXk5pXDytInoYZxn6Eop7Y6pC6q/p3U2O5mA8HqGIeu02BOG
	 oIrOzIVeEyxvM2Ef/w5SwEBppEVYk5kez7FCIuNX4kL8PxEBMtcj/8gU+w4XbvDqHK
	 m2s2yl/VS4NtYaIYRRZK2IVRtn/wsWKy9q9UG4xCfBV/Iac/czL8Mfk72ACd6eR9ud
	 vRqsY4NvA9iGC9lPuS0pogVwOoiC9rGwI3q8Z1f/jL1IcoMyg+J+lxx7oTOzwq/pMY
	 tbm26/3K7VeUQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udxGt-00000009p33-0wZC;
	Mon, 21 Jul 2025 16:38:03 -0400
Message-ID: <20250721203739.462938756@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 16:37:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/5] ktest.pl: Updatse for v6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


ktest.pl updates for v6.17:

- Add new -D option that allows to override variables and options

  For example:

    ./ktest.pl -DPATCH_START:=HEAD~1 -DOUTPUT_DIR=/work/build/urgent config

  The above sets the variable "PATCH_START" to HEAD~1 and the OUTPUT_DIR
  option to "/work/build/urgent".

  This is useful because currently the only way to make a slight change to a
  config file is by modifying that config file. For one time changes, this
  can be annoying. Having a way to do a one time override from the command
  line simplifies the workflow.

  Temp variables (PATCH_START) will override every temp variable in the
  config file,  whereas options will act like a normal OVERRIDE option and
  will only affect the session they define.

     -DBUILD_OUTPUT=/work/git/linux.git

  Replaces the default BUILD_OUTPUT option.

     '-DBUILD_OUTPUT[2]=/work/git/linux.git'

  Only replaces the BUILD_OUTPUT variable for test #2.

- If an option contains itself, just drop it instead of going into an
  infinite loop and failing to parse (it doesn't crash, it detects the
  recursion after 100 iterations anyway).

  Some configs may define a variable with the same name as the option:

     ADD_CONFIG := $(ADD_CONFIG)

  But if the option doesn't exist, it the above will fail to parse. In these
  cases, just ignore evaluating the option inside the definition of another
  option if it has the same name.

- Display the BUILD_DIR and OUTPUT_DIR options at the start of every test

  It is useful to know which kernel source and what destination a test is
  using when it starts, in case a mistake is made. This makes it easier to
  abort the test if the wrong source or destination is being used instead of
  waiting until the test completes.


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 23a2d4c64e713b5645e3af8fc9da0931600ba85c


Steven Rostedt (5):
      ktest.pl: Add -D option to override options
      ktest.pl: Allow command option -D to override temp variables
      ktest.pl: Have -D option work without a space
      ktest.pl: Prevent recursion of default variable options
      ktest.pl: Always display BUILD_DIR and OUTPUT_DIR at the start of tests

----
 tools/testing/ktest/ktest.pl | 83 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

