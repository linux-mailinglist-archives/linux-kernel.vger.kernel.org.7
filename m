Return-Path: <linux-kernel+bounces-775502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F01B2BFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C3E584FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD62326D73;
	Tue, 19 Aug 2025 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjHkBGli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D739221F1A;
	Tue, 19 Aug 2025 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601751; cv=none; b=Fg5gqaO4mnpm3TOMf8RgJ/xZJNTzJ8bQv+6Od4h40AJzN8bFVMRbJN4LVHYuq9Jzk3z+jPdITYNTejwXTPQp5gi967aOcMz7rqVHCmMdq3GP0DXXXZNicS9CSmVE1+0dq5O3iQgGK9a/RfYBS7KdLyb7wfskMXalbHgOAG0mNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601751; c=relaxed/simple;
	bh=8NtuBq063GO60AEo105UcaVtSomxlnSvCNm3SCOj9DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fHZxj4O/L/ucc7pimB1rLTSzDvbTqx1SKlJ3NLxqdOlOaDwuJZh5h8YSePwfDCHMETowQfQt4XsMRycvURdB8AI0V0rrc6rqhHr0OrE0l68P1wcsxG7DJod24YD96JkJL/8n0nHkdWGJsvmUTrrlUHCoHxvxnqF4yA7O+uqi4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjHkBGli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACA1C4CEF1;
	Tue, 19 Aug 2025 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601751;
	bh=8NtuBq063GO60AEo105UcaVtSomxlnSvCNm3SCOj9DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IjHkBGliNAw+fv3Zw/Vf3HhL0XDYo9Kttfc5flpuX9j84WieGUeTyQhxZmekxA8CR
	 FRjJ1JNtS/hwR6dMXAgZH6qY/502YzMyOs1q+00f5KsSadBGWiyCwK7hp3i6NK1XBv
	 UUBm1+cB0Ac8B9iHZk3KvDSOhcFBpKsskL8FvM3s4nbCTN615IWFf3Ffwtg6TOjL7j
	 gS6/cN54RAN1JNyWQ2dcEOOX/pG2LM7TXi4XSPt3XqOZGeByIGOFGSOFofh+N1YxjC
	 mA/6eWnOA4dPl1urW6Nql6Xi5/7iHG4q8M5DIElaEvQsBpL4GB11LdURAJQ1Rq41Qh
	 6sK8j24ibt9ow==
From: Christian Brauner <brauner@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Shankari Anand <shankari.ak0208@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pid_namespace: update AlwaysRefCounted imports from sync::aref
Date: Tue, 19 Aug 2025 13:09:03 +0200
Message-ID: <20250819-pulsschlag-panne-96f1798c7fc0@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816122323.11657-1-shankari.ak0208@gmail.com>
References: <20250816122323.11657-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=brauner@kernel.org; h=from:subject:message-id; bh=8NtuBq063GO60AEo105UcaVtSomxlnSvCNm3SCOj9DA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsiQ6IqPyU/FMjuuHS39NdRZ8Z10hczfIKk36m8i0ka N7umSKnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyipnhf1xqlR5n81Xxglzt TlufWX5rZvjwxPt1R+SIsNgqcvtKMjI8lbDUvtykdevRrdw/dwvcsqZ8nKF+X/7jNGvtOfenLQ7 gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 17:53:23 +0530, Shankari Anand wrote:
> Update call sites in `pid_namespace.rs` to import
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to `sync`.
> 
> 
> [...]

Applied to the vfs-6.18.rust branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.rust branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.rust

[1/1] rust: pid_namespace: update AlwaysRefCounted imports from sync::aref
      https://git.kernel.org/vfs/vfs/c/bba954120642

