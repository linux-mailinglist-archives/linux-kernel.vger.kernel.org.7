Return-Path: <linux-kernel+bounces-590992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58724A7D965
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830251895FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F1E23C8A1;
	Mon,  7 Apr 2025 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxefefRn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E623BFBC
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017364; cv=none; b=Z3nip5lBax4U6ed9TM23Bdq+vNV9zmHNRyQQWz2qVwJdM8KESC6LRtY0TKQSedpbw3hDVLE0MOn6cq/cX4M3MlRcx1A+/xT6YzPQ07/azz4IwSRjW9kJCweWZo3iXXhOIpnmf3W6ddNMmonu8wP1Ofjak8b+AiFH5Z9HADzVehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017364; c=relaxed/simple;
	bh=s1cg6/4yVyJ+GatvRaJHn+uMmglmLv5UIEnqk4TQ214=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Krg1iuIIcrhSiYBZRLL7wrqCuuT7bCb1UxSGFJapGno84dG4xWZnv0NI+XoVqKX5YHcfDRQLzHC2wCsrEfIW6fIcch62ZPieeYkx3kB37A146nKjnU/lrZSzYf1uHs0K74pyQV3aJ9cxE+JzgWqOpgzDCW3DUfyQ6SLvuoNDAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxefefRn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744017361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k4o0+tlLLgSx7vyyBhWv2W6pdzLe8DJIqj+A7hB89U=;
	b=CxefefRngO20Z0ViF++ehks4bADZ8yRyrEBlbaz3R8EvitnmouwwSMcQyuNto6e89Cp5oJ
	tEfZEgzxIXGwrRFmmOMnV6oGp9lR/MtW9jglA/E3zeG1ou++74AL6Jb1tQK1URijkWF6zW
	ixmqkQFTfcrQgRS0ObgICMQq2CPY1VE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-YwrnW-CdNs6VciJopexWJw-1; Mon,
 07 Apr 2025 05:16:00 -0400
X-MC-Unique: YwrnW-CdNs6VciJopexWJw-1
X-Mimecast-MFC-AGG-ID: YwrnW-CdNs6VciJopexWJw_1744017358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86A7B180AF69;
	Mon,  7 Apr 2025 09:15:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18096180A803;
	Mon,  7 Apr 2025 09:15:54 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	openafs-devel@openafs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/12] rxrpc: Add more CHALLENGE/RESPONSE packet tracing
Date: Mon,  7 Apr 2025 10:14:42 +0100
Message-ID: <20250407091451.1174056-12-dhowells@redhat.com>
In-Reply-To: <20250407091451.1174056-1-dhowells@redhat.com>
References: <20250407091451.1174056-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add more tracing for CHALLENGE and RESPONSE packets.  Currently, rxrpc only
has client-relevant tracepoints (rx_challenge and tx_response), but add the
server-side ones too.

Further, record the service ID in the rx_challenge tracepoint as well.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 include/trace/events/rxrpc.h | 78 +++++++++++++++++++++++++++++++++++-
 net/rxrpc/output.c           |  2 +
 net/rxrpc/rxgk.c             |  4 ++
 net/rxrpc/rxkad.c            |  2 +
 4 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 920439df1f6f..378d2dfc7392 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -1201,6 +1201,39 @@ TRACE_EVENT(rxrpc_rx_conn_abort,
 		      __entry->abort_code)
 	    );
 
+TRACE_EVENT(rxrpc_tx_challenge,
+	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
+		     u32 version, u32 nonce),
+
+	    TP_ARGS(conn, serial, version, nonce),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	conn)
+		    __field(rxrpc_serial_t,	serial)
+		    __field(u32,		version)
+		    __field(u32,		nonce)
+		    __field(u16,		service_id)
+		    __field(u8,			security_ix)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->conn = conn->debug_id;
+		    __entry->serial = serial;
+		    __entry->version = version;
+		    __entry->nonce = nonce;
+		    __entry->service_id = conn->service_id;
+		    __entry->security_ix = conn->security_ix;
+			   ),
+
+	    TP_printk("C=%08x CHALLENGE r=%08x sv=%u+%u v=%x n=%x",
+		      __entry->conn,
+		      __entry->serial,
+		      __entry->service_id,
+		      __entry->security_ix,
+		      __entry->version,
+		      __entry->nonce)
+	    );
+
 TRACE_EVENT(rxrpc_rx_challenge,
 	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
 		     u32 version, u32 nonce, u32 min_level),
