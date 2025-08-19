Return-Path: <linux-kernel+bounces-775858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B7B2C5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6320F1788CC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B3326D6A;
	Tue, 19 Aug 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsqjWA1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A62EB853
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610453; cv=none; b=g/BDJKrKDdQ9hhQiCF7yuhU2a9SznK1oE9lSBvooGcuQCaAu/3doCVK8wlthrImMZWVHRogtXJxFfKtfeLCgWvMGSCMTWD4goQitAgm6XFnKJ6P9mf77p+XDz3quBNrKrsYBTL8CM7vcB+VSF4us4ZExJRJALbEv8/p8QIyVBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610453; c=relaxed/simple;
	bh=IDbL/BaZRzGbx7u9p+BoKXLYG7mHOZvQn6cePpQh+Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjUpcNI1D2MB0kCLwUm6hCLqZQ+wHKFA90uGYJP46ii6Mt3tSgWI8+dNuCY9OnxSgKk70GzBHfpqXUka3MMXXhjISChfijJDSEpI4URJqqe81Mnfl/SqHpTgZ8DvFvJN6oA+DJc3fKTDSpeWhZnH1EdIUh4KtviGHoEb+EgieCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsqjWA1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80994C4CEF1;
	Tue, 19 Aug 2025 13:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755610452;
	bh=IDbL/BaZRzGbx7u9p+BoKXLYG7mHOZvQn6cePpQh+Js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsqjWA1AT4dm//WHADmtKp6iM3mjqOrtLI1G3NnDmO7E6iQiJyWuiGdOid+dUpWyV
	 YKm4rao/7IUGykP0NRAvllA08tIJ+OnjhyT2QapIjJJCpa1Fu+FmsOMBWeDbeeP32Z
	 h16ekvRNRuHI/tCpUQ2Tqu1MRzNoztTnEUvNy2H2fF5uGYVb+rcLuaWSONNIQBrHb2
	 DAxdJfBphCc9wd3UZY6prKGaFrYM6Uzq9WO1H9RjUiMqbsIDXyDDjn8n0Emjhc1Vvs
	 Rokpg4ayIeqFX0oVl+BB972jBnUT+TczwQ3Sk+T/b0hxj2GuvS6zdOnwE7fcvlvMOu
	 XA2WEUonQliPw==
Date: Tue, 19 Aug 2025 14:34:08 +0100
From: Lee Jones <lee@kernel.org>
To: andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
	"Heijligen, Thomas" <thomas.heijligen@secunet.com>
Cc: "Huber, Nico" <Nico.Huber@secunet.com>, michael.brunner@kontron.com,
	"Schumann, Peter" <Peter.Schumann@secunet.com>
Subject: Re: (subset) [PATCH v2] mfd: kempld: Switch back to earlier ->init()
 behavior
Message-ID: <20250819133408.GG7508@google.com>
References: <7d2c7e92253d851194a781720051536cca2722b8.camel@secunet.com>
 <175560831907.965378.15824431424969459890.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175560831907.965378.15824431424969459890.b4-ty@kernel.org>

On Tue, 19 Aug 2025, Lee Jones wrote:

> On Thu, 31 Jul 2025 14:45:00 +0000, Heijligen, Thomas wrote:
> > Commit 9e36775c22c7 ("mfd: kempld: Remove custom DMI matching code")
> > removes the ability to load the driver if no matching system DMI data
> > is found. Before this commit the driver could be loaded using
> > alternative methods such as ACPI or `force_device_id` in the absence
> > of a matching system DMI entry.
> > 
> > Restore this ability while keeping the refactored
> > `platform_device_info` table.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] mfd: kempld: Switch back to earlier ->init() behavior
>       commit: 5256abb7faba92e3c49dbd6aabd42f17ddf218ea

Not sure how you managed it, but the author doesn't match the SoB.

Suggest that you may have too many Git variables set.

This makes scripts/checkpatch.pl unhappy.  Try it out.

-- 
Lee Jones [李琼斯]

