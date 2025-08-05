Return-Path: <linux-kernel+bounces-756730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC27FB1B867
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50073B00BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EFD292B2B;
	Tue,  5 Aug 2025 16:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RVeCzVoI"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB227A44D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410991; cv=none; b=gvXNMucP212a0KGkykouoz/DNursjyHTK/kXuDUmNsCJwwMy8N6b5VHJA924On5ZTgIonwdAbMdSls5TWryp8AlzxcmqrCfmEatrkdcCgRIcQNgNgjN77RIY8fFfUm+ZKXOhwvHvFQDiWGTp5zWEAxNEDXkpxoiGPdyAQYhUX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410991; c=relaxed/simple;
	bh=ZYOKsmbUJbiBWaVYtF5AN2TeCHP9emZwxMBsR8kvmcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoDsemogZVpIXxtKLxS5jARLSLAw8lytM/o2tdLkxm50IaqeSBqIlM/yLn5G3r677kcDjmFo+XwhcFal1D12bL/drJ5cJybWZhYBhcpSiC8GlOpYIc/4gcZkwYHJ6p98IuzeFynri2gWGmUYtIcgZZAZLCUmyxnWQvjMAny6KBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RVeCzVoI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-615a115f0c0so9858796a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754410988; x=1755015788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTDQePGQpdRLJNbAu36X9SMzRWp9+4YjhDCOEhv/2CE=;
        b=RVeCzVoIJ2Pe/xxgK4EeAqNxZhQfahGLaYYOy3XK5diqmS0255AjHuHW59rTAdqFNQ
         zMYRX3YpBZeoExva5PYVtkLQ7Np8YgzuETTeDOKj3gjTR/D70O9NE/GWWa7FaelanzlB
         KGXkve996ANlWb/PJK5528CVijADVGs3V65rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410988; x=1755015788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTDQePGQpdRLJNbAu36X9SMzRWp9+4YjhDCOEhv/2CE=;
        b=oIHHFVrNSkX3UiynVq5cZMY3S2qw7/pxnd54nxLMpryIT7rSIs7CXL/LNrs+a6Flb7
         j87I4pPVMb3wwYf8LckbfmUxyPZBf+8pvBwa4UM6ffGP5av8ipfD0JcsgSofhuu/zAJx
         3c6cJ+KZ1KlbCu33TFQnh4YldGA7PcyOFZOO258Wa7JvhaDaapGByWeZ8vESa1HwwW39
         wv8DLYI7lyQWAO6V+hWNlVAUaz1Rp0OXFc8TXexw6KCMajIpBp4qLfuRfU2rKnUe/9dm
         CUGQMmrvNh5JSmDBR8moKyx6/Sjd/rfHvd4FzWBD21ulq9dROl7N2CwIQ2sjEALMq/gf
         5+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmv9SSIYgzzUn3oyEVzC2jPr2S5ZdBENGOLnxJHdJMPyvHVZJw6Ims2PdKnd2GIEoENt2/Mw+y2tjbeFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgut0/D19ztXy+YQeO/recgNe/hoI4z4loPuYs9pNU25FkWnGh
	UWLeNmLQxotjTmwdc5S+Tw6JO7Wz9JyF4c/tKS4UhooHfJkJR9iowqJ7UabKZ0wJznO+mKEbvnf
	ogrcJBdeq4w==
X-Gm-Gg: ASbGnctfbfERtkX1AE7kc5XRjmFqLpl+jtqH0XhFvkfW1srSFd1yn070bNCNszNtV5P
	5GGj6UXfBxOHC8ub/HCgsybMk2+od3ryCR1HsX5B1tjd9JuvvWb5tWhCDQtR52LOOE2ntJWUu1h
	1JeQbGaQcbNYK+hXGW+32NzlSTm5dsoZP12F2GHs3NaofWEHWEIiXSh7ErbbKkoXPgWIbwpAi03
	SInVe/0DOf6IaW5YBwxMinwCBfaAfnLUrKwJhiewl84KJVf8roBweVTML2FO2AazgHzBZoPs2Uu
	PsjTtl7A2IOWk7UxpTbqLbfujVy7zPXMkSxvdgfj9iCc8dtlDQ/q3a4WXjOWiG0TqxFbwDPFNrn
	fKwuzi8S9os+uQ5a6iynmphojK3S/jQBCMY5C3mFyNrw/WIodgbejZXkT1Yl1+ZoNZCNzhiA5
X-Google-Smtp-Source: AGHT+IFCVVmzpMcXWrZtLlLzdQQEzvbpuUJx3TrDdTCeRW5nOBAQa6i7QeHdLxqtXz4p0ugbRomjZQ==
X-Received: by 2002:a17:907:868d:b0:ae3:7255:ba53 with SMTP id a640c23a62f3a-af9402098cemr1586371066b.53.1754410987568;
        Tue, 05 Aug 2025 09:23:07 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a24062esm935527466b.126.2025.08.05.09.23.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 09:23:06 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10334219a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuXeqdRV3hCeV0jxf/3lL/R0geTCYxzwCVF9QGk7SBrpArFOi0pB6y7RgOIU5JFngwoS1N+4cg+LR4+ec=@vger.kernel.org
X-Received: by 2002:a05:6402:254e:b0:615:aec5:b5bc with SMTP id
 4fb4d7f45d1cf-615e6cd3968mr11900877a12.0.1754410986307; Tue, 05 Aug 2025
 09:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250727013451.2436467-1-kuba@kernel.org>
In-Reply-To: <20250727013451.2436467-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 19:22:48 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
X-Gm-Features: Ac12FXz_1jhs0pDqBU4Pe5bw2lhDIpnR4A0FLpEopYft4GtNE65Xjr2aEymiyfA
Message-ID: <CAHk-=wjKh8X4PT_mU1kD4GQrbjivMfPn-_hXa6han_BTDcXddw@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.17
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 04:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Networking changes for 6.17.

So I found out the hard way while traveling that this networking pull
seems to have broken USB tethering for me. Which I only use when
traveling, but then I do often end up relying on my phone as the
source of internet (the phone being on the single-device flight wifi,
and tethering to the laptop which is why hotspot doesn't necessarily
work).

It *might* be something else, and I'm bisecting it right now, but the
networking pull is the obvious first suspect, and my first three
bisection steps have taken me into that pull.

It could still jump out of that pull - there are non-networking
changes still in the pile left to be bisected, but I'd be honestly
surprised if it does.

This is very standard usbnet with cdc_ether/ncm/wdm/mbim.

A failing kernel will find the device and talk about it, but then it
never gets configured and you never get any actual networking.

Any obvious suspects I should look for?

           Linus

