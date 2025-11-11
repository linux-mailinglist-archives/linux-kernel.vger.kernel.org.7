Return-Path: <linux-kernel+bounces-896165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D761C4FCBB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61D154F6739
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B02435C1B0;
	Tue, 11 Nov 2025 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAhWARpm"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817135C191
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894800; cv=none; b=UBQFyyDZIrla9rJc8DbGe/YqSic3Ht8HyCPs6RJzJoheLRk24425jUSbgx+p8tv4FI622f8B4II7+4yeI16vLO6EoGTIUEqKLIkjzuaiKTcsO7qFFsO/IiMAWpmu5Jwdyczv9GBS5Z3xKNlQngfC5vIjeaBgBYe72BBaCOBcysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894800; c=relaxed/simple;
	bh=OQJgp4DEq2joCsVHjoDiIEgHVPSh6NxyzcNZwuRFfQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kod/Kd3EhCntw/F5Gvs8s+dyUbnnUe3DhcdNMTatuux/JZIsJl0317fisX2H5ZKIuezFK7fZKHLaLSzw3yejqnGupO1h6isgzhGfE5LM254TpX8QpWa3u8XBym5JM82/7CQw0jrFa1mPyuYuFdhT0XsHyjzFDG7FQJ99R+f91P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAhWARpm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b75e366866so74521b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762894797; x=1763499597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ssdPSHyU3gM2ZHlP9TSRwuYAKtI9+Fzog3TySdjfjWw=;
        b=iAhWARpmiF97QN067SslA3ZByqHEptQVU8bTFBF4V7a+lWlETG3IvzKl+jhxekE1mF
         pDVjtSHRq6VBQ61hS/jHNuHmZ1PFoW2HwpVEWBetg56+jVLbeAo+w70oZJykYDpYbhK6
         XK4UAqLrsTUOBAoJfLSompHtqAuqn+1PS1ZPlSDBF0FF2smEvQ2ZpGVqL0ZNTj4Mm5eE
         gkQv+eYbpqDtpiW96jwcRTJeaEF6vzht6IAgVMJ1VbLngPqUzxJ7B4vfpLbpCHhfbbkt
         CL2qgT9t5rthab/DD1n9gDhmtwdRU48jHCPtf+0KZjT/bq3L3Wfp33LBLKHSeaqSK0Tq
         qxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894797; x=1763499597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssdPSHyU3gM2ZHlP9TSRwuYAKtI9+Fzog3TySdjfjWw=;
        b=ml8boNCgyY7ni48wVlQ3g+0xNOL0nC3StjlsbLMz41s7zSXYbY/gAN5nFutP4SS2Dm
         SRWU2ljPwFGNcbLLwwODAU8TDrSOenA+OyV4jZMUAqbWKjXCzWDLqkgb7XZ4aZTCyu+n
         zZLFfizAG540ahD5j8LddmkmSb0p+zeSrQrj1WaBCkHTdWLnTDrBZMwaUSgXz2EIG36L
         BuepFT//0XbmImqJ/31jiVywpqzTebkKGtY51qLZcqsLJPiRgeA2y4LcTh3DV5ZJxL/m
         KWFCPDRl0PCItDB0ZCIQ7mqgKiyaysrjaScYdvnZ51OTARfZBUxmsOSUyc92i49LxRPf
         KD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8zQUp37kVsyTgXWIR8AatfxuH49HzVXdik3TtCq+f4TH4KIzLnR5YvREcCksSg4USHJAqfPk3Nt8DFBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkQ7aVEPwqSoCWuKrqWR6d5DhgIqxnR0HSYpebIZkzaOu+8u5
	3t3qSgMYHtTHf/UQYbr4wnUN7irTx+TlYQB+5sXeKp/KPca9ccolcuF6
X-Gm-Gg: ASbGncu6sETx4qDh0jGC4Se4YB+VZHLFenj2crIHy63U8/7tAE9DkaQgEgn1wxwEcB2
	lpuPdg62JBis485yGxgQLTfyrm5QrbzBUXG3sx7uEewcPXWjDl+bx4GVBjFL4fBI27ncGJBeoFx
	b9HM3aI8La3FvadWse/fu+nZtCEkAKcRFlIzU+t7AY2InshJKqb4p8mFPrjDcHi8n2sLM3NQvlh
	PaAptpAKP2bUXJfCJf/Km5uuF4Ilv3KhjhY5icPByNZ+FxW/S/+8gZhkWPNKo77qb+zaUAuTox4
	ORjKafTlkl8w24Ep5PEr3Q96Vr+GwUbp0NI8rKyJ2z/xKR8SAHjc7WoF71oqG0Q+1OODjCx+gZa
	EW41icQczVLuuopgIog+u6UauZsZFxLlzAroEavCILsy1h+iTLtrbShSvxAgCS4+e8DkRSEYpRr
	z1zAXFVXXIdQ==
X-Google-Smtp-Source: AGHT+IFCW1p6ho9Y11SAcC7SESQcgTHINsTJhTvR5vLV8FdaDa43LTw4C+qNG6PEY11aI2k6EiSRRQ==
X-Received: by 2002:a05:6a00:2e0d:b0:781:1550:1ac7 with SMTP id d2e1a72fcca58-7b7a25aa49fmr429506b3a.6.1762894796759;
        Tue, 11 Nov 2025 12:59:56 -0800 (PST)
Received: from snowman ([2401:4900:615d:9a7b:70c6:577c:2e8f:2a51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a517sm15949308b3a.57.2025.11.11.12.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:56 -0800 (PST)
From: Khushal Chitturi <kc9282016@gmail.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <kc9282016@gmail.com>
Subject: [PATCH] xdrgen: Handle typedef void types
Date: Wed, 12 Nov 2025 02:27:38 +0530
Message-ID: <20251111205738.4574-1-kc9282016@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch Handle typedef void in XDR Generator. Previously, such
declarations triggered a NotImplementedError in typedef.py.

This change adds handling for _XdrVoid AST nodes within the
typedef generator. When an XDR includes a typedef void,
the generator now recognizes _XdrVoid nodes and emits the
respective C typedefs and associated functions. New Jinja2
templates were introduced for encoder, decoder, declaration,
definition, and maxsize generation. The XDR grammar was
updated so that void typedefs can be parsed properly

Tested by running xdrgen on tests/test.x containing a typedef void
declaration. The tool now runs and produces the encoder, decoder,
and typedef outputs across source, definitions, and declarations.

Signed-off-by: Khushal Chitturi <kc9282016@gmail.com>
---
 tools/net/sunrpc/xdrgen/generators/typedef.py        | 12 ++++++++----
 tools/net/sunrpc/xdrgen/grammars/xdr.lark            |  2 +-
 .../xdrgen/templates/C/typedef/declaration/void.j2   |  2 ++
 .../xdrgen/templates/C/typedef/decoder/void.j2       |  6 ++++++
 .../xdrgen/templates/C/typedef/definition/void.j2    |  2 ++
 .../xdrgen/templates/C/typedef/encoder/void.j2       |  6 ++++++
 .../xdrgen/templates/C/typedef/maxsize/void.j2       |  2 ++
 7 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
 create mode 100644 tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2

diff --git a/tools/net/sunrpc/xdrgen/generators/typedef.py b/tools/net/sunrpc/xdrgen/generators/typedef.py
index fab72e9d6915..f49ae26c4830 100644
--- a/tools/net/sunrpc/xdrgen/generators/typedef.py
+++ b/tools/net/sunrpc/xdrgen/generators/typedef.py
@@ -58,7 +58,8 @@ def emit_typedef_declaration(environment: Environment, node: _XdrDeclaration) ->
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "declaration", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -104,7 +105,8 @@ def emit_type_definition(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "definition", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -165,7 +167,8 @@ def emit_typedef_decoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "decoder", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
@@ -225,7 +228,8 @@ def emit_typedef_encoder(environment: Environment, node: _XdrDeclaration) -> Non
     elif isinstance(node, _XdrOptionalData):
         raise NotImplementedError("<optional_data> typedef not yet implemented")
     elif isinstance(node, _XdrVoid):
-        raise NotImplementedError("<void> typedef not yet implemented")
+        template = get_jinja2_template(environment, "encoder", node.template)
+        print(template.render(name=node.name))
     else:
         raise NotImplementedError("typedef: type not recognized")
 
diff --git a/tools/net/sunrpc/xdrgen/grammars/xdr.lark b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
index 7c2c1b8c86d1..d8c5f7130d83 100644
--- a/tools/net/sunrpc/xdrgen/grammars/xdr.lark
+++ b/tools/net/sunrpc/xdrgen/grammars/xdr.lark
@@ -8,7 +8,7 @@ declaration             : "opaque" identifier "[" value "]"            -> fixed_
                         | type_specifier identifier "<" [ value ] ">"  -> variable_length_array
                         | type_specifier "*" identifier                -> optional_data
                         | type_specifier identifier                    -> basic
-                        | "void"                                       -> void
+                        | "void" [identifier] -> void
 
 value                   : decimal_constant
                         | hexadecimal_constant
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
new file mode 100644
index 000000000000..22c5226ee526
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/declaration/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+typedef void {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
new file mode 100644
index 000000000000..ed9e2455b36f
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/decoder/void.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+static inline bool
+xdrgen_decode_{{ name }}(struct xdr_stream *xdr, void *ptr)
+{
+    return true;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
new file mode 100644
index 000000000000..22c5226ee526
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/definition/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+typedef void {{ name }};
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
new file mode 100644
index 000000000000..47d48af81546
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/encoder/void.j2
@@ -0,0 +1,6 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+static inline bool
+xdrgen_encode_{{ name }}(struct xdr_stream *xdr, const void *ptr)
+{
+    return true;
+}
diff --git a/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2 b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
new file mode 100644
index 000000000000..129374200ad0
--- /dev/null
+++ b/tools/net/sunrpc/xdrgen/templates/C/typedef/maxsize/void.j2
@@ -0,0 +1,2 @@
+{# SPDX-License-Identifier: GPL-2.0 #}
+#define {{ macro }} 0
-- 
2.51.2


