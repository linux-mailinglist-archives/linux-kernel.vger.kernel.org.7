Return-Path: <linux-kernel+bounces-812165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DEB533E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915505669D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32C232C302;
	Thu, 11 Sep 2025 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg5RzKyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F432A3F2;
	Thu, 11 Sep 2025 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597881; cv=none; b=OcEZZFjQ7pDXom0CECu4RMuHmlM9zqwhItYI3otlHmtCTD6e7KZVfXtYSrqclCDLczk5BmvlmR8JXleUGeR2RTMJC49VIGdB+UmyzR+1Gme6f+kaypIHnExeuztU+5p2fpvWEOI/Os0RS7YlnWUihmpkkTX/Xs5jjYL4gJjZxEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597881; c=relaxed/simple;
	bh=35slho7IDk7RLH0t7N9+HIbGDcfyTAvEe6vQK5ZVd40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UH5iGcMSZ9p5K7Z7/rNQ2KArSRZFn3tLsgXWTO6JiJHzF7va5KdcjRgXzOxewOMIIC9ltBxlC+/LWgnykjoMk8sHKC9WBMFOpIzHbeNB+mB1S/lcXjJN2U7ShjXprH0SdXj1tMoh0ouHiRm9o7X6y/Y6KrrGOSHqrEW4+pI8Nqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg5RzKyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D491C4CEF0;
	Thu, 11 Sep 2025 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597880;
	bh=35slho7IDk7RLH0t7N9+HIbGDcfyTAvEe6vQK5ZVd40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wg5RzKyGO5Wp3wGScP2quWzilznyS9upJ26fnaTCSeJGqG0ErWtDXfSzztgeg6HmK
	 450sfD5+M0tLoKjlCNapUn+Yc6c38+PB3JsjI3H48bUYl6slJjAHGqYJFRV40aY9BQ
	 BU8EnlYr3RkZPMUpvejG9aNVID327DViNvKfrRoNFtUzCeYHcQwC+er1IZEKsyl8RB
	 y/O5Y2s2YFdV/KvhU28vB/p2B9wK7TAL0s1/jwIhbGQL8QUYPuOed5rYX1NbcEYWK1
	 2McjEEyAF2PTBDf6JviuZRAFiDnyJ6vEx3/c1iUrhEfyL38UZwpqdshchab857qJcy
	 Qe1goKgXOEkbQ==
Date: Thu, 11 Sep 2025 15:37:58 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v1 2/3] cpuidle: governors: menu: Rearrange main loop in
 menu_select()
Message-ID: <aMLQtifgkYyNxedE@localhost.localdomain>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <2389215.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2389215.ElGaqSPkdT@rafael.j.wysocki>

Le Wed, Aug 13, 2025 at 12:26:35PM +0200, Rafael J. Wysocki a �crit :
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Reduce the indentation level in the main loop of menu_select() by
> rearranging some checks and assignments in it.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

