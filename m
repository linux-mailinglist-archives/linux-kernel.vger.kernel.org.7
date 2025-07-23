Return-Path: <linux-kernel+bounces-742251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FBDB0EF23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A021C82DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503EB274B45;
	Wed, 23 Jul 2025 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vQ5JX17P"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457082836B1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264954; cv=none; b=Dpz0EnOOtR3aR8RLu1UaYtlA6txaOwHkqF5EpdLfdR6GrrXZmizEPVvp78tbNQ81uehqZmmL+/US/bEfv+pbbwVf/btV0FV0xvi9167o2cIyAmfK/4BjIJOj4jD12YUC0wqwZeNKlKNoJGjBTMqwExbZYslf3F6RIx1i4RGtVcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264954; c=relaxed/simple;
	bh=cn1B5ecgw5EKcEgrWy4NTY3Cs+jsoDRUGQ+tJQA8psA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ol2mSuDPyippsDNA0t/lDA5KWFnbiSRuhrJb6I4n/+rHAe8T+aWkHn5VMqErmcy9FqpgP8HTA0j5wQ9NbBlDMyrXtsEVsncXMQFj5ARDKFGoROVIU2NXnky7r5QvweJhYQ0yltH7Qvjy9ZGhSTMomDVs5oZqqECRhYtr29O1Hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vQ5JX17P; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 40999EA0;
	Wed, 23 Jul 2025 12:01:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753264913;
	bh=cn1B5ecgw5EKcEgrWy4NTY3Cs+jsoDRUGQ+tJQA8psA=;
	h=From:Subject:Date:To:Cc:From;
	b=vQ5JX17PhTvAw3VNQcA5zF4x7mOEKrQ8xvecVKEGGQLETsv6GnGGfqWFr6mXH8rIm
	 VEQ+lyckNlZ+Vod7bdokR5CNNd5dr1+vtgVpX1BfP3c2dUC6EF8Im9vqk5Ato1HLae
	 yZsY3Z/4X0yDZsZdGNxgHxpQ0xHNZa1uP8iI2nmg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 0/2] phy: cdns-dphy: hs-clk improvement and a cleanup
Date: Wed, 23 Jul 2025 13:01:27 +0300
Message-Id: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPiygGgC/x2MQQqDMBAAvyJ77oKmhES/Ij2E7GqWlihZEYv4d
 4PHGZg5QbkIKwzNCYV3UVlyhe7VQEwhz4xClcG0xrbOvDFSVqQ1/TEpxt8XS9gYJzkweG9dsM7
 3RFD7tXDVz3v8XNcNYQu04GsAAAA=
X-Change-ID: 20250723-cdns-dphy-hs-clk-rate-fix-a8857a5789dd
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=790;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=cn1B5ecgw5EKcEgrWy4NTY3Cs+jsoDRUGQ+tJQA8psA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBogLMyuVGyst63t76wqrfpHRjH6LmaNOkYMQ6XN
 7un641NTMGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaICzMgAKCRD6PaqMvJYe
 9RqwD/sGgKuFWMNd7hSi7C11CtTdvaN59jQaoxMZKeamstaG68jGFssd2eio+LEpWbONWc+t5Th
 n1PsW/9jnwditdUlYjWTG6t3bGSv5H/54M/QatVKOyuURbL7VOniIesPGmaO55eSU8RDqar/KMl
 tZOefrRVhJZqvgzHk/nP4PbHn7omiclvDRahrcBB6e5XlhGMQp6eXIuodx8rnJKtevnQvte5T4D
 XzJmbLvkFqX5OXJOu56Ma1lHEGBJUm2dPlce0IlqodFwFgVr6pAZLpQaoBkZ++vjQUku36Rf0/m
 SSEH6Aqmm7G35P8vl1+4FnKMrTIUEmlcYJKJxAUv/6qDYaQZCbsi0HH58aNE2AFL1qvanyw3dL3
 LWj2Sc1oRDMNFszQyV1YDkmEUAM8fcSAvEU1JaUtWrTHGmaJ5PmOAQX33r40COEQqQWhntISeD4
 johHcgLQl5ZFJKN/9tvPZaaFK09UtcrrWjiVbnPAdcN4WLk2VttfOtf4oNlEc8LTzhT0pGwTTqA
 +sHTKT7e1A2VCF31nLasLQg4ygbkBxvDNz539H8dU8BI3hT4td0agyP9jugMbihKVCwz+nDivGX
 mwWdfPNL41ilF/Vv4SFMq32oKuBiXKFHmoixpjGPY99A65UpYjtOuCTp90XszorRO1AOz1wr19X
 PLdNJr29m20SvhA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

A cdns-dphy improvement to return the actual hs clock rate, and a
cleanup to remove leftover code.

These were part of a Cadence DSI series:

https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02%40ideasonboard.com/

but are now separately here for easier merging.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Tomi Valkeinen (2):
      phy: cdns-dphy: Store hs_clk_rate and return it
      phy: cdns-dphy: Remove leftover code

 drivers/phy/cadence/cdns-dphy.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)
---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250723-cdns-dphy-hs-clk-rate-fix-a8857a5789dd

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


