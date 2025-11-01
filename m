Return-Path: <linux-kernel+bounces-881590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEC7C28835
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 23:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321DC188F36C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 22:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06046274B3C;
	Sat,  1 Nov 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="T4RQRs7R"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BD78F4A
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762036297; cv=none; b=VIfFd0rmdwLBocEjJPe9FK6kJxfpWa1MyIEGgOvx7mlh+OGPKqARjYQ4aalufclCyL4rdDiNxGFrOZeiTff3wAnC6mGMm8bLKhmLhnaBHqNq9ZS6KtOybVpB/B9mwDUCtwTGe2dcpJz55VX+98oXWmDUxFxfZiHhnQ+uUPLBOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762036297; c=relaxed/simple;
	bh=JqArab//VtjVTAuZADI3rtalHlSOh2zYSvZup8Qb328=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uMJ+6HFENfYz23WBU2MNF9TLsxpD7vwzWDEMusHjZsEdrAjapaaYpS2Xcov6zlAzvM+4Bd+SMCCsFBwYeiLa9KWOiEdg8nn/xLNQPg5PO3JtwVd7Ybj/pXxLZ8qDXrCztzoPACyl+dvWKRp+P/ov35armBfbAzRK2/uiUCPLG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=T4RQRs7R; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1762036286; x=1762295486;
	bh=JqArab//VtjVTAuZADI3rtalHlSOh2zYSvZup8Qb328=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T4RQRs7R9UhpKAd9pi+kL4gwYCzU5y3djHNT1aDcRBbpt7tDrX0Alxn5Xh1GuhCoj
	 LjUHTjLhG6dFnFkHVXX2jPiWIzeeGxc94JrlcbpLgY8OVM2v+SYK0Qn0AiGieDbys/
	 44sAmcC0Zm/KlF59w0epCJ1yX4prfVCW/R9h3tOnNKJO1UKVxkzOROfO0lmmHmRWxL
	 C2bvsFSZ/QPmWX/gmWc6ZFsW5xBhvnOxsYO/ipDPTHdxT87OeqUlON7Fu9CgrdSst1
	 ijGyuJvjZfCaY7uPpGl6+QTyWdeZeEfHH0vw6cQDThxCKDXUrqU8hnUMOs1RwMwXbS
	 0cFTbhJljhLiw==
Date: Sat, 01 Nov 2025 22:31:19 +0000
To: corbet@lwn.net
From: Gabriele Ricciardi <gricciardi-coding@pm.me>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Gabriele Ricciardi <gricciardi-coding@pm.me>
Subject: [PATCH] coding-style: fix verb typo
Message-ID: <20251101223027.171874-1-gricciardi-coding@pm.me>
Feedback-ID: 114464819:user:proton
X-Pm-Message-ID: deac9e48a8ef2c74c4177133565786595b6dcd84
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In the Identation section there is a list of instructions in
second-person. The offending line uses third-person singular.

Signed-off-by: Gabriele Ricciardi <gricciardi-coding@pm.me>
---
 Documentation/process/coding-style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process=
/coding-style.rst
index d1a8e5465ed9..2969ca378dbb 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -76,7 +76,7 @@ Don't use commas to avoid using braces:
 =09if (condition)
 =09=09do_this(), do_that();
=20
-Always uses braces for multiple statements:
+Always use braces for multiple statements:
=20
 .. code-block:: c
=20
--=20
2.51.2



