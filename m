Return-Path: <linux-kernel+bounces-840847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4857BB58D4
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B89519E14F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F8827B35D;
	Thu,  2 Oct 2025 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rR2II8h5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DHQCYoqV"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D70249E5
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444878; cv=none; b=L8hMMFn71AUNLRv8X+2I8DfdYxFyIxgvrfeJR9qsyLbs5He9ZT5uODGyyiryA/k8I8Qc+06UzGLtEAkwS9mp0JvT0ojaW4BzW61dqf3tAZ7ComL7Ljqf8SxTfzuYDkr4O71najvrbK9kPatStDFgmyXHCrEIrdNG26rbN5AOi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444878; c=relaxed/simple;
	bh=bMk+6aTQqC3sfhRRa1TBUgfbAJE7XrqWg8LBpHf3yWs=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dJ9R6SIQAclk5bNE3e+GwPZT46/eYX4wJAbnCbL7Cilb1G6QzPezelXUkIA2xXM7Pv6QeixaZCU2NSgDF0pdEqJ/0gZyw8KLex+VluyOfuR44GUY2xti9k6ouH4BJvCmEc7dx7ocJwkzc+eoSEd8334kt2HCtt+SfoYEIigVVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rR2II8h5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DHQCYoqV; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 994D07A007E;
	Thu,  2 Oct 2025 18:41:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 02 Oct 2025 18:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759444874;
	 x=1759531274; bh=4hGlKaEF3owGaJz4O+b4FB/WpfLoASBvaTMeTYOloZc=; b=
	rR2II8h5qGEQ+N3qrO28io3mSYbEZDNSzni4M3uFzc+SC3OxBkJMCLbsISCw8gRo
	aW7K/HA7nJ62jDjk+OjEtSuVCoseyfkV2PlL1VM7U92QmC30zEB0so6jgtGVq5FU
	UkwkTYZrV6Mk7OwFtasY/kz7eO49Z4wjCiSqUOSWg7YLxJyXvj9OYDKzK1gcTRBP
	YFuQLK84PpiDOEJh0ruq9q5J6yTty1qcPCyPYmZ/5UBH23ZuoDh7tKMeg8qlfmqn
	nQNMSAFSUzlwuwo/GHd39tdRF+tJOd2mIf8CstxtksHlrne5DNSDesTrQSOIIka6
	cyyV/MLozU/JOG7vD11G7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759444874; x=1759531274; bh=4
	hGlKaEF3owGaJz4O+b4FB/WpfLoASBvaTMeTYOloZc=; b=DHQCYoqVFUx85gU6v
	slFj/IXlslxekzNbzX2t7cUTqGO6QdU8WtPxzXoF2czC3Egzb5qv938SuoB2+G3o
	s3bE3Ftpp2KWlTljOf2cPRSNewo8R2JHWJoZwO8QFaMsiq1FVQOA+SIkYQ8m4VmE
	YlRprSecGGmLx+QIBg/+CnwxqT5kL0QPnPRTgH6vsOIClrIQQyiTWJlLKiKMbRgl
	pq6zjyheL/EI2oTfTLghrESZoZ1Shu5+pMHwrMwAB+Nr65/b/+2zD0ja+aStDU8S
	dt+hn4YZhV23dBtKL/PMPboqncgL1r0PxCuxrPmRIhbcm19iAWl+9VQk6BgyXT0U
	cE2+Q==
