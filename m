Return-Path: <linux-kernel+bounces-824890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166EB8A611
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44D17E6951
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553F31A571;
	Fri, 19 Sep 2025 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="zjnQDC7s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bo1P/+Ge"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1E246BD5;
	Fri, 19 Sep 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296774; cv=none; b=VDAOKQRbxind/Ce/EAVRhL3w4h0CPG93blDL1n38OGZXxAB5V6Du2o6noFg4RCTn8flNdqa9TRDFjjiBvxc4gJrO9uDf7FVIgsIQ8Mlnb7GqwwqsJP5JPIrCaVJeeEyjfG/jUY+pPr/IfSYpZZ1W5Oo669B6hXOajY/8rbs1G9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296774; c=relaxed/simple;
	bh=a7yk5iG3dYDPlZIQbU+gm9jZdy+A416cNdesi3JL55o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JGBiryE8+Yj7GqbcL9fCQZ3H92rSu0MLlk2Wp3o5NS2ySCax+hvWMGFwVC2xHIJ8hePcNFieyk/ba6N4bbuSZiGFbyujW2KpbeeszxeHO8VPJ/VsZK++VbRBDyCiwUjNmRKLQzoJ0qV+Fvk6Go0MVAnMA/eZFHo15EwhQQe51XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=zjnQDC7s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bo1P/+Ge; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 022D114000FD;
	Fri, 19 Sep 2025 11:46:10 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Fri, 19 Sep 2025 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758296769;
	 x=1758383169; bh=xWYrOdh8mSunumsDLKmjA/MdaerwYg3AbR884zyPmUo=; b=
	zjnQDC7s5U7sIJXR5FUt+QV2OsK0GWfURko/5p9fjzNg0hfDpZCXyOPOR5M5U8++
	ab756AIw6b11/2HfFoBenoblomkgToCQtVUFS4zRpaOIvHZ8GaXyhfs2UwljTJFz
	gFDJmZXrvFrsFDZeUc6JtPpNFw+XDFOAmNsrVfohK+Q9kzZwIaEJGpv1W5XgjhLg
	v9lAB18viIxJtvTLacStzx3ScGpPzDxMzovXZsZL9sQw/pspWgE02/oBhGLW3Er8
	4A8cR1k76KBpai7CQZo5b66eV/t1mzZZsPaPY7yir2YQH9XR/isPdv6hIJHFUDZc
	H2NM0cDc6LQM4hTQUih0jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758296769; x=
	1758383169; bh=xWYrOdh8mSunumsDLKmjA/MdaerwYg3AbR884zyPmUo=; b=B
	o1P/+GeT7s97yGz4t9f5bVaGsU9btSAhG8UqN7UbFaX5Vq+zK4QhO7NIlTZmX5Wy
	CUd5XCsaZCU4VTqba7POQSF1RfHaO1lGFJYOTbl+SqivujhiqESm28mcKAI/XieU
	sW9nBedbEuYyXzhUzDmppYHrG0udiGWTNqfWamBtNg5MHcaYw1aBwAg72LE5A/oG
	KunOZqHdlHuRr/yDuJIOZvGOqxlWcLx/5gEbN3ZqNcQk2gafaqX+RNSNmD32VYJS
	9KLruBFTMVoJ1ZBkPm0rUh2mWeiUd+VgOBgF60JChSSdh6s/yNNd3xHyYKoHTLUQ
	G5k2rIon53JvRnMgAIBxQ==
