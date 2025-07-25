Return-Path: <linux-kernel+bounces-745145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A87B115A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C591580F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680519A288;
	Fri, 25 Jul 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31+4+doQ"
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08C40856
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406138; cv=none; b=fY/J8mo+eH6vza7GvGftqPvWfk8oNckGalbh2/fxqZcjBmBtLg/dz8G0OKzznLTcYQINDlW8G/X51vQI3uJhJn2zG6vVIPNw9kJEucYl9H+9+FvFKSHNTIgbsUC1YdNRf05iQlj7GUubVDNvm+WDX/fuKFNogVQIwycEy3J6Qc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406138; c=relaxed/simple;
	bh=9d2LgkAsER9qXvaUPfEoLgpaLUIRkRofct2D4FWudKI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZxykvxHRqsk0KR4KPx2WhEXGbYdqW24OH2dpZ0UVoXLGJaN/nDtELKoWT/adXw8e/15v8HdARakjMwXGJ/Yeg29fdjRmwXft1B/ieppZ+G19OdwP2jQqhfiNuomayPgXsu1fkSFJPWqgDCcA/Gta0YFlNJqeDNCwNDG/uYsAT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31+4+doQ; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-86d1218df67so169602739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753406135; x=1754010935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tFITuuJDgutpEFJlerPyHHpSB0sfh/jbjTlG3FOcAgo=;
        b=31+4+doQdWFBU5yROK0V0upG7crHTpa8z8IEXwsYndxUFcIhgUmvcPLpcwZ5hOgOfs
         kpPFvUscoUJPSRpQoKYv/dhRrGFPyRRC4Q1hQUrL9674MntEALWfplzkjborBaBpPdyQ
         GdIWkAPtRvfYn94VvRCdxNijWgThtLn3tE0WHeqPfKDVGgiytx+frwy7pSLSinAZzro2
         hR+7Cg/6aA0e8vgWOAR59fiiU9vFdxraprIKPF7kMI5aZVKyp+IaNKN2vfeYeBHQDTa+
         DVsiXQT6MInYRgRT40gdmoxh7nYGVhwOVwOCqvzZrcyeGtJDr13AJxfHKRPpgPI/fSIr
         rHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753406135; x=1754010935;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFITuuJDgutpEFJlerPyHHpSB0sfh/jbjTlG3FOcAgo=;
        b=B71vFV05m8oBO2zz7Wz6tcHLNMHwh+L5bi7BJlh51Ab1gLZDTPydiz9clc8Szbg6Qo
         6U+HtJ6W4a0rxHq/BsJSy51xK2jRJp02i7Ls6PI9EpMy/wRHIvCVqZLrsKsvs2NI5wSg
         v231iQ6OAADgt4cCXEnX/UPK11TVy+j9CIUbCz93IpEeKI1DDRC/FTiKW24DAFC+beYZ
         xxD1hAm1FdX6jARXBnv57ymG1sgqA57TDeYAOcl/4Az1I3KX+Aa1gclpaioTPWuvrnLm
         NyswwIroq4dfzU9aqSJqBXxlcjsLBuIlFA7e0sk5w677/7HABnUmln5UnzV4mGQSewa0
         osHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2GMoDD8Bqc873QKd3pgQYcs8FFrlWMIz65/cJ/wY/VE8RCDnOuq9QooV2UTTwcE0RGaiZTICu5JMF3jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAKghLKEsBNggTrm2ULBC3+Hr/Vvc4r5IR1PcZoyL8fRwESf3
	QE1wdj7m0pCineIOeM3fU8U47i4/lLltb2xjjWaX1JL+SQTviImHniqXD8zxUrX4CDsHrZGegJu
	sez8wAs0IvKvZqjmhmCAM8C2zyA==
X-Google-Smtp-Source: AGHT+IGOtyjrWZUt4IHge1YVAFkDgbRkTc1qBa9LhfCId/pQ3L7S/vw2KQQqW8B0agIZPE8gkRvP90/rdal04fwoGg==
X-Received: from ior10.prod.google.com ([2002:a05:6602:a00a:b0:87c:359d:819])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:1689:b0:867:6680:cfd with SMTP id ca18e2360f4ac-87c64f87d98mr1663521139f.1.1753406135096;
 Thu, 24 Jul 2025 18:15:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 18:15:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK/agmgC/x3MTQqEMAxA4atI1gY69Q/nKjIL20YNSJS0DoJ4d
 4vLb/HeBZGUKcK3uEDpz5E3yfiUBfhllJmQQzZYYxvT2RpdjX7loHgIS0K/SUy4J8WOgutb43z lAuR8V5r4fNfD774fh1uFv2oAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753406133; l=1391;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9d2LgkAsER9qXvaUPfEoLgpaLUIRkRofct2D4FWudKI=; b=Az97+z18RNg38lLclau+LqNY25wUxs7AH7etlMkLkQAjtx4UrkJ/fucCvYO1m1JtsrhW59gi2
 O2QmudrpqmkA3awdm9rNP+my9CyxHVn9/w9CtSU5eSYTY9DSciiwM0N
X-Mailer: b4 0.12.3
Message-ID: <20250724-b4-clidr-unint-const-ptr-v1-1-67c4d620b6b6@google.com>
Subject: [PATCH 6.1.y] KVM: arm64: silence -Wuninitialized-const-pointer warning
From: Justin Stitt <justinstitt@google.com>
To: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Tom Rix <trix@redhat.com>, 
	Christopher Covington <cov@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, stable@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

A new warning in Clang 22 [1] complains that @clidr passed to
get_clidr_el1() is an uninitialized const pointer. get_clidr_el1()
doesn't really care since it casts away the const-ness anyways.

Silence the warning by initializing the struct.

This patch won't apply to anything past v6.1 as this code section was
reworked in Commit 7af0c2534f4c ("KVM: arm64: Normalize cache configuration").

Cc: stable@vger.kernel.org
Fixes: 7c8c5e6a9101e ("arm64: KVM: system register handling")
Link: https://github.com/llvm/llvm-project/commit/00dacf8c22f065cb52efb14cd091d441f19b319e [1]
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index f4a7c5abcbca..d7ebd7387221 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2948,7 +2948,7 @@ int kvm_sys_reg_table_init(void)
 {
 	bool valid = true;
 	unsigned int i;
-	struct sys_reg_desc clidr;
+	struct sys_reg_desc clidr = {0};
 
 	/* Make sure tables are unique and in order. */
 	valid &= check_sysreg_table(sys_reg_descs, ARRAY_SIZE(sys_reg_descs), false);

---
base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
change-id: 20250724-b4-clidr-unint-const-ptr-7edb960bc3bd

Best regards,
--
Justin Stitt <justinstitt@google.com>


