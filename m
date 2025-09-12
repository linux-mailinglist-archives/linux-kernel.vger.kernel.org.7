Return-Path: <linux-kernel+bounces-814088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F29FB54F08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097607C565B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DE30DEBC;
	Fri, 12 Sep 2025 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXKD3EoA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736D30E852
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682859; cv=none; b=pWmuXvP+DKAHkHa+CdVaoNq4aJfYPydw7q/Wc0j1kQZssu+Bch50rTOZCLI4qCDJiLLCz02tOeJI9g9ZbQw7gTMd+HZgMpcDlzEwwDD7uz9zIg5YkT/mZN28yoODUYPfuovXb9galNqVDuwaDU35L+BWAFv3TTajfR+Rsa4n9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682859; c=relaxed/simple;
	bh=evlpQzRLcxJYz7A4vHQ6cL7wOcbGjnT2zO6lvyTzayw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sxZr80yU6KB6utgwWM/XeiPZgYqZ+avMzaQ5D5jxhHxIwYrYorpGgtD8AsMD0VW+VC/eQkE+J20Q1DSS9IAKjb2gbsbJ6slfQxImp8A94JCTCWhumCQ+7tYpgQbjqEVCyaJeY1SPo+lvyYhm+RKgSwVTb7h6Y3/TCaL/iu8PCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXKD3EoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5724C4CEF4;
	Fri, 12 Sep 2025 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757682859;
	bh=evlpQzRLcxJYz7A4vHQ6cL7wOcbGjnT2zO6lvyTzayw=;
	h=From:To:Cc:Subject:Date:From;
	b=RXKD3EoA/jw9e4AiWt895FwnCGVafUUptYdxExGu1nzdvFkrXggGwppXqT7t9y1EF
	 WY/rJJG/jl5ia4ZolmTlspgI6wLukGqGbnrtaFdH2jCMHXN45dcFGtR6Yn53qbj2pm
	 ESSIUOenBb3uzcP8+KkM6i9Viz6U5Te1SR1UNsGgPhGm1fNGqyjmrIYmsIUo9rBW7r
	 EXHv6vduR1YLIITa/9jkrf4ibRPVVkxwlBTKlb3kuwVHtLsd/OlJM26HQVZWoMLoJn
	 p9u+6SCjZCNyD7a6wdJiw0WktWti4KMbL6v71DPcn84EzTpc3jv93iWVoNs/nbYwcK
	 m9STvRWmouF1Q==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 0/5] nvmem: patches for 6.18
Date: Fri, 12 Sep 2025 14:14:10 +0100
Message-ID: <20250912131415.303407-1-srini@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srini@kernel.org>

Hi Greg,

Here are few nvmem patches for 6.18, Could you please queue
these for 6.18.

Patches include
	- new Airoha AN8855 nvmem provider
	- new nxp S32G OCOTP nvmem provider
	- new dt binding for sa67mcu
Thanks,
Srini

Christian Marangi (2):
  dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
  nvmem: an8855: Add support for Airoha AN8855 Switch EFUSE

Ciprian Costea (2):
  dt-bindings: nvmem: Add the nxp,s32g-ocotp yaml file
  nvmem: s32g-ocotp: Add driver for S32G OCOTP

Michael Walle (1):
  dt-bindings: nvmem: sl28cpld: add sa67mcu compatible

 .../bindings/nvmem/airoha,an8855-efuse.yaml   | 123 ++++++++++++++++++
 .../nvmem/layouts/kontron,sl28-vpd.yaml       |   7 +-
 .../bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml  |  45 +++++++
 drivers/nvmem/Kconfig                         |  21 +++
 drivers/nvmem/Makefile                        |   4 +
 drivers/nvmem/an8855-efuse.c                  |  68 ++++++++++
 drivers/nvmem/s32g-ocotp-nvmem.c              | 100 ++++++++++++++
 7 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nxp,s32g-ocotp-nvmem.yaml
 create mode 100644 drivers/nvmem/an8855-efuse.c
 create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c

-- 
2.50.0


