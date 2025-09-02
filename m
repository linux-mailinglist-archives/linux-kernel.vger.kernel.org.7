Return-Path: <linux-kernel+bounces-795820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD55B3F84E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C010D189B3EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF82E88AE;
	Tue,  2 Sep 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouuy/hTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F83D76;
	Tue,  2 Sep 2025 08:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801676; cv=none; b=G4nAtiDhmtBN/Od1qCXdHSVRngmSzYdWMyAyWs8CpATfNEzEwbV46mGfughACNaOPPELyEoTiTdKP6aYw0g4KOLB7GJ5BBPb1R4OhdEMr/nw2u/ITGJFISX+f0vBih5xU+TMOohgOFxjTkbfdJe5emG6BCk7njW9LAPVtmIrUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801676; c=relaxed/simple;
	bh=LRzJOBxtCeh0osBT/DCK+SnqLQnyRNU+e7M/gZRt1JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alYJHhzlLT0OeD0AoafU9MtWzKROaZmAo8jfjwSf60nM6q2k0QlmEwV9chUf/0Pu/aHlJl52F0lltcG0ysiMftfJeYJ1gv9nQon4p8Pu/ZeK6QmmAsFZ1vEI0aP/agDsHY17ke4LO3n4dePacyDqHqJp2g7A/HEc0phupwBH3GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouuy/hTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95254C4CEED;
	Tue,  2 Sep 2025 08:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801676;
	bh=LRzJOBxtCeh0osBT/DCK+SnqLQnyRNU+e7M/gZRt1JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ouuy/hTdTiZsA9kGnTozVS6D5DWVfamu5aHp0HV1Nba9G2UmuiU5kJo34P4KfhVvy
	 TTuD3pROCPNaLCGL0d64ovtRta6TlwuVm0KZHsNZg51n8TRA18o3rHq0Wr853kJl4Q
	 HxFK+SNopggX/MRq26OqAjsGIcUmeFK9i6gFdhD9myMMGy0kKVJIo/u9Aa0EE5W3VN
	 WGjmNtu2FFOpAgALZZ2u9URVjQDJVPrJgw8fXhza1EryxGcuSpJaumwUPjMkYZyei4
	 CYXGdgLqOyyOsgfL5D7E2VzaSYxe+8AJBwLVIgVyBArruhM/cxDC+6jWkOKAiAor1J
	 oz+mUKqoxSVtQ==
Date: Tue, 2 Sep 2025 10:27:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Icenowy Zheng <uwu@icenowy.me>, Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/4] dt-bindings: reset: thead,th1520-reset: Add
 controllers for more subsys
Message-ID: <20250902-peach-jackal-of-judgment-8aee13@kuoka>
References: <20250901042320.22865-1-ziyao@disroot.org>
 <20250901042320.22865-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901042320.22865-2-ziyao@disroot.org>

On Mon, Sep 01, 2025 at 04:23:17AM +0000, Yao Zi wrote:
> +/* VO Subsystem */
>  #define TH1520_RESET_ID_GPU		0
>  #define TH1520_RESET_ID_GPU_CLKGEN	1
> -#define TH1520_RESET_ID_NPU		2
> -#define TH1520_RESET_ID_WDT0		3
> -#define TH1520_RESET_ID_WDT1		4

This is ABI break and deserves explanation and its own patchset.

Best regards,
Krzysztof


