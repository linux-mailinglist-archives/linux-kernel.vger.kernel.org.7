Return-Path: <linux-kernel+bounces-886822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05336C36AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F73647B64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F883328F2;
	Wed,  5 Nov 2025 15:51:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A132ED58
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357898; cv=none; b=I0VrXA2wQL6RIFWL51dEg0f+75Lwr3+5Ar/fIFS0vzoYHTo/T02hJ9hWUza4P1NpSvnw7RTGJcL9HlTdeIMXb0JiuxeWADBCIfDPcVCR77ALwpN5SFkKC7L8jKQVhHVv5w3PUzSBWdKnXYGhU8+kdupZmm9A1pGB+I5782WkEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357898; c=relaxed/simple;
	bh=ExVoHviwGuncCL/fZYfdyWNDwKaSCBJjDfYTRWzde5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D4NBRAZtqGlGP3yXVVc+AP0EwI0MEpPc+7Bm4i+40KB1OYHRdxESFMEE3dHKxGxVnBpGvzYsf4BnH60niI+i4rbQ2MfNTNkOFzcGUk5pPXAL+79gaiSwLLdxmCa/RU46x/6xjVRVV2VycWVQJJ4qOWia1LCg9gglfhadwvF4Y1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfnK-0007hp-5G; Wed, 05 Nov 2025 16:51:34 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfnJ-007DjI-2v;
	Wed, 05 Nov 2025 16:51:33 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGfnJ-00000000CRo-3Wyf;
	Wed, 05 Nov 2025 16:51:33 +0100
Message-ID: <1ce72e929f8f6c691faaf548a05b0eab2b9b1630.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: fix BIT macro reference
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Encrow Thorne <jyc0019@gmail.com>, Troy Mitchell
 <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org
Date: Wed, 05 Nov 2025 16:51:33 +0100
In-Reply-To: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
References: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
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

On Mi, 2025-11-05 at 23:40 +0800, Encrow Thorne wrote:
> RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> include bits.h or bitops.h. This causes compilation errors when
                 ^^^^^^^^^^^
Troy suggested "or bitops.h" can be dropped.

> including reset.h standalone.
>=20
> Include bits.h to make reset.h self-contained.
>=20
> Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.

These should be replaced with a short description of the changes
relative to v1.


Otherwise,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

