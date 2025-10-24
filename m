Return-Path: <linux-kernel+bounces-869422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D422C07D83
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E4519A77BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496823557F9;
	Fri, 24 Oct 2025 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byz1qzGg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B67241696
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332873; cv=none; b=jWJAoK4d0N/apd705lFrygn5W+BsR+GDsH0b3RqkvENsFLlVZNpejWVq+mGs/tR103cBxFqCkdxGDx9pedHBt3rJDu0TpffytAokszuu8vb8mEijgo2UhxUyzSHeCJtFhToTAAs8SM/at4Ae4xA407HXRpuBVfvD3hdK6jLbrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332873; c=relaxed/simple;
	bh=Rp0S1cz5R3mZoSK1gypCqO4bXsp2In1jV1KtJpGfMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzYw1akKmHeU7IXvM/05ESIMUvTkD62UlNo40Y6+LV1h3Bxqk+YhR9eFsNBEbru1bxRsL1u9YIkU6RHBN2lEjD31axJBHo4CKRPPFGOQYtJoGnovI5cn1KfWqb5/Mm0NPajrhuN+ETeOiTAX2hUzcaKClUs8QFB41jfBM1kMkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byz1qzGg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761332871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eC+zTvafGlTgn+UU2Bj+Z+f8183EJxEhCVpC3+v5f0c=;
	b=byz1qzGgKMuUIQGgwOy4Wg/zDRKrxFrWvpbZen7DppHmtmijQ4C8oHc0hRTQsJleJ9pTYt
	zb21k/rr3mbG3v/mcK5BNkTO/xSAjkdWgeEH2maHYouQj+PFsJgxR4TGCxnsGlYxPs32ZI
	S/tAv2B06ommw3PBd96akyZYGyoryaY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-76fJApRKPMyqamEK_hIWlw-1; Fri,
 24 Oct 2025 15:07:49 -0400
X-MC-Unique: 76fJApRKPMyqamEK_hIWlw-1
X-Mimecast-MFC-AGG-ID: 76fJApRKPMyqamEK_hIWlw_1761332868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 554891954102;
	Fri, 24 Oct 2025 19:07:48 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B31FF1800353;
	Fri, 24 Oct 2025 19:07:45 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org (open list:DPLL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: ivecera@redhat.com,
	mschmidt@redhat.com,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net] dpll: fix device-id-get and pin-id-get to return errors properly
Date: Fri, 24 Oct 2025 21:07:33 +0200
Message-ID: <20251024190733.364101-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The device-id-get and pin-id-get handlers were ignoring errors from
the find functions and sending empty replies instead of returning
error codes to userspace.

When dpll_device_find_from_nlattr() or dpll_pin_find_from_nlattr()
returned an error (e.g., -EINVAL for "multiple matches" or -ENODEV
for "not found"), the handlers checked `if (!IS_ERR(ptr))` and
skipped adding the device/pin handle to the message, but then still
sent the empty message as a successful reply.

This caused userspace tools to receive empty responses with id=0
instead of proper netlink errors with extack messages like
"multiple matches".

The bug is visible via strace, which shows the kernel sending TWO
netlink messages in response to a single request:

1. Empty reply (20 bytes, just header, no attributes):
   recvfrom(3, [{nlmsg_len=20, nlmsg_type=dpll, nlmsg_flags=0, ...},
                {cmd=0x7, version=1}], ...)

2. NLMSG_ERROR ACK with extack (because of NLM_F_ACK flag):
   recvfrom(3, [{nlmsg_len=60, nlmsg_type=NLMSG_ERROR,
                 nlmsg_flags=NLM_F_CAPPED|NLM_F_ACK_TLVS, ...},
                [{error=0, msg={...}},
                 [{nla_type=NLMSGERR_ATTR_MSG}, "multiple matches"]]], ...)

The C YNL library parses the first message, sees an empty response,
and creates a result object with calloc() which zero-initializes all
fields, resulting in id=0.

The Python YNL library parses both messages and displays the extack
from the second NLMSG_ERROR message.

Fix by checking `if (IS_ERR(ptr))` first and returning the error
code immediately, so that netlink properly sends only NLMSG_ERROR with
the extack message to userspace. After this fix, both C and Python
YNL tools receive only the NLMSG_ERROR and behave consistently.

This affects:
- DPLL_CMD_DEVICE_ID_GET: now properly returns error when multiple
  devices match the criteria (e.g., same module-name + clock-id)
- DPLL_CMD_PIN_ID_GET: now properly returns error when multiple pins
  match the criteria (e.g., same module-name)

Before fix:
  $ dpll pin id-get module-name ice
  0  (wrong - should be error, there are 17 pins with module-name "ice")

After fix:
  $ dpll pin id-get module-name ice
  Error: multiple matches
  (correct - kernel reports the ambiguity via extack)

Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 74c1f0ca95f24a..a4153bcb6dcfe1 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1559,16 +1559,18 @@ int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EMSGSIZE;
 	}
 	pin = dpll_pin_find_from_nlattr(info);
-	if (!IS_ERR(pin)) {
-		if (!dpll_pin_available(pin)) {
-			nlmsg_free(msg);
-			return -ENODEV;
-		}
-		ret = dpll_msg_add_pin_handle(msg, pin);
-		if (ret) {
-			nlmsg_free(msg);
-			return ret;
-		}
+	if (IS_ERR(pin)) {
+		nlmsg_free(msg);
+		return PTR_ERR(pin);
+	}
+	if (!dpll_pin_available(pin)) {
+		nlmsg_free(msg);
+		return -ENODEV;
+	}
+	ret = dpll_msg_add_pin_handle(msg, pin);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
 	}
 	genlmsg_end(msg, hdr);
 
@@ -1735,12 +1737,14 @@ int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dpll = dpll_device_find_from_nlattr(info);
-	if (!IS_ERR(dpll)) {
-		ret = dpll_msg_add_dev_handle(msg, dpll);
-		if (ret) {
-			nlmsg_free(msg);
-			return ret;
-		}
+	if (IS_ERR(dpll)) {
+		nlmsg_free(msg);
+		return PTR_ERR(dpll);
+	}
+	ret = dpll_msg_add_dev_handle(msg, dpll);
+	if (ret) {
+		nlmsg_free(msg);
+		return ret;
 	}
 	genlmsg_end(msg, hdr);
 
-- 
2.51.0