X-ME-Sender: <xms:wXrNaCzi_fjOk4gHIhTSebyNSPlx8d5zadhOoAyVPPRDqP2gt5kcRw>
    <xme:wXrNaOTw0g2cNM5jgUKBQ1-P60MXNoaGZTnltolhPuneUzdIaBP5uCfykZyrqZLSF
    C0ojpgpCga_zYk_F2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegleeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:wXrNaGyCS_TDkoeHopXJ2m3AYFO_QwVcgJG14nr8mo2Gxr5yV4W0mg>
    <xmx:wXrNaNwi9mEsSfoxR54n5G68BxWdT4etS-oKGUWPTQU9S3JtkMyLcA>
    <xmx:wXrNaOypj0k0rBJtI4FbPEEJUxmBPS0kEdyn2KERLqyJXjaLagu0nw>
    <xmx:wXrNaHYee-eSO5RAP6J1X0g8ZeCVg3DSq1cbgxHQZfVZZBAXPwCUTg>
    <xmx:wXrNaGRvAqqfSnaLfZQa2cBLnLkrqr8Spa9DS5DbYLSEg1VVN1PiCwTD>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 07CDB2CE0072; Fri, 19 Sep 2025 11:46:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADpVV-8_W703
Date: Fri, 19 Sep 2025 11:45:48 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
 "Greg KH" <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <84064f76-bc99-4f3c-b26b-0dacf3632279@app.fastmail.com>
In-Reply-To: <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
References: <mpearson-lenovo@squebb.ca>
 <20250821185319.2585023-1-mpearson-lenovo@squebb.ca>
 <2025082213-antacid-correct-53b1@gregkh>
 <0ac78125-a028-4d99-b106-d792d8660d0f@app.fastmail.com>
 <1c185541-2b6b-4c43-938a-9f4f4d1499b4@app.fastmail.com>
 <2025091819-bullion-hut-8242@gregkh> <aM0J2hDgqkxioAXU@kuha.fi.intel.com>
Subject: Re: [PATCH] usb: typec: ucsi: Handle incorrect num_connectors capability
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Heikki,

On Fri, Sep 19, 2025, at 3:44 AM, Heikki Krogerus wrote:
> On Thu, Sep 18, 2025 at 09:50:30AM +0200, Greg KH wrote:
>> On Wed, Sep 17, 2025 at 02:14:28PM -0400, Mark Pearson wrote:
>> > Hi all,
>> > 
>> > On Fri, Aug 22, 2025, at 8:54 AM, Mark Pearson wrote:
>> > > Hi Greg,
>> > >
>> > > On Fri, Aug 22, 2025, at 12:51 AM, Greg KH wrote:
>> > >> On Thu, Aug 21, 2025 at 02:53:07PM -0400, Mark Pearson wrote:
>> > >>> The UCSI spec states that the num_connectors field is 7 bits, and the
>> > >>> 8th bit is reserved and should be set to zero.
>> > >>> Some buggy FW has been known to set this bit, and it can lead to a
>> > >>> system not booting.
>> > >>> Flag that the FW is not behaving correctly, and auto-fix the value
>> > >>> so that the system boots correctly.
>> > >>> 
>> > >>> Found on Lenovo P1 G8 during Linux enablement program. The FW will
>> > >>> be fixed, but seemed worth addressing in case it hit platforms that
>> > >>> aren't officially Linux supported.
>> > >>> 
>> > >>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> > >>
>> > >> Any hints as to what commit id this fixes?
>> > >>
>> > >> thanks,
>> > >>
>> > >> greg k-h
>> > >
>> > > Maybe 3cf657f ('Remove all bit-fields')?
>> > >
>> > > The commit there states that 'We can't use bit fields with data that is 
>> > > received or send
>> > > to/from the device.'
>> > > Not sure why that is, but I assumed this means we shouldn't change the 
>> > > structure to use 7 bits for num_connectors, which was my original plan.
>> > >
>> > > After that, we go all the way back to the file creation (c1b0bc2) where 
>> > > it was defined as 8 bit.
>> > >
>> > 
>> > Just a gentle nudge to see if there are any concerns or questions with the patch.
>> 
>> I was waiting for the maintainer of this code to review it :)
>
> So not Fixes tag?
>

I can add a Fixes tag for the very original commit of this file (c1b0bc2) if that's wanted.

> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
Thanks for the review

Mark

