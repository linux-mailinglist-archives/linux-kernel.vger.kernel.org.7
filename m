Return-Path: <linux-kernel+bounces-858888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1505FBEC253
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0FC86E98B6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B4242D9D;
	Sat, 18 Oct 2025 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5/RTL53"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92023BF8F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760746077; cv=none; b=FH0mdMn4J64sTENQPDoFy9/oLv6irPYAkCAzha/dnCfeBqe0xeo+3jJi1lDmXs1D0YAPRUF/qnx866wnS5NG7RoiZde9v38EdP2cZ1P0wZAJ65WtmiCj46+QvLe1XR8oLRoczIxzOzvCm9UYnB1K6H/PxxpPSHN8dqR0K3llYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760746077; c=relaxed/simple;
	bh=vicAzr5G8Nj5bOl8kj0FUCuW44ReHeVMHkvxO4eBHz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F5y2NLQfjvMDigAAHiZTneJegGJAquclBi1ttx/htxmvTGi9RPkGVPps/TBjL9mtOwyV8kqw6gXo4TnjfHa6vvviNXp9jyD/wMmYJKoGMqiX3P1q4uHGROfWNbcD0IDWFeJrsb7pzQYAsFcyshqrix3QMcBd6qytklghQftsN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5/RTL53; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso2942225a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760746075; x=1761350875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsZ79Fc/eYrSb6uSl+QE8GB+MXNffylOcBysTYipsc=;
        b=U5/RTL538N872HxOtaXPLwywRcEmzr7k54UR9c5A92Q4Ta2gMkv4b/nP5GVidOQY38
         Amdd1wcy/jGp7t7+ByNp+KCEPjwzTv0hlABEZafnlifUsbJgUEozGuy64L64qsHU2Lfe
         XhmdnCAQr+/oxj98zFengad+R7jUgg7LQSqPcoCoV4ia+9e1uGI/0GkSLRWHfE692Jsr
         B+L10BhIalXvtHkhKFCusMJ5JbEkcaPoTjmUd8lvINi6GEJN6rJ9CslUOMls00eeSJUg
         5OlJQ2B+tWULlzgbdg6RvvJ0RWXFq8caAl4XLjTuruAHcs0WvFL2JGmFO/ZyznSMiSvT
         k3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760746075; x=1761350875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsZ79Fc/eYrSb6uSl+QE8GB+MXNffylOcBysTYipsc=;
        b=u+mDow6cnnR8jR090Kk5/zieHPwjdFS1NL3x/+p2qym8XjamhKOJsqr+poNKxcHFnq
         38JhC97+Qj4UsItX4Gr8ku18P5u2Ty4Kbq/+vYF0Bgc0lFbzadmkFuJQTFmOWd5+lHjF
         j9Shnn2/Pk0r5FjBRkfLnI68YDJcFcyyhCh5p+sNfRfsCT3OkPOrmJUU5d8ko8aPUV2P
         YcEywM26V4C08oQ4cZ3Sa40VtMopJ7462zq4GaBI7zF8f8BumK/mvsx6xCXXaJKMHXcg
         1Q6tT6kxCltw8i4HRa5CpdwQhq0exMah7z0afSirVuzzAhKADgKuijY16+wzYbdrO75L
         Z4Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUsq+KHUl/CoZEiqfIEeVX1F+pOuKoiAmZaEiZMAMJyC/18FXPK6B46N9fsjxvnXecxRkS7bf7lGpdTVIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcoybI1ivWUjsp3CxWGsbuZeYm+c7M4nrvDZ7t4uPivix6w3v
	E2JWCPXLDi0So0ttMso76a6pyHO6OAkcw5xno4eIwIBDLDcI88yP5eG4sJ3bNQYMjkicS6XYjlv
	Lb2UFYjB7Tw==
X-Google-Smtp-Source: AGHT+IH5Agotaie8Yfpd4OzcADNWVRMuZUwHnAmsdAx38ewjmLDznR7pF55YyI5GG3nzDG73A6J4oF7pzhXs
X-Received: from pjbgq8.prod.google.com ([2002:a17:90b:1048:b0:33b:da89:9788])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5386:b0:32d:ea1c:a4e5
 with SMTP id 98e67ed59e1d1-33bcf85128emr6136432a91.1.1760746074698; Fri, 17
 Oct 2025 17:07:54 -0700 (PDT)
Date: Fri, 17 Oct 2025 17:07:10 -0700
In-Reply-To: <20251018000713.677779-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251018000713.677779-19-vipinsh@google.com>
Subject: [RFC PATCH 18/21] vfio: selftests: Build liveupdate library in VFIO selftests
From: Vipin Sharma <vipinsh@google.com>
To: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	dmatlack@google.com, jgg@ziepe.ca, graf@amazon.com
Cc: pratyush@kernel.org, gregkh@linuxfoundation.org, chrisl@kernel.org, 
	rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Import and build liveupdate selftest library in VFIO selftests.

It allows to use liveupdate ioctls in VFIO selftests

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 tools/testing/selftests/vfio/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 324ba0175a33..c7f271884cb4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -6,16 +6,24 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 TEST_PROGS_EXTENDED := run.sh
 include ../lib.mk
 include lib/libvfio.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 CFLAGS += -I$(top_srcdir)/tools/include
 CFLAGS += -MD
 CFLAGS += $(EXTRA_CFLAGS)
 
-$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
-	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
+LIBS_O := $(LIBVFIO_O)
+LIBS_O += $(LIBLIVEUPDATE_O)
+
+TEST_GEN_ALL_PROGS := $(TEST_GEN_PROGS)
+TEST_GEN_ALL_PROGS += $(TEST_GEN_PROGS_EXTENDED)
+
+$(TEST_GEN_ALL_PROGS): %: %.o $(LIBS_O)
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $< $(LIBS_O) $(LDLIBS) -o $@
 
 TEST_GEN_PROGS_O = $(patsubst %, %.o, $(TEST_GEN_PROGS))
-TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBVFIO_O))
+TEST_GEN_PROGS_O += $(patsubst %, %.o, $(TEST_GEN_PROGS_EXTENDED))
+TEST_DEP_FILES = $(patsubst %.o, %.d, $(TEST_GEN_PROGS_O) $(LIBS_O))
 -include $(TEST_DEP_FILES)
 
 EXTRA_CLEAN += $(TEST_GEN_PROGS_O) $(TEST_DEP_FILES)
-- 
2.51.0.858.gf9c4a03a3a-goog


