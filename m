Return-Path: <linux-kernel+bounces-897272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F86C52797
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF0294F1648
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0EA3375DF;
	Wed, 12 Nov 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tKjdv4xa"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9E307AD1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953627; cv=none; b=gynUhgn2cw6XfbOzHBToyM9+zo3LNx1Bds+KeXm0ttIDClZcomWwRvv+Ex7PmgpzOTozzX4jdO0+9oyl7OkKLkczpLeoPpYMeeQH1kLkpsgIyjLQgV+BkwW9+yUQ78+F1euNg4ExNe672DZsLHiev6/ngBu31Qf0/6/pdGtuIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953627; c=relaxed/simple;
	bh=kRvzfLSghU97RsZ9VRn57pOnmWGulGRlWRhPle43nrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfsLiRE3oi7LcC6INylbAT0e9KNg70D/c2S7nO7KOHiGD9C+SPBhBCLbfVIiNEa777liI9ImmSvNk4ON67e8czmSnRjvJf1Xg5XCmPFxOQqP9I9/IlLjDs0DHGqyZ5pXYeZkejfOyoiNJdHceo6TAQMQtW8EzIYw+z3kA1HXz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tKjdv4xa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7F497C0F556;
	Wed, 12 Nov 2025 13:20:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 022906070B;
	Wed, 12 Nov 2025 13:20:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 533E2102F17ED;
	Wed, 12 Nov 2025 14:20:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762953622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J3GPCyka1JrH8xTfmJa7EWc+LLH2H9CUm6CgICF/k0Y=;
	b=tKjdv4xa+/xNCd9tfVthaZ4rJSsc8mIjhW/2SSt7MHd8w/R2sCLLL3YRhm50gLxkKzI2FX
	1rU6LA8Z/l6GpofcGTlyRcUlUQMBtAghoD1uOk40pWZ/dFtF9CjUgBGZZbnoLy13+8+KHv
	xKYm/L2LP8h5GAP/FrIPRcUuwA6RokE1+FKkjN6NGEgMGqBYs5QVkii6LBtUtPPE85e5FQ
	MX2ksmC2dpoYez0F935LGdKKFGUSAB3H+/gnHPU026iDtFwzRjXWvoCDrp1wzQhs/7jIQn
	OKoO2oJGFabYh4YrMeCbd5r5BQ2UBUL8ziafg8A7eNlLNDnE4ZQ2+jUqQU7oaA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <871pm3iegf.fsf@bootlin.com> (Miquel Raynal's message of "Wed, 12
	Nov 2025 14:10:40 +0100")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<mafs0ecreontu.fsf@kernel.org>
	<4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
	<mafs05xcpo9sz.fsf@kernel.org>
	<26a795ac-e6ff-4363-a8b9-38793a9be794@linux.dev>
	<mafs0ikgnn07u.fsf@kernel.org>
	<d00d42ce-4262-4736-8c73-5d2544e86d33@linux.dev>
	<33cbbac1-c247-4644-b555-998eea6e8305@linaro.org>
	<92e99a96-5582-48a5-a4f9-e9b33fcff171@linux.dev>
	<871pm3iegf.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 12 Nov 2025 14:20:19 +0100
Message-ID: <87v7jfgzfw.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

> When you run "# flash_lock -i /dev/mtd/by-name/spi0.1", you privide no
> start/length values to the command. Hence, the defaults are picked: the
> entire device is considered for the check. The tool asks the kernel
> whether the range 0-0x7ffffff is *fully* locked. Answer is no, it is not
> fully locked.
>
> In the kernel there are two helpers for that, and they won't give you
> opposite results all the time:
> - is locked:
>     - returns true if the given range is fully locked
>     - returns false otherwise
> - is unlocked:
>     - returns yes if the given range is fully unlocked
>     - returns false otherwise
>
> So if you want the tool to tell you "yes", you should instead use the
> exact range you locked (1024-2047) or any subset of it.

I forgot to mention: I don't like this interface because it is not very
user friendly, but this is uAPI, so set in stone. As part of my journey
in the SPI NOR swp.c file, I wrote a debugfs interface to help
visualizing what is actually locked. It is absolutely trivial to do and
helps a lot. We might want to use that for writing some kind of testing
procedure =E2=80=94 I will share it soon.

Thanks,
Miqu=C3=A8l

