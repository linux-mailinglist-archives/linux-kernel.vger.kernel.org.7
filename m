Return-Path: <linux-kernel+bounces-895035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB04C4CC55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6788C422E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FF02F5316;
	Tue, 11 Nov 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjNEm+jE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5882F1FD5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854337; cv=none; b=pJ19MxPkO/h8sSkEwN/BP5lyLpSdhKEEs8x2aGK/vOZS+/vXYlpiYBHOShyH0a3UpzcaDTb2kvBoTrIyXpZOoVUrnXz664yi4SCR19A6Hw5dR5owwn8ljG/nlFkzfrE/STiBXezM4xtmeP1/GVsWhk5r5YgEREC9DHBoR8zCMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854337; c=relaxed/simple;
	bh=8lQxcKvouaei16FqYGY0RR8AerBRZPOQndfjxzjaGZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp5XyLXXHwE+3C/pH0OiSVB/R5/0khTcPZJE82ddIyXTcpDz88RnboCcv7L4jEyvl05CnVqBf5GTXn2OJva0w/D4Ogqv8Np/MWrz8I8JldAgALvZJf4ZVcBU8XPVI6V4AAZQyMcraFSxWuNyHg9JJROARAwlwWVHtIDd8846qsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjNEm+jE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so270761f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762854334; x=1763459134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=SjNEm+jE7K8CIJg1O120bI7g57/2jeVA09YDYZY3qWy7jCxqI5sQn3AzkF+uxbCOo7
         RuP6ZFTjl1SO6ST7RT13fK5EZKkqafYWCkV9dkVB4Zjz3H5uMQw6YVN6i0r/m8BC/zfJ
         9HRWklYOtN2U7FhueKsXAxhlJrix+ayy8OWxvSvdC+XM5D7RdVJba27oztPgavuny+8f
         c2+NLx50w0Fa1slY2UpcyAT3+gmva+0rflSXRWfieZjKktyjEdvm27unECg4+6Hs4Y+Y
         gKF6by5TJiaPsfdh0sfQTmvm5WUymhWJJ+YmHkaPFwXnATxnJ8jLyv0TprzaJd1g3gSw
         rnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762854334; x=1763459134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1iqFxV3svYobU0TK9f8Y5DAj+U7MQujkDDouJLinQ98=;
        b=sDn6s2H5fjNQItzM7qvK5Xv4oqu4xsGbio1huqx5pLmheD5oeILCwAYFBKMLHQIOCl
         /pfLJcfnL5BfkcpZ8o6CqAmC6GRWoRboe/0gd8j+8VIhZwJD2i/NJ73IRCCpShd3tGS0
         uQ/bp9tyQr1uztCuK230JwZi+daSSGqVlsrXQlbxmXCRNIqOZ0MmTcXF1FpzzxzjA/yO
         CONXT+drmVG4tdU5Nnj+EYXJX83nWpGeRPOOOv63FklY0W128OhD9qbQjFY43TS7hzWg
         IQ9tO05c7RR7YFJjFmhMzsOiAxieSYr4kkD8ilSfD0nDICjmrDs0aFPrGkEt6KRojUln
         cE4g==
X-Forwarded-Encrypted: i=1; AJvYcCWvVUVHC6GvvfAtdyDMR0JG6mj9CyNDJBQS9lrNPklGgAwCkG30c5+LrStzbmheutMZa9V3gKA0aozWtQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfztOStTnLpELYLnUYnCzhp4rgJ0d8Qc5cfZwWkTKBs7d5OHA9
	HTQtF6bEk3yJSU9hFQx5ZUt6fzcNwrMuUgOVGvOe/swpbmRG4NXNT+cR
X-Gm-Gg: ASbGncseVvMpva27OgE32BoCfKi1eK9NVKvnI5MKuWdQiJ2exTjO/NMH2+cd3+KknEB
	HcqnftmyAanTP15KedbxccKT9qJ4HCyoEh22Q5OXBZjlblfheT+i20/nAh8LCtw31v57qn8tsTw
	nHOvxVo3spJrtLmoSdlsr7N2uTU983MnJmbx6t09x6/x4afX1ZKWDE3TYXYpcNzJVAM/52Kszpz
	A0fKZwLRA7Ym3HfzGhNcZp4HU+mFTFsmfahFBYoGexVwUr1L22/FVZZGIH3zkQCUs2xtkpFTM0z
	BbJVgL81vl+xvrjjZWDHPFUQw5RjWD1AKSzwaLcUugTzP0SpRYqo0QbmMB7C/QC7vA4McoSRPAR
	jKebU10lUWjBpSFqSHOVykvF81Mm2G7F2j1ELAw41KyAvniyJ48HgnWu6oro9dfAZHFlnNzZ+39
	CZOpNIhOMqOthxe8lIjKjVrU1dcnE=
X-Google-Smtp-Source: AGHT+IGA/f0ZCKraAUBHqwQvDL4XINgS9hrAFsyHo2vjiQs9gnIry2mTkBGRV4IxBbXGTbM5/YiQpQ==
X-Received: by 2002:a05:6000:2284:b0:42b:2db2:159f with SMTP id ffacd0b85a97d-42b432b1f8cmr2257381f8f.12.1762854333756;
        Tue, 11 Nov 2025 01:45:33 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cd45466sm359537865e9.0.2025.11.11.01.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:45:33 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: johan@kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH V2 04/10] staging: gpib: Update TODO file
Date: Tue, 11 Nov 2025 10:45:06 +0100
Message-ID: <20251111094512.6411-5-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111094512.6411-1-dpenkler@gmail.com>
References: <20251111094512.6411-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments have now been fixed so remove the item about
comments from the TODO file.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/TODO | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/gpib/TODO b/drivers/staging/gpib/TODO
index ab41a7f9ca5b..ac07dd90b4ef 100644
--- a/drivers/staging/gpib/TODO
+++ b/drivers/staging/gpib/TODO
@@ -4,20 +4,6 @@ TODO:
     CHECK:ALLOC_SIZEOF_STRUCT: Prefer kmalloc(sizeof(*board->private_data)...) over kmalloc(sizeof(struct xxx_priv)...)
     ./gpio/gpib_bitbang.c:50: ERROR:COMPLEX_MACRO: Macros with complex values should be enclosed in parenthese
   This warning will be addressed later:  WARNING:UNDOCUMENTED_DT_STRING: DT compatible string
-- tidy-up comments:
-  - there are some "//comments" and "// comments" scattered around
-  - sometimes they are misaligned
-  - sometimes "// comments" are interleaved with "/* comments */"
-  - multiline comments should start with initial almost-blank line:
-    /*
-     * Good
-     * multiline
-     * comment
-     */
-    /* Bad
-     * multiline
-     * comment
-     */
 - resolve XXX notes where possible
 - fix FIXME notes
 - clean-up commented-out code
-- 
2.51.2


