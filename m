Return-Path: <linux-kernel+bounces-725128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23940AFFB18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E015A4060
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE88289E00;
	Thu, 10 Jul 2025 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7OzyPgE"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61D328982D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133166; cv=none; b=VkqMVp4NAI3ZfF+EpWU3kmdwRkJK6RBPtr9BasgVrjhVmmLMqsLvd+x3oBBj304riZmgCeO4HoF+MVHi1fS38yPx2Q0Bvh3n58xeq406ZBz8DsxFKZG7WthGeo+kpgDm/BdJ6oYNZCtPl1TupcoW6/v5lIiZVPKvB22jGjTDC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133166; c=relaxed/simple;
	bh=VzVapxAgUsP9Oc16nhWc5ZFzXOlTUI7twwNtwjbYFSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXed/lQN8GelbUfP+kHuLxiWfLEk8J/vBC5PgWoJF8yKH4nAUuCCAwgUHxeKGS6VW3OiFImt5ezHvIqrJkh4NFV6YQqct/XAagc6rjotM2i5T6GIUliegF4V/pfiI4iFDs7bxORCrUg72Cgk5p0l+lTM+ViE8c0jsDzJPQj7xvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7OzyPgE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so692063b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752133164; x=1752737964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FF48xnSlp05o3+3IJgrJF7ZpVzLIoUH+8qE33ijB9IE=;
        b=U7OzyPgEslayKlhxMnYCHqO06ZExCLTILT1b3QpQ4NgNLEcQ6DOVCSdEt1iqckzIs6
         QlvEO6fhLP7mVS62AkBKt5OhOBP3H9cH9zseXliMZoou2vxrWaAFgdMevECq1gfojbfg
         9f9EXqRQr+/x4FHRiOEx2BzyUiQyUWoAdWnhy2k3hnSOSU0OC++4KcrD/oBsABRbTdoZ
         hKR9ZWHzpEGHKeeXb0APun5626bahHDNmL4kqZIfju0s+la8Z1iI3VpmdrFPDICkv9+Q
         Rlij6ofwvLq+lAtho5riP9CRlqKqfJWdRGlApjvwVKz2i4Ti8Bk9YuDWfW0T8d9tx029
         6eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133164; x=1752737964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FF48xnSlp05o3+3IJgrJF7ZpVzLIoUH+8qE33ijB9IE=;
        b=RtRxBaqRtaJSMNwtFUbvyqGWGRTqGNmtJM4/mg5NROEcA57co32qh0oZqnheUbd7sL
         f8a2qRueHPl3u0j+07LmuBQU0F64yuC16Ux444KCIvl82wQRXEtUMGHlUrTqQN26jn38
         NEe8RYwVN281Cu11mpZwaiBSheEixMEdCc9MqFpxAVYmeunZIT7QQR+WBRuZNJbZHkrZ
         eHosp/7e1GtsGdP1i1suraSrgmjHeb0Ls+RKbW56+LCI7m2bFk4Xs8R6mbmkXdjukoda
         IpQF3OJGGwJ1/JgO5XFK2WIYuf6HBmx/rzfCMOR/C94Mgw9MeZfZyvU7PYP1lvFDJNlf
         0VCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs2Yza/CgFv1jWSqUtz/xNNdoVT4qm+16ixYCMFMXjIQLlDGfjOxX9XlnS1koMnJZ/4pYvGbD81Y62Trs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfwL6bJmHTeAsJ3rkPtNV0AI4VyHAiWt6nSlOpyYavJXRvwbGW
	pyjEbRkzDbG2pWz2RUBx6IsV5UJBG9cz/EkyIhRr2TwK0JjOoTvpxKOVMWm9XXi7
X-Gm-Gg: ASbGncsASEdqevsl7G99vSjG9aOfkFzVwrP0L2i8d39RbfTw3PNn3pQ8rV8GufNRZjC
	jqSKxT3dDLVS3wtPYJjyGblw1nuRTitPdy5SlDb6+oXSaB+4F4ZsEoNnJyqbARRTwIGNDEbbOMm
	E7a1xGdWw+L1aQoruE68OGPsJw0bsTdenLt/DXL2aZQsDPfjpoovXMvk5WLOy9y1eU89XgSlbZE
	poHr2U7ceJE5VNHVlYBF6gWK3kPVlf2Mq9eQE8oFKshscn7buefyCeSN5XKuxY+FQ6prXfs4sxR
	SP6akne1wiPA7D5fGq2cPY/ify8PcpO0NfzOhMzZAkIEAT8Dsdpw2yBUb9ewd8yhP5dtTwau+9O
	edSvRCkz/zzt570wfZXzx
X-Google-Smtp-Source: AGHT+IFn226hYce4EcLM+scYf2w40wvyFsgZYANp57JgE9FjnVoVSOG0p1ivDZ3U4Jj9dCbRPp8jkw==
X-Received: by 2002:a05:6a00:3d4e:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-74ea6411284mr9667307b3a.3.1752133163769;
        Thu, 10 Jul 2025 00:39:23 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4081:199:dcfb:ded1:3f8f:36be:5438])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8b990sm1347981b3a.153.2025.07.10.00.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:39:23 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: o-takashi@sakamocchi.jp
Cc: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH] firewire: ohci: Initialize payload_bus to avoid uninitialized use warning
Date: Thu, 10 Jul 2025 13:09:06 +0530
Message-Id: <20250710073906.24105-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Smatch-detected error:
drivers/firewire/ohci.c:1514 at_context_queue_packet()
error: uninitialized symbol 'payload_bus'.

Smatch reports a potential uninitialized use of 'payload_bus' in
at_context_queue_packet(). If packet->payload_length is zero, the
variable may not be set before reaching the dma_unmap_single() call,
which could lead to undefined behavior.

Initialize 'payload_bus' to 0 to ensure it has a defined value in all
code paths, preventing any uninitialized access.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 drivers/firewire/ohci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index edaedd156a6d..c05d90511f2b 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1392,7 +1392,7 @@ static int at_context_queue_packet(struct context *ctx,
 				   struct fw_packet *packet)
 {
 	struct fw_ohci *ohci = ctx->ohci;
-	dma_addr_t d_bus, payload_bus;
+	dma_addr_t d_bus, payload_bus = 0;
 	struct driver_data *driver_data;
 	struct descriptor *d, *last;
 	__le32 *header;
-- 
2.34.1


