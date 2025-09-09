Return-Path: <linux-kernel+bounces-808813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52181B5050C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074713B373C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48E343D9C;
	Tue,  9 Sep 2025 18:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9KiSISo"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADB25B1E0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441663; cv=none; b=ZBn8IwEUYd7pGBWlMXCVvX0AFNs4DSCDDWbYAZia7PpwYvnlnm8SiXiL3CetZ4LjShuJtpp2aOW9RXTR9UeUjJBMNt5FOwAfqr9CU1lA2ZEBdsSKYxvJwja/WmFaVkGGP4i39tLTuZmQhmSvRJoerqYr2NY4OimVcZq6I8n2Lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441663; c=relaxed/simple;
	bh=XKMYR0rZFryWAt82cmAKlov8m+wRjbLtNvTpIjuR2A0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EWvvRCnM+VHzWX9ItyMEZwhY6ge7pVJMh2YH84SGnrQypwod490rA1+RriDmxJ2DC4ANnK3xgRMWZ8szVLQJGAwG9nZG6IIA/WXOmVmwlzYUjwLDFmdI3z2BGWCwDgUqQ/5E321CmVgMUczAoINA5r88hAuSSU+W1wjXCkn2UC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9KiSISo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so9152596a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441661; x=1758046461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tvNduM9s7//sCfdhyoE/HdBETl81FPFKvCYM9u9MkSs=;
        b=c9KiSISoxYnAJI8f8bNQZNUJQI4UwUFwJ9HJv6QqFwwDRGQH7FIXYL8EoVOoQWQ1lZ
         SDNmEeIWXnIaOq+DkgUI5zG4RMDzFRGXAFiK8ayeLgiw+8Kw3qVdJVA/1U5KIu2mpSiI
         BiiVbKNh1APWw/Owlz/2hYa2eACNWM9Tbgsk26wG5WATOIG9nsliewzrC/tWIeWj7bl5
         +2CdmYMv0IiKYxZxeZtpQbP20nab3njbv53ADgKqM7sxxmGsqPbP0rxFwtvqI6unS8uZ
         zWOi8lT/aw8g/PJBSluUlcr7Sis5cbd4Rkz24MWshf+7arJS5XLJYp5BkbQLFBuxHDUP
         xC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441661; x=1758046461;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvNduM9s7//sCfdhyoE/HdBETl81FPFKvCYM9u9MkSs=;
        b=lf2TI6z0e3ZtmMQC9zKUfQeWWQStQeioBNnVML8Ysgv+hapT00wGJr+cDof0USOlrE
         V2fgqlDUOYUxj8Oe5r2BiplR856mYhVYtwP+yzJKxr9KtBGzkStPK9HMi6xWI69y6y+Y
         9iUIYTvyUkeij9dti/oCOP1U4bPTQoNUUmSVvugCpzPEFfgnBYrVntt2qPIHB6+qu1wa
         L/qvaABNmvKST08Z2WIjFvoovH4AxAVtQPLhSRc09lOQugCNwX3WRl36keu2+rH+8x9u
         kaKeqBoJQW4DG0ZTlBcne2ReOMenes5xKvw+oPQT6vQKCHdp3c2unchFlSqY8PTTWdEb
         Wtvw==
X-Forwarded-Encrypted: i=1; AJvYcCXfmNWL/5POTkKXfwOR3bNSoD4j/WZuyipqZRQHm5aW2hMeRBfOiMKXeyvEibxlJ3ywnbeV4Cb6UzsjPaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQ+0BwzT1JfzupInNOgcA97vy6fxmmrI8yLR3hoFHwtAajlMb
	czfdwHX3Y7pYI0/Mpu7F/xNk8knzLb0qFuAdAGjAKBtpVfBSe11qDleX3wI8iXnhZsuEMhiqlRs
	L9U4D3GJqlQ==
X-Google-Smtp-Source: AGHT+IFOLpvhmDvGxk6t715bqYf6V40EcsZUuZVEqhl6096A5aJmAvnCAulGYXhst0wLjI2umouHZmOWzc2q
X-Received: from pjoo15.prod.google.com ([2002:a17:90b:582f:b0:329:ec3d:72ad])
 (user=mmaurer job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914c:b0:246:6d1:de66
 with SMTP id adf61e73a8af0-2533fab7223mr16781966637.17.1757441661606; Tue, 09
 Sep 2025 11:14:21 -0700 (PDT)
Date: Tue, 09 Sep 2025 18:14:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHtuwGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNL3ZT85KLUXF1DE8tEEwtTI0NDIwsloOKCotS0zAqwQdGxtbUAMDC jAVgAAAA=
X-Change-Id: 20250909-docrem-149a48521128
X-Developer-Key: i=mmaurer@google.com; a=ed25519; pk=2Ezhl7+fEjTOMVFpplDeak2AdQ8cjJieLRVJdNzrW+E=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757441660; l=1361;
 i=mmaurer@google.com; s=20250429; h=from:subject:message-id;
 bh=XKMYR0rZFryWAt82cmAKlov8m+wRjbLtNvTpIjuR2A0=; b=565KgAzEoPasOdaJ+pLXjqvOtQDtjOyYrVdW5SBIneocC/D2PFTKb0bGSsDIlakO8inXipOp7
 zaigKZE71GmDv3gBO0vPhHLkmIR02UghKhqKtVaw6RXZ3ehKuaqEFtF
X-Mailer: b4 0.14.2
Message-ID: <20250909-docrem-v1-1-dcc69059a5cb@google.com>
Subject: [PATCH] rust: kconfig: Don't require RUST_IS_AVAILABLE for rustc-option
From: Matthew Maurer <mmaurer@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

The final version of this macro does not fail in the absence of an
invokable `$(RUSTC)`, so we don't need to be careful not to invoke it.

Link: https://lore.kernel.org/all/CAGSQo01mQfcU1EiW53be1hcts0c1p-HQAab_HBk6VcVmhq3n2Q@mail.gmail.com/
Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/Kconfig.include | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 33193ca6e8030e659d6b321acaea1acd42c387a4..7d9a0b4f66a9667b2cdc9d7e87c582487476f311 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -70,8 +70,6 @@ rustc-llvm-version := $(shell,$(srctree)/scripts/rustc-llvm-version.sh $(RUSTC))
 
 # $(rustc-option,<flag>)
 # Return y if the Rust compiler supports <flag>, n otherwise
-# Calls to this should be guarded so that they are not evaluated if
-# CONFIG_RUST_IS_AVAILABLE is not set.
 # If you are testing for unstable features, consider testing RUSTC_VERSION
 # instead, as features may have different completeness while available.
 rustc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(RUSTC) $(1) --crate-type=rlib /dev/null --out-dir=.tmp_$$ -o .tmp_$$/tmp.rlib)

---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250909-docrem-149a48521128

Best regards,
-- 
Matthew Maurer <mmaurer@google.com>


