Return-Path: <linux-kernel+bounces-747442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A028B133DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BB91895AF7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D956C217739;
	Mon, 28 Jul 2025 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlXSQHhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B41482E7;
	Mon, 28 Jul 2025 05:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753678961; cv=none; b=NVluwOUytseGOu1UPgKsRsV7c7NkaBNOHT2qXUpcAqHO1qMlmeHOFTODZFObbeyHXvwyYWgQH5wZrLjn3TYrsPXtkHU9Nf2f5yvluYJKLR++3n01uSiX5d7yikm6cWaDfy/q3MeszZq6Uhvruwpqnh96hnA5r/SZ2q6B6FQf96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753678961; c=relaxed/simple;
	bh=L9PzLfyCXvKlm2QI40VeVwFfnjlEJsJwTN+gdfR8XJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evk1ygQxd0BpADe4r3yLQRqBQWaMCuSRn8raBSUjhPFEuD8juQbALUrfDIW/hEpjt2BG2r8kqWJ6c+JHJUvXrK37VHrSzYE3LhBRtqLcyPbxMMhXabnx/abKae0Y9XlVn3WZ78SyoLTzUQ2UkWslcGRVTzD83K+m8Gr8XLWYEHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlXSQHhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7DBC4CEE7;
	Mon, 28 Jul 2025 05:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753678959;
	bh=L9PzLfyCXvKlm2QI40VeVwFfnjlEJsJwTN+gdfR8XJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlXSQHhylEKWK7GxDue/UFWDCSnwJLSqqVcrhThgscHRbiSOZPKAnf8dN4qIAvdzD
	 Rk4+0huwAklS1gE5p+j1uIvYn7h3PpII3qW3p5xBV49XyDBG72jSryJQjmYTfuHMuK
	 ndm8XYAJ4oF3rLaczXzRcjCg2kPWjyRhMNuys4acMXXjyDPCtjGGPAJ5AkJlsVY0Jz
	 U1n37vCdwR2fFi8trN5m2AxqXOUuLwmASJ9hhFQjDT3EtemBYmKFz5Y4I390MwYZ7K
	 hPa5SvQYSB3IqlkF6N1CUBHV3y8/LWYbLqqkoPryIIeiuASFKBs35Ab7DcBJgs/QHN
	 bwyl97W0rc5KQ==
Date: Sun, 27 Jul 2025 22:02:39 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <202507272201.56FF81C25@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <2025072825-gotten-cupbearer-449a@gregkh>
 <aIcCBZ6MVX1OHKpw@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIcCBZ6MVX1OHKpw@lappy>

On Mon, Jul 28, 2025 at 12:52:21AM -0400, Sasha Levin wrote:
> An an example, look at the wiki page for LF's kernel mentorship
> program[1]. The first step it lists is:
> 
> 	Complete the project prerequisite tasks assigned to you when you apply for the project:
> 	Step 1: You should have completed the A Beginner’s Guide to
> 	Linux Kernel Development e-course during the planning phase.
> 	Upload the certificate of completion.
> 
> Where the course is basically going over all the processes and rules
> around kernel development ("This course is intended for developers who
> need to know about the Linux kernel development process and the explicit
> and implicit “rules of the road”.").
> 
> This patchset is effectively the equivalent of the course for agents :)

But this just reinforces my point: if we need this for humans, write it
for humans, and the agents can follow it.

-- 
Kees Cook

