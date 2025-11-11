Return-Path: <linux-kernel+bounces-895516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E405C4E243
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471F9188F6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98F333ADA4;
	Tue, 11 Nov 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/eyGGKq"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029C31BC82
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868207; cv=none; b=Q81edDe5mBTf2eFmC5b/pgnr+vrs8vpCZIgJTSMKDtk6/K4+uHiqG7kP27MWdR0rfwY8JnnUtK0NUiwQsX5tEWRbL8kPCM6fY1RHTOJZ/Z21cMe2XrnzUvYxVal7D08vWeqBSVmPZsTI4/1Y6zC8dc4Eb0zM0D4BFqr6YinBSu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868207; c=relaxed/simple;
	bh=C4jDMoBv98CSnFsm9ZYy/OozYXX7fEl+I/JjNn3CwEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AK5uOsNxH5E0qdDZl8TZqNTl21/OWVTrYWduhlxm+gTcbt1DgPcRoegoHTWop0N5Z8I0H90H0LXfn79O2iWtPl/DcpvkADy/1HjeAz9MbhxUUsGIqxgJZ583Lnsmy+x3wj9eAreoLNYSHpZTMG9loYpxTNu4pTr5XCuNi4U2a38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/eyGGKq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2508352a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868205; x=1763473005; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsHsngf+EnNDyi9/PjOxDn0IIEfbCT4oM4rKfdkxmWQ=;
        b=b/eyGGKqcArFnC9KG3KCZ61yAhQNZIFh4UMJ8xtCC7MA5sYbBFJ0YN1Xzorl/OzgKU
         8ewoAcWwTJS9u+o/5eAV4Og/z5m33rOF/RV0F7+uwE1cL/E+GorPP9QTDDHMmufLxuFV
         nYD+zU5dKHH4hKe/bnGdL2ow/b5ZuuN2qYbs8YMCCZBrmcyzT7RKkRBSI4cyWRDyEERz
         iVz77q+FLjAmVBYcnDAV+TUxlyRPFo/qw4ipWjJsQzHbx3x9Y2zAFSc2rhs66qUwR8kL
         kVROH/IhVzJAfJuaRQNHYuanbPFahwY0k0WVZgqYPkoybMi2OdhbzJJoaC/nuxSHe482
         B89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868205; x=1763473005;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZsHsngf+EnNDyi9/PjOxDn0IIEfbCT4oM4rKfdkxmWQ=;
        b=tOu11FZOqBSKXRR0dGzOfmNXpaXN9yJa8d0iszLfPHOj8OBu/28Px7K4CGW9TNhETq
         CusV00aKIvjpApLCN6lxIpdnhblMdAeKaVZfRGJP+ykpxPodZ6MNo2m3/NgA9s3gDZ5I
         tqtvdGjq3xn/KhObQptB2Q3WGQl2cnguIG2rdwUgmIaczhMHtUJ7HhMpIOGNf7TUwYdV
         79RpZ+5ZVu7+34LaDsDqdjk6DRmS9eIAZAnVqgbI93VzY+z1dn3/SGBhL6MWinpRHZFD
         r+5lJv10P3IldJQBKjjU05bD2j7yIdpfMff1yT7ae17rHBt3/i3DWRrbGpzqJNXnItuh
         FIxw==
X-Forwarded-Encrypted: i=1; AJvYcCUjOhF7T8qf6tB3DbIdUGeXZ5h6YXLfC46DUhN/RC76RAZ9bc9zRcYVQ5f2J2MvYlrNzZaR8vYRYkiazLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlXpwfw1AmTLGhYVSt6STTZNXfTpiDyrRtHFssRmtWc6lkJACg
	k2kPTCot+mhOsQuH/lnPhRfa5FWQaAwOg7hEjjQBhI6WOw1qX9ExuAs3
X-Gm-Gg: ASbGncsEfJXMSK1sBQrvcpKMgvAwZ2DveEZ2XEF38NxR8hCZr/ZRVk0VugkO/jNm1ns
	pw109JdjybKCnSyhhTwkQL6jq7xBN9g8EDZaZ+QqmQZqyZPDVYNJsGFUkEBXpfNHdWbuXDU+/YL
	EiVICbwpp4MHJ7kNLP4gHmBrf6Q5CLpGF6PHa+3ODcersEmSDDEoqrSYYoeWxmKsiy2OFA1RxkA
	MciZNKZ+FZzNDtEm6B2Cq+mF0bXOwXNpvQZh7aKcaUXDK/ay3sysL9mddI2PY7bXTASOhLxZjFT
	7rUBKFcmnm0yKftdAChNK3IQr94YvpokhPvRK6/zt2Q4QRM0+9goV+wSKkBgtWZqy6bPaO9D55X
	6SN/De8hFef5rZjqz+lF6Hr4IHYmayzr1xGNmtB1KR5kqdkP1289i0lViAd33UGwzcgcE3VFOYp
	Qm8dqFzJi1HA==
