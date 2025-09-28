Return-Path: <linux-kernel+bounces-835213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B9BA6838
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD8717C7EC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 05:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40103299923;
	Sun, 28 Sep 2025 05:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="YHyCSYQh"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD31296BBD;
	Sun, 28 Sep 2025 05:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759036267; cv=none; b=EzOTUyBoh1aQxzmNniE2LFlgONGW2Px3SzTt3vz/cAKbZwuiE+uA07HTlnuM20Vb00vZlTz8QKHuk8zj25TyDlB+2CP9pxaVyZJZAUwYwA+PdpsebDZHEY8wb+urCamOmBpBpOzSmCCWCzfphXnlyoCIaBPbqovxdv5KzhiI6Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759036267; c=relaxed/simple;
	bh=dgrMc/Uo/13qWrdXrWXTuCexU2xaoZefC8ODGpwJdXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flEN8MdRosrSQCG4oRlYoE+jQC1P7xnezMpfvpehWRO5p/rNf0WcQLx+hmR5dornj4TwD4oZ1aX8K//DADz+AqQPOA1PPYzB+4l5j6QeVrAjpOESWdsZWlnJcBUjrBqH+8Gld31+/1yLEcKvBG0kYgZsxg8ViV2x5i7lAifliDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=YHyCSYQh; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759036243;
	bh=EyKXkmVhd4Wq/fftgbLmz5/5UTp8yXrHyMxbT9ejo7U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=YHyCSYQhalD7uOoETswqj63acdVa3znz41drzdSPgRp7pAZfii+cE3zXQn8c0NUsE
	 oC/hileZx8y/rBxc0sInEBW7TLAqojKGdaEv/84Gv0x3gnpxKg155W+esWkUd2b+aQ
	 JrVSdh99Xiz5OinzldLxjr0FzmoSZupviW/jvcKI=
X-QQ-mid: zesmtpgz7t1759036242t9f60582b
X-QQ-Originating-IP: vZrW/0ceR/bex1xwbBd/Y09KBS2r8jnRxCvwYU5DFsk=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 28 Sep 2025 13:10:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14443702317554781717
EX-QQ-RecipientCnt: 16
Date: Sun, 28 Sep 2025 13:10:40 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: E Shattow <e@freeshell.de>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Troy Mitchell <troy.mitchell@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <E3B55605FD767D42+aNjDUGk1LNF2MKwE@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <C16FB37F0982124F+aNi46yQc_e-gCIvL@kernel.org>
 <83fc0f4d-1e7c-41e0-87b3-bfcb84a0450c@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83fc0f4d-1e7c-41e0-87b3-bfcb84a0450c@freeshell.de>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Nv8rTAnDNEem+Hczdb9GDY+ux7F5xAdtctXcw4um3qUHc8EQBj8ViVMX
	sBbZP60l5Ut7avNI7QjAYlLqRVJ9pbqyX17augeVT7QX+KBUvXDUXZIzgc1PoCA0lKQyreU
	dGWuvZW4RcE/eaqOl5vyDu4vx55Lax9tJAw+YPhWy69EDkxjAqieIX9KtOVmWYyzs4dBv0A
	SiP/kIjAdv9AixncoPCujeB4BAGHLGJaDEovC2HYYhZ7qjot9x39WCDxtxsO8849WY90vpT
	VXnX7/FU4W8qI629iA7VV1ix+EcRmrV9dDVOAkGn1uQ3DUz/exHMVdRw1sMYt3mt2I4nggc
	itrynf2SuY5sJ3pNNmpJWJgcBqDMNnuj7XM4ISVKXwDyWNpCJvlIxKWfabDD2QXWfij+4br
	bI+Td9izOwobO89DsYDmnmcB2ioBaPJLtggYNAfJVlm9rFFQztjO6A4fnAbhHW3NyFQXMNA
	JSO85DqTdSbN0LWSLY7vOPTYxUS6l5pQL1AQ5MG9EYFmN6oPpwVwmZRwGuavlX4pa1bPaZK
	yRIetxvsIegVYTLvT2bkQlE/7IkJTFk6VGo/0bwm4cfgYamJqqqH4bv03NMeKQT2nFNL0iw
	weL/m918zIqwxsheMpUMPIsRS0m5SWx8HYaDpZfkDLVjhfL6eiraSQQPs6NshQ6860IfNH+
	URifwG41H5wzuT7jIvo+fSrOMiTMRUfoAjkr8wYWIROeWFOp53k6wkXm7pcfJboEND4bCrK
	Sj9dzYJIXF76GaiYToXMGwGOp7GEh6g6+qYgSkCDi9fk3UwIQc+uV1uUY9X8SzblV2Q8gsd
	aAyo6p9Mt2jf/8JT5SclwwjJBfIz/AnNbNbxi7B2cr05Em+EyGDeuPDyvFMz98C9ZIqD1If
	z3w4xmgXKnZPkNV+0YC37zEDht8Z3XPZ6G66533e+5psDWMxvDju/jEksns4qqTGYcKbL5w
	8Q7rZsu7bY96Zl5HmAY5Bj2c1kxlb3Pjm5ErrMky4GgxIGza/oBWgkkR2StuMysF0Xlpjpr
	whfUL+MDeC5PWCxEmX4pcITmMNaAuKJ+ka2T85h/81SF9+N7zYR/4NG0G4vwEwy3AGH9mW4
	nVDCzr9DxGtd1PNGKEaRdSMsxgS9j1zwXOGKOdU8L4zgGZolTFhZ8000C2c4rxoKaCOSDqt
	WofH
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Sat, Sep 27, 2025 at 09:56:39PM -0700, E Shattow wrote:
> On 9/27/25 21:26, Troy Mitchell wrote:
> > On Sun, Sep 28, 2025 at 12:16:48PM +0800, Troy Mitchell wrote:
> >> From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> >>
> > My SMTP client messed up,
> > and both 1/2 and 2/2 were sent from the wrong email address.
> > 
> >                                          - Troy
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> Confirming it is showing up now. Thanks -E Shattow
Thanks for confirming :)

           - Troy
> 


