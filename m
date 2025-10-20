Return-Path: <linux-kernel+bounces-860387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2DBF0048
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A393C3B3AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0402EBBAC;
	Mon, 20 Oct 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKx1m+P+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F712CDA5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950026; cv=none; b=kv5V6tCQvPv/6WeHw2Tg2di2wn7DhfNAa3SLAEQRA23cSG1v/x0dOnG0d4UzQlkCc4IKkEE2kGgOYta9GfSRs6qLW8Xxg6HTYkzp2TWBr62H1oCxJ6Bqd3Oec6xgIgWpSWVeATf3wqzF2kAv7py4KX0ArUgx2LQ+EpisQEuFjqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950026; c=relaxed/simple;
	bh=0p7pi7Yld99hBF6iVmp4sXJMuXA0SFTO3Ev1u98H2Y8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=ZgdkkIIJde5+U1Rca5siiVkSFvcGMsIkj3f08wrT+dwBRY/u+KntScYI0067RzFmqJerwUfF55EzxHH7ZfH9JB5pcPIvlMfQm+NWazEs3wTOnvLsoue1cz26YPPMd5mTk9nLEh2C5ff+mgXKYpIqz1FOjSQ5SIMuwoflg0FlPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKx1m+P+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760950023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XjEQjZwf4EmHPbS5RjxLJjALrd9Cs6yyFcKWJJYHCAk=;
	b=iKx1m+P+sJfxUDLviPh4xQGBVKa7AP3XBKtQqc/1Qt9TRyCELHviADi4MM4T2YbDBHWr+C
	nm4xBARO1Fd5/CCnsiFzqsvOtz0LIpvkusc6trFl9Y3NXyN0g2LwMkB0Cje4MfYoS5fD0o
	M99ZwyDtfP1Yp9ONIbFjKkHlvo1JyaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-LwPprkAhN6ODlYg8QAswsA-1; Mon,
 20 Oct 2025 04:47:00 -0400
X-MC-Unique: LwPprkAhN6ODlYg8QAswsA-1
X-Mimecast-MFC-AGG-ID: LwPprkAhN6ODlYg8QAswsA_1760950019
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D91118002C1;
	Mon, 20 Oct 2025 08:46:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9129430001A2;
	Mon, 20 Oct 2025 08:46:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Fix TCP_Server_Info::credits to be signed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1006941.1760950016.1@warthog.procyon.org.uk>
Date: Mon, 20 Oct 2025 09:46:56 +0100
Message-ID: <1006942.1760950016@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix TCP_Server_Info::credits to be signed, just as echo_credits and
oplock_credits are.  This also fixes what ought to get at least a
compilation warning if not an outright error in *get_credits_field() as a
pointer to the unsigned server->credits field is passed back as a pointer
to a signed int.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsglob.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 8f6f567d7474..b91397dbb6aa 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -740,7 +740,7 @@ struct TCP_Server_Info {
 	bool nosharesock;
 	bool tcp_nodelay;
 	bool terminate;
-	unsigned int credits;  /* send no more requests at once */
+	int credits;  /* send no more requests at once */
 	unsigned int max_credits; /* can override large 32000 default at mnt */
 	unsigned int in_flight;  /* number of requests on the wire to server */
 	unsigned int max_in_flight; /* max number of requests that were on wire */


