Return-Path: <linux-kernel+bounces-660690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9BAC20D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AED05054AC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6322A4F0;
	Fri, 23 May 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LrY0UPrw"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76A1226CFD
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995668; cv=none; b=TCSmmRBqpgGNVL7FmP5m6FHN8nYk/amXo1RM96MmLgchE24MQ2bL23KtnfiFh59GSFipj/Ym7mh5WFKoAlcTH1kvBNyPsJ6ZBwW9kQs2NATDewVG3Z0KHPEGP7I4A4Hc1DCFrwVfmY3dduNvYBi+d2czKcDJnAzZtsZ4autVZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995668; c=relaxed/simple;
	bh=oe9YzhrIkRFjcEpmOMMHuXd74hPefU7Jr+/Rq21d1Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZnmMGkLaU53NcHYHzFAVYk0IPMsOrv4+AJ2MZTqaX21U2xOJ1gnTCjKSVUpVsl8YgCST2ZsmYIUy4P9GbcEXElqKlbmfCTzY5RdL9VH6SkPTXG3aXUK+kJVJ+sxC1uuwvPMyNGwrXlUAXXlYmM5myylymF4agocoonTX+klm8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LrY0UPrw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so8183122b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995666; x=1748600466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=LrY0UPrwtPLDvA/J0bNSHVUhjnjXI87L9g+VicF/2ooa8r4qxkG2rS0RtcGx3XtAjX
         arVUs5Hn34FfLre91Dzm2glIlhUF10YBfzMAWNy3/tcTHyOmtwekfZScEW6z44IxLoEP
         Y2MnpHkNaP/cZw3qfGYVkIPiRprKZV+zLBZeedx6edDOgZPSr78Paqql6Ti/KOlu5IhZ
         zebUoIkPjnDUWitowJOADZMC+3XZPDi5cR+hELnkn7x1iKV48Gwv9uiNDEipbpckx2Zm
         tZEXNRu/tys0DoWEj77XfLqUfpauQyEia14K/53F8TtSZBbjRCVENg4FmbF+0m+GbnaK
         8IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995666; x=1748600466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVRcVKoxl0DwUNG2KUS/gJuyrRdppt9iuLXI01MGzME=;
        b=FpvHsao0UlugtJpUI/E8fNx7Aks81fRmbw/VsrDLYczQpY2R0PNLRJZpuGho03xDl4
         epYDMEHHRVyljl9r1mS5OQsqjlOMPvIBvNmXS9+2oPF0km0ZI1sss2KIk1YWCN66CDGV
         MFeaCF9JmYZq6DvM8ZrNyVSoGPvH1b0fWEU2vMLymBhYpqDSYH3pgQavQjemjxhlvTI1
         +fX4zbeyew/1qUI3hngxK6BT4l1jSdsjDvLLCnuhbL3PnnPFVCVfHaYnpmjeA7ZX9UZa
         8CK8g+rqkSZB8ByrZpINqGjAYEKC3i2A/rcmH1FYBgfwcJGNhEO60wOBUI/K2omewxj0
         7adA==
X-Forwarded-Encrypted: i=1; AJvYcCUAMIZwbOrlrIqt683ELNCJeAGRRQUwcMWe0bs08IyXlyJfl+1GQX1sSI1mJ4T54chW0COBNW7wl+okUvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySo27I22Nt10tiAgQAB9SMecQN6lByNbS5FmJ5227Cf75JusEq
	u+pFlzQRnFdp/QrZFlsssfadMpnYpgYvbhgFJu4evENMMzViIeY471DLJicpikzDl0U=
X-Gm-Gg: ASbGncsOllY1gFIxwsxJYhNxdRrvg2YDkkZVuhn8+vtniR3izpu7AEg1ssPYU8fqw6o
	4FMHHxezxB5JsvQjBCVi4oyOOs4hg1x2rKrOEddVLY1IRmWpLQZ+nNVEax2Q+BvJylh0o11TRN3
	IFHvc6+kLbZghbTmjXany8RcRja8jSPmluw9twnfvWwaXbVNkxp74WD6x9GBf3p7cTGJ8iMcn4E
	y0bO45a3dVuqzonGlUnyvklxW0VdlI0z3km9AnYPOcXftWRvgmdvRGHayomYrpZmzGhghuM1cxn
	VqCChk0TyeTY20f/mcrfI42z4vmpE0q+mgvZijnMkxsJBcFEQpkmCg5yHg9MBzc=
X-Google-Smtp-Source: AGHT+IFXhCgkcbKavnE2xTp9i4da6iauW69FEMu71goEiqhGLYMQSQQ3w6lKP9OCGbZDB/3Z0XQGgA==
X-Received: by 2002:a05:6a00:130e:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-745ed847e76mr3749012b3a.3.1747995666204;
        Fri, 23 May 2025 03:21:06 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:21:05 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v8 02/14] riscv: sbi: remove useless parenthesis
Date: Fri, 23 May 2025 12:19:19 +0200
Message-ID: <20250523101932.1594077-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A few parenthesis in check for SBI version/extension were useless,
remove them.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/sbi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1989b8cade1b..1d44c35305a9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -609,7 +609,7 @@ void __init sbi_init(void)
 		} else {
 			__sbi_rfence	= __sbi_rfence_v01;
 		}
-		if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
+		if (sbi_spec_version >= sbi_mk_version(0, 3) &&
 		    sbi_probe_extension(SBI_EXT_SRST)) {
 			pr_info("SBI SRST extension detected\n");
 			pm_power_off = sbi_srst_power_off;
@@ -617,8 +617,8 @@ void __init sbi_init(void)
 			sbi_srst_reboot_nb.priority = 192;
 			register_restart_handler(&sbi_srst_reboot_nb);
 		}
-		if ((sbi_spec_version >= sbi_mk_version(2, 0)) &&
-		    (sbi_probe_extension(SBI_EXT_DBCN) > 0)) {
+		if (sbi_spec_version >= sbi_mk_version(2, 0) &&
+		    sbi_probe_extension(SBI_EXT_DBCN) > 0) {
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
-- 
2.49.0


