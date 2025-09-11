Return-Path: <linux-kernel+bounces-811485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32603B529C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D710C58025D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5826C386;
	Thu, 11 Sep 2025 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Obw30WnE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B226B0BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575397; cv=none; b=BPC64DhnfVURSocaHd2cO4gQ56p3dmNhe/zs+UsrsCGo7SV04/cpsTmCUqL2mTu67uzhADWZYoHnqqjBYwe7mfs/qUD1cVzNMDxSTcxcUwVhQ9GsGbwlT2ApYhBpTOiY/bHcE5JI/jpVftZk4kmK1ZQVZEDTlrFqpxTpjlfJh4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575397; c=relaxed/simple;
	bh=CaWSZrgm1M8YqD1WcirOTRnj0ww0foEmKSgKyjrm5nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dERZdAzBeaqLuq91B+eXuLBeql3cM7ih7cYt54RCIszu2eU11qpwBvBvBmmvKoj0pZRh87Cs1hcz7NMj4BZfOkA9VwOkJZxfpYjnsbRWtDuP82kbvbIPHsb28ZUSKqDYLN62mKo0lrb6y6UYlzMFYFyToBE2OhyAGHkjTxB2LC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Obw30WnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757575395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jvuTVWNZDyZ0h579CaXBpKTLbC1d5EjG/JgIw3vY0w8=;
	b=Obw30WnEwafIrF2H9Qp7VZkArNKvV5qbGTVxPMd2ZGTFZd1gAq/hDJPoZqz5wDsrJ93cUg
	ujNDhKP1U4fEhfcMpSJtg2686bHvU3DijDkW/nXoIoOQcBesviiI80T9zPrctyqHvtQx4l
	l4pON/65rf1fWkn14KDK1I1MrVovgfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-_j9gDVGhOqqMnUc1xnhP2A-1; Thu,
 11 Sep 2025 03:23:09 -0400
X-MC-Unique: _j9gDVGhOqqMnUc1xnhP2A-1
X-Mimecast-MFC-AGG-ID: _j9gDVGhOqqMnUc1xnhP2A_1757575388
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC686180057C;
	Thu, 11 Sep 2025 07:23:07 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.225.144])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9652F19560B1;
	Thu, 11 Sep 2025 07:23:03 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase measure averaging factor
Date: Thu, 11 Sep 2025 09:23:01 +0200
Message-ID: <20250911072302.527024-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The DPLL phase measurement block uses an exponential moving average,
calculated using the following equation:

                       2^N - 1                1
curr_avg = prev_avg * --------- + new_val * -----
                         2^N                 2^N

Where curr_avg is phase offset reported by the firmware to the driver,
prev_avg is previous averaged value and new_val is currently measured
value for particular reference.

New measurements are taken approximately 40 Hz or at the frequency of
the reference (whichever is lower).

The driver currently uses the averaging factor N=2 which prioritizes
a fast response time to track dynamic changes in the phase. But for
applications requiring a very stable and precise reading of the average
phase offset, and where rapid changes are not expected, a higher factor
would be appropriate.

Add devlink device parameter phase_offset_avg_factor to allow a user
set tune the averaging factor via devlink interface.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2:
* optimized conversion between factor value and register value
* more detailed parameter documentation
---
 Documentation/networking/devlink/zl3073x.rst | 17 ++++++
 drivers/dpll/zl3073x/core.c                  |  6 +-
 drivers/dpll/zl3073x/core.h                  |  8 ++-
 drivers/dpll/zl3073x/devlink.c               | 61 ++++++++++++++++++++
 4 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
index 4b6cfaf386433..1988721bdfa8b 100644
--- a/Documentation/networking/devlink/zl3073x.rst
+++ b/Documentation/networking/devlink/zl3073x.rst
@@ -20,6 +20,23 @@ Parameters
      - driverinit
      - Set the clock ID that is used by the driver for registering DPLL devices
        and pins.
