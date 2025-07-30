Return-Path: <linux-kernel+bounces-750406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A125B15AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B65B17083D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8B292B26;
	Wed, 30 Jul 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML0/5032"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728D23741
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865833; cv=none; b=M5TepxFF6o9W69TePBBaflnrmNlVaiJrJZyKK7V+V17zOGicwT/Ctk23dMUTV3gtnchY6f25YuAnTt+/jgEw5xlwST/VAz1sygjWaDcqY4A+jeoAmitT+u1M7FFG9kJTfdewOf5IhQ3R8X7Yxc0j7baqAmqcntR5t2Xd2t4crTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865833; c=relaxed/simple;
	bh=hsajDzu0lfxjqv88Cmk4ofktu32ybt7F20xywXJFamg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U/kdg8lZSC9NfE8zRrvcGBKzk5J8jEI/hhBbVWSNHsRQAS4D7Z6V0aI0WeWF1XCR2qKDG2iWfQX5u2Y453+H65+RajwTFTXmFzWy6m/B5ofAD+fvB/j6QY62M7q4iaxaoLPJ3DAg8jOvHtGfoU4Q2ROcQiNbkSqaF+E4pMTXWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML0/5032; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94109C4CEE7;
	Wed, 30 Jul 2025 08:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865832;
	bh=hsajDzu0lfxjqv88Cmk4ofktu32ybt7F20xywXJFamg=;
	h=From:Subject:Date:To:Cc:From;
	b=ML0/50321P4ekFv1c5FFA7LNjnsZKzik+mgq59u6o6CasVr6KRrawnu1+RvFfWN7I
	 Ddl1vF6OsEBHki2b1uB06xeV0xtN7kmi8rG69Kof+bT8M+JW9HRfGXzQu0O7WkhDf8
	 ZT2hV8mwKqwahw6hqUuDIM+F00Mr1GeUn9nITHid5dFtRa72uwlGFyNu4hnxSEff3i
	 6oFls6xPEmiNgelP98CLE3J3OV14mYbAHAeKTwuM3L+mq7rlSXRVN5Tn3AXrpJ98jW
	 q6wlVXfoVP5kQx+r17FQQxkgtl302FwP9wgN27A+x8LyEHWFmycgpEp0ckRUYIZFxe
	 xMcuIWFVVJ3tQ==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/14] drm/tidss: dispc: Convert to FIELD_* API
Date: Wed, 30 Jul 2025 10:57:00 +0200
Message-Id: <20250730-drm-tidss-field-api-v1-0-a71ae8dd2782@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFzeiWgC/x3MQQqEMAxA0atI1hPQ2EHrVQYXZRI1oFUaGYTi3
 S2zfIv/M5gkFYOhypDkp6Z7LGheFXyXEGdB5WKgmt51Rx45bXgqm+GksjKGQ7HtybsueGLnoJR
 Hkkmv//Uz3vcD0IOS4WUAAAA=
X-Change-ID: 20250729-drm-tidss-field-api-382947a92d44
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hsajDzu0lfxjqv88Cmk4ofktu32ybt7F20xywXJFamg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBmd9+Jjip81z36e/4U3taZ+7l7dX2FL6qxypFOupacwe
 k56Im3aMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACayjZGx4dC5GM7CJ+K77exv
 yHfwTzm5jsOscN7DSkXDqwq/PB8H/Ew6Ev23/NjUdA+V9ZpqhbuTGOsLp9YvuWNUGb1aW+6ix40
 Lejc4v9S6BIvPideSehEpv7Dwi9y7tccuaXxu+qyx7MvflUkA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Hi,

The tidss driver rolls its own API equivalent to the FIELD_* API already
provided the kernel.

Since it's an ad-hoc implementation, it also is less convenient and
doesn't provide some useful features like being able to share the field
definitions that will come handy in the future.

Thus, this series converts the driver to that API and drops its own
version.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Maxime Ripard (14):
      drm/tidss: dispc: Remove unused OVR_REG_GET
      drm/tidss: dispc: Switch to GENMASK instead of FLD_MASK
      drm/tidss: dispc: Switch to FIELD_PREP for FLD_VAL
      drm/tidss: dispc: Get rid of FLD_GET
      drm/tidss: dispc: Get rid of FLD_VAL
      drm/tidss: dispc: Switch FLD_MOD to using a mask
      drm/tidss: dispc: Switch REG_GET to using a mask
      drm/tidss: dispc: Switch REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch VID_REG_GET to using a mask
      drm/tidss: dispc: Switch VID_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch VP_REG_GET to using a mask
      drm/tidss: dispc: Switch VP_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Switch OVR_REG_FLD_MOD to using a mask
      drm/tidss: dispc: Define field masks being used

 drivers/gpu/drm/tidss/tidss_dispc.c      | 249 +++++++++++++++----------------
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  76 ++++++++++
 2 files changed, 200 insertions(+), 125 deletions(-)
---
base-commit: fbb0210d25fde20027f86a6ca9eee75630b5ac2b
change-id: 20250729-drm-tidss-field-api-382947a92d44

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


