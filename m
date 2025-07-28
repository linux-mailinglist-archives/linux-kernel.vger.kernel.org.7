Return-Path: <linux-kernel+bounces-748650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5612FB14443
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939293BC0A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ED32153D2;
	Mon, 28 Jul 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZfSKm3/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD041C69
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740967; cv=none; b=rDAQgVCt2J7IUFOQTOKbAYtD+sWtJ7u9hyDGZFleLCU3gbIPpK6wEWkdp6J4C5tGjqJ9xFOmtzxeGlrF1dZMqwauS0OqTD0u79Jkh9TL6da2hT6WT0D4WnrU9dTTptKf1YrfsC8pHhGhA+zZbwGO3mMD4XP5s6CbarmcXAOZlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740967; c=relaxed/simple;
	bh=TzVWYT76rZE3j083ttedwRt/20yfxuDoW0mHV1B5gDs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KevRE3Wtf9CDM7RjyLO/oAr3qvIc8DRi7wNXqKVVA/JkwnRwz/2SFqgKJwR6sG73LUI1Wb/TDaFCZ2ke4XSgKlWoJ2edBebAKlcevABfbmJsUtn1oDYiRSWr85E6WwOJHGumWlPwx816b6eKGKz0qIOW0c+2xG4lKDvDFnKzFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZfSKm3/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D4DC4CEE7;
	Mon, 28 Jul 2025 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753740965;
	bh=TzVWYT76rZE3j083ttedwRt/20yfxuDoW0mHV1B5gDs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZfSKm3/E6RiE/tCV6VIRZLG2thsq7KkBEVsP0etcc1LaZDPn8g9dwuta9RB+/3K3f
	 zk2BxycXTmSMfN160LDV3jpuZtb3shabZBxoAzOn7CHD25y8iWsbD2/9zDyaTQNUcr
	 RQvJuG3x3sqbV5xPJhWh9EHfUZw1Zww9rGuVrDzA=
Date: Mon, 28 Jul 2025 15:16:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Patryk Kowalczyk <patryk@kowalczyk.ws>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 ville.syrjala@linux.intel.com, david@redhat.com, willy@infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, christian.koenig@amd.com, ray.huang@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
Message-Id: <20250728151604.e834daa64e8c816aeffba975@linux-foundation.org>
In-Reply-To: <CAJCW39+AS5poKu3A4Y88pH2y6CWbE0WnGZfe3kL99W3sJZjreA@mail.gmail.com>
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
	<20250728144424.208d58d5a95057ee7081ccd8@linux-foundation.org>
	<CAJCW39+AS5poKu3A4Y88pH2y6CWbE0WnGZfe3kL99W3sJZjreA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 23:59:22 +0200 Patryk Kowalczyk <patryk@kowalczyk.ws> wrote:

> In my tests, the performance drop ranges from a few percent up to 13% in
> Unigine Superposition
> under heavy memory usage on the CPU Core Ultra 155H with the Xe 128 EU GPU.
> Other users have reported performance impact up to 30% on certain workloads.
> Please find more  in the regressions reports:
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14645
> https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/13845
> 
> I believe the change should be backported to all active kernel branches
> after version 6.12.

OK, thanks.  I added this (important!) info to the changelog and I
added a cc:stable, requesting a backport into everything which has
acd7ccb284b8.

I'll place this in mm.git's mm-hotfixes-unstable branch with a plan to
upstream it sometime during the 6.17-rcX cycle.


