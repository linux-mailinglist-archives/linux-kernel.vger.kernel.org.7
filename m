Return-Path: <linux-kernel+bounces-878254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D246C201C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 301D54EAE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F0E35503C;
	Thu, 30 Oct 2025 12:55:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE8F35471A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828904; cv=none; b=StdD3Ys0Xwxb01CjtjRs9XN37BYfvEtTIIxZwv+KgaSQLcQNWW0tarJG8u2fCa2w9wS3fEUZt8jtyLu1f+tMmEYm500RD1qI9FPNasmUeELquyCkfnBqR2NBdtBCg6zjfV1Ri2+HrKHTTsw+CSEVVUpAYvOlnIJLbG9AxKcUhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828904; c=relaxed/simple;
	bh=Po6b7mw3FBhvhgqPrfJ2LP2ZcFjOTAafBEccsvNf/3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NzgdsDqfJVsM5EPuM6yuHEyOMfxi7f8m8J13lj+B88/JdhzvtOBSh/VKoGMskU5Wm7MUZgjoxHTyl0m9Y1EUNZksJgECIK6o6f6AAWHae5Eo3dnG1/DU3e4/tKTBHYpxRkunFq41VVQCjEBjWdyyfuvLMgMh5Bo1priGqmlWHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAy-0004fI-VK; Thu, 30 Oct 2025 13:54:48 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAw-006DFP-2i;
	Thu, 30 Oct 2025 13:54:46 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESAw-000000009BE-3Bi1;
	Thu, 30 Oct 2025 13:54:46 +0100
Message-ID: <ea2a66b778e19dea7609370be0c16f1a440c99ed.camel@pengutronix.de>
Subject: Re: [PATCH v7 0/2] Add driver support for ESWIN eic7700 SoC reset
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: dongxuyang@eswincomputing.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Date: Thu, 30 Oct 2025 13:54:46 +0100
In-Reply-To: <20250930093132.2003-1-dongxuyang@eswincomputing.com>
References: <20250930093132.2003-1-dongxuyang@eswincomputing.com>
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

On Di, 2025-09-30 at 17:31 +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
>=20
> This series depends on the config option patch [1].
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?h=3Dnext-20250929&id=3Dce2d00c6e192b588ddc3d1efb72b0ea00ab5538f
[...]

Applied to reset/next, thanks!

[1/2] dt-bindings: reset: eswin: Documentation for eic7700 SoC
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3De40291127aa9
[2/2] reset: eswin: Add eic7700 reset driver
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Da4c5b6b610d9

regards
Philipp

