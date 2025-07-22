Return-Path: <linux-kernel+bounces-741081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01452B0DFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756C17B8B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9D273D6E;
	Tue, 22 Jul 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlvs6Qto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03F41EDA0F;
	Tue, 22 Jul 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196481; cv=none; b=MQFKM5D9LUtVIJ6Amx8Nqz0mKHPEZ37u8ib3MHdgjRJVoi6rkMDnpVvrKMOpmEAn4wfDdNSdE1S8yPftPSHs8boe5Y1raP4Q0XEnJmgONiZL8tMad33sBKjDnyBDxVugNrLyDy348Ewh7+8tlWCK5iVsULR/AKxnRyFAEtauNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196481; c=relaxed/simple;
	bh=pFvy2HWeqCbXyhfHJLCUaU+GPIWDOQBcfZOPTiK4syY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iDPBrfMiMRG5jbX0rBXS6JSD0iqxKG6BKbT8s9MvymgLx5ZZJmRNEt0R7mt/07DJHzn3B+65KKmla9G5WWnbj9WgVyyy4nCvR4xCeoaQcIm7hpKLoIKxOwqbSHSNxYPoWhjhHDnqeHYNfCd46BoOlI+jq3Hn5G86jChHWMZ4at4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlvs6Qto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7F8C4CEEB;
	Tue, 22 Jul 2025 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753196480;
	bh=pFvy2HWeqCbXyhfHJLCUaU+GPIWDOQBcfZOPTiK4syY=;
	h=From:To:Cc:Subject:Date:From;
	b=Tlvs6Qto6iGLoZqpIbv4UGfdlxahWXAFepTa7+hiBeajN4rFW40N9myFE09eCPecW
	 32NQuaYECvm47PPEQ1+NvvIPmKQks7O6oQ/rkgDrmryjxisoMDT+ISmLKU1gVB5JXb
	 XDYieTMwIXH+bG754OaHN33KOwUufO1bL2qj77ooUQFu5Y6LaVwz0env16hY/q0KGr
	 LgLYBi51QvbcAg/sFqWfKdg/+f9wTk+2fj0rm+Y2qY7AuZBeopxpDDhDlpXbGT9S+T
	 7CLbHdsvUvyvuT9gE5jFne3NNhD5o1r6gpHzb7UkQ6KqaFA6CQP0xXOdJ8WqXOngEx
	 y7iaNDw7sFPLQ==
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
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/3] Documentation for Device / Driver infrastructure
Date: Tue, 22 Jul 2025 16:59:58 +0200
Message-ID: <20250722150110.23565-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series expands the documentation for the generic device and driver
infrastructure and provides a guideline on how to implement bus and class
specific devices as well as bus specific driver infrastructure, i.e. bus
abstractions. It also expands on the existing documentation of device context
types.

Changes in v2:
  - Remove redundant DeviceContext dereference hierarchy.
  - Separate links as suggested by Alice.
  - Add a note that the guarantee for a Device reference to have a certain
    DeviceContext comes from the specific scope the Device reference is valid
    in.
  - "structures" -> "types"

Danilo Krummrich (3):
  device: rust: expand documentation for DeviceContext
  device: rust: expand documentation for Device
  driver: rust: expand documentation for driver infrastructure

 rust/kernel/device.rs | 208 +++++++++++++++++++++++++++++++++++++-----
 rust/kernel/driver.rs |  89 +++++++++++++++++-
 2 files changed, 271 insertions(+), 26 deletions(-)


base-commit: 51a486feac0ca002bee6429f03da0a6c206d0dc5
-- 
2.50.0


