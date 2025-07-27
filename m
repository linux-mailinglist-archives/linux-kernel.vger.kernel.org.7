Return-Path: <linux-kernel+bounces-747257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CEB1319C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356E8160B92
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75622A4F4;
	Sun, 27 Jul 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzRupWNK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301B1A2643;
	Sun, 27 Jul 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646298; cv=none; b=BXtQqgsud8ReYfgbKtAcvc8CiDSPnuYc3vH9T3wNtccRC2+pq643Omqw/2UgxThk7BlkPasY8ZJcNOgnN5DWmMgAwVJXyE8e7owPEd7vsA6Qm+5Gw3FUk4RWOC5riCYSbZiHKISqLLNoN9Q2h6KRzLF8jtmi//MqwzWeDowgcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646298; c=relaxed/simple;
	bh=WaGOigLlcybWzA2W2kYUu0sGcXX4U2ZEgX+oVOLjV9U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O4jhvCYly9fHADnz3XK4JXaiBWdT/ZoPSrAWYuhjZww3NMZP4Vo1ulSOa7GDxNBudboaXC+/NcWArnwrIXropxSl6v6QYCHh1+ooH+PU1wb9EkHxKNHDptc1kyg8D46+IQ8FP/7EqP7tkkb4Ol/ADnaCy+mFrAM6zSFNpnzGhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzRupWNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F20C4CEEB;
	Sun, 27 Jul 2025 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646297;
	bh=WaGOigLlcybWzA2W2kYUu0sGcXX4U2ZEgX+oVOLjV9U=;
	h=From:To:Cc:Subject:Date:From;
	b=qzRupWNKceaqQVDurrnLl7lY/Xz+a9oT4Zx2QLLNN1Gat06XvfoYEnSCyzwvgETCN
	 v5z5jbYvPdf+6ZIsLlbIKL48aJWNhScZRUI5yqCmdRp6VJWqWgwtq6PlWW3tODYB7r
	 vxjyD2N2s0DZyo6nVkXBsMs01pWRlsZqRNDPXcultstBY86/pftKlhDWNrYVwtV3cF
	 Y1tQzUNULuQRexd6GM94eHuwGqKO1J7FJJDqVolhOuMOrFptpQ3dVKnnQZGkdQGYku
	 vo7IoIe1KoCQV/uJIoBB3A2//ZQ72B43ZigVPCiUcYv0bW9nLcoHmx3sTdpcQ9hWIp
	 h/g+3JS4nKOpg==
From: Sasha Levin <sashal@kernel.org>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: sashal@kernel.org,
	josh@joshtriplett.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: [PATCH 0/4] Add agent coding assistant configuration to Linux kernel
Date: Sun, 27 Jul 2025 15:57:58 -0400
Message-Id: <20250727195802.2222764-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds unified configuration and documentation for coding
agents working with the Linux kernel codebase. As coding agents
become increasingly common in software development, it's important to
establish clear guidelines for their use in kernel development.

The series consists of four patches:

1. The first patch adds unified configuration files for various coding
agents (Claude, GitHub Copilot, Cursor, Codeium, Continue,
Windsurf, and Aider). These are all symlinked to a central documentation
file to ensure consistency across tools.

2. The second patch adds core development references that guide
agents to essential kernel development documentation including how
to do kernel development, submitting patches, and the submission
checklist.

3. The third patch adds coding style documentation and explicit rules
that agents must follow, including the 80 character line limit
and no trailing whitespace requirements.

4. The fourth patch adds legal requirements and agent attribution
guidelines. All agents are required to identify themselves in
commits using Co-developed-by tags, ensuring full transparency about
agent involvement in code development.

Example agent attribution in commits:

    Co-developed-by: Claude claude-opus-4-20250514


Changes since RFC:
- Switch from markdown to RST
- Break up into multiple files
- Simplify instructions (we can always bikeshed those later)
- AI => Agents

Sasha Levin (4):
  agents: add unified agent coding assistant configuration
  agents: add core development references
  agents: add coding style documentation and rules
  agents: add legal requirements and agent attribution guidelines

 .aider.conf.yml                       |  1 +
 .codeium/instructions.md              |  1 +
 .continue/context.md                  |  1 +
 .cursorrules                          |  1 +
 .github/copilot-instructions.md       |  1 +
 .windsurfrules                        |  1 +
 CLAUDE.md                             |  1 +
 Documentation/agents/coding-style.rst | 35 ++++++++++++++++++++++
 Documentation/agents/core.rst         | 28 ++++++++++++++++++
 Documentation/agents/index.rst        | 13 +++++++++
 Documentation/agents/legal.rst        | 42 +++++++++++++++++++++++++++
 Documentation/agents/main.rst         | 22 ++++++++++++++
 12 files changed, 147 insertions(+)
 create mode 120000 .aider.conf.yml
 create mode 120000 .codeium/instructions.md
 create mode 120000 .continue/context.md
 create mode 120000 .cursorrules
 create mode 120000 .github/copilot-instructions.md
 create mode 120000 .windsurfrules
 create mode 120000 CLAUDE.md
 create mode 100644 Documentation/agents/coding-style.rst
 create mode 100644 Documentation/agents/core.rst
 create mode 100644 Documentation/agents/index.rst
 create mode 100644 Documentation/agents/legal.rst
 create mode 100644 Documentation/agents/main.rst

-- 
2.39.5


