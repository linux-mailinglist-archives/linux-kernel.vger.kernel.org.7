Return-Path: <linux-kernel+bounces-736034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE51B09703
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C921C46E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFBD23817C;
	Thu, 17 Jul 2025 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onUS947U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8603B1547CC;
	Thu, 17 Jul 2025 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792498; cv=none; b=q++hqOcLv10AzvXLBue5GevgZjRwUm1K7I3ud5f3JExVaXJl0n1Bbw8TzvBg2Q1N7PFOOdcc3Ly3m36GMmn2NAgDpEhO8LIjzLi5NA/IDr7QeUwP9HLWI0TBV7WikxDE7mI5NLf4TOb/MhXwlH7opoLh1AqaFMVoxZtk8+qwGJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792498; c=relaxed/simple;
	bh=7v2HVD7HUuxCA51DV/t8E/np8YJ+Jzr+KIVYvGsqwy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3Kr1/cKQiYs1g2gI28xKfPkH+tpblypev81YLfY9U6lK3IqshybJ9LhZ1O/ntqiJZiaXOkQqXqkSjEuh1PMTG2Mu35F8SpbS7gRZIQQWh4p/ibP2YJMHQi3Fg6Hre9yyH8k0wNYUO5v0xIAg/Rnor9UYqQR1xn+ry/tLxQ9gZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onUS947U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA55C4CEE3;
	Thu, 17 Jul 2025 22:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752792497;
	bh=7v2HVD7HUuxCA51DV/t8E/np8YJ+Jzr+KIVYvGsqwy4=;
	h=From:To:Cc:Subject:Date:From;
	b=onUS947UJviuq9n8zh2/f+HmeZvYDTk5vAMMpBw3fqlKlCpOk4XwN04RqdGo268df
	 1Lyvm/Ovg5N9337JNR+JC7JdJSKBQa5xC7BnGldMdYteAfK+e68EHItfQrx96dZjNp
	 KJA2YXBoWq/IXJv5oENGlyFHKyD6L5/POAkQRKSMh9lQ29mwTOn5Vbs4AcIDpgTePC
	 vOWg9fD57oA1Z9vMcy2oChvCv+d4Odtt3XbUUAGr2RhAAjZcfvfVzQIuROfGMw7YyJ
	 CKqaVTzDeUhdHf6CbWMUoTKAYGOKaOw06f2Fq3I8rZs4eIh8lsmip/yZd+3mvcJqS3
	 LgprNpJ5M8Qdw==
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
Subject: [PATCH 0/3] Documentation for Device / Driver infrastructure
Date: Fri, 18 Jul 2025 00:45:36 +0200
Message-ID: <20250717224806.54763-1-dakr@kernel.org>
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

Danilo Krummrich (3):
  device: rust: documentation for DeviceContext
  device: rust: expand documentation for Device
  driver: rust: expand documentation for driver infrastructure

 rust/kernel/device.rs | 198 +++++++++++++++++++++++++++++++++++++-----
 rust/kernel/driver.rs |  82 ++++++++++++++++-
 2 files changed, 254 insertions(+), 26 deletions(-)


base-commit: 9a8682f0875b8cedad42bdfe601e6ab204fad06d
-- 
2.50.0


