Return-Path: <linux-kernel+bounces-822994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FD1B8541D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF88546BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3330B513;
	Thu, 18 Sep 2025 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIEjBc34"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF773220F2A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205448; cv=none; b=mdjkcQhu/sjDtX02ScEjAvo17Wt8I1JGbtoA8qYMyUk+RATEniyHiQ0xz6kd1sEuCohCNxsSAS9QN1Ql/TfgWBtQlhlfT//rw/3EO7pHDSOCE58IWg0+PbO7IEJn/7CKntfTvIhJNtfQdzVrz9xqdx+RhHgoyE+h2xmpm8fly94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205448; c=relaxed/simple;
	bh=IDc6RQ3z8B8Ry/K9LKfQg3eL/rSFGyiNZ4wOOd5+bsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nwPqmXjxznfSng33qOPViQUmWJ0yebj77HiIqAHrW5WcFLDw7gAc0ZMius5fWqsjN6cCVNLKUtry5epLkhIfCo65wu9gDOnc/BqWSaorYb33AcHhgsLYnQxK/3OivP4qtXFl/JNS+vkO7PSoZLOF8dDdXjGIixYjBUkhsXKW1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIEjBc34; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77d37d71967so694185b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758205446; x=1758810246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN6OUyLXfG28wohM8pGgYSaroM8kq146dlifB0TJ7X4=;
        b=RIEjBc34s6VzMqJ3ErPcdVTEJstlYQJilyEPKqQwxJKWSjDl77WrafrS2uJ+XQeP9u
         klEgThwMTkRy4FoooWn2T+jh6ecEh9yDlPzb+GjlBK8Losy+2EdMqesH32CF0wTTsY3t
         SuKOqRfOm3J410tb5jmPArs5Gu0CxPCaeKPN4G8ONBBW87/iao84NJ5X1o0lGQHgsEew
         egValb4BoX5PP3sTwn0EhQUYP91livNzsuc1ebwIZdUdncDdqVZ81DbjONrs/2RRPSBK
         KzmFl+0PCvIBIQPv9ATWqCavAGU8vEV11B3Q2GUx2bUxBF10by+LSb0y8eT68zMiNeGi
         zkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205446; x=1758810246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VN6OUyLXfG28wohM8pGgYSaroM8kq146dlifB0TJ7X4=;
        b=WDyhnjIK+sm+WS4dk97PEg/ddzS2P/G7DrfQDTY6AzQkUet4dvM8hwlkyzTkUIPo6W
         15i2CcNbaNywe4CRFroDVCiRcbzNyDvupy7mTSPoqDTQe1yEDQxgrhHyNSDJMX4N2gLG
         bvz2dP1HAHYlN1HWk53VakNOA7qaXZ/L7c3HO9p/iW3FFUwpgwG69cyllXAmCt3NpQdA
         6IO7JOpgED4vhdfBI0i1N6kjM8cG5K5URUZ8JaH2F7C4PqdxpUMM+fTl4h2h9B4gaRg/
         2PH68nPlCec8686LzPpxOsXYiv9c0NqiJ/s4gRM4OVruEsqbgCz9sdUudyYBlgvtdua2
         9ZDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVhNrcn1DFV4UQsGXox2rcoIYRaN/q4GIsF4h+E+pW2K2GgaxUR+CXrzVRJgB+GY11/ICkNhbQW5eb1Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEcQsJJZu1qWK6wQ/4WaIzWkLto0G+6WWL7Zk3qUFAt0YUGf9K
	SJMr/w40MUzE3TN27JWY20p10chQRno4eGnXAgc4lSv3HflEkN1X8NcE73z9jKkNF9pyHAIR3kW
	ehJQHzPMrNeSAIdKPW6NgfQfgOm0b4YY=
X-Gm-Gg: ASbGncvLyCUKDlQY3qGHHYHswE40VpEZlvAKti4AO0kkc/K3NvOwqYTSchUjlu6OcLY
	ifiK0C+/IeKTXnafnvO/1gi8FGlnLYK4T8sDFhbuOI/bwkYWjd04QBqoNDZpyCREZ1nMfh4GaPg
	FVh4ITn5IhK6gV2mooE8qF0KHzbDYWhA0CPkzihxr3gaDkLn6u8ql6whrMGwhi7AWxbGk1CmTpl
	G0ItaUAKU1p2149yfezPRI2uzS5PHa/j1rxDnkeOAbfE/3OiATT82Xs9iw=
