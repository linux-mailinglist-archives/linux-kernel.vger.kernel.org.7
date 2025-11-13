Return-Path: <linux-kernel+bounces-898470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1CDC555B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82CA134B019
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB5E2F291D;
	Thu, 13 Nov 2025 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="izNJ5Tvu"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9802F0C58
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998447; cv=none; b=MSBbX+GxiwEj7FIffVMVoj6+RGyX1RM6B2UwBJhsktNa3cBBxmwFfHMJuMiBMtJVLWmmFGnnOMMZcIJd4QX+alfbF9PcLDIDFxzSdwcpl9Y9yMX1nqsCl4lRLZ7yI9guCX2GHTdWjIs81/X6+eAi+Hyn6aq+8iYjG6mxd1+DZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998447; c=relaxed/simple;
	bh=7U/3jWkDl0qA7lpXkEq5MXx7Raqg0ckxjMa3eHyDnac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoWNbC87dZEhz1UCJrxsSkjhFsVYF9Nz6MZAgTP4hXO37nn99/Vu7ckgWIbLyfvEydGzjwXnk611embtEmvzsBHBhRJH7iLZb4cNlAjLKdjAxaZuI7cDk9U56QiLRuHHziMlnJuqzh4Bx3VcwQSbbbpozxB2mu2sNjQMdGxiv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=izNJ5Tvu; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98a619f020so215327a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998445; x=1763603245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnUrJZR22oRvK4b9Hq0rnS55dGa+J0g2wL6xk4xR6+s=;
        b=izNJ5TvuJX4M3VQMrXJO29Ggn6MJs4AfQTdLCbZ6Kxu80+uZfhC+qeWWTXj9+Szfoy
         bzCfJa0FXykm5GQQH4dUNOU9sBlUXUSEAJNy4pNz2LJDJxpClDFUulPj+AAkoGh4HfUJ
         C+t1N/ivr01Cs6VXTrgQMN6xvvLwqwMVy2iFe+k3qchB9I2Z2WWT+l5PvSf5cftlRrmU
         Th1MfbCr1VwdskZvln0VLAnGY0koj9dk9BYTznuoFg3Ulk85qm4+pBuKxfFTRGArN6AH
         HYBKaeq93L0JKLISgDbQLT6U+kPoLyz7Td0MDmwszIXW1Kbv5EkkzJvF2bvHskUBU7st
         fjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998445; x=1763603245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mnUrJZR22oRvK4b9Hq0rnS55dGa+J0g2wL6xk4xR6+s=;
        b=umtbhEOTmtuLnXgqRI+dyjllOwVjLIEY+NCJrvV1EzivOlZ+Rqws1WOlTMNgNVWkMA
         RXDMENY6P6CtqZPgLAjd+x4ZxAaEvGbHUcNqST/aiYsBrT6CyU8sSCxjOoO+XVYiqGVM
         rM9szmuROOJHmUIFUh16l/SrOFw1XefEMilDNJbOHirbNzF4csdSXEm85yR4v47CZJJP
         v5RZ3xFUc7IV3sEKPj1JInBi131+7TytnchmDw9zkiyTfp+ez+krkTUJ/fjMrNhnNQVV
         LVOLaW2bvQVEhKgqMNP2ku96q9aLrUBgYmEFuFgVDmYWjC6t462cbrg+7zdS5CVR1vmq
         kfBw==
X-Forwarded-Encrypted: i=1; AJvYcCUPxcEIRUH3BYHCcrTLIFmRBibgf9FcyGUh1K6MEO3QIPbDfkKJeTUphIM6lYkpWX4as872OXy4GAh39ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJ5DbTwNknO967wf7KuVmkvf2hiAS1qjL71IlOYqbOjECGEHT
	tdJwu4h4Fq7klC9omxjLXvjK/avZvS2BtLmWcTlQcSbMFutAU6MUPkX650hM59PSNSk=
X-Gm-Gg: ASbGnctRaR/FiYWbN3Hq1N5++o/ogdD8QOwQF2JCx416x2G3kgJt1MGQ7sbyVJ6S86h
	Nv2JnkLwji1ywIN7lxXh/Ghl65sSsvrGRhLQyDI8cg1eLIgLIZq1JaTGScn9AeK1DGZHNwNFy+c
	6Y+pml2Z0WHpeQLiPtBQfg6MNZCf97jFVHg2woNuGiK4se2GTu9rjrLq7+J7/9AsMoQSWIr0s9a
	JAL9khSTNETxzkVtlJj9PTZzqgtesQ+9xb/iVWYW3B4h9ry07mUBmpgMVeIfKno1SsgRsRdpl3k
	s9K6shQP0DQxSa4FMTWQn0NgMkb0KczB6DrfLTZWpywBu84CZWvQC8onwVWE8VyIZ1I/r/k+PC8
	7T1dPu7PQNjJP3rtf6dcgyXgfdhYa/R4BRwt1OKufQk8zIjyH1e6N2/Q4iqRr0zr+VX15eirh+I
	XhSZe/kn92qfuygnUn9ty7gA==
X-Google-Smtp-Source: AGHT+IFqAfqeVcZ22DpgtEmtnZ9MrEayC7yLg/9qX8OddaBkDjNDdLzIDATV5Jsr3mCugzkW5GzqeA==
X-Received: by 2002:a17:902:f54e:b0:28b:4ca5:d522 with SMTP id d9443c01a7336-2984ede9839mr68599425ad.39.1762998444849;
        Wed, 12 Nov 2025 17:47:24 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:24 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 17/22] riscv: alternative: Allow calls with alternate link registers
Date: Wed, 12 Nov 2025 17:45:30 -0800
Message-ID: <20251113014656.2605447-18-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alternative assembly code may wish to use an alternate link register to
minimize the number of clobbered registers. Apply the offset fix to all
jalr (not jr) instructions, i.e. where rd is not x0.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 7642704c7f18..e3eb2585faea 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -126,8 +126,8 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 			if (!riscv_insn_is_jalr(insn2))
 				continue;
 
-			/* if instruction pair is a call, it will use the ra register */
-			if (RV_EXTRACT_RD_REG(insn) != 1)
+			/* if instruction pair is a call, it will save a link register */
+			if (RV_EXTRACT_RD_REG(insn) == 0)
 				continue;
 
 			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
-- 
2.47.2


