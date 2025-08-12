Return-Path: <linux-kernel+bounces-765678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A4B23C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB897AA3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 23:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CBC2D46C6;
	Tue, 12 Aug 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXzFmHOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861D74C92;
	Tue, 12 Aug 2025 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042531; cv=none; b=chY7e4KXBvlUs9q+usoUcnml3lAGfb0ms5zQ1cU8jCzumrwZC0lVv8+fWi60KWqdzHQhmLk4NStBAcMrKNPjDvPtrr+V33zc9I+5Cp7oXvTx1jm2KmeJWwGmzjfB9bJuiejv+PeOmUAblTqm9mvMXeWcUjYP8PD51uFiRmnMt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042531; c=relaxed/simple;
	bh=f0lHBr8L+ho9/cldE+Khu8S3l/gYqbz0T0YotDhevTM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KQ7L1mnJWcbvldBxolLC1fEMn0A68Ld9+Q0TB0M9FUjhijSO40pO4fDOu9SUse77JITsNwVVhijDgBob4lwgQgkuAaHene0sOxup5Eh6MjRsJAY1x9gfnBJcCpM+HmLIpkzQRO3aZJ8WJZJMJp/S50MJITe8Resq8XoRGbJ1eww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXzFmHOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F9DC4CEF0;
	Tue, 12 Aug 2025 23:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755042531;
	bh=f0lHBr8L+ho9/cldE+Khu8S3l/gYqbz0T0YotDhevTM=;
	h=Date:From:To:Cc:Subject:From;
	b=OXzFmHOVPgPdaZxOWJcEF4MnSdj1uuc7qHSWWn6MbjVNbn7WsxRS7Wl3tVfx4xyJO
	 B1lCAlSp9MTdsMU/yMLEB6c4TKNXDgQQ+Ia44fP+utdFn+B14zaeC51+VJmtOSHUPP
	 ZXeAcj2kNGF3rp92H/EiwOQDIysfcPATlrdlLAkzyg/yOjbtWF77TopLKrWT1NCMJt
	 XtZEg+xjjW7uOw/d8BXrHX4pJy2p5AGTuOPQ/hNrFUeiG6Lt5FDX3UjIUTOt1SerPF
	 LYy1U6uWOpdAp8yiqMm7kuVjPz0Iuu11LvUQzGyMucA7/VKQXGFXIlXzpuF82FjYUY
	 quh6CCxchKELA==
Date: Tue, 12 Aug 2025 16:48:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.0-rc3 uploaded
Message-ID: <20250812234847.GA265853@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.0-rc3 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This is a prerelease version of LLVM, similar to how the Linux kernel
release candidates work. This is expected to be the final -rc before
21.1.0 final, so if there are any issues found, please let us know via
email or https://github.com/ClangBuiltLinux/linux/issues/new, so that
we have an opportunity to get them fixed in main and backported.

Cheers,
Nathan

