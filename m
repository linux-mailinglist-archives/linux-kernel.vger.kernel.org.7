Return-Path: <linux-kernel+bounces-744788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E90B110F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F825473BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32218274641;
	Thu, 24 Jul 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="spehQoRQ"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECF42046A9;
	Thu, 24 Jul 2025 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382116; cv=none; b=UFnn83r/mSE7u3lLQl5TVt0OTHam0/ZGdgLJYIJ1DpojSCqRg1hMLjjcXvpijfZyuiNDHMSaxSPxdrNOSiXca0x0iQkajHFNeajqsGbjEIRqo8L4WxFbHc0NZN+QK7CwJyR2BuW2SCumJMdu4G2B2Oe+HP+6rcY55YHxe6l3Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382116; c=relaxed/simple;
	bh=W9hkjzccOnVAZbWP1c+X2W/iThluSDYSy+K8OZ7abTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVEy5Cq4XZARkLU5BKYjaqPZf/d9Ej3XosOdj4gcVy+clIJ9f/I+zpxv1PnEc5Qjnj00NMwn0eZcTmxM/glHKZ7SmTiPKeUBCJtkhD7DcC7Oe22bwxVzpY+dznrU58/AqfSxG8Ev/Hmvm9vsuJo0gJqY2kh/qoEaCfsq+6FNfQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=spehQoRQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=BVHyitu7M+F0TPTtzd7aKLVpgpqZGJKtVE29W1kDdRs=; b=spehQoRQuNxAvCkN
	OWaZWG7uqMmimZuGci7ZIkinfagFbI4O5h5foeHavDQIg/gYXJ4SHek836EjAfUf9IlId2ItwCCCJ
	8iLyYX9GspeoFq69xDxESajU6l6xTSVf5AUZmYF8KBy6ZwY2XvC1za9dkF2/oMfc6dMmpeEmnqixo
	9EABtQY6FV+XEx15tro1oj4bGfQtYyNAqqB6XaDYFz17MKvTmi7+LDvy755aYfPDlXV/mqSynU5qH
	IMig4zewqX9DU4XizD9++42Orz1tiPyFLCa+UZJ7Foz1mPF3VBgXYf0xFL+mR555O70r9mM9En2m1
	r5CLsqbC7Q1oRGqP+g==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uf09Q-000T3o-1i;
	Thu, 24 Jul 2025 17:54:40 +0000
From: linux@treblig.org
To: corbet@lwn.net,
	workflows@vger.kernel.org,
	kees@kernel.org,
	josh@joshtriplett.org,
	konstantin@linuxfoundation.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Date: Thu, 24 Jul 2025 18:54:39 +0100
Message-ID: <20250724175439.76962-1-linux@treblig.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

It seems right to require that code which is automatically
generated is disclosed in the commit message.

This is a starting point.  It's purposely agnostic about
whether using any such tools is a good idea or not, and is also
agnostic about trying to draw any hard line about when a tool
should be disclosed like this.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
This span out of a Fediverse discussion, those involved cc'd

 Documentation/process/submitting-patches.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index cede4e7b29af..d7c8f47a4632 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -452,6 +452,18 @@ development. SoB chains should reflect the **real** route a patch took
 as it was propagated to the maintainers and ultimately to Linus, with
 the first SoB entry signalling primary authorship of a single author.
 
+Disclosing tool generated code
+------------------------------
+
+When a substantial part of the patch (code or text) has been generated by
+some automated system, such as an AI/LLM, or automated code patcher
+(e.g. Coccinelle) the use shall be disclosed by::
+
+  Generated-by: Example Tool 2.3
+
+Where possible, the input text or prompt should be included in the
+commit message to enable others to learn techniques that work well.
+
 
 When to use Acked-by:, Cc:, and Co-developed-by:
 ------------------------------------------------
-- 
2.50.1


