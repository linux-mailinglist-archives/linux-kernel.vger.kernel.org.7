Return-Path: <linux-kernel+bounces-727021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D266BB01402
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A71C3A9002
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3EF1E7C32;
	Fri, 11 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx3bW+Pp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CA1E521E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752217468; cv=none; b=jssITrG8XkB1r46fOjKJag64sqTjFc40zUP6nkV3l2J1NL4OKcUsr7hfa4isX1qdiGO6+RKmca1454p8GjFVF51L+JLFylIBaOtDq9wzeb0jB94RhUBp9Vx1zD0UctF7sQ0wMI9ajsyMqFXXOudcG6KkC5skUVQxhOkcDQHxtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752217468; c=relaxed/simple;
	bh=qY+9hOJvt3smSdifJr60WwKCGN7aBvnCE1D6D2NWtug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBOqhbGgovw74l/WmjWHe8A/x/H0nn/4xjipsUpBMRs0MOimix4Y9tX4TiJfGydntMrlGwVVhQWzGmpVfQSjGE+u/95sudKRbHm30kz9iklRLN5z5MqeStCoX7fni5Sf43DF6aIsFbNq5kZahwhe9HOJGYrbSRImhKDENoUWaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jx3bW+Pp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752217465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9Mb5TKDQZ34m4zy+JEIT+Wrxi+rmT6FW7pNHMJM2OTM=;
	b=Jx3bW+PpevIWkdRaFrb3rWd6upBShXRdMY5cqctFSVaqNrloSkAyVl2czbdZaqP5krvyCw
	5ePfBAdXahRy17w5OfeRsjL0bTfKaPn5dL4/T5vyIoo1qTFrUH1ORX6LA6Y9TK2j6JmQI2
	pcPHCUWsLAL9KfMWkg4kVOiAp6kdakc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-KmRaUBegOLessUeWWwUSwA-1; Fri,
 11 Jul 2025 03:04:21 -0400
X-MC-Unique: KmRaUBegOLessUeWWwUSwA-1
X-Mimecast-MFC-AGG-ID: KmRaUBegOLessUeWWwUSwA_1752217460
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785481956094;
	Fri, 11 Jul 2025 07:04:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.214])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E08C019560A3;
	Fri, 11 Jul 2025 07:04:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id AC55818009DD; Fri, 11 Jul 2025 07:44:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] efi: add API doc entry for ovmf_debug_log
Date: Fri, 11 Jul 2025 07:44:46 +0200
Message-ID: <20250711054446.1537700-1-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Documentation/ABI/testing/sysfs-firmware-efi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
index 5e4d0b27cdfe..927e362d4974 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -36,3 +36,10 @@ Description:	Displays the content of the Runtime Configuration Interface
 		Table version 2 on Dell EMC PowerEdge systems in binary format
 Users:		It is used by Dell EMC OpenManage Server Administrator tool to
 		populate BIOS setup page.
+
+What:		/sys/firmware/efi/ovmf_debug_log
+Date:		July 2025
+Contact:	Gerd Hoffmann <kraxel@redhat.com>, linux-efi@vger.kernel.org
+Description:	Displays the content of the OVMF debug log buffer.  The file is
+		only present in case the firmware supports logging to a memory
+		buffer.
-- 
2.50.1


