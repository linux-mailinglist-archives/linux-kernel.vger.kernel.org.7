Return-Path: <linux-kernel+bounces-758775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F35B1D3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC07F580D53
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF823F405;
	Thu,  7 Aug 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="azPK9rMI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE255FDA7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553283; cv=none; b=pGtrvZQF8S+I5r+Luo9u0dPZlCGdJJMUMUnhKe9NQzc+A6AnVh6+o8MU+mDNZssaBHS1dkpz4+bPqy/zb8inTkBZkpVbyqPdOzW5ws6s1tdqq7KpOVyNt3RIop4/JW6k8UOil17Pei4h53mXpckPTRUPp2+ossfxNCmtwFRcEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553283; c=relaxed/simple;
	bh=AbBx+g64e2vm8iLodl8ltBApZbqC2ncTbIPhItXlekw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E5e06w7FtXnll8ExLCEAk/2XfC4O2wyVJ0LJhLqjuBg9qbzzQbaFw/O1i3mWkl/hY6kU0AcRXk9RioVeulxwZ6B/9aye0JmMtubpQVYtZleLGS28c2+IJCRFgUDCXtOqODh7CsNpsspYXAGCQzX5B1kZ2fyo5DGLRmfeso5lsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=azPK9rMI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A525B43A2E;
	Thu,  7 Aug 2025 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754553279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDmxvPaKvO37Q4y8VV8Ok02yCaO2ZekBLC2D6ZLqovQ=;
	b=azPK9rMIk4n6o+7Qf7kWoocNwZDbWAjw7Ar2zFK9KMScCejZ8Gmxp034nkJmHsbr2gaK+m
	QzvXY8rAoQ6mQ44V8CQnRLJv8scm0Cd9qsdBMWXTaec1DWu7sltyjUQ6Wt7O1RWyZxR5he
	t9nnZJs3QWNh6dgzErvxSwwVnZz99zPgOeOZ4GcW6GRieyFj0lzb1JV2CSFXytfxea9O03
	ZMLde9v7HXd0IwNEaCcNuWab7rdM5707SORFzHoB1/5G9Dn4y8d5YY7AkGnWbx1EDbAliv
	i5sq5Qm5AYNMRitWF9e9G8s0phE7z6+oZFqiXAGRz5M67ruoDk8/q2Q6zG3Cqw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Nathan Chancellor <nathan@kernel.org>,  Arnd Bergmann
 <arnd@arndb.de>,  David Woodhouse <dwmw2@infradead.org>,  Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: dc21285: fix bytewise memcpy()
In-Reply-To: <20250807072044.4146480-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Thu, 7 Aug 2025 09:20:34 +0200")
References: <20250807072044.4146480-1-arnd@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 07 Aug 2025 09:54:38 +0200
Message-ID: <87o6srd0sh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopegufihmfidvsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepn
 hhitghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthhopehmohhrsghosehgohhoghhlvgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Arnd,

On 07/08/2025 at 09:20:34 +02, Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The commit that split up the 8/16/32-bit operations in 2004 seems to have
> broken the 8-bit case, as clang-21 now points out:
>
> drivers/mtd/maps/dc21285.c:129:97: error: parameter 'len' set but not use=
d [-Werror,-Wunused-but-set-parameter]
>   129 | static void dc21285_copy_to_8(struct map_info *map, unsigned long=
 to, const void *from, ssize_t len)
>
> Put back the loop that was in linux-2.6.8 and earlier for this case.
>
> Fixes: 67d4878e4e61 ("NOR flash drivers update")
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch, I'll take it, but that probably means few to no
people still use it, if broken for more than 20 years...

Cheers,
Miqu=C3=A8l

