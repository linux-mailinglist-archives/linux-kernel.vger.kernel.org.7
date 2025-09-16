Return-Path: <linux-kernel+bounces-818727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A3B595BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A7E1BC72B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB8311C2D;
	Tue, 16 Sep 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="w1AydtUN"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87230DECC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758024295; cv=none; b=RqPI2gZIos3CMTzd88z3rSOFt5Drqxx9LSDFpJ9Oo66EcqqAgRI56pkRdAX8NKKTSzp2a+fZHxz3HaAr/kRGhGrsQZXYlFBUCUe83TECwxOBKM4oz71YmK/jL1I5v09wtwLjRkqwzAwtLuyK7dXwFk/5olfmatpnmCT3j9KOXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758024295; c=relaxed/simple;
	bh=u4CfRJpIWWLJaKotLpqpvXU4ru0ppt8Mlv2oE2Y8GFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv1fzKM1kAeO2gA3eBqen4eMgnSJM6XAA0LadoL1HdvZ/yoYaRJx7LA+DIzMh1B/tX9enQiih/zbr3TAJFaaK7/+IHWonRVKriPb8jvvbwM53x9XxWkG2lQAimN8b1EMcjZOQws2kCqCbkcq/vPlZbya0Br54gf8q/LJlTOIK5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=w1AydtUN; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso33502805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1758024291; x=1758629091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IFlVJcArwRuB5pQMhIHpC2dkGPMYzDZIC1g0hf8SJZw=;
        b=w1AydtUNiyUjwPMvF1lH5FXjXpB941D1LiWpqxBlc0LcN1HzWVtmIVTq2QDqW29pji
         3lPjdIz/l1dRdOOSBFWBFizIDUp0XtOO2pV2mHXGaozyw1wPilvJtP1TToJT7GBgqvqM
         Ba6R1Czw/TY4o2e5e/W2NYIzqAoHinjBUFJoGpAoaA0xGfbyFFhAhHjdJiES0C8L+Oue
         hwJIN7ts7BqyS3BdIwJK5ttfiGNIMpgKPrqpu7JlNUfGwA72n9tYzDaFHjYfeCOfl7vl
         XWZ31M+ihz44VqQOhP1G3vNqU1DhpxxADkKGOxRFJs8sEaXflhbkZ5AhRWwY+u/+gyZx
         Fnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758024291; x=1758629091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFlVJcArwRuB5pQMhIHpC2dkGPMYzDZIC1g0hf8SJZw=;
        b=Ymh1+uIlFU0sCSMgh+c1D7QOGpUCPkp1Kte5jvW5H+5W/acffbmjLyQuC3n8/LvJF7
         DwSEOj5X3G8XVmwyZKXHKtZissxZZEY/FFt11yyANC8u+fNrJiY2LxabSTu2N08HqOTd
         /K4R2YhcdMx6/vyO5JBiI3znHKYztQ03IAFB01jKm/pAYTIp7iqzsqNLpJafFunhakXr
         ZpiEVBPrRl5Dvl3Zg6rC9BIWkgSZx5mVAZV0nMhna9h1O9P1c/l6c7EYBL9J6yHb89y1
         /m7Uw0ZhXzZLVGnoCHPrEl/yQyP6rywziAEBxfoOH1oDqj5Ja/OFJWBvBJ6qjtxkTSdz
         hypg==
X-Forwarded-Encrypted: i=1; AJvYcCX2qPu+vu1Rk05dDKUk2fkZuFIq4YAxL+LjFPsaxgFCp1tpiuV35fDE8h5pV3XmP6r17E0+0M5i8fS0Yi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3VI20UQy21YgVGJsSRMKEDhv2zLWotZmH2PjOm1yQxeZ34gGD
	A1w8TDNzddejY+Y7m9zSIbsrLhVV9qZT7rX6KZB8pWge+6D6/SesFECM/cgWiDE7nPs=
