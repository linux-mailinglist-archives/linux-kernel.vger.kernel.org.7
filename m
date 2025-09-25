Return-Path: <linux-kernel+bounces-832378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E4DB9F2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04641C2116F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8F3043D3;
	Thu, 25 Sep 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQOSGucN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30D12FE574;
	Thu, 25 Sep 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802545; cv=none; b=cSkJis2bsikG+c7QpZOaIgYNq/1MKNInKq33/3q/cPkNw+Yg3W8rCv3O2nh2XVnaJsBgQpWbi928/tXPkm9F6x09N8f/ckyJ3bzVK/Jf6X+yIVYIs/BO2lI79rMuVwDqHwIlH+GKwVSuUvbPFR/vDaEuLqFgqM8JEFq+MHsAsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802545; c=relaxed/simple;
	bh=wY4Qr0bp8dapJFmikkz5whlClimbMA1B1CbsO0DvkR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLe5zsfEq9JV7h8nK0O1OKoweSqOWUZ0sA2V7yTa1U7pSy5rvM5FwtS7ijP8nN2QkRtkUI5rMjmwBC57RKJqN1h3NrBZi3TbStn8b2f2wRpzkVn5THJEEL5oTSo0Swa28c8btOM+/0yC77IoVDvjSqPhpAvR20YIyHO9T3De6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQOSGucN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55022C4CEF0;
	Thu, 25 Sep 2025 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758802544;
	bh=wY4Qr0bp8dapJFmikkz5whlClimbMA1B1CbsO0DvkR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XQOSGucNOxQ88rXWvyZl6rV/06Ep9PuEzEBFiYPcqUWIetrdaamSxe/DI4C8kNTpQ
	 UUTcaUMfuOPdbjaclOngt/yX1uy5q1LtDnJdEdW7cTpFuaLG0rE2k46hynMNI9FDdc
	 9zDcCf37J/g4/pKeFrA0VAP8vgq0/k5cjfhxVNqfPBrHIfJYsQg6bdjO894sbrn+LD
	 ee4eFhMXO3BGCV7Hr4U/JN07HgxVOsUQ78zzj3eT4+HFM2cLexrwI3hEFBuO0Ped7M
	 QNulhDtLrZzzrzo3Y/oXG39Rjl6H7r7dEsw3thT34Bt+lxJJW2SNd+ZhfbfCU+bGFm
	 8xDVgINzyESWQ==
Date: Thu, 25 Sep 2025 13:15:40 +0100
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Ming Yu <a0282524688@gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the mfd tree
Message-ID: <20250925121540.GL8757@google.com>
References: <aNEedsR5CDuVBoyo@finisterre.sirena.org.uk>
 <20250925103846.GA8757@google.com>
 <d014a00d-3868-414a-80c0-cdb376a0ef47@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d014a00d-3868-414a-80c0-cdb376a0ef47@sirena.org.uk>

On Thu, 25 Sep 2025, Mark Brown wrote:

> On Thu, Sep 25, 2025 at 11:38:46AM +0100, Lee Jones wrote:
> > On Mon, 22 Sep 2025, Mark Brown wrote:
> 
> > > diff --cc MAINTAINERS
> > > index 55288f2ffb6b3,681fbc8258052..0000000000000
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> 
> > Missing diff?
> 
> No changes from HEAD.

*thumbs up*

-- 
Lee Jones [李琼斯]

