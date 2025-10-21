Return-Path: <linux-kernel+bounces-862854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C874BF65C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152931889B95
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C63346BA;
	Tue, 21 Oct 2025 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AZ06nvrf"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378EE355049
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048598; cv=none; b=UNiug10eJdnJygep61sHmQXLXVKM9fH6XH0elMDMD8Dpk6s6YjSagThA+KnPMMGG4s/M1UK+1AVvwdGqwdaMD5f4m3qDEffnyxyOtLzf1VcutLD8IUmd9PE9q6gdkLqoBzgpPYdfcZYNZeujgBamfmbslDv4sFoKubTySvznKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048598; c=relaxed/simple;
	bh=zcEo0Y4iHlgKicyWC/0hBnTrN4iw7wQjBd6lUgzbPGI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mkKjYvCqWs6VMMAKC3ITP7SHp9U4auoBKrajzpUQnMIT6DUa7nYaFfyBjENjZbFtewr0vEhrc9zVjf5/b18/1cffQbdnOJhrrxoM/W1Tnrauh9cUqwXWMdmdTbmPJwSusLIx0dBkZPXbRgCBIa+FnTY1G2w38EF9KKVA8jqerOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AZ06nvrf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2AE0C0B88D;
	Tue, 21 Oct 2025 12:09:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3731360680;
	Tue, 21 Oct 2025 12:09:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E336102F23E9;
	Tue, 21 Oct 2025 14:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761048593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jYftyPWe3cSDHOa3crBNXagLfu5+YLZP87koZDXEKHE=;
	b=AZ06nvrfdkt65l4E235uJTkuujLAFE0Xkr8yMlv8YGs+4Wjxl3cDNrgnC2wekfhdFKRJbx
	p978H1NRdxMUpJOiFKTjCdI2um+XRjTW5kiMLUBqR8J0FIKF/0630noMdkQ5tTxG2+A3iG
	5z+SYTF9YQI2Kqf5cFY5J7mxrPj7RJGbY7dzFj2hWOIjY+oL8pIl7gsj2ke1a4Gbrc/VfF
	jlZMh+iIoacYmLgyB4ovjesL8k3qgXAxwHguAQanDz0WhDnNO7IDoGaAnG34IFTBjEpU0W
	sAoLDPQEgCpOCHULSukUf3kb/HqaPCJuyQye8KRi/jTHKU1fRYNuNPbOB6YXLg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 14:09:39 +0200
Message-Id: <DDNZMD1M6G49.1M47TZR3DVYQI@bootlin.com>
Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Minas Harutyunyan"
 <Minas.Harutyunyan@synopsys.com>, "Alan Stern" <stern@rowland.harvard.edu>,
 "Louis Chauvet" <louis.chauvet@bootlin.com>, =?utf-8?q?Herv=C3=A9_Codina?=
 <herve.codina@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-phy@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-usb@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "linux-phy" <linux-phy-bounces@lists.infradead.org>
Subject: Re: [PATCH 0/2] phy: rockchip: inno-usb2: fix gadget mode
 disconnection after 6 seconds
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Kishon Vijay Abraham I" <kishon@kernel.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "William Wu" <wulf@rock-chips.com>
X-Mailer: aerc 0.20.1
References: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com>
In-Reply-To: <20250722-rk3308-fix-usb-gadget-phy-disconnect-v1-0-239872f05f17@bootlin.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On Tue Jul 22, 2025 at 10:43 AM CEST, Luca Ceresoli wrote:
> The USB OTG port of the RK3308 exibits a bug when:
>
>  - configured as peripheral, and
>  - used in gadget mode, and
>  - the USB cable is connected since before booting
>
> The symptom is: about 6 seconds after configuring gadget mode the device =
is
> disconnected and then re-enumerated. This happens only once per boot.
>
> Investigation showed that in this configuration the charger detection cod=
e
> turns off the PHY after 6 seconds. Patch 1 avoids this when a cable is
> connected (VBUS present).
>
> After patch 1 the connection is stable but communication stops after 6
> seconds. this is addressed by patch 2.
>
> The topic had been discussed in [0]. Thanks Alan and Minas for the
> discussion and Louis for having found the 1st issue, leading to patch 1.
>
> [0] https://lore.kernel.org/lkml/20250414185458.7767aabc@booty/
>
> Luca
>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Anything I should do to move forward with this work?

These two few-liner patches solve real-world bugs, there is no complaint
about them, and both the bug and the solution is explained as clearly as
the public documentation allows.

FWIW, this series applied cleany on current master
(v6.18-rc2-8-g6548d364a3e8).

Best regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

