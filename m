Return-Path: <linux-kernel+bounces-872613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7CBC11934
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8226A4E5AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF2D2DE71B;
	Mon, 27 Oct 2025 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="a+DGzPiT"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F22741DA;
	Mon, 27 Oct 2025 21:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601623; cv=none; b=s3CuSBtsDxYLq0M2t0WLLw3zV82hnRnzvW856fs/liNLk4QXSmbcVbRudD399kex3XZBzMKP76BxcSbIfgAOw8F5Fmx8t+irsgjlSk8gIss3pRez0Vu/cZcUJtR7gWIUlqkb+xDj+Y76f+bMu0ULI00wMjE3EuH02N5JKps9UqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601623; c=relaxed/simple;
	bh=osOrtDpU7pZC66nxRP4PGkWRMoZiqRS6T2PAo0SDPLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCC0GlypR2HufN8wk9K96l5WjPp5TrRSlL1vbdLWog8KnVjZdHFanqYETwRW1oDk3ea7fUgIaEkqoUuqi9MWh8Zzl+WrHB1twPQGAr3nnpmhz+xx9mBR/SX7ODkDRgjHJpIQNP0qmt7UbXOsLKY5980d6JqojPEimTLcnzQzO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=a+DGzPiT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SLOXmimtKRZScvvlqQxZfzkysLB99aDx6hb5bo1wlp0=; b=a+DGzPiThC+REygfARXSFfiuQb
	PMc8nF8WUUNzZuxziK1mT/8A0R7hIdkeEn1AWI5GC29+yc05NrDreDw+b+hfpXXuly3m8rLG0CJRn
	XQYejtGUT2rZ/hnZkuphaiW1NFOxOUwiGglzEDC6f7w3iqqN/PcPHFoVUm+nv9s4Kipo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDV3G-00CEdF-Tk; Mon, 27 Oct 2025 22:46:54 +0100
Date: Mon, 27 Oct 2025 22:46:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Jaeckel <sjaeckel@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@kernel.org>, anthony.l.nguyen@intel.com,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	dima.ruinskiy@intel.com, Mikael Wessel <post@mikaelkw.online>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch
Subject: Re: CVE-2025-39898: e1000e: fix heap overflow in e1000_set_eeprom
Message-ID: <a42d374f-22e8-466f-a7a5-ef1d51ef6635@lunn.ch>
References: <2025100116-CVE-2025-39898-d844@gregkh>
 <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db92fcc8-114d-4e85-9d15-7860545bc65e@suse.de>

> we believe that this CVE is invalid since the sole caller is
> `net/ethtool/ioctl.c:ethtool_set_eeprom()`, which already does all the
> necessary checks before invoking a driver specific implementation.

It is either invalid, or the fix is only fixing e1000, and very
likely, the same issue exists in lots of other drivers, so the fix is
wrong and should be done somewhere else...

This fix adds to the e1000e driver:

+       if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
+           total_len > max_len)
+               return -EFBIG;

In the core, ethtool_set_eeprom() we have:

       /* Check for wrap and zero */
        if (eeprom.offset + eeprom.len <= eeprom.offset)
                return -EINVAL;

        /* Check for exceeding total eeprom len */
        if (eeprom.offset + eeprom.len > ops->get_eeprom_len(dev))
                return -EINVAL;

Are they equivalent? Is the core broken?

I will leave it to somebody who understands wraparound to decide.

	Andrew

