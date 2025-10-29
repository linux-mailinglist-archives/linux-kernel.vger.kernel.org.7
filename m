Return-Path: <linux-kernel+bounces-876470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A996AC1BBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 433AA5E3C46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CF2D6401;
	Wed, 29 Oct 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtATPkDR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252C22A4D6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750213; cv=none; b=WtTUxH2ldGLOOUpcC3yCjmV6w/r2+YZ59yEouwSdB5km+SCpMnu0JKwOnG7XoFMMX3PhMswRUsyOOcxxZl49my1h5Wbh7H9CzgPJVTM0PgblTZqXjidRXTpQbpg0Us4FRecUN1+oDyTyo5C44n34OHa9OFjlC0NN6lNhG4X1P2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750213; c=relaxed/simple;
	bh=HtevJgoFY9ZJXXVp62LsRv3QeAdG1uCJ5U+JMpp3nXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPGl1OplYHioFVDsf48j+5m8WnCnEUIgSTBBEuxkrsFPsT3UzRvsrquK2gkPzwv7sJI9cSkzBdwDV5p8bjADb7leK1gY4+Scl75xJgwiqinPu1Pcc2DrtTykqYrfEAslqVurjg6JrRy+5W/FrJmVGlFU6IVrSR8VvCPPwVBH/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtATPkDR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4298b865f84so3999997f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750210; x=1762355010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eGw/S9fL+3KMXolbixXBawr0Cg0kdkrfB1puX5CgEw=;
        b=HtATPkDRD16WYM+c8sCGicuRseWqyOcy6fwW5iEbeXKUFs5RqXA1Ak0vRF52uJCLgt
         ilp/4YbwnNVtJ6ktheLDCn47+5d2sNWidRZv6ZBO+zloiaVb53oWQlwEhNj/CjMB8reP
         AlVJPaFODTq1JkgGPzuzWbWlnc97HUiwFaHRFqStK9OnMyhVBzv6YOrV//BuzKJKX3/v
         BasqqH/CIwX9B2YsJzMz6eGGz8mBl4wELJXsrkXaR+KLjV1sLK9yoEKBOek4PFrXcxlY
         xCF7Y/sd6YxTsYHfOL47mR9xqFCIEnWcUZIftn+svHMJn7PSUVvKX/rC8bU6GGeRxIcN
         Ll6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750210; x=1762355010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eGw/S9fL+3KMXolbixXBawr0Cg0kdkrfB1puX5CgEw=;
        b=ZIna9Ar/edoa0gnC3cfTOWPfbtbo0tUAjneG1CRssY95eGDTCr4O8Iqv4RZZpXIaqs
         l5EwSk83symyrVfeono5gLEEYrV54UyoEipL6LS+RDSSJkOnV3dgzPG1FKMqyyDPUny0
         i0VsKSJUOGSxequCJLHM2/LrahtzwqxpvRCBocxT/JGCeT6GPzY52SogeWppwWit/gxY
         xNr5pKRG/Mr0/tvuzuGIj/gfClShe/FrZU8vNWeJhOql7FG8PfcDPtqsBHbNwwX1ElKI
         wPYTk38FkwsyC4l8rZAy9cACkacP/6Q7kEJ0lfmSs483WTe6HycmWxUv/DMdqMtD5Pv/
         LxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUW6A3Vy6isZIsa5aBTGM3EdWgKVDNOfnDXg78mJFikxt5NMzPoKJP6ZIkx0FgRBPuC5Fb6/taof94Jna8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikgmA/F+Mgr9cWkv56ejegKPlAM3xVgfnhZLQYS3kz6m3q+KU
	wXZzMN6mM+XBzuIPqDEvBr8NwFWuHmb0GgJ8FKqT1wyeZ93QiXHTZUMT
X-Gm-Gg: ASbGncusODH8AHRwvsg/yPuN0klXLKikXYHBAXpm9JRrS7ftUZm5LbAPCbbzPomsdFF
	9Y3ELwcaOmC1CQE1fxlJfko0s+1oFnor/TG3PqpQfwBerv2vWnbgoT6QgGll8m0zFQiGlfDSgET
	SonaF85eZGFUyWORkW5+004zerY1NNhB4oBhoF+iLQPiQTkEoxOzlEYxSAgOZAdfv/nfK5ozVe5
	GiujcdaDa0qckSPEmy0RWDrRSlhRtuUCOkbBRB4fmjR3hKSXWHJYWns8na0Uo8LEefOrX/AHG2R
	wQCsfF+xIpGfYAYlgnCpZnZOAGqdQAxj8kXJVIUD1LR2xKq1asFg3CFfDhDIUOi7yplzM4C1QRa
	UL8WzntNqFGFHcxUPPJbVxCjBRL7I6ORWjpOGI5k4l7v30cogSCKZiEyx2yaNHo+MCgML6T7LKC
	R+jQ6ahG+NAZT7U8ESqnBLv5LO/iKsVMy+HE0PygipsiAh2Rps+zlkFNCX0tOyS4dm5LVO
X-Google-Smtp-Source: AGHT+IFngucxs3wXaIkWr4nm+xkyYTCdQFAZf74Vaxa80PQbOMHFlSoSvJ3gwKBogd+WW/i490lUNw==
X-Received: by 2002:a05:6000:25c8:b0:426:ee84:259e with SMTP id ffacd0b85a97d-429aef83047mr2790964f8f.24.1761750209837;
        Wed, 29 Oct 2025 08:03:29 -0700 (PDT)
Received: from localhost (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771843eabfsm46254015e9.2.2025.10.29.08.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:03:27 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Alchemy: Remove bogus static/inline specifiers
Date: Wed, 29 Oct 2025 16:03:16 +0100
Message-ID: <20251029150316.2522555-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

The recent io_remap_pfn_range() rework applied the static and inline
specifiers to the implementation of io_remap_pfn_range_pfn() on MIPS
Alchemy, mirroring the same change on other platforms. However, this
function is defined in a source file and that definition causes a
conflict with its declaration. Fix this by dropping the specifiers.

Fixes: 8efb51ad1b05 ("mm: abstract io_remap_pfn_range() based on PFN")
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/mips/alchemy/common/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index c35b4f809d51..992134a8c23a 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -94,8 +94,7 @@ phys_addr_t fixup_bigphys_addr(phys_addr_t phys_addr, phys_addr_t size)
 	return phys_addr;
 }
 
-static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
-		unsigned long size)
+unsigned long io_remap_pfn_range_pfn(unsigned long pfn, unsigned long size)
 {
 	phys_addr_t phys_addr = fixup_bigphys_addr(pfn << PAGE_SHIFT, size);
 
-- 
2.51.0


