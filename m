Return-Path: <linux-kernel+bounces-877778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202BC1F000
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7303A9B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F327B31064B;
	Thu, 30 Oct 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TEZsYtD0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BsL0FIuF"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B22EC54F;
	Thu, 30 Oct 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813243; cv=none; b=Zr8JC80TTKvS78CKcGOGuEZXP/YSu01HXB7k1n56xoWdhwAIzSAYl5OyRPUJpbqNl6ZNCjLw1cSGhnvjuLjvm5ZHcy9cS9UvIHWtYudldkhSHrkWvXkTqEikbcqmkoBQW2XHOAvorrqYEStKPxwNtL6OB61W33MFzLSb8JUQtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813243; c=relaxed/simple;
	bh=ClHpqTThjq+NAeE9XO7e5A2KiC0EaJ8zQax7y1jFiJw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k78LRq8btjBW82YpRkdKCJqCJAoyPfI7COyfzVbvZrAvwmOdqibqcrBfQoO54MdO77KvstGmEVNOPRSB3BYkIalE9/D1cm3ycKEqQsBkEwl/6u6GlALUcGGIBI+ezuAWlCdMcK2rad3GErgK1tqza7Dq9fnmIe66bvId8+Q/pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TEZsYtD0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BsL0FIuF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5DE81400217;
	Thu, 30 Oct 2025 04:34:00 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 04:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761813240;
	 x=1761899640; bh=hQyZQG22S5kNBcYIjkn9Db0gf/i+iwBmPAX3iAjfvzc=; b=
	TEZsYtD0PIWN5gf0kV66Qv1hqaM9N5YfitpB1mdoaH2l2FxLkjx1f3/rHOE0foix
	HyynJAMtsptcbbVUq7z93UvX+XrUnJWxKFZx/4CgiXRTxHo1lJ89S9yysxFynimZ
	mL3JzbJ026kZ9G2Se4TsrvDKeIKzR5xlMGFlit3OitGG06YmmK4WcB2k+JB0Cib9
	l5Q/JcEkMwEy+isarSsefdzdfOfLqcvQ2n1jK6wt+N8Lueyf0vQ/E7mTXfjLYUoP
	bs6UsiEMWrdVyhXmKfywJpfJ/7E5uXrZ04227+EnajHeiX0lAtl/wA9ZbD+c6fc6
	Rzk7O1cXkj2Z8KMumbZoPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761813240; x=
	1761899640; bh=hQyZQG22S5kNBcYIjkn9Db0gf/i+iwBmPAX3iAjfvzc=; b=B
	sL0FIuFRAr59S4U0/1OJjYpGGYbsK0GChKMlXQqubMTwgNwmHbKz5zVfNpKmJ2r7
	K/SZuI2prELNKM4k9YMXgQeDsVfkxQyzkqjaoCr6rXoABEaIjzhccpodDb2xjkbM
	hBEGdNWyoWam8r5J87hp5A+Ofks2Uz73GbHPflbLyER0eqhG1FFjl1jS8L1DqRqg
	bZLr5yMsO9J4H3b31SHnf4zclRgNJw4H1GM/TdoIj5p1MWxhq9ppXWY1BH+Nklfw
	HmA3BXsK02ZSWZnZ2Tc4BH+CXlcU53AmbqjZY5ewJvms2T1xqIQd6rnyvGZBXMvO
	90YvWxhSBeDGGzGPZd/hw==
X-ME-Sender: <xms:-CIDacfgA0uktHHo2O6oMm7_062rNp7M6UuBNI_h9dc6OvNU9Flk5Q>
    <xme:-CIDaZBSnBGd8xZwbls-ECv23q3nvMRSeajze1JyM0axoyhPoe3XjUBHZIsvj8G_F
    5BDktWt-itaA-eAR2P924_RXV5EZFvDbCIt_JblfRK709G5QSjsRXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghnughrvgdrughrrghsiihikheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggr
    nhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphgvthgvrh
    drghhrihhffhhinheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuggvvhhitggvthhr
    vggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-CIDaWuIkfq7IfmJ5oYsp9Ya7fNt5kVCOFPtstKO5Ly6z33IH5c-lw>
    <xmx:-CIDab7tzA6igd_7d8vXw_fT391mS1yqb8ig_2GTezDbQtHFoCer4g>
    <xmx:-CIDaSfqCCNZy3UlgG-9-J8vUgZYlqo8i5CCyJEUqrCsZgMRIUyPpQ>
    <xmx:-CIDaYyj6hKyPNNaSg_lJXfGJ2-ZiENkKuLpJ0Tb8qzMvbzavBcJTA>
    <xmx:-CIDaZaMg82heu2ULC_iRMVsh_D9QEEi1QWXUuEsyGLfnZg1WJ2clc6v>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 78A58700063; Thu, 30 Oct 2025 04:34:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AK9Cqudmt2dw
Date: Thu, 30 Oct 2025 09:33:39 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Lee Jones" <lee@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, "Rob Herring" <robh@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 "Peter Griffin" <peter.griffin@linaro.org>
Message-Id: <dbd5558a-90d9-404c-ae98-a8c04cdad08a@app.fastmail.com>
In-Reply-To: <aQMUu08phVPqfgEB@stanley.mountain>
References: <cover.1761753288.git.dan.carpenter@linaro.org>
 <3fd4beba-0d0b-4a20-b6ed-4e00df109b66@app.fastmail.com>
 <aQMUu08phVPqfgEB@stanley.mountain>
Subject: Re: [PATCH 0/2] mfd: syscon: introduce no-auto-mmio DT property
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 30, 2025, at 08:33, Dan Carpenter wrote:
> On Wed, Oct 29, 2025 at 08:43:33PM +0100, Arnd Bergmann wrote:
>> On Wed, Oct 29, 2025, at 18:27, Dan Carpenter wrote:
>> > Most syscons are accessed via MMMIO and created automatically.  But one
>> > example of a syscon that isn't is in drivers/soc/samsung/exynos-pmu.c
>> > where the syscon can only be accessed via the secure partition.  We are
>> > looking at upstreaming a different driver where the syscon will be
>> > accessed via SCMI.
>> >
>> > Normally, syscons are accessed by doing something like
>> > syscon_regmap_lookup_by_phandle_args() but that function will
>> > automatically create an MMIO syscon if one hasn't been registered.  So
>> > the ordering becomes a problem.  The exynos-pmu.c driver solves this
>> > but it's a bit awkward and it would be even trickier if there were
>> > several drivers accessing the same syscon.
>> 
>> What would happen on the current exynos platform if we just take away
>> the 'regs' property? I would hope that we can avoid encoding what
>> is essentially operating system policy in that driver and instead
>> just describe it as a device that expects to be implemented by
>> firmware and doesn't need registers?
>
> Exynos solves this because they only have one phandle so when they parse
> it, that's when then they create the syscon.  If you had multiple drivers
> accessing the same syscon then that doesn't work.

I'm not following the logic here.  Do you mean that they avoid the
issue today by ensuring that the regmap is always probed before
its only user, or do you mean something else?

> If we left out the "regs" property it wouldn't be created automatically
> but syscon_regmap_lookup_by_phandle() will return -EINVAL and probe would
> fail.  It needs to be -EPROBE_DEFER so the probe tries again after the
> regmap is registered.  We'd need to add a check like this (untested):

Right, this is exactly what I had in mind. With a new kernel and old
dtb, this would not change anything, while an old kernel but new dtb
would run into a different bug and fail to probe instead of using the
wrong device. I think both cases are fine.

     Arnd

