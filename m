Return-Path: <linux-kernel+bounces-856921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA9BE575C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10C054733E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BFA2E1F01;
	Thu, 16 Oct 2025 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTg5bc8a"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A62E092A
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647903; cv=none; b=THNjI4bfampLDw5eaizDFavv+ik7XLXxbCsJhFV3KeUCQskgJcNTRdRB8YDydiLf/1WC1XYzxGI9JdKXpBXCZQgAoUQmfOTD/KBgJ9WdVYE96H/1yvm3VYqRKoXe0uJKwY4UQ/ExnON2I2k79D3InL+yIThKKygd82Zvx8n/wwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647903; c=relaxed/simple;
	bh=dliEiqiTMvqs0IcfBNZb5LeQ61wchQuC1RPqs6mcWkQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=jahZNJr6juA4+hUqRwp0Y/+29zfLhy/I/ZOp/iwGPS1wyWnOTPLnPDmMwKVhoIMbtuXTd8oJW7LfjJJaQfztt8FGo+Or17svHpXd8MbEd2PPVawfVkaKkCOJX7EUFVyOcq7Jl+YdG0oUXncgkhAOiRhbVpPvLGk3B3y3F536Az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTg5bc8a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so1099135a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760647902; x=1761252702; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxkK/QQ7vt0zUL78WAYEZhyuB+OQo5aAup2L7Jq9TRw=;
        b=gTg5bc8aLGe/5TST+JAJ0W7CaxulbaqtS7Hql4i4OvwEM+Gle8G+c3Wuf2PTzS3slp
         ASyYfsdxmOkakRRVQIKCf0n9tty1VEPehXCk7DYV9nzkzjoho+6NPm4nDllTGyW8k/Ga
         JarDtqeWtNjTKEc7+Pqtw2ycDoaHCoIfP3M23N43FMeJkEepsUj/72US2f1YjPK5JN7T
         XX/ATGgB33/CQIKkfe1Qp9UVdJYWCg5k+yttP1QKY0DF/qwYonqnMOgZ2qYOkhVnTN1u
         4UCGCLkm/9IBD/mtodLkfCj+rca+FvdNCYvv6t2bapM5x5kFytW28xs/ipcviMmNs7PI
         YoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760647902; x=1761252702;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxkK/QQ7vt0zUL78WAYEZhyuB+OQo5aAup2L7Jq9TRw=;
        b=wHl2DYob1pbVSgth7ePoyYLfAcozUkkNjbUxlGgG5Cg27RskTpcJ24M0aF5lR2CGix
         pRj+RCSAfCvPFah/L9e0I7TiPRrQcAHiQwzJRUebCsr2Hm7wJIu70Ov14pp3MqP/UzRW
         GZpKFLyLRMIuwY7fKUqqEPx5nAPQCtMwhnkIXHk4Vmo7tKRfIriV9vUateGTQXDb0LG4
         z3bqDKFtlc7bEYXDovFcZpN1Ihtbr3s08WwZnTYY+taBwMpfcS9CkYpuFViFPkcIeBSP
         hGiVBVvMbuRZrE8TxulSDCk3FrZDb/6Gi8KHw31H2XQ2ch5NSckK38MtuR1VlK6j6VIZ
         ytZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjbyCDuBbqBeS6sEZJGxdSFahI1yvfa437kkfxcNSCd+3I05pEWuA5/QLrejQbOnPkbNoX2nbpHnfS55Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8frEqn2NYeoUEKaooh3szFXP3ou+JWKfoCyEohfWbHpIZnZWj
	Tz6Y4HJb8rBuV1bqbVCw1duTonbIqX/U6pj+3sGTSTI5DIBrU3bfkgefrnVIQZ42LF146gZ7hso
	hSku+9cXhVA==
X-Google-Smtp-Source: AGHT+IHX6jzTaUBGdzq/jMSrKjZ3i8b5Eknbvm6Eiw9NU7XO1EnAB15c1MZGsKcSU2etha5Z+4McyObiisOy
X-Received: from pjboh7.prod.google.com ([2002:a17:90b:3a47:b0:332:8246:26ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70d:b0:330:9c0b:5494
 with SMTP id 98e67ed59e1d1-33bcf8e94f2mr1274322a91.22.1760647901813; Thu, 16
 Oct 2025 13:51:41 -0700 (PDT)
Date: Thu, 16 Oct 2025 13:51:23 -0700
In-Reply-To: <20251016205126.2882625-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016205126.2882625-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016205126.2882625-2-irogers@google.com>
Subject: [PATCH v5 1/4] parisc: Inline a type punning version of get_unaligned_le32
From: Ian Rogers <irogers@google.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

Reading the byte/char output_len with get_unaligned_le32 can trigger
compiler warnings due to the size read. Avoid these warnings by using
type punning. This avoids issues when switching get_unaligned_t to
__builtin_memcpy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/parisc/boot/compressed/misc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/boot/compressed/misc.c b/arch/parisc/boot/compressed/misc.c
index 9c83bd06ef15..111f267230a1 100644
--- a/arch/parisc/boot/compressed/misc.c
+++ b/arch/parisc/boot/compressed/misc.c
@@ -278,6 +278,19 @@ static void parse_elf(void *output)
 	free(phdrs);
 }
 
+/*
+ * The regular get_unaligned_le32 uses __builtin_memcpy which can trigger
+ * warnings when reading a byte/char output_len as an integer, as the size of a
+ * char is less than that of an integer. Use type punning and the packed
+ * attribute, which requires -fno-strict-aliasing, to work around the problem.
+ */
+static u32 punned_get_unaligned_le32(const void *p)
+{
+	const struct { __le32 x; } __packed * __get_pptr = p;
+
+	return le32_to_cpu(__get_pptr->x);
+}
+
 asmlinkage unsigned long __visible decompress_kernel(unsigned int started_wide,
 		unsigned int command_line,
 		const unsigned int rd_start,
@@ -309,7 +322,7 @@ asmlinkage unsigned long __visible decompress_kernel(unsigned int started_wide,
 	 * leave 2 MB for the stack.
 	 */
 	vmlinux_addr = (unsigned long) &_ebss + 2*1024*1024;
-	vmlinux_len = get_unaligned_le32(&output_len);
+	vmlinux_len = punned_get_unaligned_le32(&output_len);
 	output = (char *) vmlinux_addr;
 
 	/*
-- 
2.51.0.858.gf9c4a03a3a-goog


