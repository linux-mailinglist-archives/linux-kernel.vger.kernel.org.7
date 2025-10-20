Return-Path: <linux-kernel+bounces-860097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA388BEF4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C5E3E0A26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277602C0278;
	Mon, 20 Oct 2025 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiEoW+mR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82A5287253
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760935807; cv=none; b=jnC4Q5NOkcpdEtgZC/OV2PavEgeBJsvnbJ4AQvdBxDmx7BZzIG7TK1sEkzYNlVnVobptt3E0jil2WgVC6IqXHIoinvh+cNWx3qqqTA3eDMQZRWlpmPdU7dHXUsMrmkHCeYnAVJKqZRly4MtdRZaWr7QJ8SV3SEKc5tyQoQfitXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760935807; c=relaxed/simple;
	bh=im8TptqOKTACThJRbjpoq/Ap97qCFdNDCLeY9N2Fplo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiwwB9YisFjF77a8mXswdfXuXdvprchmOelqoLgJWno3lsclVNYru2io0bIdaEo+LUozWV5UTwXTP5BatIuRPGIH4iN0HtSnsUUQt34+Ch3DkVt0Kyfgr3O2bC0rW/DOTYjamrdVQIsgBs8kPSFs8eIBDr22YgntO2qLMzASF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiEoW+mR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782bfd0a977so2857121b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 21:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760935804; x=1761540604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yrib05gMjW351Vqcc315s4iU/oaqX4kqgiXM4x8fb8=;
        b=BiEoW+mRnXS7eUJep1gqqfwL5r1RvNfz7jS7mfpK8hLucMqRxGTwTFOOU++HbG3hSc
         1ZYMEjtJ63I5yMhstGGShMWHIQRGowid7YHhvacT77Nma6K1IfGEehvqU4Yt7nxutaaD
         nnZu+nmngj0w0opv6TUWXeWLF32/gu2M7FKCoFREqgqtlwZYFkXp9XlvdP7ssIJoykMa
         AgGLQ+gqLII2oXDDoTwPiCOeoBUf2LOFI7RupGX9FzkHGhRkbIMXQlC2dMDNejReXOQq
         HQ15ZDiEFkvxJuonGJgeCmSvkdeWMCyHQzlhm4Mx0pk+4K13uHldDvQ9F4l9XFeOLfGO
         hhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760935804; x=1761540604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yrib05gMjW351Vqcc315s4iU/oaqX4kqgiXM4x8fb8=;
        b=qDaaie38n4O0vdR/LNJwMoXGvQREb9U8/b2G/ixVFy6DZ/T37nXHLozvm7oF1hUiaW
         rnY0miWMhQBb8SY3hBRsbMCPBKR6oX7OcyKoxlkVSjlG7g4SlyWiyUnxzbCzJdMTf8gA
         9fYwoMFg/wn5kT4x3G0oml+vPQ3dDFQKPx1t8XBtBkzEQKCdYjvzzMPSc0qHq63EYnft
         4uq1Pn4MTE5GYnohBP+pnIuTBAmYU6etQoVTkOFyj3wdgeHYM17ADvrMnoi9bQsdWEpf
         O/5p4gJbQa+y/M8+YfA5F8yKjb+lWQaa7xPwEcgUsQeeUu60ojdcbog2HSX8F7APsWXO
         P/xA==
X-Gm-Message-State: AOJu0Yyko80mXee7rj2HCNRmjdOsjvCnX/+gN+yEUx3DfnnEc1uMQoHf
	EaLwu+cw+7MsD9djbONGY3XWWwyeJ2abxZA6EIXjPp7ROL+nDPfwsWYTSo0N4dSy
X-Gm-Gg: ASbGnctYqt+rTgXwZyMN8laiF08quDpWNnh6Xzuoq6UutOkL7nDTD1nlMwvAzqDNbeD
	enAomSzacc6Y5EADtP9lVJ99zzn9S8KBOznMgcUIFd5NcN1reSblxpCSlLgkq13AUHH6fk6kq8F
	5NUHqmnAEq/WhScr9LpYc0YgaCc8fAKjI+5JUyiaxJ+eKoAVFeR9eOeLCFFJMYrOfpnwkWFV1wV
	KUG2eXiCuY6BT6U8Fv66pMEbKEyDSvUpL+iMa+W5UxE/Umy9nTGMk8Z58bzkNk9GsiXccMExVcZ
	BGMKejlkHbWdeHM4R3nfJ/U1dhWMeY1YVIhQ6tQ2U4DNwH7WRp1YAVl6ukPrQWC/iLRkRVnhCL7
	1Euy2CImbM6jBQqaqjAFEvcjoS+0D65oUG1XM9sWf1qtTrvZNRH/IBS8lDlMLrn2OS1yYCSyrax
	5gEzchshdUq13pZA==
X-Google-Smtp-Source: AGHT+IF61t4CBl41HaeKPrbb13q/MIse+rZVhP7zh+kIUADNetjtDhSymCvedTsDdoF1wGwNjkcrQg==
X-Received: by 2002:a05:6a20:7344:b0:309:48d8:cf0a with SMTP id adf61e73a8af0-334a8649ed5mr16272776637.54.1760935803784;
        Sun, 19 Oct 2025 21:50:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b36188sm6681007a12.27.2025.10.19.21.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 21:50:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0156D4209E4C; Mon, 20 Oct 2025 11:50:00 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH mm-unstable] vmalloc: Separate gfp_mask adjunctive parentheses in __vmalloc_node_noprof() kernel-doc comment
Date: Mon, 20 Oct 2025 11:49:33 +0700
Message-ID: <20251020044933.15222-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=bagasdotme@gmail.com; h=from:subject; bh=im8TptqOKTACThJRbjpoq/Ap97qCFdNDCLeY9N2Fplo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlf973ivbO37Y7K7W/dR9LuWDZov/Zv327AV56n3J47p cx3rdTpjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzkVyvD/9CJsq277tqHZDy8 svey9H3GApFU7cgZD+56zHV6sDaaIYHhn/KrW/naqf6T2jc/ebL0/ZHuygdSN1Q4PXv3h1+P4vW 14wQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs warning on __vmalloc_node() comment:

Documentation/core-api/mm-api:52: ./mm/vmalloc.c:4036: WARNING: Inline strong start-string without end-string. [docutils]

Fix it by separating adjunctive parentheses from preceding gfp_mask
formatting markup.

Fixes: 32904ba6f5ef ("vmalloc: update __vmalloc_node_noprof() documentation")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251020134902.3a11107e@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e207ca64a688ee..091a07f6d92524 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4034,7 +4034,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
  * Allocate enough pages to cover @size from the page level allocator with
  * @gfp_mask flags.  Map them into contiguous kernel virtual space.
  *
- * Semantics of @gfp_mask(including reclaim/retry modifiers such as
+ * Semantics of @gfp_mask (including reclaim/retry modifiers such as
  * __GFP_NOFAIL) are the same as in __vmalloc_node_range_noprof().
  *
  * Return: pointer to the allocated memory or %NULL on error
-- 
An old man doll... just what I always wanted! - Clara


