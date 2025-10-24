Return-Path: <linux-kernel+bounces-867915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD74C03EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C561189AC99
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E38E552;
	Fri, 24 Oct 2025 00:02:41 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097B11FB1;
	Fri, 24 Oct 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264161; cv=none; b=ZEaElkpwuz2o5DOOdS7NqsKqU6f06Urog69VuaSqXTgTa39Lp+sr7q90pcfsS/7aMkjuiHIR+lhMbOU9e2U275SvlnHtlIRkXO8JSMlm9SPwU8DsH2qQRUIUmiINw9U1SW7HUwlA+5izfq/O27W/4APyFw1OLsiCgidppfIBeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264161; c=relaxed/simple;
	bh=+Yux/1olVRQyz0ISw0qmRHqr0cRXGF5O459WyQrYcN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ng8DL6WCyJeCXKDvrpmtmB+pCxdzAz7gpjuoAq9aKkC+o1kmCaQgYk9k23mlsW5zi54wFW38Bsuk7oozEsrEGv86GULfXvvS1NteM03qw1BJOmTxTR8hyVVzyku59LcMATA35bhT3/ANwwpytNOHamimheom880WKEWTYIc9KMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.147.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 09A64340F1D;
	Fri, 24 Oct 2025 00:02:38 +0000 (UTC)
Date: Fri, 24 Oct 2025 08:02:28 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Conor Dooley <conor@kernel.org>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>,
	michael.opdenacker@rootcommit.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@gmail.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] riscv: dts: spacemit: add Ethernet and PDMA to
 OrangePi RV2
Message-ID: <20251024000228-GYA1537773@gentoo.org>
References: <20251022201807.1474789-1-michael.opdenacker@rootcommit.com>
 <20251022201807.1474789-2-michael.opdenacker@rootcommit.com>
 <f8a55f89-2612-49e3-88c6-acb523ac74d3@iscas.ac.cn>
 <20251023-lizard-sharpie-70f2a000327f@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251023-lizard-sharpie-70f2a000327f@spud>

Hi Michael, 

Since the patch itself is good enough, so I will just take it,
I will drop those CCs if no objection..

On 19:30 Thu 23 Oct     , Conor Dooley wrote:
> On Thu, Oct 23, 2025 at 01:58:22PM +0800, Vivian Wang wrote:
> > Thank you so much for the patch and testing results. Only some nitpicks
> > follow.
> > 
> > On 10/23/25 04:18, michael.opdenacker@rootcommit.com wrote:
> > > From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > >
> > > The OrangePi RV2 board ships two RGMII ethernet ports.
> > > Each has an external Motorcomm YT8531C PHY attached, the PHY uses GPIO
> > > for reset pin control.
> > >
> > > Enable PDMA for the SpacemiT K1-based SoC in the OrangePi RV2 board.
> > >
> > > Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> > > CC: Emil Renner Berthing <emil.renner.berthing@gmail.com>
> > > CC: Yixun Lan <dlan@gentoo.org>
> > > CC: Vivian Wang <wangruikang@iscas.ac.cn>
> > 
> > Firstly, it is usually spelt "Cc:", with one upper-case C and one
> > lower-case c.
> 
> I don't think this matters at all, the git tooling at least doesn't
> care.
> 
I think it's super useful by putting additional "Cc" into individual patch
especially for a large series to notify specific maintainers while not spam others


> > Secondly, "Cc:" should not be necessary in the patch/commit message.
> > From Documentation/process/submitting-patches.rst:
> > 
> >     If a person has had the opportunity to comment on a patch, but has not
> >     provided such comments, you may optionally add a ``Cc:`` tag to the patch.
> >     This tag documents that potentially interested parties have been included in
> >     the discussion.
> > 
> > If you look through the git logs of Linux, Cc tags are really not a
> > regular occurrence except those marking patches as suitable for
> > backporting to stable.
> 
> If people want to handle CC lists by putting it in the patches (it's
> what I do when I have no cover letter) just put them after the --- line
> and git send-email will still pick the CCs up but they won't end up in
> the history.
> 
indeed, good suggestion!


-- 
Yixun Lan (dlan)

