Return-Path: <linux-kernel+bounces-725692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40518B0027B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E24E1C24E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E2525F976;
	Thu, 10 Jul 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="PQcycRs0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CbbkcB5V"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB721E8333
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151953; cv=none; b=bpbWw7wZg4OzX8dHbL8EYvXGwQeA+yfDAuA7bRtdDmwMiAsxtRipInkOx8DNFvcsA+I7mGVFVtGO3+wQwZRf5abqo8X8xO1y7bgl5HSuJfUOcT6CHDA3u4I82Y1I8/wdboAZqoV5titfXJYkJxNMiMxmbReLEZs6xCK1dsmCGUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151953; c=relaxed/simple;
	bh=pTMpghKIEs0zHQjTSNZr5WQYgoqci6tKf63zzRw2aO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kz4LfTI4eMrExKJ8MDVTqIkhVFn2lw41RPtM1IFSX6pcsAtaNkHjC1FfB9DMNl0w7Qf780yTwcvZ68Zg/s4dU4Y3dijc+/o0+4/bLwf6jWMzXBmTV9e1JHQKfGxBPuNpYPLeBwWFRpxOWKfXxG2H+gqWU1gLMrOh5RR8/pgmntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=PQcycRs0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CbbkcB5V; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 980AA7A0130;
	Thu, 10 Jul 2025 08:52:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 10 Jul 2025 08:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1752151950; x=
	1752238350; bh=yynqYj7tMkAm1XPpixejs+zcGcMwak7RL7iH88kusPo=; b=P
	QcycRs0QIEJ816OMbyHB+ovZ20t8Ho2zAQfytwWrt94XFMyuV+ZS8fqaR5OFKQZD
	BjKgx+6LKk2WSP55QacaSsYVHEv7zKX6Q1YX45lQOHpwIop+Xza/ECq4S/Eg2EVn
	BJGHs/a49KWiVEhmQAsrR8WXkAStPdVj9PuPHrYDAVE0ZIeNSqIBTEeBTRRlM88N
	SpmY/XohFToDFzlYmAOr8iiLUInH/OL37s8wMzmHozxTnv4ZqqzzE0uS/qFo6MMF
	73s7S770YpAgpAmGKjOF9rhQXCRbbStxLyR5A6y1FOHXDludR7OvWEGLAoHn/Ms/
	m9pkOi91gXSIiILf8GrgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752151950; x=1752238350; bh=yynqYj7tMkAm1XPpixejs+zcGcMwak7RL7i
	H88kusPo=; b=CbbkcB5Vg/YoUws3a9GIdlX5fOvhpEQMI2D/VmG6fb8gkMB/ALJ
	DXkH5+8i/vFz2OaNq7xSec9yeiU+3jLPD04VQ0f/oYjk/R7EWD6ad1Mr1H0Q8s55
	mQANmw39WCMGvNvZdd11R1OZ0yMdwZ7asC0dZHleh6OhoG4GPbCoNRi7JoWrYBBK
	pG06l/5dpkzrU7gIaUaIpuSUVsRWByfig8VmRMnSd9UmjZcBM81sLihqEHGVm3Ep
	SbPVPGSq+z0ue8lz01UlfQ2Twvsa5ngzP1B8EuOj7NU8kada4f1aj0M/F9Buud+G
	4knpgtwP5AXaVG3BAaBLySizvdiwRHNIG5A==
X-ME-Sender: <xms:jrdvaI_UnNRTA8OaAeL37Ch9u-W3vd9HJsSQoSlRJcRm-HN6I85oOA>
    <xme:jrdvaHl29M3N5JSAa6NBMNpZviEUnjkWQqmolXPoDECc1AaMVPAV9C24R22IZNAyi
    G4ejji6E7QWGX7MhD4>
X-ME-Received: <xmr:jrdvaK-opIPx-sY4Hi8bLiRJzQ-YECAh42da9FztUU7h-vjlkNvFLJkaxVXXyYujUtIfPKE6aeM_v4Rbs1ldWDhraJv6HBD3HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhi
    ucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqe
    enucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedv
    leeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpuhhrvhgrhigvsh
    hhihehhedtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidufeelgedquggv
    vhgvlheslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jrdvaFkW0K2EZ1nXDqV08fxpRT79CpqAhBz0GYUvYYCPF_SWGq1YeQ>
    <xmx:jrdvaH066CAQOIztjbF-ME84-kHQcZqawFekxRbQ5SO5_Wyi-131WQ>
    <xmx:jrdvaApDk2ZQS2QVESizsK4ppPkb2oQE5a9Z-ej_1BcS2zxMAqtRkQ>
    <xmx:jrdvaEeVRk2Y7QSG9iDHE5AKfMz11SO0wyPz-umrDN9ruel9aTyr7w>
    <xmx:jrdvaAGRizR5D7tuaggfx-p-S9T1zmkekHS20pW5JTSGBRRJqLlFBMgd>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Jul 2025 08:52:29 -0400 (EDT)
Date: Thu, 10 Jul 2025 21:52:27 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Purva Yeshi <purvayeshi550@gmail.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: Initialize payload_bus to avoid
 uninitialized use warning
Message-ID: <20250710125227.GA25686@workstation.local>
Mail-Followup-To: Purva Yeshi <purvayeshi550@gmail.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20250710073906.24105-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710073906.24105-1-purvayeshi550@gmail.com>

Hi,

On Thu, Jul 10, 2025 at 01:09:06PM +0530, Purva Yeshi wrote:
> Fix Smatch-detected error:
> drivers/firewire/ohci.c:1514 at_context_queue_packet()
> error: uninitialized symbol 'payload_bus'.
> 
> Smatch reports a potential uninitialized use of 'payload_bus' in
> at_context_queue_packet(). If packet->payload_length is zero, the
> variable may not be set before reaching the dma_unmap_single() call,
> which could lead to undefined behavior.
> 
> Initialize 'payload_bus' to 0 to ensure it has a defined value in all
> code paths, preventing any uninitialized access.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

In my opinion, we should pay enough attention to the value of
'packet->payload_mapped' variable when considering the issue.

```
$ cat -n drivers/firewire/ohci.c
     ...
1385 static int at_context_queue_packet(struct context *ctx,
1386                                    struct fw_packet *packet)
1387 {
1388         struct fw_ohci *ohci = ctx->ohci;
1389         dma_addr_t d_bus, payload_bus;
     ...
1474         if (packet->payload_length > 0) {
1475                 if (packet->payload_length > sizeof(driver_data->inline_data)) {
1476                         payload_bus = dma_map_single(ohci->card.device,
                             ...
1485                         packet->payload_mapped  = true;
1486                 } else {
                             ...
1489                         payload_bus = d_bus + 3 * sizeof(*d);
1490                 }
                     ...
1496         } else {
                    ...
1499         }
             ...
1506         if (ohci->generation != packet->generation) {
1507                 if (packet->payload_mapped)
1508                         dma_unmap_single(ohci->card.device, payload_bus,
1509                                          packet->payload_length, DMA_TO_DEVICE);
                     ...
1512         }

Unless the variable has true, the dma_unmap_single() is never called,
thus the issue does not occur.


Thanks

Takashi Sakamoto

