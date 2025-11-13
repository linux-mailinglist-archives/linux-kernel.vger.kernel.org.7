Return-Path: <linux-kernel+bounces-898919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A4C56527
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02AAC4E8566
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655C633469F;
	Thu, 13 Nov 2025 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/tN34Yz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF923314DE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022842; cv=none; b=OLSqoNeM6YbZNx36ScT2KwA6Ih5a5IkyUiNPSzCss2qRSlt1BUi0YMvscQ0M4ADJ5g1X5lh9bWNH67h9453rIPNs8L2XaMKXiB1cjTbJeF/uQuNCGZPfyemS2w2kHuM3AGFfCfo/3iOX32dYIAXakreIq474pshWdX6xaEWJIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022842; c=relaxed/simple;
	bh=GjD9QEs7SzmnvHl3zPU+QeUV23iO3Qc9hI+AkOrFEL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLhgt3+8uYFjiUWH/cfIlLc5DuIvn7QJUfVeEyR1LD1LcNIsYdlf92olpn43G/hJ+4eahrKsY8xW+QiBGRQfSOl1O90mtjwkxG/atrFS57duLIfsDHWuBi8KoEOr478pKmzne9qifofGYJq3HRy+ZMK9Bow9JrMvnylozhNo9p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/tN34Yz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763022839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2+7kEHxFbK67aWdgfs3yD8hYiWGLMLm6j7NkVaF+ig=;
	b=h/tN34YzbBbfEXBdqVqtSxH17T3rdjlzZVU8EkKmI7NMUkX9shbhLAQbMLIVtQKe+AHBrl
	7hqtwAdw/F3ZfqLvzSIVYfDgWeFkMWOl/mRK/IbTjPFvhbnQ3py0qn9HLYSgp4jIIQixYk
	WjjDNLTCIwwRkkyZKiabsGuoCED9trw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-pM7bTzqeNj-IW8FGoFfpiw-1; Thu,
 13 Nov 2025 03:33:55 -0500
X-MC-Unique: pM7bTzqeNj-IW8FGoFfpiw-1
X-Mimecast-MFC-AGG-ID: pM7bTzqeNj-IW8FGoFfpiw_1763022834
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF50C18AB42A;
	Thu, 13 Nov 2025 08:33:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.78])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEAFD1800451;
	Thu, 13 Nov 2025 08:33:50 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v15 6/7] cpumask: Add initialiser to use cleanup helpers
Date: Thu, 13 Nov 2025 09:33:23 +0100
Message-ID: <20251113083324.33490-7-gmonaco@redhat.com>
In-Reply-To: <20251113083324.33490-1-gmonaco@redhat.com>
References: <20251113083324.33490-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Yury Norov <yury.norov@gmail.com>

Now we can simplify a code that allocates cpumasks for local needs.

Automatic variables have to be initialized at declaration, or at least
before any possibility for the logic to return, so that compiler
wouldn't try to call an associate destructor function on a random stack
number.

Because cpumask_var_t, depending on the CPUMASK_OFFSTACK config, is
either a pointer or an array, we have to have a macro for initialization.

So define a CPUMASK_VAR_NULL macro, which allows to init struct cpumask
pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively a
no-op when CPUMASK_OFFSTACK is disabled (initialisation optimised out
with -O2).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce6..68be522449ec 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1005,6 +1005,7 @@ static __always_inline unsigned int cpumask_size(void)
 
 #define this_cpu_cpumask_var_ptr(x)	this_cpu_read(x)
 #define __cpumask_var_read_mostly	__read_mostly
+#define CPUMASK_VAR_NULL		NULL
 
 bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags, int node);
 
@@ -1051,6 +1052,7 @@ static __always_inline bool cpumask_available(cpumask_var_t mask)
 
 #define this_cpu_cpumask_var_ptr(x) this_cpu_ptr(x)
 #define __cpumask_var_read_mostly
+#define CPUMASK_VAR_NULL {}
 
 static __always_inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
 {
-- 
2.51.1


