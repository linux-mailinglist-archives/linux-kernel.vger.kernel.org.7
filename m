Return-Path: <linux-kernel+bounces-836780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD84BAA8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CCC7A4BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D924C076;
	Mon, 29 Sep 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="ZTIksuKS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2R55JK4"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDBE17BED0;
	Mon, 29 Sep 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176089; cv=none; b=cvvWzzsGydHwnatJcZ5JovSxqKnOYTKyzZulkVLj/6dJdOsGO+nEjAmidRh4KYmCpuoVhqjdj+P3m/LZCc1zyi+wthYKQxmeM9if5vqaQaEdKtbXJ4xo5tqcnoHZ6dUVwtMqzB0tG1DWKMVh8B/paBu9I8+7/cZGJERB/iyQdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176089; c=relaxed/simple;
	bh=MnKeZzh4g+WHbVqmcbCKtzQAlACoEtsLWA1F57hhKR8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IjM6SRNqy1Vwa00worSgOg2GvQKs1dvMTFLJ66cVlMQOVcS0Nj4ZTjPnGsTqmuPnevrMN+XIQYf2+wJGZftHaIbV6x+NZEYWP8v2nLMCeTtuVZeHe7PrftYeV0TP12RG++rCYw8tix7jHnfrmf0/X9jVfPf7FnbeOBs71TbocBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=ZTIksuKS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2R55JK4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 074FDEC0110;
	Mon, 29 Sep 2025 16:01:26 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 29 Sep 2025 16:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1759176086;
	 x=1759262486; bh=xsmTvm8x58eryyv9XG5rMw2ddbtFXMRpP9fezYzv890=; b=
	ZTIksuKS+UE8JK5P0wwGIgsgsUMcQNwcsLDXe+o8KT7Sm5MJTQg0EV0NMP+OYrM2
	enB0OGeHO1f/mEsSFW3o3YYf5awGTRbafPUH8+08AoKSH8M6exEpoSrOkSuMGn/k
	2G+vBdKqw1jdbHWhJE8LjXJrvJR38P8YEC20qcXDOc4886Yb7+x71hQsQBCfnS5V
	0QWrheL1E8+01u2Nlz5GGERnzB7R9mPI3tGmLnqIyjMzDAhfzaV8eIMzWhO2efyZ
	45vabSfwj7LvLXzDRZJUn14b1+Oo1RE58bFFAJhdMyqTKuNiH8OvkVLpNxU92b5R
	0Qi5v3gkH8q0s915sKm9mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759176086; x=
	1759262486; bh=xsmTvm8x58eryyv9XG5rMw2ddbtFXMRpP9fezYzv890=; b=K
	2R55JK4HmWc4/vzCVlpbcp0jJ+YeIVzqZ0q2rARenZwxs43iUsgmbZQ0piTMwQKS
	uNXu8z2NiI9VV/8M9tw57FXZoDRVA00HhfQdx8Y831+M0WB7GKevk83tuLTPyFOX
	GIkZ+MF/zBL1q6sYkWBiF3JRR8Nr22iBnKCJNQKUBK+BaCti1JfNqM85caMWft/n
	Ap23OtfuCPDyllS/wSf9aJG7vMjO5EDZIQtmfet27WKCl2ERq5wtBtx13B1bMaly
	mGTUfsTWEWOALNKUsg9Pd7gwbXweS8UgXEgwHAiV4pOD/jlTN492r4F6fhHc9CGi
	y4cdHOY1ETdbZwQhsngfg==
