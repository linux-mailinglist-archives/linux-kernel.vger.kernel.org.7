Return-Path: <linux-kernel+bounces-782152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A1FB31BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AEB1C85F01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3D3126D6;
	Fri, 22 Aug 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnSQVsH9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786123101DA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872553; cv=none; b=nhEPWMnEjNIGJIek1DKccQYaVjQZTgeDRogqdfWQ5GkdwIgd0XNgjisFcn87R2eIPJJbr0uuVIIXlMabQ7SodJP5pDXTDMfDcDnS8+iy1+0KVjBmo11DGYB5eOKArXRQVpm+zepSggPurcBEnUZ7JMeVuA8E+NnCl/JPfDjk7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872553; c=relaxed/simple;
	bh=zCypTlaDHffLCDlbMYrzU8JmLZfE78I8zAGjTuZeDwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N79o5K+EDkVdkGtulZsgHetSv4h9qbGOXwx3Bhk29yIKSlm9GhaKa9XZZy/JQUfMKeTkJ7wHw//rVm3xf8mqaBmosF5I9qvjWRVdjSNtBSxQsD3wKLhKqr7XjXuthRDxpwD3Cl8BTM+VbCBm0SW7w8FNV1TTivEB4+rCVgkDjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BnSQVsH9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755872550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egP0+NYa72c2/aBcMaaZPvBLQrtUqtpQbxPIy/YKSxY=;
	b=BnSQVsH9qJHWZ40CakEvYYPQwE7LoT5OsHIdharf0cJLN6g6dwVkOKzV0XkS5lR+5Maz3b
	zLX22Fi0JPcsivtQqizB6iztGkhGstQ8w0eQxpH5rDi12Zc2pkX01eIPd1yc2TKfGd2uDX
	ygF9CHHlonh9LMmbT4R1J/D04dF7Q/k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-uoZDrJKnOwSqlAEAPK7JZA-1; Fri,
 22 Aug 2025 10:22:29 -0400
X-MC-Unique: uoZDrJKnOwSqlAEAPK7JZA-1
X-Mimecast-MFC-AGG-ID: uoZDrJKnOwSqlAEAPK7JZA_1755872548
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47447180045C;
	Fri, 22 Aug 2025 14:22:28 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.132])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11B9430001A1;
	Fri, 22 Aug 2025 14:22:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] test: Hide endianness
Date: Fri, 22 Aug 2025 15:22:10 +0100
Message-ID: <20250822142215.2475014-4-dhowells@redhat.com>
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

Hide the endianness of the raw binary contents of a keyring by passing it
through /usr/bin/od which will automatically byteswap it in 4-byte chunks
rather than trying to detect the endianness by examining what may be a
binary file to obtain a string the format of which changes over time.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/keyrings/2813085.1745332819@warthog.procyon.org.uk/
---
 tests/keyctl/reading/valid/runtest.sh |  9 ++-----
 tests/toolbox.inc.sh                  | 36 +++++++++++++++++----------
 2 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/tests/keyctl/reading/valid/runtest.sh b/tests/keyctl/reading/valid/runtest.sh
index 2fb88b9..2527f13 100644
--- a/tests/keyctl/reading/valid/runtest.sh
+++ b/tests/keyctl/reading/valid/runtest.sh
@@ -40,13 +40,8 @@ expect_payload payload "67697a7a 617264"
 
 # read the contents of the keyring as hex and match it to the key ID
 marker "READ KEYRING"
-read_key $keyringid
-tmp=`printf %08x $keyid`
-if [ "$endian" = "LE" ]
-then
-    tmp=`echo $tmp | sed 's/\(..\)\(..\)\(..\)\(..\)/\4\3\2\1/'`
-fi
-expect_payload payload $tmp
+pipe_key_int32 $keyringid
+expect_payload payload $keyid
 
 # remove read permission from the key and try reading it again
 # - we should still have read permission because it's searchable in our
diff --git a/tests/toolbox.inc.sh b/tests/toolbox.inc.sh
index 609a6c7..6f4fb18 100644
--- a/tests/toolbox.inc.sh
+++ b/tests/toolbox.inc.sh
@@ -12,19 +12,6 @@
 
 echo === $OUTPUTFILE ===
 
-endian=`file -L /proc/$$/exe`
-if expr "$endian" : '.* MSB \+\(pie executable\|executable\|shared object\).*' >&/dev/null
-then
-    endian=BE
-elif expr "$endian" : '.* LSB \+\(pie executable\|executable\|shared object\).*' >&/dev/null
-then
-    endian=LE
-else
-    echo -e "+++ \e[31;1mCan't Determine Endianness\e[0m"
-    echo "+++ Can't Determine Endianness" >>$OUTPUTFILE
-    exit 2
-fi
-
 maxtypelen=31
 maxtype=`for ((i=0; i<$((maxtypelen)); i++)); do echo -n a; done`
 
@@ -1055,6 +1042,29 @@ function pipe_key ()
     fi
 }
 
+###############################################################################
+#
+# pipe a key's raw payload to od to stdout, displaying it as a sequence of
+# 32-bit numbers, appropriately byteswapped.
+#
+###############################################################################
+function pipe_key_int32 ()
+{
+    my_exitval=0
+    if [ "x$1" = "x--fail" ]
+    then
+	my_exitval=1
+	shift
+    fi
+
+    echo keyctl pipe $1 \| od -t u4 -A none >>$OUTPUTFILE
+    echo `keyctl pipe $1 | od -t u4 -A none` >>$OUTPUTFILE 2>&1
+    if [ $? != $my_exitval ]
+    then
+	failed
+    fi
+}
+
 ###############################################################################
 #
 # pipe a key's raw payload through md5sum


