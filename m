Return-Path: <linux-kernel+bounces-755512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABCB1A739
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 673D94E11CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098BB28540E;
	Mon,  4 Aug 2025 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/jGJpaz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CF13C8FF;
	Mon,  4 Aug 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325818; cv=none; b=ud+Mh2MvJPGQ+8HnPRlpZNlDzKmgNQ1x+VeGFyKd5Gd2TYGe8TGMqagG9pxRVOiyl0nx245PbO2QESpE7jgJ2dbsc4gqSLUuFg+wa5v6Wh+hAUc+9/rRZ/Ts+j6cX4FlVJWUVy5Jm8iPPQFmpW0K55xStym5eocdu61GzOMq0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325818; c=relaxed/simple;
	bh=4ITM6xA+67Hl43Y85iCW60aPkjChOVjcGjhwytoyKDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHHWreOwfSViL7LGGHdscbhhsDt4FO3lyNaOQ6jnRBzdZtrJ8uWE9QOnFLayUNU1mc4bxPkIf+VFiF+5hz64a4k1f9ugKsemmuqrUvxeDVHbmwWw2Ya4YWKEEjWYcko29EDpjYYqf5VseQikstmNaJJXt3+ElmzG0dBqDboSmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/jGJpaz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bd7676e60so2488794b3a.0;
        Mon, 04 Aug 2025 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754325814; x=1754930614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9dB+qdwret/lv1adiHadYT9NK1p7670u8AwYnDe0r0=;
        b=f/jGJpaz11vsilONbhIO7vPau9s8/06EnaEmdwn5ACjg6SS1NZplmMzKHprYGi/Gdo
         r+lZ2LvkacGNXWIavHClCt2g7YdSdqu179S7LXE3t+7u8j4rpsqNG1O8FwwPZgmc32F4
         GnlBlZCPDd3PLppygm5dVOZFsw/be1h01w+g8mokZ7H6JHAtKJt8AC6puzRjjCeiR0vj
         zsmB5bfCxecG/heeOspolEOro0Uc7v/ZD/jxgPeRUAi67ohaZqhi3yNjiE6YNknC4uUa
         qxz1wZIYKNL8QJUsvpuRXNSVlTU9IiOKvxDQScRAB1d/QzjaPPH8MikUqMRxYiVDZ1Ly
         8kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754325814; x=1754930614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9dB+qdwret/lv1adiHadYT9NK1p7670u8AwYnDe0r0=;
        b=n4iI6YyS3f3dtF502H9PRdhhFxTfkHliLfsIAgJIXxgL6hDeLsuk26SZrzgeCDsYab
         0rp+ENXkaUTMZ9Vwntf4JqAWIbDEXQDJ/PpCTQgTawnRnTEmKkSAo55rIHRZYM30ZtXB
         oAC7xLXNN/jezcm8spzxuaJz35uFmcun/LlYyl74Td9OppVECRykZ9F2mldfID+V4SCL
         xT8GfbypugQwk+r4dol5YchGunyjcfG+i3smU6g+2fzj72k98CqziS38Ov1W8/TOsqMC
         e0v5PkftYcKrVzdpf7CLbdzJY13gLcj+u+SaBYLR2GtPwL5maSlCIUNUsFLPQUTCm9zQ
         1NoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvSB9pyfBn+3OAQXlzLu1NoupPhrtIvR4PaTh54+eiJCRiRGvbx4hLCkqAUOZbSynl2ZPo3jtNGDo5S+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Rg7IygLijYV8KhnlJ6sYWDXB2sqmgXC8zB68iWmm/M/DnsfH
	DB/AC4LjcKSUozaT6N/ihbeQ14qplw1zOGeknbPQOpwD2UWjgoG6MU+L
X-Gm-Gg: ASbGncu2hz4ElacVPl7QMseaD12CadWx3Qxb/A1mTJrjRSGU573+vISJe48eUsPtSXa
	e3Qy5ijS66g/oePtcv6ccTmzX8SJSAjG3FfkRkDstMU1O1KVYoL39AY5A2PP5tfMnutf74MkP4W
	+ZhoP9rzr3+QGuguRQmcY07Cqb6aLK7uBVbidhfCcFf1LTzH7msIV/iBL3mcd8pDKNyji6h3YJp
	3rqGzi0OEgAey44Ar4RcmdGIxRBbcgzSjRaS4qQ3EmnnwQCe08Gf8csDeSSxLTydow5aYpWmKPr
	fwt1dAtqoJoad8YVEbE2C9YMNf4Sb5PJBzG5MJdyUU+jzxbq6YyyrumSGsy1UkkEPwDn0lSSw4e
	RCd+8Ct2APpIE7vvMyFyLkfJEUskVQhYW/q8cudwOc5u1OGtlMFXHUiB8WfHjRDqZNgvyxCZAQi
	jo2XqBwg==
