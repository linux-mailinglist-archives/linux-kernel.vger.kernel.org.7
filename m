Return-Path: <linux-kernel+bounces-876393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FB1C1B7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881EC643874
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDC0345753;
	Wed, 29 Oct 2025 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="vKxLiLBT"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEF3446C5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748658; cv=none; b=W9a/cG8MZ+IpfqAZAfE53ax+gWUxY4KWc72RW6h78UlEaXlSE7KiGtPeHhYjUn4N04dLSvmmYxtKJaGt20rT2+51ubOlFCKcwHvjNlgMjcI6YV/tTR4zVmN4+mmdYqlf03yPCK1sE5BMqLK/otQtgut4AxJZKCHfvUPb7By62fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748658; c=relaxed/simple;
	bh=v5g2/tFW6cJCpWfZKG7ctdaqLbdAUNKogwWbJ6drI8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X+CFsvtP+vmOzf/cxvjplrItTwen4/WAG/Y0bGnlOVkL2lothvk+1T1+B2QRneb89/EatuYAzQF+QSNUIFVgMDDT8Yl/TQU5vfCpDiqzwJ8WCxhryK9ZSIAlOstGU3ky1JCHH7eEaKrGNJxvzKdRMzZQW+nrlIUC2OXbMYfMqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=vKxLiLBT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1F7661A174B;
	Wed, 29 Oct 2025 14:37:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6AF6606E8;
	Wed, 29 Oct 2025 14:37:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 589D2117F81AD;
	Wed, 29 Oct 2025 15:37:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761748653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/SkxqVl9RtXMg923ohzK0NptHaF/IbRJVg/+pganUWk=;
	b=vKxLiLBTDpT4RKqodVQ4a78yF/qqPUewJUpslNDs4poq70V98QUpsjSAkFEtBRBHDaUy3q
	ewYRzHHuydKbwo+aaL+4uW6HW40oo8ZULcAlacslayabzg8JDlOX4/+p5Q2helOvEmFSkp
	150E7/joSdHnQjbtSGt8AdZGS7vIIP6B7d9jzB/JqSUpCV3eTCzt741sjWNW1+N3GEh+Nx
	mkxyyRP2gefh6eqoy1PgxfUlpK9fh5iYfr6oVbZXPHem7ApXJLfegh1u3zzk7JE9SmGF+8
	70llBzV02nMeUePF2lWIbDGkaznMkebjipLcgPmb3HyCXH4OZzDn8x4G4eoBig==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 29 Oct 2025 15:37:02 +0100
Subject: [PATCH RESEND v2 25/32] drm/vkms: Introduce configfs for connector
 supported colorspace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vkms-all-config-v2-25-a49a2d4cba26@bootlin.com>
References: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
In-Reply-To: <20251029-vkms-all-config-v2-0-a49a2d4cba26@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=v5g2/tFW6cJCpWfZKG7ctdaqLbdAUNKogwWbJ6drI8c=;
 b=owEBbQKS/ZANAwAKASCtLsZbECziAcsmYgBpAiZ9llCo3cwKhbwIJTOJ7zIhQm30UYi95QYFc
 PrxMDS7woiJAjMEAAEKAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaQImfQAKCRAgrS7GWxAs
 4vY7D/4ptjbqjdj8ahDVRRC+Nkadn/jegwez4uSUZiQsEiU3dRvJ95JejUXOOrHm/OTL/0sqEbS
 47Ra6mFklunjoAz73I3ek+CeNu/0IVgZmYAfei19f17u2QgNnJAEkOCiln54OpsZflULJuSf2SF
 JZnAR8Xzav2yw7LkpwjFGkHyHe/CFSc48nQaZ2IJ1df22F49Tj1RBcmiQHeG57EZ9uFEpH0kyXw
 Gm5HM4BrEocYnlKczoqQjJVhLezqgtJyF28GeFNVoe0Opou7iTUkcFopQvtJlmyYZSMI4/vuFzU
 sOCeQ8jvrjNE+F9PcV18WhF2f2ILEnccGCtzeUBmuWz3CPR/nSrquad+tZTLdDfCwr+0PusNeB1
 OiCeYPKRdY4Jid7CePxMLyTQapBcU5R+9RUP7s5t9/4vLv7UAir3QvdZU0s+anP3is1hlRBKYYD
 oEGa8bVl2esZE2KmOBjUDllJYp7QCmOqjp5mVw1YPBISVTYKt1n2rHOeSlKSp2LdK4/++JPE9v0
 jJ7IKbSOzlMjPBrmjndVDDsnyf5h3HiCWOGhWbbzOqTsvlK3BuLZtjDCs8u/8kprjDxynVgcr80
 /QR1M4yALXWEDPecJzD8agRU9d3SYwejzflJ/NIhNCV9uZc6rE+AuxNAaKagrgnSIf19v5GvJuW
 tk3ayAePm3HMCMA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3

Add the attribute supported_colorspaces to configure the supported
colorspace of a connector. It will allows emulating some HDR features of
displays. This feature is only supported for HDMI, DP and eDP connectors.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/gpu/vkms.rst           |  7 ++++++-
 drivers/gpu/drm/vkms/vkms_configfs.c | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 99c5cf3dbd78..c762cadac6f4 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -138,11 +138,16 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 2 configurable attribute:
+Connectors have 3 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
 - type: Type of connector. Same values as exposed by the "type" field in drm_connector.
+- supported_colorspaces: Supported colorspaces values for HDMI, DP and eDP connectors.
+  If supported_colorspaces is not 0, the HDR_OUTPUT_METADATA will also be created.
+  Value is a bitfield, 0x1 = NO_DATA, 0x2 = SMPTE_170M_YCC... see enum drm_colorspace
+  for full list.
+
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index b03e9af569b6..a7f4589403ce 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1223,12 +1223,51 @@ static ssize_t connector_type_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_supported_colorspaces_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	int type;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		type = vkms_config_connector_get_supported_colorspaces(connector->config);
+
+	return sprintf(page, "%u", type);
+}
+
+static ssize_t connector_supported_colorspaces_store(struct config_item *item,
+						     const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	int val, ret;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	ret = kstrtouint(page, 10, &val);
+	if (ret)
+		return ret;
+
+	if ((val & -BIT(DRM_MODE_COLORIMETRY_COUNT)) != 0)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (connector->dev->enabled)
+			return -EBUSY;
+		vkms_config_connector_set_supported_colorspaces(connector->config, val);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
+CONFIGFS_ATTR(connector_, supported_colorspaces);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
 	&connector_attr_type,
+	&connector_attr_supported_colorspaces,
 	NULL,
 };
 

-- 
2.51.0


