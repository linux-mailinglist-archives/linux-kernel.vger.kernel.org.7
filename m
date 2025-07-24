Return-Path: <linux-kernel+bounces-744820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72AB1113F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B5C3B95DC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE0B2ECEA0;
	Thu, 24 Jul 2025 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMutJ1Ss"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5523F41F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383443; cv=none; b=tBe2GNlyOpLvtTOLwjSclDE46pqzOTbdI72t7wzP5MMn7weZOhqfzVWckEAn05inipdd9TuZVxaB9i3u38osjhZHPNAkEmDkDdJUBR9fUSg7LB3t72LLzDmrLGBsF6ZASI6e+xdiCf6k062C/n1WPxSs33yNTgiCQfrVg1uz+p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383443; c=relaxed/simple;
	bh=n4kt9r4mEclx1NN9F8/S4ryqbdZwsApz1DAl59dkNP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIpvpSt92+ZMLbErDBECEaJ1ek03OzMlngfOtuxuBJbTU05nDL5pMBsv2rMs/h4dbZExhmDp7nqWwe17CXEXpgQBNjJKrH3fHo6azHzKekrjvi5BCU24dARvMX9YQrxCEXY/lZmrAp1R69o30hHf7FieQdq7h4FpLeEM3gM1eNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMutJ1Ss; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GwsSb605ckTPK8iuLovIMbfX8h9jkGkILDlWm/zGsjU=;
	b=eMutJ1Ss8RBaq71XgmMMelNKcOG3twwD1Kqsoh+FjniMsfWd1kQqaAvp5l6HJqorR985ed
	Zczm+zsezUCNeXQ7jhKQtmOy815sZzSElTSktWBkK036Y6G8+WinpgLJtDplyN2gP4fB1R
	UficQr8ui0u5mEXZc3Wiv+DQQQIIB7Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-f8jrWir-MLqcdypW4K-vNw-1; Thu,
 24 Jul 2025 14:57:13 -0400
X-MC-Unique: f8jrWir-MLqcdypW4K-vNw-1
X-Mimecast-MFC-AGG-ID: f8jrWir-MLqcdypW4K-vNw_1753383430
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F8E19560B0;
	Thu, 24 Jul 2025 18:57:10 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62934195608D;
	Thu, 24 Jul 2025 18:57:07 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/2] Arithmetic ops for Instant/Delta
Date: Thu, 24 Jul 2025 14:54:05 -0400
Message-ID: <20250724185700.557505-1-lyude@redhat.com>
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

Lyude Paul (2):
  rust: time: Implement Add<Delta>/Sub<Delta> for Instant
  rust: time: Implement basic arithmetic operations for Delta

 rust/kernel/time.rs | 115 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)


base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
-- 
2.50.0


