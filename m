Return-Path: <linux-kernel+bounces-769288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87DB26C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7AAC4E3ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EBF253B52;
	Thu, 14 Aug 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBQo99wL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CD22CBF1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188590; cv=none; b=hVNE37e18TIIPxfpcbPdHXHaFJFdrlWfDlyC5HFLBb38IVCaOd3n5Fv3ZfpqXadEwlAmjmshICi1ZNQhmQMPkX2drfHo/zTepNW2hfQXagu8Ec8+YTt6+HO2Y+RCUiYpMiNmBAhiyxQmus8g7O0kNlKqxsjqGkQBZMrgOFRWTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188590; c=relaxed/simple;
	bh=AEN36PmgyN9jzCWiDGkGUayCiskyZP+8KyliUZDm/Jk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oAwdEM87yz92ap7ox/LlDzPCGhs+hbC0cFNJNQThI/+NEjzpRy2ttfYDpnIA6lDbRbL5OJ/PWXO+pJeU7iHBuyrrz5ghZT07zWvFW2w3TgqjyecWHPLO/gFk3fK/goaBWCpbDU67B50dq0PYhZ7JLGHDutxTTL9J98bbl6Dmp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cfenn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBQo99wL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cfenn.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2ea9366aso972036b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188587; x=1755793387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFmrZCX1rf8ycDJAIRjNPjQ9vGNsMosDYblKELZGZ2U=;
        b=RBQo99wLXfCM4cURsBTQ1ZcIMHEm0LtdmszEaQ/t/EWx5hCL9jDPTKw2Ot91NgSzhs
         Uvq8Sb5PZ/CBrwVxU1Kl5LgtbnoDX3WIFoggBo3Ev1qY9/2jOUz0GxCnu47FfTqgY1N1
         zOSppWwqgAZNzt8kOWjbwXLzVc6Gh8tpVhrDM/WHI3FgqKixmIplpthaxf0I21XGP0ZN
         yO+M7KkbEfzXkhp35aJ8Li1minGEyZQN/pgGP6XlThVu6PgBUu3HA5dcmZeNlNJkQZA8
         MgCau5UISlDsJ/+ZFM0ucWkRYBgvFx6SpsX5uYegoR+APgjbk4pq3cOJSx52/o/sCkig
         d4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188587; x=1755793387;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zFmrZCX1rf8ycDJAIRjNPjQ9vGNsMosDYblKELZGZ2U=;
        b=nnKN1TtUVanfcjeqXIMG7hgbaK71n1V8PPw4fZKSRKnnUFjKyUuUZUAVwCXnzhgFwd
         AWOanni7qEImeA73LLEjvmWXCkfgsnT+EF1F4/xJ2YzoKM83AJCiMCjYGDk5muFRcIqd
         KnPhXLXJZ+ryLfQo8F/wU/ep8oO6VVDQHsyzXiP5WFkRbfjQjNRRQeFJtsff6LHJl0u1
         okZ82jDQFd8t28NLvR5DntidWLnWynzybvUIdW7G9OIwHiqW4kAMKQ/ckhz/oxyBYP+f
         ClL6qYhP7dLAHrQKALRc2zRXDDXvIbT+snEihGAq4TKu6fs7bj/zYc4wELDgkZJzUgrN
         v8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVxlklTtjWKNR3UGgzX1w8+5W7H5Q+R7/BJm2EIkOGgN7ujDueBmBSN0fTBLK9+dvaONGJGt94f5Boxcfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9dKN1AEDwBH97mjfpRO8wcTVyjeOkBGnD3KCPlIRTpjbPW4Se
	eVveKHqLbyRkCgIzY1/j2jd1Fo0I3kpV7PrvpSQ+9RJB195uJunPkMmNLkkCkXwXseDzySlhzry
	C8w==
