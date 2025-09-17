Return-Path: <linux-kernel+bounces-820436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DEFB7DE67
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1031C32519C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4563568FB;
	Wed, 17 Sep 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KHB1jjpf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8282350829
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103854; cv=none; b=hYywoNL2cQ6174ypk46PMvcTKBxFpQBk8SsRhJw1p0GR9UOckjC2Vp55APpuqvRMwiQznw8D8FpJjE82/x9TpdhvF4vpeKjUU0SpJVrMSO4/vMBLlAuSTfSqSwSDX/dfgkqdogU7WjKCCsI8pgde6iw8zoqLxwb0HlEnKMg61DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103854; c=relaxed/simple;
	bh=ZZVPr8zwc3jcO0OuCGyJfEYik/KPMCAqckFIByRhOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls4BEwpmWZvqzJg1rLvDu13IFlq7t63d3caEX+WDO7JlpJCWnqL3wFQWQBXGYsH2PZC5adE98Akvs3ReHl6FYEwNRrjjQY6Sjh3nargNFEKOkSxzLeNp6U7CAVuLFKeX1AlH0Ppl60uy+XNYXub0254vfDqrJIH8kAcN2sE33WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KHB1jjpf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b00a9989633so165633866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758103851; x=1758708651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=KHB1jjpfoHVd6r03+VcgMSFtXfUZgEHfz0eUDpbzphy68Y3r7KiXTDRDkFPpkITFI3
         vexwxHWxEfVYpM7Bf/qbom/G24tUPWn2sBnMS9khGZSEwXGJH5STWoxV+D+fI4DGwlMH
         BSB5bMOu2PbJZC/Qi/bxW5/5soNJ6LCZpM0hUDNIOr4aeUTNtzlULmByXbRuaTT5i5Fv
         6e5Llh+0YA10niOaEnxSyKemShp3pNwdSBb/a3JqnSo98lCTb3HNZknZNs4VNvCtv6z+
         IG3DJOFo15kDQhHr99WLypKrmBHbeumma4VeKD10WffndCe7b64fWp3JrT9cN0FmE/WS
         ibhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103851; x=1758708651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=Yk8XwaVsS3TtL8vqrNnbEex8yuG3mkMzc2QI+6KJ8BlvdsxHD2et927XDAsubzfEmC
         Lrcmj5Mim3PDteIMFH6BCM043+TP2H39d2i2tC4pTLfT0j2gUaL285WGH0lnKHuzqwSb
         VnmiWFE62d2/fp3aXN2RoNjIasWsa2vKx7sBHR11IybVSDAXEG6U4ewJDcLVM6fGcIfJ
         oRF55brVb1kf4L4d1ivs/7F1Ix4N26QA7YVggm56pn4U2MUEdAWMhJ2vp7KzLkfgjr5F
         MYsEnsy0d9xjdaePrVX+Hp6LzFpkEY8SbpnE1m3DL1u+oVOOehk2p+cLZdJxnU6M0o15
         uaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgCAC+d/PXJ8O8YY+jeAoVHm/iVxTFoXyAuJG+d4nmLIaGn+IJ3Km9Au2I6ykQqo8YfhmgUxvzvzKBWi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YydRK9FOVAoZcOyWTiJldXYVRgxoqH+H99By/BRRzTrkZWQN+BJ
	zpFZIzK/nabXmR754I0V0vSU3cBrjLYShBaRZYmKQraaazwikqeIsmz8lJ1hNihRFcU=
X-Gm-Gg: ASbGncuCnq/5PIGo9Cb6z3SjMUxe5+fX+UUqiBZWID/1/TmqUioHco9IGkwAQpEVGUV
	9X7KefaK/pO3GOQvwKOy1yDUWoK6UX7Wv6dPPrgXZgni4dyBImLNimsX1UflywzlFywrU8YT/2O
	0FD6Tm/YGdoRvEh2Tx4GfF1fnszofvRw6Msh10Wi5FXy82kpDAF4QzZ2Cr9etZ/dI7vfGwsRilW
	nAK+SJP13HAurz8sTn6qonhrb3VzQCtxg/gEfGinM0Ot0+M2e0lGDY1EpMILU+nIYX+bhZEp60+
	No8wi3VH3M7aSA381enTNgWJUqQCVRwuRpjiEJBWoerYUoPyQbH+yExcjeMLAROtx7qR6qBWa+l
	WfOyrIIRVmTQazhF0HhIj6F5UpGXs505SRktik9NgX1zx7LHTtuaNya3Qpomi9sXT
X-Google-Smtp-Source: AGHT+IEffrTIn04hCkbbCjr83BNBKSLUY7sk2TJEFlqvq5wVXFDKpBzk6i+bXHi14sqiagolHGQ+ug==
X-Received: by 2002:a17:906:c106:b0:b07:c66d:798b with SMTP id a640c23a62f3a-b1be49e1b5dmr185057166b.11.1758103850321;
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d2870da1sm1004985666b.13.2025.09.17.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Message-ID: <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
Date: Wed, 17 Sep 2025 12:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17.09.25 11:54, Oleksij Rempel wrote:

> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.

This reasoning depends on netif_running() returning false during system resume.
Is that guaranteed?

	Regards
		Oliver


