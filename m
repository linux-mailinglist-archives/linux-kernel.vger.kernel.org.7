Return-Path: <linux-kernel+bounces-891435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9666C42A78
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E6E5348E4F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284992F291B;
	Sat,  8 Nov 2025 09:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GOvzaZwG"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B12E22BD;
	Sat,  8 Nov 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594613; cv=none; b=Jr4Zy7EWv2SVa3IGaSuB2sDWMNYOpbWrahd1nJUuETcsPd+TA1OQXHJC29rcWUhiF/LZd0Jl+ALC2Uqe6Jld9+DpoeN1p/KXJpueUsLhIpkxayU5VwE7e6cTXQBFTwybSLusPB5R57zqyRT8cddMQ2h9T4yc1Msmg+ZTvA7ernU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594613; c=relaxed/simple;
	bh=EU5psEHBNq7zxVfGcbPO2p2HeGtCUZ6cPz61EOQCxBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rg6Zd0ZQicVqPIjNXUv/4cav3vSUJHhjsJSKWgWwUOiJ01Vbq0Vpr5+6J/4WZMrgbHxnlvQna7I55oH3Obdg5pWH+JVLJHR0QvzhBitjGEIDAmrrE0zfOrDJgonMF0lIxIuGEqlW+/aWytceGJrF77LJoL7kwtVXRu4v7UrWM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GOvzaZwG; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4F366F06;
	Sat,  8 Nov 2025 10:34:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594489;
	bh=EU5psEHBNq7zxVfGcbPO2p2HeGtCUZ6cPz61EOQCxBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GOvzaZwGa4feIx+yzb5Iut6sDCInMjxW+ZMEXZFjUBMlGBONchrR4NVWcj9d4GW4K
	 UKvI9s2CWNkg1Qd4zEh0QYq0doMCwGwjZvRNfZFWYgY3CW9zSCjJun5iTbnGk7u8eM
	 xA2EKkge1tbkVVejmkMAame7vCvz5gb7XGr+c9Hk=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Sat, 08 Nov 2025 10:36:25 +0100
Subject: [PATCH v9 4/8] media: Documentation: uapi: Add V4L2 ISP
 documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-extensible-parameters-validation-v9-4-6a7e22aa57d0@ideasonboard.com>
References: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
In-Reply-To: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Antoine Bouyer <antoine.bouyer@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4827;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=EU5psEHBNq7zxVfGcbPO2p2HeGtCUZ6cPz61EOQCxBQ=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8mceXuXf7+LXYwHKVmC4noulRRQzL44WoWb
 e/9DqzXp5yJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJgAKCRByNAaPFqFW
 PEakD/9muUP0gfjAuZs/SJvWSbVDGZWB837z7akXxPXl9htif13nYeEuIwyndTrstJUDTibE6Mo
 aQRcB15uCUJjilCYfa9mndeyEmx08aiXkKB0sGvXu4PVHhlXCoeel4E1t/PX2wnDh6lhArhhZRs
 sHi8n40xWcJTH9O9s8ziEieWv+0bCQkHv22O90JluwXOoo1aHenNKmw+hZk8PpVAR8/BQxS0Tp1
 hi6JYTVNqqmCauTV89zKz8gQtuDUCyUF0foIrZpajDXh238Fd5bnbcw8BKw6u0p1spGr25uVjYG
 ZlK3PUIrBjFFvHaSq3ZkDjHswDi0c3mTCtIfCCJ3Nbn1ZVkaktbEU7sAZr6oEBTmO/FtLSQphX0
 5zglNHvdxR2E3lPxkFbu391HFQA0RqhJ2SQoNBUppI7/Mk7dhI3/0yd4N+/naEHK/YdsPTESIsL
 v41f55Bn8RN2RmXoqTRZR2YiHJgz/M0aRrn56BV6Gq7UxuOYe51Edv/m3Sd4pbdhQ2kofjNGdVo
 i38IEB8pabRpZsHHRQ6q9qdfcyvlf2RKQRwFoEgnH7N3usfQFKStjp+uBYIQLyPIL8crcO40N+R
 XPqMgK/JgU9Yy/pqBV1MEeQuZFsxXPxAtqZgufj5n79UF4Wr2DfYDVS/3BYbOKJcjbSVznmGWhd
 skwMRVYHx4jiySQ==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Add userspace documentation for V4L2 ISP generic parameters and
