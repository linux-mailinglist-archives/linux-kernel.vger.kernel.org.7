Return-Path: <linux-kernel+bounces-774673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AED01B2B5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAE1963C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD31DF75D;
	Tue, 19 Aug 2025 01:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXk2nAdf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E771547F2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566737; cv=none; b=jJtGlVBDEuVf88EviTRpxfiebAQ2V6qZvh+/pdvajrUvFYeLSaKDYz+yD0mbZlST79pAxKDIt6MsReZXsltH8JwqvV89NY1nXQXapwxWrEJdrfOkUZU+YQDYeBG1xVJdhuNQSEIxZR439ZiOb7QVHJOJLWWvaMykapOx23O8BHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566737; c=relaxed/simple;
	bh=lx7QrQh6j2ndEk4HOrX+QrCpsLlL5jUNhl3+yYubfmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFpJbeVCEgPsSJSCv/jjpYE4onXDJ8vMgl0mrHcgimF7bMbQXTRjhALbFSq2JPVqNJUmYkiBbfveJB9zZrNIs7G8aDCKj26MMlQ39BbeXnZ3DFmoCHa7rGgKb/L9b/gmc3fiT79jpFnQYgk8LYQVmy4DyfzIHtnKFQjyV58acGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXk2nAdf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755566734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm6S3sOmnMWBq4IxtVvgAb+NwqRQv9UdFtiUfY0OHl8=;
	b=VXk2nAdfwEZ0RHCGqS9ZdKXVMCmawL41d0cfT34k860mmr14XHg2DjQgZjZZ6shao/1TH6
	Lnfddh2Gwig2sHzwjJJwvmhu10e4Gz54yBQJFOERt289lzhZ8BtaZG6X4jpAvk+DTh6sf5
	dAh3C3+qJqs8mLsYxR2APZ0lJEBmMUg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-P0_UrfOeOeSZu6Wn8eXIBw-1; Mon,
 18 Aug 2025 21:25:33 -0400
X-MC-Unique: P0_UrfOeOeSZu6Wn8eXIBw-1
X-Mimecast-MFC-AGG-ID: P0_UrfOeOeSZu6Wn8eXIBw_1755566730
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E98A1954194;
	Tue, 19 Aug 2025 01:25:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.36])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8DA201800293;
	Tue, 19 Aug 2025 01:25:16 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: [PATCHv5 02/12] lib/decompress: Keep decompressor when CONFIG_KEEP_COMPRESSOR
Date: Tue, 19 Aug 2025 09:24:18 +0800
Message-ID: <20250819012428.6217-3-piliu@redhat.com>
In-Reply-To: <20250819012428.6217-1-piliu@redhat.com>
References: <20250819012428.6217-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The KEXE PE format parser needs the kernel built-in decompressor to
decompress the kernel image. So moving the decompressor out of __init
sections.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
To: linux-kernel@vger.kernel.org
---
 include/linux/decompress/mm.h | 7 +++++++
 lib/Kconfig                   | 3 +++
 lib/decompress.c              | 6 +++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/decompress/mm.h b/include/linux/decompress/mm.h
index ac862422df158..aa35b9ea96f10 100644
--- a/include/linux/decompress/mm.h
+++ b/include/linux/decompress/mm.h
@@ -92,7 +92,14 @@ MALLOC_VISIBLE void free(void *where)
 #define large_malloc(a) vmalloc(a)
 #define large_free(a) vfree(a)
 
+#ifdef CONFIG_KEEP_DECOMPRESSOR
+#define INIT
+#define INITCONST
+#else
 #define INIT __init
+#define INITCONST __initconst
+#endif
+
 #define STATIC
 
 #include <linux/init.h>
diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624ff..05b1e353dcd2a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -165,6 +165,9 @@ config RANDOM32_SELFTEST
 #
 # compression support is select'ed if needed
 #
+config KEEP_DECOMPRESSOR
+	bool
+
 config 842_COMPRESS
 	select CRC32
 	tristate
diff --git a/lib/decompress.c b/lib/decompress.c
index ab3fc90ffc646..3d5b6304bb0f1 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/decompress/generic.h>
-
+#include <linux/decompress/mm.h>
 #include <linux/decompress/bunzip2.h>
 #include <linux/decompress/unlzma.h>
 #include <linux/decompress/unxz.h>
@@ -48,7 +48,7 @@ struct compress_format {
 	decompress_fn decompressor;
 };
 
-static const struct compress_format compressed_formats[] __initconst = {
+static const struct compress_format compressed_formats[] INITCONST = {
 	{ {0x1f, 0x8b}, "gzip", gunzip },
 	{ {0x1f, 0x9e}, "gzip", gunzip },
 	{ {0x42, 0x5a}, "bzip2", bunzip2 },
@@ -60,7 +60,7 @@ static const struct compress_format compressed_formats[] __initconst = {
 	{ {0, 0}, NULL, NULL }
 };
 
-decompress_fn __init decompress_method(const unsigned char *inbuf, long len,
+decompress_fn INIT decompress_method(const unsigned char *inbuf, long len,
 				const char **name)
 {
 	const struct compress_format *cf;
-- 
2.49.0