X-ME-Sender: <xms:leXaaCgqPf_DyAGTGEcUXFFa9VhKzWH4hc1o6e9teNDobos3_PkSCw>
    <xme:leXaaN22WQkzXYQ9xj1eEjfCVIWtMfz06c3af49Plz14dXRWoa53LpiEzmC5cA-SQ
    zrGno4dJvPAlcupzyBmB3UrSajqHAwqI_6qDZbK5qzrEi56EJz2AOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejkeeludcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:leXaaMN4bfutkd5QBWqbTlup1he6UKdMHkgfMUs-Tx2QdsXA_SF9Hw>
    <xmx:leXaaJ2DDPFfwRtyPcqjsIn2n0f88zVP-OYroCUlIyZ1-XxwRkR_Dw>
    <xmx:leXaaLmqYf4DPAOt0bsvw5ocGQ3iy7rMxaJ_5ZdHYGORtQTL5G6KFw>
    <xmx:leXaaAURJWW4rjG56oI_D-lHmnJje7Gt8bvACioAOoOYtIBX4BG03Q>
    <xmx:leXaaFdQhbozbtQPELZGr_CDMW0LiypBQHHeGZRFe5KbtVEuGAiWxhEx>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F38DF2CE0072; Mon, 29 Sep 2025 16:01:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADpVV-8_W703
Date: Mon, 29 Sep 2025 16:01:04 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <384b208d-5866-4563-8d84-23342a8e3663@app.fastmail.com>
In-Reply-To: <2025092909-sacrifice-immortal-5e5d@gregkh>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh> <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
 <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>
 <aNFFpUZek-k5YXls@kuha.fi.intel.com>
 <0698954f-6efd-4aa5-ba23-39b7730031b4@app.fastmail.com>
 <2025092909-sacrifice-immortal-5e5d@gregkh>
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Sep 29, 2025, at 3:35 PM, Greg KH wrote:
> On Mon, Sep 29, 2025 at 03:25:06PM -0400, Mark Pearson wrote:
>> Hi Heikki,
>> 
>> On Mon, Sep 22, 2025, at 8:48 AM, Heikki Krogerus wrote:
>> > On Fri, Sep 19, 2025 at 11:45:48AM -0400, Mark Pearson wrote:
>> >> Hi Heikki,
>> >> 
>> >> On Fri, Sep 19, 2025, at 3:44 AM, Heikki Krogerus wrote:
>> >> > On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
>> >> >> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
>> >> >> > Hi all,
>> >> >> > 
>> >> >> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
>> >> >> > > Hi Greg,
>> >> >> > >
>> >> >> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
>> >> >> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
>> >> >> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
>> >> >> > >>> 8th bit is reserved and should be set to zero.
>> >> >> > >>> Some buggy FW has been known to set this bit, and it can lead to a
>> >> >> > >>> system not booting.
>> >> >> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
>> >> >> > >>> so that the system boots correctly.
>> >> >> > >>> 
>> >> >> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
>> >> >> > >>> be fixed, but seemed worth addressing in case it hit platforms that
>> >> >> > >>> aren't officially Linux supported.
>> >> >> > >>> 
>> >> >> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> >> >> > >>
>> >> >> > >> Any hints as to what commit id this fixes?
>> >> >> > >>
>> >> >> > >> thanks,
>> >> >> > >>
>> >> >> > >> greg k-h
>> >> >> > >
>> >> >> > > Maybe 3cf657f ('Remove all bit-fields')?
>> >> >> > >
>> >> >> > > The commit there states that 'We can't use bit fields with data that is 
>> >> >> > > received or send
>> >> >> > > to/from the device.'
>> >> >> > > Not sure why that is, but I assumed this means we shouldn't change the 
>> >> >> > > structure to use 7 bits for num_connectors, which was my original plan.
>> >> >> > >
>> >> >> > > After that, we go all the way back to the file creation (c1b0bc2) where 
>> >> >> > > it was defined as 8 bit.
>> >> >> > >
>> >> >> > 
>> >> >> > Just a gentle nudge to see if there are any concerns or questions with the patch.
>> >> >> 
>> >> >> I was waiting for the maintainer of this code to review it :)
>> >> >
>> >> > So not Fixes tag?
>> >> >
>> >> 
>> >> I can add a Fixes tag for the very original commit of this file (c1b0bc2) if that's wanted.
>> >
>> > I don't think it's necessary in this case if the fw is really fixed.
>> > But what says Greg?
>> >
>> I don't think the Fixes tag makes sense either; and to confirm - this will be fixed in FW.
>> 
>> Greg - can we go ahead with this please?
>
> It's the merge window right now, I'll pick it up after -rc1 is out.
>
Sounds good - thanks!
Mark

