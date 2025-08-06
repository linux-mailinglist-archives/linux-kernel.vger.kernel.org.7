Return-Path: <linux-kernel+bounces-758376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DCEB1CE34
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD2E56651E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A642264B3;
	Wed,  6 Aug 2025 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnWmksTl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E189220F33
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754514266; cv=none; b=NwP3bcupIF760pWxWxX44+RiNT2Jy6kEA4r8jd9zDT2cUzZOLj0r0cxRmvZPnFwpl42cQmLaaYPyjTHjZzrZYxp2ORg6XaID7lPGgT51zmAKt3sCieZkBCgUivfBg9e5XFGGOOHK7m756//clWnOdWRf+ZP8l9yLDABtUTzFHJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754514266; c=relaxed/simple;
	bh=nTBO2VfZVbhacy9nQazk9AO4gtqz+cLDnC6c+cJcUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=SY3SfDlx98IeIr27xzsLtsS4VhIacN51lEaRhzAoWBEfqc2ITzVJezkexIRpeLyrpdYPXWA2zC3MUxT92xt+tvA0iQfLZSicH9TjQMSRG5FKdbAb+gJv5jHQ0o2+Pp8m6CYUrEC64V6iNjOmn1X4X90dWXFpzrM0QuQGlHDM2V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnWmksTl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754514263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjA/k55gOeFwqG1BJhrtffC2mdTbEoqBb7PoziZp3QA=;
	b=TnWmksTlDZaI6Ya2WniD0KvRLVzwOskUyVBhGOV5Xam1Ghm/R0IuRkbP0JMzbZJwMhP/Z6
	K3GrDbgnunWPdXKnRbUfNWsBVtfeuldGOHUuFQRHA/MhSvTCAnaIx1pnCoDaYt3NAGIN4R
	UYjoA3uZm5YE/U97BGo7t2xru8RINEc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-lO16nl6oMWa1DPvWRuY1SQ-1; Wed,
 06 Aug 2025 17:04:20 -0400
X-MC-Unique: lO16nl6oMWa1DPvWRuY1SQ-1
X-Mimecast-MFC-AGG-ID: lO16nl6oMWa1DPvWRuY1SQ_1754514258
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 76E361955F3C;
	Wed,  6 Aug 2025 21:04:18 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.58.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4DFF3000198;
	Wed,  6 Aug 2025 21:04:15 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] audit: record fanotify event regardless of presence of rules
Date: Wed,  6 Aug 2025 17:04:07 -0400
Message-ID: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When no audit rules are in place, fanotify event results are
unconditionally dropped due to an explicit check for the existence of
any audit rules.  Given this is a report from another security
sub-system, allow it to be recorded regardless of the existence of any
audit rules.

To test, install and run the fapolicyd daemon with default config.  Then
as an unprivileged user, create and run a very simple binary that should
be denied.  Then check for an event with
	ausearch -m FANOTIFY -ts recent

Link: https://issues.redhat.com/browse/RHEL-9065
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
changelog:
v2
- re-add audit_enabled check
---
 include/linux/audit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index a394614ccd0b..e3f06eba9c6e 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -527,7 +527,7 @@ static inline void audit_log_kern_module(const char *name)
 
 static inline void audit_fanotify(u32 response, struct fanotify_response_info_audit_rule *friar)
 {
-	if (!audit_dummy_context())
+	if (audit_enabled)
 		__audit_fanotify(response, friar);
 }
 
-- 
2.43.5


