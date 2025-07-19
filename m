Return-Path: <linux-kernel+bounces-737978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41346B0B2C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797F117B680
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86828983E;
	Sat, 19 Jul 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMu4z/Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599421CA84;
	Sat, 19 Jul 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752968412; cv=none; b=WEZtt0CMKXq/idMCosRYsXSPkASsWwGur7s+hIZJ4xja8PZ1J06L1P25xn/gQJVzfqIX6AHYjhL/MTN/weLkI9daADzzwuSU48J9PO0cxaYEIQwqC83K+Ip66syM4bRsuDIGqBlHPYHHEOGBE8M2qjpTtmTx9AC31U4bVtQHvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752968412; c=relaxed/simple;
	bh=FI59vIFSv/rQiyNOoufWt+w01lG/gPIsnfpCq90z7yA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+91U9onNkLiLQOHw0jic5saiF6fAhqzN67SVHIBUExAhJszTf5Qg6P+17V7LWvFhLK4MrFudpg/DdQY7KhnGwogxoDIijY8loWx+p34CiXizar1oSB/zR6muJSFEPGFWXzflVGpjLxgHxSJiDf+hNlOpvuTaFuOqerdV3but7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMu4z/Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AAAC4CEE3;
	Sat, 19 Jul 2025 23:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752968412;
	bh=FI59vIFSv/rQiyNOoufWt+w01lG/gPIsnfpCq90z7yA=;
	h=Date:From:To:Cc:Subject:From;
	b=HMu4z/Dn73KQoYUpnqa4pmk+K+fCW7Wm9kHPX7b9B3z/au6EowTTjGwVxxbPO0ToN
	 BJ46/4YbZAjmyXc3s/rSinGapBDAMyprHT9xRp0S96a2KEBBBKR/TM1AYvz8akrcyf
	 LbUIQGgwR0iQdJsUhlRy5Oou/p9Nao7mJrZvss6ZkUbPEu0/8GRB9IBVkUYN1nqeEp
	 UubH+KVhVWvs4b7uqhGLWAIjPwAUuHhuQsZx2lek8GA2xtSiRIEadani9jf94WWLOM
	 BAUGa72yxmwCTw8KRZQfOSTbu9hAd/s3LW95ENzPN7cQTqQTXdzZFgB0lrLxDNpHBN
	 f0yZ2IYXg1cOw==
Date: Sat, 19 Jul 2025 19:40:08 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.0-rc1 uploaded
Message-ID: <20250719234008.GA220041@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.0-rc1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This is a prerelease version of LLVM, similar to how the Linux kernel
release candidates work. If there are any issues found, please let us
know via email or https://github.com/ClangBuiltLinux/linux/issues/new,
so that we have an opportunity to get them fixed in main and backported
to the 21.x branch before 21.1.0 is officially released.

Cheers,
Nathan

