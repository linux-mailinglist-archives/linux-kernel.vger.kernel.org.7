Return-Path: <linux-kernel+bounces-875176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48463C18649
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FD93B3DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5B2FFF9B;
	Wed, 29 Oct 2025 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MV6t+NOM"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995672FD7B2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718374; cv=none; b=luA191C+GTNteTU/OVFtM65qsAV4vTjn9LQR3n+xK+StvgDB0wLXXDzSG1YWjvpxwONQW7ySPf7tTp2QWSTXY326HXMAQtiyuf15ojweZzajjYC4fG6Fdq+GffqVvZh5xoro/ItYkZFN7sNt9KbDUKZcjV8OQkBFfuatWpN/Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718374; c=relaxed/simple;
	bh=Jz6lTbQJJpANgTNmdxol8b5N1JDR8lBZHzpn1MjixyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGFBWd/9iTmu0a5sl0aAPscdzkUuizu27NkBqGxgK7UEQru1OD/4zC+Tw1Ym8nDzxYeF11xYu3veEoGPZsdAg2XsRGiFQIp9WwwjqP0XodKojgg3SD23ohMhLE7rUkai9gGMcPaN/MUPiUJU1GNpAi7/1nbLovfLJQ36RT72AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MV6t+NOM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290cd62acc3so76391815ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761718371; x=1762323171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i05jzYamgP9lQzq7NVfIhzmsUOor7ugG/3Trve+qFY0=;
        b=MV6t+NOMaBGztvJOv/y1zG3vKZD3uDr1qwpOFTSyKHTvT0MOTuDNBtBEr74+kqgoRU
         oNwfQuK1UHZN0Re+tyccxmyoJyyojwYvc8JKr6VB+Fc67ho15e+6FOFHQ//heykfrtVR
         DBm++RTrVUrJZRMC2oRBLEFpcstcVweH8MF5nmJrZSSlEbV7VrkYzMywQDFNSe0iM1LJ
         XCxyUyHrdJmOX9tB1Hm2B6LKDaGjDunCgZ+4geJCA0sdrrURxOqq8ukMtI2wMA4Q1FXR
         qY2kmLz+NoSXUw2jEr5mqLOJjCwPdMA+489DoTHmUicam49sikk5RUfbnw4gpWywR2Ef
         F05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761718371; x=1762323171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i05jzYamgP9lQzq7NVfIhzmsUOor7ugG/3Trve+qFY0=;
        b=jsHEmCCuA9+JJvArzWEsdyi8/+gdnViK8F21J1qCHJPvIl+fxfxmfFWCeepKHQhnYC
         vaPyLSkIGizAQs9e27HGRWWovfi+u1sMXj05+jlNfRufoBcVmhnpBaSbokdBn4cZewkI
         Ax8f7jDrTjb+3aN30BNBF10QUuGoTrFARLqBrtWEo01iuE4WydOQHJuhKILt9nAj9LNh
         eXY9FSNFzp+P8W6ae26aGZdjDkXkNfgtTtvleWGfhtj5AyThw6lpNYJ6mghMQYRYTa2e
         TbHLgObfaMrVdy4/dvYHIIuZz/83V2E7slbPG7tqBnFcmERDohLLVk9++oPruUOhv8Ah
         mU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+KZMaazXbMjNKJjbLnOfORTHTbiXk+FYaS/fh3sPTud21riFAP7ZaBxsXWxP/YI908J4O2JwgeI1YVlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxREwqM2uPmEuZbfpN5r5qVz+sS/IjNW1QhE9meuuzDyRwyykKg
	EaIbhl+PimNgFWxZPGUHOPlwcAPwVD0Cipg455yL9TCoB6rLKKeIlJPc
X-Gm-Gg: ASbGnctgpeu4JN5pcitpnVMXNfgFo/AUaHfpc9JiLPHXIVkUisoT1V/nnLwXgoo0U0P
	fO7rkKcrHFbr7vfar7nRXPQ1w9I4scgpaYa0ByC1eVlrUW2ii/Q6IQLRMAlfmbdZlokf31t2QXC
	DYqKAQQjqhh0Go+5PC2RhLvBnXOktGeGqxIbmGXlZ6IpKhanHXs71Epsw3p3Myw1iL7dsBMwi25
	Z3bSdpna3huUdcBn4OfWcwBZyitBdhzBu3MSTxuSC9KCdjcTRT7orDaaHikMMTV7wP8J+Tdn80Q
	GybQ5eEIUYxnJP9gsPFBUWF6uPS5+rHS3dQZzuT3LOFyXd2kNFDHFPreOmbEMh3SbWPjB0KzMqI
	otpVcLPvg9ILfBGn0AG62kA6bWc2Vj791/NhgOuayVyDQVCGmZJv8hFE4R8dICjmT6bW8y409dw
	==
