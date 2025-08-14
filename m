Return-Path: <linux-kernel+bounces-768086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D675B25CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1320585D86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4B265284;
	Thu, 14 Aug 2025 07:11:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FD29CE1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155500; cv=none; b=MkCJaF8dA5Xh5D0TMBbPsIXOj3N8y5j1yAS0ALiGx+tf4FXFSVBzpqfTJGe8HAHAKFcYUWvZCKsM7YoevWOQAJAN/l9l1YAdCZb6Wh3vqO/wuAV1X61Lz8Yk5uP0sqw/QNBqi4vtvH5ZJYAaDclLoss0uZxnzgE2x8IXL9J/2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155500; c=relaxed/simple;
	bh=TpZELQc4+3aumXfCv2BaVBa9vE2V9E/st6PsIM/RXSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vj7IERKLAOS2I7G9WdcEkqEgFkicRw3dUkkA57m9JxNb7iB0aJ9AsJcJXh/uAsreXO+NOPJpQkYrBfijxUC96LAncNTgDJRXEA6gRp3/B//p9LIGK8IKNrRn5FfpVxC7i0VaciaendcwF5dmUA0LgIvG9fcLN0ZSpQKikP4JKIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umS7G-0005i4-1i; Thu, 14 Aug 2025 09:11:14 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umS7E-000DJQ-31;
	Thu, 14 Aug 2025 09:11:12 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umS7E-0002mN-2m;
	Thu, 14 Aug 2025 09:11:12 +0200
Message-ID: <d256d4a9aed3cca70917391db3b187f73f9be74d.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: th1520: add resets for display pipeline
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>, Guo
 Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi
 <ziyao@disroot.org>,  Han Gao <rabenda.cn@gmail.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 09:11:12 +0200
In-Reply-To: <20250813081716.2181843-3-uwu@icenowy.me>
References: <20250813081716.2181843-1-uwu@icenowy.me>
	 <20250813081716.2181843-3-uwu@icenowy.me>
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

On Mi, 2025-08-13 at 16:17 +0800, Icenowy Zheng wrote:
> The VO subsystem of TH1520 contains a few resets for the display
> pipeline -- display, MIPI DSI and HDMI controllers.
>=20
> Add support for them to the reset-th1520 driver.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

