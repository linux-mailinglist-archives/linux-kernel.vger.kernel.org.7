Return-Path: <linux-kernel+bounces-845814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9FFBC62E4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3014E6CBB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ECC2BE636;
	Wed,  8 Oct 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk5N31tX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E026A0C7
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759945859; cv=none; b=K/Tp2DFhXAxLtjHS/9h2SGRzT13xZVQTu1FOgsHKMuJFYu95/4BpRNAi6ov0cqf92H9lzaiuPPY5vv2a0a6hohME7BMyfc9RQYbhhqdhRkFPSD8w3JVlBEg6KFfUW02MXiXK1YscPgFSUYOGnhBUXL7poGi09lKUFjOhHI8ADKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759945859; c=relaxed/simple;
	bh=Da1eqrZCMQTfiA7GWCzrdL36EgR1rBWR0A1debnvh+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=afi2Ia88ceEs5S/pYlgQFRFvPqiIS1krcQwjVos2EYsUwpIvpdd//hhP/yBQGUeFZ17GRWtjJxxDH4lpy0Mjm6lmbu50o4d1XVu0+L4J1Zgcd5GdtiIzT2a65EudiQqay+gq7JgQ2f5sdhWbUBurMftc3Cx1Lac2huv96ei1Ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk5N31tX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66A8C4CEE7;
	Wed,  8 Oct 2025 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759945858;
	bh=Da1eqrZCMQTfiA7GWCzrdL36EgR1rBWR0A1debnvh+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Rk5N31tXSG7Lp2JaTap0qUfFvs8YVYtXUVWw6RnBnjRcZAyBY3BkrvAu7UB6nWMIJ
	 J6KOkhYHVddhUV9dd4BbNHgCTHNYq/6WOHYqyjJHga8bhFCcXJodrTUvYKStFuFlg1
	 EQbgMQd21Ecwwlq8Q9cR91MACITK+u+U7COzWZ6NqViUfpmfrlBgHNYs85kTj59xRL
	 YG77XzyPn7F4ppwUkg6oGdb9RfpPXI6Y5236eO1otbwr2WQ0J2kXdFmo0pcoohe+V+
	 QXLbfeGdjz/eFuz/izGdKqNouK12Fd5DtV7z5DAUvWd1ZeEsDwblWaDSSStqlqnvGE
	 lfGlxMPxXW9oQ==
Date: Wed, 8 Oct 2025 11:50:53 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>
cc: pjw@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins <charlie@rivosinc.com>, 
    WangYuli <wangyuli@uniontech.com>, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: cpu-hotplug fix
In-Reply-To: <20250919132849.31676-1-danil.skrebenkov@cloudbear.ru>
Message-ID: <7bc8eb67-0a48-1756-c907-dae7751b4c98@kernel.org>
References: <20250919132849.31676-1-danil.skrebenkov@cloudbear.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Sep 2025, Danil Skrebenkov wrote:

> openSBI v1.7 adds harts checks for ipi operations. Especially it
> adds comparison between hmask passed as an argument from linux
> and mask of online harts (from openSBI side). If they don't
> fit each other the error occurs.
> 
> When cpu is offline, cpu_online_mask is explicitly cleared in
> __cpu_disable. However, there is no explicit clearing of
> mm_cpumask. mm_cpumask is used for rfence operations that
> call openSBI RFENCE extension which uses ipi to remote harts.
> If hart is offline there may be error if mask of linux is not
> as mask of online harts in openSBI.
> 
> this patch adds explicit clearing of mm_cpumask for offline hart.
> 
> Signed-off-by: Danil Skrebenkov <danil.skrebenkov@cloudbear.ru>

Thanks, queued for early v6.18-rc after cleaning up the subject line to be 
more descriptive:

"RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid 
rfence errors"


- Paul



