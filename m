Return-Path: <linux-kernel+bounces-745674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B936B11CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684101CC7686
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D522E3378;
	Fri, 25 Jul 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJUvyhrl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F235235BEE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440918; cv=none; b=V4gHomS0KSdAUL2cQstNehavQPGFY2CsxOqobTp+pKgg3bimU/BguutsGBdy90aCnFx9sI3CrgT8W1IEGR5tdhDrXUH5Z+Wp6VtpC/RI6gScxAAhcUQ3pHuIluBZ2E009iy18MFOEc5RlOCkTUbfyprRQ3tUvMMmbQ0uhzQ5hYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440918; c=relaxed/simple;
	bh=XLQsVzD7cuupoZvPuQLHGSY6DgCvx2X8Ab3dvNv+Qh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmM9FyVXc7DlRcGpUUA0rJ9KHK4CeD/ChVm3tOkWKt1cBykYCCxk/B/8BQxf4eeGJxg+hsA32sVK2Y9l8KcLJlhPnutTktiD2MXedlVgnNlSFBCJPFbrdSFNpgd9ohCY1/h4/fvNkfpzk3wHMGTyh/2U0gbxyKQOzzfJ7mF9/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJUvyhrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6400CC4CEE7;
	Fri, 25 Jul 2025 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753440916;
	bh=XLQsVzD7cuupoZvPuQLHGSY6DgCvx2X8Ab3dvNv+Qh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJUvyhrlcAScom8gUPgi6GfFzA76sXQjD1xTQhcn7GUdHXd6mU5CVRlLZqQVe2yh2
	 ++Jkwi4sucZP5BLV+ZVZvaDmG+4OXVMwJnIjv4uUN9g/TxuqxYPbPUGZ+MukGNpBlZ
	 yWn7/vQFt/gWvCAzPgJKKF8ubPeumrjz/X7Wn2lHhGH6lMKmXIYD10PkQgZmobFHsH
	 RqvjzVwUoP0byDpFK6ZvSzxViqr2DxAXgItjtB00WeQDKER9URFKK0GvWf85gP3xV/
	 PpuoScv5DZl9h+UNUB4i5mZBddtf4a+u5xtLUuA6kn+b7lfG/uO9H+hX0eK1n5SnGz
	 snFImm23/Rvhg==
Date: Fri, 25 Jul 2025 12:55:13 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 7/7] timers: Exclude isolated cpus from timer migration
Message-ID: <aINikVzeWoKpX0_V@localhost.localdomain>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-16-gmonaco@redhat.com>
 <aIK8UFz3A7hNc1sq@pavilion.home>
 <381cb8d6b28648dbd5772c6bc0b2f1f10c29b53d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <381cb8d6b28648dbd5772c6bc0b2f1f10c29b53d.camel@redhat.com>

Le Fri, Jul 25, 2025 at 08:42:19AM +0200, Gabriele Monaco a écrit :
> On Fri, 2025-07-25 at 01:05 +0200, Frederic Weisbecker wrote:
> I assume it's cleaner if I squash it in 7/7 and add a
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
> and/or
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Do you agree?

I would prefer to keep the patch standalone because it's already a
logical change that has its own motivation. It's also invasive and
could potentially cause regression (or improvement) so we want to be
able to bisect to that.

Thanks!

-- 
Frederic Weisbecker
SUSE Labs