X-Gm-Gg: ASbGncvat8tE8Ax1rA6huzgU8zhww1GzyAs0YvfB2vQjr+EvT9yrSQ0rNWiJzIfcWfT
	9a+7NSyyuYzbHLqD7IlLfbp09IflOMCuCv+ACsk5fUzjShdSuyGQqt8e+ZXXAXGJEIidYP+8/hm
	G1UH2QSpW0hKigf1wusBNn0HJ3wgLuteWBIhPTvqLWBA7Ew7bQTftDXm8qsEMJEDIcBA9fuf9eP
	YqSsfe+sUQk637Rw4mKvlW5rAM2Sm8nEItLp80Nd9G5wU/GXGt4ILVZHR7SIiSfAbgh8jK4y27l
	BNWffol7bu5RyHrWNnbpQxq+kB+xy2qiwfCzG0dQGHYdXF7hMbMpFuQ2Tm30Qxs1xcyMD46/o+f
	Z1x/BJtWbrYGTySiwkrW6bK7OEMHM1buqiXE=
X-Google-Smtp-Source: AGHT+IHXZCY8k+7hYQ8XiEwjomG782rdKfYg9mbN/tQoUYffmZEo0KfqDGcVU/8jZ68nDml+ck/41g==
X-Received: by 2002:a05:600c:1994:b0:45f:2cf9:c236 with SMTP id 5b1f17b1804b1-45f2cf9c56fmr68757235e9.4.1758024291301;
        Tue, 16 Sep 2025 05:04:51 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ec486e6193sm3410937f8f.25.2025.09.16.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:04:50 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:04:40 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Mina Almasry <almasrymina@google.com>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "asml.silence@gmail.com" <asml.silence@gmail.com>, 
	"leitao@debian.org" <leitao@debian.org>, "kuniyu@google.com" <kuniyu@google.com>, 
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "Vecera, Ivan" <ivecera@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <42xbm6obaa22qoictrgaeqza76iucvasquthb3igqhozrlxmbl@dtspujve2njn>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
 <CAHS8izPU7beTCQ+nKAU=P=i1nF--DcYMcH0wM1OygpvAYi5MiA@mail.gmail.com>
 <SJ2PR11MB8452C5DFFFDDF084EE1C066B9B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ2PR11MB8452C5DFFFDDF084EE1C066B9B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>

Fri, Aug 29, 2025 at 09:05:02AM +0200, arkadiusz.kubalewski@intel.com wrote:
>>From: Mina Almasry <almasrymina@google.com>
>>Sent: Thursday, August 28, 2025 6:58 PM
>>
>>On Thu, Aug 28, 2025 at 9:50 AM Arkadiusz Kubalewski
>><arkadiusz.kubalewski@intel.com> wrote:
>>> ---
>>>  Documentation/netlink/specs/netdev.yaml     |  61 +++++
>>>  drivers/net/ethernet/intel/ice/Makefile     |   1 +
>>>  drivers/net/ethernet/intel/ice/ice.h        |   5 +
>>>  drivers/net/ethernet/intel/ice/ice_lib.c    |   6 +
>>>  drivers/net/ethernet/intel/ice/ice_main.c   |   6 +
>>>  drivers/net/ethernet/intel/ice/ice_tx_clk.c | 100 +++++++
>>> drivers/net/ethernet/intel/ice/ice_tx_clk.h |  17 ++
>>>  include/linux/netdev_tx_clk.h               |  92 +++++++
>>>  include/linux/netdevice.h                   |   4 +
>>>  include/uapi/linux/netdev.h                 |  18 ++
>>>  net/Kconfig                                 |  21 ++
>>>  net/core/Makefile                           |   1 +
>>>  net/core/netdev-genl-gen.c                  |  37 +++
>>>  net/core/netdev-genl-gen.h                  |   4 +
>>>  net/core/netdev-genl.c                      | 287 ++++++++++++++++++++
>>>  net/core/tx_clk.c                           | 218 +++++++++++++++
>>>  net/core/tx_clk.h                           |  36 +++
>>>  tools/include/uapi/linux/netdev.h           |  18 ++
>>>  18 files changed, 932 insertions(+)
>>
>>Consider breaking up a change of this size in a patch series to make it a
>>bit easier for reviewers, if it makes sense to you.
>>
>>--
>>Thanks,
>>Mina
>
>Yes, will surely do for non-RFC submission.

Please, do it always. You request for comment of something you make hard
to read. Does not make sense to me :/


>
>Thank you!
>Arkadiusz

