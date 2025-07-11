Return-Path: <linux-kernel+bounces-727723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C33B01EA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD2EB44A37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D592E1C58;
	Fri, 11 Jul 2025 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW5GvxUh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBA2DE70C;
	Fri, 11 Jul 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242752; cv=none; b=SmJJdQe9ZkFZVH+fjLQa2AYzW5fdpk70ei5htc5YKvjRaRcXIPO8HLUooF8PT4d8WQdWsw5opt3mRfHN0wWE40uM8treXZexklRAMInQE631tQLXDjvN3GA4rA74Eh8j/Lrbso+qDZckVy8vxSOoGHLgLzOMsGex/IF5oVbBTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242752; c=relaxed/simple;
	bh=5TpBooB+W+BeZbiDzq1Z8dO6nOJic8u7bkQBOn930wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpR32aXUfPVNQEI8j44Hv2HNfSISgWe9sOR7W8NmrMrjuNAo8LqsgCFvJqCAY5uVTtc4RAzZa4epBJHveEC8TF8zoFrcgvQFuji8oGfsLsZqhvsa9OmbCySpM2KZNhSZ661HPFqU416zm6b3uPobgAFRAXUFm+uhlEqbq4YpAdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZW5GvxUh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so431344766b.2;
        Fri, 11 Jul 2025 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752242749; x=1752847549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTH4I4G8D0dNn8spSxVZfb/FaHuz4VLbXp0Sw7lFQKc=;
        b=ZW5GvxUhPzN3r/NWlhVl2DmZvVzGgBesrcShtlkJqMZ9LJuak3wTrbA34hQt3oI4vl
         6i+Cx9+M4CyibnKxdnr/VL9thWCXkUP9er38SwQLRx8yg+cqOFoOrSezmVMwM4yGi91E
         yjE8KEKUeLtcllcwednFj4XuNB6p5m7Id+nDj4S4EJ5oRFAumt5k/XWr08PVii+KeBSO
         JkcI6p+ospPjpvS7YwOlb2qBGsJa2NbHd/tgm/rSCUbLMkmWP2BM/C8AzTjnqXxHAHkC
         Dx9wwIt/dj7a/jNP0naUj4FaqJq0ejqCEe8quGQYF23Kqcy9tENKl9F7DvMapVcQguqh
         Kbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242749; x=1752847549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTH4I4G8D0dNn8spSxVZfb/FaHuz4VLbXp0Sw7lFQKc=;
        b=AHb7iQFFri0eTQa+feJOe4uWdxBUOub/AanjQfS2YuxSErJbYNbapGjo/KwoLCdElY
         ar1gJR9+4wyMijYmK5HktOwfkEXnhNB0p0ynFtQL6KwVVl8Pz44xtMlpOyubCY17WLPv
         sQwtFdZmJhFw7Mxmg/fQujYCh830GfYY61FvLStLPNbAYdeYN24lv/o2zbCE7l7RrNzp
         4eCo4uWSuOONLxseXXDzF7Ik5Sdlf1zzEXrwwowjO255iWNHvLLx/spHvbnTWc8JUcdi
         ITR8nl1aMmWIUModDHqqcDKv9HPwCiqHU7MFFb5TMSJgRidlaCPZ6O7ftZ+gkIf7yW4P
         Kv8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVY6nIGHvu1zdm/C8ki+FUbKs5Cj0tYSGvr/Fn9K7C1hoIaKlzD3Q5nxJTg+CAwkvbpkbX0UmcOs15qLus=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJQJGBgbgLiwLwqjyVBg1Io89ic3YcuMZp3B1nyGhd4iwBgMW
	kW1+2N36IGWk8O7Hqk/WWyk/B2MMdo/8PagBMUVbtcB1w0usivQe6ch1If2GP+jO
X-Gm-Gg: ASbGncvWfMIQeoSGORp304DBTwLU0L3DKuOVzaEgXgHSc3RBIeFfevHdXiAuxCrecOf
	BFr6fQNwb4LfLJ3h8IJxollTYZjmuZwHoP8NcI6N494fOikzCAmtfwjlZx428qkm3Hri/ENQxg3
	uGlhwCzzCDhcJCLvKY05TiU53Tg5rVjZpK8uRwvZvHFRi9ErBcQp7zLXdiMCHdnG4BUfKnWnPiw
	TEUhsAMHzIr3KceylFR3Ibr145Rh/7kr3VE1gte7nF9989/JQSidl05+3aRRoZArR1xJUAhc6VZ
	wHT/agmRzkh+Lxy+3rPxibfJT6rW+5WD4+yyWpWqTH733i+jLVC69HfLqr45bNV/zKeF+8tkX21
	Ct348a6sxwT0dBU1fDlVWrVF5qRvuiYfll+2YHh3GRE+cHANxeKorG79ex1+EvIlBtqjLHduW0U
	U9Z0VtwA==
X-Google-Smtp-Source: AGHT+IG7dihf3htJD8tYgepLxFBVBydbxwFYs/DwnZ80aqP09yns3LELTN0AQf3rpUon7qCKDcXzLQ==
X-Received: by 2002:a17:907:d858:b0:ae6:ae75:4ff6 with SMTP id a640c23a62f3a-ae6fc1cf1a8mr357229566b.52.1752242748753;
        Fri, 11 Jul 2025 07:05:48 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bd9sm303435166b.132.2025.07.11.07.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 07:05:48 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Fri, 11 Jul 2025 16:04:56 +0200
Message-ID: <20250711140507.17574-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711140507.17574-1-stefano.radaelli21@gmail.com>
References: <20250711140507.17574-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v4:
 - Added Acked-by
v3:
 - Change compatible string to match existing mainline format
v2:
 - Add symphony carrier board compatible

 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index bf6003d8fb76..d56046e439e9 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -100,6 +100,12 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,var-som-am62p-symphony
+          - const: variscite,var-som-am62p
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


