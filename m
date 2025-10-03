Return-Path: <linux-kernel+bounces-841818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEDABB851B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC56F348E41
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F79E2E8B97;
	Fri,  3 Oct 2025 22:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDw3U4I2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D02E7F27;
	Fri,  3 Oct 2025 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530460; cv=none; b=bwEP3uDByURg2QLcUDMCAo3GVm/NderV31gHLpFUeN7/zyzB5H+fjWLvTIAHV7gjsxFR+vKN2QtSCChrVkrt6umuI8rYplubY9BToZtt6l1c7O5YXIGAdWyfXIgbdgivZu2r9W0LYczXLzVkkBZXmE3eie/txNdbRgd8fgvzSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530460; c=relaxed/simple;
	bh=sA7GiiYNGw0DroJhU5v2cyWMSmIAOSRyumgDzIPC3vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrYCu1VlfvmEbJ2B8Jd5aUBEV65zmHgaTp6NbFd5qrpJjfpmMAwzsbAVbBD+L1QHyfYuWdfacsfpRoxZBe82wBXrNK0lvarm/a8dZRoDLPG9hVeNTusCEgi9R86Kmwx4E5PN9Vpc1r6rNTr3sWOHkvRSjjuB1Za8ZOe9kWhDSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDw3U4I2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48908C4CEF5;
	Fri,  3 Oct 2025 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759530460;
	bh=sA7GiiYNGw0DroJhU5v2cyWMSmIAOSRyumgDzIPC3vE=;
	h=From:To:Cc:Subject:Date:From;
	b=KDw3U4I2MlWy1hr04dBuHlbQW0Ld/m8o90qY+YJSBpAZNDvmMfkwJETeXBH1mm69X
	 ErP6kjPmY1kLuu74lPu815SzMzbZi8MXVs+Tkf7A1XdevKTLgpLCoA8Y+3fCRS1GS3
	 qoDBikb+LQggC5Pkoui1rXIYsgJIS2oIA5aUvUoRJdHMhPyZnqV3NknWVHDnuCQx5V
	 2kQ3mzjXFF76SSVbRnWQd26oWGEOq4DaWhxaO+iigDQDVSweJCRw6aaIfIzjMW5+AX
	 qzHtE/hrnsPLq4BAHOu7TqW2Do8KK9TrM0BR8ZCqMqOHRVcwkSIfQH3UEHyUZ5rhF8
	 gJw6WY5I7DkGA==
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
	tmgross@umich.edu,
	mmaurer@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/7] Binary Large Objects for Rust DebugFS
Date: Sat,  4 Oct 2025 00:26:37 +0200
Message-ID: <20251003222729.322059-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for exposing binary large objects via Rust debugfs.

The first two patches extend UserSliceReader and UserSliceWriter with partial
read/write helpers.

The series further introduces read_binary_file(), write_binary_file() and
read_write_binary_file() methods for the Dir and ScopedDir types.

It also introduces the BinaryWriter and BinaryReader traits, which are used to
read/write the implementing type's binary representation with the help of the
backing file operations from/to debugfs.

Additional to some more generic blanked implementations for the BinaryWriter and
BinaryReader traits it also provides implementations for common smart pointer
types.

Both samples (file-based and scoped) are updated with corresponding examples.

A branch containing the patches can be found in [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=debugfs_blobs

Danilo Krummrich (7):
  rust: uaccess: add UserSliceReader::read_slice_partial()
  rust: uaccess: add UserSliceWriter::write_slice_partial()
  rust: debugfs: support for binary large objects
  rust: debugfs: support blobs from smart pointers
  samples: rust: debugfs: add example for blobs
  rust: debugfs: support binary large objects for ScopedDir
  samples: rust: debugfs_scoped: add example for blobs

 rust/kernel/debugfs.rs              | 112 ++++++++++++++++-
 rust/kernel/debugfs/file_ops.rs     | 144 ++++++++++++++++++++-
 rust/kernel/debugfs/traits.rs       | 186 +++++++++++++++++++++++++++-
 rust/kernel/uaccess.rs              |  29 +++++
 samples/rust/rust_debugfs.rs        |  13 ++
 samples/rust/rust_debugfs_scoped.rs |  14 ++-
 6 files changed, 487 insertions(+), 11 deletions(-)


base-commit: e406d57be7bd2a4e73ea512c1ae36a40a44e499e
-- 
2.51.0


