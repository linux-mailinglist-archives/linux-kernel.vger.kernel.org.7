Return-Path: <linux-kernel+bounces-731914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB2B05C91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D5E7BCA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D932E49AD;
	Tue, 15 Jul 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OmnU90SQ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231F2E49A2;
	Tue, 15 Jul 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585902; cv=none; b=tGKknPCQ8jOklzAoKFTNBANq3G7u4eQtYRw5XYvulnnp/wh8rX6H6famIorwXFxnZuZxU4NFxUx2lWWzEZ5eoqMM46N06qsCHSvQORP4QEgukSEyj6/+VcafPwIT7tUQBM1Eb3zRdVMelwW+Yc/spSenmcBhnb/34qaUHd8PxSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585902; c=relaxed/simple;
	bh=m3DHASIkA8xKervtSWzCWs/rmNGNYcvXNTqN9riIcxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blzK0KPINZiz+d3kawVcbAuQdyWnrKjXlW5fc3wA67mnR8QMYTGnJKeEidHgkjUf13oCpYfnQ33oWM1l28DDHwy+zPLidcZb1rIFSKmT0jCWUwo1RRBvVceOeNWM4WJ9Wm9QtEF4hncaKEskXIst3fiuXXfMHA5xUhqWHbznuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OmnU90SQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wNlaWSamDFSq/Jqem+yHh7sXr1BP0uqXoeYgV7dAIAg=; b=OmnU90SQmj6FYkOolhCcdTrR+o
	zyKw9OqcgK/AZU1z3tng3XVyXdC1fDwNb+2EEM8PxBntc/ZLiklywaoyGmU9kQaxlXj1jwqgpBwhV
	lbJjDSe9EZHrgwWZOeYbUOev4o86kKFn606iI4J8s5+mvllfv+fqaX+qMUL3ZVVv9osE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubfeM-001a9h-W6; Tue, 15 Jul 2025 15:24:50 +0200
Date: Tue, 15 Jul 2025 15:24:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next 1/3] net: stmmac: xgmac: Disable RX FIFO
 Overflow interrupts
Message-ID: <b38cad0b-c2b1-44fc-847c-140066a12652@lunn.ch>
References: <20250714-xgmac-minor-fixes-v1-0-c34092a88a72@altera.com>
 <20250714-xgmac-minor-fixes-v1-1-c34092a88a72@altera.com>
 <bef4d761-8909-4f90-8822-8c344291cb93@lunn.ch>
 <21a0e265-6b2c-4bcb-b0ac-5fd47503f909@altera.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a0e265-6b2c-4bcb-b0ac-5fd47503f909@altera.com>

> > What is the reset default? Would it make sense to explicitly disable
> > it, rather than never enable it? What does 8a7cb245cf28 do?
> 
> The RX FIFO Overflow interrupt is disabled by default on reset. Commit
> 8a7cb245cf28 also avoids enabling the interrupt rather than disabling
> it. This commit mirrors the same thing for the XGMAC IP.

So same as 8a7cb245cf28 is good.

When you resubmit with the correct Subject: please add Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

