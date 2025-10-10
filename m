Return-Path: <linux-kernel+bounces-847628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD92BCB4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868EE19E65E2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E444213E89;
	Fri, 10 Oct 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="pQ9NDHKU"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7A1A275;
	Fri, 10 Oct 2025 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760057820; cv=none; b=OewIsb38jP3ZEuviLCL9aLopguvJtgJvXJ5TtulN0vfqeQrN1Gs2coM05LEQ5iYyikNVtW1qZbvhw59IciABmBPpgDFNArW0He6Np3KD5efnwNE1M5oZYMeVqiRotJ6jWpPJo1M9Tk3zVKIdfD+DYtWX2n7h7UKdqlotlzRLoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760057820; c=relaxed/simple;
	bh=VdkLWNGoSoWb9dUpbdZ5uS/cLKsn0M3yhQkZxhoECNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTccp30AIBEiknQb407LpmbKe+NC760xKsza1ixJjcve9JsV0N5volqKdPr7Bw++7Q/sStzddmxbXCVC3UCY+UtfdWsLmN2DzlLKulg6gYwJyzGvDlLO5CrPFOWq1fXIuoLHRk1WZPsM1FauFS6Y9+eHpqu+QFZMqBZs+uOWnVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=pQ9NDHKU; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1760057791;
	bh=CyvlSdXG8TtNo3ETOGHHmQ0/SGXil5W+cwusE27OmWM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=pQ9NDHKUZnwxkBjpg7m6qhWpH2b8qWx47NdNECdJoCY7iYQA4MFQd9XsyO8YvKvfw
	 2tXkOMe2pGNe953CJzS3T4ahqaf257YSAcEcs2mfBvCXJ9AZ914HIVftxccussFINs
	 rLtpUDMvtLiYRZG021BIdvgNvQHxFPQ+E4bZoPIM=
X-QQ-mid: zesmtpip2t1760057789t9ba13e2a
X-QQ-Originating-IP: upay9BIZzUs6ukPD/DewrCcUCwZLERSWByypQTR/LpY=
Received: from = ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Oct 2025 08:56:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16317150121370824884
EX-QQ-RecipientCnt: 16
Date: Fri, 10 Oct 2025 08:56:24 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Conor Dooley <conor@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Yixun Lan <dlan@gentoo.org>, Troy Mitchell <troy.mitchell@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <4A760DE7DC8BE2EE+aOhZuGN-RPGwnEfJ@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <20250928074914-GYA1344940@gentoo.org>
 <20250929-challenge-molecular-947bb1f5962b@spud>
 <A5845378AE731404+aOdtKmFPaYfc2n7n@kernel.org>
 <20251009-crazy-outhouse-fe3e47d0dbe7@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-crazy-outhouse-fe3e47d0dbe7@spud>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OOO9dHjlsLs7LVAoif0I5hWrfmV+DbelgjM+jI98kumbM0hMjlQ0oqWS
	HT4TO8mQlLLM3cqOaW5+O4M+E9CR1XnYKgR79ovFlOP4bY6WUY0Kh9Am1VQfMuDNMgeK5ZD
	3yf+vVtpZz67hwzVRtGKDkV7Q7g0tr4me4ZNkMnZLESlOPR5m+RCl3LdEIYo7Zpcf9em12n
	TcKiqpYRRyy3mtMhsUm+k+E9XbeUtgMMx3GdzFQUwSaHApPcqFaLnalNCPOAQsm9Y1msDyP
	Ivy9GgRBd6GMTw3PcA975h8J0uguh1avQltqLaAwWHhyISMQDc6s+WJ6yFd0SKa6AM3iam4
	GTqv3CdlfbEa8mv+MZe4baIM/AS3NqEqEVbJtySE1W79CrcNoTOHHI/XyvwEv94T/gZJlFV
	6+ZUKElQrccV2n/1pR/et1NN86suGyuH3oJ8GkK/fdxPK/Ne3/QzcDRPOPchjTsMyLDuomS
	IguU56wnTaV0wwsQFLPxZRVX8yOFMT7aIMb6CAY0EC1L2KPwOrXxfSHKvvbFeGmvE6zMaet
	uFSyYhhs7M6W2fUWfwZJxY1klVzd1CBsWqbfKvoPqPfHDnyVyyuKTFegRux1xkV64A0XEpX
	pekwHjGlZQcIDsPcMpPlXXtDXYyCHkWvyddPoaYTdSBpHj0y/kjdfltyGQOg/M+sUR0zWR3
	8axGUbk6Y75nR3lh17T2CR1+g+HauTX35p3zq2oz1C1Cg2MIw3n2LbUvab8c4rtQGMCVklW
	WoZLbKB1OQU/fk6Ev7WnSrib1sgRVSEiDufQO0l9WacOS0bon6lJsEaQPTGeTwWyynB6ztS
	HOQKb0KNy1kdmjj9+/m0BbIIifs+KhYp74K0ZwWtEr9kG+qcKyZAR05YrtMenjugFxTy5J3
	Bg6qtk1jstyyczXe3UOW4PXGEoElhhDthNjXQDQuBJHbIbQtPT2+sfY3geFqCWSCOKeDR/C
	/RQbPk1YEgTVATPSgc5sugjoijt2xgEe3kCmY3/PWkF1GvIm18kl6a2WWlWZiRTRb4sr+5o
	ACaC2Bss/2OHwcSqYV7dh+RBYEwz/tVmz/Pi0HHw8HQ8S/v9IBJ5/87O2aUNXXVuaD/Zx/U
	4v3jK7WhnZn
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Oct 09, 2025 at 04:27:10PM +0100, Conor Dooley wrote:
> On Thu, Oct 09, 2025 at 04:07:06PM +0800, Troy Mitchell wrote:
> > On Mon, Sep 29, 2025 at 06:48:22PM +0100, Conor Dooley wrote:
> > > On Sun, Sep 28, 2025 at 03:49:14PM +0800, Yixun Lan wrote:
> > > > Hi Troy,
> > > > 
> > > > On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > > > > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > > > 
> > > > > Document the compatible string for the MusePi Pro [1].
> > > > > It is a 1.8-inch single board computer based on the
> > > > > SpacemiT K1/M1 RISC-V SoC [2].
> > > > you could wrap at slightly more characters, I remember 72 chars
> > > > (haven't spent time to find a formal document link..)
> > > > 
> > > > > 
> > > > > Link:
> > > > > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
> > > > I'd suggest to list core features of this board, while using this link as a complement,
> > > > base on previous experience, vendor may change the link address, thus the link vanish
> > > 
> > > The link doesn't even work for me.
> > Could you double check if it really doesn't work now?
> > 
> > > Is this board actually made by spacemit as a developer platform?
> > Yes.
> 
> With the link, that seems pretty clear. Not sure why the link didn't
> work before, but it is working now.
Thanks for you confirming.

                - Troy
> 
> Cheers,
> Conor.



