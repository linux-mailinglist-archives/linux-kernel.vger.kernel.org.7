Return-Path: <linux-kernel+bounces-768648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD8B263B2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D9F3B244B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518222EE29B;
	Thu, 14 Aug 2025 10:55:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F52318132
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168930; cv=none; b=HEjH3TWDCVT6YAaOHVqvXE2kBT3jKelpcZo3qTS++M5T0l0M6PxdDeY4yRI9ZowA4w9dv0z1uw70xl2EKv9RgTU7BJiRQfZ7W1YXIzs7y7IfzwfJL6j+HoDqQGaXOi705ffFw3RO+Dbbs3MrCrsQAacXowlZm5YfJf5ZR9JcudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168930; c=relaxed/simple;
	bh=Xw/wvjyGGGJpJehEehnMN6+VyYYeWU5bXA0uZKnhym8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BNwqzgLRyFsbZw8VscEUSI5ZVSayWDBLJubIArG6L+eO/a6/wtjElYvgfYOG2ACwd36OnFXUm+Kcqo64wPx9qYyzVBpNxTW3rP9mESGPqv7K6Jq/m2zpV4WaFJ+g8PivWYIGIdJ3v0gwIaAs2ctya8WX/R8vdiNpOB95VmFSmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcF-0001SU-L3; Thu, 14 Aug 2025 12:55:27 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcF-000EyD-0x;
	Thu, 14 Aug 2025 12:55:27 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcF-000Hv1-0j;
	Thu, 14 Aug 2025 12:55:27 +0200
Message-ID: <443a4855d626a0d5c63d9db7ee25785563050d17.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] MAINTAINERS: Use https:// protocol for Reset
 Controller Framework tree
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 12:55:27 +0200
In-Reply-To: <20250728095237.494132-1-p.zabel@pengutronix.de>
References: <20250728095237.494132-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mo, 2025-07-28 at 11:52 +0200, Philipp Zabel wrote:
> Use https:// protocol, the git.pengutronix.de server does not support
> git:// anymore.
>=20
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied to reset/next.

[1/2] MAINTAINERS: Use https:// protocol for Reset Controller Framework tre=
e
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D8d81298d87f4

regards
Philipp

