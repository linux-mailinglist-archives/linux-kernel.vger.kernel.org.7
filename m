Return-Path: <linux-kernel+bounces-891712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB336C434E6
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 22:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C06188BD21
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 21:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491E28725A;
	Sat,  8 Nov 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou/OqR+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7196286400
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762636791; cv=none; b=SvhzV2ESN/+0qOt/SVd9VP4c77LDH32L3IGFPiJDRYUR9Z+9VMkA3Lhpo0DwrQr6zsPq+HTP+CzAXpa5nL+kHjRCGAw1qyj2Y+91kIOGN/E95gDOTTm0ioKHFpJWG6ax/9NfLJDJsHI8spHieN4ja7ZCeFJHMwI2pgy0GtVqQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762636791; c=relaxed/simple;
	bh=gnWzEsrpN2kIhNsNvkhKEcj/hLIzAurToD4yj1+Yt1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=turHosHAHhZlG61J+4MaKZxsRLF9K/5Eh+IelWLnvI1lr2cEQkanbYRfJNY0Z9NNmX9j3Ixp/YSJkQoLeLrx3D4YdPM07+peeUK03SbINOIu34B8QyYba4AWFDJiPtE3ksu/pxLiS79G9UmEcBZBo8OfXx0srobj7hZI0igKkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou/OqR+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0BEC19423;
	Sat,  8 Nov 2025 21:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762636790;
	bh=gnWzEsrpN2kIhNsNvkhKEcj/hLIzAurToD4yj1+Yt1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ou/OqR+Xt1UEZnE6M2quC42nGmsnY6DO5WwyZPCoygxxUBIuVf+KCQUyYzZrVbGN1
	 M+/9NqLhgIa4EgyosZPvilRLOsfI8xnh8ihe2EsdBYxJ9B7sohWkoDRko1k0oEkSmF
	 Lhh/y2ic28fCDC3WGDzsNQWk06nLw+5dSF4EL26I1MLI3WqLgyxEH8BuFzZgEom7uy
	 Ae2vvQmNyd6gfjBRn6NjbMW/NoSvtMCX4HLGeC6K95f4yD0VZCHDgg0naWhUf12pvt
	 BK0xSUC9Ut3hF6umR6n5V/WKS/Zizu2PEJkYrMTMo3ZBa0Zic+XBIEsCSDZu02CG9f
	 o+ONzweanoPbQ==
Date: Sat, 8 Nov 2025 22:16:03 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wenst@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	J =?iso-8859-1?Q?=2E_Neusch=E4fer?= <j.ne@posteo.net>,
	Tom Rini <trini@konsulko.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] scripts/make_fit: Provide a way to add built
 modules
Message-ID: <aQ-zE_EmoPbgCItD@levanger>
References: <20251006230205.521341-1-sjg@chromium.org>
 <20251006230205.521341-5-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006230205.521341-5-sjg@chromium.org>

On Mon, Oct 06, 2025 at 05:01:55PM -0600, Simon Glass wrote:
> Provide arguments to support building a ramdisk from a directory tree of
> modules. This is a convenient way to try out a kernel with its modules.
> 
> This makes use of the cpio tool rather than attempting to use a python
> module or our own code. The list of modules is provided in a file.

The list of modules is provided via command line option/arguments,
isn't it?

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> 
> Changes in v4:
> - Provide the list of modules from the Makefile
> - Reduce verbosity (don't print every module filename)

Reviewed-by: Nicolas Schier <nsc@kernel.org>


-- 
Nicolas

