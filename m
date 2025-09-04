Return-Path: <linux-kernel+bounces-801632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08FB4480F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41D3177A0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB335296159;
	Thu,  4 Sep 2025 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="uZuF1dRg"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498D285CB2;
	Thu,  4 Sep 2025 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019997; cv=none; b=LBEq9Sf5u/5XdCRcgSvZY5bAulsvjNYtG5nF8QHusSPUQULgNNYzmbGWbBSI+KAHvqAtXutlZfZhfI9yNom3POsmhnJ3aNcQ+OfODiWPHtCS6zzwn1FRSb0QmDEA/15tto0AamcJ+z+aX6ZVFmL5F4e074vb5cFeUvoBuN3Fx+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019997; c=relaxed/simple;
	bh=QiHIY+KGsOBc9vvFNqr/YKh5r93V7JQ/OZJ1YrLv16M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMfVEFB7jaPLbLpGwfo/dEZxL0Pzo///nyHpb2ZUMfQOYZXxBDJD7dqcLwQBGMQqRQ2wn+GldVWuvtuIDam+mLtGWaOg6yYfkJJcxTh+Dy+din9J9psxWuBRx4VsxjnKOWfSaEO6YTytwtkfHQmI7BJ/ipXhS7GSYXXVI8bT7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=uZuF1dRg; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4E95BC000567;
	Thu,  4 Sep 2025 14:06:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4E95BC000567
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1757019995;
	bh=QiHIY+KGsOBc9vvFNqr/YKh5r93V7JQ/OZJ1YrLv16M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZuF1dRg/704uBqbSQ/uQxjs1BSpOFYEe4nDbjx+aB96kZYGMowW9+CAEaKwJX6gO
	 GQ9WkFnFRLb8Or+Kk5lLJKWqS3FYNdPcWbfSwhK1TKRYFuQyVRy/8sZGFWZteWydv1
	 rxvciWxxURtiuOKt7up6cfuees1PpGrE3r0AtwoM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 07D7418000530;
	Thu,  4 Sep 2025 14:06:35 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Stanimir Varbanov <svarbanov@suse.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 4/5] arm64: dts: rp1: Add ethernet DT node
Date: Thu,  4 Sep 2025 14:06:34 -0700
Message-ID: <20250904210634.222845-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822093440.53941-5-svarbanov@suse.de>
References: <20250822093440.53941-1-svarbanov@suse.de> <20250822093440.53941-5-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 22 Aug 2025 12:34:39 +0300, Stanimir Varbanov <svarbanov@suse.de> wrote:
> Add macb GEM ethernet DT node.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

