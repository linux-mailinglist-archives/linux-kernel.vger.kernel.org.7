Return-Path: <linux-kernel+bounces-848508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E441CBCDEC0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C1540675
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8D2FBDFE;
	Fri, 10 Oct 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXnSbxtH"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB045266595
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112567; cv=none; b=h/AXmAbBemzBcUeOTaomIkyKb1D6oxnVzs/XFQkxmUk6U/2UWK4GamOWGOUae1D6azGthtD3+fiM7x8c2KPeEG0OvqYiEPt3Vyn89/a3RjGVMqXXPpLZyPOSzXFnf+3de9Pu/ovIt0b3b4jL/tEYbf5axHWB6AZ8H76AEs7L/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112567; c=relaxed/simple;
	bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=LqBpA8BQ82DZEUtGsNewRumxfkP4h0bmY+w47t3oMV41oWzBTDB0yCsNAQSS8h7MJtlJf9cpKojhxhArcPQN6+jr0RwT2Fe+86a/NtoigDdK/H+zwpT06AOZBDY6BI4FFVE2jzPs4PFVncipboaOXBLr+pQi+IPCeOPxweo5DtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXnSbxtH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330469eb750so2859534a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760112565; x=1760717365; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
        b=ZXnSbxtHX3vbly1eok8TXzd91rr9rrRDQsD+QL/kiAilppk/eDxNYmCSLD3HmxvtVa
         VBSw3eMwn3+uo4OtyJehuir8S1+wf+qJtw+S0MQ9K4+ORMWMemQPJQU9mejHHmJF1enQ
         gPpFFj1kTVSrnhff+R4p4Xs116zsC6oKyzfJUhgMrBH6tem0G2kVlVHuv/rHb7aHxbC6
         /W6q36WTO7mIoboXq7qYKowwh2qBloWawU4DLFSpfp6FRugQPrJCWN3lILTezC+B4+jA
         by6MKNlakMZ39rvioOALkYosKR3n+HCR6F5FdupNCIA70gfkRBPh+I4MbREQE+ra6p9f
         dUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760112565; x=1760717365;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dUAeS7yBEEUpdZCGYWU4GjkvgMKwT400c1scQYXOmu4=;
        b=G9pwhD4spT95WBPUFSsq3i3DSLac6Np4E9gqq4KfubrEs+UqKZmwTJS9TX7OS9tl+D
         hNn6vuM1Ku5t0TTwdF5ro0JF48rIgIj24TBXgPgBjCJRqqLzDSWwWMFJ/eh0PGFLyV5M
         Qg0pgVS31pT+UgSV+1XinBH6lRHGiPe+yB0Ob7wJ6k7GnWYrl0ycfHf7puCeEv1w6JaT
         8KsJfJt+DT30/lXkLivjph8WVEWiIETI1FTa0T81/JooZQzoAsQ7vtd+0b4xWiqVT7d+
         R47ZZbmo5+qg22oduTwy20QN/mHcKSl2qSPTh4v++cB7mcwsoeob4YQUjfEfrWfu/P9g
         6RJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9vgHAsB2/E8N2/Mq9lZY7RvsbX2hn60Z9z+kCpGle/tMq76LIWTRT/Slibzd114xTIGYIqfCH+8w96Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpqRe0RYidNNMhCvcHAHgmwQRhRP6zFZC5oM3qpmLHkqwdUAD+
	HXqCAbfOY+LOJ/ArFKOpLxlha8nWKoaLEqpijCTkaEKeB8SUZa5vU0FLZlXpp0XWAPs=
X-Gm-Gg: ASbGncvJ4i7s/LKZhrTPUyeLqrXEkiIEWuMV1gTcsaV2n0+bRcrNdmodVYA/sr2fX8g
	HAGpDjx5HhVm+GeSAy7QguESKCdew2Ft9hGAF0uvDmTCTnfL/r2g/WRIi1xJhDxG9uZFzvhVP3B
	mnDVRDovV1Ml3yrNd92WtJqJeToQcx2kNjxqBI6otCCG59Xezd2bpvJjg0nONvDjHGqsZeIfgpR
	W6WZhB6Znbn1iFoxcNe8jCEkJkSruxYxyc/1qAFE2MpcWVSFmg7Mr2IsAGbCSHWAIH0UGCoALhX
	0y+t8nu9/y+8WCsKY7TiYqEzibRaHUHS8+KJ16xaFeFPthsYtmr2JRzQb2LNxXjrZr8p4xlvtQB
	zH8V/x/ZrFddcz60AzQWVmNyXya4QeoUHS9pIb5mZckQGYTJx
X-Google-Smtp-Source: AGHT+IH+Bl3n6xNhazOXQB/JNZbXQU7MgQx2mZf+w+x6ONuirr3C9IMHxepRFQ/oxDWw/d8XL0TVFw==
X-Received: by 2002:a17:903:1984:b0:26a:8171:dafa with SMTP id d9443c01a7336-2902723fc6bmr169811785ad.21.1760112565141;
        Fri, 10 Oct 2025 09:09:25 -0700 (PDT)
Received: from localhost ([175.204.162.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm61079905ad.48.2025.10.10.09.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Oct 2025 01:09:21 +0900
Message-Id: <DDERTVVZ8Z1Q.QZXNA7INPVQ4@gmail.com>
Subject: Re: [PATCH net v2] net: dlink: handle dma_map_single() failure
 properly
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Simon Horman" <horms@kernel.org>
From: "Yeounsu Moon" <yyyynoom@gmail.com>
X-Mailer: aerc 0.20.1
References: <20251009155715.1576-2-yyyynoom@gmail.com>
 <20251010065515.GA3115768@horms.kernel.org>
In-Reply-To: <20251010065515.GA3115768@horms.kernel.org>

On Fri Oct 10, 2025 at 3:55 PM KST, Simon Horman wrote:
> On Fri, Oct 10, 2025 at 12:57:16AM +0900, Yeounsu Moon wrote:
>> There is no error handling for `dma_map_single()` failures.
>>=20
>> Add error handling by checking `dma_mapping_error()` and freeing
>> the `skb` using `dev_kfree_skb()` (process context) when it fails.
>>=20
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
>> Tested-on: D-Link DGE-550T Rev-A3
>> Suggested-by: Simon Horman <horms@kernel.org>
>
> FWIIW, I don't think my Suggested-by tag is strictly necessary here. I di=
d
> suggest an implementation approach. And I'm very happy that you took my
> idea on board. But I'd view as more of a tweak in this case. Because the
> overall meaning of the patch remains the same as your original version.
>
Thank you for letting me know,
>> ---
>> Changelog:
>> v2:
>> - fix one thing properly
>> - use goto statement, per Simon's suggestion
>> v1: https://lore.kernel.org/netdev/20251002152638.1165-1-yyyynoom@gmail.=
com/
>
> Thanks for the update, this version looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
And I really appreciate your review.

