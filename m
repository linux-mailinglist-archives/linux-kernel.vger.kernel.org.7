Return-Path: <linux-kernel+bounces-767576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6EDB25637
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD88956386B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF002F39D5;
	Wed, 13 Aug 2025 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VORMbbAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E12F39C7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122516; cv=none; b=bnDN93ND8ea/Z4eV6vvw5SDfOWXkvJIWASxRjbOQwTY2ACvaenyMx6YqUev+JPTBCiMPsfXsRa+VR0RCbwSNfjvWzVLae9LKTRb5grCaIul0EYrbJ1Of1V5zrq6aBbC5C7ev/2u9ZwxmWSg7/ewuAbDp69wKopD2qsLIwaUcniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122516; c=relaxed/simple;
	bh=yPLTIGHkAU48mMe7a/YMASqRcP4ZP+4xEDN+XqrQ+Tk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UyUix8oGtWDnZjOP5KNupACwnZ9b71+4tKvlmJZ4p65p310+rWuH04M42I747EE0EqDxlaWiLU2DXoVScwQN4f3u4WL4mb5k9n56lvvXxOd7WBycnlwUNN+2DKGOwpEbjWKEZfr20Baszneb6zIVGBNvyMfiPbzi0MniHWsvqac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VORMbbAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A4DC4CEEB;
	Wed, 13 Aug 2025 22:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755122516;
	bh=yPLTIGHkAU48mMe7a/YMASqRcP4ZP+4xEDN+XqrQ+Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VORMbbAl+fY/DGJKEtsNj3CarhAjUkUxQLManmah3KztYjAPI5UkeL+rZxVD4VWyN
	 n/8UdnrzALINZ5B2PWcCQilOujvVG71jcFZ5WuBrDKrp1ZG5ttRBqwONoGBide7xQf
	 yDlQhqPHByCBoP5cYfSsXGaCkSyTXxndfuN7WopE=
Date: Wed, 13 Aug 2025 15:01:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Nanji Parmar (he/him)" <nparmar@purestorage.com>
Cc: lance.yang@linux.dev, mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hung_task: Skip hung task detection during core dump
 operations
Message-Id: <20250813150155.81680178704c4652fd454a80@linux-foundation.org>
In-Reply-To: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
References: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 11:30:36 -0700 "Nanji Parmar (he/him)" <nparmar@purestorage.com> wrote:

> Tasks involved in core dump operations can legitimately block for
> extended periods, especially for large memory processes. The hung
> task detector should skip tasks with PF_DUMPCORE (main dumping
> thread) or PF_POSTCOREDUMP (other threads in the group) flags to
> avoid false positive warnings.
> 
> This prevents incorrect hung task reports during legitimate core
> dump generation that can take xx minutes for large processes.

It isn't pleasing to be putting coredump special cases into the core of
the hung-task detector.  Perhaps the hung task detector should get an
equivalent to touch_softlockup_watchdog().  I'm surprised it doesn't
already have such a thing.  Maybe it does and I've forgotten where it is.

Please provide a full description of the problem, mainly the relevant
dmesg output.  Please always provide this full description when
addressing kernel issues, thanks.

