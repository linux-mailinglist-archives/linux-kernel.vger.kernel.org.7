Return-Path: <linux-kernel+bounces-895770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C03C4ED9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084E01883AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD933DEFB;
	Tue, 11 Nov 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1FeMUeh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A136997C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876197; cv=none; b=mqNc+6vemaMnvzxY8kRT9AYrFBF2h3OD8qaqMF6+w8wpraJFH7jhT4RRgjydSld8LSi9qoRWeST7KoZ8F/rO17jceHR4e+kZso2+0ym5UExtcTEcHGRA+bOTlKA+qHQZziS3YBqj7l5gjhhNUcpSP+nlglKSAGozr1jNsaUkR9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876197; c=relaxed/simple;
	bh=qD6zIG+QFIh9H5gMT+JWHMXeNqgfXO8dSPuiOhs9AzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqy9+bXImihLc/ugfZI6xAgu6QXVgIghMHOXUW8Vycdn/m5N658z5SozUY/jLj/VhYSmpjICVLhnnvwK64o8XFl2SFuzha5QUk/aBAe+cErtbG320BamWXbhur31ATmtvbFV/sa4R+C6MRt4uEq7TpYt9it5d2egLUyrewuVZ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1FeMUeh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3720e58eso2409250f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762876193; x=1763480993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldB0OPyDE9pZ9lZi6t4J5SC+CGo/82OY1zC0z4qhuPw=;
        b=N1FeMUeh9AbsTM9znheALQWUQ0YwCaX4LeGGr8D6SzzXCIUYQDpDAhZNqkuJ8sryUN
         0DFf6jahTH593gBhtp0cr5VKwo7F0deKFMWPn9s4KCzqVUuoiVLzJljuzmWC4KjcpqeT
         eM/OXo/jfbuYwcrpXbQZVwZLa9wrzpWgwRIZ58tThg+gJcUgYx/2E6l2ndiVtOIx4XUx
         hH60Y+byANhUcvaOM1QRL20kL3C5x1jW2yNcsTd1KpQRqcT7spbE82kOWcO8PVP4+rTI
         YYQuh1Sx/HYWU6NgrszHSIq9jy9YLs/V4wxTqkjjnixmTGfTJTAyKZ33c8WY5bIc/GKW
         3oDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876193; x=1763480993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ldB0OPyDE9pZ9lZi6t4J5SC+CGo/82OY1zC0z4qhuPw=;
        b=P9Otkxz4y9F3HQn2xeezGmAshbURSbKKoWnGVNpKu7jXZn2POccAx+6vB0s5pkFbA1
         FkOmL5U8vWdu6+p+cJhVnV7Quvdd44lcsl/IHqGsrfFR5qC1wogOqz2v+XZg2S2CWp9v
         J3Z4rfQ0G/31wJKb2IMewaVfIE+Ai7q+ZmKEQjU9WD+SX8UEQ/NcQ0x+W8ciAZBBp/+X
         RsqB+Z1OtL6qyzv62urI6cBBDAsmkuLq2cmS5CZYygCJvmU5fNcxPHKiX9ljtTTZQ5Ll
         8ao+9vDX0KlpB4RqpDHyn6/NNDaxdOIbFYb/1U1NBoKUJXkt4h+9wlz4IIPXksI7k3+v
         YYtg==
X-Forwarded-Encrypted: i=1; AJvYcCWvTransXuO8LA5iqFzSlSSJ29OkiWxMGdUu+5O6dRuzi69lzLLeSq5AgAAI130at7HTSRxOB5zKQXQrEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD31k9FqduRyh9QZ3vKNf8RDHEeXiKN8WS4qMQD9404eNxp6qH
	j+jY140FXl5AidwBfesTlqhaCg2VVYCdcDwKr6MSbuRl5+34cn0/0ImO+Nr5jJJgHrw=
X-Gm-Gg: ASbGncvyn4SD2O6k7I/gs4d18cOW4U/NC31k4eXLR5xjCEaS3H54GXdwaOIDNtPsns0
	mAVhQjwohIcn6Sd2Mr5RmagkeUDx9ORj410JVwUG1phOP/4gRuxNStNdKwdSEAbdm/+9AhmQFUG
	nsbMs8yg9/iGc0MLpvHXWV5sRZpm3nBhGjAWHvjk4ZZeAO/7IH1j4MWQu4Rb0tIt8B77GpYNevF
	NA4n2Dw5UILbzA0Hh6KbOxCcCAdVbZsyaWENzjQM7FRQeI1fL/Ud+8VDgKP2JMvZ/PPNZ4feghb
	PORpnfLHh4okwAnb9EopCQmoaw8ccyrc37igpwKEQjJsk3hFj/Z9fVJ++Iq9ggUKdsmTW3V+cpE
	HVOO1YgDQPQhPq5UTYPiyrJBOkGoTxMeDaljcSYSLEQ4d3oXMG46dmQw1rkf/k/2smPQgaoxDbo
	z9HrjFmAHnDAyl8iPPsQ==
X-Google-Smtp-Source: AGHT+IEOSm7C5wtpa4ZrHjhS6rbYwvS1yk5B9tIcVm28eW4cAMJObZ0VcTOXc0R/m5W6dUpuHdMeIQ==
X-Received: by 2002:a5d:5f42:0:b0:429:bca4:6b44 with SMTP id ffacd0b85a97d-42b2dc1f4e9mr11678592f8f.13.1762876193119;
        Tue, 11 Nov 2025 07:49:53 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm28269916f8f.10.2025.11.11.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:49:52 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: keyrings@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] module: Remove SHA-1 support for module signing
Date: Tue, 11 Nov 2025 16:48:31 +0100
Message-ID: <20251111154923.978181-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111154923.978181-1-petr.pavlu@suse.com>
References: <20251111154923.978181-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SHA-1 is considered deprecated and insecure due to vulnerabilities that can
lead to hash collisions. Most distributions have already been using SHA-2
for module signing because of this. The default was also changed last year
from SHA-1 to SHA-512 in commit f3b93547b91a ("module: sign with sha512
instead of sha1 by default"). This was not reported to cause any issues.
Therefore, it now seems to be a good time to remove SHA-1 support for
module signing.

Commit 16ab7cb5825f ("crypto: pkcs7 - remove sha1 support") previously
removed support for reading PKCS#7/CMS signed with SHA-1, along with the
ability to use SHA-1 for module signing. This change broke iwd and was
subsequently completely reverted in commit 203a6763ab69 ("Revert "crypto:
pkcs7 - remove sha1 support""). However, dropping only the support for
using SHA-1 for module signing is unrelated and can still be done
separately.

Note that this change only removes support for new modules to be SHA-1
signed, but already signed modules can still be loaded.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/module/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 2a1beebf1d37..be74917802ad 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -299,10 +299,6 @@ choice
 	  possible to load a signed module containing the algorithm to check
 	  the signature on that module.
 
-config MODULE_SIG_SHA1
-	bool "SHA-1"
-	select CRYPTO_SHA1
-
 config MODULE_SIG_SHA256
 	bool "SHA-256"
 	select CRYPTO_SHA256
@@ -332,7 +328,6 @@ endchoice
 config MODULE_SIG_HASH
 	string
 	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
-	default "sha1" if MODULE_SIG_SHA1
 	default "sha256" if MODULE_SIG_SHA256
 	default "sha384" if MODULE_SIG_SHA384
 	default "sha512" if MODULE_SIG_SHA512
-- 
2.51.1


