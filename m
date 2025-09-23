Return-Path: <linux-kernel+bounces-828234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF55B9438F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2ABB4479BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9FD27B4E5;
	Tue, 23 Sep 2025 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIl2bQ0R"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EF2765F5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601327; cv=none; b=kz+oE8YX03wW3ROHEzX0EDRjO7u+IvPg1psCpTd1VYxb+RvkzWE/W8+Y5X1no+kzUSrimLl+JEuzItvntWmVzTmcfiQfP2fPEiw/4bNhMv73Yp6Txz2epfxZI5dmbDIGWv0ZvPGNTBNPxpQd810rq7EvpI8s8UMN0wOGP/4Q3R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601327; c=relaxed/simple;
	bh=XLZkhs9B7s43yPMz0XkRiX5V/b3jeChbEWeI9PX6mdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgRUsX3yUNHi5AME0SQMiiTBcW6ZfRaUIhHrSNYpdoFagsCDqGDmGbhQ5+Cnek3Vfn9ckNU6ZXIphiXZ0Y7dSCR4NQrGGT1GBmzh5W+bVorQh+kQv63bVYpPwYcqc+qyLo2ezl9op0GvIuOoUaBU3bA0nSWgXcOvjPByNaTEP7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIl2bQ0R; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f38a9de0bso1633770b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601324; x=1759206124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+ep2im58IjxT7DllA4u/z9ICpD6gnUYG9dPd2F5jf0=;
        b=QIl2bQ0R3qkHGbx7wtcI+aq1Qp5wUz3htJv3pN0OdZlkdmfWLWSSifGLkjZpwemfji
         AluDAtJEUXF05VpONny+dYF5n5ijJSCa9OYdjVZGPuRs1YxvnP+T224tr3DoZSNBcv7n
         OwpECYJwBrrWE9w+wwloDs383yekhoHh5ZWHJ/rCgQsnxdkd+LwcpNHJEoUyCCF3fIOu
         0Z05VlM3tNbi7FR8iZFSM+x7hOJP2+XfRVw7eXjSOPJ6oFkney9lfhPw+AhNAZyYwUAn
         tWsncgSBd3AEoMwmBcbVfg/PVqahoKxYiriV3Ugh5xYsU+p/eiMAUqZuUXclQusGIDwh
         Q74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601324; x=1759206124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ep2im58IjxT7DllA4u/z9ICpD6gnUYG9dPd2F5jf0=;
        b=u710pCpBnFhToTxF37cTqmU2ADUXAynxA/+eivBf/Z/sXYcLZ3c9bjL+zlwC1auRil
         t3GkeJZgC7AblcrJcl7YI0rufuB9mId/pByGSThT3VQoQdXatoNer5haIAnKs1yKYwwn
         ME5x+3FfSA4gpASMvO9igHn9XTXSNQpSmBzo/OQUww6KzChuQfr0h+ewhB/DlqlnO/ds
         51HFaL/zF1n61vdgA3vzRFmYnVjuiYT+wNmD0ZpRpm7ldKJlAAdWb6bCCkuc5ogU7GPS
         4gHEPm3+4Y9Rht1EmTgKEucO/BHpphLTZszeyG+lXbXMKeTeGTim5nAriIiJ6XwnsYGE
         IDpg==
X-Forwarded-Encrypted: i=1; AJvYcCXkANLAuKTj9MnjKlY+G3Sm2kvT+zxO6gP3eqExmnpJSHz6q4gYSffIOwj4nYNdWhwG6ejZOF2L0nHhW5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3p808l/aSVRFJKGYbaAvakOB5fo1VPpwfygAfpd+FPM7/IpO
	xx1tdkIjRCVRKTI7z7I3KQchk5+y8NML2geF4+/ZZV8aSnqp3/Ba2mRyIf5v7lBp
X-Gm-Gg: ASbGncsiF2tgPjzMGRiZyQRl8lJNQREhossgn6YpPNj3d0p98ObfKys5beAIftvDtPX
	dg+O3ma1/MIN+D6sRpldYJtVNJt34g1ORAYNMvchUly1W3BElMiJHj35gBDElpW1doOGVvL43dB
	ivD7qZO0Xkp6gfXYrc9mhyeiAa9JaWjv6f5unzPeAknKL1Z8OAl3dEFrgX4+AN8+qxa33IE6Ibq
	5Nr2Liqs8KaETg2o/YZyyFnZ2IJmQGQ4gi7H5WZI0iV+gVWb2ATqf31iYp4TkZKtTTvOYcw1VVa
	uf0SOu1S7YT4qWxfrkyY1PjSuqETMlzEVn0n2gAx/1Gr6sMguzKzZuNR++gquzK7KelJT0H4KGp
	QfUfazBHAf8NiA+4DMYdIFSx9b55lvj46Kg==
X-Google-Smtp-Source: AGHT+IFYm7cLGFEmVi93jViXMI0vjzoclxblnK03HrQzBTlwHSUg8RgeIuDYR9ocCKvlWOoegY4qwQ==
X-Received: by 2002:a05:6a00:3d13:b0:775:f2cc:c78e with SMTP id d2e1a72fcca58-77f53a83d8emr1675324b3a.21.1758601324334;
        Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:04 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 1/4] iomap: make sure iomap_adjust_read_range() are aligned with block_size
Date: Tue, 23 Sep 2025 12:21:55 +0800
Message-ID: <20250923042158.1196568-2-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250923042158.1196568-1-alexjlzheng@tencent.com>
References: <20250923042158.1196568-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

iomap_folio_state marks the uptodate state in units of block_size, so
it is better to check that pos and length are aligned with block_size.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index fd827398afd2..ee1b2cd8a4b4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -234,6 +234,9 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	unsigned first = poff >> block_bits;
 	unsigned last = (poff + plen - 1) >> block_bits;
 
+	WARN_ON_ONCE(*pos & (block_size - 1));
+	WARN_ON_ONCE(length & (block_size - 1));
+
 	/*
 	 * If the block size is smaller than the page size, we need to check the
 	 * per-block uptodate status and adjust the offset and length if needed
-- 
2.49.0


