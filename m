Return-Path: <linux-kernel+bounces-827620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55599B923BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4F188ECED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A922311C19;
	Mon, 22 Sep 2025 16:32:22 +0000 (UTC)
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6803115BB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558742; cv=none; b=a1jPzL9OdfXFEDIRi1tpIrDneHomWMYV3W9jIEBJPd+/JAa344+6RH8+rWsM6LRy94bWIG2wSgTTQvjqXU9tBNLx6SCPeN3uJ5fVHxqC0aqQMRZI+axK3IP3my4rqUnmK/dWGTgJZ104MlMfnN2L4tkfYPbrAbBGbgsTBlPiM6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558742; c=relaxed/simple;
	bh=L+1GpczOXpwStUSxO6lxxywZlkszQxq/Sca4B3MQJto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XKGDauH0UkaEEv9Y1vnhgxK31A7lTH1WGyGpjVCJPaDJBPiv/bJOqP0lSNpySa753lgIuPyIf7O/lNDIA5ITnSAqOX2rH7UyxmEY8xc2ZsI1D0Y7GEK9BipUr97MQfOQ2gj/PjrsTnPSiDBkTDzh8b+vA5DzgNQjItQggb6gAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: Alexey Simakov <a.simakov@securitycode.ru>
To: <marcelo.leitner@gmail.com>
CC: Alexey Simakov <a.simakov@securitycode.ru>, <lucien.xin@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-sctp@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] sctp: fix null deref in sctp_sf_do_5_1D_ce()
Date: Mon, 22 Sep 2025 19:15:55 +0300
Message-ID: <20250922161557.2716-2-a.simakov@securitycode.ru>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SPB-EX1.Securitycode.ru (172.16.24.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

The check of new_asoc->peer.adaptation_ind can fail,
leaving ai_ev uninitialized. In that case, the code
can jump to the nomem_authdev label and later call
sctp_ulpevent_free() with a null ai_ev pointer.
Leading to a potential null dereference.

Add check of ai_ev pointer before call of
sctp_ulpevent_free function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT")
Signed-off-by: Alexey Simakov <a.simakov@securitycode.ru>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..93cac73472c7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.34.1


