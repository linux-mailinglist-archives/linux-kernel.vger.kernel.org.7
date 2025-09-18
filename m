Return-Path: <linux-kernel+bounces-822203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFAEB8348A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54CFA1BC55F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E732E7F30;
	Thu, 18 Sep 2025 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rFqZdDmz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iv9YMUd4"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E871C84D7;
	Thu, 18 Sep 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179758; cv=none; b=Dtjydz5ZL9lUhEbuBE0cSOUgxlsdRwvE6yCMI3mTm6t2nPh8tFQbRzNosL6uiyNfzQ9BOao59BXIp1aQi82MZ5SXse3VsSA9WGPZwXJiVPRpohMv+HKkELlM8UceZBclnRFa135xd7sJmoXcis0QKxv92eq6zpgKn1Jrh7S4eZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179758; c=relaxed/simple;
	bh=WPFajZR1wHVq+VScI8b3i3dGz526ygojSyX2M2fGz1M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i8MQlaYbaufhy2k+4V4bv9ZZBYZsQeMKp4AObZfkPVRqwWy2f18hqc+jdRZ9It+akWoT2mQQvKcoMwrCRiuWVaQtQhcNxAjKAkGcppIdXfxh7tOb1nkX07D5bo8rvUI32f6iLHTyPN9TuZbY1o349ZtBCqpNy5aCemSLzvGGF34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rFqZdDmz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iv9YMUd4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 546A2140008E;
	Thu, 18 Sep 2025 03:15:54 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 18 Sep 2025 03:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758179754;
	 x=1758266154; bh=DU11/Tr79cSSrMHUNkMp59yAjz/GPUE0u3hy/HX0Khw=; b=
	rFqZdDmzA2sHs6qelE+PUc1TQm0t28Q0OjaWqdAfG1wBl5nAvmpMBpBJ0H0MtZG9
	8GuVONn2o97BcBFfVu2driscQ7kWlBqlQr/KHBVD7m5++dsthNHYD5SjfHAj3Yr0
	Xlaq+rQQ2otYQhRoCjfYZEfR0ZPMjcYFKFJTKmKeUI9FnhC0XMamZn+IniAS7RGB
	lWzVfiCSnQzPaRII5ew3gv/ZvkX7WP+GQsum6MSQN8jit0PidX2oyM8e5ge4MZvB
	obiHuyJKvgRLFQIDNEOJ0qg2se+RuzpXCEVkPuWjKHFZTZBCbSCOOC521dl0Yats
	sgQ4qC2FUaPM/fLa08FzIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758179754; x=
	1758266154; bh=DU11/Tr79cSSrMHUNkMp59yAjz/GPUE0u3hy/HX0Khw=; b=I
	v9YMUd4i+kjXzN5QcWtQcZzxLekJDd5uKpR3aTaUjVxQg3OlK0HBJ/9ZalwZvi3r
	PCx+xTH7An0qlGGzKMttDnLbxZRsjp97SwhyACCIKcG36wnGtcXoxKMTkzqTTqgr
	w3tv2/eGzlM4RM8cOeOkEuuguWr3w0A6brmrrrchSbSREp2IgfaWcB4TU7ORov4+
	Gb4W2idOv70qoA/ZDWB6XnV+eJupa8nFWGHkZ29MttR2eLb/C+Z4Iu8vTFXTnAD+
	OkSt5kzKCgKUGVi5XhVKXSF0qC2PCWjYYUP9lIICl0Pk1I+Ib54J01dq7xijf2Ac
	coYRnq3tIiRn2x7GrhSxQ==
X-ME-Sender: <xms:qbHLaBdp_JkgrwdsLhPziaVYarONhdn75Bz-uRgeiqho5DCNi4Mj2A>
    <xme:qbHLaPOEDXIwb9yYGc7XgZ2aefiRLZ-DU9GfclUFSLu-UoFj0l-8ONXkcYDL1Gh_M
    N2vaCwD7LbdswqHfqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprhhosggvrhhtrdhjrghriihmihhksehfrhgvvgdrfhhrpdhrtghpth
    htohephhgrohhjihgrnhdriihhuhgrnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    sghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmh
    dqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    phgvnhhgrdhfrghnsehngihprdgtohhmpdhrtghpthhtohepphgvrhgvgiesphgvrhgvgi
    drtgiipdhrtghpthhtohepthhifigrihesshhushgvrdgtohhmpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qbHLaFK4PNHQyUqkHV_dgUof_om4S-pFHPkFmxvywGbrwGEfMYMD2g>
    <xmx:qbHLaA3phjWFaK9SbPYeHWmJRYj5osTWZoTX1vMOxI6KVQxYEYfs6Q>
    <xmx:qbHLaJVuR4BguJkrwHX95pqxH8UYFKbwjiZLjWwhdBsJoi00N9qIdA>
    <xmx:qbHLaCM3buqUl0IyL-4GjBWbWTjcfRqWCbijTVXMRNLi46Z_WcnADw>
    <xmx:qrHLaLymjW7F2MjNYIzgRU6hQBKT1o_dmIy-nCb3QHPXpS4je08F33XI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 83F6A700065; Thu, 18 Sep 2025 03:15:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIKy7lM-vHXJ
Date: Thu, 18 Sep 2025 09:15:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Fan" <peng.fan@nxp.com>, "Daniel Mack" <daniel@zonque.org>,
 "Haojian Zhuang" <haojian.zhuang@gmail.com>,
 "Robert Jarzmik" <robert.jarzmik@free.fr>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 "Mark Brown" <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sound@vger.kernel.org
Message-Id: <fd5451a1-9720-417a-915c-1ee3149426f2@app.fastmail.com>
In-Reply-To: <20250918-audio-v1-1-e9d0df5c60d2@nxp.com>
References: <20250918-audio-v1-0-e9d0df5c60d2@nxp.com>
 <20250918-audio-v1-1-e9d0df5c60d2@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: codec: Remove pxa2xx-ac97.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 18, 2025, at 07:44, Peng Fan wrote:
> With commit ce79f3a1ad5f ("ARM: pxa: prune unused device support") and
> commit 2548e6c76ebf ("ARM: pxa: pxa2xx-ac97-lib: use IRQ resource"), there
> is no 'pxa2xx-ac97' platform device created by machine level code, so this
> driver could be removed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  sound/arm/Kconfig       |  10 --
>  sound/arm/Makefile      |   3 -
>  sound/arm/pxa2xx-ac97.c | 286 ------------------------------------------------
>  3 files changed, 299 deletions(-)

I think you are right, I was sure there was still a way to use this
driver either as part of sound/soc/pxa/*, or as an alternative,
but now I don't see how.

If we do this, I think we should just merge pxa2xx-pcm-lib.c and
snd-pxa2xx-lib.c into the respective callers in the sound/soc/pxa/
driver.

Robert, can you confirm?

    Arnd

