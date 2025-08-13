Return-Path: <linux-kernel+bounces-767624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DAB256EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B573AC19E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FB2FE044;
	Wed, 13 Aug 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBCjQYjl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870252FD7D2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124985; cv=none; b=ZmdChDV+CmWW9TLIn+tA/YwLMA8SEUTehO266nupGsDrEOg6+1d1D4giNtYLieHYxQ1aScZVFL/FDR/UTwA1K4A3bjfgalwW2foF/CLthGNAYtfM4CiyW9TDtPwN4eBjSzytY0sOil5Ac0VNzVcFz8hiDKw4Y6ajChVirlbMnis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124985; c=relaxed/simple;
	bh=qlwaWio57GqLMA9Fb4mvAHFlhGAkvsC98uuNEQObk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuGO/wVgXmn+CV4SR5e7ovcFNy8Vkm2d71bXY6h0ygxGKy0utxEgjVkwTSNLNjxqWzqSAhRUVqHL7JD/jBPPZ4hKOSffjl1/wwwcp0betEdhHOvwGuibrTXyQwP8P6uw35ro+WasiNgFYiQ1wwbjsTv9mooGKlgSgT3fwlTpSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBCjQYjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755124983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLWwbEpsyDLokTeeRPGfQvr4ehtZaUWiSPjkeJIZb9w=;
	b=JBCjQYjlDLFsv5SINuRhDq4eCgkhwBFa35KeEATOqTumg6LxlFD63ZG6i12f+VkiekgCMl
	1rhqzXjiEgy5vO1kRCB6pOmlw8g9Q/XVSyHCgoVumNsicUg9YiyZJ2A0Ujxfli13hcxqLJ
	c0y/iInMtFbsv1WnfNFx1nyrzuQOdzM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-32bRiNvjOumdIDxS9T09RQ-1; Wed,
 13 Aug 2025 18:42:59 -0400
X-MC-Unique: 32bRiNvjOumdIDxS9T09RQ-1
X-Mimecast-MFC-AGG-ID: 32bRiNvjOumdIDxS9T09RQ_1755124976
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89185180034B;
	Wed, 13 Aug 2025 22:42:56 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70FD030001A1;
	Wed, 13 Aug 2025 22:42:52 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 1/7] rust: hrtimer: Document the return value for HrTimerHandle::cancel()
Date: Wed, 13 Aug 2025 18:42:16 -0400
Message-ID: <20250813224240.3799325-2-lyude@redhat.com>
In-Reply-To: <20250813224240.3799325-1-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Just a drive-by fix I noticed: we don't actually document what the return
value from cancel() does, so do that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V4:
* Reword to "Returns `true` if the timer was running."

 rust/kernel/time/hrtimer.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 144e3b57cc780..6bfc0223f4f57 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -324,6 +324,8 @@ pub unsafe trait HrTimerHandle {
     /// Note that the timer might be started by a concurrent start operation. If
     /// so, the timer might not be in the **stopped** state when this function
     /// returns.
+    ///
+    /// Returns `true` if the timer was running.
     fn cancel(&mut self) -> bool;
 }
 
-- 
2.50.0


