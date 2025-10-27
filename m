Return-Path: <linux-kernel+bounces-872585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E8227C1182A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D7BB4E6B93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD11E5724;
	Mon, 27 Oct 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ2d+pVb"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39A2C11F8
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599748; cv=none; b=OhaxYiUTmRv9APip5HiMaL7IBM/0m6xyyocouFP+jciP9yIEhOCr79VX8kWHhRPyvQfWFqAeNpjwKZEu5Rsrw8AKDLaDlMqeNA3PAqjXngftB9xnnuyey+jAg+0lmZJ3hTbdjUxcosfpIOJt2yHNsjaZNHXcjhH6/0S/Te+gLAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599748; c=relaxed/simple;
	bh=BvG8AUf8NN6rZ/ehI7IqoOiJlXIB7OaMY/Iqi3A0kPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDbUJ42QJA37QOWcI+6iwya+UC+51sSV21L0jkcNDvViRa9xAGPQtwYrV0AVdrcMAVS2C+RSCPOBENZ/nAqQKJg+y1anzUdZZZzTCY5UCQRuzlEAacqg6IqXVsy2bwMS3AxiBctoX0MlMyec0ZfHDD9SDvcY49knEa9Ag4NsRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ2d+pVb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4270a072a0bso897200f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761599744; x=1762204544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+lSoLN8i9YckeiTu4zcJOQuV8QC283u18C2Hio83s8=;
        b=FZ2d+pVbe8WWXVyNTdduxiEQHfAi4oZte4kkkmwbDNG3DjB6xJ3e/0hJzL6YKoZbhy
         IkxaXfi0CbeN1o9xc47wSgKvkvSM9zkhmlcZOpIFvC9ZDSsldlggl/+9LBtyJmAYKwwD
         b063jCW5rL+7PupwqKegP9IdEzEerMnMC6tZsJ/iKs+AwKMHBlJNrcYXic7JqI2WXCoR
         8u5vJFr5MiPJvwRxiQ/cU5IxfOob05tluG7DXbnM6znnDPkhJtjcN18Cf6vjp+DQLqvo
         slo6Yh3utUuf7YOKZUeblF6rZujU1RMR2/4DK7Hkvrbtrg//EIQTc6tMNbR7QtfYlzGD
         oASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599744; x=1762204544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+lSoLN8i9YckeiTu4zcJOQuV8QC283u18C2Hio83s8=;
        b=ejT2EoXFzIINHQ1siQmO4ATkZddJzQlblHRRh2iC/IrPAA/SgZPCiUvZc6rUZsFKTF
         VG0rKPK3aDKFkbECsMB3DcqQUCs+a3E1cwqlDnMFQGY710VMjXCf8Hj1gFJHeevdVuj1
         049MaCwkhslwr0rOUH/riReflSBBWTCn9aNBqsSNl38m5TYGPZ2tRnWAiZ9lhOoOOHUT
         X6mZMIaCgczN6BX0Mdy6R4MDw5NmFDNV96qiF8QWn5gdm8dV5uCf+H6JFy5YvgsP+TjX
         Q/azG7iLhPddbcLpu57UQxSV2pUgRX3sbFN0XuamYyXgBDXce9Tmk4qAFYyw6swWzF+/
         Rhhg==
X-Forwarded-Encrypted: i=1; AJvYcCVes6ea9ujzZ4GrUOgRkFOM8XmJRDVeQ7b+1YrnTgobpL1MCg9GBqnlO7yFTMxXUzNDibXEoqcidWF71zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1k24OmD1+cdeJDXm7X/7tbf0nGUIflx/Z1jYLYN0R5+stwCg
	tDFH9TIuUfYx3IuWyNYck/QBAJsPR3V/j/YacHT8017Y5Rnso7JUtiWp
