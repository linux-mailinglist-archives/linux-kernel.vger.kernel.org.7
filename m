Return-Path: <linux-kernel+bounces-822313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5652B8383F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C651BC4853
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1468D2F532C;
	Thu, 18 Sep 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n/hG5ToT"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177312F3629
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184013; cv=none; b=H4fiGCAJGLGCvI9AcY4XLtT8GptYYKMtzxuCZ3PsKoxuF7Eb1PZyYXEWrrOIZZmSpLR7/xunLpHDxYZ1xO9YJiufM4UDOmQi4yQqXEzEx0l/8fQ3gcEPfypHgpaROqQ5VlCGf2sCnStPhDX5cK3DS80+gAbpKbNlWcj+XgMUKw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184013; c=relaxed/simple;
	bh=pUdkfqAw9H4Plnx5hhoqT5kj2u5bikzVgOINNDNhwH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OYsjXLDzujo3BiVo6mjMRHRO2d2aEOFyL3Uw8zbcZyjbnZSYftd+rsph8IebGpJOLz5w2TN41zDBtZ4xz+C+14rOsJK4wXE5BaIopd7QqOoqBDkDd6wpndUE5UEzRMFOXrdoMtiOo4AItdfnNuxmWMD6RD4oVSoAGOp0kvSQdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n/hG5ToT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B2850C00084;
	Thu, 18 Sep 2025 08:26:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43EDE6062C;
	Thu, 18 Sep 2025 08:26:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FEEB102F1A63;
	Thu, 18 Sep 2025 10:26:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758184007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5IaPwRTM0oie4mB87Ujle/rv2fSoo8Z+ofAqYkKA8w4=;
	b=n/hG5ToTC5xO91+v33o6k85Yp5PDW9V9Dfxe4ur8vZGY39yQW5x5QQAg0IdOl/XZ7Oz526
	r/+qZjqfFtLivvw0L5f1VDiujxxTkliPFox8qvPJABx0qyhXuAY1LS1c8O9NDhPnuq4cH8
	QauL3sL3q4kT6U2xStRr2AF5L86eLXukaTP2DEyjeoDHWH6HFA1W7vm2jYTsz1LyurNB5d
	eosKe7CRKCNqrgxU5meG+LLxUYC6MG0dleO8JD0wcY4XQNZOLpj9jd7o7g8TIHWmS6jpZs
	125oSW/iVmSmLP31oqTPP9NmHuuJU0d0qWO5rF7glQlDZXLYG0DR0QmbLu1qFg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Tudor Ambarus <tudor.ambarus@linaro.org>,  Martin
 Kurbanov <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH RESEND v5 0/3] mtd: spinand: fix continuous reading mode
 support
In-Reply-To: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Thu, 18 Sep 2025 00:53:58 +0300")
References: <20250917215401.19132-1-mikhail.kshevetskiy@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 18 Sep 2025 10:26:28 +0200
Message-ID: <87h5x0180b.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Mikhail,

> Changes v5:
>  * rename spinand_create_rdesc_helper() to spinand_create_rdesc()
>  * get rid of controller_is_buggy boolean

I received patch 0 and 1 over 3 only. Plus, what is the reason for the
resend? This series was no longer in my watch list which means I was
probably expecting changes on it, which would have lead to a version
increase. Can you please clarify?

Thanks,
Miqu=C3=A8l

