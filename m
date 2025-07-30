Return-Path: <linux-kernel+bounces-750181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E337FB1582A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF004E7805
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2471D54E9;
	Wed, 30 Jul 2025 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH4gwDcD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2A17BED0;
	Wed, 30 Jul 2025 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753851062; cv=none; b=pR9/ehqsVPWyS7PaFZlV3CW32/LWbTlh/oMXJjm1kF529HjjFZ+ouCrRCFiYVA6wdLuxsvtHrpzMjMsXCPnVDAQqweBR1atACkGqjUUQr8v/n1c40CmZNtYY+iWGD+97P1y4Ee/ze1rBEtoufP+x7l5QJcWoxxkqUY2XNAc/KoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753851062; c=relaxed/simple;
	bh=RxGMRxGRju4HWBIkrWOoTZkXaFWFHu//cpnBUbRIYWk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EWDLPtZNsKl+ae445Av4Oyc6vasPetf9xHtbPdOrIcazyEnU8hH+hWmtIRCkxLTiUrKvdWoYmF9S+NWl1ysg56GYIlWKPGiwKkq01RVwo1S+vucetz63oinKnMSBJesbX3IsGnfnI5nLv28Pkb5/pV3KrHUksKhjwzXOk5uN9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH4gwDcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5C2C4CEE7;
	Wed, 30 Jul 2025 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753851061;
	bh=RxGMRxGRju4HWBIkrWOoTZkXaFWFHu//cpnBUbRIYWk=;
	h=Date:From:To:Cc:Subject:From;
	b=QH4gwDcDfNcIMC+P8p56iBvP4bDtQTENerDvx2IuPNUU1wHLlNPZ7Cnb4cuL9Ty9m
	 XZEVVckHmzbL9IH5zLaFR6/wxeGzDMpEE0/7q2QWWf5oYxmCjpyaY0Sv9EK9auyKF3
	 iLDm8Hdu3CaV4eLNZXu2nB3+0TqJ6Oxm2bCeyI5Mvnv0uxi8i57BLDdqioiNYGslm6
	 CzCOI9Xj+vqaGFDYz5zvcjEy/SUGyF77Y5v7cxYJvshduX7BO1rXxCZ8Qw3EOW4xoy
	 wkGp2tLnnSWTVgunM4Jszj0wD+7+A6SYWIVBJmhBy7p62BxH19zbaLvqX3mDU0JZ3x
	 Fql/TwUnJjA/w==
Date: Tue, 29 Jul 2025 21:50:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.0-rc2 uploaded
Message-ID: <20250730045057.GA3686463@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.0-rc2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

This is a prerelease version of LLVM, similar to how the Linux kernel
release candidates work. If there are any issues found, please let us
know via email or https://github.com/ClangBuiltLinux/linux/issues/new,
so that we have an opportunity to get them fixed in main and backported
to the 21.x branch before 21.1.0 is officially released.

Cheers,
Nathan

