Return-Path: <linux-kernel+bounces-774964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18EB2B9B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA86839C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BF26D4C0;
	Tue, 19 Aug 2025 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="GLOmXOs4"
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F41AF0C8;
	Tue, 19 Aug 2025 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755585534; cv=none; b=vEEflVP+gPR/KHVQE/4NncWicG/vmHb3pULOgZedsIZJx6M32/SVRC+v+YTLFzolBHhBPd6xe7tyDn7xxYfMf6odyoZLI7Jeh+jL+yoqH5zj6kghUhH4UC7JL7CgUydHeuqB1n1dhRvsVLHPJlvjn9GbdBlx+J3si6CWQk2WrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755585534; c=relaxed/simple;
	bh=NJnYaJ1A22Lr2BKCr3YkvWlJsaIjpApT5aFP2VZVFcI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Hm0e7+nqiWLq6BLehfNxt3a/TbYPCRaJl01rrthhkPpW20Sr4uDQTCjdOzBBofiddlZ0M2MYd+cJZaRf2XRkryMpY0F2G3nJv60976reX3l2J846baW8IgEVJF8//EEE/qR7Zd0LXm2wv29YeZF8kAQgEOgnQ11KQjoogpAR2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=GLOmXOs4; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 35F6D34A;
	Tue, 19 Aug 2025 08:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1755585524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObL26OE97gG5flRbHvdO93Fpd5gaO/HRUMy/l+G5JRk=;
	b=GLOmXOs4SK0S5ZeBtoSbCC4KJ8ATerfn7naXeU3hX+r/7f/HSj8lG6iznyNL1/cjpjKCkg
	BpG/G21iDSsy9UrSCCr5SEVGyCMLvl/l5insHYezX+qyvrOxSoyz3C2PqKyxXOiKgqYNQF
	Nb2kEBD0rLzRfcNvKHBEH8t6cQW07c96ywANk6DgRAW0xDHcTIZGTJkZmsevN4IxCRayVx
	Wh14y6dPXOEbHU/pSeLHWVjPUhBpv+OXnPoQg+pdE9R8yIVCZGkJVgFU/s/3Z8+6GJoQYR
	yhUwnHXSGfyu5QtMg+noXOTHVM6XGRuDTG6KKpbpeeYaEEY7U4QKpNKRuKQRCw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 19 Aug 2025 08:38:43 +0200
From: Michael Walle <michael@walle.cc>
To: Randolph Sapp <rs@ti.com>
Cc: Nishanth Menon <nm@ti.com>, vigneshr@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, d-gole@ti.com,
 afd@ti.com, bb@ti.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, detheridge@ti.com,
 matt.coster@imgtec.com
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the bxs-4-64
In-Reply-To: <DC5T752T3P8B.1UC57G2GH35Z5@ti.com>
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
 <20250813181300.xfpsu23arx7xy4fy@anointer>
 <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc> <DC5T752T3P8B.1UC57G2GH35Z5@ti.com>
Message-ID: <f0353dea24751f2f2ad6e7735232b933@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi,

>> Apart from that, we now have two series which partly overlap.
>> Should I repost mine, as that's more than just the DT entry? (Which
>> doesn't work as is, I'd guess.)
> 
> Ah, I don't see that series on the linux-arm-kernel list. If you can 
> forward me
> that I can work around whatever you've got.

That was the one Nishanth mentioned earlier:
https://lore.kernel.org/linux-arm-kernel/20250716134717.4085567-1-mwalle@kernel.org/

Also this:
https://lore.kernel.org/all/DC5KCSEUZQUJ.3KPENNUQBUFM8@kernel.org/

-michael

