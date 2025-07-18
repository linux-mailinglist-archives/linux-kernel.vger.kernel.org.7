Return-Path: <linux-kernel+bounces-737333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C3B0AB0C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB1D5A841F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F61D21CA02;
	Fri, 18 Jul 2025 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ab0elrW2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820002135D7
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870029; cv=none; b=u2vy5ipb2DUzc0GaBRK0mOdueWACNI55spx5H2xGzJ7Mlj1LjR+4J+75x2H7w+JhdWcYvaTmSqwghcTnOrbJ7/M2U5KBjD2eIDJkEz58JvVpGs/Yw3BECvm5c/qWjLeLTP8gVZvN78UPX4Fd+ZmbqiMsvT6KI9IRihdRP72vy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870029; c=relaxed/simple;
	bh=uIvcpKAUW1KWJdXr3GIVE8N8SD9FFqOSC6+Rmejq/7g=;
	h=Message-ID:Date:From:To:Cc:Subject; b=DWYLJWdI0WADmo6rQxT49HuJdC4fm6NSa/z7jDczPxW0q11zWHjj1CeEu3h+VpZmX3MW3YsuzMDVXL4h2n1+tPoj1Z51p0bC+sqwHVvUfE9a9N5Au/FXhr5cxFKCHyCqlp6oPETDC1Co4TpyBtx+TAtTOJAKgjnV2oen6iaHlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ab0elrW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6F0C4CEEB;
	Fri, 18 Jul 2025 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752870029;
	bh=uIvcpKAUW1KWJdXr3GIVE8N8SD9FFqOSC6+Rmejq/7g=;
	h=Date:From:To:Cc:Subject:From;
	b=Ab0elrW22n5CV9rOwMGSXlsIZj0KpzM6b7sk/7NMx8VK2EV/v9w7hy/u0jv7lGoVR
	 NnpqO/DpQaYY7edEK9L1SYr+MfxhrL0uf1+ugWInBBu596wJ3YP+T4wmMuxX9tBw8M
	 1AqMo6AT87ZJsp2U/aVUhhTJxcNjnDXLXiZBjxcWdrlRi5FoCSKSeXThXc//HmA3Wc
	 MllBtZNhmtIi2Mw0W7Y94zyNK/T1JfkqyaR4e4CcdheG0WBnow+6aR9KSGTQgDbtwe
	 oqTEmLeTp93/dFBKP90EIeULckM/l+kd2klFW7u05RbGk49aM/kqvL9QChd3pwGmNu
	 i+/jyNWLk/pJA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ucrZd-00000007Qc6-0qpl;
	Fri, 18 Jul 2025 16:20:53 -0400
Message-ID: <20250718201840.714067501@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 18 Jul 2025 16:18:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
 Dhaval Giani <dhaval.giani@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH 0/5] ktest.pl: Enhancements for 6.17
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Some ktest.pl improvements:

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

Steven Rostedt (5):
      ktest.pl: Add -D option to override options
      ktest.pl: Allow command option -D to override temp variables
      ktest.pl: Have -D option work without a space
      ktest.pl: Prevent recursion of default variable options
      ktest.pl: Always display BUILD_DIR and OUTPUT_DIR at the start of tests

----
 tools/testing/ktest/ktest.pl | 83 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

