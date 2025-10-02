Return-Path: <linux-kernel+bounces-840125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDDBB3A10
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3B23AB825
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C37C3093A6;
	Thu,  2 Oct 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nx/hXwd+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C78272E7B;
	Thu,  2 Oct 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400883; cv=none; b=ghDtoNPABN4X26XFhiYTU98hLX2oXunoM1S9idqs7G5fvAiewuAqOcFqZQ4XtzLsG4Ah3638Ls5Vv5GElqG5dn4jI7UhyofMWaS5ouXuJufBRL66ORpErdszQWDVlzuk1wLwqQSgLHHLJrCVucz3KedCV7rDwUKS+YBjQ+pjVV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400883; c=relaxed/simple;
	bh=d1/mluIS30Lu5giQZYTMX0VJ/90APcS2qriKrQpYrFk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uN6DoGHsqz99sq4ZXcXcHI3NCpbPTtTs2iMed1ZpFKTO4Ywpv7tYz1eg66oCHKmuLy0GGE1NMuxGHWD7CKelH1a7p5I2u9NId7BNFYCzsjJxG8U1xsJifXJx/xecvp27BX6EKTNpqbegg4EP8nhm0XybwSr1jF78kD1dUwWDKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx/hXwd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB817C4CEF4;
	Thu,  2 Oct 2025 10:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759400882;
	bh=d1/mluIS30Lu5giQZYTMX0VJ/90APcS2qriKrQpYrFk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Nx/hXwd+2LQZiiLh8XsG8P7K9FNALozCrWgRpdCFfnNtCiaI/gXGOJxTvXO8c2uOM
	 zd8QPRF1CNtxzWAZXqfcNokMPMQaM7Vagn6EZk22z1m60+OuiNbGtRAUkokN0rGJN8
	 gKvFzZ+z3DjYrUw8bRkBZporMg6U46LE2QVZebKFWTChNvid4iDoxFOvMRERAwI1Wo
	 zb5BeLCI2ObSAU4KhJKynvEU7BjjYHviCCqiuLQBzutUFTbLcU1n8yPKzPcRR6NnD/
	 REedEsaMgSZ9uOoZUMmf1T5NsJlGwxcfR7nrXoPfPBGPrXueriX+HnGnIJ3IgRoC2v
	 b+VnCpL67Vi9A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 02 Oct 2025 12:27:53 +0200
Message-Id: <DD7RK3CJOYMR.24WFU9NPUEX96@kernel.org>
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
Cc: <byungchul@sk.com>, <Liam.Howlett@oracle.com>, <amir73il@gmail.com>,
 <andi.shyti@kernel.org>, <andrii@kernel.org>, <boqun.feng@gmail.com>,
 <bsegall@google.com>, <gregkh@linuxfoundation.org>,
 <linaro-mm-sig@lists.linaro.org>, <link@vivo.com>,
 <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
 <masahiroy@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <matthew.brost@intel.com>, <max.byungchul.park@gmail.com>,
 <mcgrof@kernel.org>, <melissa.srw@gmail.com>, <mgorman@suse.de>,
 <mhocko@kernel.org>, <minchan@kernel.org>, <oleg@redhat.com>,
 <paulmck@kernel.org>, <penberg@kernel.org>, <peterz@infradead.org>,
 <petr.pavlu@suse.com>, <torvalds@linux-foundation.org>,
 <vincent.guittot@linaro.org>, <will@kernel.org>, <yeoreum.yun@arm.com>,
 <ysk@kzalloc.com>, <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <gary@garyguo.net>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <alex.gaynor@gmail.com>, <bjorn3_gh@protonmail.com>
To: "Guangbo Cui" <2407018371@qq.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
In-Reply-To: <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>

On Thu Oct 2, 2025 at 12:06 PM CEST, Guangbo Cui wrote:
> The DEPT patch series changed `wait_for_completion` into a macro.
> Because bindgen cannot handle function-like macros, this caused
> Rust build errors. Add a helper function to fix it.

Good catch!

Given that the latest version of this series was just posted, please squash=
 this
fix into patch "dept: assign unique dept_key to each distinct
wait_for_completion() caller" [1].

Thanks,
Danilo

[1] https://lore.kernel.org/all/20251002081247.51255-37-byungchul@sk.com/

