Return-Path: <linux-kernel+bounces-890033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04558C3F1CF
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367744EA4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527DB2C08C4;
	Fri,  7 Nov 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq5iWyfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E729B766;
	Fri,  7 Nov 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506984; cv=none; b=EKjX+mMrFvUyPggH+gsWRFOLxOO5BePrsAcw+dS7un0RwR2f/efoUmL84I5MZAV07p2HvcUKyJUHzU/IzR2xgDsYXULDLG/SxzndFMS/u9fAQfptjpu3ClO2UYwCg4ATFtRrfpkWcNJ4Hj5xivg6lku9fG2Ma9jJ18z3KX7pFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506984; c=relaxed/simple;
	bh=UoVXo6tHQ4cj6zburWizTCb9MMH3tgvgojutIuhcmgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBczASudgn+sPoItQFqpjapjhiTHFF85LVSnEkitpj07KBYAh88heaiO7xzn8hlP//EA6XL1X2vrOpSBZBoD6RWH/ZGvltIYieXTLZ5lIH4aXK/LZIAEtRKXO6OQf8iReXyBie7HOZwCLjCDVhDTwkMwCquB4ZQQG9l/bWbhPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq5iWyfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5FEC113D0;
	Fri,  7 Nov 2025 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762506984;
	bh=UoVXo6tHQ4cj6zburWizTCb9MMH3tgvgojutIuhcmgw=;
	h=From:To:Cc:Subject:Date:From;
	b=Aq5iWyfOvyqt3g3Otl1TKV+WSlmEBL52L4KhpuIYSa5amVJwSr+tUdtiKfRKP6u7k
	 Y4v2Qo07UPWi+lcWa444zwQg4JB/97yjIpuLaF9JNGeys+R/rfzigW0dlCdHzJnd1z
	 labdTroq+8paujj+uRG6uDqYopBSzEwF/0xesL0swxFDZJ5T7uiN3rvgABJb4M6nOp
	 6bv2bsT5HwuMDMua88Y1mQtDYifDwL6qXmf1xCMCdMZAsPCCLCpaiV9IGKI9awuatp
	 zZc1giFGKE1rbbf0SiTGvcz9x9usadrlX59mN/QTZaClogzC4CMjm+80BcTF0GAbgv
	 bSkL+n45+oP6g==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] rust: debugfs: Implement BinaryReader for Mutex<T> only when T is Unpin
Date: Fri,  7 Nov 2025 10:16:07 +0100
Message-ID: <20251107091612.2557480-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit da123f0ee40f ("rust: lock: guard: Add T: Unpin bound to
DerefMut") from tip/master adds an Unpin bound to T for Mutex<T>, hence
also restrict the implementation of BinaryReader for Mutex<T>
accordingly.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251107134144.117905bd@canb.auug.org.au/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/debugfs/traits.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/debugfs/traits.rs b/rust/kernel/debugfs/traits.rs
index 2c32ddf9826f..82441ac8adaa 100644
--- a/rust/kernel/debugfs/traits.rs
+++ b/rust/kernel/debugfs/traits.rs
@@ -257,7 +257,7 @@ fn read_from_slice(
 }
 
 // Delegate for `Mutex<T>`: Support a `T` with an outer `Mutex`.
-impl<T: BinaryReaderMut> BinaryReader for Mutex<T> {
+impl<T: BinaryReaderMut + Unpin> BinaryReader for Mutex<T> {
     fn read_from_slice(
         &self,
         reader: &mut UserSliceReader,
-- 
2.51.0


