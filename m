Return-Path: <linux-kernel+bounces-879683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E71C23C45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E98A4F5D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEE32E6B8;
	Fri, 31 Oct 2025 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6iLMVDR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AC32E69E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898223; cv=none; b=m1duvSMBcF+fkQvM/2VNhyITDAWXePq9YV1dunOtEfBUVl2u/0LBt1nO9SDfFbLegn2HpTdWcInQwrYt7JWBFRJJ6XvKu/nQIT4GVQt7jkWuN5F7ltexgfiiYXqJEAmapAlMzyFsoWtNZjOcEI7lgRJBl4HUQyoLZDhA0ywn9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898223; c=relaxed/simple;
	bh=VrcIxeKGvklYAAY8vcHJNydokVUp7bULcDMSaEYoXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UBJyzZOydoqOGjOlKLuA3IV7qsodluEIpKKeqt/vjao/cRaMuixFlUCUPgYcT5j2eAEO3WvihTPkMrqfkB+3zkPnc7fB+X5DfChvIPnrdd7MTSQpvxMrOWz78H4nOeKi7/4UbkEqfkxwOiXjycQ+dNRVvXkw9WD0JXG1zFYcI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6iLMVDR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761898221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i82y6QYrW3cjMA5vRe+eeZV6V5DVvv4lrrKkBnMpwUY=;
	b=O6iLMVDRh5NPKiM+a5C7oDviF1K8FJC0JQGJnrrGs3hTIYzJVJyoRmwUQo8cAUuNRYou6e
	rFDj7c1MIEYoTwXEvKjc6apXzrwRjXi+uUge8kNzqvSSwz7tX9UFTwVm+LAbhJ3Ol0YAcr
	VySm6wzgeTWk/0EtF5EV+/SalpK3NAc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-OxcYE4hsN2eSyqcord1K_Q-1; Fri, 31 Oct 2025 04:10:19 -0400
X-MC-Unique: OxcYE4hsN2eSyqcord1K_Q-1
X-Mimecast-MFC-AGG-ID: OxcYE4hsN2eSyqcord1K_Q_1761898218
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33baf262850so2322664a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898218; x=1762503018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i82y6QYrW3cjMA5vRe+eeZV6V5DVvv4lrrKkBnMpwUY=;
        b=g+R5A5KEXQJyqpqUmHg7CPZsEshCktmizYrFdQoTDmJmU1oLt8g3iXkewmIQDHHeuK
         05j7Cbib0EWa2Nf2Xt7w78uwvCLFlD32ZStKQqGgZ+YmctD+LwO/LyulpUoLsJ6LWBO4
         xT960Oh2mklxmJFZVOqtIRfxDXXElT4b6YJI1k+K5GslUAxGhQww6dpLpEolEJ87RgqM
         059QphW3p0S0uovzIWSS9kyyiaLV/Q8t/VfHwIbnfBtnI4FLg6bzvhiL1Io99utQMRps
         5ONXnHBtspR7hGVi3+Akf7EttdAO8IDKVoXB2Y+Mw65OOiGI1ET5Jo2RFxqXR2X2artO
         lT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCg32FNLnowrbIuoJHVbV9ZrCkz+p0avaKBwr/WITzM3zQldZMeJvL9Pp2fUbo9gzyYrU2O8Rgfo1G+Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMl5wIx/kJdbTJ2WlWINkEUIP3KtXaTvE42nT9DCDG8Ylf8L9
	QjwEdNq4iYrDcPBbo/Tg++PBDDmZw0SZifvt/ESKLd6lhYW7t2GGg7AxittqQxPUct3upPGs07/
	tGM4XYgJUhnSxHk2qNDzovpPtRcXD1ybYmBTrJEDalJxrvI8p0MxUwekASD83YQ8M3A==
X-Gm-Gg: ASbGncsfH+5qEtPPOr/hQEe1iB9zcTm5h+1Wb5A4ZgLNms6tLtB/FxSdEiv4KQq2Sru
	HfVo8W7V8SqSIIa6pyB2gLNzagfapZbdYv79JNkSI5TFfYaF4t7ONRoW0ODMILThxiKitwzUTRf
	AWYFL7AW3IQtVKLSc/r3wKtAzQCKtPOIj1zRIgfQpBcDr90IG95nfi7EVBpmAer5ngDMaAi6sXa
	otonuGlosg1z1DDbr74GokK6YRncTDFge2Sp1bTiFs0/lYA+af8PcNBzwNgeJ+hiE1aDGYPZ+62
	J9/mShDKXLVJMhkoESEwmT/muOVamM43twC96UBkpbwMKXEHVkSC9CO14cPJ07/qvA==
X-Received: by 2002:a17:90b:2e50:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-34082fd8a51mr4113230a91.12.1761898217804;
        Fri, 31 Oct 2025 01:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4iFz4WR/OBJiATgxQJLE1K7D2jafbG20415vZcHWra3bLCe9VveUtUMdFVbyjY0dNnGmaJQ==
X-Received: by 2002:a17:90b:2e50:b0:330:6f16:c4e0 with SMTP id 98e67ed59e1d1-34082fd8a51mr4113171a91.12.1761898217197;
        Fri, 31 Oct 2025 01:10:17 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340999f9943sm814815a91.1.2025.10.31.01.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:10:16 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: linux-modules@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org (open list:MODULE SUPPORT)
Subject: [PATCH] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
Date: Fri, 31 Oct 2025 16:09:48 +0800
Message-ID: <20251031080949.2001716-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
is enabled. This can lead to a linking error if
set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,

    ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
    security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
enabled.

Note this issue hasn't caused a real problem because all current callers
of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
depend on CONFIG_MODULE_SIG=y.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/module.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index e135cc79acee..fa251958b138 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -769,8 +769,6 @@ static inline bool is_livepatch_module(struct module *mod)
 #endif
 }
 
-void set_module_sig_enforced(void);
-
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
 #else /* !CONFIG_MODULES... */
@@ -865,10 +863,6 @@ static inline bool module_requested_async_probing(struct module *module)
 }
 
 
-static inline void set_module_sig_enforced(void)
-{
-}
-
 /* Dereference module function descriptor */
 static inline
 void *dereference_module_function_descriptor(struct module *mod, void *ptr)
@@ -924,6 +918,8 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 #ifdef CONFIG_MODULE_SIG
 bool is_module_sig_enforced(void);
 
+void set_module_sig_enforced(void);
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
@@ -934,6 +930,10 @@ static inline bool is_module_sig_enforced(void)
 	return false;
 }
 
+static inline void set_module_sig_enforced(void)
+{
+}
+
 static inline bool module_sig_ok(struct module *module)
 {
 	return true;

base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
-- 
2.51.0


