Return-Path: <linux-kernel+bounces-591287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 672F3A7DDD5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B24A1892172
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21F24DFFB;
	Mon,  7 Apr 2025 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WF4fTGRO"
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75831A7044
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744029440; cv=none; b=oVZmxsOL6EtS6AtvghnU3PsTIuzX5YaktdDyiYhmDb8ViwhrlhhvgP8VoqAfw6hl5yz0RR1PVEx8K/D1yupu/Uo/853DJZlhCYF3V/Jvkpk30xKY/EywT4fCjbpmZxALuxgdxSyvgkO4Vvo3ZvJeokgGWjB5K9kIu+KFJImtoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744029440; c=relaxed/simple;
	bh=r/T5Mvgm+4E8BMHpVYH3ATZZcktSIOl0OSw2kMJvrD8=;
	h=From:To:Cc:Subject:Date:Message-ID; b=g+5jX6Mc/mlhLDLmimrwjK0V1OnGhOx/7DD8pqwDQ3y9CapMlT7KyYRZHocjzKha3KQSiT44lJ8CFM2aa8DN4wRj6JVzdI9REQI2ZcwQNJaObK5kgzSf5Gpsgqbx2YLGHFqFhXtY9zpAJ6RHy6bCPMxR+jg1Pr+82fWw1jpw0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=WF4fTGRO; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-2c7e5fb8c38so2704818fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Apr 2025 05:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744029437; x=1744634237;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21ud4a7PpzHTsE+w/yzFe+lHiyhoei8BC1Tfj/sZr0c=;
        b=Msq8P9mn1rA5H/ZiaL1yo5aNIikzFJd6TqJBgCJo6Eqc0gNxxNAA/KuN4uwJqVzLmA
         q/l9Zkvt9bsrWc23yjPcH3Ny+cosLBMqlgteHULtkugriW/zB0Utwgq+Z2pn48ApYlBf
         4Uu+tE48XIVr3kTOyBJ/X1PyzKgVchCQGBiLuf9xiwzyEHbFFhPq9ZJ6R0uZtDlAPMRC
         Ig61uMbRJ2vPY+wBY4wXUiRI9DuAJ7N6+6Q1Fvxr5caif7scwPvmhPxK8RgW2mxDOPAM
         SjCzMYqM4kSUdZdzLlXOzOiK12WzO9fBdd1tleNVpPBekgrJ6E4KC7A8iaVTDW04gyVd
         IU2Q==
X-Gm-Message-State: AOJu0Yxf0MLpviRTEt0bkhNOGWnHWNFTG1ZKlc9pu5sM1AYo4U1p2t0a
	SZRDeXD842F1plspoFMtJ/TOvU+l8sq1oCF4/3hY9OCfzpFAS6bQS94Kd5RAt+5O2dio5fAv7u8
	LGdAmfclpFWV024t9ArR+dVqN8AT3iw==
X-Gm-Gg: ASbGncvqy7JnkQKrljq7VrMIBrT+2mSerzLX5Yk2JP6nGeTMqYdf9j7/5u2ruvRMhg0
	XbBb3Ec9aq2t3e6xHfeHdlGXqC6H1CFh6adx029UFhwkBCPS53fSQZqw2CfH2RPVJvTz33ar6Td
	HBXXMO7vz97CwUhdI+o+VdU408rhUilqXtkgW82J/8fOs3g1HNBELZVD9r4zmrIKHKPsGOm1HUO
	9nCxub7AIROSVuV/9rrMZ2oW/lAB97xenNrnYQjzEPiN61ZxE87GoeaTZDYNldgSlzD+aws1Zec
	vRdyiYYGRJwgUMbyf/KgkhjCZ6E=
X-Google-Smtp-Source: AGHT+IFwD3N3azBjTuz63ahaMy52lmrJaPVlJJNJrWOY/OnOBkQkkoZFOugtTieb0gKL5dsL3XIPsVIQhsY6
X-Received: by 2002:a05:6870:9c84:b0:2cb:c780:ac52 with SMTP id 586e51a60fabf-2cd32f45081mr4230230fac.23.1744029436705;
        Mon, 07 Apr 2025 05:37:16 -0700 (PDT)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2cc845542d8sm638112fac.5.2025.04.07.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:37:16 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1744029434;
	bh=21ud4a7PpzHTsE+w/yzFe+lHiyhoei8BC1Tfj/sZr0c=;
	h=From:To:Cc:Subject:Date:From;
	b=WF4fTGROUngYoKZVX7o687VHDF3//y+V1ZeOlVvIKNMYZXvXmuzOdjIY9IY0aLl+/
	 FaEvgWzVzhOdPMgz21C8E0ueAEqVmEWHozh70iYFJtt65h8LlW+cBqBDdz5+UA2gu0
	 V7bttLm9A0H0m0c9Y5rHdL6gX8p0GG2wxFRnVniL8lWbHfixZztxI9U2OLrsJHDTKP
	 owwr0aMD3lulmaNzyf901YaArthAlftfRm1U6Gui/1XjUaWQsZmQXmOEM1XcnXoAWG
	 XsJrBltB7Ie2IQIAKSkjgsx1wFIjMW5nupqATvSG8y9nDOCQpfnjmApxBsbGBrjJsH
	 4I6gHLODN9Xng==
