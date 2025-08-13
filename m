Return-Path: <linux-kernel+bounces-767162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 625EBB24FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3C91C242BD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E7428850E;
	Wed, 13 Aug 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0jViror"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6319288500
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102595; cv=none; b=FClm74YIb0XMLZeV+DOebCBWfbnoRkqn7GyLDTyA/zdw4ZecfU8TjDDazTlIJNo1HeAo3YMD/kZIXmuqeyzZuCFChd91B3Sj7BE6OlWRAXig3GM1HIWHkfXJENExF5i5qzBIIU1qjGVqsMl/3jd8eWFNhJGt1fjDo8Kby1rqNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102595; c=relaxed/simple;
	bh=9pgg+XdHdToWRzkyCMq3sArw4zfrHrvDzso0Rfa6hKE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kl1y2FPz64TiyXiCL7n4yS4jz0hUX5X3HnWY0+6ldqcaXmIrjPP971XtpD3KQrFGqZspA4SzTLzrl/sXh1BWL88r9n9mH369AdT6VPHMvP1GdfrG2EVe4bv9cbCIrepiYFqUsb0+fGRozvqgMEpY7gIHT6Oi9h8TpzVhDsRO/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W0jViror; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755102592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MEJQ0bA6l6R4bPSBmfr8qps58lLXfFOv0XKCIuYxrZc=;
	b=W0jVirorkwbQAfdDmMHtj+hotwsSbW3/aGDndoing3Yw6L/nDNGv2yr+IX/pxqkBg6hkMa
	SNKGeRhKmvi8GLoT1yX4ebhZAAVP7gWFg4C3k88loubF4UAd6MRpzg3oPGEWMId3id3ozO
	xHo2TxF1FM/g3Di/g7J3NW01R86WBkw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-BnzzmykcNSi4lbg0s_qCcg-1; Wed,
 13 Aug 2025 12:29:47 -0400
X-MC-Unique: BnzzmykcNSi4lbg0s_qCcg-1
X-Mimecast-MFC-AGG-ID: BnzzmykcNSi4lbg0s_qCcg_1755102585
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49ED21955E9D;
	Wed, 13 Aug 2025 16:29:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D6BE4180028F;
	Wed, 13 Aug 2025 16:29:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 13 Aug 2025 18:28:29 +0200 (CEST)
Date: Wed, 13 Aug 2025 18:28:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: PF_USER_WORKERs and shadow stack
Message-ID: <20250813162824.GA15234@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

I know nothing about the shadow stacks, perhaps I missed something obvious.

But it seems that if a features_enabled(ARCH_SHSTK_SHSTK) thread creates a
PF_USER_WORKER thread, shstk_alloc_thread_stack() will allocate the shadow
stack for no reason.

Don't we need something like the "patch" below? PF_USER_WORKERs never return
to userspace. Note also that update_fpu_shstk() won't be called in this case.

Oleg.

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -209,9 +209,15 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	 * is disabled, new_ssp will remain 0, and fpu_clone() will know not to
 	 * update it.
 	 */
-	new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
-	if (IS_ERR_VALUE(new_ssp))
-		return PTR_ERR((void *)new_ssp);
+	if (args->fn) {
+		new_ssp = 0;
+		// clear p->thread -> shstk/features,
+		// reset_thread_features() won't work
+	} else {
+		new_ssp = shstk_alloc_thread_stack(p, clone_flags, args->stack_size);
+		if (IS_ERR_VALUE(new_ssp))
+			return PTR_ERR((void *)new_ssp);
+	}
 
 	fpu_clone(p, clone_flags, args->fn, new_ssp);
 