+   * - ``phase_offset_avg_factor``
+     - runtime
+     - Set the factor for the exponential moving average used for phase offset
+       reporting. The DPLL phase measurement block applies this value in the
+       following formula:
+
+       .. math::
+          curr\_avg = prev\_avg * \frac{2^N-1}{2^N} + new\_val * \frac{1}{2^N}
+
+       where `curr_avg` is the current phase offset, `prev_avg` is the previous
+       phase offset, and `new_val` is currently measured phase offset.
+
+       New measurements are taken approximately 40 Hz or at the frequency of
+       the reference, whichever is lower.
+
+       The default value of this parameter is 2, and the supported range of
+       values is <0, 15>, where a value 0 effectively disables averaging.
 
 Info versions
 =============
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7ebcfc5ec1f09..4f6395372f0eb 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -915,7 +915,8 @@ zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev, int num_channels)
 
 	/* Setup phase measurement averaging factor */
 	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
-	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
+	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR,
+				     zldev->phase_avg_factor);
 
 	/* Enable DPLL measurement block */
 	dpll_meas_ctrl |= ZL_DPLL_MEAS_CTRL_EN;
@@ -991,6 +992,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	 */
 	zldev->clock_id = get_random_u64();
 
+	/* Default phase offset averaging factor */
+	zldev->phase_avg_factor = 3;
+
 	/* Initialize mutex for operations where multiple reads, writes
 	 * and/or polls are required to be done atomically.
 	 */
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 71af2c8001109..289d09fcc5c5a 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -67,19 +67,19 @@ struct zl3073x_synth {
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
- * @clock_id: clock id of the device
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
  * @dplls: list of DPLLs
  * @kworker: thread for periodic work
  * @work: periodic work
+ * @clock_id: clock id of the device
+ * @phase_avg_factor: phase offset measurement averaging factor
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
-	u64			clock_id;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -92,6 +92,10 @@ struct zl3073x_dev {
 	/* Monitor */
 	struct kthread_worker		*kworker;
 	struct kthread_delayed_work	work;
+
+	/* Devlink parameters */
+	u64			clock_id;
+	u8			phase_avg_factor;
 };
 
 struct zl3073x_chip_info {
diff --git a/drivers/dpll/zl3073x/devlink.c b/drivers/dpll/zl3073x/devlink.c
index 7e7fe726ee37a..fe8333a2ea1ee 100644
--- a/drivers/dpll/zl3073x/devlink.c
+++ b/drivers/dpll/zl3073x/devlink.c
@@ -195,10 +195,71 @@ zl3073x_devlink_param_clock_id_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+static int
+zl3073x_devlink_param_phase_avg_factor_get(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+
+	/* Convert the value to actual factor value */
+	ctx->val.vu8 = (zldev->phase_avg_factor - 1) & 0x0f;
+
+	return 0;
+}
+
+static int
+zl3073x_devlink_param_phase_avg_factor_set(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dev *zldev = devlink_priv(devlink);
+	u8 avg_factor, dpll_meas_ctrl;
+	int rc;
+
+	/* Read DPLL phase measurement control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Convert requested factor to register value */
+	avg_factor = (ctx->val.vu8 + 1) & 0x0f;
+
+	/* Update phase measurement control register */
+	dpll_meas_ctrl &= ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
+	dpll_meas_ctrl |= FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, avg_factor);
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
+	if (rc)
+		return rc;
+
+	/* Save the new factor */
+	zldev->phase_avg_factor = avg_factor;
+
+	return 0;
+}
+
+static int
+zl3073x_devlink_param_phase_avg_factor_validate(struct devlink *devlink, u32 id,
+						union devlink_param_value val,
+						struct netlink_ext_ack *extack)
+{
+	return (val.vu8 < 16) ? 0 : -EINVAL;
+}
+
+enum zl3073x_dl_param_id {
+	ZL3073X_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	ZL3073X_DEVLINK_PARAM_ID_PHASE_OFFSET_AVG_FACTOR,
+};
+
 static const struct devlink_param zl3073x_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(CLOCK_ID, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
 			      NULL, NULL,
 			      zl3073x_devlink_param_clock_id_validate),
+	DEVLINK_PARAM_DRIVER(ZL3073X_DEVLINK_PARAM_ID_PHASE_OFFSET_AVG_FACTOR,
+			     "phase_offset_avg_factor", DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     zl3073x_devlink_param_phase_avg_factor_get,
+			     zl3073x_devlink_param_phase_avg_factor_set,
+			     zl3073x_devlink_param_phase_avg_factor_validate),
 };
 
 static void
-- 
2.49.1


