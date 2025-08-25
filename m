Return-Path: <linux-kernel+bounces-785531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F86B34C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6566A1885FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A662797A1;
	Mon, 25 Aug 2025 20:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR/amotK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E35393DE3;
	Mon, 25 Aug 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154122; cv=none; b=gKv75vW+gtCEZOd22XhKJzXrzDGRunAGPSn5+K0y/Y6f05UJrG8FLNKIXXNZTCJKV5jktxwwwHfyBaudUGjbZWdk0xGozMsaiXyhJMNRxSitjKDMUnaD1cdhHJc9kGSVfhoLY3DDQLKZd9Zt1v1PCfJ14g9xf8HIA6gXHg2xprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154122; c=relaxed/simple;
	bh=clQ4TqAaJ6PNsNurlmZNN4F3pMdqHfa3TBczUU59oZk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hfQnZGShC/rlfnQUW8ozot1oUpC3+DT0+OOqhnFA9+IPR79mfCfjegC6YGT+7FsUvvZi7k40uJXlk9he2SUfL72pTp3oDumq7Hje6SyoIsJkNU7s6g0rcKjdxVVsUR2+au0TlefqEBji67KLvZvDpJkbSSEzQJ5bLIBzp4v/R5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR/amotK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83DAC4CEED;
	Mon, 25 Aug 2025 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756154122;
	bh=clQ4TqAaJ6PNsNurlmZNN4F3pMdqHfa3TBczUU59oZk=;
	h=Date:From:To:Cc:Subject:From;
	b=GR/amotK0t3sP/rZqjpwAvK1i2q+LZ+ibBvGkLthScohw+oyDyq5dTEHb6FPDIt7z
	 vTa2JWGKriwhRVIKWkEJsRbdQBSyFO9/vyifhr8ffZOjXxlUY/5W3pipIzgF8D6o+u
	 hwSlW6YHXs8ROT+qImU8JijRLSygxSaSGKKGmk9SM8uLqLkIib3fhZXZpaxU7m4PiT
	 VuNYoBqaQS8mIe3QNZ0Z75ys/uUBI1j0Eh6C0Ozn0rI7tGGh5EHeXLKPbK2tflE5h1
	 x2nM3jf0U54lQOKd1q3QPs+91xc1DQzK6+WXHYbwNYbAalqFMmM/N7TWGRXRsRDXfm
	 Uia3d9x6QHfcQ==
Date: Mon, 25 Aug 2025 15:35:21 -0500
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.17, part 1
Message-ID: <20250825203521.GA399593-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull DT fixes for 6.17.

Rob


The following changes since commit 0121898ec05fa4c1f566fc05c7e8b3caf0998f97:

  dt-bindings: Correct indentation and style in DTS example (2025-07-28 19:56:29 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.17-1

for you to fetch changes up to 80af3745ca465c6c47e833c1902004a7fa944f37:

  of: dynamic: Fix use after free in of_changeset_add_prop_helper() (2025-08-22 16:21:35 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.17, part 1:

- Fix a memory leak for of_pci_add_properties() failure case. Then fix
  the introduced UAF.

- Add missing IORESOURCE_MEM flag on of_reserved_mem_region_to_resource()

- Add already in use vendor prefix "eswin"

- Clarify "of of" comment in of_match_device(). After many years of
  drive-by patches dropping the 2nd "of" (which referred to
  OpenFirmware), a correct patch finally arrived.

----------------------------------------------------------------
Bagas Sanjaya (1):
      of: Clarify OF device context in of_match_device() comment

Dan Carpenter (1):
      of: dynamic: Fix use after free in of_changeset_add_prop_helper()

Lizhi Hou (1):
      of: dynamic: Fix memleak when of_pci_add_properties() failed

Pritesh Patel (1):
      dt-bindings: vendor-prefixes: add eswin

Rob Herring (Arm) (1):
      of: reserved_mem: Add missing IORESOURCE_MEM flag on resources

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 drivers/of/device.c                                    | 4 ++--
 drivers/of/dynamic.c                                   | 9 +++++++--
 drivers/of/of_reserved_mem.c                           | 1 +
 4 files changed, 12 insertions(+), 4 deletions(-)

