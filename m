Return-Path: <linux-kernel+bounces-768651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AAAB26377
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 883C74E56B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475092FD1D8;
	Thu, 14 Aug 2025 10:56:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788FE2FB991
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168963; cv=none; b=WodKMjyhky4PHefYfHT6Mox4AUeO3dTN1oZrK46d5nDAMLTgqJ3mU4wMlQFUh3UHCzCMr6TynbRZA7+Qmc0xVyhKiBVuSQqWAABpedRmJDaT+nobZESDq5fbhUTWUi1psG88BwWlazEKmM0rlsCwQP6bYVeMzCxJ+1oty8N/Uqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168963; c=relaxed/simple;
	bh=Ev6nTniyqvf5QNlY+rf18W4fR/OBBWfAIRWRURDlFyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEsKopHlirSQVEoGGKN0GFYZKogAcQJHfQAchpPS6xd8CZbVkZe/143bFzOs9gBALyDxGiyib9iqN17CsJLZ8Y4d2Wbt5m7Gc+cSDVT6D0HrFSORYAKOmRH0CHjBHSys2XvTptKaF1IOnAZboUZvu1Wxwu1cm5KyXJ0Gfi8v0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcZ-0001Vn-1f; Thu, 14 Aug 2025 12:55:47 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcX-000EyH-2M;
	Thu, 14 Aug 2025 12:55:45 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umVcX-000HwQ-25;
	Thu, 14 Aug 2025 12:55:45 +0200
Message-ID: <8d21aeee5bd111aa010c8e6b8a4870298ac72cbf.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] reset: th1520: add VOSYS resets for DPU/HDMI/DSI
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>, Guo
 Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi
 <ziyao@disroot.org>,  Han Gao <rabenda.cn@gmail.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 14 Aug 2025 12:55:45 +0200
In-Reply-To: <20250813081716.2181843-1-uwu@icenowy.me>
References: <20250813081716.2181843-1-uwu@icenowy.me>
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
> The VOSYS subsystem of T-Head TH1520 SoC contains a set of display
> pipeline in addition to the GPU. The display pipeline contains a DPU
> (display controller), a HDMI controller and 2 DSI controllers.
>=20
> This patchset adds reset controls for these devices.
>=20
> Icenowy Zheng (2):
>   dt-bindings: reset: thead,th1520-reset: add more VOSYS resets
>   reset: th1520: add resets for display pipeline
[...]

Applied to reset/next, thanks!

[1/2] dt-bindings: reset: thead,th1520-reset: add more VOSYS resets
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Df443d7c9ed46
[2/2] reset: th1520: add resets for display pipeline
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dd342031a5238

regards
Philipp


