Return-Path: <linux-kernel+bounces-745087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D89B114B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B9A1CE3F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA532E36ED;
	Thu, 24 Jul 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lgsFnP7Z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9272451F3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400236; cv=none; b=foSckNePGdDWVHAHuuwFyiVjMiZHTTuOMX+QqD6keZPDEV+nG7uYFlTl0Bd7djx7vPg6bM431gCfgkScN/QcfMzA4Jy8DOqf63xTFmsnw+4C6yOtN2CrIkumACEDs0+ajFzMk+PgJHDXuE8mUK6344mFyo+MhxHm3sjVATO6zkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400236; c=relaxed/simple;
	bh=Znz4HWUKeUDrvSYkQdDugVKK7rHsODYScSSfQiOAlsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpXlaKWwEXl5nFrKiY7A1C5mg6ZRbXa7C8wep1qXbduii43mOL/L0vK5QN/2u3ShKPL/nvFo947AMJ8N6MpYShC9x9ZB8K7aF8IYC1upFr9acL3imB+riSI/mLjgGWd/K4V8meUnraRmii2rdkEG827feRAsvdmQhSMmpnk9bG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lgsFnP7Z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23649faf69fso12757835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753400234; x=1754005034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAeHR6jMoeNreT1rLi4tkifNH7GwHO7F0FWeni164mI=;
        b=lgsFnP7ZIEeysxH1adfOmwPF9uqTzuw/RibcbSZs27i/5zDzhcuHX5w0/alwXJt1Zi
         oQN0HjQqg4XHIQF+3nQ1j1JVCtEL27hgI+7BmOdAiHfkCWqsldvWA3/48jQE/2xT9GJk
         4VW1iYPUaXF41lZMR2ayCWK1qPE70PBWEKN4GmZwBSBjnazn65XLD0pBMyQfCelbn8OG
         uB+UJN/E9i4sgcuGXiKWtsQHkc0VgEDTIIWskYsNpV+BJDGVBq0lfX4c82g94F+oZjka
         ulN7RVLZPVxHi7blBgT/DLWSgMSobXWBfZ9HrZIjl4QDEPdeQ9zRD6JOYx4r5KxMfah9
         ptLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753400234; x=1754005034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAeHR6jMoeNreT1rLi4tkifNH7GwHO7F0FWeni164mI=;
        b=hlIR5tVAS/o7ojQ5EvNLFTlPW76aonT4fPsq+Wmdzoxq4vVPrPAwPAqj7O67peiCw4
         cKGeubR7mQ9KR+cmghMkn2Ep6OFTvVJOfgwGjoJaadwIc68ILsrXsNR4tAoKYES83wYc
         S2o1Ddjb0JHjDrBu+2y4KwWZ4+dTYQH1kbq1E9FnHYnjUdtDHcX+Dbq01RYG+XwQPwx8
         9XJEvHupgh3vFf0bK+N63ow7022dZpO2bGwIofvmtLYG+drNkRnAxb0RKBm2gtCOwG1j
         zxEBheIBiBzPkvLJorNZ5zj86DpFzvJLhSlDJp7TBoSgsAVEWHenLDX9puX7W3OQz+p3
         Qy9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtALFtx3YZpDQQ3juInJ/L3lhGgbotjRGeuvzyJZq6bFN1wy8t7GuuKMJL/hA3P/cd2ctcZEiD3naURBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVXFM/qiD4A9OqWkxJMSbyRqDKP7yYYPPO8eI7s56suKFVZSB
	XeewvHAlvwTdyLgQYnpcxynV5R0X6q+F9rl6DS/Di2pkkib6dUVcw4/oQLBONWYOEeA=
X-Gm-Gg: ASbGncvWvFT2lN9Nuch1SbMcWIO/EhVdGZ5WGYuil+ruB9MU9xoeNwCkmRthB+kkOaH
	Me55zXeHA7GmWxCW0g0GcPVa74NUQSZqvJuzdVvN4LWb7R25ieysBTqgaif+rys/eYbqRXuThkQ
	2hd0d66l6pqalo5lq5mtrOt0OrpTVmlfXbwJf9gpNj1994CYwA5ajdAO++lEU0Pb2ylxXXQdRjM
	1sor1vSv3SZIM287eVLye9bFxTrefa/IykGXU2SdZhQqKQYFtwmdVKvx07yaYGX7Fu3uDX2vw1r
	IMPaBFfqFQ0JZS4qypHUKQlEqjXgHwMEG2S2CqC7jnwLbpGvK00MtiZkVLu0132mrkTEyqjTz45
	PGBEZTVKDymeqO80cA+xXqYpuV9rq6pZ+SexJ0zeGvIA=
X-Google-Smtp-Source: AGHT+IEC6umj6Lj/bljHcGk8ktP/FZKxktXm+XIJAAVaqHXn4oZH20sfm15h9uxx49Sr7WC6JzXzDg==
X-Received: by 2002:a17:903:3c2b:b0:234:adce:3ece with SMTP id d9443c01a7336-23f9813ab07mr115991405ad.11.1753400234285;
        Thu, 24 Jul 2025 16:37:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc706sm23598685ad.106.2025.07.24.16.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 16:37:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Jul 2025 16:36:57 -0700
Subject: [PATCH 04/11] riscv: exception handlers can be software guarded
 transfers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-riscv_kcfi-v1-4-04b8fa44c98c@rivosinc.com>
References: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
In-Reply-To: <20250724-riscv_kcfi-v1-0-04b8fa44c98c@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Monk Chiang <monk.chiang@sifive.com>, 
 Kito Cheng <kito.cheng@sifive.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 rick.p.edgecombe@intel.com, broonie@kernel.org, cleger@rivosinc.com, 
 samitolvanen@google.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
 conor.dooley@microchip.com, charlie@rivosinc.com, samuel.holland@sifive.com, 
 bjorn@rivosinc.com, fweimer@redhat.com, jeffreyalaw@gmail.com, 
 heinrich.schuchardt@canonical.com, andrew@sifive.com, ved@rivosinc.com, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Exception handlers are static and loaded from readonly memory. Control
transfers can be software guarded and not requiring lpad on target.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 598e17e800ae..3f0890b9c0b9 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -224,12 +224,12 @@ SYM_CODE_START(handle_exception)
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
 	bgeu t0, t2, 3f
-	REG_L t1, 0(t0)
-2:	jalr t1
+	REG_L t2, 0(t0)
+2:	jalr t2
 	j ret_from_exception
 3:
 
-	la t1, do_trap_unknown
+	la t2, do_trap_unknown
 	j 2b
 SYM_CODE_END(handle_exception)
 ASM_NOKPROBE(handle_exception)

-- 
2.43.0


