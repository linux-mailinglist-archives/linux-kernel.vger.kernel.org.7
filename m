Return-Path: <linux-kernel+bounces-879521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B8C234CE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C94A3AB031
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1982D838F;
	Fri, 31 Oct 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZPYWDvO9"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E25C802
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889338; cv=none; b=iZNS9oV0M7cbhYIzt/4nuluybyw8wlgROqw4uHiBwsHH1KohNFyqt4/tnpDeZfmS/LMX9cSf3JW2BFylBz58kjsUAvDw7PwqIGKicl85KI6UqtAachuNT4E/ex+w5JhtLebXoqLvtzO+SpW6s+H9O8ocvIz1ZqKws8ndDYKvCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889338; c=relaxed/simple;
	bh=y+N0one3SjRuMzQ1dXbngvWuMTGERzN918iiEvMwJ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBB4bbQlxayL4V93RX+ri8lL4k/FlGyHnAJoucP6kFaFQwW/EtNlhA/TUx7QqE47IeTIyAe+VPngRsrAbC8AbiuyQIwhi7FP9BpBOHSEVTkxPcRgPCc/2TadDoQ+qLvV6sj9KIO95quvYvAbL6KnY0rs1gujfmniN33c95q9Dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZPYWDvO9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TQqZIJeP5CSn33TdVIECa+JUYfZiL7DOjcre99nFWVs=; b=ZPYWDvO9Wp2iWV8PUDok0hPuRf
	JrGa1m6p45JDOaNW5hx4i9HIiGUxj+ty99xqptOjAU/Gz58Ir7FEWHuw+4SZCPvhqKsGykDt0Yvz5
	lRuTEcIF17DfAOmTM4boQW5B71M05Afl06+wzCUQa3zKlzfwNZ/dg2E65exbN0guXtU2gCiDCFHTZ
	lCAAe/GX7QithuP1Ui88BorUX0l1EZnpXRNPgAQLNtNsYr7rKyjKrGV+0ONkNIyQ5cq6PmGLKu80r
	Tt5v5hTVE0RiFfw8yMQ7QoM+x09c5691JzlyDGsoz+XgVi7+7ZQsD6fhnO0V7RLhNwO+7SfRoaReI
	VoH/4SLw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEhts-00000005QDD-27k0;
	Fri, 31 Oct 2025 05:42:12 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	James Clark <james.clark@arm.com>,
	Tao Zhang <quic_taozha@quicinc.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org
Subject: [PATCH] coresight: coresight.h: add '*' to kernel-doc lines
Date: Thu, 30 Oct 2025 22:42:11 -0700
Message-ID: <20251031054211.1411151-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc reports 2 (kernel-doc) lines in coresight.h that don't have
a beginning '*' in them, so fix these lines.

Warning: include/linux/coresight.h:173 bad line:
   connected to @src_port. NULL until the device is created
Warning: include/linux/coresight.h:177 bad line:
   needs to be filtered.

Fixes: ec9903d6cc34 ("coresight: Add support for trace filtering by source")
Fixes: d49c9cf15f89 ("coresight: Rename connection members to make the direction explicit")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: James Clark <james.clark@arm.com>
Cc: Tao Zhang <quic_taozha@quicinc.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
---
 include/linux/coresight.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20251016.orig/include/linux/coresight.h
+++ linux-next-20251016/include/linux/coresight.h
@@ -171,11 +171,11 @@ struct coresight_desc {
  * @dest_port:	destination's input port number @src_port is connected to.
  * @dest_fwnode: destination component's fwnode handle.
  * @dest_dev:	a @coresight_device representation of the component
-		connected to @src_port. NULL until the device is created
+ *		connected to @src_port. NULL until the device is created
  * @link: Representation of the connection as a sysfs link.
  * @filter_src_fwnode: filter source component's fwnode handle.
  * @filter_src_dev: a @coresight_device representation of the component that
-		needs to be filtered.
+ *		needs to be filtered.
  *
  * The full connection structure looks like this, where in_conns store
  * references to same connection as the source device's out_conns.

