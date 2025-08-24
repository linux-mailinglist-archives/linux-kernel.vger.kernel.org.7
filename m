Return-Path: <linux-kernel+bounces-783705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6CEB33173
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C27188DDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177B1F2371;
	Sun, 24 Aug 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GJUo5aHQ"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3535963
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053070; cv=none; b=WsjgYdmECYmB3qIQ+HS8fUHiqDNIRRiksiZ+ltdQvAn7lFzVTTr4RD31u3kDTh8AODQyxWmnI/wxXEUg2wgkSBQX0dpLrGjXoZUrOeG416HAyHZBu9mUP77tPHEp9aOl+UqQTqxUIoANTk0ayPX9T90xCsNMGWpxWyBRMjt6DtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053070; c=relaxed/simple;
	bh=Gn7KbLvYVMKJjjXjrXuVd3D0X74qDKII9qi+DZSlr3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=olKZ+vAJ+/2aTM4MTeTh2FF56f0x61uAG4B7q63u0CDcK7oTVv7P3ShLOl6Unqk5ksva6Idmv3KKuNAvsqK60lhZOTt5wTR7iP/djK29yJOHT53gl92H+hZfDIGYx/iKBgB2Xj9lmTXPGmmfGRGWCskMY6ewmC2gZv+YBtEp/4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GJUo5aHQ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0C47B4E40C0F;
	Sun, 24 Aug 2025 16:31:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEC49605F1;
	Sun, 24 Aug 2025 16:31:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7037F1C228A68;
	Sun, 24 Aug 2025 18:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756053063; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Gn7KbLvYVMKJjjXjrXuVd3D0X74qDKII9qi+DZSlr3Y=;
	b=GJUo5aHQQnmkLiRWxkYrY+HJGhs9t/dxJcmhFtp+22CfaWBiZ+7lpHesFzTPxanVsmttFC
	Yzx79I/6fG9X4+HKif7WubdzJj5mB7WMvVItMJBqraRQ3EWISz0R0KziM4fyyvWeXn/NEu
	7iDYvScbXsuSPQbMgJz5QG6XGKUL8/Q2/g1DI2HdNNH0dbHabsoxrC9Zywbxwx6rco9fS+
	tGB8/++Jc+eNisi9fnqy7+tuJk9WLQuLNf1KnyrsvUycoa1WhY4YcsBlXd1mGlf12Mzbz9
	jZVmGQ8+ssLYw1VX5119SyQ/V3AfPwQAc+4YrTjEN43XTMNGtOq/W9GO0HrpPw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Teng Wu <gigadevice2025@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  teng.wu@gigadevice.com
Subject: Re: [PATCH] mtd: spinand: gigadevice: Add continuous read support
In-Reply-To: <20250818135227.2114-1-gigadevice2025@gmail.com> (Teng Wu's
	message of "Mon, 18 Aug 2025 21:52:27 +0800")
References: <20250818135227.2114-1-gigadevice2025@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 18:30:51 +0200
Message-ID: <87349gisw4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Teng,

On 18/08/2025 at 21:52:27 +08, Teng Wu <gigadevice2025@gmail.com> wrote:

> GD5F1GM9 supports a high-speed Continuous Read (CR) mode which allows
> the entire memory array to be read out by a single read command
> without re-issuing the 13h =E2=80=9CPage Read to Cache=E2=80=9D command f=
or every page.
>
> Datasheet summary
> Feature register B0[3] (NR bit)
> 1 =3D Normal Read (default)
> 0 =3D Continuous Read (CR)
>
> ECC status register 7Ch
> Normal read: bits [3:0] =E2=86=92 ECC status of last page
> Continuous read: bits [7:4] =E2=86=92 accumulated max bit-flips over the
> whole sequential read operation.
>
> Datasheet:
> https://github.com/WT-886/DATASHEET/blob/main/GD5F1GM9-v1.0.pdf
>
> Signed-off-by: Teng Wu <gigadevice2025@gmail.com>
> ---

I am happy to see more defines benefiting from this feature! Would you
mind sharing the result of a speed test?
`flash_speed -c10 -d /dev/mtdx`

Thanks!
Miqu=C3=A8l

