Return-Path: <linux-kernel+bounces-795966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38722B3FA13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C2B1B200F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057012749D5;
	Tue,  2 Sep 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f7lDmIYH"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70FE3D987
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804825; cv=none; b=FF65dCwV79Uoe8zd3xzSNA9SQsrEHJ2lHb2XD6r0fYOFNpZxDXhVJJb5C1kEvyp9OCLI/r/2Kw+y98rDQPExA96bYYU+E/D8lqfWAQsvwEiNPJbrHH48AD9QCh5coQXiE8wnXcyPkNnLjh8ytP+BTZyDC8Cw3GNaKW3JdF878rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804825; c=relaxed/simple;
	bh=vxkgYmr0na4zwlPowsJWw/T3UMnvYBUEt6gF36I49b0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8ASPta2WInCNNUh6d1TaHHFMXRlH2fmF5F7tGpSWSlRRFwrWejJeTqF+blOyoxd2UWKCES2zip9YU69x6s+/s7g4xW83BskqHicnidw6koTqgIekz0gUIt9OZsYNeUQK5rvSZyBeYMq9DO89D/pu1xq8er6od0praSUgq5zhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f7lDmIYH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7928A4E40B94;
	Tue,  2 Sep 2025 09:20:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37F5360695;
	Tue,  2 Sep 2025 09:20:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D2421C22D61F;
	Tue,  2 Sep 2025 11:20:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756804819; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YOvQGStceXvCa6+9l/nLVbzaS08FnkJ7K2s7/vOvOWg=;
	b=f7lDmIYHp1rBw3TWK91p4NcyZ1pzqRF/rgIW2Ij3Ej4QwRFl4EB38p4rCRLBqbh4Lm7YMZ
	tuR21DOaRaCVfvKta4qZgLoQZ/ID6UAahefrz4VynO2uaYoa+pZuwVJa0q3AzyHIYJNgHV
	FrOaZdO3sdsPhc9g9RxCi1zomXFFe55eR4FkhqDzfH+qHnoI2vaOtjNMvuouqUtZC49SAf
	TTwyE9qDsbwpsCHQRGFF2dbDw9p3ijgDELYXpGnFmMs5ZcOzg/Sp/xNTm9TG//seZdKN/e
	wipYWj/wmKSOAELGWNmAj7YVVDD3izGKhORLvy3Sn9YuqJCMPNmHw++NVX1jEQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  chengzhihao1@huawei.com,
  yi.zhang@huawei.com,  yangerkun@huawei.com
Subject: Re: [PATCH] mtd: core: only increment ecc_stats.badblocks on
 confirmed good->bad transition
In-Reply-To: <732d629c-d1b9-4483-95c3-9a80bd7b2511@huaweicloud.com> (Wang
	Zhaolong's message of "Tue, 2 Sep 2025 17:03:54 +0800")
References: <20250902080117.3658372-1-wangzhaolong@huaweicloud.com>
	<87ms7dntlb.fsf@bootlin.com>
	<732d629c-d1b9-4483-95c3-9a80bd7b2511@huaweicloud.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 02 Sep 2025 11:20:02 +0200
Message-ID: <87zfbdmcsd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

>> Said otherwise, the { while () badblocks++ } block shall remain outside
>> of the if (_block_isbad) condition and remain untouched. Just bail out
>> early if you are sure this is not needed.
>>=20
>
> I=E2=80=99ll send a V2 shortly that:
>
> - Checks old state when _block_isbad exists and bails out early if alread=
y bad
> - Otherwise calls ->_block_markbad() and increments the counter on succes=
s, with
>   the increment left outside of the conditional as you suggested

LGTM.

Thanks,
Miqu=C3=A8l