X-Google-Smtp-Source: AGHT+IGDjwTRcdAqf05X0XiytKvs6TUJs4CRbFOgYSvhPEVGOev9GHKslYfuxtH72VUKIy90kLSq9g==
X-Received: by 2002:a17:902:da8b:b0:24c:9309:5883 with SMTP id d9443c01a7336-294deed42f4mr24163005ad.28.1761718371361;
        Tue, 28 Oct 2025 23:12:51 -0700 (PDT)
Received: from snowman ([2401:4900:615d:8cf8:2d1:6dfc:1f47:b080])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm140404165ad.8.2025.10.28.23.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 23:12:50 -0700 (PDT)
From: Khushal Chitturi <kc9282016@gmail.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Subject: [PATCH v3] xdrgen: handle _XdrString in union encoder/decoder
Date: Wed, 29 Oct 2025 11:42:36 +0530
Message-ID: <20251029061236.5261-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028145317.15021-1-kc9282016@gmail.com>
References: <20251028145317.15021-1-kc9282016@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running xdrgen on xdrgen/tests/test.x fails when
generating encoder or decoder functions for union
members of type _XdrString. It was because _XdrString
does not have a spec attribute like _XdrBasic,
leading to AttributeError.

This patch updates emit_union_case_spec_definition
and emit_union_case_spec_decoder/encoder to handle
_XdrString by assigning type_name = "char *" and
avoiding referencing to spec.

Testing: Fixed xdrgen tool was run on originally failing
test file (tools/net/sunrpc/xdrgen/tests/test.x) and now
completes without AttributeError. Modified xdrgen tool was
also run against nfs4_1.x (Documentation/sunrpc/xdr/nfs4_1.x).
The output header file matches with nfs4_1.h
(include/linux/sunrpc/xdrgen/nfs4_1.h).
This validates the patch for all XDR input files currently
within the kernel.

Changes since v2:
- Moved the shebang to the first line
- Removed SPDX header to match style of current xdrgen files

Changes since v1:
- Corrected email address in Signed-off-by.
- Wrapped patch description lines to 72 characters.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/union.py   | 34 ++++++++++++++-----
 .../templates/C/union/encoder/string.j2       |  6 ++++
 2 files changed, 31 insertions(+), 9 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 2cca00e279cd..ad1f214ef22a 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -8,7 +8,7 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, _XdrString, get_header_name
 from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
 
 
@@ -40,13 +40,20 @@ def emit_union_case_spec_definition(
     """Emit a definition for an XDR union's case arm"""
     if isinstance(node.arm, _XdrVoid):
         return
-    assert isinstance(node.arm, _XdrBasic)
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+        classifier = ""
+    else:
+        type_name = node.arm.spec.type_name
+        classifier = node.arm.spec.c_classifier
+
+    assert isinstance(node.arm, (_XdrBasic, _XdrString))
     template = get_jinja2_template(environment, "definition", "case_spec")
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
-            classifier=node.arm.spec.c_classifier,
+            type=type_name,
+            classifier=classifier,
         )
     )
 
@@ -84,6 +91,12 @@ def emit_union_case_spec_decoder(
 
     if isinstance(node.arm, _XdrVoid):
         return
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+        classifier = ""
+    else:
+        type_name = node.arm.spec.type_name
+        classifier = node.arm.spec.c_classifier
 
     if big_endian_discriminant:
         template = get_jinja2_template(environment, "decoder", "case_spec_be")
@@ -92,13 +105,13 @@ def emit_union_case_spec_decoder(
     for case in node.values:
         print(template.render(case=case))
 
-    assert isinstance(node.arm, _XdrBasic)
+    assert isinstance(node.arm, (_XdrBasic, _XdrString))
     template = get_jinja2_template(environment, "decoder", node.arm.template)
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
-            classifier=node.arm.spec.c_classifier,
+            type=type_name,
+            classifier=classifier,
         )
     )
 
@@ -169,7 +182,10 @@ def emit_union_case_spec_encoder(
 
     if isinstance(node.arm, _XdrVoid):
         return
-
+    if isinstance(node.arm, _XdrString):
+        type_name = "char *"
+    else:
+        type_name = node.arm.spec.type_name
     if big_endian_discriminant:
         template = get_jinja2_template(environment, "encoder", "case_spec_be")
     else:
@@ -181,7 +197,7 @@ def emit_union_case_spec_encoder(
     print(
         template.render(
             name=node.arm.name,
-            type=node.arm.spec.type_name,
+            type=type_name,
         )
     )
 
diff --git a/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2 b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
new file mode 100644
index 000000000000..2f035a64f1f4
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+{% if annotate %}
+		/* member {{ name }} (variable-length string) */
+{% endif %}
+		if (!xdrgen_encode_string(xdr, ptr->u.{{ name }}, {{ maxsize }}))
+			return false;
-- 
2.51.1


