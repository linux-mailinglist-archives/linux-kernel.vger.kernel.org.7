Return-Path: <linux-kernel+bounces-770410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711EB27A6A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C813B3D75
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB42BE622;
	Fri, 15 Aug 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ/rdNuE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7427C84E;
	Fri, 15 Aug 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244607; cv=none; b=HWfJ3As+oTrJCRVBbZE9FWcEaWfI9QUl0hJKmjOZ4gW97KfxW+V3NYtZZqc3h9rCfumBf9lRqs66HpsEwp/bEjp/DoetkVBNcTWIQjiIVcrHuf7K0AnB/NIo6ZGx/LUPJ74PxptZ0D/2qocA264gM15TM3t4MztIL9uiJWbu3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244607; c=relaxed/simple;
	bh=9zyrvDyjfVYyWsuS94gwRz8UnTctJ6fTZCf1KTGT0T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCw2iuilJufSrcgUGaZONrDlphMW4ouSSYIcvOgEqB8iXn3F5cC8pFXFhabLpbj3XcoePTpgwyT4v7TpNXPMa5LSGCGtkZRTwFOThyxj+dP7BKH6HfG5vlwQDOCCkCi6Y4UYvgBsHFAf1v+aJl3xmG0k43NNKPmrMcSDXPs0Ato=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ/rdNuE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-244580523a0so16246185ad.1;
        Fri, 15 Aug 2025 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755244605; x=1755849405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94HKFscQ+ugjTxu5GnpFNBaeL2IHgfjLAhQn0iZHS7E=;
        b=NZ/rdNuEpZFOY9AzTY5SqejCCBec0C5q2Ry7PJ4YgFSkZgjw0trTyJuNJlWqIYmUBp
         E0CPykjJ3Dkh/CteL0y+M+Xfg4h8487y9ZXaL/pcqTgY2X3d2m6sWacKSHGryCp+NAhU
         mYyKBxmLjLscAZaC7J0clDpMsj8F+NgIfehnntjFqnaahqxIseGNtE3ugmvt9ECzd00F
         JvhuhGeX9EowLPZqPFpt0EvfSqVs+C/VfJmxdcyYHTOOsv0vidj+ouiW+nQJIFt7SQQC
         4JZIfTDIGsi/ligdKdeLbz21tDNR/gA8vJkHME3BML53NFp7njIW5zFSPN1eRcluvNtL
         AWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244605; x=1755849405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94HKFscQ+ugjTxu5GnpFNBaeL2IHgfjLAhQn0iZHS7E=;
        b=pLgwG0G5DE11BMlIIVX9GzkYekVw1TtlPRu0vxQb6OeFjJ2YctCDG7hPUVZvvGiwKd
         Ugtsxem4sQ0lEZ94ZItZX4zY98lyOg6OlWEkzYqhxMxl+Nu0+zyr9PDzXI5rnqPg/odg
         bkP5tB2pQmlMLjmuEWksmJIaXJDDKe9SZQAWZ72sZ3zl+g0Cr1d/1XYBIwaQBUWwMgPQ
         1SE0Zm75Bm8r4Y8M38KkJXm0VYy8OZ+UOBv6bvOxp5Ip6u/H//RMDoO62sHojl/cEsp4
         7a11kQhWTXsuC26LnWePcnxqi+9bXhDSOPX4uZZ3UY1+Fee9gZJVaSkH2UxI234DQVLm
         oZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOOyHchfw3etpUssLqPLirvg9PtN6TLj/bAgnuhYOqmLiuTgjtPmPzyQ0A9938cHNO8ocqpHjovXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSmVr9der3JQJc+F7wpW9XJcTUtjdEM+6axnTC0BSgiKP+bFK
	Zxq7Se6TDxSYvbl/oo0gyBd/JmqbYsrxRUANUyYjjZrMXDnvuRuKyRnN87nUtSRL
X-Gm-Gg: ASbGncvcyvLdAx0WoKhmaTIWnWvxhdQGm+5zUI49oKAzcSimbDfNHExEw94B8iOzWOo
	6kORTNgWhKQ7WU+ctnnnq/NvKfuxMG/5F+r8BG2M9glC6mxS0fP4CXSshcnnKSYJG1BZ2o1Tqlp
	eBlaP71/COqHme4dEmLBM3MSBjQWAWMIbCYfozvu+6bDyF0laOQ0r2EnK/K56HS15y1fVA362LQ
	aK1g3i1tru9aSPxBjq1hxd6Rm+xEp1c+TEcg2HD3Us95RyqqTEz7RNstwt7pOgtJq9k6mw5ikW4
	BLYCYM32LlP0qai26K/XfYmmmyfWes7WW5f4Jwbw6JRYdDttskxG3hGATFqWhBTf5NYzvjHS+D+
	LFnX98QxTn4xLT8OXrRisGQ==
X-Google-Smtp-Source: AGHT+IENpZ3DUGjafhYrp0JjY0F8GbPlJ45vECelGvT3ZIvS7UFcIYwlqSHw/Sa5we/uG9E5ip1mjw==
X-Received: by 2002:a17:903:2f92:b0:242:9bc6:6bc2 with SMTP id d9443c01a7336-2446d9fcb10mr15906305ad.57.1755244604805;
        Fri, 15 Aug 2025 00:56:44 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53eec7sm8353225ad.118.2025.08.15.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 00:56:43 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5148B40AB483; Fri, 15 Aug 2025 14:56:41 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] Documentation: device-mapper: Add dm-pcache docs to toctree index
Date: Fri, 15 Aug 2025 14:56:16 +0700
Message-ID: <20250815075622.23953-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815075622.23953-2-bagasdotme@gmail.com>
References: <20250815075622.23953-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1099; i=bagasdotme@gmail.com; h=from:subject; bh=9zyrvDyjfVYyWsuS94gwRz8UnTctJ6fTZCf1KTGT0T0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnznq9PdTXSW1PU3DZ9WmNR9v79zHlvucNvJl1J0Ev8k vj7fqRHRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACayPozhn1XN6+cHdUquipzf lOt1bXaY8bzPC4Pj4zUcfzlntmu1mTIybEjYN2GSWISwyx25T40z7jVrmrslvPL47Hdi81/eteZ vWQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports missing toctree entry warning:

Documentation/admin-guide/device-mapper/dm-pcache.rst: WARNING: document isn't included in any toctree [toc.not_included]

Add dm-pcache docs to device-mapper toctree to fix the warning.

Fixes: 6fb8fbbaf147 ("dm-pcache: add persistent cache target in device-mapper")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250815131115.45518c74@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/device-mapper/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index cc5aec8615765e..f1c1f4b824bafe 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -18,6 +18,7 @@ Device Mapper
     dm-integrity
     dm-io
     dm-log
+    dm-pcache
     dm-queue-length
     dm-raid
     dm-service-time
-- 
An old man doll... just what I always wanted! - Clara


