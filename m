Return-Path: <linux-kernel+bounces-744083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7623B107D0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC1516AE42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA323D29F;
	Thu, 24 Jul 2025 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWgcIleE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D6A19343B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353191; cv=none; b=L0bR9CyiIVJCWLcYcFCt65Utym/v1h/exBdDJ7C1Ehzm4jubb+IkbZ7GStB5B4caGsiQqaQ7b8C05QDRIWRBhLcGr6BzYdNf/cj9KpWTyQqhsdcx0Fkdl1S1eb0vQ0JB8C0loklLCA/1T81hBwmzIky7MI5DIE4BnL5OvYIezxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353191; c=relaxed/simple;
	bh=u/TbHR4IjyTcM/RxVon50qNPdvcLgQuEref5udttCc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpflYBFM8hVb2yTq4YZZmAI2x0Ge68Kd1rYCweOoEGydLxuEqgxEbOooDzmfZIR8H2gL4oRDz0E7fwKorFpc7G2eKI4NY23QmlxoC546t7tXsLMAMzWlaZBNFlrEGak8/W1wC0UuzXv8cnmnuejlOp+1s5rK3j3G6g0Mbjf8Ccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWgcIleE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8466C4CEF4;
	Thu, 24 Jul 2025 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753353191;
	bh=u/TbHR4IjyTcM/RxVon50qNPdvcLgQuEref5udttCc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWgcIleEUfAEyzlUWSIVHz5GQEqhLOC0aAX1GvcAebRNmbFoi1JH6T0SZBsawVkAo
	 2D1tlPVwpuRFKDhW2raaND3XakE/J+wVWWCtT0XUwJlO2dRtTlS9jHoo9+xZLTz+S+
	 xetO+LsJMKjsqPYyXdnfUpL+0yeE030nMKOFcM2ZlxUBt0oNbmRz0ppzuPYLGQ0Gj3
	 +XueRgj1fqXPgkdMoxCxcLHY4fjYa2JpJkLFTwPmaHwj9Q9f7EXcXInrSqRE2faF+Z
	 whcoF01LnvPtmJakd4e9RoPEzQT4VvfVANFTKuL48ZyWcRm5zd4MewjCk0zBSSiVTb
	 2AYfyqKp8U/Zw==
Date: Thu, 24 Jul 2025 12:33:07 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/7] cgroup/cpuset: Rename
 update_unbound_workqueue_cpumask() to update_exclusion_cpumasks()
Message-ID: <aIIL44p2Omeyh4Zn@localhost.localdomain>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-13-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714133050.193108-13-gmonaco@redhat.com>

Le Mon, Jul 14, 2025 at 03:30:55PM +0200, Gabriele Monaco a écrit :
> update_unbound_workqueue_cpumask() updates unbound workqueues settings
> when there's a change in isolated CPUs, but it can be used for other
> subsystems requiring updated when isolated CPUs change.
> 
> Generalise the name to update_exclusion_cpumasks() to prepare for other
> functions unrelated to workqueues to be called in that spot.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

