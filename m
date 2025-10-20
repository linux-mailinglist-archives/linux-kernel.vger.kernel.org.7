Return-Path: <linux-kernel+bounces-861940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C9BF4150
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E71FD4F4016
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2D62F7ADE;
	Mon, 20 Oct 2025 23:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxEt3KwI"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EDB2ED165
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761004479; cv=none; b=mmVK7+uMnpC/84vy9Pb+Hu00sSE2rmwS8LX4PxswhJgsVHaVzpz4LjTJPDpfrLILJzjZphjs7WIKOHuE/j3Yl0sqdpo4VDtB3bD+AVIJ+IYnR01/cd0GSuKZe2JPdicffxSHxMngU/X3REogTVfEL2p1YFaUW1Lbcg9HPSpet6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761004479; c=relaxed/simple;
	bh=Z8yBcQJaMDVMDwGKP92PcEANBe9SMhtbIsxuU/XAv6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2Mxbexs31zyM6XSwz29YK+0+PQlThRb2PpjRFI1vNJPvBS9kasTdj7yx5UKY1puG46g4ZDNWCWIm2l8I2NOD3RGRthggD9zZ4AINUFP8NwXEgounUIUfH/WD+O6C8aebGHYekdDC9YaWA4fwxHhr2hJC/UT58Ii6Jnm85OOI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxEt3KwI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7835321bc98so4323627b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761004478; x=1761609278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkJQ2Wqv2WIkS8r8m2VU+kwyMn/g5LRAACPYO1/MIBg=;
        b=GxEt3KwIwHh8VkYt/6Hwuf/IhkydNHarL+dhQT2kaJB466b6T9JK8szeEOCs4QSIMw
         6jck9vs578B839o2yDz/jjSDVOwZIsaGSs48tq51uhRJHQQ07qKuRcll6k69IiMeJh3c
         0ArGk/AVQpP3ncKXUFzVNYAHnW/gWmnd6RKgTeQlrJq6jFoXkP65Dj45eCyFvgDP+E8k
         e3MY7HGsmMHi11PdYteg8sn3QKM2lvNqgmRRXuJFf9kuyUdsk3hjP1GMfspFEG9tRbvR
         mLi8mFQznpIbnT97helbZNp6vkVXYipBdyEW/Dfhu7Gv7alLkI5Aacux65mJ6w0Cc5Re
         nhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761004478; x=1761609278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkJQ2Wqv2WIkS8r8m2VU+kwyMn/g5LRAACPYO1/MIBg=;
        b=LFlT188yUhPbbaby2680DZPjPL49O9EDWK/+eAZsrato1RN2MHum63TKmGeBYD2o6U
         XHNZRIWUtTwxVsG2g7zIyYMRjVCRHZIrkSN5lD0mJFJcDGVPLR+TVrQi2x4R0afhEZhL
         H6t9GorTpYzwuPzSYZe5n/sCWA8HYuYRi8zihLjVdwTuWXWnjcNPCzVpKdaUiveMfO/I
         LMeh5CXZDvyuIwjD5yB6rFYEkxIxMaspvOJUEHl/CaFNkE6pR5IYUYsRqnSoV6H8HEv4
         W0GjlJG6aucN9G7HxIv/HwFBZq040e+tShlvYRyNOCI8OKOmQZSkpQ2aFf1rA76CaxrE
         +FKA==
X-Forwarded-Encrypted: i=1; AJvYcCXdJzPqcF0hHTDMSQTagEvQgo0eXT4YJ1E0Uq41EUWJGJ7hySfzcZp9GGKCinTNpxFOUsmMvSneRCNqQXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQG0P7QH7rcCb30O1PQqDVcKKc/h+0tS0v0N7gcXgJtb1QugJ
	dAb8YtU4PKVWs/8/g1VqOvTNbXcFVGEsgaCN28GHBajuKo56aAb+gtcw
X-Gm-Gg: ASbGncvZ0WAtM1y8QcMmSUzTR0tX1nAd6JnD61cy5EuXVqTNX/H+Rq4fqZJE28DirvN
	fl+GMKDn+QJ7AuDvWN216Z3BLNUi/0vjhhuwTV8yTI5VJUyqphx44EdT+1pbr+vJuC14aNa+Eir
	zGQkDhjQzal9q7UffON8Exy2SCZx+k5PUprQPeAaGlpxIPOycLAltxj/IRN6qcTHEvXo6IS/pA0
	rvciZ45Ad9HF0fJP7jRz9T6Nd3wOG0XVoyeRcyYcuc9LEcMG9oJMYYququLuz3DfjWw6/A13Ki7
	z7S8WoTM1aRgPDZwz2OGgjxcmUNHsMR4Jvj/4in1fMzkCKu9TT0HgN4s3qBxfTFeLv+rDPcswCB
	Coy+h1rE+a4UQn6dSUNj9FZbCZLE21fvZ/TowI2g3uZknSfUBclyDTUyJKVXoIrLi6lT370jvrd
	lzgSGQxgDVgen72djQ0CFPcQ==
X-Google-Smtp-Source: AGHT+IEWbUvYFru0xgeOb8F6Gj2YJIGo2FfUgJ3zMwHaKzd+9qSePGSKb4FX+0Eekq3XescoXtalXQ==
X-Received: by 2002:a05:6a20:918f:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-334a856e67amr20900400637.27.1761004477385;
        Mon, 20 Oct 2025 16:54:37 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15b0csm9487310b3a.2.2025.10.20.16.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 16:54:36 -0700 (PDT)
Message-ID: <c42e042b-f1b1-453e-a350-dc5c99d38c75@gmail.com>
Date: Tue, 21 Oct 2025 06:54:32 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384,
 SHA3-512, SHAKE128, SHAKE256
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>
References: <aPXfzd0KBNg-MjXi@archie.me>
 <20251020005038.661542-1-ebiggers@kernel.org>
 <20251020005038.661542-4-ebiggers@kernel.org>
 <1062376.1760956765@warthog.procyon.org.uk>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <1062376.1760956765@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 17:39, David Howells wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
>>> +If selectable algorithms are required then the crypto_hash API may be used
>>> +instead as this binds each algorithm to a specific C type.
>>
>> What is crypto_hash API then? I can't find any of its documentation beside
>> being mentioned here.
> 
> crypto_shash, then.

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

