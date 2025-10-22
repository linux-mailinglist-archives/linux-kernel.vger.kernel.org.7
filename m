Return-Path: <linux-kernel+bounces-864081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F03BF9DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896B61920518
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278042D23B9;
	Wed, 22 Oct 2025 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhj491uD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D12D1931
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761104634; cv=none; b=OMKj45UKoXyuBTOFV9w+pWo0nLWdYhjRKbwOTT3+LxyvsDVNorBMNUTqSI4/iWKNi5jog1Ez0/6VI/js07XMRiaKqiSaqManvdHtmDupCQN2QdNHPcpg1kQWOcJ6WRFbIz48mMXrV+go+7Ag7rbOM77AlQ6ctkt8gsNcE9BUJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761104634; c=relaxed/simple;
	bh=dg6Xeh8W9jYy+DaZHQ+BRa/bMuMWs5I/8dF5W8zJ63o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RNgxOt7ocnwNZc/vlY2eenfVO2Z0K7An6xLnG4hN0FyBA8n3EjjBMXzrBf7KUt/GTDHBi+gfUCT0pmPQj/ukzrMtXHJSgXi6N25cTCXNLBJrfLCHUggu1by8S5SdK6BfBho/EwoqxDSIi5IiPg/V/1zCBP8tz/js8NNBSMg0Bxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhj491uD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4aed12cea3so1063016766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761104631; x=1761709431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTRF+HmDl+bAL0OAwMRSISeP2Yi5Xj/P9MCjPmh9ndU=;
        b=Dhj491uDf6GgM98QDG4rMrgqFm6Y58n8M6FCBBSlbDeNKpHfWParpleNOIW63VzvJU
         OoQbFPtQRX1HkjZFuLqUjICVnSAuGdRG0ltM+9eO4K1c9C4frsmiRF7u1dhx9CpID9AH
         PRhsQQOuGxQeexv3lbX9lkJS0BCLokA3/542To6uNd/Vww6dXvxe5t843vjvU5ezjxY0
         OZptqPdPp22XHpCigZDNaKCekDu54tRgd2SAGr0F0feHl3jT5sZWrUzZg/+oyblcJWdS
         CvR2ELCxwntRh2NEn0qIzuB8D8pAqSTV204DdPIXvMmvTYVl5K2anL6YCw4+tyEdRCl4
         wu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761104631; x=1761709431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTRF+HmDl+bAL0OAwMRSISeP2Yi5Xj/P9MCjPmh9ndU=;
        b=BE5JofmThCDOtn90UcNcNl44JsTxEF6RAS0UpLN2jnJGBfVrGft2gMeVjp38ZFncBF
         vIeJkPHiltrZdSLatpHLGkJgrA4fbhF/1X5nTBazRfjw/cuameDi1NiBpEFlEEWjtC5R
         KAzXZCp0Hg9BoCz2GQkQoYx6a7shB3Phg2FGgr9yWPEGGvdFj/eNGstprSWvSk8Tgp5O
         HC3ebJjD4V9FJStKJvf14oPZNsxKCmkK99yYbm4TZhmxrCcCTi/9ewwsjf0O3mTnPDwi
         gtIlb3XlpH6cbW5XlprQS0s7mOasiuVFBlXC1wjNM1Mq3zrviFyg5Au/oKXR50woAwgj
         JOTQ==
X-Gm-Message-State: AOJu0Yzx5YVm/EjpPMvZ2wGvIUVYaTq1rParhMesh6IZLf5InTFl/pvD
	G5qzJYS/0PntP7Uq5mibcIBvpiAYJduR0ARwHmCgA5lb7TP/pVocRaES
X-Gm-Gg: ASbGncsMb/9YbvHAskBMC3ZPMaBciCwkWbtFXnU7KjITP2Hnm84BB7MLiQHVsRRl5k+
	acqjBkFpUjc6Raocdq8XpyrJjgitm39Jt2Re96jUrlpib1DnnnmTXkV4EDW+0JL6OGlicROkjzb
	tduvAtYfjv2j/zJsQcoYy1QtyBFBVxtgV4Z9hwXc8f/Bh/fHpgGFg5bh6UajOY7Hi+ns+FFjoKE
	lkF0ksWGtjmtXJhlv29d/8oPixE+DJt4G/5wGVo/A+PWrzznQORIMmRCaFO/dlXxd3ao8UDVaSp
	UHzuqp+4ReSi5V+XU1YVcpAk0H9fa457MY2XYNgKBjsDogKa5z2ihR0MW6OzwKyhJo4t8cMZZgV
	yXtjA4JqHTPCEMxg5C5m3WHNMqR5oj/ZGie1pwFLCjJC9itjGqMH/d8Z/Cxp8AoPBGF35MjO5MW
	hH5g==
X-Google-Smtp-Source: AGHT+IHPO7PWYa0DB82l3UyTHZGWH0MJm65SKGjGbpwKQ7i46gAfvnK/b0OSSMfiAZu596bNELN8nw==
X-Received: by 2002:a17:906:c103:b0:b3c:de0e:7091 with SMTP id a640c23a62f3a-b6472d5bb42mr2004845666b.8.1761104630850;
        Tue, 21 Oct 2025 20:43:50 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8395c52sm1220593966b.30.2025.10.21.20.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:43:50 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 719D24236CE1; Wed, 22 Oct 2025 10:43:45 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Documentation: process: Also mention Sasha Levin as stable tree maintainer
Date: Wed, 22 Oct 2025 10:43:35 +0700
Message-ID: <20251022034336.22839-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=bagasdotme@gmail.com; h=from:subject; bh=dg6Xeh8W9jYy+DaZHQ+BRa/bMuMWs5I/8dF5W8zJ63o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBk/gpqT5OacOPDC+KawRsOrkmu8Rx9v9XgcMJ0/bc1H9 ozpt+fv7yhlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEWmYyMjyrXFyeoJDyazqj mLijOOeZ7xGZXoeiWr2TF1z4zvzmzAGG/8UupnIcE9laTvRv4g5s25PjYPPET+orvyjP2468Cvf zTAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sasha has also maintaining stable branch in conjunction with Greg
since cb5d21946d2a2f ("MAINTAINERS: Add Sasha as a stable branch
maintainer"). Mention him in 2.Process.rst.

Cc: stable@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/process/2.Process.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 8e63d171767db8..7bd41838a5464f 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -99,8 +99,10 @@ go out with a handful of known regressions, though, hopefully, none of them
 are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
-"stable team," currently Greg Kroah-Hartman. The stable team will release
-occasional updates to the stable release using the 9.x.y numbering scheme.
+"stable team," currently consists of Greg Kroah-Hartman and Sasha Levin. The
+stable team will release occasional updates to the stable release using the
+9.x.y numbering scheme.
+
 To be considered for an update release, a patch must (1) fix a significant
 bug, and (2) already be merged into the mainline for the next development
 kernel. Kernels will typically receive stable updates for a little more

base-commit: 0aa760051f4eb3d3bcd812125557bd09629a71e8
-- 
An old man doll... just what I always wanted! - Clara


