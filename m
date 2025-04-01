Return-Path: <linux-kernel+bounces-583647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37234A77DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D1B3ADAC7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B5204C20;
	Tue,  1 Apr 2025 14:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MTCSNC2W"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D11F192B;
	Tue,  1 Apr 2025 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518170; cv=none; b=h12izFnbzhFO79d/ww9vnSgyQ2KvClz4gn7SguBdfu1bJKBpUy9I/jxEOm121F1o5pJbkRifMkQqW9h21PZM/5muPpvzEohWSZDDFTOA3P7980Oy17NVH8DNQELaENsV7xiNHjwCp4CKAKQxtZmgGkqj7CiOcaFaPp3b34TBXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518170; c=relaxed/simple;
	bh=keXjzvWgFPpRIBHgUNsIP+Wdn4sX5m9QLvX3VUjl26w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXgXdAp60lvRsG2TluPRlgsbHS8Pm773962Nw1zy3cG3DM8SawraGfffjsFZoGsmsN0eutky9jNsXhoLDnvvLMDC4aqTatoOIxSkByncZ4IVBnksztaHQhDdrzgPUhDWEQV2MWDawoGLPKsrQGOQKMC0sacKpAzIsTwxFsp2+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MTCSNC2W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=edy3dQ/D65sk6R7FifAnpjI1/Mdzys/X7UHSS/x7tKk=; b=MTCSNC2WOvqlov4HzcW4N0vcRg
	XwX1obY1hwi0aN+kgd55+KkXYMg6sgufoJxQdJKmXpcRjsiOsgWdPCn3Y4ep98L83vuHqDz4e+TKL
	9Efqpg8kJg4fvRfMl1RGJNMj2P7B8OF6dJ7vB67aSfEJ9ycA16hdTY/ecapsjXTrSVlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tzcie-007gsi-7I; Tue, 01 Apr 2025 16:36:00 +0200
Date: Tue, 1 Apr 2025 16:36:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: m.grzeschik@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arcnet: Add NULL check in com20020pci_probe()
Message-ID: <7194164e-5715-436e-8093-64f3742cf5f1@lunn.ch>
References: <20250401134903.28462-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401134903.28462-1-bsdhenrymartin@gmail.com>

On Tue, Apr 01, 2025 at 09:49:03PM +0800, Henry Martin wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> com20020pci_probe() does not check for this case, which results in a
> NULL pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.

It is more normal to add a test after each devm_kasprintf() rather
than one big one at the end. If the first fails, all the others are
going to fail as well, so you should not bother and just fail the
probe.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr

