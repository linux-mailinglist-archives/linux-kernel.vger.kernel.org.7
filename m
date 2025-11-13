Return-Path: <linux-kernel+bounces-898466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24AC55556
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427A94E12AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148822BE04D;
	Thu, 13 Nov 2025 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="cMIfCgiF"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7862EA169
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998441; cv=none; b=e38kCRDwa4FDmI/HlVcfk8a8EEfUpUG294iJI7KDqpfRExmLWygfyKmCLafBce6/BmMHVxF3pp55UYgE7gvooIQB+lg01OO/Yztj+ZZYJ/R4aSweXGLBYHLIqVPYfv5s7vQ/KA8j5XVqYa26s2ugg4j156mK05qCRR/DKtWSvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998441; c=relaxed/simple;
	bh=iLgqPY34e6LHnAK1SrHQ7ZHSON9/8Yws1CAsFU3netg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgh59vh2eHYfVT7UkcKxT5Yt813q/mGzaTsvapltNpk4avFY02aiTte83fJ4wMERAiEeCiHiKmirTuhnvmb5l475D3S9q8E8so3NzKj6NbeBycnTL+wOC+TNrsAoymn92BX7gC4lJw8yuR0BSL1KHHxPB28JPJWHs+4sB2knlAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=cMIfCgiF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc0d7255434so186270a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998439; x=1763603239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61IAp/RLZglhPiTIaYZ0zqBWXh5TU3+Z1ZyRv4wlW+o=;
        b=cMIfCgiFpgZbr5MtVWRz9zCHhtaomfBI0eXgVtTUNJpHGlqnbovUZHaRIML8Tb7vR/
         Xkc5dRVRhVP+idjgATGWQiHk7sBxIMSNcXt30QJa6A+sXZ8dcl8gaoioZdJGOhXGnbsp
         omce5Y8q/F7Qa7E2CnPqpVQh75muVWUl34eIV9p+YBwSizZp0ucZLc8oMAV1NNUyGMbL
         lT0G+MLZ4yLzFt5h8UrhRM2WJgy+1SfQ6iTQeRUioxL7wwjIA8wFWdqnbBDJFSXw7Egv
         1Vv+N0UEEirykp0415yBp3rrwjfkvWpn6Qse0JPbLDlrkZsQ49M3LYzlzO0DOnzhn81e
         bSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998439; x=1763603239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61IAp/RLZglhPiTIaYZ0zqBWXh5TU3+Z1ZyRv4wlW+o=;
        b=bCmqWH381+kPrWVjSGTfbF0M420OHgKQrhTgN51R7CqnaQl/C6P+wwUKx7FCXSzhbG
         0lGOXZlIFUomY4xPKqvijs+z6/akx3MpI4Ps55c9wSi/0WRWms6wpXy5zRZ/E/a4ExT/
         jcvuraEkef8aw8dvAMeoKCWobPwb2X1e2ruBnXWEnJd53nHXurxehhYtePtXCeGtJiWA
         PHpkCW85iHJk22Shyy2NDH575w5yUZBu8ZtNBfbTfPoNA8Powr5uMzLR8oUxfiH9R+hF
         ugmj7Arm+dUmJbNlNXpS15xmB1WbsWKzFUCm+8GSEovYYxj40Z4/SXeKprUASop3vk1s
         vmCg==
X-Forwarded-Encrypted: i=1; AJvYcCXCMJS7Mt4ONC5YkH8RsysV2jyNlwtZxOotVyW4c35VjwgVEftSFfCbJi1Q2Swkmxd8l48L7oUMK1jCr5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGaaO48WEq0vyiG5gR9lOic1ihwiNnWd8a7JoD7INvZZMcJ7Co
	gxds2gEsnQ+WUUcx2ChTw093SoFGlshG/oYcs0ur6r8NIv8YQbzonocnWf7FS9gQvDg=
X-Gm-Gg: ASbGncuNoMPTmtDnYZN3b64l0PZY8lOc7xXmelZXIXWWkjtLddaCeNXqTWOR0lBiuUU
	q2J0RN5Y8/PGQRLCOb4Q6+jlkT36wbgx06lW4Dse2pxinHKgg5+h3NFnE0SNNJgZkSwvX61hnKK
	ZYJsw5XFG7NHTjSPQFsT6lfXsbL+9AX3Uj4x8iWODMw03F27iiMEDJ0gaSdTBE1uERT+abmSQze
	s/mZBp7yhKzGXoeRz+hgjrCY7IEG2zcmtOsEBZsutqDCzrfsioVkhQWZMv/Kuf3/xt0WlL7KLrq
	+3EjdufZ19ex/QMdqLL8DqWcUs1SEYqWpK57ziPUWXvUTzKXq0u03DUb7WIFJaeZ6nCw3skngRA
	KbQYIyTJXY4MirzDNpLBzkVUvitYjzMzdI9CCRCqQbOpc/QTshgETtiTt7IdtboT9X/K2LZYYXp
	z+u35bxG3dWMEYTGS/WgYkgg==
X-Google-Smtp-Source: AGHT+IFQeTKY4sW5xPwKJekSx5UPto2J8a08JXV7cfYp4pOZ2iobnw+lqJ4IrO6RHskdtg/6++UDAg==
X-Received: by 2002:a17:902:e5c3:b0:295:ed6:4625 with SMTP id d9443c01a7336-2984ee0459dmr58942605ad.47.1762998438873;
        Wed, 12 Nov 2025 17:47:18 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:18 -0800 (PST)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 13/22] riscv: ptdump: Only show N and MT bits when enabled in the kernel
Date: Wed, 12 Nov 2025 17:45:26 -0800
Message-ID: <20251113014656.2605447-14-samuel.holland@sifive.com>
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

When the Svnapot or Svpbmt extension is not implemented, the
corresponding page table bits are reserved, and must be zero. There is
no need to show them in the ptdump output.

When the Kconfig option for an extension is disabled, we assume it is
not implemented. In that case, the kernel may provide a fallback
definition for the fields, like how _PAGE_MTMASK is defined on riscv32.
Using those fallback definitions in ptdump would produce incorrect
results. To avoid this, hide the fields from the ptdump output.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/ptdump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 34299c2b231f..0dd6ee282953 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -134,11 +134,13 @@ struct prot_bits {
 
 static const struct prot_bits pte_bits[] = {
 	{
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
 		.mask = _PAGE_NAPOT,
 		.set = "N",
 		.clear = ".",
 	}, {
+#endif
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 		.mask = _PAGE_MTMASK_SVPBMT,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
@@ -214,7 +216,7 @@ static void dump_prot(struct pg_state *st)
 		if (val) {
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
 				if (val == _PAGE_NOCACHE_SVPBMT)
 					sprintf(s, pte_bits[i].set, "NC");
-- 
2.47.2