X-ME-Sender: <xms:iv_eaORAfmyx-VrNY1qjojo2ry6eNu_jd6HzWbWeTYEjU_xDIhppBg>
    <xme:iv_eaOlMzQUBukbXXyBPZaKmAtXPYb1i7cbcNBfyWplkCDXIrZliEB6nxxb7AaJY5
    V44DQlJnaZH7DI3F_bTauG_PKU3CYtrNB1YEFh0e7pCG5y3rixDDX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekjedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceu
    vghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnh
    epkeetgfeufefhkefhjeegffefteffveeuhfdvieejtdefvdetheeftdejudffvdehnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhiikheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepkhhriiihshiithhofhdrkhhoiihlohifshhkiheslhhi
    nhgrrhhordhorhhgpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhunh
    gurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlhes
    lhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhrih
    hstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotges
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iv_eaN1i_9MEdLYEaN5LmPLsLN4VdWQ5gzqyXtm4S2hdB3FI6ojE8Q>
    <xmx:iv_eaJQ0iqhekBJG_ZNv4N7eyiZd6qivnqLNQ9d2MVElQqs6DFJQcQ>
    <xmx:iv_eaOxYPZ981NcrRqq5DjAYYDp97i96adR2uvubuViawKp-w_Y7Tw>
    <xmx:iv_eaBA1Vg93SANUa7SRpW7_2SDp8UR21x4gNm6WJd3zRTuGfCDkxw>
    <xmx:iv_eaFi4-HVvRUCQzDfSfHm0IxXHeK_HBVcSXLPGriYfhV1o9UV624s2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1C7B6700065; Thu,  2 Oct 2025 18:41:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXqMPTuZh4v7
Date: Fri, 03 Oct 2025 00:40:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 soc@lists.linux.dev
Message-Id: <a7fa4971-85a3-4435-8728-493acb68ed0d@app.fastmail.com>
In-Reply-To: 
 <CAJKOXPcRw3teqahDc6RBCz8XvqLt2sHqxrOUxpA84RszcsnGFQ@mail.gmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
 <d482931b-1779-4b49-9fa2-1c101bdf0929@app.fastmail.com>
 <CAHk-=wjsMPACg__N37EL8Sh=z1wkCpj+FQKpoVPXzyiVpm1i_w@mail.gmail.com>
 <CAGE=qrpygJ4XgtzdnGACj-6KRiD8r57F4ogNYaA3LLMusBV9fg@mail.gmail.com>
 <CAJKOXPcRw3teqahDc6RBCz8XvqLt2sHqxrOUxpA84RszcsnGFQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/5] soc: dt changes for 6.18
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 2, 2025, at 08:26, Krzysztof Kozlowski wrote:
> On Thu, 2 Oct 2025 at 15:04, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>> On Wed, 1 Oct 2025 at 15:27, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> >   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-dt-6.18
>>
>> Bah. I've merged this, but this causes build failures on arm64.
>>
>> I only noticed after already having pushed it out.
>>
>> > SeonGu Kang (1):
>> >       arm64: dts: axis: Add ARTPEC-8 Grizzly dts support
>
>
> I'm sorry, I should not have trusted contributors from Samsung that
> they know what they are doing and I think my CI misses allyesconfig on
> particular branches, because for-next branch did enable this symbol
> and it was tested by my CI. Also LKP tests each of my branches and
> didn't report this, I think.

This one is on me really, I had the right tooling available and
I had used it in the past, but I never ran it after I did the
bulk of the merges in the past few weeks. There is always someone
who misses a dependency in the DT updates and I rely on that
check anyway to detect some types of incompatible binding updates
and I have no excuse for not noticing it myself.

We'll have to refine the process anyway when we start taking turns
with the soc tree merges.

> Issue will be fixed with commit coming via clk tree - Stephen Boyd:
> https://lore.kernel.org/linux-samsung-soc/20250825114436.46882-2-ravi.patel@samsung.com/
> And git pull:
> https://lore.kernel.org/all/20250909183504.104261-2-krzysztof.kozlowski@linaro.org/
>
> I understand this won't fix bisectability.
>
> Arnd,
> Eventually you can just mark arch-artpec as broken just to fix your branches.

The missing commit is at the bottom of your branch, so I'm sending
just that commit as a build fix, that seems easier than marking it
as broken now and then later reverting that change.

      Arnd

