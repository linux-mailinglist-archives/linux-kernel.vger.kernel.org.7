Return-Path: <linux-kernel+bounces-876184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1575DC1AD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD14F1A24B55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CAD283FE3;
	Wed, 29 Oct 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpdHgLYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC9335BA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744608; cv=none; b=kI4fkPQUJAcZEskIGNcDqWP2wjwV67ML8kcD9gV4FHci9Ws1oLLqhrjAZbhTbjK04dyJn8Ckb9J/AcsqB2IzxYn6yDKfUSKfk1OVNuMN3LWmXNvqXan9x186kxEIPUjpQi/WUl/Ao+CEKsb4sUvZxOjXL8mBcj4wwA1q25242sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744608; c=relaxed/simple;
	bh=a/x3BocHR/s8615Io2F7/Bq1r8QllIsGnZYgJqApHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfNGdYmJNhk03fkZkrTb7e9YkG/u0x3IiYbTcvepQE+4k0yxIXoehE47FPjCnLh13kaCNu/XYysi/ANmaHTL9SBAYyT8a6nRCnf084O29bocA2n8XA497/SoTUYSexL5XyHcR0NuRj2xlIUl9Fr9/N+ISNhlLUf6k4tP+7WFgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpdHgLYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88739C4CEFD;
	Wed, 29 Oct 2025 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761744607;
	bh=a/x3BocHR/s8615Io2F7/Bq1r8QllIsGnZYgJqApHWo=;
	h=From:To:Cc:Subject:Date:From;
	b=fpdHgLYoajX5OwtwyS5gPZcOoAo0Uf8IhS86qIqqyiE3ie0rLuqpm0aP8kQErJPDA
	 mtRTjbbbb1tEnXThQFW+wN3Purj7bVWKgo7So8xk/uNmskggBBIpi03k8n4L+VDXtR
	 HnJXeVcfjha4LRNdWe1sNI2NOEet6a4muaY1LB7lXdGIrADPRHFvktL+7UfDNSR4me
	 6kBht8+xozoLFr9uUTcH2aGfIcMWWuCoPWQIaMVevmKg59AygJ7QOr3mt/dVyiTSjv
	 1Qe04AQmGktZJqV7wkkk0vQL9dIGR6TB1ytxatg/vb0zUZjfbLjAA6T4RutCtQx/6o
	 TOat7o+voSmkw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vE6Fh-000000004WQ-2dI4;
	Wed, 29 Oct 2025 14:30:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe candidates"
Date: Wed, 29 Oct 2025 14:29:22 +0100
Message-ID: <20251029132922.17329-1-johan@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.

Using "%pe" to print errnos is in no way mandated and a driver authors
may chose not to use it, for example, for consistency reasons.

Drop the recently added cocci script that has gotten the build bots to
send warning emails about perfectly valid code and which will likely
only result in churn and inconsistency.

Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 scripts/coccinelle/misc/ptr_err_to_pe.cocci | 34 ---------------------
 1 file changed, 34 deletions(-)
 delete mode 100644 scripts/coccinelle/misc/ptr_err_to_pe.cocci

diff --git a/scripts/coccinelle/misc/ptr_err_to_pe.cocci b/scripts/coccinelle/misc/ptr_err_to_pe.cocci
deleted file mode 100644
index 0494c7709245..000000000000
--- a/scripts/coccinelle/misc/ptr_err_to_pe.cocci
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Use %pe format specifier instead of PTR_ERR() for printing error pointers.
-///
-/// For printing error pointers (i.e., a pointer for which IS_ERR() is true)
-/// %pe will print a symbolic error name (e.g., -EINVAL), opposed to the raw
-/// errno (e.g., -22) produced by PTR_ERR().
-/// It also makes the code cleaner by saving a redundant call to PTR_ERR().
-///
-// Confidence: High
-// Copyright: (C) 2025 NVIDIA CORPORATION & AFFILIATES.
-// URL: https://coccinelle.gitlabpages.inria.fr/website
-// Options: --no-includes --include-headers
-
-virtual context
-virtual org
-virtual report
-
-@r@
-expression ptr;
-constant fmt;
-position p;
-identifier print_func;
-@@
-* print_func(..., fmt, ..., PTR_ERR@p(ptr), ...)
-
-@script:python depends on r && report@
-p << r.p;
-@@
-coccilib.report.print_report(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-
-@script:python depends on r && org@
-p << r.p;
-@@
-coccilib.org.print_todo(p[0], "WARNING: Consider using %pe to print PTR_ERR()")
-- 
2.51.0


