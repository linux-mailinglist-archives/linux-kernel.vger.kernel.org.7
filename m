Return-Path: <linux-kernel+bounces-783045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B1B328AE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BEEAA3C63
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8381F4176;
	Sat, 23 Aug 2025 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="lGMhyRDX";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="t+yANq42"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872B273F9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755954276; cv=none; b=HJ5FpQzNAmowKQVVGJanwuVNnNQGJ9BcUvRUDS1YMaVFuPDCgKcqze0by55fNX0Ho+Ij7SR3mcDZPaT+GYFFkb4qjWULxSSaTFAFC1XNZDaaQttb+4vGxXSY8jt1yuj5m52euPmYqFK6OWxMxciQ3yP5CUFLrGdIwKfjie5mapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755954276; c=relaxed/simple;
	bh=9ydM5NWBud1GfQDvD+Nz8838Op27MspclOz/jCY4T4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mnv1gMGFvSVHWeCzEqKukpg6sigUoT+K0wAZCreow1kR2nmxfvccPphUJGaFSg70sTU6+TYdagMKRQhYq46nt4OHLdd88DfpnBUPj3Pmq8udQR+7upb6YSSC/wMNf43uG7Hu4VZNg7D2hv6iuH66Db6FH/gnbMzO9W7vyY3JLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=lGMhyRDX; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=t+yANq42; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954270; x=1756559070;
	d=konsulko.se; s=rsa2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=USLZVbG5IB2ruAXTCfXR91VY562JG1KkktDhm6jAPu4=;
	b=lGMhyRDXZcbkzhv7bOss7ttLInYqwFQtl+bu14RU1WC1NdRNulcGD2uNNgUNBjW3NjE/cmhHFT39W
	 16rTY4TYjRDjgmZqfH2wPxdcCo4PRRnuBf7jLAN7BXeB7t7uc/dOkVb+4XwR6wbbr9FWR8rgjnngqh
	 DYIMLL9r3PS7RNHAK96dSn55xG0TdZBy/vlHD7rm1fcyDOBjhPuarEb6ZOK3Y36N9l0NqmnW6ND9fZ
	 ds9NoEH7ts+fMbz2fijc6swe1AkR+qKY7g2LLlfWO8V5oQWqG7qqSZPanF/83T3iZXD3jyTjzzG78W
	 qxVMMkvfee5sX8xObYy+9EuIlH6huow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755954270; x=1756559070;
	d=konsulko.se; s=ed2;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 from;
	bh=USLZVbG5IB2ruAXTCfXR91VY562JG1KkktDhm6jAPu4=;
	b=t+yANq42VD8WcO2xMfB8ffxj2wGRZHsFaFAkZHVrzpGvnIKvr14YU6LCeQImb9MysuGZ9R+/vUhlE
	 Cfeuh90BQ==
X-HalOne-ID: b4200260-8021-11f0-adc8-fb5fec76084d
Received: from localhost.localdomain (host-95-203-16-218.mobileonline.telia.com [95.203.16.218])
	by mailrelay3.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id b4200260-8021-11f0-adc8-fb5fec76084d;
	Sat, 23 Aug 2025 13:04:30 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	linux-mm@kvack.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: [PATCH v4 0/2] rust: zpool: add abstraction for zpool drivers
Date: Sat, 23 Aug 2025 15:04:19 +0200
Message-Id: <20250823130420.867133-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zpool is a common frontend for memory storage pool implementations.
These pools are typically used to store compressed memory objects,
e. g. for Zswap, the lightweight compressed cache for swap pages.

This patch provides the interface to use Zpool in Rust kernel code,
thus enabling Rust implementations of Zpool allocators for Zswap.

Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
---
Changelog:
v1 -> v2:
* reworked to stick to the existing Rust driver infrastructure
* removed raw pointers from the Rust API
v2 -> v3:
* detailed safety requirements for unsafe API functions
* removed unwrap()
* some typo corrections
v3 -> v4:
* added a working example of zpool Rust API usage in the
  documentation part
* change to Flags arranged as a separate patch
* improved safety requirements for ZpoolDriver trait
---
 bindings/bindings_helper.h |    1 
 helpers/helpers.c          |    1 
 helpers/zpool.c            |    6 +
 kernel/alloc.rs            |    5 
 kernel/lib.rs              |    2 
 kernel/zpool.rs            |  338 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 353 insertions(+)


