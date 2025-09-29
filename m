Return-Path: <linux-kernel+bounces-836737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8388BAA735
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 21:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003C3189E2E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6924677A;
	Mon, 29 Sep 2025 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="rohuN/+t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pSRwhlY3"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77F72614;
	Mon, 29 Sep 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759173930; cv=none; b=NpLMIUBUBF4EhJ4VyvQrhD/wwQcYQvhxK4lwS8zoQqj8PH3YjWaVp3Aqz1Io14ZMgUbkkvg2lBrt8E3d8WUsnK6f0Yuj7V2HosqXx3HoIDrM3wjUkgm64q9tZ+w3dkfK67R5p5wHcPrNCBDw8mhxWaGKcy5UD4dAaE9UzOOCjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759173930; c=relaxed/simple;
	bh=Oks3wpEIxN4yVSpCmhCTkIS2j/8DeWh0JN7rZT92jAg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=psogGW6IVH+0ehaAfmgV1w8IDIg5r4u/C2L92TqqlW2Paj/nbXRu6iQOINCx+Du+QdTPiPW01FPXMAwKhaa+mbL4YwCFNV/EaW5IThXCyeWRhpNmEeyDEUUyIvaO2mewKpJVv6CaNfiDE8JVI/blmyjx3cRbQaUV/fA49uJPqr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=rohuN/+t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pSRwhlY3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26D7F14000C9;
	Mon, 29 Sep 2025 15:25:27 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 29 Sep 2025 15:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759173927;
	 x=1759260327; bh=LEYRrqmqBwGkK9yG6i30I/Zds6zim/KQqc5+mlPQMLk=; b=
	rohuN/+thrz8tvXTDkRow/SWED9yWfGKQUcESjBVLGXv1Z44PqH+vEnYbyYzEd7s
	7RIRLYI4b5lAghElwvjhSih/n2m3u+ppFrB/n9b+IWKzNSOTEqHvudFd91UYCRUA
	RThcaVinKdsLT57DajPVqF8aJJmNVcYSkUduNjaDHiSyh+cfz2PJhn4hzTr24/Fu
	dFq97g0OvONtN9D1HVWydYe6XJ5kXKj4XGfu062riOm/qbI/1s52Vrzp3GWGGxqH
	rBhpdI+ImVKK8pRz1VwrYTvNoxqILj6j4O1J4fDjJ/snaL4Bfk8x1VUoUmHPaj5F
	e0x1x8iGbsBmd0IpGpuBZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759173927; x=
	1759260327; bh=LEYRrqmqBwGkK9yG6i30I/Zds6zim/KQqc5+mlPQMLk=; b=p
	SRwhlY3x25laGfimAlMQRonwrgNS2cCvDzGglpQ9RIh3nfMnP72IGZ+DCws2SFs6
	w6JkjjgsiLEn1sUh3B7yAH7zbSh46sUMdkkRAj6plxv0Z6IemUa1JYFhgyGRWiYu
	J5FgwW7ghUkCJdLPkyj76T5ytjGLlu5oU2ay65I/09SujptcoluLrPYALdoajc/j
	L8qk23yHDV5RpJZxpERmAnXnpgkygI0+7Qp0JbTzQqrXX59WKL0evJi31qb2bh1g
	iEMx/xAHFEjWb0GELLB+jUYMdvCBeNvO1vFNzVNoZbLfQm7z67wyc/FdqTXmA/+h
	UGiClPWNrK1BMGrkf9nGQ==
X-ME-Sender: <xms:Jt3aaPObOdJQkEb1nnxZm0DQK_qryfULWZCjD9qDhMM_NalNBloq4A>
    <xme:Jt3aaEyMNp5ihUykPqc1Q9wRY92j2FpbEmzN95aK-RNr-j9_WKBDdPmzPa9_6QmEx
    rlWcdChYpoyCGmSmHF6Xy9QPYix6P6Tt3_cklc55TDArbUc-vp6EmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedtveehuddvjeejgffgieejvdeg
    kefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvihhkkh
    hirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehg
    rhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Jt3aaA6sdYxapwe4qnAtwmKT0vZsJhSxUgJX9rb-XFQnqMaZKIac6g>
    <xmx:Jt3aaIy8w2JgGng9WfiH0tnpMOGdB1Hy_6agUzx1jWsOKtb6vr7keA>
    <xmx:Jt3aaHyi38ScLaL5qVMkGScdlC4RfclpAaQsfj9lv6emnaSAPDyv5g>
    <xmx:Jt3aaAzBJJcrfxyRIGH6WMt4InTWqnn2twKgBBfKyaDFusKf9gV9Qw>
    <xmx:J93aaATjDIfmoQ7aeKpR-MNGm4ad7hps3iCH2v-9EUoFnYLNMFG_4jZZ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 587EC2CE0072; Mon, 29 Sep 2025 15:25:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADpVV-8_W703
Date: Mon, 29 Sep 2025 15:25:06 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>
Cc: "Greg KH" <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <0698954f-6efd-4aa5-ba23-39b7730031b4@app.fastmail.com>
In-Reply-To: <aNFFpUZek-k5YXls@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh> <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
 <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>
 <aNFFpUZek-k5YXls@kuha.fi.intel.com>
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Heikki,

On Mon, Sep 22, 2025, at 8:48 AM, Heikki Krogerus wrote:
> On Fri, Sep 19, 2025 at 11:45:48AM -0400, Mark Pearson wrote:
>> Hi Heikki,
>> 
>> On Fri, Sep 19, 2025, at 3:44 AM, Heikki Krogerus wrote:
>> > On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
>> >> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
>> >> > Hi all,
>> >> > 
>> >> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
>> >> > > Hi Greg,
>> >> > >
>> >> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
>> >> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
>> >> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
>> >> > >>> 8th bit is reserved and should be set to zero.
>> >> > >>> Some buggy FW has been known to set this bit, and it can lead to a
>> >> > >>> system not booting.
>> >> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
>> >> > >>> so that the system boots correctly.
>> >> > >>> 
>> >> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
>> >> > >>> be fixed, but seemed worth addressing in case it hit platforms that
>> >> > >>> aren't officially Linux supported.
>> >> > >>> 
>> >> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> >> > >>
>> >> > >> Any hints as to what commit id this fixes?
>> >> > >>
>> >> > >> thanks,
>> >> > >>
>> >> > >> greg k-h
>> >> > >
>> >> > > Maybe 3cf657f ('Remove all bit-fields')?
>> >> > >
>> >> > > The commit there states that 'We can't use bit fields with data that is 
>> >> > > received or send
>> >> > > to/from the device.'
>> >> > > Not sure why that is, but I assumed this means we shouldn't change the 
>> >> > > structure to use 7 bits for num_connectors, which was my original plan.
>> >> > >
>> >> > > After that, we go all the way back to the file creation (c1b0bc2) where 
>> >> > > it was defined as 8 bit.
>> >> > >
>> >> > 
>> >> > Just a gentle nudge to see if there are any concerns or questions with the patch.
>> >> 
>> >> I was waiting for the maintainer of this code to review it :)
>> >
>> > So not Fixes tag?
>> >
>> 
>> I can add a Fixes tag for the very original commit of this file (c1b0bc2) if that's wanted.
>
> I don't think it's necessary in this case if the fw is really fixed.
> But what says Greg?
>
I don't think the Fixes tag makes sense either; and to confirm - this will be fixed in FW.

Greg - can we go ahead with this please?

Mark

