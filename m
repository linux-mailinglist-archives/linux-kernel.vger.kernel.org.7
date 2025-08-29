Return-Path: <linux-kernel+bounces-791623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA3B3B958
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3D27C4FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87231158E;
	Fri, 29 Aug 2025 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HlZ28ScE"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C98F30FF21
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464874; cv=none; b=DZB9xav5BsEgbwAvSsMQO6SVzS2fV0FcsNWLBNht5sAdIpQ76qgYEoUdVggSm+qtuGwZqGYQVp1eHYIbScLYFNqXgCRQ2F0pWNiBVGFhJmmanOFsTKbKJMidc9W28SMbpYLxRH0fx2yz0PbzniwPzD39VHUmurGWRQPUXn3EN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464874; c=relaxed/simple;
	bh=o00iDb5UYdIfCyM60Ae3j8Plc64XIahNETckMuCAzEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Evh9RgnDFWH/m8iVNeqT6Mlzk7hXIDvpKq35K11SfsTVFjIwU9GDxUFhz1GRMxzIRo804xQCLXXyO9n011L2yxDDGt0PrlDXqanc/zTLlCpJEJ76evDu00QErLEf35xHDxAjAVOKSV7oR6gNomjJPBQLcXq4Z63KtfKoXg3pV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HlZ28ScE; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-afe81959e5cso191995566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464871; x=1757069671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzTerVh/nCBDl27Owgk/DKlFx8Mn2cN/NIkEjSaweuQ=;
        b=HlZ28ScEhlTJqsqRcihNvC+4ZcY6FG7G31PA5SpYEqdHwPtySmu/4g2Y5cFAbrpoBJ
         6dTm1S2tUnqTLjlEEUOLh/cIqXfpKtWXIsdBGxz11dJOtPQ0XDf43DLkIYAoQD3vnvDJ
         WVmrJG5FTo51FDWy57DIqvUocUGNKbk/oB8Csn+elsCNJjxXpwTVsjsfqmzdwYJFAjNZ
         CSvjjmSXEnKePujyZbTqgD2vcrqA1dp0g0VigdPzpIrkl2DQfmiXJhdPMZyoPfWtisL4
         smMKGg3bjvP1rppjnOhd0RDxetBcnO4JMNdVRY1Uip6jMJaD+/7z6xq5m/Mb+zbyCGLh
         FIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464871; x=1757069671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jzTerVh/nCBDl27Owgk/DKlFx8Mn2cN/NIkEjSaweuQ=;
        b=tQSrcvcmg+mcuy7dfSmVFOa1o3kSS+vkymUgf6Y0A7RP2ImH3vjo4yJZ+VpbeF9C70
         zvI2GWbjQ+oLOSgis76n+H4Gjq0jw17EJRB1uqkuTI+NLa6kCZN153OwuhPJv/hZkXyn
         l2+VTqZnYkeYfg71FrhIJN+Zl2xAGbN5I5iO7b3T48VvQ7SjGVW8mUKmntOGshZ4vb8d
         S9GlzRaTiIE9vTK4lXRi3liZ9GJRmbFyZRHpJdmbkczmu4v1aNBLwfAC0FCcAk7tHJjM
         Q5kADPf53EOhdJNNhXtJvMMJstpMMGwmeQ4ClgYwUjv9IpuXJpFlmeKyyIIJgPkSSsSR
         atBg==
X-Forwarded-Encrypted: i=1; AJvYcCV3e75V24U4giyp87i+R7EzM2THSneRDUx2xVpLeGQcu/6qmqvUHS4V4jnQYgeNojRe86aJaswzcTMOPO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyijGzZVHgHcELzoTPtcZv0lQkpZ4icztujhRfg2LeiYAiy91Hb
	Gt8SuLjzFKmplKk7G6eyBNE9L6zhNJDhLzhc9ovy1lxYwcpvF5SX+u4W1EGZdB8R8rlEUbeluwB
	861Wl5cO7PwoqAsSmug==
X-Google-Smtp-Source: AGHT+IFTtQCdjV7sfltO3GmOq7hzjj4vCpIsNY9YQpuWWop+sd3pviuI1QGFkyDeMWAuOScrxjcHr9lkftkQ/q0=
X-Received: from ejcrx18.prod.google.com ([2002:a17:906:8e12:b0:afe:944f:fea5])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:968c:b0:afd:d9e4:51e7 with SMTP id a640c23a62f3a-afe296bceabmr2540214466b.63.1756464870885;
 Fri, 29 Aug 2025 03:54:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:09 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-2-sidnayyar@google.com>
Subject: [PATCH 01/10] define kernel symbol flags
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

Symbol flags is an enumeration used to represent flags as a bitset, for
example a flag to tell if a symbols GPL only.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 include/linux/module_symbol.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
index 77c9895b9ddb..574609aced99 100644
--- a/include/linux/module_symbol.h
+++ b/include/linux/module_symbol.h
@@ -2,6 +2,11 @@
 #ifndef _LINUX_MODULE_SYMBOL_H
 #define _LINUX_MODULE_SYMBOL_H
 
+/* Kernel symbol flags bitset. */
+enum ksym_flags {
+	KSYM_FLAG_GPL_ONLY	= 1 << 0,
+};
+
 /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
 static inline bool is_mapping_symbol(const char *str)
 {
-- 
2.51.0.338.gd7d06c2dae-goog