X-Google-Smtp-Source: AGHT+IGiHOIAjf30lk+UFmNrFQaWvBdKfD8cfNSSkXgEJsYVgGWHQ+DWs0KkzZMegs6oZI7jmZ85kQ==
X-Received: by 2002:a17:902:fc8f:b0:295:7804:13b7 with SMTP id d9443c01a7336-297e53f8126mr144158995ad.10.1762868204702;
        Tue, 11 Nov 2025 05:36:44 -0800 (PST)
Received: from aheev.home ([2401:4900:8fcc:9f81:b4f9:45ad:465b:1f4a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17ad4asm15405645b3a.37.2025.11.11.05.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 05:36:44 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 11 Nov 2025 19:06:29 +0530
Subject: [PATCH v2] crypto: asymmetric_keys: fix uninitialized pointers
 with free attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-aheev-uninitialized-free-attr-crypto-v2-1-33699a37a3ed@gmail.com>
X-B4-Tracking: v=1; b=H4sIANw7E2kC/5XNQQ6CMBCF4auQrh3DFEjQlfcwLEo7wCTQkrY2I
 uHuVm7g8n+L9+0ikGcK4l7swlPiwM7mkJdC6EnZkYBNbiFL2SCWDaiJKMHLsuXIauYPGRg8Eag
 YPWi/rdFBr281aeylbCqRr1ZPA79P5tnlnjhE57dTTfhb/wQSAkJbGYWEJbW6foyL4vmq3SK64
 zi+7FeCA9gAAAA=
X-Change-ID: 20251105-aheev-uninitialized-free-attr-crypto-bc94ec1b2253
To: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
 Ignat Korchagin <ignat@cloudflare.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=C4jDMoBv98CSnFsm9ZYy/OozYXX7fEl+I/JjNn3CwEM=;
 b=kA0DAAoWlj2i1D/XexwByyZiAGkTO+Kh2b6RqD7EGmO/BCI/q1zMuOv1Th2Kz5mOb/1thRizI
 Ih1BAAWCgAdFiEEARUaTi6yGpBew2L2lj2i1D/XexwFAmkTO+IACgkQlj2i1D/Xexyo6AEA3d1+
 BqJbTn/YkvKO/IkOQ28XtN83T+r08K3xzqHaQEsA/1lPQwd07Lp4NP1oGLvR7m2Otvo6xT3FMTY
 JxZW1PMkB
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behavior as the memory assigned randomly to the pointer is freed
automatically when the pointer goes out of scope.

crypto/asymmetric_keys doesn't have any bugs related to this as of now,
but, it is better to initialize and assign pointers with `__free`
attribute in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Changes in v2:
- moved declarations to the top and initialized them with NULL
- Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-free-attr-crypto-v1-1-83da1e10e8c4@gmail.com
---
 crypto/asymmetric_keys/x509_cert_parser.c | 2 +-
 crypto/asymmetric_keys/x509_public_key.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 8df3fa60a44f80fbd71af17faeca2e92b6cc03ce..b37cae914987b69c996d6559058c00f13c92b5b9 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(x509_free_certificate);
  */
 struct x509_certificate *x509_cert_parse(const void *data, size_t datalen)
 {
-	struct x509_certificate *cert __free(x509_free_certificate);
+	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
 	struct x509_parse_context *ctx __free(kfree) = NULL;
 	struct asymmetric_key_id *kid;
 	long ret;
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 8409d7d36cb4f3582e15f9ee4d25f302b3b29358..12e3341e806b8db93803325a96a3821fd5d0a9f0 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -148,7 +148,7 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
  */
 static int x509_key_preparse(struct key_preparsed_payload *prep)
 {
-	struct x509_certificate *cert __free(x509_free_certificate);
+	struct x509_certificate *cert __free(x509_free_certificate) = NULL;
 	struct asymmetric_key_ids *kids __free(kfree) = NULL;
 	char *p, *desc __free(kfree) = NULL;
 	const char *q;

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251105-aheev-uninitialized-free-attr-crypto-bc94ec1b2253

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


