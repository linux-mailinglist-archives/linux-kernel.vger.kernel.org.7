Return-Path: <linux-kernel+bounces-869285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 824DCC07869
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E00714EBBE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB2A343D66;
	Fri, 24 Oct 2025 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHtYB4I7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E231B806;
	Fri, 24 Oct 2025 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326553; cv=none; b=ICjVGEH2vTCe0ApjvnYBMxXUtIT+OpgzZJdXPnZeKqzQZ67mYRFya3gr5vJxWRF41x+ftvF1HjxSOWYBvekmMPGNUG3ldXO68rlI6A9A3dSzNjXAyLPoRTRhcB7uWhEy5ECfEuDycOacvGGDnLvUMnJ9WuLCCaYIgVEeJK3COEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326553; c=relaxed/simple;
	bh=Vh52TZEVUBZCxdmc3LVnwmhW9v+l2db+3dQn43dH5EM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KrzaXhlzABFhFc6sd3rzIwVVkcCxZb3pdu5x0oR5S3PzvQuBrV6zdHssQAlyFuMLytGbooR97iZWOOZFJNZUrIb8JrTgV5lM5vKqAXo44kFUtprHU7Eu8ulFDaNfVorPtfKkyV04umauwCQvRTaxt6mvhpauZRYhLzTntdamuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHtYB4I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E18AC4CEF7;
	Fri, 24 Oct 2025 17:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326551;
	bh=Vh52TZEVUBZCxdmc3LVnwmhW9v+l2db+3dQn43dH5EM=;
	h=Date:From:To:Cc:Subject:From;
	b=WHtYB4I7Oo+EG4UgcU6KxrihbksDEonFGWm9HomHPGSuO48qN2EFZ/lu4pbyzrkWM
	 UFizHlXhHAa0J3ASmrEMDGkIROHs/NBRMOEg+hTYDUzH3nUe1fanz7f5kDaZ5YsEOW
	 +N9bFZvpNYR/SPPWH9TWZz7JyUBhV4HFBmAk5LU6hEpRTPsOYWy69G+v8njRHFnPx9
	 gX3LijJsuMpr5izB3fa9ODN1I9SBIKMYirSkRHVi40ZnuAJdLJ6UADcdMudeVJV02A
	 q3uajvNSpgqBUAtYr4vBiMoQCF0Vv0Fq7z9Ju2dfJbcd+kTJSgleGEpXvaXu5gdlbw
	 JW0t83461HMIQ==
Date: Fri, 24 Oct 2025 12:22:29 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.18, part 2
Message-ID: <20251024172229.GA2130411-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull another set of DT fixes for 6.18. These are also 
dependencies Thomas is pulling in for the further refactoring in 6.19.

Rob


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.18-2

for you to fetch changes up to 7209ff310083315386570bf8d001a0845fe7ab8c:

  of/irq: Export of_msi_xlate() for module usage (2025-10-24 07:44:09 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.18, part 2:

- Fix handling of GICv5 ITS MSI properties on platforms with
  'msi-parent' as well as a of_node refcounting fix. This is also
  preparation for further refactoring in 6.19 to use common DT parsing
  of MSI properties.

----------------------------------------------------------------
Lorenzo Pieralisi (3):
      of/irq: Add msi-parent check to of_msi_xlate()
      of/irq: Fix OF node refcount in of_msi_get_domain()
      of/irq: Export of_msi_xlate() for module usage

 drivers/of/irq.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

