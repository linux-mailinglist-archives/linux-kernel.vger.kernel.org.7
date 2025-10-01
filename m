Return-Path: <linux-kernel+bounces-839485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F438BB1B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 22:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5FC2A63CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99992FD7DF;
	Wed,  1 Oct 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qK5+6bq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F373QN7N"
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A83283FD7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759351962; cv=none; b=sDff4/ByC/jyzTnpK0Qq5/QaT5vyUjXxs6Lju9OlAv2gc1BGh7w74JC2tjD3awC+KpX2VwmEzRnJ99h6ck50GtIg6QerIhJRARk5vlvSC029oHxcmOe78bOx45SHhmzYnlwgXr9Wc2LM71h1qh/8oleNVa8TA6y/bv+Z4eb0akQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759351962; c=relaxed/simple;
	bh=QzyE0+R58RgiQTk3Zug88mk/wlJ2AVPBey7eRgbNiiU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JA3MTdFuK3nuf6ekx7gEcymcFIqFzmrGd92V8sJxt3n+UGVMt6tWOoXp2ZCb9SDDruNFMcNh0D4YwDKvKnNF9eo0B1har1dbl+0H+AsmT1nKLt0KSMp3wZcDhQ8JeCH41EEBi6fHQwV37tSYDMgit7zDg86UNYTSfBzXI4xukdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qK5+6bq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F373QN7N; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1195140017A;
	Wed,  1 Oct 2025 16:52:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 16:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759351958;
	 x=1759438358; bh=jElQQ9PX+0V5sqeyNaST6yqqr8qfdCvwBoU7CLgEs94=; b=
	qK5+6bq0zPVE5zIunXwsiFzMIVB099c8exml7+QJApsStVDdbbDWgaVQSDTQnI7r
	gPGXnDoCrASbuDLpPHjZmkm9kDuQ2v4+BMAjKi2EO6HqwXqcerTyIxOnRcZ+GxH5
	GsQ34wKFRmQzhsNC/CWen/PWosSbYDuoc+5bdlmxvxXtg32yyPdE9JUlRw96C0rs
	/tbdvuBMqa7xQ9ZzyK1xcrxm+IGZ6PbG9yV/KoIxcFvr4RTVT6MCUlGtK5qqvnJY
	2xtgbX1b8ggiT6HRs5OtLBxbnnZVoYfNE5OJhvvq8H+mZuceqI/0OTHP3aSeNxKc
	xnkpwmaoCRWz1q4xpk+r7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759351958; x=
	1759438358; bh=jElQQ9PX+0V5sqeyNaST6yqqr8qfdCvwBoU7CLgEs94=; b=F
	373QN7NihCkOrI+VN9YxZwLwhdUmhD7cRKlbHXdY7wMh5rTjXycKcYi2ZZRXxn8r
	dn35QppbjXPmPivf0v4KwFWDOKWxeAn+CYHDAK4hYKKByUFKRNJO8EmK7wN8wS1o
	dAPECR+dMRqrQwO35w6/HJXtQFEGjH8Zp0T4ssmtmr/0zBBlKk4QZJqjrodwkY0h
	X+KR5hWXy1TKbDF/GVx11U2WCRcLHDUEgkqJ9hlKZRSU8qa3/o4LsMBWhkl6Rfhy
	TEaBXr2j1NcsH42hnWM1UJALR1UtF/xqtoLklkxx/vg7wz1IFerG/RWn7MYYoxXl
	Cs7bjj+woEDbpStaE4WIw==
X-ME-Sender: <xms:lZTdaJETKfO1qfiNxl9hZ2rQ7rCxr1MtK1fjha8scMrDKBn_qc_gCQ>
    <xme:lZTdaJJuTBNbkXKVPInsj9UuTeCnEiGf-1UNNmE2zC1iRVGGJDmuigBBdOJinnaF0
    q5dq_tzQqyMcECrCayTsSU8bsJxIRoRxusM41rbNKzTEhDD6pvIPIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheprghruggssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthh
    grnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrihhvihgrlheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorh
    hg
X-ME-Proxy: <xmx:lZTdaFsErVrRlEn2dHr66ucnD-LOgrU6d9vsAe2CXLj-Nrd_wL8bLg>
    <xmx:lZTdaM8k4xrN4C-HMtQOuo0lUlZN9t8w6NA3LLJuqVePmcDHWfVAqw>
    <xmx:lZTdaETlupRQZ-Ph5aEzaBK_F6MXRjnbVEVglO_Y8kf6VEdthIU7PQ>
    <xmx:lZTdaGVJunJInLI4WJU8QMslHtjuGQrt4N2SwyKhv65TSyk1ahwgLg>
    <xmx:lpTdaMnySD3-diLxf8np-sfjgq9uwp1H3sAFgrQJ-xcXmwaaf6xkUKrd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1C5E700065; Wed,  1 Oct 2025 16:52:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AOvO0JZNdWB-
Date: Wed, 01 Oct 2025 22:52:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Franz-Josef Haider" <fj.haider@outlook.com>,
 "Linus Walleij" <linus.walleij@linaro.org>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Kees Cook" <kees@kernel.org>,
 "Dave Vasilevsky" <dave@vasilevsky.ca>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org
Message-Id: <6d9bb65c-d693-4d99-8183-b605cabf9380@app.fastmail.com>
In-Reply-To: 
 <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
References: 
 <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com>
 <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025, at 18:04, Franz-Josef Haider wrote:
> On 9/30/25 15:09, Linus Walleij wrote:
>> On Thu, Sep 25, 2025 at 11:33=E2=80=AFPM Franz-Josef Haider <fj.haide=
r@outlook.com> wrote:
>>
>>> From 33ce5a26ef08199625bc5bb01a176047bfacff91 Mon Sep 17 00:00:00 20=
01
>>> From: Franz-Josef Haider <fj.haider@outlook.com>
>
> Hello, I have done this change because when trying to "select=20
> CPU_ARM940T" from a Kconfig for a device with arm940t cpu, the build=20
> ends up failing with errors like
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arch/arm/lib/ashldi3.S: Asse=
mbler messages:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arch/arm/lib/ashldi3.S:44: E=
rror: cannot honor width suffix=20
> -- `rsb ip,r2,#32'
>
> With the change I am able to build a kernel which runs on a device wit=
h=20
> arm940t cpu (with the patch "ARM: Add missing mmu flags entry to arm94=
0=20
> proc info." which I've submitted as well. And with the necessary mach=20
> files etc).
>
> I can elaborate on this in the commit message and also adjust the=20
> condition to include the other CPU types you mentioned.

Hi Franz-Josef,

We removed support for ARMv4T NOMMU a couple of years ago in
commit 2f618d5ef5dd ("ARM: remove support for NOMMU ARMv4/v5"),
in order to simplify the Kconfig CPU selection.

Adding a new platform in turn means you'll have to add that
infrastructure we skipped back then, and the dependency here
is only a very small part of that.

Do you have a public git tree with the rest of your patches?

     Arnd

