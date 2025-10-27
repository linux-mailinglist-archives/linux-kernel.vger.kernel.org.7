Return-Path: <linux-kernel+bounces-871730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C608C0E299
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FB9188F36F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA6B30274F;
	Mon, 27 Oct 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbT/n8VM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192352F6912;
	Mon, 27 Oct 2025 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572926; cv=none; b=PpeCOUcvtHTo79LIDNixambwAQFVw3riJxney17jKzpFnr7r7tuWLNzJ7alnrm19UgsYmaqTOCU371dVcI2DppLZ5MRNVyS9pgUuxBHOOarv92AasPgSZZV1R+MMwY+l9shDU5gKK/sEZAqqjz4d3fC9GzvDkmvcSBinw7PIWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572926; c=relaxed/simple;
	bh=bKodtt7Hjm2rW+pJ5rAyiEVO0GiiJmbH9W91QtsBm4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1rWZWDiPsWrYP9NFyNE7ufiPhQ5iDQbELylgc1LtXldV/P5/kSdv7DIx8e3r+/09laXPK2JpEEwJEdMtKtRNxTYIMQ5F21lCQ4KMyjw6pusRf0whpBHnkS5Wa+jUJINbB1hxvZeRgwr4e6oMRlukU2ht++fsY1mpIw6hUpOP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbT/n8VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E155C4CEF1;
	Mon, 27 Oct 2025 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572925;
	bh=bKodtt7Hjm2rW+pJ5rAyiEVO0GiiJmbH9W91QtsBm4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbT/n8VMkqnhuDh1CLKL9D+ZHrpTxzqwzmWJ13v3b1eR2RO2IiIHGWfFHTgZQ8L5g
	 5uMlwPZ3DLwHhWjQenNgDxlNo3ETU8FJ7VaWoodRpWHQfXXyM8WqtMkGUz+Rf6tiVq
	 YRL6x0XveiGat6QFArCntzoZnNWrWyPxcPhUtjwfhdOGYrqlq4emBJFzFgDwkW2Ls2
	 AM1JCwmZMDYaTMBaOjMr03IZD6fd4EACQoYamaGoavlDPlbYwk0f1iZU+U7MJyOTvf
	 KzmExsMlLuyzkXYfvJcYqFiMTZsLhF+/NoXx8ivdQNF5RwoaP2uRhDns0Rs7Eavnuz
	 b0TXbOTKYf4eg==
Date: Mon, 27 Oct 2025 08:48:42 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>,
	Eric Chanudet <echanude@redhat.com>,
	Radu Rendec <rrendec@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Make the number of reserved memory regions
 configurable
Message-ID: <20251027134842.GA274032-robh@kernel.org>
References: <20251023-of-max-reserved-mem-v1-1-cfecc7a2150f@kernel.org>
 <CAL_JsqKtGMk8JQJR37i73CMnqtdoZddNpnoVhmyE4w1qUXnRhg@mail.gmail.com>
 <6moxms5mnvjgvfxie4zoewdvq4bbmg56hmtpohdxwujdqydxqg@r2x2rvrpjh6g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6moxms5mnvjgvfxie4zoewdvq4bbmg56hmtpohdxwujdqydxqg@r2x2rvrpjh6g>

On Mon, Oct 27, 2025 at 11:02:39AM +0100, Maxime Ripard wrote:
> Hi Rob,
> 
> Thanks for your answer!
> 
> On Fri, Oct 24, 2025 at 07:57:06AM -0500, Rob Herring wrote:
> > On Thu, Oct 23, 2025 at 10:35 AM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Some platforms register more reserved memory regions than the current
> > > hardcoded limit of 64.
> > 
> > I've already NAKed a kconfig option for this before.
> > 
> > The limit is now 64 dynamic regions, not total. The static regions are
> > unlimited. What platform needs so many regions and to abuse
> > /reserved-memory like this?
> 
> I'm sorry, I totally missed both that you nacked it and that it got
> fixed recently. We're still seeing the issue with 6.12, but it looks like
> 
> https://lore.kernel.org/all/20241008220624.551309-1-quic_obabatun@quicinc.com/
> 
> Is the series you were talking about?

Yes. Plus some fixes on top of that. Every time this code is touched, we 
break someone...

Rob

