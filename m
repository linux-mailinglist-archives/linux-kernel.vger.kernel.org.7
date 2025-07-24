Return-Path: <linux-kernel+bounces-744864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF3B111DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472AE1CC5A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC72EE275;
	Thu, 24 Jul 2025 19:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iAqnqtNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BB20012B;
	Thu, 24 Jul 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753386197; cv=none; b=bZ1unCG6nr2Glyrrn6Tf002MDPU7GbgzPtckToo7ruePZOe+TMSp8SYHyty+/9fkFQWMQTujGw615oD3FOTETGSWkb2XjZT6QXne2eEeqQ5wKKrSh2lrAYRxJ6vet1KQPHmlaA91ef9VJdV0xM4iBglr1ozA82z0a1kY0tREuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753386197; c=relaxed/simple;
	bh=BId8e81gEFbSFqQY1v7cyxqjQV93EVWZIRUWU0ayerY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1K5j/JT7hvTTt+a2NDxLbOcOZGjXMCvm7FxIQ7/9gK203eTP4qTCLD9BI3jUO5LD5mz+LTOYfHfLdbb1axtrFSGjc0XqxEj/xA0VA1Gj1OzbcWhMK3+8LWtqfn4huHxwEjIE2dogh5+BgWnPOCJql7xuTMCqDujrtnJTLcaYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iAqnqtNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA45BC4CEED;
	Thu, 24 Jul 2025 19:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753386196;
	bh=BId8e81gEFbSFqQY1v7cyxqjQV93EVWZIRUWU0ayerY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAqnqtNz1uRqNS23At5/mUzFZeS8mUM207bmCXhN4Un2PnfkiSL3yhMXeuFlyuwyT
	 WaYmwFnLtFHlA5eXbRrfSBrFP4Myi6wOdTB68tAB/UkOzyymPtMpe5SfYT7X5/ZYfD
	 j7wE1SDdg+sgN0CCa22Lvacy3zIG5m3Ow7hhKJE0=
Date: Thu, 24 Jul 2025 15:43:15 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, joe@perches.com, 
	corbet@lwn.net, apw@canonical.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
Message-ID: <20250724-rapid-auk-of-wind-f6d94a@lemur>
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>

On Thu, Jul 24, 2025 at 09:20:32AM +0200, Hendrik Hamerlinck wrote:
> Modified the checkpatch script to ensure that commit tags (e.g.,
> Signed-off-by, Reviewed-by, Acked-by, Tested-by, etc.) appear in the
> correct order according to kernel conventions [1].

As already indicated, this is the convention used by the TIP tree and is not
universal. Moreover, there is a lot more nuance to how trailers are used, with
many other subsystems strongly preferring chain-of-custody boundaries. For
example, the following trailers indicate a history of how the patch was
reviewed:

| Suggested-by: Sug Gester <sug@example.com>
| Signed-off-by: Alex Dev <alex@example.com>          -- boundary 1
| Acked-by: Acker Mack <acker@example.com>
| Tested-by: Test Rogen <test@example.com>
| Signed-off-by: Sub Maintainer <sub@example.com>     -- boundary 2
| Reviewed-by: Rev Yewer <rev@example.com>
| Tested-by: Integration Bot <int@example.com>
| Link: https://patch.msgid.link/foomsgid@exmple.com
| Signed-off-by: Main Tainer <main@example.com>       -- boundary 3

There are three chain of custody boundaries in the example above and in the
chain-of-custody scenario the trailers should NOT be moved around between
these boundaries, because each of the boundaries indicates what each
signed-off-by person is claiming as their responsibility.

Everything above boundary 1 is claimed by Alex Dev; all trailers above
boundary 2 were collected and applied by Sub Maintainer; all trailers
above boundary 3 were collected and applied by Main Tainer. Alex Dev has no
responsibility for the tag provided by the Integration Bot, so moving their
signed-off-by to the bottom of this series of trailer would imply that they
are.

I would leave the trailer order entirely alone and out of tools like
checkpatch, so this is a gentle but firm NACK from me.

-K

