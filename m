Return-Path: <linux-kernel+bounces-892635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF43C457F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1A1188A391
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562BA2FC896;
	Mon, 10 Nov 2025 09:03:34 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB92F83BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765414; cv=none; b=TZNLUWXUQa2RG2J1SKc32MhT58momVzcqyk/4hjcdUfxCyx+TCj3DDITgl2JqAN0bAtkKldsShzuTJ8l3V/xOHe0pJ9rqwKa+a/GHWCNpmSOnBT+cthj4b33tAmownius4KEpj7FceC5NW7wi3FI9Yc7Ejd1eumHOfC2cs4AWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765414; c=relaxed/simple;
	bh=pSdqTcO76SLf+ieSPI/7/KBN+zgZ3jmlRkgvs+drUH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ot9R7UOTbZuT3HipIwCPhTZw1M7yssbcDMOuHqH0qq/TVEEU5aNJHx/xkABWekoXbQhePePsDrfETxlhyM+9L6cPT0ftQg2KycXLfp5CiZ/3TMpEzk3cRTfv7zXlqwvtQer2bq8X9hHldbjCQ9EH1QZyLDOp815sQCjosg3u9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINo9-0002CV-W2; Mon, 10 Nov 2025 10:03:30 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINo9-007zaw-26;
	Mon, 10 Nov 2025 10:03:29 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vINo9-000000005KM-2Q9j;
	Mon, 10 Nov 2025 10:03:29 +0100
Message-ID: <418b2ecced5fae262030dd3f8b3947ec9525f15f.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: fix BIT macro reference
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Encrow Thorne <jyc0019@gmail.com>, Troy Mitchell
 <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 10:03:29 +0100
In-Reply-To: <20251110-rfc-reset-include-bits-v3-1-39614338fd43@gmail.com>
References: <20251110-rfc-reset-include-bits-v3-1-39614338fd43@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mo, 2025-11-10 at 14:10 +0800, Encrow Thorne wrote:
> RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> include bits.h. This causes compilation errors when including
> reset.h standalone.
>=20
> Include bits.h to make reset.h self-contained.
>=20
> Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>

Applied to reset/next, thanks!

[1/1] reset: fix BIT macro reference
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Ddae9b0708255

regards
Philipp

