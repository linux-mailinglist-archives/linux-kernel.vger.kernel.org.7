Return-Path: <linux-kernel+bounces-760559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD0B1ECD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA243AACA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EDB286890;
	Fri,  8 Aug 2025 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d4vRw/7K"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C881B423B;
	Fri,  8 Aug 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754669432; cv=none; b=NtgRNctGMitm40OVgAuAlxIjTxowrXnP8ACgxxkKzuV5AjcvEbsmqI6f6VjaX0ZDYQz/U99V/gBFaFDOah6B8R2hBZyQ1z9dByQoEbetMyozCBCW6K97AZpRbAHd2WMoi8odpfqf8/AQX13L70nN+6O5X+O2Ko9JW1dovmyyRAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754669432; c=relaxed/simple;
	bh=+eOVY9tUPincYEWSfvcp/AyQSua0qXQ8IOjEUh+Rg4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9K6KGyM7cHeLC8Z2pPZ839BMbCKval/tyrkaH1ZkShlqsDCsEGFIbgRnysZc7JQr/6h96ngsU5OBA41n9zKOJfy8QczK8AN0HeLpToRcpKwoNrByETbQtLhzULFN4dZaaQvU7rA2fsEmqzuc1wfz7+bsBLyFAwlTdEn5Tkb7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d4vRw/7K; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BB0E1C001508;
	Fri,  8 Aug 2025 09:04:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BB0E1C001508
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1754669052;
	bh=+eOVY9tUPincYEWSfvcp/AyQSua0qXQ8IOjEUh+Rg4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d4vRw/7KEV9m9DKdBdDoeE2Bv66WwyGKM459lsGpI1ElJ9I46Wpc89SL2CctgqSiq
	 qr5HALG5Kj8dUa8PB1WfXsGAs35S6Ol+IU8dpDTbz8i2DqUhJvrx0GTqX2dOxHFNmc
	 RW2aAY7SmNTpr55seLp5IEJxJnIMsok8srzM8bYs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 49AE71800051E;
	Fri,  8 Aug 2025 09:04:12 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	Taishi Shimizu <s.taishi14142@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: bcm: Add support for Buffalo WXR-1750DHP
Date: Fri,  8 Aug 2025 09:04:11 -0700
Message-ID: <20250808160411.40391-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713071826.726682-2-s.taishi14142@gmail.com>
References: <20250713071826.726682-1-s.taishi14142@gmail.com> <20250713071826.726682-2-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 13 Jul 2025 16:18:24 +0900, Taishi Shimizu <s.taishi14142@gmail.com> wrote:
> Add Buffalo WXR-1750DHP under BCM4708 based boards.
> 
> Signed-off-by: Taishi Shimizu <s.taishi14142@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

