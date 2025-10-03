Return-Path: <linux-kernel+bounces-841761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073CBB82D4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 015404E63E7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565D25FA13;
	Fri,  3 Oct 2025 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugB/oof4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A35E19DFA2;
	Fri,  3 Oct 2025 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526013; cv=none; b=ZUyqtcXn6nbjIQnV2Qu90JGrGv9bSmy+G4+txTegoj8Ym3xfpM+IezJQTCtcYHwbJFLTutQ317JTkcbquNRJk8Sqg+hHbiuBrK2QR5J+RPPzIF6Pi4IIuRSMuz+sotN3qk+cp/fcK06L/zrqkXJReTOJ/jRGyqvf+RHaUfK9lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526013; c=relaxed/simple;
	bh=6g1nw5xllyollCqrM6iwZ/HICb+xwXiCDb44PYNQxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdS3nl0DDbqE2Hca5toyh7yjOjlFqcwm0/uBcnpBgTDIOKytM3eeARsfZCrv/hcywGgZwp0HL0bxA1xYKUhO76F331jKLUwI9HXS7GQLrpTTCe0zIZg4yzV9DjLEnKrEf8+Sp7U8RCsvk7km1zqACsiAYAFdvJFzYVHztZUnxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugB/oof4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E65C4CEF5;
	Fri,  3 Oct 2025 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759526013;
	bh=6g1nw5xllyollCqrM6iwZ/HICb+xwXiCDb44PYNQxNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugB/oof4ZAiP3PUpmJ01D3yHMaXXrS7wjyBwjfnTU/B98fNG00Be6C9ebdlYDaHrh
	 f9bzkAawEdx8uVrj94ZIzxb/+wmyYGRzsK/isBr0SQcrpsDzETXG2wgWGd85w7+S2j
	 01vAHTv048LMAaOBtWm7V3SGYHrvtc15imC5c9wQWThVKYiNZjhyNdRCoV8LAGNDUN
	 F8Eb709HoOmvvG6SUTdoIGoazFpXS06RDhkdTAmhxNLGqce/pF4KPLJqlZ4xYyXtMb
	 pdhpzuT6gJLSChvv/idVMq0Z4k/b3YY0Orf10QxbVdYzGJJwWlyz8QpLJHJyCM37VN
	 8+5SwvroftWVw==
Date: Fri, 3 Oct 2025 14:13:31 -0700
From: Drew Fustini <fustini@kernel.org>
To: Han Gao <rabenda.cn@gmail.com>
Cc: devicetree@vger.kernel.org, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] riscv: dts: thead: add more th1520 isa extension
 support
Message-ID: <aOA8e46KosVxuewV@x1>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:46AM +0800, Han Gao wrote:
> Add xtheadvector & ziccrse & zfh for th1520
> 
> Updated the commit message for the patchset
> 
> Thanks,
> Han
> 
> ---
> v1: https://lore.kernel.org/all/20250911184528.1512543-1-rabenda.cn@gmail.com/
> 
> Han Gao (3):
>   riscv: dts: thead: add xtheadvector to the th1520 devicetree
>   riscv: dts: thead: add ziccrse for th1520
>   riscv: dts: thead: add zfh for th1520
> 
>  arch/riscv/boot/dts/thead/th1520.dtsi | 28 +++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> -- 
> 2.47.3
> 

I'll apply this to thead-dt-for-next once 6.18-rc1 is out and I can
update the next branch to that.

Thanks,
Drew

