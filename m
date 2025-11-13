Return-Path: <linux-kernel+bounces-898413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76417C553DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB4D3A5202
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5FF267B90;
	Thu, 13 Nov 2025 01:21:55 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4025A33F;
	Thu, 13 Nov 2025 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996915; cv=none; b=BtS+2o/znwYFvDCRFZtIIyQXtzEx2iexT2F2WSRcQvTc7266fIQSpt/gzHKQwv1FV4fSltFYNi93eOOIh/PHm+CaON8Y0km63R8K0+NCqNj8RNsVjIF0aCRP42JKzJagVVGIhfFoKo3Q+a4d687RRe6kw4+Dl3DtHjlOGH36yHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996915; c=relaxed/simple;
	bh=4J2w0vQ2SIHCJ212oHrkdW5EhKGUnJtjrmEhtVi+nW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPTgAtPAXRSLNAXs3qJRmbEXNAUGj2q3QEmIBUOI2DJNKcl2Hc7lQGJ3I/+7PeuCI0OeqSdMHWrXI9Z/DyyqQk0CtBkiurW1Lo9j/h8jPbNMwBWtnBcvzbppGSmBAZoosJ4b8WCBrs9EmA/wbIThk5xy3MZ5DV2S444mGNAAP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-3b-691532ad56c5
Date: Thu, 13 Nov 2025 10:21:44 +0900
From: Byungchul Park <byungchul@sk.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Guangbo Cui <2407018371@qq.com>, Liam.Howlett@oracle.com,
	amir73il@gmail.com, andi.shyti@kernel.org, andrii@kernel.org,
	boqun.feng@gmail.com, bsegall@google.com,
	gregkh@linuxfoundation.org, linaro-mm-sig@lists.linaro.org,
	link@vivo.com, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
	masahiroy@kernel.org, mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com, max.byungchul.park@gmail.com,
	mcgrof@kernel.org, melissa.srw@gmail.com, mgorman@suse.de,
	mhocko@kernel.org, minchan@kernel.org, oleg@redhat.com,
	paulmck@kernel.org, penberg@kernel.org, peterz@infradead.org,
	petr.pavlu@suse.com, torvalds@linux-foundation.org,
	vincent.guittot@linaro.org, will@kernel.org, yeoreum.yun@arm.com,
	ysk@kzalloc.com, rust-for-linux@vger.kernel.org, ojeda@kernel.org,
	gary@garyguo.net, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com, kernel_team@skhynix.com
Subject: Re: [PATCH] rust: bindings: add `rust_helper_wait_for_completion`
 helper function
