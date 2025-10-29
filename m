Return-Path: <linux-kernel+bounces-876483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00921C1BD6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9766A5C9918
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D342E040D;
	Wed, 29 Oct 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE76H9/8"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD796248F75
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750586; cv=none; b=HqVIr3+6FrATYXLl29Wr1WHHzB0CmFtrTtZ098xJJSwcfhoAXJehTzz6lU3hRYs3EFGweuvpOVIPflzz4ormoKqgS6R0SrX4SvwxhgfEm+7Mntc2VQIsF4O1ce7lU18YzdnooS9cc76odJd2S02h0Dh+6oqbDlB69mgZtE/qVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750586; c=relaxed/simple;
	bh=mub5xq+d3zwD3Tp9LeI2+uD7gtWzrddfCYJvWD4LlFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=It2TGEaPzw2hmfwIawlchPEMhBo6Otrj9kbOUhROd/PvlFJ1he0NK5QxKvf92vz3L2hnzbtxOdKBRu7fuW05pXj13Wb2zeLDQm9Iq9Isc0ywtoj2DPm+BPos8TDP2SDqvldRoejU7k4bc8/Z5Xx7YlOiO+KjWOfignaRjLb5tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE76H9/8; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-421851bcb25so4525045f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750583; x=1762355383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDVcuv1mfeIpSK3q83K0a2QfXRJdbHArp+wCNkw9rZI=;
        b=IE76H9/8IsDiife9EzjaxPnjZm7teCC+SifZM8uND+dHsRxR6UrSWljzJ1EmoOKEhr
         VQ/FMghPQ2PjvDGscj01I1pSIKsIaiGxM6u+sy7VHse+3udhy/I5aU3WFRMU7kgJSN9q
         NP06QVmQxX1U+uBmIZgedVnB37NkRvz6ABPkommTgbo4GHcnDPq9+4GDMMLWIOAwOmtE
         d2YsBTKp/GXuN9UH9VCPxpUWti2fabWKjBmPsJHdT1ZvUgEzzJnHLrGRTSo2kAh0N7SB
         ZnPnxAjqzqOGYasAAuYuGikzz1G+/+76yYJbQYT+zwpxZY6SMp33RJnsXOsnTEhG0j2a
         fA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750583; x=1762355383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDVcuv1mfeIpSK3q83K0a2QfXRJdbHArp+wCNkw9rZI=;
        b=BXJYU7GtbxNCMGXMmyzDgOqtXIJmyi4w9eu2k80VnpNKcXaGpRJRDrnEyuEg8X9Vf4
         t3ad7bj89edaoTO/qnE+UZehWrtDqAxNPf7cReAePGe3TyGUuKATAlz8P+XPvmgwmtBK
         xAhvs+EZNiLGMBQkug7Q9fnZsRuzpMgHeMYib043TKZpmOx/zTyELwagdmI61UnV5WtF
         r1WA+ZPKnTmqtDlUNM1rrzrRrNZR5ctz888AytAEmyg+e+d13gwCs/gO0CeqgbcwoJuu
         OPkak2WEJjMGDsKOkWyzj/hYRGZJjeyEc/z20kyBgt1fjKFo3qqnvskLUCFTWAK4NfvO
         iXPw==
X-Forwarded-Encrypted: i=1; AJvYcCXycHBQEqZSQGqomBlYea430HEazCBjrpsnL4FXmfUlbJepD3l5PV8e8gJ+jedr1NjZtYyL7GR685GrDjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQN5wq/l6G1tk9y370B8Pm73ahLvO7QIKER85vgKU4fVvJMUMw
	QexbP53NFq3LfKAEMGMtaSHByEtrwtKO6j6F0mbEBITh/qYVWeJbznLW
X-Gm-Gg: ASbGncuT3UrEN6/GUVzf7qs+7ZuW6+qNg1GfdF/UCeCywiTt/JQ3TVhp1UeZuFaISi7
	A+vbXFp6CoWS/+PqsZ52CrNbJWFy/ompjvbdctCeAdq9Ql5BSs857zvafKpVnIzt8x+S2eQhpKH
	NzG+rtbud4C24Vvb7bB6sykMvDXLLR0atuwYspD8UPJxXWvTD8D4yMaPRcUPMaWy+h1lvl9yA2v
	e3p+JWow4NRF3rMNF11q1x8hLe6OCiBKG4aJhAzIdBOju4ca0hj+RCXNS11EOZe//Oju8imwqMr
	y41voTdZN+QuaR6R52zgUP3wzx5Q6SCWo952NYmaN6615m4kgeWuwjWzF0wSxeRrAruyLAoa5GX
	Utco4OOtidFTYrJrFKWlcjO8NM87PMvEi/DrJ+jGuvjinpDOeZsknnQbugKXHs1dI+NIYyE6iEl
	JyECZxOTd/My+decwWcYYVmCEpQusmrDkfiCtLdt0ZW8JVCmoRt28WlypFUfiLgKRtA38+
X-Google-Smtp-Source: AGHT+IFr5lXTMPj28TgIXEQnhqGrZvFG8wCr+BEM+nWtQqin9EbEnz1MWXEHn3P+VkAb6rw3PLOvqA==
X-Received: by 2002:a05:6000:4712:b0:3ee:109a:3a83 with SMTP id ffacd0b85a97d-429aefbe00dmr2910419f8f.29.1761750582940;
        Wed, 29 Oct 2025 08:09:42 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771e3c878fsm54565375e9.17.2025.10.29.08.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:09:41 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arch/powerpc: Add missing includes
Date: Wed, 29 Oct 2025 16:09:38 +0100
Message-ID: <20251029150940.2523328-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

Hi,

I've recently been doing a few test builds for some of the more exotic
platforms out there for a patch series that I'm working on and ran into
some issues that seem to have been caused by the framebuffer include
rework. I see that Thomas did address some of those already, but it
looks like I've been running with slightly different configurations or
something that caused these additional ones to come up.

Given that theese seem to have been broken for more than a year and it's
not exactly clear which commit it caused, I didn't bother adding a Fixes
line, but still wanted to send these out in case we want to keep these
platforms building.

Thierry

Thierry Reding (2):
  arch/powerpc: Add missing linux/of.h include
  macintosh/via-pmu-backlight: Include uapi/linux/fb.h

 arch/powerpc/platforms/powermac/backlight.c | 1 +
 drivers/macintosh/via-pmu-backlight.c       | 1 +
 2 files changed, 2 insertions(+)

-- 
2.51.0


