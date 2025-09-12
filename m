Return-Path: <linux-kernel+bounces-814441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E58AAB55428
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E31D65F90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8B266560;
	Fri, 12 Sep 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlkGAl9O"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B257AD1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692243; cv=none; b=plG2yKpchaRipsiECspxXU0/cNRJDwaAis/4f5vzeAkfZIBBM0DhuT4tNXkxobftMpD8haq5FJn5i6nRT2/C8+Z8vzhfxBGUMh0KZ64RCCuaaGCsVeXiGJJwjdIkbnoQPq+VUvXDB1pUigxhLBFlfbfRT30Ul4tKy+1A4IN0B2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692243; c=relaxed/simple;
	bh=QAP8xPRbr/UWVUxzhd8ZCmVofjt9pXTb3Og3/f9CxgM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Pj+IWYOW8Wz4Uwde+4qh3SMUTrOYptuCqMyuIAX75r+B7zGBUajjlGyPU4Bdclonlf9RYHLpwl/obRjbMs5644O5h9OMob3mFuh/uctmM8Pslwpc9/I8gqwkjL5KF/JJz5vR/PrcEU45MwVXfhXrNUUDO9ik4+Nm06hIRl+Z79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlkGAl9O; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2071022b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692241; x=1758297041; darn=vger.kernel.org;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmHZZLM+jLINLbKueG0GF/VWczCVBfuAc7hrSwl/VJw=;
        b=NlkGAl9OLlmIbal17GWxuT/1qYkQJp1foImzAhBNvwwrT93cziY8UwKEcgdHGZ5LvI
         nBiVvYm2b/cBmmGUppPZHEvkDrX7H8k5zcKIKJK2FyExN1ZatOMqtuFOMy6L+MmQ3I2k
         EIzXpEMBhOYGtUg+Ib/8zE4MDOjfzQH1IWVxiGY9cA0m31pz27F67u5hOoPN1fiz8emD
         jZYID1FqfgwwddPrStfvDJeItDbvdyNb4IWcaDUHcEPY6uTHcU9k1T1hYakoVYZqadK4
         qme7BPpnrYkJpnpeP4SQLcIxh2ANjrIYr1wE5MQKCdXPNSiiD5dXHpXGSzYNhK9u2nrR
         apqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692241; x=1758297041;
        h=in-reply-to:references:cc:subject:from:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PmHZZLM+jLINLbKueG0GF/VWczCVBfuAc7hrSwl/VJw=;
        b=orRXfbcu9WYkRSEb/NvvHJTntcHfCZjrXIhxfWk/FBdmUEkZmZTPm/Y2JFsDfG5OXw
         HG0agKP0gChsWV59FzqnGYZ3QFTWsoTaHAwoRLZ2FXQxTs7mjMd89UNlEpPhHYXKqjjQ
         uZ/tkDgqfLPcCxk82/ty3tlLHmn8uZDk9IDwekiY96L6Vh0vjC5djCNN5kvPigI9w/e7
         uG6DcEJ81Ha2jXjlqKv4UK5JqAel+DAGfIyDGQOJ2giL0FHb3oo1nuPufDlRSnZrWJ/d
         8T8C1avk5vMB9D4wohhHZYL86R53WwGvyqhcs+LLf0GXUE2YEDLjmewv0yWYvhYmfhpm
         kwyw==
X-Forwarded-Encrypted: i=1; AJvYcCXVEMwVLQG1ZQ9TvMb0kl1gDliwURjQ+cRFgD6vDFQ8+jXIjXEKe1PNDc8uSwQPpqaDPHehlS/s08F8JJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztg6oXn9Txxml+XtDfihDwEZfhpJnQULxTTmHmHgIhZDG1vGkJ
	o+SHPXq68KJaKMJOB2m6jD0SoMPQJh5IDqp1dd5w7ieI2REJfHIL7AHT
