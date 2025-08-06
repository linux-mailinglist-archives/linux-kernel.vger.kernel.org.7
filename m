Return-Path: <linux-kernel+bounces-758320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EBB1CD8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063867AA141
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA545221FC7;
	Wed,  6 Aug 2025 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7WhLWBr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3812B2BD5B9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512663; cv=none; b=RFtxGzEFCq7o87OQiDc9gNbfqXDOSYDyLtArOOYB3laEsNaTUeBAG6jyb0wKYlOqZ33fgncOTusc9rdUvrQM28Zvx2dBWHIgL699cgHPYWVjjyAz3HI2vB01MdPEuvl62BGrqmvVJm0P+I7bJ3JLBUgY2NNKNZazC2cIhYindjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512663; c=relaxed/simple;
	bh=Cz7mmpHuGqCeQqdDmoKo+SSe5T0TEhmQR5v3P1DDHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1DkI3Ka2xXfT7dCzr2063l2Nv0T0DU2d0V9kUE4h74y/WFA1AXUGD5ZnOiD8ZewMkRizdnylri9uQ1NmAjl3qM0M/epkCSlI/Yr90QmbbyZM+vPTSw6PDv68GY+uilS3TYnYAW2MSpnrsbiQTH1tiNADMOj4RvBJ7WWrYS7L2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7WhLWBr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pgw2HEBWL/o6lds7Ytffz5iXDstSedUrccIm0ypOU1Q=;
	b=P7WhLWBrEkZ8amiwptCKGkf4Cn06TtL6KTCgUREXfQpW2nQOFmJ4VZkIfNrKt/BynUyiGY
	gM2Z6W4RtTgC/UenmoR7Eem1QKnxoc7lg71scyqG4AQwGJBM8h2K1WBEi4SUnYx/NFDwSJ
	bBgD7y0FElvyFONI6YTSPEyyizmoN1w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-39d-sI9KMkumubDWD5AxSg-1; Wed,
 06 Aug 2025 16:37:35 -0400
X-MC-Unique: 39d-sI9KMkumubDWD5AxSg-1
X-Mimecast-MFC-AGG-ID: 39d-sI9KMkumubDWD5AxSg_1754512654
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A1A218002B4;
	Wed,  6 Aug 2025 20:37:34 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAE81180047F;
	Wed,  6 Aug 2025 20:37:30 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 04/31] cifs, nls: Provide unicode size determination func
Date: Wed,  6 Aug 2025 21:36:25 +0100
Message-ID: <20250806203705.2560493-5-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/nls/nls_base.c            | 33 ++++++++++++++++++++++++++++++
 fs/smb/client/cifs_unicode.c | 39 ++++++++++++++++++++++++++++++++++++
 fs/smb/client/cifs_unicode.h |  2 ++
 include/linux/nls.h          |  1 +
 4 files changed, 75 insertions(+)

diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
index 18d597e49a19..f6927c7d9fe1 100644
--- a/fs/nls/nls_base.c
+++ b/fs/nls/nls_base.c
@@ -171,6 +171,39 @@ int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
 }
 EXPORT_SYMBOL(utf8s_to_utf16s);
 
+/**
+ * utf8s_to_len_utf16s - Determine the length of a conversion of UTF8 to UTF16.
+ * @s: The source utf8 string
+ * @inlen: The length of the string
+ */
+ssize_t utf8s_to_len_utf16s(const u8 *s, int inlen)
+{
+	unicode_t u;
+	size_t outcount = 0;
+	int size;
+
+	while (inlen > 0 && *s) {
+		if (*s & 0x80) {
+			size = utf8_to_utf32(s, inlen, &u);
+			if (size < 0)
+				return -EINVAL;
+			s += size;
+			inlen -= size;
+
+			if (u >= PLANE_SIZE)
+				outcount += 2;
+			else
+				outcount++;
+		} else {
+			s++;
+			outcount++;
+			inlen--;
+		}
+	}
+	return outcount * sizeof(wchar_t);
+}
+EXPORT_SYMBOL(utf8s_to_len_utf16s);
+
 static inline unsigned long get_utf16(unsigned c, enum utf16_endian endian)
 {
 	switch (endian) {
diff --git a/fs/smb/client/cifs_unicode.c b/fs/smb/client/cifs_unicode.c
index 4cc6e0896fad..ba4b361613f6 100644
--- a/fs/smb/client/cifs_unicode.c
+++ b/fs/smb/client/cifs_unicode.c
@@ -290,6 +290,45 @@ cifs_strtoUTF16(__le16 *to, const char *from, int len,
 	return i;
 }
 
+/*
+ * Work out how long a string will be once converted to UTF16 in bytes.  This
+ * does not include a NUL terminator.
+ */
+size_t cifs_size_strtoUTF16(const char *from, int len,
+			    const struct nls_table *codepage)
+{
+	wchar_t wchar_to; /* needed to quiet sparse */
+	ssize_t out_len = 0;
+	int charlen;
+
+	/* special case for utf8 to handle no plane0 chars */
+	if (strcmp(codepage->charset, "utf8") == 0) {
+		out_len = utf8s_to_len_utf16s(from, len);
+		if (out_len >= 0)
+			goto success;
+		/*
+		 * On failure, fall back to UCS encoding as this function
+		 * should not return negative values currently can fail only if
+		 * source contains invalid encoded characters
+		 */
+	}
+
+	for (; len && *from; len -= charlen) {
+		charlen = codepage->char2uni(from, len, &wchar_to);
+		if (charlen < 1) {
+			cifs_dbg(VFS, "strtoUTF16: char2uni of 0x%x returned %d\n",
+				 *from, charlen);
+			/* Replace with a question mark */
+			charlen = 1;
+		}
+		from += charlen;
+		out_len += 2;
+	}
+
+success:
+	return out_len;
+}
+
 /*
  * cifs_utf16_bytes - how long will a string be after conversion?
  * @utf16 - pointer to input string
diff --git a/fs/smb/client/cifs_unicode.h b/fs/smb/client/cifs_unicode.h
index e137a0dfbbe9..c3519a46a2b5 100644
--- a/fs/smb/client/cifs_unicode.h
+++ b/fs/smb/client/cifs_unicode.h
@@ -60,6 +60,8 @@ int cifs_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
 int cifs_utf16_bytes(const __le16 *from, int maxbytes,
 		     const struct nls_table *codepage);
 int cifs_strtoUTF16(__le16 *, const char *, int, const struct nls_table *);
+size_t cifs_size_strtoUTF16(const char *from, int len,
+			    const struct nls_table *codepage);
 char *cifs_strndup_from_utf16(const char *src, const int maxlen,
 			      const bool is_unicode,
 			      const struct nls_table *codepage);
diff --git a/include/linux/nls.h b/include/linux/nls.h
index e0bf8367b274..026da1d5ffaa 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -56,6 +56,7 @@ extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
 extern int utf32_to_utf8(unicode_t u, u8 *s, int maxlen);
 extern int utf8s_to_utf16s(const u8 *s, int len,
 		enum utf16_endian endian, wchar_t *pwcs, int maxlen);
+ssize_t utf8s_to_len_utf16s(const u8 *s, int inlen);
 extern int utf16s_to_utf8s(const wchar_t *pwcs, int len,
 		enum utf16_endian endian, u8 *s, int maxlen);
 


