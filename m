Return-Path: <linux-kernel+bounces-862706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2284BF5F2E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2828A19A053E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364462F362F;
	Tue, 21 Oct 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OtoMAP7n"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3212F2619;
	Tue, 21 Oct 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044839; cv=none; b=snfDXdQP2bTmhW8iMdwAPgndyWS1+9nf9Xpwy4MaypkXYLLY6orkcMyQS0BICuMP+4TynRUsu4qiUKDT00+fX6Po7xGRhkSYq2f54Gsh29pxYC8KOLfsUKdAnAC33fF8onhifqpydQMFQipdLEi5Y21PTuJRkaGL6knLfAS3Mp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044839; c=relaxed/simple;
	bh=n9l01WVOdLYsNtWLeGEEkur1oK8Lb6bJ3MmOA1JZiig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWFzQLHhO+RLjDw49eeSDaVp9ATlmiNwdYzI8LCZNPj1877NMLMqPU0UDBeXzipOyqcREs+jKLzULFH7NbdDfHXBmGXMTyqoeGeMvLKW8Bdfb22DQTfHXN6+bU/hfFjNVwI8I7ScQcclNX0iA39ky0HbmtXT2oP+YSStuyRw0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OtoMAP7n; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 03BB61F83F;
	Tue, 21 Oct 2025 13:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761044835;
	bh=Pwk8DjJA8z0oysJkbtvk8bhihXS0Rs1EqYDINNJtUYQ=; h=From:To:Subject;
	b=OtoMAP7nFhJluGnIc3sDNdXjGWYpJaez2TDKP0ZmPxYsijtx3eHfzWXyvZMYXox6T
	 nz5KMvxUbJlLumhO/ydCbevrpqttlVuWEZrGcy86glWsMeY2HPqEMwFGtda1VL1Ovw
	 VWHYcACHoezmtNDUaIDeCrVyRA+SvporIMJoAfcmJe6yaLdbDRXQJxD3uOvm+loVYb
	 npNGjPMXuvne9ZPSg7N2I4iWgzDC4XkYtyF6I7ZNfrlZV9VKN7ddFvU00HRo1vr/6C
	 y+THkqeb6aaYN6ExTXihWGWvyVzneq/aoOL6f1BBgsUvVgFt6KByfva+pJLk3fLmMA
	 TwuD1njbb8LSw==
Date: Tue, 21 Oct 2025 13:07:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiagofranco@gmail.com>, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, afd@ti.com, u-kumar1@ti.com, hnagalla@ti.com,
	jm@ti.com, d-gole@ti.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Robert Nelson <robertcnelson@gmail.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Message-ID: <20251021110710.GA40034@francesco-nb>
References: <sid7gtg5vay5qgicsl6smnzwg5mnneoa35cempt5ddwjvedaio@hzsgcx6oo74l>
 <e60dd8d6-2bd5-41f0-bf8a-b0a5822a7f88@ti.com>
 <20251021093420.GA28462@francesco-nb>
 <cf10f312-3ba1-4226-96da-d2c9a149c1c7@ti.com>
 <1a849a0b515c77faebe28456d6537d39d4ca32d0.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a849a0b515c77faebe28456d6537d39d4ca32d0.camel@ew.tq-group.com>

On Tue, Oct 21, 2025 at 12:06:32PM +0200, Matthias Schiffer wrote:
> On Tue, 2025-10-21 at 15:26 +0530, Beleswar Prasad Padhi wrote:
> > On 21/10/25 15:04, Francesco Dolcini wrote:
> > > On Tue, Oct 21, 2025 at 02:33:10PM +0530, Beleswar Prasad Padhi wrote:
> > > > On 20/10/25 19:47, Hiago De Franco wrote:
> > > > > DM R5 sends a message that is never consumed, since no firmware is
> > > > > running on the M4 (the core is offline).
> > > > 
> > > > May I know why you are not running any firmware on the M4
> > > > rproc? If the intention is just to run the DM R5 core on the SoC,
> > > > you can disable the IPC by NOT including the
> > > > "k3-am62-ti-ipc-firmware.dtsi". That was the motivation for the
> > > > refactoring.
> > > Verdin AM62 and AM62P are generic SoMs, that can be used for a multitude
> > > of different use cases. And not having anything running on the M4 is the
> > > default use case.
> > 
> > 
> > If not having anything on M4 is the default use case, it should
> > be marked as "status=disabled" in the DT.
> > 
> > > 
> > > I think having the node in the DT is the correct way forward, if you
> > > want to start the M4 firmware you need such a node, so this is enabling
> > > a valid and useful use case.
> > 
> > 
> > Having the node is fine, you can still choose to keep it
> > disabled by default.
> 
> I agree with Francenso that it would be nice to keep the node enabled by default
> - whether something is running on the M4 can be controlled via sysfs after all,
> and may change over the runtime of the OS.

In addition, from what I know, this is required even if you want to
to start the firmware of the M4 from U-Boot.

Francesco


