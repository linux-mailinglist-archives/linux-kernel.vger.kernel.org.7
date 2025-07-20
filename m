Return-Path: <linux-kernel+bounces-738292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E1B0B6D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0091897D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A554421CC4F;
	Sun, 20 Jul 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixQEtDsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32D2F50;
	Sun, 20 Jul 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027368; cv=none; b=E3KqIfSZ2t9VfiBTn59TqzGP/mX7LNh+i0Ur9vV9ssX/fcToY8mMQWUeyf9fQMRfGYrHOdaqTanBTyd9mU+8MIEuJFaBai4odgX7exiPAYrrCK6Hyd+roclN9Ld7FPpPvSdZNWkVS4qAFISdL99jcjsSHx7y1LoRfrFDb86RcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027368; c=relaxed/simple;
	bh=KOvd9h12om46AdPENSwvdfV7AtkFhdLph8vblX3Fhc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nzMBeLPMrhyv4UbMr467JcFhsG3xtIMIb7SAqUheVw07xf4KTEI6SR2os5NQ8lDebX0fPbwJ2QfO/CzTZBiJygzuuFcTmzFHWCrhuA6k818CXlrUBNb3+Pi9AMtnDpZLWr5Envbd195ENL87d24DbNOd8c030DjIS7+Z53PmH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixQEtDsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECAC4CEE7;
	Sun, 20 Jul 2025 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753027366;
	bh=KOvd9h12om46AdPENSwvdfV7AtkFhdLph8vblX3Fhc0=;
	h=From:To:Cc:Subject:Date:From;
	b=ixQEtDsScMnevPaf4pvOisBwLgGFyzYOfQFA3u+uP3CDy9FyXqU3DOxV27oMtsa33
	 mjl5YkvixKbkEqns/yfM2YFIsvS5Hbv0FLzP+nl8nNhKtzlJA21g+vhyDsZLbpUri8
	 rJxIM6wXOb5OMDkcvN/ZlWtz/32sgKERH34EYQABzXZ9TXHljl7UDQWCeJv2Y5ox2T
	 nPEnJ59ouqWQ8+N8MaHYYBnOmbpQZO7EvaVdNtx2yoMW2umg9AZRXbP9jNq07VQ3rB
	 f2MU+7untXXzFhD2wQS2/ud+WHCLngOJ413HRnIdghqPEUjvKfn9Ifuvuv8CIsC+04
	 WR56Jjexv1SBw==
From: carlos.bilbao@kernel.org
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: bilbao@vt.edu,
	Carlos Bilbao <carlos.bilbao@kernel.org>
Subject: [PATCH] docs/core-api: Fix circular buffer examples
Date: Sun, 20 Jul 2025 11:02:43 -0500
Message-ID: <20250720160243.149595-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Fix circular buffer usage in producer/consumer examples in
circular-buffers.rst. They incorrectly access items using buffer[head] and
buffer[tail], as if buffer was a flat array; but the examples also use
buffer->head and buffer->tail, so it's a struct. Use buffer->vals[head] and
buffer->vals[tail] instead to match the intended layout.

Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
---
 Documentation/core-api/circular-buffers.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/circular-buffers.rst b/Documentation/core-api/circular-buffers.rst
index 50966f66e398..b697915a2bd0 100644
--- a/Documentation/core-api/circular-buffers.rst
+++ b/Documentation/core-api/circular-buffers.rst
@@ -161,7 +161,7 @@ The producer will look something like this::
 
 	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
 		/* insert one item into the buffer */
-		struct item *item = buffer[head];
+		struct item *item = buffer->vals[head];
 
 		produce_item(item);
 
@@ -203,7 +203,7 @@ The consumer will look something like this::
 	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
 
 		/* extract one item from the buffer */
-		struct item *item = buffer[tail];
+		struct item *item = buffer->vals[tail];
 
 		consume_item(item);
 
-- 
2.43.0


