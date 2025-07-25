Return-Path: <linux-kernel+bounces-746442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9FB126B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463D454253C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647A425A34F;
	Fri, 25 Jul 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQo6QiCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99313258CC0;
	Fri, 25 Jul 2025 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481503; cv=none; b=F/9KI9ykpVv4h5njjHKpTDntpFys0HT6u6SZuoOR5t0YusOz9Xp8bX2O7rCl/FdjNbSSKPTommRoPZAYji9+Vm/uQKoQ0MFr7CCYfVERgu0erC/uOdrv0JDBomb+YIn5PL+tOa18sBgzaPh7HpJzkba8sWUNxKiF8QTuiIHStRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481503; c=relaxed/simple;
	bh=DHfuxpHGFRMW7GFjNjUe0UknsvDb/gVPCyVBm2FcvPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYU2HQ6D2EfIryAU9QmVb58rGzBC1aUO9ZRzkAMFfP0gUGaNJ/oNm/n++/iM1jN1gwlqE7WxkZnu+nUpuA7kSivOXfqH/yd9OBQq3lfMEGr7Wyt30Bm28wMkQqlJGRDNi6Q9Sd3zZkg9YzQp40I5zdxbS8FurdLKURC66En6kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQo6QiCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CADC0C4CEE7;
	Fri, 25 Jul 2025 22:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481503;
	bh=DHfuxpHGFRMW7GFjNjUe0UknsvDb/gVPCyVBm2FcvPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQo6QiCTsl85hjoTfFPIbYz2cBYgls+iU95Aal9Cr1FfJwlPdhNo3+fkd2qEembAo
	 HNgcOInb/tdkxII/3KELdRaPlP9xWuIc/elh3Y2JLkImqexsibMaDA4913luxGHUJ4
	 KIofpUPVjY7vDduunDgR36ugibitXhTKURwiaSSTISoFp3vR8WdHUlgOXMJcYI4hQQ
	 0qhvHPJWT2vjd/66mx0qeIfs6vv1WvQnYx7aQ/G9uF5eUmIw4XWd4zA1B3CIeHk1Ft
	 inilkk1c29tG+lJXnXZnFisPw9BlRgukveWdNXF7ZVMZRNXTuSQZJRXN7IrSF/xvYS
	 pvnYKWPVSKaAQ==
Date: Fri, 25 Jul 2025 18:11:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kees@kernel.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <aIQBHHamNA3Hr9nA@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
 <20250725141958.10b11edb@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250725141958.10b11edb@gandalf.local.home>

On Fri, Jul 25, 2025 at 02:19:58PM -0400, Steven Rostedt wrote:
>On Fri, 25 Jul 2025 13:53:57 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> Create a single source of truth for AI instructions in
>> Documentation/AI/main.md with symlinks for all major AI coding
>> assistants:
>> - CLAUDE.md (Claude Code)
>> - .github/copilot-instructions.md (GitHub Copilot)
>> - .cursorrules (Cursor)
>> - .codeium/instructions.md (Codeium)
>> - .continue/context.md (Continue)
>> - .windsurfrules (Windsurf)
>> - Documentation/AIder.conf.yml (Aider)
>
>So these AI tools know to read these?

Yup! These are the "magic" files agents try to read and add into their
context as they start up.

-- 
Thanks,
Sasha

