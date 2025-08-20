Return-Path: <linux-kernel+bounces-776975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E3B2D3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99E881C414E3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697EA2C08C4;
	Wed, 20 Aug 2025 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HR6ocByz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7DA2BCF43
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668222; cv=none; b=KWhNKBqRZMQ6yqsSdfhWFv+ipDVxcflpjPtC1fUEawn5lzHiuG3FCaK6qs2l1H+9sl/HveMN8euZuEQj5wQPfujsz/Rm/k109wbo41WxERQs2xKZ/cBgwzqGTypsx33ywytj6R63dkM89ScuAKXg0gVp7Ea83jGJdp2R1pMBGtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668222; c=relaxed/simple;
	bh=3Xdhe4bRu39GQie2dQ0RZhJ0QOGO3XdwESK139d067Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=JdVsUN0LNadVDocA+KkrXjV/oAIVvLkD/cX1UCd9Ug2wM43Ek/eqae/Ag569o1C1ZOh0X6sxjF4zGOWimolUIKU2+rckYZnz8EMba5o8Y9TuPgB/aOmDVgk/ptQF5fvdROrkY4R/moYPqGS9qomoAHiMvqJjMVhm+JjTGoWmK30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HR6ocByz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z1K+NrhffiuczGQxxvXLPTT8safjMr4ane+44BSMgbw=;
	b=HR6ocByz7mw4F8A3NwodU+qxiioDXqR8oSQ1Umtfp+E5Vw4+b9dd+ksDTPkrXZacS3kPgL
	eek0BdaqzpVQwvgyO4Osld6GpNEWupdpH1HfQOgV1y4l+mMtd8kouOkzldsjznPx+RS2y2
	jLdMuVBkMC7n9iw4Ic3Gc+M11HObT1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-FM4T_kMAMBejUgJcViqkcg-1; Wed,
 20 Aug 2025 01:36:56 -0400
X-MC-Unique: FM4T_kMAMBejUgJcViqkcg-1
X-Mimecast-MFC-AGG-ID: FM4T_kMAMBejUgJcViqkcg_1755668214
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62A951800366;
	Wed, 20 Aug 2025 05:36:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1826D19560B0;
	Wed, 20 Aug 2025 05:36:45 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-um@lists.infradead.org
Subject: [PATCH v3 11/12] arch/um: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:58 +0800
Message-ID: <20250820053459.164825-12-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

And also add code to enable kasan_flag_enabled, this is for later
usage. Since kasan_init() is called before main(), enabling
kasan_flag_enabled is done in arch_mm_preinit() which is after
jump_label_init() invocation.

And also do the kasan_arg_disabled chekcing before kasan_flag_enabled
enabling to make sure kernel parameter kasan=on|off has been parsed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-um@lists.infradead.org
---
 arch/um/kernel/mem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..7b7f838274b5 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -58,6 +58,13 @@ static unsigned long brk_end;
 
 void __init arch_mm_preinit(void)
 {
+
+#ifdef CONFIG_KASAN
+	/* Safe to call after jump_label_init(). Enables KASAN. */
+	if (!kasan_arg_disabled)
+		static_branch_enable(&kasan_flag_enabled);
+#endif
+
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
-- 
2.41.0


