Return-Path: <linux-kernel+bounces-845553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB24BC5590
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319B04F49D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF66028B7D7;
	Wed,  8 Oct 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG/6zosE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22062283FCD
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932186; cv=none; b=QwDdoyzZh2ptaXVl166KslF+564xV/Jfw8CdYSybGluOjq6cSsk2Xhe04mVZBeESXZtJrgAc2RHQI3IhnJ793JAPpGW6Fa9/ahlx/NpdHRqO5vicNARnmj6uwVC5NNhugwND3LqNKVAh8OcCy+LzRIx+ITmC3yFxE0jLqH/ouPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932186; c=relaxed/simple;
	bh=fvwFPXmotSN1uInHl4gSQolt94wb5njLbeaaynaGQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyXAEeorI/tpk5k1fHaa/lhaVh1ADCJKR18c0Ejsg87rSKug9KOa/HQ6LmMhO1Nl/qcgTPkTMf8+d0Wr8f2+dX46PkpnSJBiKu/i7GeKbKjaNe4OWjThfj5Uty4lEFLozchkd3uWZ/kxPk5BOSYXg3G9AGoNszAvwM6XCjo9aFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG/6zosE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A209C4CEF4;
	Wed,  8 Oct 2025 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932185;
	bh=fvwFPXmotSN1uInHl4gSQolt94wb5njLbeaaynaGQ4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RG/6zosE4ie8x8xWY4cENy4AWJLWK9vZqVMOoJFwcCyjEUNgXDq6b7cPqZHbqDpnR
	 mJ2NfM1CH897yszVg7BSJhjbxtzg7pKKjsP5yBn6B0okRDlcxK08RkFdpVnEta++Bz
	 kb5N3eMO0HKi9yd5HkKzUbdTnuPjvwOtAir1zmKkXcKDCk8QrCNmXId2jAf5FWxk6u
	 8w67MDZrc3EQkTqH+4VfT4eOI4coiTgCVbjo1SFM1wIa+dlPg/OaXjPKGtYCO6G7rg
	 mp8LEPNs4m6hA45MWHWMJhMz9QwRmAdgT8V+IukXXS5Nto4HMk5iOhFCtyTsy9KxdM
	 nTBF1iyUKwtrg==
Date: Wed, 8 Oct 2025 15:03:01 +0100
From: Lee Jones <lee@kernel.org>
To: Corey Minyard <corey@minyard.net>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mfd: ls2kbmc: Fix a couple Smatch warnings
Message-ID: <20251008140301.GY8757@google.com>
References: <cover.1759478975.git.dan.carpenter@linaro.org>
 <aN_uCPqymUbVN34c@mail.minyard.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aN_uCPqymUbVN34c@mail.minyard.net>

On Fri, 03 Oct 2025, Corey Minyard wrote:

> On Fri, Oct 03, 2025 at 12:28:58PM +0300, Dan Carpenter wrote:
> > These are two issues which were detected by Smatch.  They're not really
> > going to happen in real life.  Small kmalloc()s can't fail.
> > The devm_mfd_add_devices() function isn't going to fail either...
> > 
> > But still, they're worth fixing just for correctness sake.
> > 
> > Dan Carpenter (2):
> >   mfd: ls2kbmc: Fix an IS_ERR() vs NULL check in probe()
> >   mfd: ls2kbmc: check for devm_mfd_add_devices() failure
> 
> Got them, thank you.  I'll get this in for 6.18.

Do what, now?

-- 
Lee Jones [李琼斯]