statistics formats.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 .../userspace-api/media/v4l/meta-formats.rst       |  1 +
 Documentation/userspace-api/media/v4l/v4l2-isp.rst | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 3 files changed, 69 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
index d9868ee88a0717c1acaa4ee477eaed96a6411f73..7b758ea9eb4ac3c4b354bf8e2f319985ed9e2b37 100644
--- a/Documentation/userspace-api/media/v4l/meta-formats.rst
+++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
@@ -25,3 +25,4 @@ These formats are used for the :ref:`metadata` interface only.
     metafmt-vivid
     metafmt-vsp1-hgo
     metafmt-vsp1-hgt
+    v4l2-isp
diff --git a/Documentation/userspace-api/media/v4l/v4l2-isp.rst b/Documentation/userspace-api/media/v4l/v4l2-isp.rst
new file mode 100644
index 0000000000000000000000000000000000000000..facf6dba1ca7fc34c40e285215cfcb6dfa4ee332
--- /dev/null
+++ b/Documentation/userspace-api/media/v4l/v4l2-isp.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
+
+.. _v4l2-isp:
+
+************************
+Generic V4L2 ISP formats
+************************
+
+Generic ISP formats are metadata formats that define a mechanism to pass ISP
+parameters and statistics between userspace and drivers in V4L2 buffers. They
+are designed to allow extending them in a backward-compatible way.
+
+ISP parameters
+==============
+
+The generic ISP configuration parameters format is realized by a defining a
+single C structure that contains a header, followed by a binary buffer where
+userspace programs a variable number of ISP configuration data block, one for
+each supported ISP feature.
+
+The :c:type:`v4l2_isp_params_buffer` structure defines the buffer header which
+is followed by a binary buffer of ISP configuration data. Userspace shall
+correctly populate the buffer header with the generic parameters format version
+and with the size (in bytes) of the binary data buffer where it will store the
+ISP blocks configuration.
+
+Each *ISP configuration block* is preceded by an header implemented by the
+:c:type:`v4l2_isp_params_block_header` structure, followed by the configuration
+parameters for that specific block, defined by the ISP driver specific data
+types.
+
+Userspace applications are responsible for correctly populating each block's
+header fields (type, flags and size) and the block-specific parameters.
+
+ISP block enabling, disabling and configuration
+-----------------------------------------------
+
+When userspace wants to configure and enable an ISP block it shall fully
+populate the block configuration and set the V4L2_ISP_PARAMS_FL_BLOCK_ENABLE
+bit in the block header's `flags` field.
+
+When userspace simply wants to disable an ISP block the
+V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bit should be set in block header's `flags`
+field. Drivers accept a configuration parameters block with no additional
+data after the header in this case.
+
+If the configuration of an already active ISP block has to be updated,
+userspace shall fully populate the ISP block parameters and omit setting the
+V4L2_ISP_PARAMS_FL_BLOCK_ENABLE and V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bits in the
+header's `flags` field.
+
+Setting both the V4L2_ISP_PARAMS_FL_BLOCK_ENABLE and
+V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bits in the flags field is not allowed and
+returns an error.
+
+Extension to the parameters format can be implemented by adding new blocks
+definition without invalidating the existing ones.
+
+ISP statistics
+==============
+
+Support for generic statistics format is not yet implemented in Video4Linux2.
+
+V4L2 ISP uAPI data types
+========================
+
+.. kernel-doc:: include/uapi/linux/media/v4l2-isp.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 8989e7e00d86d0c13c4c0b7e5c7eb9481b65861f..b4dd272a0790c317580d0747c8043738a1a58d8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26859,6 +26859,7 @@ V4L2 GENERIC ISP PARAMETERS AND STATISTIC FORMATS
 M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/userspace-api/media/v4l/v4l2-isp.rst
 F:	include/uapi/linux/media/v4l2-isp.h
 
 VF610 NAND DRIVER

-- 
2.51.0


