Return-Path: <linux-kernel+bounces-782129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BEB31B92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F86E1D61244
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBDF312823;
	Fri, 22 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgmhr3DZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C5311977;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=sBk3eapjgedg6EyLXr2NJIenzh+PhC/87gY6WbaNlO8XL4p9JGwGJjMXWFuyYaf+ivGCsCGs5jF2ZVwGI/HKEj2nHMNoLB+xXv5YjmjfcPGqSCjcbEFKCeOByaTz2ldggzXNRRNH+iqh2WgONvAN4PQxW0ctGTvjLAMYl5c/zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=wQmzELiyLlP6dYnGbR5xm0Wl2cXgsAK4Vx4o5Slpgnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1BLz7ZyTVp4J8wvZojFyePONFcD9yZ9T5FzMjXtQxDihaTvozYPVMj0S+8yOIUEbbdk11zhPqR+Z/NIXWOCEgSva7+p+HsiMs420iOliFFOX+5wygFHtCUWyF5t/eXWcLXd0vdeH3Ha8rRg8j6Kqi298fyDGUyGX5l9l/afDJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgmhr3DZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4037BC2BCB7;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=wQmzELiyLlP6dYnGbR5xm0Wl2cXgsAK4Vx4o5Slpgnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zgmhr3DZt+Ed1uvBvlGY6a0RI3Qw7O7QBPDF2XQDJvwwuhtFW4YIVZnU2WiUdtnXy
	 RZ6Gc1RJRbRACwbkhdZJ8UdE6Vv/0XMyicEl3jkF+wt80SQ1cf2nKRVj+p4kcg34G/
	 Wo2fKhy1W3zqrj9n9g18rwI9uj+3uYLg+7ms3Vr/2/hvhixcL4MIZdKlRMuGt15dzk
	 SfFZw4BPyIVCyRhOdHxY6ZCPD3OrCKHvmntddpns1C4ViDTOgwRmMQ0JCvOBoJHvGe
	 BQPk9Igq2xL9iHvh9Uhm1W2WpfNejvvj4Y2Iz72516mizzANBsm7K1f3ETrphzCKih
	 nOjuuX2gRKaRA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrp-26gB;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/24] docs: kernel_include.py: remove range restriction for gen docs
Date: Fri, 22 Aug 2025 16:19:27 +0200
Message-ID: <5dff693860a6a3faade15c24abdc380f09db468d.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Originally, parse-readers were generating an output where
the first two lines were setting a literal block.

The script now gets only the actual parsed data without that,
so it is now safe to allow start-line and end-line parameters
to be handled.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index c5f4f34e22cb..4cdd1c77982e 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -122,9 +122,6 @@ class KernelInclude(Include):
             exceptions_file = os.path.join(source_dir, self.options['exception-file'])
             parser.process_exceptions(exceptions_file)
 
-        if self.options.get("start-line") or self.options.get("end-line"):
-            raise self.severe('generate-cross-refs can\'t be used with "start-line" or "end-line"')
-
         # Store references on a symbol dict to be used at check time
         if 'warn-broken' in self.options:
             env._xref_files.add(path)
@@ -209,9 +206,6 @@ class KernelInclude(Include):
 
             title = os.path.basename(path)
 
-            if startline or endline:
-                raise self.severe('generate-cross-refs can\'t be used together with "start-line" or "end-line"')
-
             if "code" not in self.options:
                 rawtext = ".. parsed-literal::\n\n" + rawtext
         else:
-- 
2.50.1


