Return-Path: <linux-kernel+bounces-894190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA9C49715
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F32C84ED45A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AB2F60A7;
	Mon, 10 Nov 2025 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMnLplU4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F021B9FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811119; cv=none; b=oM3/4iu2RyXTQEgreioZjfsZuSjj3RvEZDA30VvM6vDYem2fwtKgHk2J+OrmCwXFKooeRrcuB/bkGgOFX0DIffpmZgBxHDm3tN8AMf23BSkHz/D04Qpa/Tt/KmFg8c4kUninv1yelMJ1dEkVqCXGm0BwLIj3t5WXskSS967TW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811119; c=relaxed/simple;
	bh=dHwTe00j1MV9dgQgcUWIMhhJ7OdyBnhAZ0pGNCeydWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGFiFekXvBTmtWHEtHZVJd5He23e8J3mqRMtyy5wmEy6GFBtte4b9E0qsL5Hyuq6xaC2CHL0Kk35KorrNweJptPWb2Q1cZhOc6tKHIfAmxHj9/bk1mMfE8GqYp+azPzQZKJeNLMFhr4n31n21b+HYaBgjHeO+j+uc6H8KrlEWhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMnLplU4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b7272012d30so653168266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811116; x=1763415916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KiFNjiZ4X2EvOoUrngxyK7bRgO5ZFSxeJZ13R5Tmu5A=;
        b=bMnLplU4DiovrGil+UN3G4mfT22q2bHV3WKMkW2E2O9t1/PZYbKeLrRYODyv0Rme60
         9wAe4zAt3UrKRekIvIR2NcWu7MvIkibn5+g5U9V1Glv0sGSj7/FZvtb1B5xWrdNEgwlm
         Un7n2xkMVWNO/f2aRi++DEPNWbUJQSPptoE6scpWoemNw84UwgjPKhE7BwqGkGzleTVF
         YWSqas7/TOcMbKVpJffrXmAb+76Mf6MOnf3cJ/S6oD7XEeBaA4sWVx/9ij0tzExyYY3+
         2l0vQe0FPNY8/vTmpLx8E7ZGGhSIWpaC3RtuasnRTFGGd7b5bGYz6ManD/OeWxgWeLAc
         jdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811116; x=1763415916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiFNjiZ4X2EvOoUrngxyK7bRgO5ZFSxeJZ13R5Tmu5A=;
        b=BG5mgwIrwq6SQTWy79LG0Kx1wtFDp804QksnWqIUgIq6q0MGjn+YufNe340r7OiuK9
         mC2eQSkcJL0Jp7ULAWaYdDlS1tpqN1NU08hLSVWQuOpWrHp9rw3qxIs12ODB2CuJ06HQ
         zDVJzn68x9lHk8sK70r/aTAlYK5U5wsHms9B1/pgttO7OWdBhhpTue7fnSjBop+RMVAd
         /SVBR7hJ/gWV6R7kVpM2k1FWQB8d/grCVlHr00fOV+rKlFZOBMah53Pdj72RpV/IEBJf
         2rB5pAW6q+553+wrqrejCyvNf0L0Ksj4dbXJv3McgW+GqfzESlT4c/fhyyBT1Susufpv
         JMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW37wn89C1jHUTAKH3hvagqcRvHlOXobb3cGnBjW4I/7BeQa646UzJB+hQGlar0iyNmEjzdpeT6EE3+wew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0890rczWFC6SEZLCprHWwiti8MKKKSGnRr/3i/ClOgSiZtgqt
	Q1iF9uayGaPpHd22HHwC77Wj3zZNhjGEA6DAg0pBwF5m5pUKBhw5IN9E
