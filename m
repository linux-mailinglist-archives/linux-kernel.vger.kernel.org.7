Return-Path: <linux-kernel+bounces-764954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFE0B22967
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAA65A0318
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13228507F;
	Tue, 12 Aug 2025 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="lvUjqhfh"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B227FB27;
	Tue, 12 Aug 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006165; cv=pass; b=VeV3URzZbhcEniWIjT5NVJRazeKV7wwyojhr6lugzuSs+NQ6OOJ5so6gWRlHLm2EdwHvCTA2eARWUXcRJtnnOJg+e6M3ACPbsFAuiVbujxE8WFqvLH2JTHleO2bMeBL874KVBRU8WE3/nxqbptT/rxOqzOtPtpzbvubPnvGN6eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006165; c=relaxed/simple;
	bh=VA/IhSA+wElgw/TQpAmNJns2NWQ8O3CCkvUy+PyqOsQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XdsTC53mQnMzpukaGcSIdZQnNp/uJMtLDhiIYdjwE5oQcLM3xxRMxMT0VJjhea0rRuN+p9/KGw9czqrk6g9qejcxptJfZk4a6DeJtBThf6YLtnzli7GWCRAgeUX5sJJ1NUIzSLtvnhUhNl4wxzZ1H/LIhdaS91SYebxWXYjL2E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=lvUjqhfh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755006152; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ob2a/f0eaZdCkypYg4XmY5b8LnjcS5jzNQY8Wclo5TdSrhceyUMocmxn0bkcW5f65So9ut1pn/JU5WWc3W7WiMG3RUbHu/joNlg9JqadynXkD6k91ql301mUqzLY99f2b+fZs203uDCSZ918kYc08zgIqJzUdy7pmnCgS3iktfo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755006152; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VA/IhSA+wElgw/TQpAmNJns2NWQ8O3CCkvUy+PyqOsQ=; 
	b=gd328Pg5XKwKeKvMXDpmob07Vb0f7nFIFU/c2nV1mNLzQbBUwgMTcmWepbg52MqvfF8lD4o2nFvPScY5DGbGxcUyiPxyhDP2ZgCLB+893DAhY6QSncBN5YEEJjUIb6+xWpQRftwCN+b2/JC7Ab/bba1OPKHYIlP/VfV6lHiV+6I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755006152;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=VA/IhSA+wElgw/TQpAmNJns2NWQ8O3CCkvUy+PyqOsQ=;
	b=lvUjqhfh0BPdd0ewTbefpOQPYoD9rafGuCkqLGNeaojQjm7bQwnGfagG/yDm7wFh
	hLIocF23EIbk23cW+rhqo0QzNQ9M/R4JYAGKi/SY0qvceCZFIJUtHxXuTe6R1gVQPH6
	sDM9v3oEMe3RoUXJIHrTaUTAGrAurbov4orvNqaziPkhpaJEzTJa9i47mMSaWHuC6HE
	BgWrZ37mp3xgQCa4vNmWUSg7OIMSdn+coL1DF+fk2Ko25yODGRFMGF+EbWvqe3BTAH6
	tt6bN9nPUmdrJd20Qs8ASA3fUtEPmiu9ytH9x7TQ3uobdvI0bqlGb/4z50UZwf+whj+
	W7j84GJwhA==
Received: by mx.zohomail.com with SMTPS id 1755006149202627.0494069115554;
	Tue, 12 Aug 2025 06:42:29 -0700 (PDT)
Message-ID: <50a61990b5009217dcc0ed74142c4ffeba137f73.camel@icenowy.me>
Subject: Re: [PATCH 0/4] clk: thead: Misc changes to TH1520 clock driver
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>, Fu Wei
 <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 12 Aug 2025 21:42:23 +0800
In-Reply-To: <20250812054258.1968351-1-uwu@icenowy.me>
References: <20250812054258.1968351-1-uwu@icenowy.me>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2025-08-12=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 13:42 +0800=EF=BC=
=8CIcenowy Zheng=E5=86=99=E9=81=93=EF=BC=9A
> This patchset is my changes to the TH1520 clock driver, mainly for
> supporting the display controller (the first 3).
>=20
> The first two are functionality additions, with the first one adding
> support for enabling/disabling PLLs (for DPU PLL) and the second one
> adding support for changing DPU dividers.
>=20
> The 3rd one is to address hang issues met when testing the DPU driver
> w/o clk_ignore_unused command line option.
>=20
> The 4th one has no relationship to display, and only exists for my
> need
> to change an arbitrary GPIO (well, GPIO3_3, the one controlling the
> fan
> on Lichee Pi 4A) with gpioset.
>=20
> This patchset has a dependency (a 0th one) [1].
>=20
> [1]
> https://lore.kernel.org/linux-riscv/20250809-fix_clocks_thead_aug_9-v1-1-=
299c33d7a593@samsung.com/
>=20

Oops, looks like this patchset deserves a new revision now...

PATCH 2/4 has a round_rate() implementation, which is considered out-
of-date and determine_rate() will replace it.

PATCH 3/4 was broken during rebasing.

PATCH 4/4 is found to be not working (and even makes padctrl0 an orphan
clock). Yao Zi told me that I need to first do some changes to ccu_gate
code.

> Icenowy Zheng (4):
> =C2=A0 clk: thead: add support for enabling/disabling PLLs
> =C2=A0 clk: thead: support changing DPU pixel clock rate
> =C2=A0 clk: thead: th1520-ap: set all AXI clocks to CLK_IS_CRITICAL
> =C2=A0 clk: thead: th1520-ap: fix parent of padctrl0 clock
>=20
> =C2=A0drivers/clk/thead/clk-th1520-ap.c | 174 ++++++++++++++++++++++++---=
-
> --
> =C2=A01 file changed, 143 insertions(+), 31 deletions(-)
>=20


