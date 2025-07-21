Return-Path: <linux-kernel+bounces-739055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE64B0C11A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6422D540022
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F60428DF33;
	Mon, 21 Jul 2025 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSJPIlOd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608428EA67
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092959; cv=none; b=OW77zCFfm5ZnqPdz9gyOIXcj3dxISiD7i/Jmdpywu9XzNrrgJ7PJx0tIaRXTdT82LhkJ2szdcHBhVUbEvwSZyAs6z+kxXePhifE4b7kN1SmpCY6kH4qkBctR5ILqPNQKJr2cb7mTJ/graWlao3F8wDfalp6HLVpImhU9nY8AvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092959; c=relaxed/simple;
	bh=Xzm4L2rCMTbZETCxaqfrxzTEm+y5HPwHsQ7uZJUkLvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZpoKNJEYQM+Lthvc0JfCyf2RwRyURlvTJfsHJRo21Qdune4ClWiJ6x9ka81DMkxdhcSd35kQCkv4H/kIsFlBLQdY6Pp36lMK/O3T4X/+vQnkK4N9YYAyPpbQlGh4eVnrSNn0UwBCoFxAYdRZRlpXpE4XbSTVqwvyukcnohOeJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSJPIlOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753092957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=chuHxGtw5hxVAMaDl6gbD4Ls68eoG/cRtabCSyBVGiM=;
	b=SSJPIlOdMJMo9i5IGqYI0lX1LQS7Izb/82CiJy0x7EQRtJmFq1Z3MBlRx38wZlCIKpBhHX
	FGeisbtZ+cTMkHetW7of+jJEv6KRqE7nCV02lN0+K7PrIOd51PjcGnXI4QuRQHpsxgKBwO
	mpq2MzWCe8qjkeSTJXU77cJiUJT71Fc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-K7KOLOCLMA-hvPrvne4Axw-1; Mon,
 21 Jul 2025 06:15:56 -0400
X-MC-Unique: K7KOLOCLMA-hvPrvne4Axw-1
X-Mimecast-MFC-AGG-ID: K7KOLOCLMA-hvPrvne4Axw_1753092955
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF9CC195608F;
	Mon, 21 Jul 2025 10:15:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 769F218016F9;
	Mon, 21 Jul 2025 10:15:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-spdx@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] LICENSES: Replace the obsolete address of the FSF in the GFDL-1.1
Date: Mon, 21 Jul 2025 12:15:36 +0200
Message-ID: <20250721101537.276552-6-thuth@redhat.com>
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
revisions of their GFDL-1.1 license:
https://www.gnu.org/licenses/old-licenses/fdl-1.1.txt

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 LICENSES/deprecated/GFDL-1.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/LICENSES/deprecated/GFDL-1.1 b/LICENSES/deprecated/GFDL-1.1
index ae62699ab62c3..d7a524f602a47 100644
--- a/LICENSES/deprecated/GFDL-1.1
+++ b/LICENSES/deprecated/GFDL-1.1
@@ -24,7 +24,7 @@ License-Text:
                    Version 1.1, March 2000
 
  Copyright (C) 2000  Free Software Foundation, Inc.
-     51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+     <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
-- 
2.50.0


