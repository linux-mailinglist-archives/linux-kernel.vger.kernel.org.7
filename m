Return-Path: <linux-kernel+bounces-847565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA7BCB337
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D35444EE232
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9CE288C34;
	Thu,  9 Oct 2025 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VE2eqbNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32686331
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760052796; cv=none; b=ACV5liEDGmC2Eh08pTgpnT+ZCrCDcUkAayhSZj6Xgrl+fkiEW++Xx6tc9hASkGRcZpi66k8sAmK1UcNA+bWD+qbuGaoeltM/GXbj8vGJ8YM4vF6qSHInNbRmrgKy533gfO1EtyRQ/0nvrHZ+YY+cqnfCU8TbZS7/WJaHLkmuJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760052796; c=relaxed/simple;
	bh=pnPG2TG9PTYq3RQMqhtbs/di2ZVkxvmkOAoJj5TwnbI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Gt6m1opfEn/o5NGwGZzcT6dtocnb9SyZdwd8NiwZdlFzI2bou9YV8SPO8XgL9YIOueD9AzIkYZSp5XxquRsmRkF9Q1xwYk4Gxgvtj42QiLmc6vsYH5WXqRX65bhrAChT+2jKVheoy/p5xPsh+zQWfKt+8pPgR+uN3CFi0qXIyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VE2eqbNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E31DC4CEE7;
	Thu,  9 Oct 2025 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760052795;
	bh=pnPG2TG9PTYq3RQMqhtbs/di2ZVkxvmkOAoJj5TwnbI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VE2eqbNlv8RrqSiVqCSRoOkpzX4n5+VwPosz1GP5I60VojE7MkbOI/Ux2Y9yrCE/0
	 odDR06RhlMN8SXdAc16X22QxSHahTt3r1XwMzbsUi9XrRPaxZlzEAa9kQjNTEdcB/Y
	 fwZ3gtsBVXMJtzFeS/+qoK4rUYxOZVo/0Poqy8DtZT5i/L2e4ph1I9W+T0bglimnqV
	 PYWv0t+iE4GqKCnRa5gHAnmJbe9sH+zRB4DyIrQEj5X4Odw4Tvpp2GNRqKCOXTKCIV
	 9VPDpOeqfuDYBvwZStSXSWaQmJ3+cvmGrPMg/wv/9SeZaAX0p4COfIzNqsPOQLIlAD
	 woWZEZ2bzIVIQ==
Date: Thu, 9 Oct 2025 17:33:11 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
cc: Paul Walmsley <pjw@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    duchangbin <changbin.du@huawei.com>, Alexandre Ghiti <alex@ghiti.fr>, 
    andybnac@gmail.com
Subject: Re: [PATCH] riscv: Prevent early kernel panic in instrumented
 apply_early_boot_alternatives
In-Reply-To: <4de90ac7-f05d-4c16-a5c5-8101f5d2fe91@iscas.ac.cn>
Message-ID: <58b5a08f-b10c-668b-fbb7-cf44ef2ac940@kernel.org>
References: <20250624113042.2123140-1-changbin.du@huawei.com> <a89f5970-5ea9-4d92-8952-6c26a22ac153@ghiti.fr> <d41d9c7a103f4600a4fc5beea77e0f4e@huawei.com> <2396743a-480e-2ab3-f7fe-569d8f2adfcf@kernel.org> <4de90ac7-f05d-4c16-a5c5-8101f5d2fe91@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-560156192-1760052795=:1991624"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-560156192-1760052795=:1991624
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi Vivian,

On Thu, 9 Oct 2025, Vivian Wang wrote:
> On 10/9/25 10:01, Paul Walmsley wrote:
> > On Wed, 25 Jun 2025, duchangbin wrote:
> >
> > [...]
> >
> > Working on cleaning out Patchwork.  Was there any further conclusion 
> > reached on this patch, or more broadly, static ftrace ?
> 
> Static ftrace for riscv is no longer supported in 6.17. config RISCV is now:
> 
>     select DYNAMIC_FTRACE if FUNCTION_TRACER
> 
> Since commit 5874ca4c6280 ("riscv: Stop supporting static ftrace"). This
> patch should be obsolete.

Thanks for the followup.

- Paul
--8323329-560156192-1760052795=:1991624--

