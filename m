Return-Path: <linux-kernel+bounces-820431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C9DB7DE25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794FD16BDE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29934AAEA;
	Wed, 17 Sep 2025 10:08:34 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27E345750;
	Wed, 17 Sep 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103713; cv=none; b=HMe0DQHLnZ3MQAIhrytxq5EMr78qihjFZEWPTIzlz68NqsZ71Yy571NiErVjfpIT20Y4e2LuYSmhEpWuk2erUaug0Ncjg0RY0LmIUVl2qhXUSRCKHxpIZ95V9jO5ZOpfh5vGwdBen+5L/HJBnVw9H6MMMaA9HmjAKSvuhsdX5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103713; c=relaxed/simple;
	bh=uGgIsSRh2yAuyUDI6Tik8W2MjULVQI47fnoWhcTl/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNKEXAOZJLuZbQxc5ls7x6FExhrMMfuU/aC27QaQYzdcSAS1BgqX5FdusdgNeNQehhOMm5KB3PT0Ep2Alp4Ry/Gva5+qJ+jW4d0njgk39Qoi8ReDxnTpuHLNX34cYwPw+1vtEClYPG8kIwRla6TC9DLcPsIRkYEuyCLvF3oy1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uyp5Q-000000000JG-2t4D;
	Wed, 17 Sep 2025 10:08:28 +0000
Date: Wed, 17 Sep 2025 11:08:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] arm64: dts: mediatek: mt7622: add 'serial' cell to
 efuse
Message-ID: <aMqImGmz0uf_aTUR@pidgin.makrotopia.org>
References: <18af6977cc34de75e64279141dee69dcbc81c420.1758063737.git.daniel@makrotopia.org>
 <87179c9f-cc7f-446f-9e8d-c84bddb48660@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87179c9f-cc7f-446f-9e8d-c84bddb48660@collabora.com>

On Wed, Sep 17, 2025 at 11:06:13AM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/09/25 01:05, Daniel Golle ha scritto:
> > The efuse of the MediaTek MT7622 contains an 8-byte unique identifier.
> > Add a 'serial' cell covering those 8 bytes to the nvmem defininition of
> > the efuse to allow easy access from userspace, eg. to generate a
> > persistent random MAC address on boards like the BananaPi R64 which
> > doesn't have any factory-assigned addresses.
> 
> Sorry, but I don't get why this is named "serial" and not "soc-uuid".
> 
> Care to explain?

I don't have documentation covering the efuse content but only got this
information on an informal way:

https://forum.banana-pi.org/t/bpi-r3-serial-number/14556/10?u=dangowrt

Either name is fine with me, I thought of it as "serial number", but
obviously "soc-uuid" works fine, too.
I can change it to that and send v2 tonight.


