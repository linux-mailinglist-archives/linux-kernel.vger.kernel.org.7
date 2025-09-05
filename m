Return-Path: <linux-kernel+bounces-802774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F5B456CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59F51C283D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7134A326;
	Fri,  5 Sep 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMZ3qS4S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CD34A30F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072869; cv=none; b=qJKYXNvfMwxDDcarx3+FGCl4Huea4yaVHU6WmppxDrYoXqRoy/ARWDIWgCDL3bkaFK98hYlcD6ppPlpYVGy4TfdW1gN+mhvaeqjd+1Nhh4MzdbeAQ2erYUeVNIvwEIrB8GZCfkrs6J7XRl2s59jyT48EeAAl0PlhLvBrxB9HGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072869; c=relaxed/simple;
	bh=FdU77GPJOYxh9ocYPZ2SLosHzgjN3maiq6j1EqF+Mmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KelOOu+9tK4CSp4Bmz+qvEzNSstIrfQIdJTMLQBFI+ceaA42tmvf2a0yX1lwmZ8cwd/YofZ+0jpFS18mUXrn+gi8rmER+AeW6NtQtazYX1KG7bgW/3PyoKrIA54GIn6ipMxq3/QtDRyXGgGJOmh0Yn/fuTR8M7xqcebL/Bom3yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMZ3qS4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788E7C4CEF1;
	Fri,  5 Sep 2025 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757072867;
	bh=FdU77GPJOYxh9ocYPZ2SLosHzgjN3maiq6j1EqF+Mmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMZ3qS4SFYO4hBy0FiCKO5p7W8eTE5WHvmHyXftn3QsS9JkfyU/xmmVnxtd8DEIvL
	 OFOoMJwqRYNfs6FOsh0JHeop0nRTAwNsBGjgnn+k8TmarQ+7QvB2ra7HUhwDZOT6jC
	 jvbNgAKBqjdeTUSR/oIVxgvfXnnMU+6l+xE5FWGvXLbJTDwT0z7b8G9XmbgsJg6hZ+
	 HGeW53YkUU1yZcNsXLIF0hl2dxt5AsCP3RR1UpQVSiZ/DOIe+A7Cw4KkeSpJ0BVJgG
	 W8Ps9CqLaYftc96Di/svVwUJ6+I5YkXxoosiwRwXU5dQnonowBlcVmZ5pXl9xfCz9u
	 gkDzVBlvEKb+w==
Date: Fri, 5 Sep 2025 13:47:44 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Adam Li <adamli@os.amperecomputing.com>, anna-maria@linutronix.de,
	tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	vschneid@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
	patches@amperecomputing.com
Subject: Re: [PATCH RESEND 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
Message-ID: <aLrN4KQ1vDsqRTwM@localhost.localdomain>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com>
 <20250821042707.62993-2-adamli@os.amperecomputing.com>
 <aLm4wRwKBMGkekkT@localhost.localdomain>
 <6f14ff5c-cddb-f450-b4bb-fcc995b5ce5b@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f14ff5c-cddb-f450-b4bb-fcc995b5ce5b@gentwo.org>

Le Thu, Sep 04, 2025 at 09:10:29AM -0700, Christoph Lameter (Ampere) a écrit :
> On Thu, 4 Sep 2025, Frederic Weisbecker wrote:
> 
> > The current state is indeed broken and some people have already tried to fix it.
> > The thing is nohz_full don't want dynamic isolation because it is deemed to run a
> > single task. Therefore those tasks must be placed manually in order not to break
> > isolation guarantees by accident.
> >
> > In fact nohz_full doesn't make much sense without isolcpus (or isolated cpuset
> > v2 partitions) and I even intend to make nohz_full depend on domain isolation
> > in the long term.
> 
> I have never used isolcpus with nohz_full. AFAICT isolcpus is depreciated
> and cpusets are unnecessary complex overhead.

isolcpus for domain isolation is indeed in the way for long term deprecation
and the only replacement possible is cpuset, which overhead is only visible
on partition creation and update.

We could argue on the interface, the point is that nohz_full doesn't make sense
without domain isolation.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

