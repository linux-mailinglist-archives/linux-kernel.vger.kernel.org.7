Return-Path: <linux-kernel+bounces-869414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A251C07D32
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1F23BCD7E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FB034C15E;
	Fri, 24 Oct 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBElSGu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6534C134
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332135; cv=none; b=eY3Z1izVqE88lEB4RKXv3+Jbxupb27uVOxjiHRDaUXkImI43E7PxXXfycPbTu0jZKWF6zzZOwq6Pc0h0n9FTFxY0gTKnG4pSBjeVFuAvq/llAAwLghPt8oRuxrYu7dubVuUyJkryNbpWqzk24UU/B6JHL4PBJglu6Kl1aeCi0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332135; c=relaxed/simple;
	bh=Au2y6QuL/1OptsUjz9Vi4Quqje7xjMfFkThB1fdAqvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozdDDNuZnP8j9U9iXLAQCq0Fw/uWttcw7N8xIF7NeuAOJAQlCNxlYgXWzQNuRmcq5hKOMVz2Ecckws0S4PcpJrqDyTpUZ0aKFDtyZS0jbOu1/5fEKch/rVs1X4sDV1Y3J7S0YPfyDUA5w8A1FaeUy8+teTmEYbIDXRrIm6z23Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBElSGu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761332131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zh2IWrtmuEEEWOhFl4HGUxrir13Dlskm07kP1/wIoac=;
	b=aBElSGu/oeJ2NwvuC8YJ+ItN6JT5PW4U8hrscPrhxAf8lcYKAcvqNSGAn6oSm0ZlDbnVaw
	Ly3f8PJbAQP+0Rq5sqsyaLn1l/8NfWS0BWQ66JD5c3OhVUvuBBLk3H8DriBND/tPGdIT8K
	Cd02ye8cb1ZUQW/akixKzSJucOr2658=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-XT0nEk2sPvyUyZwXNOowPA-1; Fri,
 24 Oct 2025 14:55:26 -0400
X-MC-Unique: XT0nEk2sPvyUyZwXNOowPA-1
X-Mimecast-MFC-AGG-ID: XT0nEk2sPvyUyZwXNOowPA_1761332124
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F0FA19733CC;
	Fri, 24 Oct 2025 18:55:23 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.192])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA9FD19540E9;
	Fri, 24 Oct 2025 18:55:18 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Milena Olech <milena.olech@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Petr Oros <poros@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Michalik <michal.michalik@intel.com>,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: mschmidt@redhat.com
Subject: [PATCH net] dpll: spec: add missing module-name and clock-id to pin-get reply
Date: Fri, 24 Oct 2025 20:55:12 +0200
Message-ID: <20251024185512.363376-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The dpll.yaml spec incorrectly omitted module-name and clock-id from the
pin-get operation reply specification, even though the kernel DPLL
implementation has always included these attributes in pin-get responses
since the initial implementation.

This spec inconsistency caused issues with the C YNL code generator.
The generated dpll_pin_get_rsp structure was missing these fields.

Fix the spec by adding module-name and clock-id to the pin-attrs reply
specification to match the actual kernel behavior.

Fixes: 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 Documentation/netlink/specs/dpll.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index cafb4ec20447e1..80728f6f9bc876 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -605,6 +605,8 @@ operations:
         reply: &pin-attrs
           attributes:
             - id
+            - module-name
+            - clock-id
             - board-label
             - panel-label
             - package-label
-- 
2.51.0


