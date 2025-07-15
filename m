Return-Path: <linux-kernel+bounces-731761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18DB05920
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B64E2EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46292DC322;
	Tue, 15 Jul 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CPN0oTWo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E12D0C75
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580151; cv=none; b=aOgwvc+yq1C0955mHi1x4soGgwKoliPbu/41/PB36SHZCqbMb+v7hu+vmMGOEKycnbESpeLnL68eogHHBh46aOPckovpAy8au8gWO/MDuHdgBJS+lTHq3boVN/8Lg9zvesrITL/bYsJfvBTI0zCyDAA8lycQhq+yIb9SFZG/zOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580151; c=relaxed/simple;
	bh=H65xc5R0MlyO0nD0fYmQfSB1vnTb//tbsmGqm0vbgPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQVBa0S2UyAWvXlAkZdxMxeZZtJgU6WpuR8hoA9VmPf34gSuGnW0K4Md+97bVffteo1ReaMbSK+NOWdz9L1nWkld0Hr/izAKOu6NfMnmTrNDK1WPX0K4KU4zUSnUSUVJS+CThKA4Cwzh5AE02bdplqmkxOuZiRB6hqwC/DlLjrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CPN0oTWo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso952902866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752580148; x=1753184948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYFAX28B73ZWV81uVTn+uVGouCQNziKk/Cb++ZONJv0=;
        b=CPN0oTWok489uuh/Ul0GxV71e8yodVgNEnbtawWwqo+8q4/TmYy/LEtF0wKOv+2kIz
         40VdXQLTJBnJ0ipt8SXlIk2bkkSFvutUMq0iI1ZN2bO2PX94O66qcWHHsjzIxjKrAOCx
         JcBJxDKjNWtPMzwq2m7utfVrrM3CW1zWHx4pf1A9bcAh+XkFJQ6CyUL3dU4NqfZxHOeB
         e7XCDagxk2k2hQ9akBZvvhZoUEq0Vt3fi8EjW6iBfYm+mJ4QRi+S6reMy+D4KDg/5uJx
         JKe2ywOCQQqyiysPap4IT0zMeACSUj+GVNWezEi6chw8q6ce06JFcRLw/fPSXkm6FOWY
         G7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580148; x=1753184948;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYFAX28B73ZWV81uVTn+uVGouCQNziKk/Cb++ZONJv0=;
        b=kVLrwHsJAy4k/gQJB7g7gNy0yA+mXm94UDtEuulvK+ito0g4o/ipUHGe60eufcCJ54
         DRlaSUsbVq7t1VG/h+RknxPOOA6iNwmCpcuVRBlU+lJ5gS1GAiODBwux8JKLqx/rDvaq
         H4H9aPvcNcqCPnpbKJDPPdxkbppOHZsVEfQQHGom6bF6qlHBUlj7jLlog3XnYKcRzzmu
         dF4UW6uGiRzRn++8lbHKej0NLsZldp2/MjlE88VEvO8fMG//ooeAe8oY2cRYaih0tqAd
         N5bGtylQoY7UZ1op9GWuUOJYTFzMwamv9iUGZvisqRMFl9aJbtTNWcnzA5ryOiy+jjgR
         3KoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPyA1a7/MuQB/F7Sh/DyZg1ICq6aIZ/g7DARvUK4a54dAKHpp9tinq2uln4jlxbxXz9PYS6oCzcc9Gr3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/YcNAgkDAXzfYr3keRbh0OdcYQ2JUPIQTM4oS6FenYrAKWMq
	/nDC9TgG9Iu2YNIuxCY9s8k3mKVhrPVX8L2YS5BjZB3ldwYBlVUkTE+vmj25XIGovPs=
X-Gm-Gg: ASbGncuUjgFv3JdeteH5AoFggi5raGHwJxre6z/AeAw07haerhtwCfI3tEaYhHbLA0w
	XVZOEVbsB71aGmXXRdUnNAB582ClmUP0ho3Itl9MV45zrW2CjAGKykz/JWcxYkzuEZa0cxzL7Vu
	RcM5VB2lj1shfno/itzC0E6tjoL+588O5EdrjYOrYUkVeWhK6szLo2u5OCYJeTebwMqhjt7pypc
	H1LG8ImhHvRK5La0oaVyIZWFrD4l9jJynnzzolZ0F7ROvXXww1Yx7wzCviYvxvf9el5DdRVMHK5
	F7lQw/71PP4JTfbgW1LwBzdFDy6fsrhezND1KlRQ7cAhjixeXfClBDCjrCff1TP/gMsA8HlBTRv
	VBbxYQ6Asa/Q+umPDBAH6fFFaBANFshRVZ4ZR4enK3QQWWSa2A1D/FYSGJ8kh9EO1UA==
X-Google-Smtp-Source: AGHT+IGpZJAcfXHpIV6qXP8Zk9PSOKUee3mFWI6sjN8MP30hMErhwYj770Upg2/rLyzH0ZZRMVTPig==
X-Received: by 2002:a17:906:f5aa:b0:ae3:5e70:32fb with SMTP id a640c23a62f3a-ae9b9488e4cmr232066866b.4.1752580147476;
        Tue, 15 Jul 2025 04:49:07 -0700 (PDT)
Received: from ?IPV6:2001:a61:1337:8001:1c60:c024:2a6e:24da? ([2001:a61:1337:8001:1c60:c024:2a6e:24da])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91d05sm984882066b.3.2025.07.15.04.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 04:49:07 -0700 (PDT)
Message-ID: <22e2c652-7861-48d2-b769-79b2ef4ea878@suse.com>
Date: Tue, 15 Jul 2025 13:49:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
To: John Ernberg <john.ernberg@actia.se>, Oliver Neukum <oneukum@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ming Lei <ming.lei@canonical.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250710085028.1070922-1-john.ernberg@actia.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 10:50, John Ernberg wrote:
> Having a Gemalto Cinterion PLS83-W modem attached to USB and activating the
> cellular data link would sometimes yield the following RCU stall, leading
> to a system freeze:

[..]
   
>   	if (!netif_carrier_ok(dev->net)) {
>   		/* kill URBs for reading packets to save bus bandwidth */
> +		usbnet_pause_rx(dev);
>   		unlink_urbs(dev, &dev->rxq);
> +		usbnet_resume_rx(dev);

This will schedule work.
Do you really want that?

	Regards
		Oliver


