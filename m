Return-Path: <linux-kernel+bounces-793534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 146CEB3D4DF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60501899ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFB2773F9;
	Sun, 31 Aug 2025 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="2JSeaLru";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="aazivrjU"
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50225221275
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667894; cv=none; b=b9hVUUZVzG6+/VXUWEOxDWzDjdCJ9naoL7i0YGQkHsOYkUR5DsZlMMs4S2Y+59wQNodHCQt8g6Q8PaOHP1DRt7nMIdekcY1Kq5a6FIo+Uq7blfvmPQXcqIMV0sbO5a+VxFS4lxiZCtxTSydK3021W8jZSGNc0jSWonZbGwzQBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667894; c=relaxed/simple;
	bh=7D3KwNWJoC6p1VF2zcIsFrvHRGbh4rZ3AUloKNQr7YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcVP6l0xtgetNrlxT0ZMiIIZTME7Qe++W9xLfsn/MLwArZ9W3iZJ+A28I1Lmj8ltX+cIsDANS0srA8YodLbnhEz+G3ovz3i/uIwkoqBsqttn27q7E61muqkZODHRs+Jqv+QCcs78+7blF14L02KdfivujbrhWIoUFTccwuDjB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=2JSeaLru reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=aazivrjU; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668792; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=; b=2JSeaLrumPYpLTAQOtDbLejeR2
	tCsT7/85RIulIbZfr6DnCyOINKzyEbMRFqeFIcXLJYi6HsZwr2MuVZUwBwyMrqB/FMyFckR90HALy
	NfxlY+Xjm2lTjHy57VKlDRMc9rTifCpoDtHB43Kcdl+Dm1Ul7bfgi4uIkl6og366o/OOvAQdPl6im
	6g55sTKpzTgydDNPnW6ANkn0cMaMhRw75Qw4IJmw8pSSd9346/CmFb6x1pjlAiDKkYAw0lU9BZxqO
	lV7ujydn7mcJN6CvxB0dQon3npxf4XeM7qfwsiDq0d+q3iTAfMOnh1x7qtSr+yOGk2VjCoMpkpnQr
	jhYd0Sdw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667892; h=from : subject
 : to : message-id : date;
 bh=XTOQ9/bbRBmTKIaXSYEBEdp9Uyv1R7EscXEwjs/sOsY=;
 b=aazivrjUIAnUHPbQXKm/+ydnhUtclD9XyGkvrYaUvNTIgvTJPTkr9jZBFYcIvLYp6/E3d
 A20zblz29fu3IOdm9tVwwlsdoE21VYDJgZvjIg/yajEqdt5VhqNRSMR2ThacICn6RA150Q1
 Saae8F2f4cfuQi+I053g3X4Rfcyouf4EJCDOO04JU6GOqpfP+uUz57Gt/NvCej/Xfn6IMzm
 51LFwA2UXH3frYFurlHF0Td4o1HuCQE/PJ/gH+kBCWAEgJNQGPzq7WibU5zLJhL0wbWPAfu
 ESqner43KLfiv3WfOj59PZrJWXigTGS4bT6TUM4daKY2CJB19qdil+GRf/cQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-TRk4XF-Tb; Sun, 31 Aug 2025 19:17:59 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYt-4o5NDgrhYfw-mjHk; Sun, 31 Aug 2025 19:17:59 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 5/5] 9p: Track 9P RPC waiting time as IO
Date: Sun, 31 Aug 2025 21:03:43 +0200
Message-ID: <cd1a0278bc06117a870fa7068228e77327a25127.1756635044.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1756635044.git.repk@triplefau.lt>
References: <cover.1756635044.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: RczFNjPfh5-k.CymStYCYNnlH.lqbE2AkkXtC
Feedback-ID: 510616m:510616apGKSTK:510616svxP-T_CuV
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Use io_wait_event_killable() to ensure that time spent waiting for 9P
RPC transactions is accounted as IO wait time.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/9p/client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..3f0f4d6efc00 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -713,8 +713,8 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err = wait_event_killable(req->wq,
-				  READ_ONCE(req->status) >= REQ_STATUS_RCVD);
+	err = io_wait_event_killable(req->wq,
+				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
 
 	/* Make sure our req is coherent with regard to updates in other
 	 * threads - echoes to wmb() in the callback
-- 
2.50.1


