Return-Path: <linux-kernel+bounces-778514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BEB2E6BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731C55A562F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A32BDC33;
	Wed, 20 Aug 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR3PgxLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77E28BAB1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722243; cv=none; b=kLEy8gPkdUHhhuZgyHJH3SYiKeJNNGD+9G4sB2OCslKO+p5VUyaMJuiJ7/i+CMPeTZOD9IlSiyU9nD8WrE9YXtKaCGGmCJ0Y1RLhf22CtR1CrrEnOvGDSLzw+Hbbz1kNXmjdxMOrDJUe4S2A0Gtbvi+FTtJuauDBkMiJQdFRO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722243; c=relaxed/simple;
	bh=gtT4OeLfaN09rUrwbjSyPqQAywxnbICgSKzEe6o6/CM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Seh3aqyXcPWM154f0VGNiawen1UMyh77Mh5Wpvam0nYmCMDfLjrCTgk3OY9ousDUggBU2ix4CloCySlQwqA1Y8Jag+r5b9+NqAxTwAhhYyKn2yuQlfeU/rOA1Qei5D3OfkyR+cNUBnXhZifMFNMmMYe4AkY2M4IIlf2GqVpNLyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR3PgxLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755722240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rgl6MUeLJ6GGDLJO4uAP0sSLK/4bOYOpvnv/jxWGeH8=;
	b=LR3PgxLkHDrmMo1HRNdOktRikeQHLufYz7PZcZoHG6PrAlCu8znjYNbS7ezMpQgkEMXps6
	rMYMVXrp+ntlE6SztQTSdhPYONSu4tpfFnOy/cOEZ+1fUBYCcT/EzhwgB6fdAvO4tSCtRI
	0Q2PZVg+411+Ekgdkm5/pyOKtJm32S8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-VfbJ2woMMOa_xUHlJ_Ct9g-1; Wed,
 20 Aug 2025 16:37:17 -0400
X-MC-Unique: VfbJ2woMMOa_xUHlJ_Ct9g-1
X-Mimecast-MFC-AGG-ID: VfbJ2woMMOa_xUHlJ_Ct9g_1755722235
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53235180035F;
	Wed, 20 Aug 2025 20:37:15 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 92CEF19A4CA1;
	Wed, 20 Aug 2025 20:37:11 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 0/2] Arithmetic ops for Instant/Delta
Date: Wed, 20 Aug 2025 16:26:42 -0400
Message-ID: <20250820203704.731588-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When rebasing RVKMS against my hrtimer additions, which themselves were
rebased against Fujita's recent work for introducing Instant/Delta, I
needed to reintroduce the ability to perform some of the arithmetic that
rvkms uses for vblank emulation - so, this commit introduces such
arithmetic.

Example usage:
  https://gitlab.freedesktop.org/lyudess/linux/-/blob/rvkms-slim/drivers/gpu/drm/rvkms/crtc.rs?ref_type=heads#L167

Previous versions:
  Version 1: https://lkml.org/lkml/2025/7/24/1400
  Version 2: https://lkml.org/lkml/2025/8/7/950

Lyude Paul (2):
  rust: time: Implement Add<Delta>/Sub<Delta> for Instant
  rust: time: Implement basic arithmetic operations for Delta

 rust/kernel/time.rs | 141 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

Changelog:
  rust: time: Implement Add<Delta>/Sub<Delta> for Instant
    V2:
    * Change behavior in ops::{Add,Sub}<Delta> so that we panic on overflows
      under the same conditions that arithmetic operations in rust would panic
      by default.
    V3:
    * Don't forget to update the commit message this time!

  rust: time: Implement basic arithmetic operations for Delta
    V2:
    * Don't forget to make sure that we inline all of these
    * Drop ops::Rem and ops::RemAssign implementations for Delta, replace with
      Delta::rem_nanos() instead. It turns out that there's actually no way to
      perform i64 % i64 on 32 bit platforms in the kernel at the moment, the
      closest that we have is div_s64_rem() which only allows a 32 bit divisor.
    * Actually use the kernel arithmetic helpers for division/remainders so
      that this code works on both 32 and 64 bit platforms.
    V3:
    * Change the output type for Div to i64, drop DivAssign
    * Change Mul/MulAssign to accept i64, not another Delta
    * Fix parameter name in rem_nanos (ns -> dividend)

base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.0


