Return-Path: <linux-kernel+bounces-898282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A59C54C30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A6F3B7FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ADF2D193F;
	Wed, 12 Nov 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3U9ZtLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714852BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988165; cv=none; b=FPIgLJCDkZX4E55/CJzbtTzx/NGoJ/yt3jFbWvaw69B7he4qk7RDQpVnn8oRtzDbyxvgRijjvfB6VpZmxRYbhZZnomK52BLxe0PyevoYMpbagdyl9fh0ladLfjNhTxXMZRhgyiQ3QTBLEq12jLTtIWbsv1Ak/EBVYalJ3FmCGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988165; c=relaxed/simple;
	bh=6F6Ph+mBRwZHPlibDEBt422QzwWtBzRDmoS6rRlf2hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAEi4uD7ooAUcUCwuz0uXuOyB34uXzQxmChVdmyM/AJIjQOTsOneMh+kJsltv0M4txjJbrOAowBSwAPP3S7Qqqr95gDuBTjoyzVAqbev0+VDeeqvoOKXKIPpjHSpzletUJ51G74fgdWTDyHovHgdic1BRVo/XpbedX2UCNeT5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3U9ZtLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52672C4CEF7;
	Wed, 12 Nov 2025 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762988165;
	bh=6F6Ph+mBRwZHPlibDEBt422QzwWtBzRDmoS6rRlf2hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3U9ZtLM8oF+kzwDvVB6ER2pdVinRk5S03N501V/zUwBf6e1RlR6A6xXm5aIaa7Cn
	 q3Nq9EZCjqNhWva/F9gIOuh+F+VXr1k6y0kWZ4vLv6+b64tGfdnq8tneBfw3W6T35Y
	 KWX4Ji5xBnKC3ywMWL7cgkbSDMFbbCMlWVC56KAlU/xFqKwnviNZIOZOndB9L2JvW1
	 nAlyqxi22NF3r/Z69UIuqvwnQd827gKajQLuDca6ikDdsCwbfE3Ox0V1oPJk7ExBnk
	 5Qud0WfyMmuKAc/ZJ1u3uUov/XZo+XcfKF0LokYIlI5mYTJcRFnyjWIoE52yB+WHzd
	 xotO3IleRDYoQ==
Date: Wed, 12 Nov 2025 14:56:02 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	linux-kernel@vger.kernel.org, joe.lawrence@redhat.com, Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check
 scripts
Message-ID: <z4go2m2c7ufulwjk7vkcpv2oyfo2jwpxzieiuuetegnv7sjrsj@gbjwkp2dpdyd>
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>

On Tue, Sep 23, 2025 at 05:32:16PM +0200, Jan Stancek wrote:
> We've been observing rare non-deterministic kconfig failures during
> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> disabled and with it number of other config options that depend on it.
> 
> The reason is that gcc-check-fpatchable-function-entry.sh can fail
> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> there is still someone writing on other side of pipe. `pipefail`
> propagates that error up to kconfig.

Ping?  This fixes a nasty build bug, any objections to merging?

-- 
Josh