X-Google-Smtp-Source: AGHT+IHbvvaM8cLOGfE7/9Isrk/jW3M6iqhtWGp4tR+HAEvnFMuWJFZQLc+k611nhWiHWI7pxSrvIA==
X-Received: by 2002:a05:6a00:3914:b0:736:3979:369e with SMTP id d2e1a72fcca58-76bec307ba7mr12922999b3a.9.1754325813753;
        Mon, 04 Aug 2025 09:43:33 -0700 (PDT)
Received: from localhost.localdomain (36-224-173-205.dynamic-ip.hinet.net. [36.224.173.205])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm10926937b3a.120.2025.08.04.09.43.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 09:43:33 -0700 (PDT)
From: Joonwon Kang <kjw1627@gmail.com>
To: robh@kernel.org
Cc: devicetree@vger.kernel.org,
	kjw1627@gmail.com,
	linux-kernel@vger.kernel.org,
	nsaenzjulienne@suse.de,
	saravanak@google.com
Subject: Re: [PATCH] of: address: Fix bug to get the highest cpu address of subtrees for dma
Date: Tue,  5 Aug 2025 00:43:14 +0800
Message-ID: <20250804164329.98971-1-kjw1627@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <CAL_Jsq+J+6gxOzsXe9t9==GGJ721jrbNhaGMHZyfCTxkM8B0eA@mail.gmail.com>
References: <CAL_Jsq+J+6gxOzsXe9t9==GGJ721jrbNhaGMHZyfCTxkM8B0eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jul 27, 2025 at 1:01 PM Joonwon Kang <kjw1627@gmail.com> wrote:
> >
> > The function of_dma_get_max_cpu_address() for a device node should choose
> > the highest cpu address among the ones that nodes can access.
> > However, there was a bug of choosing the lowest cpu address and this
> > commit is to fix it.
>
> Please provide a test case in the DT unittests or at least details on
> the DT that is affected by the bug.

While working on the DT unittests, I got two questions to which I had failed to
have clear answers. Let's assume that the device tree looks as follows.

parent_bus@... {
	#address-cells = <1>;
	#size-cells = <1>;
	dma-ranges = <0x0 0x0 0x1000>;

	child_bus@... {
		#address-cells = <1>;
		#size-cells = <1>;
		/* Note that the size part exceeds the `parent_bus`' dma size. */
		dma-ranges = <0x0 0x0 0x2000>;

		child_device_1@... {
			/*
			 * Note that the size part exceeds the `child_bus`' dma size and
			 * also the `parent_bus`' dma size.
			 */
			reg = <0x0 0x3000>;
		};

		child_device_2@... {
			/*
			 * Note that the address part transitively exceeds the
			 *`parent_bus`' end address.
			 */
			reg = <0x1000 0x1000>
		};
	};

	another_child_bus@... {
		#address-cells = <1>;
		#size-cells = <1>;
		dma-ranges = <0x0 0x0 0x300>;
	};
};

Q1: What is the expected output of `of_dma_get_max_cpu_address(parent_bus)`?
I think it should be 0xfff since the `dma-ranges` in the `child_bus` should be
capped to the parent max cpu address instead of treating it as if the
`dma-ranges` in the `child_bus` does not exist. The current expectation is
0x2ff which is for `another_child_bus` based on the existing test case
in drivers/of/unittest.c and drivers/of/tests-address.dtsi.

Q2: `of_dma_get_max_cpu_address(child_device_1, reg_prop, &addr, &length)`
returns a success with `addr` set to 0x0 and `length` set to 0x3000. Similarly,
`of_translate_dma_address(child_device_1, reg_prop)` returns a success. On the
other hand, both functions for `child_device_2` return a failure since the
address is out of parent ranges. I think those functions should also fail
for `child_device_1` since the dma "end" address of the `child_device_1` node
is not valid in the first place. Are the current behaviors of both functions
intended?

> > Signed-off-by: Joonwon Kang <kjw1627@gmail.com>
> > ---
> >  drivers/of/address.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index f0f8f0dd191c..5e984e0d372b 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -969,6 +969,7 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> >  {
> >         phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> >         struct of_range_parser parser;
> > +       phys_addr_t max_subtree_max_addr = PHYS_ADDR_MAX;
> >         phys_addr_t subtree_max_addr;
> >         struct device_node *child;
> >         struct of_range range;
> > @@ -992,10 +993,17 @@ phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> >
> >         for_each_available_child_of_node(np, child) {
> >                 subtree_max_addr = of_dma_get_max_cpu_address(child);
> > -               if (max_cpu_addr > subtree_max_addr)
> > -                       max_cpu_addr = subtree_max_addr;
> > +               if (subtree_max_addr == PHYS_ADDR_MAX)
> > +                       continue;
> > +
> > +               if (max_subtree_max_addr == PHYS_ADDR_MAX)
> > +                       max_subtree_max_addr = subtree_max_addr;
> > +               else
> > +                       max_subtree_max_addr = max(max_subtree_max_addr, subtree_max_addr);
> >         }
> >
> > +       max_cpu_addr = min(max_cpu_addr, max_subtree_max_addr);
> > +
> >         return max_cpu_addr;
> >  }
> >
> > --
> > 2.46.0
> >

