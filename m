Return-Path: <linux-kernel+bounces-848671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B74BCE4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F35C3A1C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BDB301031;
	Fri, 10 Oct 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSYGnCab"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6571DFD8F;
	Fri, 10 Oct 2025 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122587; cv=none; b=Tun1+nmcgywmZKmWidNzpzkh4MffMC/7EeDgQem94MZcSkziWYWzIxLYnIpZHRbLWsAlGArA+eVw123IbmrTxVaWn51K/kn2sP22cs8+U+DQ0FCe1OkUSC/PXA7dFR8cLf/UW8vUvx2vXybLegoVj6U3H6ZwX7hZb8xe4f9sV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122587; c=relaxed/simple;
	bh=sFXQ+M87qqrW6E3ybEnLSe49i0qbSE5OdfOw9RtTlvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLsCxZdjoVEJdjnRm45YcfnF4PHviWW2SXpCNwgIIPfbbRB8dP6SeE3lZWkucxxcqTlXaj+B4hcUtEm/xDddtJe/XAVM8QkNLfvhlJk4c7eLlzAVx06PzYLxYQJpwnBOT9gNhK02PWHXK4Po3X03P9tEIDD4+3dIQrYLBpzHSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSYGnCab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E021CC4CEF1;
	Fri, 10 Oct 2025 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760122587;
	bh=sFXQ+M87qqrW6E3ybEnLSe49i0qbSE5OdfOw9RtTlvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSYGnCabgES32RoI0V09lLgiiElnUWix1Xn33WTj26kaHl2vj+xKrMKF9eF17PmtE
	 OCAPZPBY5mhLpFODwkVm6MHcY6K2FXQ/EUi3SAQZ3/OZvSEetdZpf2TZCeCFTDfnLv
	 uPEuZRgNyOkXHcJf88qXxGQqIpeSUTehRZzImZK9BgcAhJ7XvMyCIvepImha0oPovi
	 3eq/BYQ04YL3/kqabJH+PhPgvr2HL2kSRSqNMsRfhcTQM3x49aWPEoP9tE3QcOpe2W
	 LNS3HPpKB1oknlDai87NAoL1bTWJVVm4FtXwcz9QJUkKgaMfHh3s9B+7bWn8XYPq+f
	 6RE8ybzpXtN5g==
Date: Fri, 10 Oct 2025 13:56:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Baojun Xu <baojun.xu@ti.com>, broonie@kernel.org, tiwai@suse.de,
	andriy.shevchenko@linux.intel.com, 13916275206@139.com,
	shenghao-ding@ti.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com,
	will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com,
	chinkaiting@google.com
Subject: Re: [PATCH v6 1/2] ASoC: tas2781: Support more newly-released
 amplifiers tas5802, tas5815, and tas5828 in the driver
Message-ID: <20251010185624.GA713043-robh@kernel.org>
References: <20251010022951.51581-1-baojun.xu@ti.com>
 <46346003-603a-48a8-8359-eaca77c8cd63@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46346003-603a-48a8-8359-eaca77c8cd63@kernel.org>

On Fri, Oct 10, 2025 at 04:33:47AM +0200, Krzysztof Kozlowski wrote:
> On 10/10/2025 04:29, Baojun Xu wrote:
> > TAS5802/TAS5815/TAS5828 has on-chip DSP without current/voltage feedback.
> > 
> > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> 
> You clearly do not want to follow what we ask... subject is still wrong,
> but in different way. I do not understand why simple comment from Rob in
> v4 has to be done in three versions.
> 
> Your subject is too long, contains redundant data and references driver
> which is for sure wrong. See writing bindings.
> 
> Please read again Rob's comment.

You are looking at the wrong patch. Not that the driver patch subject 
couldn't use some improvement too.

Rob

