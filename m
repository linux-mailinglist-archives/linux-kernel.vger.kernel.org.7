Return-Path: <linux-kernel+bounces-800447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A881BB437B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B53545603
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944FC2F83CC;
	Thu,  4 Sep 2025 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RG9qP27m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TfdnPvfb"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC67081F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979810; cv=none; b=uFutSAQwMMMvjOlW3zSIrqoU42IV/T1KNu765QqXAWHEBV4elOZNPA4I423aSm0poG9QmdE17aP/XT29rVG5eyjnLi3ZohNn89POR7CAcJYN7dzfrAtCmy/SyFhElRrlWNQXcn4U+zz7jhWZ/VUxjNljBhryOFUlMDFO+RE5BUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979810; c=relaxed/simple;
	bh=Hp0pjo9dsvLoMtJagxCi6kGhKLni3jcoMZk2rsRdjIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6W4QdsboWUEEG9Qslt5mwZX2zBOai43btyjPeVXoqWVDJ5wJB/9m+zRRu8yt0PNDlpW2xfMY2QQukWWEmVEyXKNLKdFEw94DmUX+4MQaxmtnmWkdqr6SyuwAWS/w1/C92FO6yaaCQTWEeAd3gk+sbScD1KU53VMtFqdnenPdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RG9qP27m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TfdnPvfb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CF2A514001FF;
	Thu,  4 Sep 2025 05:56:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 04 Sep 2025 05:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756979807; x=
	1757066207; bh=qRgjtoyz8BA3D8r3zYcx6ZaoyRe2lnSpKHe7TcKNhUU=; b=R
	G9qP27mwqyiII+hfHECX9yliQqY3nn2cA5PST7USHOvv/F/BCKBOMCMi02VcG/+E
	ts9N66Ve476jEMYSvdDSvXqCm/uKIM+pY+am5dR6mQer5Erwzrw5mZRUFwTaOrdN
	CUZItPP5V19e/zHeDDsNIyq8smsuwPrL6bmhc5C78BkHJYe8jzIiajiTu6rzQHgY
	O9X58DyaFDgctwytnn1A8L44T8JPipZIPb02DxhG7f4oc/J2LIkigql3BUh91E6z
	b1fcA9PtDrBrPaRRSF7sOkmMoI4gW7gqVDis0P52cdPDRLtBMR0a0BNXvx/tL4pI
	okjJ2+lFWpsFh3fX5QNpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756979807; x=1757066207; bh=qRgjtoyz8BA3D8r3zYcx6ZaoyRe2lnSpKHe
	7TcKNhUU=; b=TfdnPvfbp3X+wQSPON5F3tAxixDIGim32a6IcqbXO4YDFkhz9uS
	NvUa8jGG7SZQ5LiypGUjc3wYPumTtzOxR/3tY4P8b0/WiNMVUrI5H4xLQ8HAlgKn
	uM7cErR3z9OJ53mkygogwFWWMmNuaWV+gCPgs3XjplBgKSooQXjIYjWAkIhbPzeI
	VBjbS8jUwh62PxapT65zGiHTNcN2Epfkfzgtg0SJ22qSPu6uwAKcPRrp1Tn+Cpzw
	E74qyQqL14B4Hn8YrLBtAsViLRxK8efvKY80kVaE86nm8E0bDvsVdbwMB55hMvYU
	SbhCZRaly+jWdYEpyfAP40uj/VvElRIYfwg==
X-ME-Sender: <xms:X2K5aNXggyFnuM8Gf7ca_BQe2fVJFRuALkjRUZBeiK96mH_TxlNWGA>
    <xme:X2K5aCynwOO4qZrow49r5ZU8gouZ2lBrHQ5dKNA-MUwoglk4C2Z3aDiDu1gH-pCC5
    GjnY3fSInBEuDPnahE>
X-ME-Received: <xmr:X2K5aKSzgDTO9IM3g8rpOvVBPtYziisnKK0-G79NYfO3ZmXRmIBHPkK35cIJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcuufhh
    uhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdeludfh
    feefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopeekpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehjohgvhihprggsrghlihhnrghssehgmh
    grihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpd
    hrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:X2K5aGglJVLMEXr02yQaO1VZynVKYNzRPGjT5Vx3zkuzqjuzykj2UA>
    <xmx:X2K5aJk9ADht_BuLSzm-Ubm2k0mLjLQ4SLqJTvRGFQFKEkZ4vedmBA>
    <xmx:X2K5aBuFmw2OWHahmHBNklYIENKbQ6yWAJNgM0KYvUokHkpIgZIlVw>
    <xmx:X2K5aPajPrGLcRfLKIh2N8NJGNjncrMNDNB5SxCpax78m2gfd0icZg>
    <xmx:X2K5aKJ-LpaIFXhjkM4eMEDCsng7GTizFjY_jUod3_uREqhTxMMTVo8e>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 05:56:47 -0400 (EDT)
Date: Thu, 4 Sep 2025 10:56:44 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] fork: simplify overcomplicated if conditions
Message-ID: <tzjq757k4tt7k2mkcapttjuax6zgzr3nl7ivusuvxfmok5kvb4@vub2gw7vp7vu>
References: <357638f71edc7f1d9814b1851a64e09a8895bffc.1756968204.git.joeypabalinas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <357638f71edc7f1d9814b1851a64e09a8895bffc.1756968204.git.joeypabalinas@gmail.com>

On Wed, Sep 03, 2025 at 08:46:29PM -1000, Joey Pabalinas wrote:
> Since `((a & (b|c)) == (b|c))` is the same thing as `(a & (b|c))`, use
> the second version which is simpler.

Huh? No it is not the same thing.

a = 1;
b = 1;
c = 2;

(a & (b|c)) is 1 which is true.
((a & (b|c)) == (b|c)) is false.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

