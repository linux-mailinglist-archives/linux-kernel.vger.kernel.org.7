Return-Path: <linux-kernel+bounces-761286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6208B1F73B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 01:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421E189B793
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 23:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4D26AAAA;
	Sat,  9 Aug 2025 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmp9+4xE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAAE1F3FC8;
	Sat,  9 Aug 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754782822; cv=none; b=piiurP6fXIhdCH2emHFQRc7KgbMI/xLHD9tubB8I1cUEjQubiFOAcm7MkPaCO58MFFXvx2uK0u7sWPM4KELUDzQqWLambj6PoaD/OlDDwbfrHrLyYmo+mqAA4dO7Yf/EYK0Q9+eGowOq/dCt5YtmjqQWV92+cPH+4MP3O1lIp0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754782822; c=relaxed/simple;
	bh=0krP812oyw02W1PFcWpcjqMHYTl6SRO9CmN1xtE8Rk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uogk4YmJuJUgkGUeGqObbWT+hUMT3UTjPnLsvFEWXEZt+T176oL6xDH8ROMzSFMHV1MFP1Qu8zThzlKVFw24mj+bRhvTgjy4EcwfwNYNuhFpPZP1feZMxAGph1yicIZsvPHE3/xNP0RkyEtvHjixk0URgeJzeUvI9WsPgcLdlAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmp9+4xE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF65DC4CEE7;
	Sat,  9 Aug 2025 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754782820;
	bh=0krP812oyw02W1PFcWpcjqMHYTl6SRO9CmN1xtE8Rk8=;
	h=From:To:Cc:Subject:Date:From;
	b=bmp9+4xEr2qiiE1XjuY/l91izABP77eVMTv5AQFNVnfKO08VTb4d1EJhhtDCQT4My
	 AksM/RLDoWr16TsS+oBsjZNQEOtaccekFIWenBCZtXFKwRQrReWsevuz3s79Amr7kL
	 CmmzcloRyApHM0HBNwwDjZhJONrJTgjEUJA6n57VR+gGs4wmERCv/Ven4SUxRkrOzs
	 KAyy70L8vg63DnU2RZDu00yT//4zFZXpnP1ijQunsDOOpHPmwvVKfenoMAxFUtRQqb
	 j0D22uYdd0IAZ9GtCSH8x5TjSrej5uKBfUVS0F0s/WKQQh7Ob5QHWaLxEtAjJ4eEj9
	 EZ9Em8u/tsIGA==
From: Sasha Levin <sashal@kernel.org>
To: sashal@kernel.org
Cc: corbet@lwn.net,
	josh@joshtriplett.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: [PATCH v2 0/2] Add unified configuration for coding agents
Date: Sat,  9 Aug 2025 19:40:06 -0400
Message-Id: <20250809234008.1540324-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds unified configuration and documentation for coding
agents working with the Linux kernel codebase. As coding agents become
increasingly common in software development, it's important to establish
clear guidelines for their use in kernel development.

The series consists of two patches:

1. README: restructure with role-based documentation and guidelines
   - Reorganizes README to provide targeted documentation paths for
     different user roles (developers, researchers, security experts,
     maintainers, and AI coding assistants)
   - Adds quick start section and essential documentation links
   - Establishes proper attribution requirements for AI-assisted
     contributions using Assisted-by tags with agent details

2. agents: add unified agent coding assistant configuration
   - Creates configuration files for major coding agents (Claude,
     GitHub Copilot, Cursor, Codeium, Continue, Windsurf, and Gemini)
   - Uses @README references to point all agents to the central
     documentation, ensuring consistency across tools

The agent configuration files now use @README references instead of
symlinks.

Example agent attribution in commits:

    Assisted-by: Claude-claude-3-opus-20240229 checkpatch

This ensures full transparency about agent involvement in code development
while maintaining proper attribution standards.

Sasha Levin (2):
  README: restructure with role-based documentation and guidelines
  agents: add unified agent coding assistant configuration

 .codeium/instructions.md        |   1 +
 .continue/context.md            |   1 +
 .cursorrules                    |   1 +
 .github/copilot-instructions.md |   1 +
 .gitignore                      |  10 ++
 .windsurfrules                  |   1 +
 CLAUDE.md                       |   1 +
 GEMINI.md                       |   1 +
 README                          | 184 ++++++++++++++++++++++++++++++--
 9 files changed, 190 insertions(+), 11 deletions(-)
 create mode 100644 .codeium/instructions.md
 create mode 100644 .continue/context.md
 create mode 100644 .cursorrules
 create mode 100644 .github/copilot-instructions.md
 create mode 100644 .windsurfrules
 create mode 100644 CLAUDE.md
 create mode 100644 GEMINI.md

-- 
2.39.5