X-Gm-Gg: ASbGnctK6AbUw5qQGAgc31Smi8+/EKi2t8YM5///wLaX743YNcdCH9+rPfRjm9SXCA3
	iwS/jqvbXmZfH6FUB2Qo4hA4aSuvDyAc0xoVCbER1SV0g7S1acBNc18UKN9r1tPIEJ32Gfzsz3i
	gABZwenJgzn0QCqNq+8+9xYE3STI3YAxWzGgBeVdub8WVYcLsNwu4kxweEEPSqT0tQXSFSeRHjH
	8kKn84AmcScccJtcstnJKqBJrVnQwb5GFGxsdxzHXzgzF1X9oJ/u8zUShFx1ulhnw/6/iHCtt56
	KHESO0BuOGl+fL5Z+BaZGvUIthHMxTE6UqENbhiWYt3Jt5RBuT+YQMAJDbtCm6OYeNyxsmMiGZW
	QseX6Dg7uFO7/ZXFsqNh3VdRDshfrqiFlzHnZPsPrS4SwYPDJvnS44Ik43EkvT9QkIsbMDrOojD
	ko77o=
X-Google-Smtp-Source: AGHT+IFh12DrNry+1f/bNAHrJL6pcvzNP2C93hPckDgSQBHTy0o9MGQQybcLPrWQEBZ/cNilLsQO7g==
X-Received: by 2002:a05:6000:2382:b0:425:86cf:43bb with SMTP id ffacd0b85a97d-429a7e7212fmr608481f8f.5.1761599743675;
        Mon, 27 Oct 2025 14:15:43 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db99asm16489890f8f.32.2025.10.27.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 14:15:42 -0700 (PDT)
Date: Mon, 27 Oct 2025 23:15:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
Message-ID: <20251027211540.dnjanhdbolt5asxi@skbuf>
References: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027194621.133301-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027194621.133301-1-jonas.gorski@gmail.com>
 <20251027194621.133301-1-jonas.gorski@gmail.com>

On Mon, Oct 27, 2025 at 08:46:21PM +0100, Jonas Gorski wrote:
> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
> tags on egress to CPU when 802.1Q mode is enabled. We do this
> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> VLANs while not filtering").
> 
> This is fine for VLAN aware bridges, but for standalone ports and vlan
> unaware bridges this means all packets are tagged with the default VID,
> which is 0.
> 
> While the kernel will treat that like untagged, this can break userspace
> applications processing raw packets, expecting untagged traffic, like
> STP daemons.
> 
> This also breaks several bridge tests, where the tcpdump output then
> does not match the expected output anymore.
> 
> Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> it, unless the priority field is set, since that would be a valid tag
> again.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Sorry for dropping the ball on v1. To reply to your reply there,
https://lore.kernel.org/netdev/CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com/
I hadn't realized that b53 sets ds->untag_bridge_pvid conditionally,
which makes any consolidation work in stable trees very complicated
(although still desirable in net-next).

| And to sidetrack the discussion a bit, I wonder if calling
| __vlan_hwaccel_clear_tag() in
| dsa_software_untag_vlan_(un)aware_bridge() without checking the
| vlan_tci field strips 802.1p information from packets that have it. I
| fail to find if this is already parsed and stored somewhere at a first
| glance.

802.1p information should be parsed in vlan_do_receive() if vlan_find_dev()
found something:

	skb->priority = vlan_get_ingress_priority(vlan_dev, skb->vlan_tci);

This logic is invoked straight from __netif_receive_skb_core(), and
relative to dsa_switch_rcv(), it hasn't run yet.

Apart from that and user-configured netfilter/tc rules, I don't think
there's anything else in the kernel that processes the vlan_tci on
ingress (of course that isn't to say anything about user space).

With regard to dsa_software_untag_vlan_unaware_bridge(), which I'd like
to see removed rather than reworked, it does force you to use a br0.0
VLAN upper to not strip the 802.1p info, which is OK.

With regard to dsa_software_untag_vlan_aware_bridge(), it only strips
VID values which are != 0 (because the bridge PVID iself is != 0 - if it
was zero that would be another bug, the port should have dropped the
packet with a VLAN-aware bridge). So it doesn't discard pure 802.1p
information, but it might strip the PCP of a PVID-tagged packet. This
appears to be an area of improvement. It seems reasonable to say that
if the PCP is non-zero, it looked like that on the wire, and wasn't
inserted by the switch.

