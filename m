Return-Path: <linux-kernel+bounces-791632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13640B3B97E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34E6A07531
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6C319846;
	Fri, 29 Aug 2025 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RowSZijb"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0D310630
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464883; cv=none; b=rmnjXhM5e3/0za3XKTeNvjr7/ymkUypzRxzEby/BHGbIE2cOIEw0vqimZrxkFKBApb0T8zM1l8VpvgGR5wQUXA4ynhJ7IAMlz0X7IUx70movwSgn28YxBGMxJynvalRvmspciBIXhL+U0Wh9RtiMZnJs0i3xj1A9QQr+c0pTY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464883; c=relaxed/simple;
	bh=dffa0L6234ztRx9C96gKJmKJajvyCWjO/vN19K5vk8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJPWmafjfiAryiPjGFA/ludTYCF3TvX6/FOHLkN/4urrrVXoebAg5161pb8IOD9pNdeYn00LjDKaMQlk/auud1yhI+lKpnDSktMh4xGZF9w7LsbgysyML+KjijhgHMyQY/o7lInBPh7Qw8xxXjeOD1iCUWitRYzMAkF4TuZcyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RowSZijb; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sidnayyar.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c79f0a57ddso1174371f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756464879; x=1757069679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enXXJwtnX6u3ZFaViBZUrEuTl1Z1GtEQPAAtWrQl1uo=;
        b=RowSZijbnosPDZitROCFUrCrCmw9+GNPVwsIzaloRPXtrpSy9qj94pOwfGirV9HQtW
         6zQepS4zggglD0kzFsQPakFq2ilqXGg0SkPiOVHHNepAPH7fQZtpjSlGuRqjvr8Qex0e
         FRXZJb+eXk43dTSm2c6rSD46JBTu/4BMJecCH3cylRoY4mUD2yXk8kP4qFaK+iOj+iY+
         Ookoj+oQFxeSCvgVfLbL1ApZRr73o4AmXGl/3cjVM3GIXcBKqbSJ/6o/ioeX1H/fJ4E9
         /iJccqhkw/h0OzL1yp5bsS4BOsTVoJ+Ml/HuQmZDZmArPRIQi2N3g/LTkUUwtqoPs5qp
         3zsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756464879; x=1757069679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enXXJwtnX6u3ZFaViBZUrEuTl1Z1GtEQPAAtWrQl1uo=;
        b=XWga1mikwSBKTDIkVn9ASiTlC1Limbl4bNPbiNL6b/1T/PeHfGkXnEHJ2rBDwfPI1Z
         ryRzIiUwKPMYmCDpPXEyZmaHCVdBV/wgSSzPEvgd6oHXoQv0cwg3YvCFk31FyXn2UVrK
         bgUuwm5PuemQuDNaeB2ynt41u9o3WmxadrmCVIbsFTMzPhxrXWEUYQBgdrcMHUg24KOU
         OJ2OfDVDX0GwdsI54wkOGKmPqLxr0cuMscNFcMf5WVKvR5FeFL1cF+WghFHJVWzdKA9K
         1GooA8zXBUmV38sfK3KtpiUu4JqQSUlEhLldofJTeKz2eQ8sTPmXpqywy1/fjYtC7Z1V
         k+/A==
X-Forwarded-Encrypted: i=1; AJvYcCVbh8Nw/vsal3Q5IxdzTYjF6sWMBGI+BDPWc2ji3ZAHJ27+8opP7EGjWwVrke7lUHGF/pw02oQHjaDM7mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtrbWHjNrfay5KobL88pk7nqxs7K0rElhbqf+2dBEEMhD6lH8
	N/BDQhKsB03mEKLBSI+U+2vPU127qpW6h12cMqZj+3WOK1mf5P9LlGiobix2eBhYt0MP4R8u89Q
	kkapRUHxAZHvqNHaDAw==
X-Google-Smtp-Source: AGHT+IGg/yFiglPyxsXk2HLgEh4ox4wWOVB+V0V2/cy4dlrL4d8IE17mWIFRoJoeOCGIJ/ix3IDhjY7+D14g08c=
X-Received: from wmbjg19.prod.google.com ([2002:a05:600c:a013:b0:459:de2a:4d58])
 (user=sidnayyar job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40c9:b0:3c9:52db:9f64 with SMTP id ffacd0b85a97d-3c952dba323mr13516384f8f.22.1756464879493;
 Fri, 29 Aug 2025 03:54:39 -0700 (PDT)
Date: Fri, 29 Aug 2025 10:54:18 +0000
In-Reply-To: <20250829105418.3053274-1-sidnayyar@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829105418.3053274-1-sidnayyar@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829105418.3053274-11-sidnayyar@google.com>
Subject: [PATCH 10/10] module loader: enforce symbol import protection
From: Siddharth Nayyar <sidnayyar@google.com>
To: Nathan Chancellor <nathan@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: Nicolas Schier <nicolas.schier@linux.dev>, Petr Pavlu <petr.pavlu@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siddharth Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"

The module loader will reject unsigned modules from loading if such a
module attempts to import a symbol which has the import protection bit
set in the kflagstab entry for the symbol.

Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>
---
 kernel/module/internal.h |  1 +
 kernel/module/main.c     | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 061161cc79d9..98faaf8900aa 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -108,6 +108,7 @@ struct find_symbol_arg {
 	const u32 *crc;
 	const struct kernel_symbol *sym;
 	enum mod_license license;
+	bool is_protected;
 };
 
 /* modules using other modules */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 4437c2a451ea..ece074a6ba7b 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -380,6 +380,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 	fsa->crc = symversion(syms->crcs, sym - syms->start);
 	fsa->sym = sym;
 	fsa->license = (sym_flags & KSYM_FLAG_GPL_ONLY) ? GPL_ONLY : NOT_GPL_ONLY;
+	fsa->is_protected = sym_flags & KSYM_FLAG_PROTECTED;
 
 	return true;
 }
@@ -1273,6 +1274,11 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 		goto getname;
 	}
 
+	if (fsa.is_protected && !mod->sig_ok) {
+		fsa.sym = ERR_PTR(-EACCES);
+		goto getname;
+	}
+
 getname:
 	/* We must make copy under the lock if we failed to get ref. */
 	strscpy(ownername, module_name(fsa.owner), MODULE_NAME_LEN);
@@ -1550,8 +1556,12 @@ static int simplify_symbols(struct module *mod, const struct load_info *info)
 				break;
 
 			ret = PTR_ERR(ksym) ?: -ENOENT;
-			pr_warn("%s: Unknown symbol %s (err %d)\n",
-				mod->name, name, ret);
+			if (ret == -EACCES)
+				pr_warn("%s: Protected symbol %s (err %d)\n",
+					mod->name, name, ret);
+			else
+				pr_warn("%s: Unknown symbol %s (err %d)\n",
+					mod->name, name, ret);
 			break;
 
 		default:
-- 
2.51.0.338.gd7d06c2dae-goog


