Return-Path: <linux-kernel+bounces-846416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7261BC7EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553061A60D88
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A883F2D192B;
	Thu,  9 Oct 2025 08:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="WiaOkJNj"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86729D292;
	Thu,  9 Oct 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997279; cv=none; b=ePUWKmoC/QeG92DyU/Oi2AX8khYLv3m45BiAufIR75php//AFAvmZOvnM0QRkqLBoOsZC3H6Y+nmoUx0Q54LImFFwNO9aqOSN3bts4cZ0qkmkoI98Ad/6tMM/OCHwaRGkEioHdA2la7jSQ8KVcXWNO/Z8Y1/8uCK5XmOtNzIQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997279; c=relaxed/simple;
	bh=DKsNxhZuvjGgb7iyN4foc8ZS/xGsFnmU8aui+Jb/OlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbE5LepU0RfrYIP58Hw0Xh5UuJnbrR9WoeuaBKiON3Xe3BVxm3V4sSfd4OAP1vi/zpCCeH3Iqiek27felr5CoAyBpVC4pOoTTRSVkDOYmdRvmQLGEq8BQoyTWbcVEQfrzIAATsYkORwhM0WvP12QuI1TIhzOojInIh6LTbJEp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=WiaOkJNj; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1759997231;
	bh=QomI1gNvaUojwqQoknXFY7m4GYm6zxoKTgnI/BnC6LY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=WiaOkJNjAfaOxrrDPIS7pnBdL6f1nW9gDe0qY/RG0qlJd/MbAJ27jdS+34kgOUmRl
	 gLVV9BZ4jBbW5badASFhVDHnU+USXqRKFu6uWqYBeENV2WNIY+urgKjT5maAFk8SS4
	 iRy9cmlmZ+J6TV6nHE6bjlgrhoE/uTu+lpJ8a6U4=
X-QQ-mid: zesmtpsz8t1759997228t014935b9
X-QQ-Originating-IP: 3K5W0OLDLhEJGiGik9gi2j2qEwUpKM2FSNoCg+xeMgg=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 09 Oct 2025 16:07:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2621622551196741310
EX-QQ-RecipientCnt: 16
Date: Thu, 9 Oct 2025 16:07:06 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Conor Dooley <conor@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yangyu Chen <cyy@cyyself.name>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: riscv: spacemit: Add MusePi Pro board
Message-ID: <A5845378AE731404+aOdtKmFPaYfc2n7n@kernel.org>
References: <20250928-k1-musepi-pro-dts-v1-0-64d0659dfdbc@linux.spacemit.com>
 <20250928-k1-musepi-pro-dts-v1-1-5efcca0ce3ae@linux.spacemit.com>
 <20250928074914-GYA1344940@gentoo.org>
 <20250929-challenge-molecular-947bb1f5962b@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929-challenge-molecular-947bb1f5962b@spud>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: Mp6z4bZjgTSTBwMUNg8zA9wVxazGdIn93I9Zu21FdJDVa3RXuD+vQjXh
	HHdxaylN9cjOmrQ/WgbLFNFtWLqcn08nuxMpo9RxJR3NopPzZUNsZdRr/08pXyUJ6GMpky9
	IfLW2D13rw7HxB9e1LGPf987k/TreNIwYE6R7en00JWSp1rnbXxeUYfGiKV9gUJz38tjZAK
	kVCx8+/y3vXwr5EsoI+L5M1qqyHVsUAehlvLVThtrWFem6sXUgwFTgWoJOS8yEwcRrRm2Eu
	5xnNR+EMSuhVE1/IqJmEEGv4JPi34oniOGdlInUE4dDUEQCzdin0EBpmNFZyFJ+2pcoMDlr
	ztDKM87TqqndgJzwD6zP7ZKNH46XcumRbtTdSm8AlV45iuUgL48zPpn0mARgzhacWDrRZLs
	WcmSolLIF95e7Y02al/G6q0S9RClEdsnTOG1UhYvkCLECMNWWhYNLq543+Zd1jmz6Ygu1nB
	2w7hZrJiaDUVsahIr6ufnvr4xLZEYwsDLDEFblCHCLxXloVHLQaHib3ZaLY9khPiHZ+zVux
	VGchYJ3bpMPzBEXafYNgnGcipSA55Y8qrSGaMp2s0EJjoJSG8TEPWnDi3FWUcGII63HViBm
	RaURwpJHmXGDZIxfqUwU/Yoeq2QYpSoBGXt1sE/a2rfltAY3uUYLJFXznjdHQOY67PtdM64
	tJY2dzS7czbY12eZIOeXaN6HUBXkwoVHX4NELTic2Qqmln3vReQECz1qydVkfRQolZMeNOR
	j3CsR/RUVbDxYQ3zhjEY8dhhh7coqluyK7qO0O4WL0vXznJuq8PCMFctXHKSOwVUhD+1g6V
	YPo55Mz7KO5VtZuomMD7cGFsuSqTeApa+C91VJfkFaXpDzVAM5oL4qGOvuhCuWB8beKvZFs
	qpd0dWanYd0adsyTgO17UvE0/1KZNcf7cPyA9jIEu1l4wtvKT4L76Al6Jbsx7jYeAvKfQ7M
	Adf7CFBMRBTvACRg6C8nqJUI+UZWpncN7H1SpEVkV8U6md+q7tlv1zfs7tiSX68Wv4eXiWl
	ngPxh/xy4WfGQd19YCwznKLnCAdZo1KP37zgtBPmUZ1iB1GXuz7v245KXLKSEts0gVK5x3J
	6N4GfVqoVZvcjNrGeRi7iY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Mon, Sep 29, 2025 at 06:48:22PM +0100, Conor Dooley wrote:
> On Sun, Sep 28, 2025 at 03:49:14PM +0800, Yixun Lan wrote:
> > Hi Troy,
> > 
> > On 12:16 Sun 28 Sep     , Troy Mitchell wrote:
> > > From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > > 
> > > Document the compatible string for the MusePi Pro [1].
> > > It is a 1.8-inch single board computer based on the
> > > SpacemiT K1/M1 RISC-V SoC [2].
> > you could wrap at slightly more characters, I remember 72 chars
> > (haven't spent time to find a formal document link..)
> > 
> > > 
> > > Link:
> > > https://developer.spacemit.com/documentation?token=YJtdwnvvViPVcmkoPDpcvwfVnrh&type=pdf
> > I'd suggest to list core features of this board, while using this link as a complement,
> > base on previous experience, vendor may change the link address, thus the link vanish
> 
> The link doesn't even work for me.
Could you double check if it really doesn't work now?

> Is this board actually made by spacemit as a developer platform?
Yes.

                    - Troy

