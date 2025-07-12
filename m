Return-Path: <linux-kernel+bounces-728736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E2B02C62
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 20:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D501716F0A7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 18:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D5E289343;
	Sat, 12 Jul 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDbcMAcB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE62749DF
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752344380; cv=none; b=JVppMIMzC8ZVX4DQ1J1G4DgyYqMDd0d4770TXxjMWIRCAA2gau0rZKxnvUQaaru2t9uv5+k5kDSQlHp5IKhct8o5ozW5apXz5ddY5bpHlEsNE0q2otKiC84RjB3WyNByV6GBBSbeueNGA0SGYsUhxddQ8/wkopS02Wsm1cR3P5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752344380; c=relaxed/simple;
	bh=VAzrj+slNfvi//h9gMh+UkCm8r6fN5pUy7YKE9FRLKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPq5unsyxtIx9HyDjXFdSuZ7mrfC5tYhqBxSaYXRYa0vjBbA7Vi7GebQJcPK5NUxH8BTich7fKUP6HoGIqr9HdAPeKA18GYSZI7NYK7oQKItWhBGW1mnUTDYxK0QxYnYVSccQdDXU0hjZBJCEZcDuGu/DtLvCgvgOWqaRX2QIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDbcMAcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71776C4CEF6;
	Sat, 12 Jul 2025 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752344379;
	bh=VAzrj+slNfvi//h9gMh+UkCm8r6fN5pUy7YKE9FRLKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDbcMAcBJGThHxZo22rP6k4KPi94bXDl9Z/CaCAZcJBWOchC+DUCn2F4N0wIEIYgh
	 QSt6kXV4k4ff3OPkcURHlNwra6DWdCP8pTEuWBx1tg/rVjedDslCJ8KM1YXew+Jqtc
	 4DDFk/b3Mx/Q8y17pn6d5ArzeK4xBcMdoZXrbyYz24QW/3e6J91gMIN+rXjZXQiWqH
	 YHtOb/qxlmJ22VnzZnaT9EBaGNR7FeoY/l3hoHz5DJo/8oaC7TD96gp48NCkjmPmL8
	 LiQmQ9eGlVVzcl7FkdES2xoq5Rvdbc7KGsi9U5kXyURV4iqIL1rdYe336aR5z1QkI2
	 q803VBcWbRoWA==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/8] nvmem: apple: drop default ARCH_APPLE in Kconfig
Date: Sat, 12 Jul 2025 19:18:57 +0100
Message-ID: <20250712181905.6738-2-srini@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250712181905.6738-1-srini@kernel.org>
References: <20250712181905.6738-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Peter <sven@kernel.org>

When the first driver for Apple Silicon was upstreamed we accidentally
included `default ARCH_APPLE` in its Kconfig which then spread to almost
every subsequent driver. As soon as ARCH_APPLE is set to y this will
pull in many drivers as built-ins which is not what we want.
Thus, drop `default ARCH_APPLE` from Kconfig.

Signed-off-by: Sven Peter <sven@kernel.org>
Reviewed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d370b2ad11e7..edd811444ce5 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -31,7 +31,6 @@ source "drivers/nvmem/layouts/Kconfig"
 config NVMEM_APPLE_EFUSES
 	tristate "Apple eFuse support"
 	depends on ARCH_APPLE || COMPILE_TEST
-	default ARCH_APPLE
 	help
 	  Say y here to enable support for reading eFuses on Apple SoCs
 	  such as the M1. These are e.g. used to store factory programmed
-- 
2.43.0


