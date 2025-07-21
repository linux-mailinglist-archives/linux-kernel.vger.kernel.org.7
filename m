Return-Path: <linux-kernel+bounces-739056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D6DB0C11E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F443A4A24
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068428DEE7;
	Mon, 21 Jul 2025 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iP+j2Dee"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A428DB7B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092964; cv=none; b=oXf+w9xvFjClSvlpH28sk+WQmKacd00D4vJl3AopyQF6Q0Mo7Dj4Bu2BTSEnc1sDBPujJlUyRYnkE+qQI/dKhPWiXJuVIgEjpK4fH+QRoUrccpXW2UKvd9/y40TCbFXpXGU4ocVHAXaxwoddo3BOTaWaOhJOr0OpxnpSPeuus14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092964; c=relaxed/simple;
	bh=JS1nklxjkM4f9lgybWe3r1PHCL3nq+jC2DMBEleHZw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB71yC8shIL4d7XF0Ra5RR89Kuos0SSIuGsqzgFIzuBfPEWF4olHtCH6pdSgo5B46Xy5aO5q6XKcY5IvUtfXJkr/i+qMmTgIr2wclT2Oalc+IZnuWYl/NnY6qpLTt8L+WeVTIikGFn2+ihN80u6WUGgxfFLRYjt6bW4vm0qy7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iP+j2Dee; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YL+xG3o57AdS7FU6xOB3eOBLgq+9jizJi10GGiZLccw=;
	b=iP+j2DeeyX4E4i1swNrL8g8d9YfBMRvbP3Alr+I3Ai3RbMXEanVFtDxAJlzTjw5kKqYdlp
	Oe6I15eFef4A8R9J1QPp9pOqi4yiY26RfVAYJlxn5dgq5DBjuMwOq3b35fuLiG3Irzlfmd
	C1i4Y+8QQWTPkAGIIfTZjaE/WGeGtck=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-SB9v8FDfOBmCrgPEQqhE6Q-1; Mon,
 21 Jul 2025 06:15:59 -0400
X-MC-Unique: SB9v8FDfOBmCrgPEQqhE6Q-1
X-Mimecast-MFC-AGG-ID: SB9v8FDfOBmCrgPEQqhE6Q_1753092958
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D10E919560AD;
	Mon, 21 Jul 2025 10:15:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9003C180170E;
	Mon, 21 Jul 2025 10:15:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-spdx@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] LICENSES: Replace the obsolete address of the FSF in the GFDL-1.2
Date: Mon, 21 Jul 2025 12:15:37 +0200
Message-ID: <20250721101537.276552-7-thuth@redhat.com>
In-Reply-To: <20250721101537.276552-1-thuth@redhat.com>
References: <20250721101537.276552-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

From: Thomas Huth <thuth@redhat.com>

The FSF does not reside in the Franklin street anymore. Let's update
the address with the link to their website, as suggested in the latest
revisions of their GFDL-1.2 license:
https://www.gnu.org/licenses/old-licenses/fdl-1.2.txt

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 LICENSES/deprecated/GFDL-1.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/LICENSES/deprecated/GFDL-1.2 b/LICENSES/deprecated/GFDL-1.2
index b97e99a11d370..5e8fff04af056 100644
--- a/LICENSES/deprecated/GFDL-1.2
+++ b/LICENSES/deprecated/GFDL-1.2
@@ -23,7 +23,7 @@ License-Text:
 
 
  Copyright (C) 2000,2001,2002  Free Software Foundation, Inc.
-     51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+     <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-- 
2.50.0


