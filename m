Return-Path: <linux-kernel+bounces-870065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F082EC09BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9DBB734EB13
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2B631987B;
	Sat, 25 Oct 2025 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMoRVw/e"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE531961E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410486; cv=none; b=ZL2NsTFVTWnj/i7Ow43tL/AjD736YzCwMI0+trFoxhorkcPq2lfG+x52XnQcoaVnd3upVOA/UpM5zXBV/Ue1P0c7DKlQYhGmyENPWa9mtPGJP1oCF4MtuOt2OmSOyns2j4cxs8mI+IxEpK/+v/hPRvGALjiwdsElnNxiYsiPQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410486; c=relaxed/simple;
	bh=7GwbfwFI4OnHwDpWdSIvynNWO47LZso8CXPD0pWl0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIE04NXD5t2aKQ9bp8MG64vf/y2Iem5Am2tpWI4WRRPUcpnNNQV7mHR8lZjMSrxR/5y4pZBdC6GFevvKt8UAcJbZyt1LQmzI2C2haQISQ0rEoFQ62wbS5PdBHR6pnGgk+cEZpx3GmCW+peYSoIaMftdSAw9iNTObV4svP/wFuOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMoRVw/e; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e88a1bbf5fso34505731cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410484; x=1762015284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=nMoRVw/e47Ca2PFeJxQGcilQ0+7K/pEDLQw7tmgRePfrLJna7o3M4YgejGBdeZLUrE
         S3dkSVkPnYssItysHDNziPNz5ani9VPDt5wnM0lFVl/EEWlfABAT6vg9vyLR14/bM+se
         wYGzV9Z6exKNx9La/3E8WKdzQqG5wKpwkPooGNdiL5t6v2STACEUnGqZQvmdYtQ8Ld18
         bI+uVQqfk3/vDnzetw35OgPfnGNCLkeWB0nQ8qa+Dztpb8zTK/sjoy2q+4+FwBihknoC
         SKciyHsJUBU4KqBDmxil+LjI+CO6tw2Wxbp2EDtyRXelqLB4/wGWfss7AZm+H3opj8jo
         +Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410484; x=1762015284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=JiVdmhLLXX5fNRUHXbXVUzJa/EnhrLX4rSMyQpkRHo9ezhEbR9WdjILGmcC2ciR7DK
         amMYMxlkpkI/E6mYwZLvV8dnPw90ghHnn56NYq2ZGn3o4eCSXbW6c+MBU16iXFUDwegy
         6Ed6+5vwwEg3hgLRxwr75ZNv4V4pd3vQq0EHq2r4KTkXK5pkhS4Wf66LOwY364HyJYwq
         PQTdFaZ76s+iJhNVIQ4SqULvvKOE1MeiCiiorfaeNHT+KelhSAvYxARRafmLn+z8giZ9
         PdAtyWLeS3un58pvneh7J+kF8divQSzjrc5IRLGM3k+FN+wQ9zF4V+G+sGKEdserYhMO
         TIFg==
X-Forwarded-Encrypted: i=1; AJvYcCUFTA5ofnQoq9QnF4LqA1UlGwFvD6ZhrzAMoojGuMHkc2FVX/6SXCX5YfRXABpPkWsRR4631d+pEpPT0DE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx75l1CZRIWKB6nNUHa3a+r1xfgQvJoiIOneyaBiltX3JNAvWr
	pJ2rvAiQEtRMlwj+1JaeOqO2IW5FYS8rz25gHhLSi1+FjDz1jEcoQL+C
X-Gm-Gg: ASbGncuXA+b9bdS2Cte0FoDxsONi5zlDgw8ortEFJL2ge5fn1jI8CalOYbXKr33MIob
	COzWQrYNrM6v6aArEupylxSy7zOOBRKDec6iTMfWkZINpR4etR2Jac10/Y8afMPBqltkezCKbin
	eQ80RZjCcyaVECjnqh/iKo3bLmnfR7HTBIPmPSD8Knkj7A4/Y0ndgcN3+uQigdQddoFP2QPu2mW
	ZCVCtQcqVuJSNYnrg/oqYb8U1EWCX7K6WVadLUs6RewdRuW8m1uBqcEEje1qFeUHQN1PYUOOYIx
	lCWnBDb0rNKCLOtx+fxelDOxujC8/DMUYiXlgN7Y9F3txI0ybnAU/x5tKwzxKO7EF0k5qE2z1+N
	oSU5kpwDxiWML2WA/KvwkBPkynzbIGqsz2lbWgTw/zKWWz5DbDukdsh9Iou0CfR4ypdwdDqQZWi
	TPrC6oOO0=
X-Google-Smtp-Source: AGHT+IH+bChMnhrke25hcunXp4ctYBzAwgqUPi/DPNGDmVtSwY5Yr5lQoJiKtZxVaRD5EDx9mjp5Qg==
X-Received: by 2002:ac8:7dd2:0:b0:4e7:37fe:b619 with SMTP id d75a77b69052e-4e89d3a5549mr397523541cf.65.1761410484101;
        Sat, 25 Oct 2025 09:41:24 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24dd30c3sm174457985a.21.2025.10.25.09.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:22 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 20/21] fortify-string: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:19 -0400
Message-ID: <20251025164023.308884-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/fortify-string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b3b53f8c1b28..0c95cdcca736 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -11,9 +11,9 @@
 #define __RENAME(x) __asm__(#x)
 
 #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
-#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(BITS(1, 7), r)
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
-					 FIELD_PREP(GENMASK(7, 1), func))
+					 FIELD_PREP(BITS(1, 7), func))
 
 /* Overridden by KUnit tests. */
 #ifndef fortify_panic
-- 
2.43.0


