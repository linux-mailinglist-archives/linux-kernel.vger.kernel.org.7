Return-Path: <linux-kernel+bounces-793530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE72B3D4DB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 21:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C7017152F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F3F277013;
	Sun, 31 Aug 2025 19:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="YmlUHOWC";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="cldfSgBU"
Received: from e2i440.smtp2go.com (e2i440.smtp2go.com [103.2.141.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7E2765C0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756667892; cv=none; b=t2P/48MPEKjBkfOtNJbepb8V+Az7xhJ+kMsa9ekgzsw6VZ+m9VVaBYrC3croxx+mo6a6nwT3MgVleE25mCImWEaa4bsjpkdk0PrJc06XFJmsDSIZOskcI2xo1LVisyk3fBYzojfzTSaB5d1c07EQvqpC3o7WaGVZqZbzc6PyXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756667892; c=relaxed/simple;
	bh=DRcLIFuIOSuESQ2ofaXfG+0PDFNlbm73jo++sagk/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gwg2jA+vjMJJ8oogt70uGxn9UZhmyVGZ6/buv19UfFKe+Z5pZymn00G1gWVlLnfHOc2QGQEFLLTMPw/e27hb0Y8kRt9wNYwtJI4xuRlmk2UTeTmUrSe2NknmZd6ZkRIwV1ArE13sw6nKLQKSRSJr2VvWvRBN6BJMrs2q0maLtOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=YmlUHOWC reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=cldfSgBU; arc=none smtp.client-ip=103.2.141.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1756668790; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=; b=YmlUHOWCN8SnHhfnMU6+3okeiK
	xFxC5SIjzF6HOjD8w6vkrNs/attasnfylrL7MaJbxt8+d7fZnsJOlBhjN7w6vpPzNq3WBxz0ELUsK
	BD/cvsBHYl6h2ghoHUnQoTMsjhEU7DMqdp1FAYtqMrQDvLxJX0gO7dgwkT7bWMPQLVYxMvXfvBj11
	CBysuEan6L6zDgDi+ZhjkQmfz9meOeGbdgA0Xf8mla9i8Sb+MH/yb9227cxoxBWd7b+5meHKUtmwf
	HPZO4PSw5e+jQknXklAbVRXdLgjEy3cdCJq0HeZPWJIaDCJnAFZsXq9kp8dL4Jg0X3ha1I8bYmo0u
	TXbMFxSw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1756667890; h=from : subject
 : to : message-id : date;
 bh=yB6pbMXYcls8l8+6f9uwrMKHsQgjD3KAY1Ts8L0/mj4=;
 b=cldfSgBUC0YITv0FHUzkYCSarjbeju/L7WKk/RKlqfmxSlIpjn4rGlm+xhSb5j+Mb5ZW+
 O1WTPoNoklxK5Ci+BAKeJ8x8ZAdi0/norXnHKxgeayPgV72Eiz6doGoPA1JScFlRm71Requ
 VGu4haCfI9oedw3Poy+ikT16k25bIQGht1rT4MN3OEwWD12I4YEjFIMsY1hyIjdNEXB0x62
 HBc7cdwj4CdKt5g8EUuZRy4o2JcXpnml46XbVlmRoG6HKf9rMDN+2oody0LdLBtF5kyEcd3
 CIYMqOWnBui45PRyrGXgUvH8CWj7PMuaJRrm9sx0pGguzddumXpnbGgZuoGw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYr-TRk4Kv-5d; Sun, 31 Aug 2025 19:17:57 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1usnYq-AIkwcC8vNym-KDcR; Sun, 31 Aug 2025 19:17:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RFC PATCH 2/5] 9p: Introduce option for negative dentry cache
 retention time
Date: Sun, 31 Aug 2025 21:03:40 +0200
Message-ID: <18f109c2d62d0529511957f3c2a492374d01e63d.1756635044.git.repk@triplefau.lt>
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
X-Smtpcorp-Track: -IKmwD02fNdQ.ewGxnBPR3Vb2.IIQE8QEqUj5
Feedback-ID: 510616m:510616apGKSTK:510616sJVlOeeiTz
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Add support for a new mount option in v9fs that allows users to specify
the duration for which negative dentries are retained in the cache. The
retention time can be set in milliseconds using the ndentrytmo option.

For the same consistency reasons, this option should only be used in
exclusive or read-only mount scenarios, aligning with the cache=loose
usage.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 422bd720d165..7c0c2201b151 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -34,7 +34,7 @@ struct kmem_cache *v9fs_inode_cache;
 
 enum {
 	/* Options that take integer arguments */
-	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
+	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid, Opt_ndentrytmo,
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
@@ -52,6 +52,7 @@ static const match_table_t tokens = {
 	{Opt_dfltuid, "dfltuid=%u"},
 	{Opt_dfltgid, "dfltgid=%u"},
 	{Opt_afid, "afid=%u"},
+	{Opt_ndentrytmo, "ndentrytmo=%d"},
 	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
@@ -110,6 +111,8 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 			   from_kgid_munged(&init_user_ns, v9ses->dfltgid));
 	if (v9ses->afid != ~0)
 		seq_printf(m, ",afid=%u", v9ses->afid);
+	if (v9ses->ndentry_timeout != 0)
+		seq_printf(m, ",ndentrytmo=%d", v9ses->ndentry_timeout);
 	if (strcmp(v9ses->uname, V9FS_DEFUSER) != 0)
 		seq_printf(m, ",uname=%s", v9ses->uname);
 	if (strcmp(v9ses->aname, V9FS_DEFANAME) != 0)
@@ -251,6 +254,16 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 				v9ses->afid = option;
 			}
 			break;
+		case Opt_ndentrytmo:
+			r = match_int(&args[0], &option);
+			if (r < 0) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "integer field, but no integer?\n");
+				ret = r;
+			} else {
+				v9ses->ndentry_timeout = option;
+			}
+			break;
 		case Opt_uname:
 			kfree(v9ses->uname);
 			v9ses->uname = match_strdup(&args[0]);
-- 
2.50.1


