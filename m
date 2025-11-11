Return-Path: <linux-kernel+bounces-895108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E077EC4CF16
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4E4FC403
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6C3345CC1;
	Tue, 11 Nov 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR5JJLwf"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2433A032
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855622; cv=none; b=A5ctD7Fr83WfLAqFsHbviSz0Buc9+XvuDudlqSVcSP4rHa6+i3qFqAsBHfT8eKXhz5cZ2UY9pwr7ZdQRfcRDhq11sCKWg6tkb+jqAnONiiZXNO1KawEvG+wxVkIA+qOzGNUijB/So2ki4lMQ83rLdIoXEf1SOrlLz5RagXB682Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855622; c=relaxed/simple;
	bh=D9DSXHRVJFLfhBvf9Xi+1f1QYXFfOuwhDhDl0ec9+ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYLsVUgjuMNpLiJNOSwElTY/5Whh/jbEQsBmv3WsLJvHTa497jznRL6F02lvn1z6XeFw+C0BYioypBLXORnuXSW05giMTSAiH9RGMqzHfpQItruMqOcNgHAnx8ezRWmkA70NSX8+JlrcobBqUyWJurC3IGHGwSCp5y821sQlgiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR5JJLwf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78665368a5cso37971157b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762855620; x=1763460420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmIn+rr47OIki868fF0YXvVBbJdq9zqT2ApwBKYAGgw=;
        b=dR5JJLwf/PgJSENbgeRN1zMr67kFgnNJZIpIRiNy3X1u+G/zygXyqxfPtE4ncT4CFm
         kQ9ezWp9mkM9UjPieYfUoarZZxf5IKqCpyMik4Tsd4njpok8G4D2hmbHejAatt7t1gJY
         q2/vQ4aNFGe0B8OYtfLFKMx1Dml8H7D/UdPVnB0896e/x+ZOqc7zCa7l9qpnrTs+Lzfa
         SsedkyPr875lcTGH8s8CwsCms2aU/NEwb0VEfpn2B6mJrKEk/osQFyOJgg9NFa1VtoRO
         M4rsWfvP73xw4qWugDdL52PbHjvBC1bXfCvf2Ujes7Wl69wWpV7/NsRyNTtsqGqjqmai
         72cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762855620; x=1763460420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XmIn+rr47OIki868fF0YXvVBbJdq9zqT2ApwBKYAGgw=;
        b=QPhXxzmYSLVWGO5pj8FKcilwwLLK7z3F6B31vRcjZk40L/Jg4mUVIKy4hqF75DnnK0
         w3EplllRp6taDFh+7NP6MbI1uumMnqDlCiiFgSllF+xEvp+itILp5PLXYvdw2rPDw8Zh
         AiZqnKEexmdN7jjiF2qzV+3n5x2l+V7mbPka9j3EJxnvXZKz06iZZSDD6hDLv61BMEOc
         Ca7WquBmfB+AQs/gDaYl1uBejwnOL64OV8kW/en+5r649uR5uNsJMa/lbsjMrChU6Qzr
         owbDV8aWV3LpgiaisJgB27T90JeAc9eTY4xYQNwfNdPL3gORDWVpdtoPIjQ6hnhpt2Ja
         6Uag==
X-Forwarded-Encrypted: i=1; AJvYcCXOIfgFnzzXh2LoGJR3ZEWnuOCpAAH13p3WOwEAxDFKUemgzHCRGqNUknVdVLWsCm/15KJUreQnW9zsPZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykyRk31Ehnoc/nY6FYevo+bfSpAwGqHhFdY9aNigV84HBC4Adw
	fhu2wDXmeijXYDikXiQ35QCrlm1CwhW6x1KUDF3HVLlD9dmAEdxjGuDwCzQCyvv7G1IzdWfpHxG
	aLYOzxT7Sua8g4lyAiCtiGGZfTXSmzTA=
