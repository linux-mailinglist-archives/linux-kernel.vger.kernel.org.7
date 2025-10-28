Return-Path: <linux-kernel+bounces-873998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF62C15432
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20A2188F8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A7264A86;
	Tue, 28 Oct 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it10JmqX"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B2253B5C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663216; cv=none; b=av1fnKH7hUG5GTW3wxj80PSmmg3GvrYboKlTGfmREcfk2sS6HJd8Kmd/CYMTXF2MftkkL2i8+nEN7ZfgRJo0D40SHu90BXrbrq03JnlRHppoc4K8a8KTjtGl9azU86kwAEgolzDCz3T46Mgz0UKC8g0i2okm5xfn49iKVLBDicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663216; c=relaxed/simple;
	bh=eBV5tomgADNHlVSvWwPHW4U38dRIY2x7fDBeiWqcT0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTZEfJKRfVYpFIhilhc0rxHvtWP+AVo1kc7u5E2cJSn3tDrd4w8Oxbv5XHv4nARYME5UbyEFNLO6DVfayZ+n1ZQ608RUcpquUGwiaims2Mo1hO/qyZr/URSlFVaTahUE1VpUmJ75lIXi2fTXxhZjl/uhUDiKj2cUU2Om/FqI6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it10JmqX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so6189606a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663214; x=1762268014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIalhegjjb9A0mID8JmFLQUJM2t6ufSIdsLy0MIR4mQ=;
        b=it10JmqXmnmjfv2NfAd8tgLIGdh6CNPoEHlLxGIVAtbafHKVqyzperEHxcVPhVjECW
         CikbGOyUlUUFvEi8ehmGSRyh3cjZgCHlQ5R+/+RuR4uUbt2l3k18vgscRRh7WQbDIkWH
         S7Va6mq8MQuqP7cWDDLakG4Ox7BkKn+7q7JMzazvIZ6MbH0nwP8+Q8/DeAhgnbhKLxIb
         B89Pi0tvxBjvABS0BNuE37g7D1NlI6Li5hFnR2kJoQiGyn2a/7pC27HZXu9enhjLskot
         WZkkp6Ts1/pRUBgHruo+3dEAwgDXB9+71TLTiTfoANVLjsm+qqHXapxO2teAH7JUSK0s
         XoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663214; x=1762268014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIalhegjjb9A0mID8JmFLQUJM2t6ufSIdsLy0MIR4mQ=;
        b=ABNCRSFKVcojMMi40IfyxPHvV9ULO61MXyXSx1POLIMNvH+RRVixdYEweSep4RdAjv
         Lb+tx99Bf33FEcDEzWLHgiND2f6an6nToETmCdWnmeYPMxyo8D8avb1dIgJesoe9gCBS
         /OTaIKTxuSKn6WjH7/3isEQ+saTHTdjv0ZD2Jgi524nL9OyhO0krJas6uq+9Of9fu7j5
         KB3fkF0XwjdlLRSFOvx3C3jTs8KvUFk916TL+k581tl9VoBa8jdjiWD2n0x+orqzXq7u
         nDeGX2/SO+6cjl0XzXoCayRHA7Btj1mZykj946FH9e5Uqk9TIPk/6GtB3j4y1xApuCvr
         exBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2z4KBCIdtfL/mrtYvlVqO8un74hQmiro/rvuYVwMK6wZRa37TtYnwO55yZRDH8bSI4SMrYdULTqsiis=@vger.kernel.org
X-Gm-Message-State: AOJu0YypARE+/9OsQc4s6mbei03YKh+NLbTFV0zU69whKMm9uwd7ngzX
	XwqSVqig4XOTY3+s5o8Lha79wkVTZc6j21a+N/Xn66gZI/rOO3n6oCTN
X-Gm-Gg: ASbGncuQraAlJ+XXr5tWpH/WD5MZntEhm4Qrb+/UMq5oaRsIap22QG5Fqhi+8Wze6mM
	NhipFzKh3BpDBqrTSxdjwWrSJ8p1XKLRZFRlVuTkEHjyb6PZ+Y/vqaGEmhTVv3T1xdbIevjrX62
	iY8jUYegExVRw1QT48Qooq4wM9SRBOHRTaO6xeAazIeszjCJC4cVMvV3slsddT3WAisk3brFAmc
	mdLuoK6Chkq97xlYAbrVOOCIb2yvLLTVlLUYJKw+HJchHtlwzSwRY2N6zVBfqv7xax1QhsdhJTn
	sB2tP/mX3Or3Jq6qppdCmf5bw+iram51LsXbjzIsyZArYCU+dLKom8PhDMHQsmY4aEdmAcEWMGH
	TY1urZq2ZQhSSgen8Onr+0JXC0LwBHjzeE7qjY/bqoxoUNN2UtwyjlVt0RocgD+h9UK3QpHovVE
	w=
X-Google-Smtp-Source: AGHT+IG5Jh5Qx7F5nYFMpvwvX4h43bkvhS5OSWOasULrME1OQBV2BPufImkgArWA+uvLmx1JjQh1Ww==
X-Received: by 2002:a17:90b:5243:b0:33b:b673:1b07 with SMTP id 98e67ed59e1d1-3402875c4b1mr3926768a91.9.1761663213732;
        Tue, 28 Oct 2025 07:53:33 -0700 (PDT)
Received: from snowman ([2401:4900:615d:9a55:694d:60a0:5539:22d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402a52c997sm1495828a91.4.2025.10.28.07.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:53:33 -0700 (PDT)
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
Subject: [PATCH v2] xdrgen: handle _XdrString in union encoder/decoder
Date: Tue, 28 Oct 2025 20:23:17 +0530
Message-ID: <20251028145317.15021-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026180018.9248-1-kc9282016@gmail.com>
References: <20251026180018.9248-1-kc9282016@gmail.com>
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

Changes since v1:
- Corrected email address in Signed-off-by.
- Wrapped patch description lines to 72 characters.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/union.py   | 35 ++++++++++++++-----
 .../templates/C/union/encoder/string.j2       |  6 ++++
 2 files changed, 32 insertions(+), 9 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/union/encoder/string.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/union.py b/tools/net/sunrpc/xdrgen/generators/union.py
index 2cca00e279cd..3118dfdddcc4 100644
--- a/tools/net/sunrpc/xdrgen/generators/union.py
+++ b/tools/net/sunrpc/xdrgen/generators/union.py
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #!/usr/bin/env python3
 # ex: set filetype=python:
 
@@ -8,7 +9,7 @@ from jinja2 import Environment
 from generators import SourceGenerator
 from generators import create_jinja2_environment, get_jinja2_template
 
-from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, get_header_name
+from xdr_ast import _XdrBasic, _XdrUnion, _XdrVoid, _XdrString, get_header_name
 from xdr_ast import _XdrDeclaration, _XdrCaseSpec, public_apis, big_endian
 
 
@@ -40,13 +41,20 @@ def emit_union_case_spec_definition(
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
 
@@ -84,6 +92,12 @@ def emit_union_case_spec_decoder(
 
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
@@ -92,13 +106,13 @@ def emit_union_case_spec_decoder(
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
 
@@ -169,7 +183,10 @@ def emit_union_case_spec_encoder(
 
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
@@ -181,7 +198,7 @@ def emit_union_case_spec_encoder(
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


