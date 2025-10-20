Return-Path: <linux-kernel+bounces-861364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00DBBF28B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F8A46353A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E77330307;
	Mon, 20 Oct 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="sK5AUcvp"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F0265296
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979127; cv=none; b=o25J8PGnFxEG33IdesRn0Qc7SlbgIkhcf+YYb85BALsXI99ZMlTcI4x7q/WkC2YAaXOmeMjwre1+j9tXfDunUfOAEusBzuOfLnzZyupb4CQMACszmIK+hhKySRjtg1p579PWq8N8B+T4gUjTGTlwgHNjPPDcCGr290CMp/jrzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979127; c=relaxed/simple;
	bh=MegxqgosTv1U9bmqdWFqbKF2SSWgJ06/KUsVUL61nw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIZgnP3D+wuf6eUbiTxP6lMfhtizloo+MbRXaESq8UJxFSfxsZvIwff+Tp3BsjJVquU4mYWFjoGYFQ9DwiOWMjpzT/8EyMIznbg2gOvMfco5XExAfYzEbxYBW4XpP37ScMcOo5HaO0LjlKFXLEuh1UmJqHzVhRFAiIWbPwqlWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=sK5AUcvp; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-940dbb1e343so44537239f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979123; x=1761583923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOxUmFizj9Ufb4EIO4FC5gzTfZsJZC8/cUTKAJuMzsg=;
        b=sK5AUcvp+Lcb4qcsPinWD3GeAs6Mde8oYJJBPNobBz2CXRVqFeDG1jd8dmZxXFi6lM
         h/4ITURmqmGWDBKXK39bslPKq41UaiLq4Dzfp/xq6unsrtJ0FjcPRbg6fx1ulrp2YjLy
         Ueott+f1eTOoPc5h/6QYLEV1UA+9n/EKeGbo4v5+B+qAYYcbZwFrFo9h6I1P8c0JoCF/
         jyV6NsaKFGDi39vKsSEwRN8OQWZncah0HOBZWTaJsFwwpucMeiaWtAPkY40enV9F6RB0
         RcOTBZ/rI9ZkEfn2xZre1eMonqzuh6mvoOt9lJXpAxQafrK/0fHVSBWNnJcMC5RCyrhQ
         k4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979123; x=1761583923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOxUmFizj9Ufb4EIO4FC5gzTfZsJZC8/cUTKAJuMzsg=;
        b=R3ayKstHBwYzuGaLdPh6c+A0SJLAwMfg6Je28q8Vrm4Lt5GJjioHVyphaof4VpZHta
         gLRYpjXURy2842gZ+qSx5ergH5MqoCi8+TAd6CT0raB6ykoi2UP001ooqCqesoCJrJ3h
         IjT5TLnKuZ7/lRp1uVLOAPELeMNYTQ6Rb/6IEDUSOqRIfDY86ycBrFYAfMdR7OWEVwbs
         JzfTynaIY8QTGXNOCt9amkt68bUjXSDQcASNKb9t04L4GQ26k4FoqbnWq54ddtmkSNoJ
         9EVTrP7oOhi2gfn2K07o42187lY0d7lKh1qlL0ZpupQ+WxL9Xeiw0CfpN2Yk0mjd2YKX
         g/6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkH9PqfZ1TMiVDzk8SO1nxZfuzLh7lSUjo26esj11ROJL6ZfycnSaBXYzZdKxAN56PolAIeurudNN2AMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+Ve1DTNKt+sY4O1Sz8M7eVcrCZ6gc7sToI/Y5yEWb0yyiMqI
	ZTT/uOgwDc7ZRfyXDldow6WFJJ9DUaI7f1MFNc7yFj0idP1/GN8sgB8CTKkrDqRVEMw=
X-Gm-Gg: ASbGncv2G6W+6H2ydvsH+F4PJGfXS4SfohL36XqYC3E5osZX1wz8fR8opmzciNphjEL
	rWMdyyGdHXuPHam0/5iKe/jAA7mXnQvabxCj143FYoey0tevCCODIAsxVdv1tv119vmWKdudrZf
	b/lPUnRbISzqcD7kNnyup4EOTrrks7uZ4vLrYv6uFioOL17d+RcdJUnGGwOdV4/Mvk7rdmaDNzJ
	drscmQWjPJEyXXyeYI2+B2papRaXJ5LyFQE8/8oaeHz31Dt4tNzgNH4x+WRetHPHUqiBOeJYgdQ
	4bjHBOx/D/3SzkX072spLCtMpAyoAxLugE8hj0wKFIPzbBuLOQcM6G/4lUiF85g3okc1o0UREI2
	TLFMraSgoh9v2F2v7ZBBY+OA7sTMRDP0XvlAqqTYJGRsAJr/xkvFy33O74lyI06C8I9mDKX7pk8
	1wVZIw5f9WtaUe3phKzc1ZD5ypihOzZhO5v9eTEB0QN0Ixw0xcJLPHDtQ+pPG/0RAa
X-Google-Smtp-Source: AGHT+IF/UQC1U4T3O3fIMqDaCL1ih7iPN9SgktMMT7A1RqheXlU2cIQVFeZ9iCADqymX+H06lIfZxA==
X-Received: by 2002:a05:6e02:154a:b0:42f:a6b7:922b with SMTP id e9e14a558f8ab-430b42f1f24mr238954605ab.7.1760979123535;
        Mon, 20 Oct 2025 09:52:03 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:03 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] spi: fsl-qspi: allot 1KB per chip
Date: Mon, 20 Oct 2025 11:51:48 -0500
Message-ID: <20251020165152.666221-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fsl_qspi_default_setup(), four registers define the size
of blocks of data to written to each of four chips that
comprise SPI NOR flash storage.  They are currently defined
to be the same as the AHB buffer size (which is always 1KB).

The SpacemiT QSPI has an AHB buffer size of 512 bytes, but
requires these four sizes to be multiples of 1024 bytes.

Rather than add a new quirk to support this scenario, just
define the four sizes to be 1KB rather than being dependent
on the AHB buffer size.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 703a7df394c00..9ecb756b33dba 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -795,17 +795,14 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	 * In HW there can be a maximum of four chips on two buses with
 	 * two chip selects on each bus. We use four chip selects in SW
 	 * to differentiate between the four chips.
-	 * We use ahb_buf_size for each chip and set SFA1AD, SFA2AD, SFB1AD,
-	 * SFB2AD accordingly.
+	 *
+	 * We use 1K for each chip and set SFA1AD, SFA2AD, SFB1AD, SFB2AD
+	 * accordingly.
 	 */
-	qspi_writel(q, q->devtype_data->ahb_buf_size + addr_offset,
-		    base + QUADSPI_SFA1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 2 + addr_offset,
-		    base + QUADSPI_SFA2AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 3 + addr_offset,
-		    base + QUADSPI_SFB1AD);
-	qspi_writel(q, q->devtype_data->ahb_buf_size * 4 + addr_offset,
-		    base + QUADSPI_SFB2AD);
+	qspi_writel(q, addr_offset + 1 * SZ_1K, base + QUADSPI_SFA1AD);
+	qspi_writel(q, addr_offset + 2 * SZ_1K, base + QUADSPI_SFA2AD);
+	qspi_writel(q, addr_offset + 3 * SZ_1K, base + QUADSPI_SFB1AD);
+	qspi_writel(q, addr_offset + 4 * SZ_1K, base + QUADSPI_SFB2AD);
 
 	q->selected = -1;
 
-- 
2.48.1