X-Google-Smtp-Source: AGHT+IGcd07zjsRHCN+6GTJdRqh4GjZhv/t7J1/kavBrrK68F0NKZTofb+1eiVL2rNI7gfhN5uqB3IK/jw==
X-Received: from pfnv9.prod.google.com ([2002:aa7:8509:0:b0:76b:8c3c:6179])
 (user=cfenn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b52:b0:76b:ef8f:c292
 with SMTP id d2e1a72fcca58-76e2fd9259fmr5310386b3a.16.1755188587488; Thu, 14
 Aug 2025 09:23:07 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.215.g125493bb4a-goog
Message-ID: <20250814162252.3504279-1-cfenn@google.com>
Subject: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
From: Chris Fenner <cfenn@google.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Fenner <cfenn@google.com>
Content-Type: text/plain; charset="UTF-8"

This change disables the TCG_TPM2_HMAC feature by default to resolve
some driver initialization failures (with certain TPMs) and performance
regressions (with all TPMs). See "Security remarks" below for why this
does not meaningfully downgrade security.

When the TCG_TPM2_HMAC feature fails to initialize the "null key" (see
tpm-security.rst), it will cause tpm_tis_core_init to bail out early and
skip device registration, causing all userspace requests to /dev/tpm0 to
return ENODEV ("No such device").

TCG_TPM2_HMAC depends on the following being implemented in the TPM:

- TPM_RH_NULL
- TPM2_CreatePrimary
- TPM2_ContextSave
- ECDH-P256
- AES-128-CFB

While the majority of TPMs in the ecosystem conform to the PC Client
Platform TPM Profile, which currently mandates most of these, not all
versions of that profile did, and not all other TPM profiles (e.g.,
Mobile, Automotive, Server) will. The TPM 2.0 specification itself is a
"Library" specification and does not mandate any particular commands
(and very few features) in order to maximize flexibility for
implementors.

The TPM driver should not break userspace for a TPM that conforms to an
atypical profile, therefore this change makes TCG_TPM2_HMAC disabled by
default. It also adds a remark about what will happen if this feature is
enabled and used with a non-supporting TPM to the Kconfig.

Some real-world public examples of problems posed by this feature:

TPMs that do not support the feature result in broken userspace starting
from 6.10:

https://wiki.archlinux.org/title/Trusted_Platform_Module\

Significant (around 200%) boot up latency due to all the added TPM
private key operations:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2080322

Security remarks:

tpm-security.rst describes the threat model of the TPM2_HMAC feature,
wherein an active interposer adversary on the TPM (e.g., SPI) bus
tampers with TPM commands and/or responses to interfere with the booting
or running system. The TPM2_HMAC feature uses something called "salted
sessions" to establish per-request keys that can be used to protect TPM
traffic.

Because the kernel does not have a priori knowledge of a cryptographic
identity for the correct TPM for the system, and because the kernel does
not have any cryptographic identity of its own with which to
authenticate itself to the TPM, the session is established using a
one-sided, unauthenticated key establishment protocol, wherein the
kernel asks the TPM for the so-called "null key" and uses it to
establish the shared session secret.

This poses a serious problem for the threat model of the TCG_TPM2_HMAC
feature, which it resolves by asserting that userspace will attest to
the "null key" using the EK after boot and compare it to the contents of
/sys/class/tpm/tpm0/null_name, exposed by the TPM driver. However, this
creates a trust cycle: we do not trust userspace to perform this action
correctly, because we do not trust that kernel correctly measured
userspace, because nobody has checked the null key yet. An implicitly
trusted remote attestation verifier also cannot be relied upon to do
this check, because it has no way of knowing for certain which key the
kernel actually used to establish the TPM sessions during the boot.

This should probably be discussed in tpm-security.rst in the future.

Signed-off-by: Chris Fenner <cfenn@google.com>
---
 drivers/char/tpm/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index dddd702b2454..ad419ca97b8d 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default X86_64
+	default n
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
@@ -39,7 +39,10 @@ config TCG_TPM2_HMAC
 	  communicating with the TPM to prevent or detect bus snooping
 	  and interposer attacks (see tpm-security.rst).  Saying Y
 	  here adds some encryption overhead to all kernel to TPM
-	  transactions.
+	  transactions.  If the TPM does not implement a command or
+	  algorithm required by the feature, it will not be registered
+	  during initialization, and userspace will fail to open the
+	  TPM with ENODEV.
 
 config HW_RANDOM_TPM
 	bool "TPM HW Random Number Generator support"
-- 
2.51.0.rc0.215.g125493bb4a-goog


