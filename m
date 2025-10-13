Return-Path: <linux-kernel+bounces-851149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BCBD5A87
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DDF14E058E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E02D12EB;
	Mon, 13 Oct 2025 18:11:07 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594B1EDA2B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379066; cv=none; b=tFhRT+MXI7WClEvttD9S+AxLyctRa7/GVrqnUPDxwdILxf9SGaztCD+bnTvGm3izMqsugRQT7qDXY+TesAtcFj0KO5h+2xFAgPoOEhcjEXd9o3fZmN12FUWFQFCrWlst5+T8TzZeURmnPSkYRT7mTFG7XmebcL3hZol+CPB+w+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379066; c=relaxed/simple;
	bh=0Bzuud3fbzTgE93y68oTL55XoEOeH0xhkZtO0YadA28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUk53SaDh5tXmjOlCSIMMhzyxv4iArPY8yonDjcWdcVzf65BE3nxGqgrkT5U+FsL43u19kqesn1RT6fnwl/17OtBm67JCQfw6nMDUho+nqO93H8WVeUjUB4fT7TeJq7Watl4Iee+NCAlVOIAXKn8KXCctryDQJxu+iKFCUbXno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso6621646a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760379064; x=1760983864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NktohjsRp1hmfKBBZVJM9FY0NL3mIXRdvn/tPXzoAnk=;
        b=G4Y5MJ12JXTdetLpYhrqTfsU3AkqkAmzo0EqctIonlIwAM6ibcLnImsU0RnIgxlfQ8
         JYvg6ONXnfHBzPQZ/1g/a0fahRNh8qZAUF9QIAbMMRS5Jc7zMEaqn8XZFHPHzi33OjwD
         K7k2BQOpGK8hYsRrwELtLnnmsvS8vs/T3rG4QSQPiFPTEU2NAvOdBPzd7Th0MhflBKJP
         NX623SE7Py3r0Li7fQrS9UAJ7QbpHSdXyOSMytK3ugCDo+MYc/VCzlmY3ryCcvea3csK
         K1/W2C8BhHFmEpKOeDED5s4qGmbtb7Yuig9YiwsGk9IaGYJnC/O8lELpMi4AdUng5o+J
         e/JA==
X-Forwarded-Encrypted: i=1; AJvYcCVPvZtuxFSvmK82o4DWRUAsE1pqP33pnbSn8Outrq2T61b70W18goAyiPeXVdeKAaiEQyb+4lAEcSknb4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuLeQiartP36WH0pj2DXLH/V7P7y3WeA9QOzv1T/UDEQodaz7d
	Djf/VtgQk70KFBeL5ZV091XFkP+0rAk4F+nV8mSY6jSbwxqjKcA+QLSd
X-Gm-Gg: ASbGncvtPf9QovOvJmzrfSJhAxgGvL9mGTB1K0yDFrnso+fA2Y/2+ZV/375zSnyUX7S
	Ix10wI9pOnk9BVCmJxPqMeVddhpk0uTZXM03k4BkjhqvXRVfHfW5mhMqGE9VVdiM61IobSTOwSQ
	Naw7ZGq7SzTOAB/VLxrBq65fUXE6vvbclyBgNkz2/OwiUhlquwd/7EVrMYvqIJoybwpSc3Vsfez
	hAWi207fGvsZiZ4lWC/lIe+0dH11m9iWxXG2oj28SQzaDmNpmrHGWMlh4rNddv0tNHHbMAkFJ+L
	1DqzQGYXyLjU1XcGYJiPm0krmfnb2UysyaJpxWKv1895XbMWGw2m3SOBbGrkFo9eh+vhbC7uF/V
	ju7rOnOH3/ZhQ/Aa2Bm8CmeIYO5Dk0m5NP2Mw6073Vhh0qQ==
X-Google-Smtp-Source: AGHT+IHbes+6c9B6vBDGbbc0VnnI9qPJtLLBClW/BkZx58Er6Zqt3ZVOHaRjm9I+D9i4QTYnlUSGfA==
X-Received: by 2002:a17:907:7f8f:b0:b4e:a47f:7157 with SMTP id a640c23a62f3a-b50aa9a1d23mr2461363366b.19.1760379063674;
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12c48sm980952466b.50.2025.10.13.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:11:03 -0700 (PDT)
Date: Mon, 13 Oct 2025 11:11:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	david decotigny <decot@googlers.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v7 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <3aozzslkx7jpiabyvey3562i57ogqkw2wb4xfp7uazidj572p6@jg6lw5dzxxto>
References: <20251003-netconsole_torture-v7-0-aa92fcce62a9@debian.org>
 <20251003-netconsole_torture-v7-4-aa92fcce62a9@debian.org>
 <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6764450-b0f8-4f50-b761-6321dfe2ad71@redhat.com>

On Tue, Oct 07, 2025 at 11:47:22AM +0200, Paolo Abeni wrote:
> On 10/3/25 1:57 PM, Breno Leitao wrote:
> > +# Clean up netdevsim ifaces created for bonding test
> > +function cleanup_bond_nsim() {
> > +	echo "$NSIM_BOND_TX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_TX_2" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_1" > "$NSIM_DEV_SYS_DEL"
> > +	echo "$NSIM_BOND_RX_2" > "$NSIM_DEV_SYS_DEL"
> > +	cleanup_all_ns
> 
> If all devices are created in child netns, you will not need explicit
> per device cleanup.

Humm, that is what I was expecting as well, but, when I tried it, I found that
the interfaces got re-pareted by the main network namespace when the namespace
is deleted.


For instance, in the following example, eth1 belongs to namespace `ns1`, and
when I delete it, it then moves to the main network namespace:

	# ip link

	# ip -n ns1 link
	3: eth1: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

	# ip netns delete ns1

	# ip link
	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
	link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
	3: eth1: <BROADCAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
	link/ether d2:3d:b3:3b:59:37 brd ff:ff:ff:ff:ff:ff
	altname eni1np1

