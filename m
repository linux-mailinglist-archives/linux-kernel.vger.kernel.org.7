Return-Path: <linux-kernel+bounces-746261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD422B124BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D6AA7A39
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150EC23D280;
	Fri, 25 Jul 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="H5HoZ7we"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779AB2D052;
	Fri, 25 Jul 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753472032; cv=none; b=DjOAPd8QbNzWmUC1CeTVow/41vLkRBkH/qhXVc6mfJzm/SPgzyIkpeFdJJV818NODllCheKxRGfQGLUMdwa/B3zBRn+8AN8ODZUZ/OYWM/26TbIm6GT1ocSxeBpSqDR711lS77ogZS1W/QN4Wo5+t5mv1wJt8P/vDW2qJJyD1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753472032; c=relaxed/simple;
	bh=r8mlM7FiQEg1L2QTN1ooTgTm0zlBWN9V95Czg8v9tjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O58ZIjXJB8liwoD7oLSOG/9uREj3ePYYCh36e4XvkiT7H0oe+ncH+YJnDQs92JwO10sXOYVcRpNzJ9J2qEtv+X9Dv+tH9vpwUERf6hk6yjCxBnGixw8Jzy/Zjp0pips3X7NiTXmY7x2oA20eAWnKdzEdNybdhbIXrmo+hMMWuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=H5HoZ7we; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753472014; x=1754076814; i=deller@gmx.de;
	bh=prdgWERnB6vVLOAd1xe7swblcuaID8D87uoTNlv9ZMc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H5HoZ7weK53wBWT5fxxIpOWPfEC84Rjb1jLEXfQKCUExbtgteIq6Y/kw/EZaOwsv
	 aBdVyqQ5/9W1CNGyxe4RTIsTBeOiFjLQ9FslmdNoalG46TmWT+dCT9M12bDOKsOnL
	 ulXhPVZ7biHtQt8K6tEuiCSTKFnnth9dJV6L4D3Qk+0uEqmo58wFLwUIbVPD6Om3M
	 s//J3z+1eeRJzGpGfkjQUs4GoXZXI0z180p4cnWrvt+Tw2Fc528AGGHRwX5R5h42F
	 bYWuIU1b8iG1dmbmx1ifcOyJgE4YTn13lHXyJmp1NnO+1ZPAsuNG0sWCAf6J8bSx1
	 GgGisWB3dX4racLbig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.173] ([109.250.63.22]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1uSF0T2Z1T-010le9; Fri, 25
 Jul 2025 21:33:34 +0200
Message-ID: <05d6edd9-aa6f-4ddb-a32a-6b2ec844628a@gmx.de>
Date: Fri, 25 Jul 2025 21:33:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Makefile: fix a typo in palo.conf
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20250625073102.804075-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20250625073102.804075-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X0hVkHDOJegvbM62VszeVr0a8WqfCDRTgaAPn9o9XFqb9mKK3sF
 b95rAFQBgD53UsUg3ICDdQ/3rz7F2g/eaUzK7x8CIik5WTllHfy2W628B/bKvmgauqFOat4
 s0j8Wi4CVf7d6sZIjMTtyRnyxloi7UEkns1Vat1RDB4sq6o8e+Fs086OFnUABqIncg/X18g
 /9JLKsjdTCaJbtA1KMmQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4NQW6PHIHDU=;k96lQQfIgvoLe7CBrh04ebKQpEx
 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

On 6/25/25 09:31, Randy Dunlap wrote:
> Correct "objree" to "objtree". "objree" is not defined.
>=20
> Fixes: 75dd47472b92 ("kbuild: remove src and obj from the top Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> ---
>   arch/parisc/Makefile |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied.

Thanks Randy!

Helge

 =20
> --- lnx-616-rc3.orig/arch/parisc/Makefile
> +++ lnx-616-rc3/arch/parisc/Makefile
> @@ -139,7 +139,7 @@ palo lifimage: vmlinuz
>   	fi
>   	@if test ! -f "$(PALOCONF)"; then \
>   		cp $(srctree)/arch/parisc/defpalo.conf $(objtree)/palo.conf; \
> -		echo 'A generic palo config file ($(objree)/palo.conf) has been creat=
ed for you.'; \
> +		echo 'A generic palo config file ($(objtree)/palo.conf) has been crea=
ted for you.'; \
>   		echo 'You should check it and re-run "make palo".'; \
>   		echo 'WARNING: the "lifimage" file is now placed in this directory b=
y default!'; \
>   		false; \


