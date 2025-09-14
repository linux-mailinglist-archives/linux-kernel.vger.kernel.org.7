Return-Path: <linux-kernel+bounces-815745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14941B56AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E6C3BB6B8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7222DCF62;
	Sun, 14 Sep 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="UEyTsq/8"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911925F973
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757868978; cv=none; b=MkxZYzER6W7icc9s/z0dorOdR9fxRFBUK78w/SqXjX7G4JTrBSPwmQWxDk6qKWvzBdp+qzb45lfnV4AW9gc31mHFZKu+fOMncnf6SIVRgUL6dTLZ6fkbhItn6Z4RLxOjDgnYnNp75cBocASYtu5eBzOTqm4wABWHGSZmrf1NV8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757868978; c=relaxed/simple;
	bh=RkfQfhlJbWyA2LHc1bvVYWrp9RkM8HrXK7A2wjNzvIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb5iIqTLVPNzKiAsv92fkgA/h7V3bEYnyj1lBJ+m/yHQZQ9HpB3ExuN4STBXDI+ilDeOT+eQmz1uZLwllo7ffv5oms/qq3EVyWL2unj4Fx6zdphvnpbb3dox+1fbPiwKeIF84dik2kTOhMdlaBdYuHJynGWRFh6QXnSFtbI3pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=UEyTsq/8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07c38680b3so358319566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 09:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1757868974; x=1758473774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPlpyeAwSRDCzGoq7PgUzo7R9sROP9lHXNmER4Pl0Oo=;
        b=UEyTsq/8pAHwi+9IH7M466q475q0LO+gzT9fX/DKEThrKeJ4CVCViGmTCEM9hneJbN
         tzDYssgdnVoC2KRYJM/5MoN5mideTncUgNFC9+TkC7ZMoqrMb0EC+GDMI+JTI8brCgcy
         FH10yS7ugg2I7a1NHE8791AcrUeSFwsMgT9ttuj2dyHi2mpgygjYfTHDlJWQ+sLxcNTH
         Aw1uWKyGWp9TEGE4no9J95JcdbyLVeyw2Zi4SHizjKaBMhZK+CB69iqApmeCBa/Lrj4A
         1BRDk1KaiPEictdpO/quanr2HJFmfT5esvxx+pdAOJUZZnlA1zbXs1y0HsKrPasKTrT2
         nqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757868974; x=1758473774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPlpyeAwSRDCzGoq7PgUzo7R9sROP9lHXNmER4Pl0Oo=;
        b=D+0UbmLwLwKJKyI615SuZ6RDKANOIfSuDEZrNJGso/Vq6npiOkZdsK1F39gFGuNDd3
         6nu/7bGL4t8JImCTwQuXX0fF3GXzW87BtajZ45m0XBJz616tPFnAs1NpFMqkmtlnLLkV
         Q5i2hSYLhoSrjl/KA/uoPUj8/17iDDbl5to+2UuIaWnlbPirXD6AeuGnXZaHGX2wM+XQ
         Yl5aUI+5eXZY3rFsIlOc/tyeusAvVkRWNW2hkFy+s69avs+ZrGEiy6lKK4z7USJRq7bJ
         /YceuKpky7i4WdMSyNry1ofZMjB7Tb96rRR63PygoJu0G5PF9JS6vHSK9OXHqTuer8bg
         vjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUZT4auhMnWLebXsj7xHCsMIr2sDh7fk5TcnTu/tFafyYem5cfF+73x/x+wTVpNXijpJ/tVz7YojYsQn6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxnlWJcxPOj7fXHArN3FbOJ3k0r+YQRr+bN1Suqwvbsiwza08N
	Tb1TLWiHH6ikvXhkGdGzZQJbCDFltWmJ5praoE6vI9lA1mCN1oEHn5tKdFdWWm/dNVQ=
X-Gm-Gg: ASbGncvaHlgZpO4W8czQ8FrYnInwtA69rEaQ+oPwfKwymEEgzdhZTzovyrFQoOMuQtz
	2nLCvugBGRJSMDHJKec6dM+aH0uPa0mX7tLLSvMP8JT3SG87t/2nNU7OJpkaQFsbMjVXKaTjHfX
	hZvy6aaA97H7l5xSFQU1HBlF0/l4erKxbyJwwPTuBuieKn0//gqwE+LDxLynpUpr2MY9M7LfaN5
	LHqIlaHGUvahiEMGjJys+yO6jx+6OBGTad9SsGpESjLDzr2tjWvwyj9Eo6k/LeG0383NEk/10uq
	jeBu+dgss2YNxX5GYzUvsriAouno1oCfyfJjH2O6MnOwu1OD1QZMnemCecbkgI34xEAvaFi3/Cb
	KdZCVlVav//fWh7RJ5dmF37/3fZVl1FiJMk13l+604cYdq+RTdjOTN7cI52Vvj6KlGQtkOg==
X-Google-Smtp-Source: AGHT+IFo7cg/KTe51S4KiqVqGNE/pynRgI3QfYqO9osoGDCNwd6sXzlp1MQZ0N6YUJ78vOJwr7Bgcw==
X-Received: by 2002:a17:907:9344:b0:b04:4786:5dfa with SMTP id a640c23a62f3a-b07c3820e57mr986866666b.35.1757868974236;
        Sun, 14 Sep 2025 09:56:14 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::a43c? ([2a02:810a:b98:a000::a43c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da302sm768603066b.16.2025.09.14.09.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 09:56:13 -0700 (PDT)
Message-ID: <a9d9967d-ef5d-47ff-88a5-b1fcf9bcd319@cogentembedded.com>
Date: Sun, 14 Sep 2025 18:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: renesas: rswitch: simplify rswitch_stop()
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250913181345.204344-1-yury.norov@gmail.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20250913181345.204344-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> rswitch_stop() opencodes for_each_set_bit().
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   drivers/net/ethernet/renesas/rswitch.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
> index aba772e14555..9497c738b828 100644
> --- a/drivers/net/ethernet/renesas/rswitch.c
> +++ b/drivers/net/ethernet/renesas/rswitch.c
> @@ -1627,9 +1627,7 @@ static int rswitch_stop(struct net_device *ndev)
>   	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
>   		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
>   
> -	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
> -	     tag < TS_TAGS_PER_PORT;
> -	     tag = find_next_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT, tag + 1)) {
> +	for_each_set_bit(tag, rdev->ts_skb_used, TS_TAGS_PER_PORT) {
>   		ts_skb = xchg(&rdev->ts_skb[tag], NULL);
>   		clear_bit(tag, rdev->ts_skb_used);
>   		if (ts_skb)

Probably shall be [PATCH net], otherwise

Reviewed-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

