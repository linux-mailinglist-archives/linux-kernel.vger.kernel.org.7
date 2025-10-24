Return-Path: <linux-kernel+bounces-869348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89659C07A71
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DE73B4E04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604F342C93;
	Fri, 24 Oct 2025 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="m3Mk6yOh"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E5303C8A;
	Fri, 24 Oct 2025 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329200; cv=none; b=a0ByZzzbFnDhi1c/y59mlhZ34C8zGTvh9pdQCfpv+2aFCAYT0QRmU1FqPkerhbWlw0EiPlDgyhyPF2tBSvrjx54kewPlHF9rz7XgFSezl+zDsOZqiM0a/SbgOUJWQ2wPXYrwbWR1wMzpZl2iGZPdY3F6wz6Q2idLl52RJrG+KNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329200; c=relaxed/simple;
	bh=9a0TgFQiFD71k1iDK0L9UBL2o1z9+uplLaO+xSIPDhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkbZhqV9woIia6lIQ6NMKeqXSk0402iW2aJUduvNS7Iaf2OMI3whFRfbar/bGf9uYVrDrsXclYzIgpEJHkMByo2LVinXLwBXAsXurKYkBQWB9Xc9qcvpSnCICauOMIwJlk/2UlAyq7Pp0SlK5e8FZCDg9+qrGEsoDCnJV16u4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=m3Mk6yOh; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9FB67C001505;
	Fri, 24 Oct 2025 10:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9FB67C001505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1761328645;
	bh=9a0TgFQiFD71k1iDK0L9UBL2o1z9+uplLaO+xSIPDhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3Mk6yOh3qi21ChVnsKe2WApmt3xxy1+JYapDnA0501QkxBBkJiS+AujG0RVOkEJZ
	 ukd9iJlyepNxhsOzy7M9i4+U6Vsd2sP4ZQgera/uIUGntT7BgrJ9JLpQCWPTlJxxOP
	 z37W5ebdEZpz9SD1lShMK3+PaRP0abu2KPBLfjuw=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 2B53118000530;
	Fri, 24 Oct 2025 10:57:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stanimir Varbanov <svarbanov@suse.de>,
	Andrew Lunn <andrew@lunn.ch>,
	iivanov@suse.de,
	mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] arm64: dts: broadcom: Assign clock rates in eth node for RPi5
Date: Fri, 24 Oct 2025 10:57:24 -0700
Message-ID: <20251024175724.3223588-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021135533.5517-1-andrea.porta@suse.com>
References: <20251021135533.5517-1-andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 21 Oct 2025 15:55:33 +0200, Andrea della Porta <andrea.porta@suse.com> wrote:
> In Raspberry Pi 5 DTS, the Ethernet clock rates must be assigned
> as the default clock register values are not valid for the
> Ethernet interface to function.
> This can be done either in rp1_clocks node or in rp1_eth node.
> 
> Define the rates in rp1_eth node, as those clocks are 'leaf' clocks
> used specifically by the Ethernet device only.
> 
> Fixes: 43456fdfc014 ("arm64: dts: broadcom: Enable RP1 ethernet for Raspberry Pi 5")
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

