Return-Path: <linux-kernel+bounces-750493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEFB15C64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F02546DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFE26D4F9;
	Wed, 30 Jul 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYyE4w/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB8157E6B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868519; cv=none; b=mumZHoQp6+N+e9viWOu96K1lxYM12dwDcCDu7CvVz93iuURpjkvfCOp4x8E0AczfK90zpD34qqZXOSk/fmstSUZfb5vvkv0pTlwB4us9wwynW9nXDRn2JVardF84arNu7RYeLZjQid6swSgsRLSo4/1q2giGKXifGSrR6/nRtWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868519; c=relaxed/simple;
	bh=3tJZ3ekeSkMhPjWaC86tVr+iXxMIB8+oY/PjTn+yJO0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RolDW7TJiOddcpQ4hbFdpK1yehfagxW6goGcplyvrp/81kV3QRdqLdmvYoLXC8c2xy5Qd8J5+xQIwcTj1tOUCvUFkm9eAdQ+6WMu/vz3i58KzrT9YM+12e5y0Snwyi8KjX4kf3sw2HAN3rm+jl3/w5R95NGGDJlqLkyQnHbo7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYyE4w/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902BCC4CEE7;
	Wed, 30 Jul 2025 09:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753868519;
	bh=3tJZ3ekeSkMhPjWaC86tVr+iXxMIB8+oY/PjTn+yJO0=;
	h=Date:From:To:Cc:Subject:From;
	b=XYyE4w/ef3+TDQInrCMKf5UbHNLQUlV4sPmGjaXglJ1SIjwHChY1FlgiVdO7l1rgh
	 +YKcGYtNeRitF07F5V6/HYa5kyqLCPZP/14/vIf/N3nZyCRmicuHzDqa7E6r2AJ36L
	 rP2TR+e5FIcdU3CP6JHKhFlkkTh0wobpgl5YreXZdOS7fgALCCqQfHmxngugrpDP6G
	 B0UnOADy0Afz167DucAK4I3Gadtpu7k9KzqB49kk/mK8wfvdp07d1iSNwanz08p6AM
	 qa2ka4ydlN7bK52Pbr+lS5OU9yzGhOeHORJCfCcLOc42Td6uyK9l5+kWoJsXJyw8j4
	 v/gT73K6b+hQg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3Jw-000000005yw-2AxD;
	Wed, 30 Jul 2025 11:42:00 +0200
Date: Wed, 30 Jul 2025 11:42:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS update for 6.17-rc1
Message-ID: <aIno6ItXX8F15Vdb@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.17-rc1

for you to fetch changes up to e326371f3002dbf54befd8ada9570fa489a46991:

  dt-bindings: gnss: u-blox: add u-blox,neo-9m compatible (2025-06-24 13:27:48 +0200)

----------------------------------------------------------------
GNSS update for 6.17-rc1

Here is a GNSS update for 6.17-rc1 adding a compatible string for a new
u-blox receiver.

This has been in linux-next for weeks with no reported issues.

----------------------------------------------------------------
Alejandro Enrique (1):
      dt-bindings: gnss: u-blox: add u-blox,neo-9m compatible

 Documentation/devicetree/bindings/gnss/u-blox,neo-6m.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

