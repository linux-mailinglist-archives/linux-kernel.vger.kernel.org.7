Return-Path: <linux-kernel+bounces-669125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C84AC9B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F501189F801
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 13:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7F6ADD;
	Sat, 31 May 2025 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOA7fp1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227023815B;
	Sat, 31 May 2025 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748698814; cv=none; b=OUL61qCULgSk7YmF3LK7By9RRorNTjNFiOYz8v6oQpofDHsPIKXng6MC9704y+jOt/8vPstmcnpVebaCYySFIxleEfmLr2X8WsDT16vbxCpbxOnKq/GuOUH3GEXOXgpWue8xNsynicbB8J70vFWWrqxLTa1TaKpnyoE03nIX7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748698814; c=relaxed/simple;
	bh=XqWPDWiRyz4buOXC7JUMJhnKN++3un3+UjTzL+RenBA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ByH7KkJUAJboj67b5EFnh5jz0z7Zr1JtnYT3EnkBTnHQkSeNpvey7FZvJkePmoFjHKeYi8df/IKXUVPXiJThv48sRy1AoF7EgCS8G0yKlm2sJjdxgkAigwybo1jV/AqrMjBJtN905AlYRyPpZq5OxMqinRDE+B0+nDcfsPIlWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOA7fp1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0886C4CEE3;
	Sat, 31 May 2025 13:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748698814;
	bh=XqWPDWiRyz4buOXC7JUMJhnKN++3un3+UjTzL+RenBA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=tOA7fp1qHt40RpiZGeKAKx1tLrPTsroFaTIV25L001kqllbEbTArnrZdiI1eHl/Zs
	 YnMESXwMzlvRCp3jEBoypdBP371/9osSa/CeAiCEDaRgz6W+oxfjWe1IflUTrFH1yj
	 7ASwYpKIgkyMJMkUfszVTlSoXs61DQbHzQ4FyBUgWrBCy+K1s50VYjEFZ5P1NO9DSi
	 HlIK5Mz2w+UYQVgTQMzYKsHYTbm38S1e2wlQvorSmEeuwN9COeRG3euRYKPssVCqCg
	 e3WH55EzKOXf+m70hoEjD8H0qtaWxgr67xKcbvHpj5FdjmYP1zI7plW9CIRBr+dz/T
	 abH3O3CrljJmg==
Date: Sat, 31 May 2025 06:40:09 -0700
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kbuild@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] require gcc-8 and binutils-2.30
User-Agent: K-9 Mail for Android
In-Reply-To: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
References: <feab370a-3857-4ae9-a22d-1ab6d992c73c@app.fastmail.com>
Message-ID: <D46A2AE5-F7F8-482F-8D26-C7179D8115CE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 31, 2025 2:09:53 AM PDT, Arnd Bergmann <arnd@arndb=2Ede> wrote:
>      Kbuild: remove structleak gcc plugin
>      gcc-plugins: remove SANCOV gcc plugin

I didn't see either of these emailed out, but we'd talked about it earlier=
 and the resulting changes look good to me=2E Thanks!=20

Acked-by: Kees Cook<kees@kernel=2Eorg>

--=20
Kees Cook

