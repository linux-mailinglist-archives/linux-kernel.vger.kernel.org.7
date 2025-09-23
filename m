Return-Path: <linux-kernel+bounces-829282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DD3B96B08
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DE917E345
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC32356C7;
	Tue, 23 Sep 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR4rgp0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A9AD24;
	Tue, 23 Sep 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643229; cv=none; b=VH7HrJl9Ddr/fN6ceIvPaIobg3EcK9zUfUhbcC9/b5O22a+sO3V891RIJ7bttLtVDk96YuJfvhQ9DZUNldtWKlNUGENUL+Yd26CStcKdtn5WwOrN0v2YkK7PdU6o9/eB3l57SuhZeHf3nzhO8CgtqoBs4J0ohYVmRT5nv58VOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643229; c=relaxed/simple;
	bh=945hZaNFvPwQ38RxpAecJ+xDmCzgtXLq2vZMOy9Q5A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktdN8rvOlEbx9fBVLBID1VA+hPp/ugGwOLhSUSC4XTHm2YyWzNXeJeBUFbUz8HgewQiXZRnXJ+PNzEQNxno6soM8CuavsEaLfcVq6C/ZqSqoRKp/RBJI3S1XPRXmSFA9nXhOTht9ThdGWlbLmgPxkU5Jk6NJ4MRn1oEtg0KPhSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR4rgp0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8DC4CEF5;
	Tue, 23 Sep 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758643228;
	bh=945hZaNFvPwQ38RxpAecJ+xDmCzgtXLq2vZMOy9Q5A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BR4rgp0QKPijQvntp5/FcgA46LJmL+IJi+d/aFbHafE8Mj/WLFVNsNiJyFnls1g5l
	 pxhqVBhBRG+tSRMfW1nBl3WxElxZNt8csfRPEgBwopD0qH3q6q3P6iEg+F/JV0xhup
	 kd96xcJEcmRw3sqsuMubUEmFbumTQzyC1xloeT8q64ghhTxXcpeEjJNwvZleDFi0N1
	 kG982qJ9Bc8oJ9ICdmqB9SLBkJyIkaetfyMhO/BpEXXYUuMOme8uKthPkbSiOtrQ+k
	 kzQ5JD7CHzQFwkM4uf97yCfIyvm+wLhZaEhkjjgoCcjCO7v6fGqw+eqpNG5r8zHOjv
	 9kEymnWwPpjRw==
Date: Tue, 23 Sep 2025 06:00:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/7] sched_ext: Use bitfields for boolean warning flags
Message-ID: <aNLEG9m9JM4gDM9L@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-4-tj@kernel.org>
 <aNJQFqg2R80VJc7p@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNJQFqg2R80VJc7p@gpd4>

On Tue, Sep 23, 2025 at 09:45:26AM +0200, Andrea Righi wrote:
> On Sun, Sep 21, 2025 at 03:32:43PM -1000, Tejun Heo wrote:
> > Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
> > single-bit bitfields to reduce struct size.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> Hm... I think the struct size remains the same, at least in my build:
>  - before: /* size: 1072, cachelines: 17, members: 14 */
>  - after:  /* size: 1072, cachelines: 17, members: 14 */
> 
> Maybe if we add more attributes in the future?

Yeah, just so that we don't keep expanding the struct as we add flags. I'll
update the description.

Thanks.

-- 
tejun

