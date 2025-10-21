Return-Path: <linux-kernel+bounces-862541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA823BF5901
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892CB18A7846
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E692F6933;
	Tue, 21 Oct 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YfPu/PPl"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3E231845;
	Tue, 21 Oct 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039735; cv=none; b=h/mXmkEa0NIxguFqqnTJVnFi3oTApNXPOq3cCVjVE3/uhKls5pNWcPbILz1XWLCt4v/aL0BbLEGUR9hmNl3tFkwhk92WucrpPgvHWoGo3l8pbtV5bvq9ZyIlR8JP2D0GUA6tFAAVXWrNegBLYt3wYEP6n0upyZFr74YEbgJBsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039735; c=relaxed/simple;
	bh=B3Jy7cA+N4KH4QnWIOx/sol3r3bRZVymO5EXRRR8cSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5RP/Bm44SEHnvcVva8DTBN7yZaNOhZYcsfML3J9RPe32XHnaa/uLAaWVIsDwaVCnLzmc4Pbb0/WH3CFD8ka/+EC3tB8Qp7VcouzEzgJ/McR16gvHf6ehyvBDeuBOwhyOayXxkTVOko9zSAzgdkBWHVWxtT7PH6eSl7Yi3Nawkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YfPu/PPl; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id EB6942125B;
	Tue, 21 Oct 2025 11:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761039265;
	bh=8o+wETYksP8ccjEosz8Cbz5sDcAm+lKn1MXus85N6hk=; h=From:To:Subject;
	b=YfPu/PPlq2HCEYCkZ6DMBbfM0yvF6ZC7n12d9hkKdj1MW9iFrUpGbN65nH0cIiBv5
	 7g9HNVFSTM6pKIk+d95YldohlYU6EfMAPBOgbGMVJRp7T0C86mFnTpfUDxI0VJIT5h
	 yTQD8LLRTku7cjc8PtWy0zOQum5BXOFH5Y+Z6zrXwcOy2wWPGksj8QCK/ZIAK4x9si
	 c/2knDKelHt2/GZva+si3bcwSwa4sjZflo1rrU6vuGbV7rZoCJYN2D/wS/kKb3tjHY
	 NSdliuWB8h9HyN7JwSfMiQ8sYo9r4hkLvNhB4zAN8cwQ4vj1oz3Eo6cHiKWw6MaNZm
	 7KZrWVWc24MRA==
Date: Tue, 21 Oct 2025 11:34:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Hiago De Franco <hiagofranco@gmail.com>, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com,
	jm@ti.com, d-gole@ti.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Robert Nelson <robertcnelson@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Logan Bristol <logan.bristol@utexas.edu>,
	Josua Mayer <josua@solid-run.com>, John Ma <jma@phytec.com>,
	Nathan Morrisson <nmorrisson@phytec.com>,
	Garrett Giordano <ggiordano@phytec.com>,
	Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
	Max Krummenacher <max.krummenacher@toradex.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Diogo Ivo <diogo.ivo@siemens.com>,
	Li Hua Qian <huaqian.li@siemens.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Baocheng Su <baocheng.su@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] Suspend to RAM does not work anymore with
 k3-am62-ti-ipc-firmware.dtsi
Message-ID: <20251021093420.GA28462@francesco-nb>
References: <sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l>
 <e60dd8d6-2bd5-41f0-bf8a-b0a5822a7f88@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e60dd8d6-2bd5-41f0-bf8a-b0a5822a7f88@ti.com>

On Tue, Oct 21, 2025 at 02:33:10PM +0530, Beleswar Prasad Padhi wrote:
> On 20/10/25 19:47, Hiago De Franco wrote:
> > DM R5 sends a message that is never consumed, since no firmware is
> > running on the M4 (the core is offline).
> 
> 
> May I know why you are not running any firmware on the M4
> rproc? If the intention is just to run the DM R5 core on the SoC,
> you can disable the IPC by NOT including the
> "k3-am62-ti-ipc-firmware.dtsi". That was the motivation for the
> refactoring.

Verdin AM62 and AM62P are generic SoMs, that can be used for a multitude
of different use cases. And not having anything running on the M4 is the
default use case.

I think having the node in the DT is the correct way forward, if you
want to start the M4 firmware you need such a node, so this is enabling
a valid and useful use case.

> List of suggestions/solutions in order of preference:
> 1. If no intention to enable IPC on rprocs:
>       Do _not_ include k3-am62-ti-ipc-firmware.dtsi
> 2. If intention is to enable IPC on rprocs:
>       Make sure rproc firmware is available in rootfs.
>       rproc would boot up and consume the mbox
>       msg, suspend would be successful. Tested this
>       on TI AM62x-sk with commit 1d6161617c, works
> 3. Add support in mbox driver to flush the pending
>     queues.

2 is not applicable here, and 1 to me is not a good solution. So this
means that we need #3.

> > #regzbot introduced: 1d6161617c
> 
> Would not see this as a regression, but rather a new
> bug for the omap-mailbox driver...

As a user this is just a regression. It worked fine before, it's not
working anymore now.

The fact that the solution might not be in the same file that introduced
the issue is not a reason for this not being considered a regression.

Francesco


