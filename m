Return-Path: <linux-kernel+bounces-752568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81BB1774B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF0587151
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302022561C5;
	Thu, 31 Jul 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2xbbct1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BF13A258
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994700; cv=none; b=EN9xexRHm1rPtUHwynv4ITm3fD53+XLC3/0GzVooXboolTPansGb1DjujnbUW2j2sy9JibUgy2ay7bCsFuaR3llvlQPpNq6oHYoKO42rEm8AyE6dCJcRYfjt/mx9U2apW2SuZV/ufJzZb/VqHRsytF78GhYtlImtqKm7g5hwTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994700; c=relaxed/simple;
	bh=7DZFscx/zUQAE+CwN/WvqEagWcG2FAbzwc3W0mBDlNs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sOaeK9a53lQjxtYKUhx8/zp+M59jdhd5qRsAHvPUNT49WnHYIxWH5X/8JJWfScJTk7VdLgPrZNYQiUiuwUKFUV4NTOoQnI+pWXMGDo4UMxfbrASVnOLrSv1j58fnt6fwlkAiQocaUpKNhSl92yokyWsqq9jVUTujI8KObea1kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2xbbct1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08901C4CEEF;
	Thu, 31 Jul 2025 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753994700;
	bh=7DZFscx/zUQAE+CwN/WvqEagWcG2FAbzwc3W0mBDlNs=;
	h=From:Subject:Date:To:Cc:From;
	b=q2xbbct1CyemFNk3e6stq4bft5itNiUSfUeuLmoRmtjiP0oa3ODaxFCkpzczUcptK
	 kiApCmlF0T8vnLWEFy3y8jX6w/T1U1cPCKSyBlJRqaY6kKpcDqwAXxylpryhI42sq0
	 f8829kv3Gk5EKtu2qZCPdhks1PgYqnrRe95f0qhAybIkruZC/0ZMtBN6hFYg/dJc5P
	 ThlSxrPsupjAgW1X52OHaNAac9l2zVSNziDCdjuE3OAOLOERq0HC0HknMAQdMTmagn
	 3NrUnHWIerdhi7wgvOz3o4RN30fcQsLTdlw3Sd2ixu2laIYQwkcThwfqtwjKp8ceVO
	 jB97epkbuVHzg==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] regmap: Fix lockdep warnings for nested regmap-irqs
Date: Thu, 31 Jul 2025 21:38:17 +0100
Message-Id: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADnUi2gC/x3MQQqAIBBA0avErBtQK6SuEi1CJ5tFVmNEIN09a
 fkW/2dIJEwJhiqD0M2J91ig6wrcOsdAyL4YjDKdso1GobDNB7KcGCldHAO2qrfKWa0Xb6CEh9D
 Czz8dp/f9AP9XWoZkAAAA
X-Change-ID: 20250731-regmap-irq-nesting-40970c711fd2
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7DZFscx/zUQAE+CwN/WvqEagWcG2FAbzwc3W0mBDlNs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoi9XIw6PByEh6vhNcQdEzokhF3liVUrW1Q+yGg
 lyxt2pZSH6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaIvVyAAKCRAk1otyXVSH
 0M7LB/9aKDwut+FwzGyBKxgCPlZQKNHj0HD/NEZLC3Xouz/EFZVLQRYpH0TjgALByhnyEJ2NTac
 amvfl+hapdrS3JuNhmRi0r0w5VSgOm7f0CJmUCIowltQhyKZqb9o07Go2ILFBuCU9TicDCThU7e
 BrjkifVYg/sDGzgAcZ0P2drlM1ajGVEyr0aw8U5oJbdLKSwt6RuiG6aNPOmnkKvjuncQpQwnRnM
 XqPa2b5FqLZrPB4MbLhV88T7AocIYnsiIvmQF6JMGvDWNUP4s199h5PvKtBTa61VOkQUTPi0S5N
 RM2DvZdpHkQSjcfUCO95VqLNCREmD/OWJpBKl6bspLm0dt0Z
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Russell King reported that lockdep warns when it sees nested regmap-irq
interrupt controllers since it defaults to using a single lock class for
all mutexes allocated from a single place in the code.  We end up with
both the parent and child regmap-irq locked simultaneously.  The second
patch here uses an explicit lockdep key to disambiguate things for
regmap, the first adds missing mutex cleanup which I noticed while
writing that patch.

I don't have an affected system so this is written blind, I should
really write some KUnit tests for regmap-irq but didn't yet.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      regmap: irq: Free the regmap-irq mutex
      regmap: irq: Avoid lockdep warnings with nested regmap-irq chips

 drivers/base/regmap/regmap-irq.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250731-regmap-irq-nesting-40970c711fd2

Best regards,
--  
Mark Brown <broonie@kernel.org>


