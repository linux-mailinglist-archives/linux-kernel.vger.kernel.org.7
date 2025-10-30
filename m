Return-Path: <linux-kernel+bounces-878260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D96EDC201D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 860FF34EDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439103431F6;
	Thu, 30 Oct 2025 12:56:10 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2C0343D67
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828969; cv=none; b=ROoWmYmKSU+RQJosJI+NBzkjeLORtK2wdD3i+BPlD+ITaMfmNZC1u5ksMIreOkV4nrFnSyuFfIB7zmgAi5J9qZgVm1ZIJ4dNpuOn7LvvUAtI13g+cmz1A7hkZvtTxj/w+9b7jXXgY1pvEtbtPyW4VmoQH+ZFHdsoCLMhvC0X/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828969; c=relaxed/simple;
	bh=KQbToFNxIKZEOav2WExySd4IM3YdWRMB+9fwi/1SJSU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/Az44yBAn7S5rn3RIWNqoIOAl1HlQjEjAxKA1QtufzxEW1ZmFPh8BizHWk+hZqOb+pyiFOV5hyxsBBmXuOynUlegG5ny+UBC3rNc8PQh8TdsZlmWREgl+sXaHdgGjqwM1k+LiLnMmgiwR0rnx5UGUfE6J5Y94nWmBtymKL/+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBz-0004nE-8s; Thu, 30 Oct 2025 13:55:51 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBx-006DFj-09;
	Thu, 30 Oct 2025 13:55:49 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESBw-000000009Jt-3zT9;
	Thu, 30 Oct 2025 13:55:48 +0100
Message-ID: <845f360bb63bf3db5a57f90a5c474271a7194d9a.camel@pengutronix.de>
Subject: Re: [PATCH v3 0/5] Add reset controllers for other TH1520 subsystems
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yao Zi <ziyao@disroot.org>, Drew Fustini <fustini@kernel.org>, Guo Ren	
 <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley	 <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Michal Wilczynski	 <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>, Han Gao
	 <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Date: Thu, 30 Oct 2025 13:55:48 +0100
In-Reply-To: <20251014131032.49616-1-ziyao@disroot.org>
References: <20251014131032.49616-1-ziyao@disroot.org>
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

On Di, 2025-10-14 at 13:10 +0000, Yao Zi wrote:
> TH1520 SoC is split into several subsystems, and each of them comes with
> distinct reset controllers. We've already had the one for VO subsystem
> documented as "thead,th1520-reset" and supported, and this series adds
> support for others, including AO, VI, MISC, AP, DSP and VO.
>=20
> For TH1520_RESET_ID_{NPU,WDT0,WDT1}, these're reset signals that have
> been introduced along with support for the VO reset controller. However,
> registers in control of these resets don't stay in the VO reset region,
> instead they're AP-subsystem resets, thus the original ABI is
> problematic. I remove them in PATCH 1 and reintroduce them in PATCH 2.
[...]

Patches 1-4 applied to reset/next, thanks!

[1/5] dt-bindings: reset: thead,th1520-reset: Remove non-VO-subsystem reset=
s
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D68ce5ac15ff8
[2/5] dt-bindings: reset: thead,th1520-reset: Add controllers for more subs=
ys
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D76001d5d3cd1
[3/5] reset: th1520: Prepare for supporting multiple controllers
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Dac3d323caee8
[4/5] reset: th1520: Support reset controllers in more subsystems
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Df5da5084e282

regards
Philipp

