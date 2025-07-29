Return-Path: <linux-kernel+bounces-749871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FB3B153FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63DE18A8575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5DE2512D8;
	Tue, 29 Jul 2025 19:56:40 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8ED22AE7F;
	Tue, 29 Jul 2025 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753819000; cv=none; b=DOFXxIdxBymo3qOq6+1wyngya8I0QdFWWeNr/YJaUGfrprV6mA0UneQUzSU2t1d7Fl70A2PLC+mj2k4d8BT9VaEqFuBuloqsZ90JACUBdlO/iOgK5iquj3LHVL2emA2f3Fihd5jweK378guI2KOMlfRa+0zTkSoMZ96c719ycYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753819000; c=relaxed/simple;
	bh=vvzgDDg/nuQ9VDoEratT9Kr3y9XHrFmTyGBX6B7z8dM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLbCJ/6PfMjoSH8AsydJsolXxpbXW9KGpVHkFprg7FdTufLrAbn2jj2xNFWCpGnCKFTfz63omR08+uXo4BpgGEXM9OJDx9MSmAJYx75BnFFdS1tI/rId6jC75JlySbizWuXP2aiwLiHgI4eGXEryn52tMQzoYelU6SHNTQRQJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:d071:2bab:ab9:4510])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 4E88C40420;
	Tue, 29 Jul 2025 19:56:29 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:d071:2bab:ab9:4510) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: joe@perches.com
Cc: apw@canonical.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	contact@arnaud-lcm.com
Subject: [PATCH 1/3] checkpatch.pl: Add warning for // comments on private
 Rust items
Date: Tue, 29 Jul 2025 20:56:15 +0100
Message-ID: <20250729195615.34707-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175381899018.10664.6697783917442649837@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Hi,

Background
----------

The Rust-for-Linux project currently lacks enforcement of documentation for private Rust items,
as highlighted in https://github.com/Rust-for-Linux/linux/issues/1157.
While rustc already lints missing documentation for public items, private items remain unchecked.
This patch series aims to close that gap by ensuring proper documentation practices
for private Rust items in the kernel as mentioned in the coding
guidelines for the Rust linux kernel: Documentation/rust/coding-guidelines.rst.

The actual solution comes in several parts
------------------------------------------

 1) Patch 1 : Implements detection logic to emit warnings for improperly
 documented private Rust items (e.g., // comments instead of ///)
 through a set of heuristics.
 2) Patch 2 : Adds an auto-fix mechanism via the --fix option to help
 developers correct documentation issues.

Link: https://github.com/Rust-for-Linux/linux/issues/1157
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
--
2.43.0
-- 
2.43.0


