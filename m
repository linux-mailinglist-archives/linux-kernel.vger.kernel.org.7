Return-Path: <linux-kernel+bounces-811138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D423CB524D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C6F1C267EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6C278E71;
	Wed, 10 Sep 2025 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVk4LXht"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AB724C676;
	Wed, 10 Sep 2025 23:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548714; cv=none; b=OosCAN+NdPm03oSykGdRf3Vqk6mEjGP9yVMnmtUDl9Lh7r0hTTDZwFIE1rqh0w4rR3qMaxjdhoj2d4/IXm3BtD3ZnTpYjF2UqWZuNXL6HUhrQULPy5IZ680M384qGBoRnRmqz2JZ9y04zq3zSv+MapF/c4le6P3GMiyKlwPkDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548714; c=relaxed/simple;
	bh=G/Y8KaG03rqMl1Aox6CuhGQyJe+3r4BVje0MntuJFVY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P1mjkNE1nRe/TF339UyUAgyKnI7hRNa1hM+pRHgLU+TcFeP0GsUgJcSgujHHg/QL+d88P7Gzuz+arJe9IhFGr9IsS/aX/Uz8jL+bWrhUhbXJEsfBZQGtyBa4kfBefO6Lm2NPw4EVtUCyNWI4A4PxCpKp5+0SMcDk3kA6yX9e92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVk4LXht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A55C4CEEB;
	Wed, 10 Sep 2025 23:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757548714;
	bh=G/Y8KaG03rqMl1Aox6CuhGQyJe+3r4BVje0MntuJFVY=;
	h=Date:From:To:Cc:Subject:From;
	b=nVk4LXhthQXwvlie2NKbdtjNOT5UlaAKvLGyFtlZ9/X9kmkzKkq8RYWFvucyuuxeG
	 03H6udJth/p9Um+IohmlDeIda6XM6SbFkZnOV9pGvE94Y3F6ubdQ1HviDoyON8uWnH
	 8W1ahD9ffFDSblIj5Zg5NdStVn8FxpoQ0mptyipHYD7WzdoXauQBSvsyD4sg7RBrD+
	 3kco9+qR85JFHCA1oxqfs63T1IOPKRQ8lKkw1P+jLI9LQsHh9ieelAk21IGKEtrDH5
	 DKrZc1vc9pJP29utRYlG5wUp3h/Oijj3sAtp+B+AOZ2Wul37omn/RkMbODpHfj5Ec3
	 7jr+IRlZF1w3g==
Date: Wed, 10 Sep 2025 16:58:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org
Subject: Prebuilt LLVM 21.1.1 uploaded
Message-ID: <20250910235830.GA1133148@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 21.1.1 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before the 21.x
series is no longer supported.

Cheers,
Nathan