@@ -1213,6 +1246,7 @@ TRACE_EVENT(rxrpc_rx_challenge,
 		    __field(u32,		version)
 		    __field(u32,		nonce)
 		    __field(u32,		min_level)
+		    __field(u16,		service_id)
 		    __field(u8,			security_ix)
 			     ),
 
@@ -1222,18 +1256,60 @@ TRACE_EVENT(rxrpc_rx_challenge,
 		    __entry->version = version;
 		    __entry->nonce = nonce;
 		    __entry->min_level = min_level;
+		    __entry->service_id = conn->service_id;
 		    __entry->security_ix = conn->security_ix;
 			   ),
 
-	    TP_printk("C=%08x CHALLENGE r=%08x sx=%u v=%x n=%x ml=%x",
+	    TP_printk("C=%08x CHALLENGE r=%08x sv=%u+%u v=%x n=%x ml=%x",
 		      __entry->conn,
 		      __entry->serial,
+		      __entry->service_id,
 		      __entry->security_ix,
 		      __entry->version,
 		      __entry->nonce,
 		      __entry->min_level)
 	    );
 
+TRACE_EVENT(rxrpc_tx_response,
+	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
+		     struct rxrpc_skb_priv *rsp),
+
+	    TP_ARGS(conn, serial, rsp),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,	conn)
+		    __field(rxrpc_serial_t,	serial)
+		    __field(rxrpc_serial_t,	challenge)
+		    __field(u32,		version)
+		    __field(u32,		kvno)
+		    __field(u16,		ticket_len)
+		    __field(u16,		appdata_len)
+		    __field(u16,		service_id)
+		    __field(u8,			security_ix)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->conn	= conn->debug_id;
+		    __entry->serial	= serial;
+		    __entry->challenge	= rsp->resp.challenge_serial;
+		    __entry->version	= rsp->resp.version;
+		    __entry->kvno	= rsp->resp.kvno;
+		    __entry->ticket_len = rsp->resp.ticket_len;
+		    __entry->service_id = conn->service_id;
+		    __entry->security_ix = conn->security_ix;
+			   ),
+
+	    TP_printk("C=%08x RESPONSE r=%08x cr=%08x sv=%u+%u v=%x kv=%x tl=%u",
+		      __entry->conn,
+		      __entry->serial,
+		      __entry->challenge,
+		      __entry->service_id,
+		      __entry->security_ix,
+		      __entry->version,
+		      __entry->kvno,
+		      __entry->ticket_len)
+	    );
+
 TRACE_EVENT(rxrpc_rx_response,
 	    TP_PROTO(struct rxrpc_connection *conn, rxrpc_serial_t serial,
 		     u32 version, u32 kvno, u32 ticket_len),
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index 8138f35d7945..0af19bcdc80a 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -953,6 +953,8 @@ void rxrpc_send_response(struct rxrpc_connection *conn, struct sk_buff *response
 	serial = rxrpc_get_next_serials(conn, 1);
 	wserial = htonl(serial);
 
+	trace_rxrpc_tx_response(conn, serial, sp);
+
 	ret = skb_store_bits(response, offsetof(struct rxrpc_wire_header, serial),
 			     &wserial, sizeof(wserial));
 	if (ret < 0)
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 825430edaf0c..f7488bb19f60 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -668,6 +668,8 @@ static int rxgk_issue_challenge(struct rxrpc_connection *conn)
 	serial = rxrpc_get_next_serials(conn, 1);
 	whdr->serial = htonl(serial);
 
+	trace_rxrpc_tx_challenge(conn, serial, 0, *(u32 *)&conn->rxgk.nonce);
+
 	ret = do_udp_sendmsg(conn->local->socket, &msg, len);
 	if (ret > 0)
 		conn->peer->last_tx_at = ktime_get_seconds();
@@ -1201,6 +1203,8 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	if (xdr_round_up(token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);
+
 	offset	+= xdr_round_up(token_len);
 	len	-= xdr_round_up(token_len);
 
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index ac13907cc93a..02f2e8ddcf6c 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -685,6 +685,8 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
+	trace_rxrpc_tx_challenge(conn, serial, 0, conn->rxkad.nonce);
+
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 2, len);
 	if (ret < 0) {
 		trace_rxrpc_tx_fail(conn->debug_id, serial, ret,