Received: from mpazdan-home-zvfkk.localdomain (dhcp-244-168-54.sjc.aristanetworks.com [10.244.168.54])
	by smtp.aristanetworks.com (Postfix) with ESMTP id D55FE10023B;
	Mon,  7 Apr 2025 12:37:14 +0000 (UTC)
Received: by mpazdan-home-zvfkk.localdomain (Postfix, from userid 91835)
	id C0C3840B13; Mon,  7 Apr 2025 12:37:14 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Marek Pazdan <mpazdan@arista.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Marek Pazdan <mpazdan@arista.com>
Subject: [PATCH 1/2] ethtool: transceiver reset and presence pin control
Date: Mon,  7 Apr 2025 12:35:37 +0000
Message-ID: <20250407123714.21646-1-mpazdan@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Signal Definition section (Other signals) of SFF-8636 Spec mentions that
additional signals like reset and module present may be implemented for
a specific hardware. There is currently no user space API for control of
those signals so user space management applications have no chance to
perform some diagnostic or configuration operations. This patch uses
get_phy_tunable/set_phy_tunable ioctl API to provide above control to
user space. Despite ethtool reset option seems to be more suitable for
transceiver module reset control, ethtool reset doesn't allow for reset
pin assertion and deassertion. Userspace API may require control over
when pin will be asserte and deasserted so we cannot trigger reset and
leave it to the driver when deassert should be perfromed.

Signed-off-by: Marek Pazdan <mpazdan@arista.com>
---
 include/uapi/linux/ethtool.h | 14 ++++++++++++++
 net/ethtool/common.c         |  1 +
 net/ethtool/ioctl.c          |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..36c363b0ddd4 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -289,11 +289,24 @@ struct ethtool_tunable {
 #define ETHTOOL_PHY_EDPD_NO_TX			0xfffe
 #define ETHTOOL_PHY_EDPD_DISABLE		0
 
+/**
+ * SFF-8636 Spec in Signal Definition section (Other signals) mentions
+ * that 'Additional signals such as power, module present, interrupt, reset,
+ * and low-power mode may be implemented'. Below defines reflect present
+ * and reset signal statuses. Additionally ETHTOOL_PHY_MODULE_RESET
+ * in 'enum phy_tunable_id' will be used for reset pin toggle.
+ */
+#define ETHTOOL_PHY_MODULE_RESET_OFF            0x00
+#define ETHTOOL_PHY_MODULE_RESET_ON             0x01
+/* Not Available if module not present */
+#define ETHTOOL_PHY_MODULE_RESET_NA             0xff
+
 enum phy_tunable_id {
 	ETHTOOL_PHY_ID_UNSPEC,
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_MODULE_RESET,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 0cb6da1f692a..3d35d3e77348 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -101,6 +101,7 @@ phy_tunable_strings[__ETHTOOL_PHY_TUNABLE_COUNT][ETH_GSTRING_LEN] = {
 	[ETHTOOL_PHY_DOWNSHIFT]	= "phy-downshift",
 	[ETHTOOL_PHY_FAST_LINK_DOWN] = "phy-fast-link-down",
 	[ETHTOOL_PHY_EDPD]	= "phy-energy-detect-power-down",
+	[ETHTOOL_PHY_MODULE_RESET]   = "phy-transceiver-module-reset",
 };
 
 #define __LINK_MODE_NAME(speed, type, duplex) \
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 221639407c72..f1f4270cdb69 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -2954,6 +2954,7 @@ static int ethtool_phy_tunable_valid(const struct ethtool_tunable *tuna)
 	switch (tuna->id) {
 	case ETHTOOL_PHY_DOWNSHIFT:
 	case ETHTOOL_PHY_FAST_LINK_DOWN:
+	case ETHTOOL_PHY_MODULE_RESET:
 		if (tuna->len != sizeof(u8) ||
 		    tuna->type_id != ETHTOOL_TUNABLE_U8)
 			return -EINVAL;
-- 
2.47.0


