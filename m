Return-Path: <linux-kernel+bounces-787616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C5DB378A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D60686A49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A148B21B9C8;
	Wed, 27 Aug 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7SSQHnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04592366;
	Wed, 27 Aug 2025 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265928; cv=none; b=gf4pZGyFOIt82twcmUIQwejCw2tl0QfFiSoHK8enXdkeO/2XDZ9wVDxXB8ZO9qrLij190k7WoCY7s3euPa9hVyoV+AjMDo+5dOC9dc/Rk6LcOAxhZMMKgGcZ/a0U5MORURZ4hCPLMpvn5dbxDwfttHFe4CTrxzOSAIyb/neDpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265928; c=relaxed/simple;
	bh=vbOwvKfken9Q0kduteQTYsYdcXvxD6+VkMSEss+uVSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AgxM0pJqmo0JQRyF0acqvvNx5R+Kw3i+SacwkZPROnXbSRw3+TWOcmepwRQ/bbENSZPQcqcQeP5Rtvjx3kRdbeERS7xIPr8Of992QWLCNqWbzh2J24TJjvIPWaAtN5ZfB9fGOedyhgl52jiGoeYU0iYy9yflpiBSYmS7OiWoMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7SSQHnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945E3C4CEF4;
	Wed, 27 Aug 2025 03:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756265927;
	bh=vbOwvKfken9Q0kduteQTYsYdcXvxD6+VkMSEss+uVSw=;
	h=Date:From:To:Cc:Subject:From;
	b=A7SSQHnpb7ZChD2nGEGioESJ3LbTy/4BzWyFUDIZ+79vgBmA4lxWhGBDSc5v2eqjV
	 Lc98Ry1mIOLbb5QcNCZDH/Mc7lXItMUUFNy/GlwqyWh8OYi7rlUGnrpWqx9TC5aOAD
	 wctOjyll/IzUtXWVAuMBHTtiIxhjKgnn2SrDeYeZ4SoRdktGQ3+6IbFJcbAYszx0yZ
	 vOghVznhR/TSspx3aOfDH6tkavVAH/IjzEjrOX9eg3WWeAhOXoaFrU+13J0eAKPoqH
	 566Z+zNTfj/YibAQMOf8lq+SY18VNg0HU+1B8nqv1d0wSfXveMLCLZ7XV6kjdPpVIE
	 mgQwoVOjdGenQ==
Date: Tue, 26 Aug 2025 20:38:43 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.0 uploaded
Message-ID: <20250827033843.GA2135688@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.0 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 21.x
series is no longer supported.

Cheers,
Nathan

