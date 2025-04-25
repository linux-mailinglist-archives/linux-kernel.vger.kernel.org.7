Return-Path: <linux-kernel+bounces-620353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 816A9A9C989
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCDE18989AB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 12:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843024EABD;
	Fri, 25 Apr 2025 12:53:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0824E4A4;
	Fri, 25 Apr 2025 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745585595; cv=none; b=XG0NPjSFTa4CytBxBq5sYDO7qJSqkKj2A4/jyOrmJ0nTIeBKqPFkeNBvYZcK07HpOqj3lBzhxbFcd9p1im6W8z/M1Sko0M3TVM6F2aiE9kSSPpQye7iXjV3UUqCQ11wJONsq8BDhhdlYq0BVqy5soHDfTNxybxAkgkg3c+kfsTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745585595; c=relaxed/simple;
	bh=+oeeVKI2hlo1M+5hYy0KCm8NvN2FuUU18yUSbHBOst4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5ZZ+EyW6w6FyTinFhmY8Ky/G7+NbD9qc1bDKBhcpRJEVbi+bo6N1a6upGXJY5OrdgUHmR2PfZSDbSl+R3pJmLeOxV4TyduqBHIhk1+KO1kJKNRSvOJcJzLtB2Ld73umdse+9tvdwuKdsfREZtg3NarVyBCLoBB6y4eTU+NnJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 007FC106F;
	Fri, 25 Apr 2025 05:53:07 -0700 (PDT)
Received: from pluto.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A8A63F59E;
	Fri, 25 Apr 2025 05:53:09 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	dan.carpenter@linaro.org,
	maz@kernel.org,
	johan@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 0/4] Introduce SCMI Quirks framework
Date: Fri, 25 Apr 2025 13:52:46 +0100
Message-ID: <20250425125250.1847711-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

with the increasing adoption of SCMI across arm64 ecosystems, we have to
start considering how to deal and take care of out-of-spec SCMI firmware
platforms that are actively deployed in the wild, in a consistent manner.

This small series introduces a simple framework, based on static_keys,
that allows a user to:

- define a quirk and its matching conditions; quirks can match based on:

  	compatible / Vendor_ID / Sub_Vendor_ID / [Min_Vers, Max_Vers]

  from the longest matching sequence down to the shortest.

  When the SCMI core stack boots it will enable the matching quirks
  depending on the information gathered from the platform via Base
  protocol: any NULL match condition is ignored during matching and is
  interpreted as ANY, so you can decide to match on a very specific
  combination of compatibles and FW versions OR simply on a compatible.

- define a quirk code-block: simply a block of code, meant to play the
  magic quirk trick, defined in the proximity of where it will be used
  and gated by an implicit quirk static-key associated with the defined
  quirk

Patch 1/4 in the series is really unrelated to the Quirk framework
itself: it is a slight variation on a fix posted previously by Sibi around
PERF FastChannels and it is included here for simplicity, since the example
quirk provided later in this series has to be applied exactly where 1/3
applies its modifications.

Patch 2/4 introduces support for SCMI quirks: support is default-y in
Kconfig as of this series. All the quirks found defined are stored in
an hashtable at module initialization time.
Since V1 the quirks are matched on ranges of ImplementationVersion if
provided.
Since V2 the matching condition based on compatible, it is optionally
represented by a list of possible compatibles.

Later on, when the SCMI core stack probes and it has retrieved basic info
via Base protocol, all the matching quirks are enabled, which simply means
the related underlying specific quirks static-keys are enabled.

Patch 3/4 Convert a pre-existing quirk to use the Quirk framework: it is,
though, a peculiar quirk, since it was meant to match any firmware version
or from any vendor/sub_vendor.

Patch 4/4 introduces an example Quirk for a known problem on a known
platform as reported by Johan, Marc and Sibi, BUT note that the matching
condition in tha patch MUST be properly completed in the patch (I was not
sure what to use...see my comments)

The macro-salad still triggers a lot of checkpatch warns.

Any feedback and testing is very much welcome.

Thanks,
Cristian

---
V1 -> V2
- added support for matching against an optional list of compatibles
- compile the quirks even if Quirks framework is not enabled
- reduced CLOCK_DESCRIBE_RATES triplet Quirk size
- added more docs & examples

RFC -> V1
 - collected tags for patch 1/4
 - Added version ranges handling for Implementation Version
 - make Quirk frmwk default-y
 - add COMPILE_TEST depend
 - move quirk enabling logic out of Base protocol init to avoid possible
   deadlocks with cpu_lock (reported LOCKDEP splat from Johan)
 - fix Quirk matching conditions for quirk_perf_level_get_fc_force


Cristian Marussi (3):
  firmware: arm_scmi: Add Quirks framework
  firmware: arm_scmi: quirk: Fix CLOCK_DESCRIBE_RATES triplet
  [NOT FOR UPSTREAM] firmware: arm_scmi: quirk: Ignore FC bit in
    attributes

Sibi Sankar (1):
  firmware: arm_scmi: Ensure that the message-id supports fastchannel

 drivers/firmware/arm_scmi/Kconfig     |  13 ++
 drivers/firmware/arm_scmi/Makefile    |   1 +
 drivers/firmware/arm_scmi/clock.c     |  33 +--
 drivers/firmware/arm_scmi/driver.c    | 111 ++++++---
 drivers/firmware/arm_scmi/protocols.h |   2 +
 drivers/firmware/arm_scmi/quirks.c    | 321 ++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/quirks.h    |  52 +++++
 7 files changed, 486 insertions(+), 47 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/quirks.c
 create mode 100644 drivers/firmware/arm_scmi/quirks.h

-- 
2.47.0