X-Gm-Gg: ASbGncuRE2NW5tV1JamUSjxK8afzqtoP8dbrExH1yYtUu4asdxYzgqNzGjkZAp4w6yZ
	h62skrvSBvf5A3VlXaosrx6a1Rj1dQxB+koqj2ZxqVq5whfEq/bLTZYIFGAnw7gdkUhM075EfRG
	a7Hk3l8QN9jDrB1Fa+wPEuYt9KFfN58jUImnUJpHtrSdAFcU4tAy6+/1N7JKw9lXIBgGgIk6v40
	sdcAaSEvdukw3777ZHC8bU28xE3T2BasztHbuX/ajKCfWg8y2lssFcz/fE=
X-Google-Smtp-Source: AGHT+IE5CdgYP4S6eVmoXO/ZsyBjFqfgRd/wYKtWoj1g+kp/Vi0+gR3ZGX/nKQXM51ALznSDaJ1HWFPt25Qweg0Vcgg=
X-Received: by 2002:a05:690c:6ac9:b0:786:5be2:d460 with SMTP id
 00721157ae682-787d5350cdamr108183427b3.1.1762855619827; Tue, 11 Nov 2025
 02:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
 <20251110214443.342103-4-jonas.gorski@gmail.com> <20251110222501.bghtbydtokuofwlr@skbuf>
In-Reply-To: <20251110222501.bghtbydtokuofwlr@skbuf>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 11 Nov 2025 11:06:48 +0100
X-Gm-Features: AWmQ_bmSO1z1LVSBIAI4czPL30v972CtnbpO3gCqbxlnpZfY5KJuoptPPMAGhlw
Message-ID: <CAOiHx=k8q7Zyr5CEJ_emKYLRV9SOXPjrrXYkUKs6=MbF_Autxw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: deny 8021q uppers on vlan
 unaware bridged ports
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:25=E2=80=AFPM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> On Mon, Nov 10, 2025 at 10:44:43PM +0100, Jonas Gorski wrote:
> > Documentation/networking/switchdev.rst says:
> >
> > - with VLAN filtering turned off, the bridge will process all ingress
> >   traffic for the port, except for the traffic tagged with a VLAN ID
> >   destined for a VLAN upper.
> >
> > But there is currently no way to configure this in dsa. The vlan upper
> > will trigger a vlan add to the driver, but it is the same message as a
> > newly configured bridge VLAN.
>
> hmm, not necessarily. vlan_vid_add() will only go through with
> vlan_add_rx_filter_info() -> dev->netdev_ops->ndo_vlan_rx_add_vid()
> if the device is vlan_hw_filter_capable().
>
> And that's the key, DSA user ports only(*) become vlan_hw_filter_capable(=
)
> when under a VLAN _aware_ bridge. (*)actually here is the exception
> you're probably hitting: due to the ds->vlan_filtering_is_global quirk,
> unrelated ports become vlan_hw_filter_capable() too, not just the ones
> under the VLAN-aware bridge. This is possibly what you're seeing and the
> reason for the incorrect conclusion that VLAN-unaware bridge ports have
> the behaviour you mention.

Ah, right, no call at all.

But this is about a bridge with VLAN filtering disabled, so filtering
isn't enabled on any port, so ds->vlan_filtering_is_global does not
matter.

See my examples in my reply to 0/3, which hopefully clarify what I am
trying to prevent here.

> > Therefore traffic tagged with the VID will continue to be forwarded to
> > other ports, and therefore we cannot support VLAN uppers on ports of a
> > VLAN unaware bridges.
>
> Incorrect premise =3D> incorrect conclusion.
> (not to say that an uncaught problem isn't there for ds->vlan_filtering_i=
s_global
> switches, but this isn't it)

This should happen regardless of vlan filtering is global.

But I noticed while testing that apparently b53 in filtering=3D0 mode
does not forward any tagged traffic (and I think I know why ...).

Is there a way to ask for a replay of the fdb (static) entries? To fix
this for older switches, we need to disable 802.1q mode, but this also
switches the ARL from IVL to SVL, which changes the hashing, and would
break any existing entries. So we need to flush the ARL before
toggling 802.1q mode, and then reprogram any static entries.

Best regards,
Jonas

