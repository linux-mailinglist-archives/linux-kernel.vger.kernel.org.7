Return-Path: <linux-kernel+bounces-749721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D99B15218
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B357B0947
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954429898D;
	Tue, 29 Jul 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LfVXuYoh"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47B64A0C;
	Tue, 29 Jul 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810334; cv=none; b=FbMbd1WwIue/tlJLa6oXrSiCop4Lwna4Mps+F6EB0pGGVo7xRQul6iY+ea/CMFXyAoMxUOya7qy9xPPjOT6HlUUlFI8CjS9cL1IIQu67hIdNGJxmPPFj2DwH+jNK5fO3WV61QasLaXAClEWzaVIyz0HRXeR4jQ9A7P6PeS65Bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810334; c=relaxed/simple;
	bh=rB28K/zY6w1+YLKV+1vmwxb40ckJ/zgtUeMbnfJcj28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mzgfOvUCRRPNhX6MZwxzc7rGmm57aH3TD2TEo/bd/bEVWJaBIGKSVK9WeUmfrdNBVG44DuQW3Y+f6NVtPTVx6l/fGGFX3Q0oQDq6ZISY+RKLPVTPURmgg+VJO87JeBayCRlIK8KXtCaFglUQJrjfHkDuO5oL4TH6nz0wXfFY71w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LfVXuYoh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753810329;
	bh=rB28K/zY6w1+YLKV+1vmwxb40ckJ/zgtUeMbnfJcj28=;
	h=From:Subject:Date:To:Cc:From;
	b=LfVXuYohaqvqByeG9V2l1E4OR/g4CE79YxGp3B6vJmpMAGnF/H+tcXh9HYkv3Srvz
	 6SluH3N5QRLbxMaWQIVAec8bMO4AcxmoPAJlgvXozfO1f8gtC+DlyGW80eVvm8at7p
	 H+1LNlTr79a4xA5gGpCB3vxBhG4JCvIMmqSiM6mqKfFKFIr41rk2Mh+QdFw5xJ7DlK
	 NIskiZVYb8hCJEjZ2BAViLf+1I5cnziiZSMMKe0wjR8Kx+ng9rzGvZrStyr9jjmkCB
	 IqpP7BNtKTsHUPF9Q1eHzCuhBGuIppVSVVn8OYCRnwEd4uCeCTLgkm78izB3qs2brf
	 EAp1N+MItD9Vw==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 97BC117E130E;
	Tue, 29 Jul 2025 19:32:07 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/2] rust: regulator: relax a few constraints on
 Regulator<T>
Date: Tue, 29 Jul 2025 14:31:39 -0300
Message-Id: <20250729-regulator-send-sync-v1-0-8bcbd546b940@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsFiWgC/x3MSwqAMAwA0atI1ga0+EGvIi5Km2pAqiQqinh3i
 8u3mHlASZgU+uwBoZOV15hQ5hm42caJkH0ymMLURWs6FJqOxe6roFL0qHd02FW+sq1tSgoBUrk
 JBb7+6zC+7wdbW68aZQAAAA==
X-Change-ID: 20250729-regulator-send-sync-94d4a7a61eff
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

This series implement two related changes to address a bit of an oversight
on my end on the initial patch for the Regulator abstraction. Note that
this is not a fix, as it just relaxes the constraints on the previous code
as it is safe to do so.

Patch 1 removes some needless &mut self for functions that already provide
their own locking on the C side.

Patch 2 implements Send and Sync. In particular, there is no reason for
Regulator<T> not to be Send, and as discussed above, it is naturally Sync.

This is based on linux-next for now, I am waiting for 6.17-rc1 to be out in
order to rebase.

---
Daniel Almeida (2):
      rust: regulator: remove needless &mut from member functions
      rust: regulator: implement Send and Sync for Regulator<T>

 rust/kernel/regulator.rs | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)
---
base-commit: 54efec8782214652b331c50646013f8526570e8d
change-id: 20250729-regulator-send-sync-94d4a7a61eff

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


