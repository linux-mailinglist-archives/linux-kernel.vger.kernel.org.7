Return-Path: <linux-kernel+bounces-825926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975D5B8D22C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6653C178BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F772853EA;
	Sat, 20 Sep 2025 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSGJRckd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461325FA0E;
	Sat, 20 Sep 2025 23:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758409924; cv=none; b=iK0EesNTC462IOisbULr5k4IpPFZHp9zEOc9KvC//jMX58N+KFXwCNiwid/88ibv8YmWXYU6qJiDgnQAqWV/4SMhXDfU386+osmpTDJQEAvVJ2AGwR5OdeCleCvDgFM/JoDCR/eqjHi6YNOK7Wlbm3QnM1LxZnGttSftyTdvpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758409924; c=relaxed/simple;
	bh=Xz0ZO8Amtu9KkICAzIlfDkm862T/8+/a/0h4CNym7TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oP5Uojq+EKSLAtErcXF1I0xPJFq/umCeVPTLWpYry/+XTqbNAf+e9+UzY+tBscp9Hj8FOGgiwwBzfqZmIX5fp+Qs49DJlJwa9Znbmw2oR0TJwKiE09NK6COepzK6LJBWexMgnlODqDI+Ft4tHIVV8WN2+CmGkZmmrZvVhgaKE8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSGJRckd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AD1C4CEEB;
	Sat, 20 Sep 2025 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758409923;
	bh=Xz0ZO8Amtu9KkICAzIlfDkm862T/8+/a/0h4CNym7TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSGJRckdldKLlEis/93BetnOjwyxMW19G3O1dui2TpdtDhX1ZokF/vQNqxPkr1EBS
	 EUjmr/u+5ggVDPbHclssDZkifMJiasT84Urxw8tZ9MmKluiPyWNT3Vg6LNpf/+8l1T
	 1WimfKmfFmM27WWQ0W3Gq/FZ7VGS5OpPiJI1CXKn6ubETezfAaF8PWOxPEEPDe0ugs
	 sMWPsBjd38bpoB3kP5kAY/U+las7leL4YLwrZkg11qSgG6CU9H/MEmfSpU6XVzPsXi
	 vlrbVJSdY4LgmIKhueVlPD3TWN/peseWpkCEsXFnhpMZyWaYMSqO/sacIjqY8TQivT
	 EgDxHkFieqD2A==
Date: Sat, 20 Sep 2025 16:12:01 -0700
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
Subject: Re: [PATCH v2 1/3] riscv: dts: thead: add xtheadvector to the th1520
 devicetree
Message-ID: <aM80wXloinEr6srH@thelio>
References: <cover.1758228055.git.rabenda.cn@gmail.com>
 <1ff3fb07b24fb375fcf9d3067aa50583f47c35fe.1758228055.git.rabenda.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff3fb07b24fb375fcf9d3067aa50583f47c35fe.1758228055.git.rabenda.cn@gmail.com>

On Fri, Sep 19, 2025 at 04:44:47AM +0800, Han Gao wrote:
> The th1520 support xtheadvector [1] so it can be included in the
> devicetree. Also include vlenb for the cpu. And set vlenb=16 [2].
> 
> This can be tested by passing the "mitigations=off" kernel parameter.
> 
> Link: https://lore.kernel.org/linux-riscv/20241113-xtheadvector-v11-4-236c22791ef9@rivosinc.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/aCO44SAoS2kIP61r@ghost/ [2]
> 
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>

Reviewed-by: Drew Fustini <fustini@kernel.org>      

Thanks,
Drew

