Return-Path: <linux-kernel+bounces-767512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC8B25578
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A706E171C82
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4282F0C66;
	Wed, 13 Aug 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDKFw9rR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C762BF3F3;
	Wed, 13 Aug 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120727; cv=none; b=ap4nW0DNOxP5a+6oHrmiucHdZZ67HIUKL+GdLpHKXyv0pG7zzW5VJ0gkifGEfy2yoDCp1gBKTAQxS54eKgP5j+KjjQPnNw1ZAEyPtjp96p2zPNaiLpeX0o8urIqV6iu90lKtuBML77vloVVswBWj6X7WFmvcWyBUUSnQTrKKNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120727; c=relaxed/simple;
	bh=zAxzRiVLqsjw7sByOm1NLMZiSLothxFD7dx5ZQ0UQBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=srGV1UlxLX71bn5dJuZPpa38tWgs6b1WhpNpunKZKOsUwbzGz/o70NWqlMyQyLhv7URsVmB8DJuqOYp5EqqFClrfyp6T2MgHu6q+T4R/I7oOAXiTXeDgrB3upYevNmm4Y+ETBUV27+js0nZVyIN1x1xkV9Vb088hpZpI6aHBLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDKFw9rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5BDC4CEEB;
	Wed, 13 Aug 2025 21:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755120727;
	bh=zAxzRiVLqsjw7sByOm1NLMZiSLothxFD7dx5ZQ0UQBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TDKFw9rRlXVNuYwo+mt0yzsAgImn2acbIfF+M0Gh+QQjxHq7eV2vz6P3z4VBU5Cdc
	 68qDKuV0KSBMEsvBSUaZPeqTBF71E5QeVca+2mBEi/wQAsyAHTMZulmm+1o4LciEGd
	 ldIZHzJscxTa5jQGa7X0h+1WM98LADBzuPpZPfSJhm0/sbwB67JKFshKgoSqqwvyjT
	 1UKKjwVMS0+cs5IwFJ9zFAIG6Rm8G47YIeEx+sVhVYTFaWeIBWibWonx2lAlPIQmXg
	 lsk/W2k8L/cgGT/6P2PMO6Mwkwv5EoIKiYXQoPErnRYy8W85pHumfFJB2rl1+vX1xa
	 iUQrynxKbLLDA==
Date: Wed, 13 Aug 2025 14:32:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yibo Dong <dong100@mucse.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
 geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
 lukas.bulwahn@redhat.com, alexanderduyck@fb.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <20250813143205.1c0bfafa@kernel.org>
In-Reply-To: <CAMuHMdWpmt2q9tVm-3HV1h2=-7D6zEs_HnBe5gfYVgvfB=01hQ@mail.gmail.com>
References: <20250812093937.882045-1-dong100@mucse.com>
	<20250812093937.882045-5-dong100@mucse.com>
	<eafb8874-a7a3-4028-a4ad-d71fc5689813@linux.dev>
	<9A6132D78B40DAFD+20250813095214.GA979548@nic-Precision-5820-Tower>
	<CAMuHMdWpmt2q9tVm-3HV1h2=-7D6zEs_HnBe5gfYVgvfB=01hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 13:05:36 +0200 Geert Uytterhoeven wrote:
> Or use scoped_cond_guard(mutex_intr, ...) { ... }?

Hard no on that in networking.

