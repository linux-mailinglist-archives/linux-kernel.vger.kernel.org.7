Return-Path: <linux-kernel+bounces-615261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F1A97AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63625A1AF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C102D1916;
	Tue, 22 Apr 2025 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXRLktWD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A981D63DF
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363148; cv=none; b=B+8SyLbEau6ITDIrcNZr27rWEatIWgBvlkEsTtzvuRUeOMjAnsgfiUW4pdLPVrjHYkXD9MO4wRf8A+TRfKDbd0fQ+rMY2gsXs/3piXOVlkYUcnGJTRfor5OtnfkxA7lED7bRw2XUfV/EtaYW3RvwfHVSdg8UVFXzUE6N8oUxhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363148; c=relaxed/simple;
	bh=irEw6+L+FOASxlUvYZZgJczgjod4d4aOBm/qDTnfY3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SObf8rK1h2uRRhLwoDRdAPxhmimbxdOQsFB7gFjGG3dJ0WkF6mHBgan8EbvD9A2DSj9qsHMjYpveM9rqdeO4Z4xdDPN/EsKmEwnfmZvSNaAfw2fYwgc6MWqm2MgoVyVrLlgjI6cMDKSHnhumvLHyHmuM9dynPxIAtJezzGjK82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXRLktWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745363146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IkY27Gdp5eznLfjbt7qpVQ0OYk/4ucZm/cTdksHi7i8=;
	b=GXRLktWDFJSiQpsC/JoxkZFxX0QeJ3GsMBxFe4JIvMdzHbidC0TdwUtm5T/JgJVHrWc/EN
	V7fycR0iDiXefyp89UJ+QbJxecK0x/Fi80xnJAUTsTcEjhdvP7XqzOwv2DCQ5oqU6rLtk8
	UspKXnblqG5GVdz8J2awuhYpTyRUVbc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-sFOpMImRNl60evbqp62llg-1; Tue,
 22 Apr 2025 19:05:42 -0400
X-MC-Unique: sFOpMImRNl60evbqp62llg-1
X-Mimecast-MFC-AGG-ID: sFOpMImRNl60evbqp62llg_1745363141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94E2C180056F;
	Tue, 22 Apr 2025 23:05:41 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.88.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 283DA18001D7;
	Tue, 22 Apr 2025 23:05:39 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com,
	rafael@kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: runtime: Define pm_runtime_put cleanup helper
Date: Tue, 22 Apr 2025 17:05:31 -0600
Message-ID: <20250422230534.2295291-2-alex.williamson@redhat.com>
In-Reply-To: <20250422230534.2295291-1-alex.williamson@redhat.com>
References: <20250422230534.2295291-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Define a cleanup helper for use with __free to automatically drop the
device usage count when out of scope.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/pm_runtime.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 7fb5a459847e..69d4b2929ee6 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -466,6 +466,8 @@ static inline int pm_runtime_put(struct device *dev)
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
+DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
+
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.
-- 
2.48.1


