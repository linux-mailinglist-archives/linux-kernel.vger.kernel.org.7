Return-Path: <linux-kernel+bounces-829564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48107B97599
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A22442FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC23043B7;
	Tue, 23 Sep 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Qb5JmT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18FC213E9F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655845; cv=none; b=tVJ4MpSaihWUFLh3NdEPT9XZT4DNMJTd2AYhlNoyc5ge+bRQ5sWRLrTJrTidMFU+B6hGqIxhwcOExXgBSvCQzdmxqn7AI6A9zemfc9BUWvKMVIOonR5YpACubV+oHd6Tq8tNeV77AzUiKI5V1D+1wqjhxcDzP4zp2ozpPRQW5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655845; c=relaxed/simple;
	bh=UwNgaI77PBjLSUE+r6FEG3m9gYMM55QqcYE/BwPrKY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgrpRHQVaTmSSjQ6wd1sVhi1c0xpzNj13eeTqBPrPpwFR7b/eQyvrTpxSenPmlaGnH1zU378ewc6D5ES5IrRe3jHpirN17s2Qo14yFwDRFAsKBXm4tAe2EOq3X+z649+ZI33mv0UUrF8T78zu4e9P2VFEnM6wvigPSxHhnPP0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8Qb5JmT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so40632855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655842; x=1759260642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3XzVTxMO4iEx25I8nAUCxuLVUDgVKpjcSi8HGEwM1A=;
        b=S8Qb5JmTNvWjbsOSb4GzAmhgHDdETKBTg3543IS3Qia6TNW0CFMuwioXGfbjDhE28K
         RON5bUIKPcJTclpBw58c4LMKlfFRBuKp3GyL/Ba8nx1coiyCh73eB5mWnsgBtAE5lSNq
         jqdmee3zlJOiddzbtHMebCOEWp3t/Ume8JpmwU3xOxaSngua8lW+tzuzA9AkFix29MfT
         B3XJ+YVQ4k7I2S8XwBhzO82jA4f0kS3WQpiCiyLnShmPRT2JkjJXz/8uSwc1t/D+1VHS
         yzv+YTq1J+nl+gV8zD3Z6DLKSx+B2spziF5klIYq0krcZqJzXRaqfDY4B58+FE2trT7i
         7png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655842; x=1759260642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3XzVTxMO4iEx25I8nAUCxuLVUDgVKpjcSi8HGEwM1A=;
        b=i7aLiG+PoTcOvCILWLJEnJI5lvfytG0A3098pN/0n919GbaMfruQSsP0IF4JWI6HFv
         j3vADNadCaFx4lq27PzcgKYPkWnnzeMFzBLHSkR4cu4vSu7XReOTfT+Q1mRC2gPP17qg
         XnQV05TFSALNnpb8HA+4OYJA0KF0L6Z09hJjHXBieuBs8QUvTQmOFF1Q3Oll+w2k4l8q
         ofG5t9M5L4F/YKmTdORbVl8Kg9M8oZ3Va74jXigTELfLsRGwQmNf+5ccECoMmBUv4HXA
         /Jqh0GBz16cuRkbw0BFuH1iqOJV6H6cxufcENNjlR4msRFtVQ+VhWFjg+NYjnyCDUf+l
         QWzw==
X-Forwarded-Encrypted: i=1; AJvYcCXzGFJKu6bYxVaL8HRNZNpWlzuYz+aKr0lCTd8aiVI3Mek8ah+8gI/Kvvuavr3AXrdz9nWwUvRwIGFORIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieLkh6tmr4igEDFnKShpcHUTQaMl0hamG6khEAk8QDsqyWzRe
	49ZaTrUKZClbxc6NLnyHKMmlEI2mR7A6FFkjLdeQ2wRuLqjeXllKnbnm
X-Gm-Gg: ASbGncudTFkWyHiXFW5yL+9yh18SKp6OjXGzjS9mC2qHsyR7cqG2X//BcqrJUedJ5ju
	kI+lo5WCvgpS+Mm2Vkk2kCK95p1tJ+ekkjIDOKEa0f7L/YMWJ3k5S5c3G/96MaWcoilypv/oxv+
	HVaChzSruo6v8evcSKfju5ufhPh6kuINWt9TfuKiOOl88wBHx1sp9BQxFOWAT4VH8h5D7JsIUtW
	R4vOwgze72647x8pFe4tOMpvB34cspMA6dyehpxXp+Er+4Se9AW48svkZW8DPuxd8JwS9UmLgPE
	ectVlMlnxG5IFvH1AJAHtPz5ps0vN8j2xJAyU47btjF75Y0MdDGpxmLgkSlutmj5XBhlV6ufXiL
	WO01Ft7bpuv+YAl1YOIo=
X-Google-Smtp-Source: AGHT+IEfC1NNEAG6LGNFDwZmSsO6QvXxb0bSOmjC5mNFchosn0D8MEMu1s0ZAr8KAAjzIJEQm5U3VA==
X-Received: by 2002:a05:600c:1c05:b0:45b:7ce0:fb98 with SMTP id 5b1f17b1804b1-46e1d97493fmr45353685e9.5.1758655841922;
        Tue, 23 Sep 2025 12:30:41 -0700 (PDT)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f127660840sm19066278f8f.11.2025.09.23.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:30:40 -0700 (PDT)
Date: Tue, 23 Sep 2025 20:30:39 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/6] netconsole: resume previously
 deactivated target
Message-ID: <4evp3lo4rg7lh2qs6gunocnk5xlx6iayruhb6eoolmah6qu3fp@bwwr3sf5tnno>
References: <20250921-netcons-retrigger-v2-0-a0e84006237f@gmail.com>
 <20250921-netcons-retrigger-v2-5-a0e84006237f@gmail.com>
 <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t32t7uopvipphrbo7zsnkbayhpj5vgogfcagkt5sumknchmsia@n6znkrsulm4p>

Hi Breno,

On Tue, Sep 23, 2025 at 05:22:25AM -0700, Breno Leitao wrote:
> For targets that are set by the mac address, they don't necessarily get
> np.dev_name populated, do they?
> 
> I am double checking netpoll_setup(), and if
> is_valid_ether_addr(np->dev_mac), I don't see np.dev_name being
> populated.

I was not expecting it to be the case either, bu my understanding is that 
np.dev_name does get populated by __netpoll_setup, which is called unconditionally 
at the end of netpoll_setup. __netpoll_setup eventually does:

np->dev = ndev;
strscpy(np->dev_name, ndev->name, IFNAMSIZ);

I've confirmed that for targets bound by mac, np->dev_name is empty before these
lines but then it is correctly populated here. For targets create by name,
np->dev_name is already correctly set prior to this. 
Please, let me know if I'm missing something.

> Should we also compare that the mac doesn't match before returning?

Even though the above seem to work on my tests, I was not 100% sure we wanted
to also check the dev_name when we initially bound by mac.
I've also considered the approach below, which I think achieves what you are
suggesting:

if (!is_broadcast_ether_addr(nt->np.dev_mac)) {
	if(memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN))
		return;
} else if (strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ)) {
        return;
}

Let me know if you prefer this approach, it would allow resuming targets in case
even if their dev_name changes.

> --breno

