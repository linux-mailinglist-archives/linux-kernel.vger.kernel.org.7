Return-Path: <linux-kernel+bounces-782153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A98AB31BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196A31D410F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6D43126D7;
	Fri, 22 Aug 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmwAyjLq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A4310647
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872553; cv=none; b=SsF0p+iVzYq+Sk38Kcwx4vPonMQQvGJlKoJMrD68f4eRiZPQ4+QMq/hswBOJIdz2CKi5itJ7YB+fQlDwH1G+o4nwZLwF3DkLnI39m/rZh/a7IHkSGKnCEHHBAT0yao9H5dxA4bqIWFdCzGcFsaM2abHL4EZQxvxdEwWc723508A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872553; c=relaxed/simple;
	bh=EwhQfNdwMRYnfyJhiDl/WI6c9SiGSsdsQ4W0UUcmEFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8VaPIQZUq5jf/fDoLfdenc2DjJBaVFd5aI0eFFE9YtC8odFXU5E9I1v7oHY4leFQxKQbE4cDnkKhDA+MbAfYsvTBaSysKwGc2L2lA4ImxGUcN4OcgownDYjbQ6dQ+9MVCQ2n5hXatyZUb6wj1IA2ODTSK4g4wzOULfZHrs+F80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SmwAyjLq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755872550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OjevWaCAD9+4PGKq/fwSEtJ4889VG5wi2+iz89n84dc=;
	b=SmwAyjLqN5XekkC7Ub1k7A+Z25GeUzHMaljxlfCnqjPv+8bc0fxh2icPScku2yWJiW2VH4
	9P9xpw2EEx4FM/sAIpQXry6bHr/Lrn7V67gni79QWVs15EENobUIirJ2XTYi9YtYRSBdSM
	F9Pmnrau7SLEUEDTwVZtoeADpH92tj8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-Fnxh-02ROLuLaIZevzUWMg-1; Fri,
 22 Aug 2025 10:22:26 -0400
X-MC-Unique: Fnxh-02ROLuLaIZevzUWMg-1
X-Mimecast-MFC-AGG-ID: Fnxh-02ROLuLaIZevzUWMg_1755872545
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AEB121956088;
	Fri, 22 Aug 2025 14:22:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.132])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E283730001A1;
	Fri, 22 Aug 2025 14:22:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] request-key: Fix mishandling of last line of config file
Date: Fri, 22 Aug 2025 15:22:09 +0100
Message-ID: <20250822142215.2475014-3-dhowells@redhat.com>
In-Reply-To: <20250822142215.2475014-1-dhowells@redhat.com>
References: <20250822142215.2475014-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix mishandling of the config file by /sbin/request-key whereby the last
line of a file, if it is lacking a newline, will trim off the last
character and then try and use that.  Return an error instead if we find a
line without a newline char at the end.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 request-key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/request-key.c b/request-key.c
index bf47c0a..d1feec3 100644
--- a/request-key.c
+++ b/request-key.c
@@ -367,6 +367,8 @@ static void scan_conf_file(struct parameters *params, int dirfd, const char *con
 		/* ignore blank lines and comments */
 		if (len == 1 || buf[0] == '#' || isspace(buf[0]))
 			continue;
+		if (len == 0 || buf[len - 1] != '\n')
+			line_error("Line missing newline\n");
 
 		buf[--len] = 0;
 		p = buf;


