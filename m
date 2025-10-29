Return-Path: <linux-kernel+bounces-876989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701AC1CF15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 072294E8B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61177359FB9;
	Wed, 29 Oct 2025 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7xfVF0o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E435971E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764869; cv=none; b=eH5XIF0Bks66CVEJOiONwSFlXZwznaphgzaTQOSv7OCUPk8qD9pCCHfGsMkk38jJvXMUzqm9+vIOh2JoYI8YiCk3A6qGF9g5ycnAi7uvRn42pNcaDw9r10IDfRKZvPunCKaqrzz87XfqLj8X98bfctNqba6c4e10cM+AfZ/l7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764869; c=relaxed/simple;
	bh=49v353t4/906lS7X2KOyZwahd8+PWlfEMWjxjmqfFBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nQ1TXsQEJ2exwXlwgqUgM1NDjIx62f9iP3yaWkUrJc0XTwZZICRORq00jXSzo6PhAMJi5ZBUeCDdYtCHtr2ZoaYp5OH/z6zyPzeE23f4aKRwLTWSdJSnPvgKJCljUmjTsXniSfy4MlKSYhMgCRZtlaxkTiUwtNpEbia3jYdSxHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7xfVF0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6220BC4CEFB;
	Wed, 29 Oct 2025 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764869;
	bh=49v353t4/906lS7X2KOyZwahd8+PWlfEMWjxjmqfFBk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=X7xfVF0otCc/bNp6n8AsU32/gwTfo4XDdL2PsZbw8COQEmU0B+g4CN1ng07YCSMFX
	 vooHhJQjlHWB7VeaGDB89lKi1mN5sJvDxuBMKtr/4ZMb+/5o41Wyw+cue9/Ips4kv+
	 aYyjST9s2qCbwp51eNFGqcw5UEjXn7q/AnDgyUt6aF1cUX45pVLphMC9kMSD/FunVF
	 v3N//YCPwkurJCEfiXZ39G3Exo0yx85F3YZPOdVzumY+RO8aoXF6O9PmU5DLcLUze6
	 8ZcvH6+cSHi9Axtri6YN9zi0MAuvhnZQKU0PjPVBpDzIY1ojTCf7XkjD/szTKn9Urm
	 cVoEM0PuxYekg==
Date: Wed, 29 Oct 2025 13:07:46 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Feng Jiang <jiangfeng@kylinos.cn>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    emil.renner.berthing@canonical.com, nicolas.schier@linux.dev, 
    masahiroy@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Build loader.bin exclusively for Canaan
 K210
In-Reply-To: <20251029094429.553842-1-jiangfeng@kylinos.cn>
Message-ID: <3b4026de-bc0c-61ca-41fc-47bdd4c633a9@kernel.org>
References: <20251029094429.553842-1-jiangfeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 29 Oct 2025, Feng Jiang wrote:

> According to the explanation in commit ef10bdf9c3e6 ("riscv:
> Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210"),
> loader.bin is a special feature of the Canaan K210 and
> is not applicable to other SoCs.
> 
> Fixes: e79dfcbfb902 ("riscv: make image compression configurable")
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

Thanks, queued for v6.18-rc fixes.

- Paul