X-Google-Smtp-Source: AGHT+IFhZD7k5FRjyNJx+sSzVwaeNyL2q4qjPlMlcQFnqYx6LT/d960WLfFakjpmqfqXBsKQLRHj7RaAt6fk5YjM5fQ=
X-Received: by 2002:a05:6a20:2450:b0:249:467e:ba70 with SMTP id
 adf61e73a8af0-2845641b90bmr4887486637.24.1758205445964; Thu, 18 Sep 2025
 07:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913044404.63641-1-mmyangfl@gmail.com> <20250913044404.63641-4-mmyangfl@gmail.com>
 <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
In-Reply-To: <20250916231714.7cg5zgpnxj6qmg3d@skbuf>
From: Yangfl <mmyangfl@gmail.com>
Date: Thu, 18 Sep 2025 22:23:29 +0800
X-Gm-Features: AS18NWB6aHnLtegCP0Qrw-Qf-BcoCYte67EfE_oUYhQeFIVJUf2eO5bV4mq7rlU
Message-ID: <CAAXyoMOpj1iCd6KZH0dQ-riuDSH_KOkvzB=cz66rWgykChda9g@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:17=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
...
> > +
> > +     mutex_lock(&priv->reg_lock);
> > +     res =3D yt921x_vlan_filtering(priv, port, vlan_filtering);
> > +     mutex_unlock(&priv->reg_lock);
> > +
> > +     return res;
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
> > +                      const struct switchdev_obj_port_vlan *vlan,
> > +                      struct netlink_ext_ack *extack)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     u16 vid =3D vlan->vid;
> > +     u16 pvid;
> > +     int res;
> > +
> > +     if ((priv->cpu_ports_mask & BIT(port)) !=3D 0)
> > +             return 0;
>
> The CPU port is VLAN-unaware by default and the driver leaves it that
> way, correct?
>

Yes. Actually flows via CPU port are entirely up to the tag, and we
actively isolate it from any other ports (see port_setup()) so packets
without tag are automatically dropped.

...
>
> > +static int yt921x_chip_setup(struct yt921x_priv *priv)
> > +{
> > +     struct dsa_switch *ds =3D &priv->ds;
> > +     unsigned long cpu_ports_mask;
> > +     u64 ctrl64;
> > +     u32 ctrl;
> > +     int port;
> > +     int res;
> > +
> > +     /* Enable DSA */
> > +     priv->cpu_ports_mask =3D dsa_cpu_ports(ds);
> > +
> > +     ctrl =3D YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN=
 |
> > +            YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
> > +     res =3D yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     /* Enable and clear MIB */
> > +     res =3D yt921x_reg_set_bits(priv, YT921X_FUNC, YT921X_FUNC_MIB);
> > +     if (res)
> > +             return res;
> > +
> > +     ctrl =3D YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT;
> > +     res =3D yt921x_reg_write(priv, YT921X_MIB_CTRL, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     /* Setup software switch */
> > +     ctrl =3D YT921X_CPU_COPY_TO_EXT_CPU;
> > +     res =3D yt921x_reg_write(priv, YT921X_CPU_COPY, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     ctrl =3D GENMASK(10, 0);
> > +     res =3D yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
> > +     if (res)
> > +             return res;
> > +     res =3D yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     /* YT921x does not support native DSA port bridging, so we use po=
rt
> > +      * isolation to emulate it. However, be especially careful that p=
ort
> > +      * isolation takes _after_ FDB lookups, i.e. if an FDB entry (fro=
m
> > +      * another bridge) is matched and the destination port (in anothe=
r
> > +      * bridge) is blocked, the packet will be dropped instead of floo=
ding to
> > +      * the "bridged" ports, thus we need to handle those packets by
> > +      * software.
> > +      *
> > +      * If there is no more than one bridge, we might be able to drop =
them
> > +      * directly given some conditions are met, but for now we trap th=
em in
> > +      * all cases.
> > +      */
> > +     ctrl =3D 0;
> > +     for (int i =3D 0; i < YT921X_PORT_NUM; i++)
> > +             ctrl |=3D YT921X_ACT_UNK_ACTn_TRAP(i);
>
> YT921X_ACT_UNK_ACTn_TRAP traps packets with FDB misses to the CPU, correc=
t?

Yes, and

> How does that address the described problem, where an FDB entry is
> found, but the destination port is isolated from the source?

also in this case.

...

