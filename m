Return-Path: <linux-kernel+bounces-775537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D3FB2C058
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E19F1793FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A332A3E9;
	Tue, 19 Aug 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOJZXM7Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32B284887;
	Tue, 19 Aug 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602733; cv=none; b=eKzeM3OsVCrIwPxXZpuWeJ8WTajudO4cRG7P+wNEAHbdlww4UqAp6rGmQQfAuzWi+qjKpwxmNZJsWRy6XpxvWIg/4PUkBphntPnOqPhUyTWS38nYMFNaKu8xemNKlRNz1DOaWUnMwaZFFGBBal52UNpCUiJ5msn9XeDt47KFp1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602733; c=relaxed/simple;
	bh=HIXNH+k5AYwL7MBbX/jTRB7KMiNH0ypU7X81zMRc7/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r0YUNXh14tpd/Co5/ecU/xs8Xibe5FjZdU3XQOP6h/4uJDvp/SQ/fy253Z+JeViFtQ4cAnlS0QtJy0OUTHGfZXqWxv8vLAODhyNBQPd6CqEWruelr1WSBUp+wo2VNSlR8RP9vRIx0LzArZxG3aMb3e7m+E0sa1V3LRKHhByEdnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOJZXM7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9357C4CEF1;
	Tue, 19 Aug 2025 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602733;
	bh=HIXNH+k5AYwL7MBbX/jTRB7KMiNH0ypU7X81zMRc7/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOJZXM7QOyUckMMZmhpT7H577pr6tIlsT6NJwblLGkvhIxsGflcWGEtn1ChoCRiIK
	 GuuK9Lr1DcjyAT840Lsg9QDcE+cI90V60ounOKRCfjcj3WHDmzNNdhVhIfSmPxn1hh
	 9FhYEFOpEWnhEuj7XGto3aU3zRyqMMmh+a2sm7dKNDpeQuNguZVE4Y7t/UG+Jnyxza
	 j3limtbV/E8fNTIiGtiL1vSIBts167rAw+hHPx0cfqsLwdzyKjNNXquxwnkGhSO4d3
	 mwhlA0FiNSnG3XLKZVVJ3bbE37oGAAuih9BPNTwqWK7bQCPTc0jvijTbLyEUgL2MQW
	 qwOetGRKhSGyQ==
From: Christian Brauner <brauner@kernel.org>
To: Shankari Anand <shankari.ak0208@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
Date: Tue, 19 Aug 2025 13:25:18 +0200
Message-ID: <20250819-abgegangen-verfassen-0324c7d8909a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814100101.304408-1-shankari.ak0208@gmail.com>
References: <20250814100101.304408-1-shankari.ak0208@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1084; i=brauner@kernel.org; h=from:subject:message-id; bh=HIXNH+k5AYwL7MBbX/jTRB7KMiNH0ypU7X81zMRc7/E=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsiVeLMPNXa1AQvnLBYtGnzMPxUyW9OZe8iC4xPPlmD 89hif1uHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZOYHhf+63qVc8HyTfeGOu Yjvrt+8qsY5P81Ne3ntwQ/pSZNSqKW8ZGaa5+hXc3WUatuen765K3cwJz1aEpLyQDKs0dT8d3p3 0kAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 15:31:01 +0530, Shankari Anand wrote:
> Update call sites in the fs subsystem to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
> 
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
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

[1/1] rust: fs: update ARef and AlwaysRefCounted imports from sync::aref
      https://git.kernel.org/vfs/vfs/c/eed8e4c07d85

