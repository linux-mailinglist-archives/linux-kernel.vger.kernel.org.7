Return-Path: <linux-kernel+bounces-798049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E179FB418E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A51BA483A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF392EC550;
	Wed,  3 Sep 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RAQYzjRm"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9412ED143
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888866; cv=none; b=J54u3eAraf9hNDZxvhu0J9cZydlgo/y2cFFra27bMGuC2c845EvcFThw7Zsve8kYoxJds8PY7rnEktujhSfaY+onmQJ8d9gE2IO25SIKDW73IsHOm5zPQxV4+O1TN0Ua0M5agitXUBz6MwzHJZi7ngFZDL6cXX2/k8vxGKlFjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888866; c=relaxed/simple;
	bh=JsNVQI+TIrorPHcMKJYXnp9wWGJJyxNgOxqE89EoXZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFQVo3wbiCgpGNRcBX26KIqxxq8+U6s8DwxPF84N7C82Pc6TmrmsCB+7USefXj9kvWHW2e8Hjf39QIda1pjG715OgNZ8EQxN0HGySr92QfHvTyX/6Z1ltI29pBFyx8wKSJJ7hx7t4hfk4y74jB1pTan2cotpM2ozNThkcCjudK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RAQYzjRm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so42851375e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1756888863; x=1757493663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0TB5YZ2Z3EXPa0RdeJrcF8HUqJiNgkWuQmRT0sSvhkg=;
        b=RAQYzjRmqDiE55QbU2Bq0JGGqXBOGeyQ1OuIti4VY5w1MmdXFGYC/zVXyBNY1cgAmZ
         7sLDiI82r1rbo4p2H82OfyySEx/xjWjcpc4fEtkt1i6bfDy5cXZ5ITOvEbTIBTJEHvvE
         SfaRfu+v0HxERv0+c57DdH26FFvONp8m+RxUmGRy6rJYF5U+KHCeSqEzTy+AygFWaCdf
         ex6vPzYq2X9zlDPf9PSORQ2sxAcTVjDRUk/OGcTgX4Sxv6ajagWuY2zkp0VA1ZMMe/Zw
         17cs/iVlH+FD/tMYNg9vFZX4kTgzo/0XnjXqKJJBLw2q82zrrYGIV86pW7VbyQSPV918
         KlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888863; x=1757493663;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TB5YZ2Z3EXPa0RdeJrcF8HUqJiNgkWuQmRT0sSvhkg=;
        b=G5Z3waY4tlzI7alsz3nHwDuvOfODTyWWFwZXpLs9dPfPGreix/p3cg0caZeR4lJoXM
         laHc7cT3bfC/7uij8mV+m9D6/b1zRwuPfFeFDCBA+mZjku/4DYGVsfLvVd2nd22DcOCN
         KQC65f9356FIO/z+CE3OMb5+y0UpHElsDGrE4rBPm5bRNdsCqDTatQPNcA8+qxZWIsP/
         JUuYyVxXmd3gC76EjhyKA3y9+PV2JyV0MIHT74su0Vxlq8937EnpcOrtBSAHIM4nyhwm
         HAe4sv8BbMewGdDzrV6o1YkdsgGFFTj8V+KCItMMn8K5NQ1A1a5ujoPZ0CeYaDF6LIwD
         InYA==
X-Forwarded-Encrypted: i=1; AJvYcCXHtQtXyWoj2iSVhpRAfdPIsItFHkSEXC7uv6JCALHpnO8WC7TeKYWx1fJ6kK96XJJqkF5f0vXkPLPOooA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5k8DQ6SUqGECMJSNm1WE+7525A+UtnjZSUCodfq/bFH01oBaT
	GWqVl7BjQ1Lh1zKdRMG2BAfxdeOmbgcGbz/6DADMm/VEPz2L2GqI4giBl722TFx1LTHpXY/2QV5
	omAHy0F3V+NTHNzSknQekbr+Z10P5a2soG7jU8WsPQ1MOv8r00uMYYVwRGA0=
X-Gm-Gg: ASbGncsfaGXfpMxbq52qH30e6NFlYsQICjeweRn2UeIJ6uNb14lwpbyOKwWzximO6Pl
	XaCLwfBIB0x7nZv2vHEubLS9yZoqvUDaQ+v0WaRE/G720pvELs8CtUnQMdQ//5A3Iv+TKRlN9nz
	xC/4fmnZomSVgBgdRg5jzDtOObSC0vHTMHwv7X+zX0WGUTLg5kTr0+gyLU4z47PTSfO0Ov0Wfow
	VDl1+sqOIM1LR61kB1rzxe7w2PcZ/b7kfxpqnt0gNMOgTuyCLnr+FhdjzLT4EpE55QRLm7W2Drj
	0W+qS47Z2vAF1RygSTB8pFenEl9CVcSrEvKSQJpqZ7HbSy9/fGwx+aKx5U/1DAhSotzHoh6vMxO
	zoe6XF40tJWmVmGZi/Zlr5EbnRA1p9owiTddKKNBqIFkT+J6133KknNrsTxOH9lLsgVVR
X-Google-Smtp-Source: AGHT+IFmeOmpAlDVviXXUbydolz2hQ73o+t1pjbKxEZVQJtQs/jjkhYanNEEinULoQLn2ujCXocLPw==
X-Received: by 2002:a05:600c:3b01:b0:45b:88c6:709d with SMTP id 5b1f17b1804b1-45b88c67339mr98096095e9.25.1756888862683;
        Wed, 03 Sep 2025 01:41:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9d8:889a:5a4d:126c? ([2001:67c:2fbc:1:9d8:889a:5a4d:126c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e886619sm227507755e9.15.2025.09.03.01.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 01:41:02 -0700 (PDT)
Message-ID: <0c104f3d-5ee6-4d07-a183-62d603ce56df@openvpn.net>
Date: Wed, 3 Sep 2025 10:41:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ovpn: use kmalloc_array() for array space
 allocation
To: chuguangqing <chuguangqing@inspur.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20250901112136.2919-1-chuguangqing@inspur.com>
 <20250902090051.1451-1-chuguangqing@inspur.com>
 <20250902090051.1451-2-chuguangqing@inspur.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250902090051.1451-2-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello and thanks a lot for contribution!

This is indeed a nice improvement, however, we've been working on 
changing this part of the code.

We already have a pending commit in the queue (to be sent to net-next 
soonish):

https://github.com/mandelbitdev/ovpn-net-next/commit/9b62844193de705502fdf4a693dfe0f6c7d94f13

With the mentioned patch, the line you are changing does not exist 
anymore, therefore I don't think it makes sense to merge your patch 
first and then removing it again in the next commit.

Sorry about this!

Please feel free to stick around and submit more patches in the future!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