Message-ID: <20251113012144.GB75428@system.software.com>
References: <20251002081247.51255-37-byungchul@sk.com>
 <tencent_13F1EDE0D6B7A44697F31AE274C8E664E908@qq.com>
 <DD7RK3CJOYMR.24WFU9NPUEX96@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD7RK3CJOYMR.24WFU9NPUEX96@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfZ/v86vjtsep+Sqb7SysEVrsYwybxXeGCRvDxjM90zPXaRcp
	hkSWFML8KCH0Q+5kXYRFuUyH2kpNzxSFunVSfl1nxE0Xxn/vvT6fvd6fPz4iNti4YFE1b1Ms
	Ztlk5HWsrndE/hRbRJA67ZI3FNLT9kJbeycHP3MrBHC2pLLQcP0agvb+dARfB3IxaA1VGKzl
	+xg47d7HQs+pjzw01vUg2H+5lIeKlA4BPM2vGbBmujA03T3HQ2v9UQEKWhoZeN2hcWCvr8Pg
	PRICDdlZHGjHuhDY+i7xcKLPhaDHW4ihsP+DAFcvFCG4WZWG4PMVLwsHv/g4qM2qZqDA04eh
	1FWD4c2RXgHSH3oxHGibAXme6eC5VsLPn0St562IFjx9z9Mrh74z9E7OS4FeLNtO7cVh9HKl
	m6FlJYd4mj/QjWnb80qeOs8MsLQqzyrQVt9bTD91vWBp5sEyhr5w2bjlQWt1c2IUk5qoWKbO
	3aiLddUcRvHPuKTz7i42BdWwGShAJFIkOZl1V/ibtUYb78+sFEqOv20f4rw0kWjaN5yBRDFQ
	mkAy6qMzkE7EUrlA7BU92L8zSlpPsu9kIn/WS0B8N0o4fzZIZxB55Iz+zUeSx2c7h3qxFEY0
	n5vxO7EUQop8oh8HDJ5QfrppSBkkjSfVt2oZfxeRmkWSa6/7c/MY8qBYY48hKec/bc5/2px/
	2osIlyCDak6Mk1VTZHhssllNCt+0Na4MDT5R4e4f626jzw0rHUgSkXGEvvtsoGrg5MSE5DgH
	IiI2Bupvrh5E+hg5eadi2brBst2kJDhQiMgaR+sjvDtiDNJmeZuyRVHiFcvfKSMGBKegyZXL
	56W55QhaKvVfeDWPfXdrXFGTobvtwJJJKyyK6WFQVMBMwR4cfn/BsGUDjtlra8wtex4Xpcrq
	lJWzirNHDr+e+SU/OlK3NCq1d/ji6FGzPKtwc+2bRTFPPp5YWN1575Raz6c4ZZ9Drd4Sqjk7
	asemr45qjQ/O81zthDVJu3YZ2YRYeXoYtiTIvwCI95BPQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTcRTG+b//9+Zq8La03tQMFppJWUbGgcT65r+gix9KiChHvuRwrtjU
	UpK0i+matyK1lZWlVrqlzVtJpGioXQTNLkMts3JlM7utRVojZ0R++/Gc8zzn+XB4rMhnfHm1
	NknSaVUaJSujZZvXHl1uWeWjXvmgdRZkHz8Mg0NvGfh9romDrudHaOi5UY1g6Hs2gh+T5zDY
	elowmOszKSgezaTBUfSZhd5HDgRHr9Sw0F56n4GmjFccOJ8MU2A22jH0NZ9nYaA7n4OK570U
	DL+yMVDX/QiDK88PegpzGbAVjCCwjF9m4fS4HYHDVYmh8vsnDq5fvIqgoeU4gq/lLhqyvrkZ
	6MxtpaDCOY6hxt6O4XXeRw6y77kwHBsMh1JnGDirq9j1S4n5ghmRiodjLCnPmaDIbdMLjlyy
	JpO6ayHkyp1RilirclhSNvkek8Fnd1jSVTJJk5ZSM0cG3G8w+TLSTxNjlpUi/XYLs3XeDllE
	nKRRp0i6FZGxsnh7+0m0/zFz8MLoCJ2B2mkD8uJFYbVo67WwHqaFQPHUmyHOw6ywRLTZfmID
	4nlvIUg0dEcbkIzHQj0n1jU5sGdnrrBTLLxtRB6WCyC6a6sYDyuEEiR2dEX/1eeI98++nb6F
	hRDR5h6lPJlY8BOvunmP7DVVob64bzrSR1gstjZ2UgVIbprhNs1wm/67LyFchbzV2pRElVoT
	HqpPiE/Vqg+G7tmXaEVTb1KZ/qvwFnL2RbUhgUfK2XIy7q1WMKoUfWpiGxJ5rPSWN8RMSfI4
	VWqapNu3W5eskfRtyI+nlfPlG2OkWIWwV5UkJUjSfkn3b0rxXr4ZqKa2V7YpqHkLWZB8svrM
	IadRXvTZ6Fvttf2uJSrIejO4MckxO7AjNvKd7p4hIiCBXFy0LbL4SH/t1jUnnpRL3IfmjJyy
	kYGJMbmPaVVPf3Ht7qJl+cHD7K4DMXxj2Ia02NTryxob6rI6XNqIkomAseinFf6aidaFH/ue
	6V6mK/zXKWl9vCosBOv0qj8bQDGJIgMAAA==
X-CFilter-Loop: Reflected

On Thu, Oct 02, 2025 at 12:27:53PM +0200, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 12:06 PM CEST, Guangbo Cui wrote:
> > The DEPT patch series changed `wait_for_completion` into a macro.
> > Because bindgen cannot handle function-like macros, this caused
> > Rust build errors. Add a helper function to fix it.
> 
> Good catch!
> 
> Given that the latest version of this series was just posted, please squash this
> fix into patch "dept: assign unique dept_key to each distinct
> wait_for_completion() caller" [1].

Thank you all.  I will squash this into the patch.  Thanks again!

	Byungchul
> 
> Thanks,
> Danilo
> 
> [1] https://lore.kernel.org/all/20251002081247.51255-37-byungchul@sk.com/