X-Gm-Gg: ASbGncuEjbliXBz0nAOvdF5shNLVDY/3eI+Wu0ev8UDwyZ9nqrFDNQxK5K2euO8rLeG
	yhctizHk3nRYKC7mJg98hNVS91J+pazB5UblvSR/zu1eWXfdUKOghX9ixd26bdZ/idRfzK+YWDF
	eWUZPL0N0tArXr0blY03X0F/+aoqlGZ4gUGcHxIMp7VogOEKk5MmdEZoYQEuQghX3qn1IWXPwve
	5uGtmLV18jecrHRoFMYAXVjGbAduYJLZtOY/pC3Tod+mWKNho1aRTKY9e9vlbIiMAZx/S/GKFHD
	G6RtmCpsY4dNgZ53bh3FjBinX9+afU893KZxIrudaNXPS/EXQLtUb8s1LFaksbelUDRDxXHvmjk
	8jIwcb3V3f0/Yx45NDcvuVyFmpELNJHa3PpIBiUSQw3G35tF6Ntpsa9MAg2t0UD0=
X-Google-Smtp-Source: AGHT+IHplBs4rBxiEhWoleYLgDAH+C3KFfIe+pRXRtODawS1+YsgRO5KAu5iqzqSv2dZN+qba3zvNA==
X-Received: by 2002:a05:6a00:4644:b0:772:2f06:3325 with SMTP id d2e1a72fcca58-7761218ddc4mr4436593b3a.17.1757692241092;
        Fri, 12 Sep 2025 08:50:41 -0700 (PDT)
Received: from localhost ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c54a71sm5807277b3a.102.2025.09.12.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Sep 2025 00:50:37 +0900
Message-Id: <DCQXWATX22EF.1AWF6AGWZ639S@gmail.com>
To: "Eric Dumazet" <edumazet@google.com>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
Subject: Re: [PATCH net] net: natsemi: fix `rx_dropped` double accounting on
 `netif_rx()` failure
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250911053310.15966-2-yyyynoom@gmail.com>
 <CANn89iLUTs4oKK30g8AjYhreM2Krwt5sAwzsO=xU--G7myt6WQ@mail.gmail.com>
In-Reply-To: <CANn89iLUTs4oKK30g8AjYhreM2Krwt5sAwzsO=xU--G7myt6WQ@mail.gmail.com>

On Fri Sep 12, 2025 at 11:19 PM KST, Eric Dumazet wrote:
>
> I do not think this Fixes: is correct.
>
> I think core networking got this accounting in netif_rx() in 2010
>
> commit caf586e5f23c (" net: add a core netdev->rx_dropped counter")
>
I hadn't considered that the Fixes: tag can refer to code outside of the
changes being made. Thank you for pointing this out. I also noticed your
earlier work from 2010.

I'll update the Fixes: tag as you suggested.

>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> ---
>>  drivers/net/ethernet/natsemi/ns83820.c | 13 ++++++-------
>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethern=
et/natsemi/ns83820.c
>> index 56d5464222d9..cdbf82affa7b 100644
>> --- a/drivers/net/ethernet/natsemi/ns83820.c
>> +++ b/drivers/net/ethernet/natsemi/ns83820.c
>> @@ -820,7 +820,7 @@ static void rx_irq(struct net_device *ndev)
>>         struct ns83820 *dev =3D PRIV(ndev);
>>         struct rx_info *info =3D &dev->rx_info;
>>         unsigned next_rx;
>> -       int rx_rc, len;
>> +       int len;
>>         u32 cmdsts;
>>         __le32 *desc;
>>         unsigned long flags;
>> @@ -881,8 +881,10 @@ static void rx_irq(struct net_device *ndev)
>>                 if (likely(CMDSTS_OK & cmdsts)) {
>>  #endif
>>                         skb_put(skb, len);
>> -                       if (unlikely(!skb))
>
> I doubt this driver is used.
>
I also honestly doubt that this driver is still in use.

I came across it while analyzing the `netif_rx()` and `rx_dropped` code
paths, and I noticed that there are quite a few unmanaged drivers using
this kind of code. So I started to fix that.

But If patches like this only burden busy maintainers and reviewers,
I'll stop sending them. That said, I do think leaving unmanaged drivers
as they are is also problematic.

As a newcomer sending patches to netdev, I realized that there are quite
a few such drivers. I don't necessarily believe they all must be actively
maintained, but it feels like some action is needed.


> Notice that this test  about skb being NULL or not happens after
> skb_put(skb, len)
> which would have crashed anyway if skb was NULL.
>
I think I wrote the commit message incorrectly.
The main point was not about `skb_put()`, but rather about the `if`
statement that checks `skb`.
That said, after your comment I realized that `skb_put()` itself also
looks problematic.

Thank you for the detailed review!

	Yeounsu Moon


