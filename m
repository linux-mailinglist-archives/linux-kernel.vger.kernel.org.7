Return-Path: <linux-kernel+bounces-726687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6917B01007
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6523A9F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4C2F3C11;
	Thu, 10 Jul 2025 23:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AjiF6Bp9"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EC7307AFB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191942; cv=none; b=okd4KiNnsg0TDpVfYPoJBU0uQ1l/ojMQEuSRK+bNdTEYgOe5mMyBM3hI/hGcgDWS18J0ftB66ujDYf0CSZdQBD19MX1fyfJEMo+rR1f/erPgquiQWvd2AUxQFGy65bZ/epwYB/6Q/dcvXx7i3itjo+4b0Nhfj+j8q+Lu2v1ioh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191942; c=relaxed/simple;
	bh=NzBvjzZSlnSlEwD5PPYSMqLvkxiVg7UhqXlmM5Ui+i0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tSgb7Gf9+3vshwF0ONk7C3BO5bINVWdpogUrPRn0Ka5LbD4YKHywPzkLxkQPrXepGZY7cJZ+J+/nwqXY5b4FKjIfgLfqJvX0/uiuH79fUQ4j3TNnFJ7S2NlBlcGKHSG7ubrEQDHcoRGh8WtQnCBa3LqbVYtSdb2vOaXcoCPSoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AjiF6Bp9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2ce3b809-28c4-487a-85d2-c62bce7260b0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752191937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iXgdYm+l921dPhsin9euYhz1uRo0hm5DDdzuaPKGqE=;
	b=AjiF6Bp9mwnViaXvmTFOYjWNgIxn2AVg35FSMpIdAFk6rkBv+dapf1s0mPZmEk5RqaXNsK
	y8co69kxpKHE163QzjWR9WPW5vJTZyGEQzx1cSHv4Q4IZZKqaSHyGlIYDQAI2i5Dh6a8xO
	W4OfIEfixTaZ4iPsAuUxNYIE++LVwcI=
Date: Thu, 10 Jul 2025 19:58:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] comparing the propesed implementation for standalone PCS
 drivers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Simon Horman <horms@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, John Crispin <john@phrozen.org>,
 Felix Fietkau <nbd@nbd.name>, Robert Marko <robimarko@gmail.com>
References: <aEwfME3dYisQtdCj@pidgin.makrotopia.org>
 <24c4dfe9-ae3a-4126-b4ec-baac7754a669@linux.dev>
 <20250709135216.GA721198@horms.kernel.org>
 <c84518eb-15da-4356-ac6a-b2fcb807d92f@linux.dev>
Content-Language: en-US
In-Reply-To: <c84518eb-15da-4356-ac6a-b2fcb807d92f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/25 18:50, Sean Anderson wrote:
> /* In mac_probe() or whatever */
> scoped_guard(mutex)(&pcs_remove_lock) {
> 	/* Just imagine some terrible contortions for compatibility here */
> 	struct phylink_pcs *pcs = pcs_get(dev, "my_pcs");
> 	if (IS_ERR(pcs))
> 		return PTR_ERR(pcs);
> 
> 	list_add(pcs->list, &config.pcs_list);

One thing we could do would be to add a mac_priv field to the PCS that the
MAC could stick some kind of identifier in. I could live with that.

But I still don't like how you'd need to hold a lock across pcs_get/
phylink_create. It feels like an unwieldy API.

> 	ret = phylink_create(config, dev->fwnode, interface,
> 			     &mac_phylink_ops);
> 	if (ret)
> 		return ret;
> }
> /* At this point the PCS could have already been removed */

--Sean

