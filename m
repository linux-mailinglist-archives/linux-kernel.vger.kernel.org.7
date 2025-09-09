Return-Path: <linux-kernel+bounces-807360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0FFB4A368
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9820176622
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F92306B39;
	Tue,  9 Sep 2025 07:22:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA0234984
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402570; cv=none; b=Pm7Abqmoi6v7Mymyz+L0/2fKvfX9fqEl5N7C90qIT7l4N6wxq8n8+N3M8eajtGhQx0ty9lXhAquevZE+VsEbP0OUKtQ2Lqh30m2UbKeJOygNZ/Kk/bk2qWOz09LDl1vbIabitkGjKsiclXpV4nDAZ2hvoSExhdwJCOdvMK/lvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402570; c=relaxed/simple;
	bh=ok2n6cqsL+vIJgQ81dXujsfUhKolao67KZL5GoqXcjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHyIah6FHaNvFqPncn8xP4iFoh6d0T0q4oWuZuDGG2zKzj8TnJaw3WQwx8WbKe1tfVrLcqjQCps5yYWBIWi6jkPVztNy5JDbbk4Q7sashFDPD/bse+rf0Uw0L6BeGZ/hH8d/lS5OTGKqGfJVu+yz3g3bfIQzwCYCtrt6EQB7RC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgF-0004gp-KO; Tue, 09 Sep 2025 09:22:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-000NlQ-3C;
	Tue, 09 Sep 2025 09:22:14 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-0000000FZFY-3h6Z;
	Tue, 09 Sep 2025 09:22:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 1/3] tools: ynl-gen: generate kdoc for attribute enums
Date: Tue,  9 Sep 2025 09:22:10 +0200
Message-ID: <20250909072212.3710365-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250909072212.3710365-1-o.rempel@pengutronix.de>
References: <20250909072212.3710365-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Parse 'doc' strings from the YAML spec to generate kernel-doc comments
for the corresponding enums in the C UAPI header, making the headers
self-documenting.

The generated comment format depends on the documentation available:
 - a full kdoc block ('/**') with @member tags is used if attributes are
   documented
 - a simple block comment ('/*') is used if only the set itself has a doc
   string

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index fb7e03805a11..f0a6659797b3 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3225,6 +3225,29 @@ def render_uapi(family, cw):
         if attr_set.subset_of:
             continue
 
+        # Write kdoc for attribute-set enums
+        has_main_doc = 'doc' in attr_set.yaml and attr_set.yaml['doc']
+        has_attr_doc = any('doc' in attr for _, attr in attr_set.items())
+
+        if has_main_doc or has_attr_doc:
+            if has_attr_doc:
+                cw.p('/**')
+                # Construct the main description line for the enum
+                doc_line = f"enum {c_lower(family.ident_name + '_' + attr_set.name)}"
+                if has_main_doc:
+                    doc_line += f" - {attr_set.yaml['doc']}"
+                cw.write_doc_line(doc_line)
+
+                # Write documentation for each attribute (enum member)
+                for _, attr in attr_set.items():
+                    if 'doc' in attr and attr['doc']:
+                        doc = f"@{attr.enum_name}: {attr['doc']}"
+                        cw.write_doc_line(doc)
+            else:  # Only has main doc, use a simpler comment block
+                cw.p('/*')
+                cw.write_doc_line(attr_set.yaml['doc'], indent=False)
+            cw.p(' */')
+
         max_value = f"({attr_set.cnt_name} - 1)"
 
         val = 0
-- 
2.47.3