X-Gm-Gg: ASbGncv8bdUfR4LMewKZusdJxAv/wZXLIZ93pr+D3fmUwn+W2yzXLVz6tWSQxTUtJt0
	AFoOY4QDhl2Ph42DPQJpqVG7gmV88JkyQslYZ6DFoVT5bOdJctZFM3+Q2i1oyUQ3AMLxXNWhcgC
	UdDgn5o6k0+mTGLgA3LV5ya4csCrLHno5A6EK9NhqAlAuV+BIO4eCNyS2MZ2QWtfKSUeZMgjCdT
	vbnnNkUGcgo0/5HuKWnJd7sVnIjWm9x/VMjvTByzT2Ecq0/Y5blE9Y+Ao83vJlJwCSSYKiUUYlD
	lc6HyiEKeeQ717WwLdT2gyamuYHg6047B2W7UuBeW5OKbbw9xCQlKSBtGET0et26DreA9dt795x
	qvEt8TSdL2Gm7VMqAQ/HoJilNf3xPakoxTUXKQ6VKRNIOzIHslX7vtxGFA2ZMsB+5vHdWIyRkj6
	rllq+/6KFrklgw2vpJ4tYKfacKmDv49paZE8TRSpedh4uq1rBAUWHmqQhL
X-Google-Smtp-Source: AGHT+IGg2UVCwGUPO2ALg7EHaUKW+Wi+Pkw0XTmmfXGNkVW/r/qLutpXRxnKp37lcMUpt8E4SQus8A==
X-Received: by 2002:a17:907:8688:b0:b6d:3a00:983a with SMTP id a640c23a62f3a-b72e041024cmr973604866b.38.1762811115633;
        Mon, 10 Nov 2025 13:45:15 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72d1b4916dsm1075671766b.15.2025.11.10.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:14 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 0/3] net: dsa: deny unsupported 8021q uppers on bridge ports
Date: Mon, 10 Nov 2025 22:44:40 +0100
Message-ID: <20251110214443.342103-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/networking/switchdev.rst is quite strict on how VLAN
uppers on bridged ports should work:

- with VLAN filtering turned off, the bridge will process all ingress traffic
  for the port, except for the traffic tagged with a VLAN ID destined for a
  VLAN upper. (...)

- with VLAN filtering turned on, these VLAN devices can be created as long as
  the bridge does not have an existing VLAN entry with the same VID on any
  bridge port. (...)

Presumably with VLAN filtering on, the bridge should also not process
(i.e. forward) traffic destined for a VLAN upper.

But currently, there is no way to tell dsa drivers that a VLAN on a
bridged port is for a VLAN upper and should not be processed by the
bridge.

Both adding a VLAN to a bridge port and adding a VLAN upper to a bridged
port will call dsa_switch_ops::port_vlan_add(), with no way for the
driver to know which is which. But even so, most devices likely would
not support configuring forwarding per VLAN.

So in order to prevent the configuration of configurations with
unintended forwarding between ports:

* deny configuring more than one VLAN upper on bridged ports per VLAN on
  VLAN filtering bridges
* deny configuring any VLAN uppers on bridged ports on VLAN non
  filtering bridges
* And consequently, disallow disabling filtering as long as there are
  any VLAN uppers configured on bridged ports

An alternative solution suggested by switchdev.rst would be to treat
these ports as standalone, and do the filtering/forwarding in software.

But likely DSA supported switches are used on low power devices, where
the performance impact from this would be large.

While going through the code, I also found one corner case where it was
possible to add bridge VLANs shared with VLAN uppers, while adding
VLAN uppers shared with bridge VLANs was properly denied. This is the
first patch as this seems to be like the least controversial.

Sent as a RFC for now due to the potential impact, though a preliminary
test didn't should any failures with bridge_vlan_{un,}aware.sh and
local_termination.sh selftests on BCM63268.

A potential selftest for bridge_vlan_{un,}aware.sh I could think of

- bridge p3, p4
- add VLAN uppers on p1 - p4 with a unique VLAN
  if refused, treat as allowed failure
- check if p4 sees traffic from p1

If p1 and p4 are isolated (so implicitly p2 and p3), its fine, and if
the configuration is rejected is also fine, but forwarding is not.

Jonas Gorski (3):
  net: dsa: deny bridge VLAN with existing 8021q upper on any port
  net: dsa: deny multiple 8021q uppers on bridged ports for the same
    VLAN
  net: dsa: deny 8021q uppers on vlan unaware bridged ports

 net/dsa/port.c | 23 +++------------
 net/dsa/user.c | 80 ++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 71 insertions(+), 32 deletions(-)

-- 
2.43.0


