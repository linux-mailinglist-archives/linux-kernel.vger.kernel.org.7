Return-Path: <linux-kernel+bounces-799169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 671ECB427F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC1F188055A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C3331E102;
	Wed,  3 Sep 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MlkBA6Qn"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1528D2765E3;
	Wed,  3 Sep 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756920579; cv=none; b=WSqLo+q8GbYlOWEyNsLZUJYDpjbiGI5j1UGsFiwxEsokSnh1XmBGOJ892aPyJZGd+Mt6skqF4P8OQ1lEIbBxkBNRTyBRPlB8ArkgrYEVkIO7Iw0AJcrCs/E318cv5xZKs0ZrTjTwvh1SOMjO7BtNPuQ+79xwiolNJU6MqZn/Ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756920579; c=relaxed/simple;
	bh=MgR3tYmVRb8vi08gFaEidd7fXX3CfhvWHiW0QflcxGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wv3F91p0P2QZG2ruVZ70c/U1zyT2HHEggumyOXqs4Rh23Qf2QAMtMtZs+yYLKi760br/S1yic1QixN9icfGc+gmPuaGyvodpaq+l9pF0DDGYAv5xVpMSIWgAKsZz4fPSogO+ix2uumfmA6Dd9zSeUpYH8HMB6Vk+hG+ghzEfjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MlkBA6Qn; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6A66BC000C6F;
	Wed,  3 Sep 2025 10:22:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6A66BC000C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1756920175;
	bh=MgR3tYmVRb8vi08gFaEidd7fXX3CfhvWHiW0QflcxGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlkBA6QnPCNo2FcawW4uT+Gz1EJVgjkBd9nbRAdayc/HP+ysGLPlA8GU9E5AmwLJa
	 Pstlg+3YByjjjpg4r/X8vQx1vz62LtFWO9r5NGOVsjFhS3yMrR81drZjApVRRHPEIO
	 O18WrfkYWFVsHr9ILOgmdOsR7c63nfWMTCN0nAxg=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 0A6A0180004FC;
	Wed,  3 Sep 2025 10:22:55 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] arm64: dts: broadcom: bcm2712: Add default GIC address cells
Date: Wed,  3 Sep 2025 10:22:54 -0700
Message-ID: <20250903172254.2512047-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822133407.312505-2-krzysztof.kozlowski@linaro.org>
References: <20250822133407.312505-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Fri, 22 Aug 2025 15:34:08 +0200, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Add missing address-cells 0 to GIC interrupt node to silence W=1
> warning:
> 
>   bcm2712.dtsi:494.4-497.31: Warning (interrupt_map): /axi/pcie@1000110000:interrupt-map:
>     Missing property '#address-cells' in node /soc@107c000000/interrupt-controller@7fff9000, using 0 as fallback
> 
> Value '0' is correct because:
> 1. GIC interrupt controller does not have children,
> 2. interrupt-map property (in PCI node) consists of five components and
>    the fourth component "parent unit address", which size is defined by
>    '#address-cells' of the node pointed to by the interrupt-parent
>    component, is not used (=0)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian

