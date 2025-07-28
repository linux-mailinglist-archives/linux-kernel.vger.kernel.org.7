Return-Path: <linux-kernel+bounces-747504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3AFB13496
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA983B372C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62521D3D9;
	Mon, 28 Jul 2025 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+gI9whl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15EA1D7995;
	Mon, 28 Jul 2025 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682622; cv=none; b=enmBZdRQp1KdW/JwmuoNkCnda/qdsPwvSQlabUtHy2ycaxl/Vn6QfnXopqlwgySk/5DPu0nDGycA0FA6Kkg64TnvL2zQC9RFl4Q5B2TZYkuuCm39OmRLNP6H002UTHhRYp89clxe6J4IFWJOTSOBfkF/m0xuQymdhedWVp+3jYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682622; c=relaxed/simple;
	bh=czqJMhn87F/tucJUQVgRrsbciq1urHkmWQ+o5DbBMJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFUNV+i1zMHIyxbM87YOzWBboTLgjorqJ582bpWjqlhB0QFYP2eauwW/8831iB8dFxvQMgzgjpdYM0EIuftqK2h2UgOQrY+ityA+EJrHf9uYjiMDBLeghGRh+Dr4NKP7BnZKT1nWPWkdxlhJfJbRA5WOAPycThZXJCxwseUrdRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+gI9whl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21745C4CEE7;
	Mon, 28 Jul 2025 06:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753682621;
	bh=czqJMhn87F/tucJUQVgRrsbciq1urHkmWQ+o5DbBMJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e+gI9whl6LciXeVZ6nH6nerYU2QNfNG/AzM0cHJGiyyJLe+K8IkJsAfYw6HaeDfuh
	 4mlxhj4SB71p7K1kEyrvpeZJF/bhSCrDp7RtAIwx6wB9ZLG6E05s4cFUzVf19kuZY5
	 31SvKDjATwVyYPbJrBlk6dVJWNAsWuUj6AYby44p8rCWu2ca+IAXnHHRi5Is+Hf4ez
	 OISLqC17QfxBop6levPMfGMVcEpyYYauhI3SoIeQbNBCxK92P7gn0uBvVz7z6X6qk5
	 eyor7mrK3B3g0ryv3Oay9CQWw/ZTCiMe6EA8yABF/7+WC65fig/SS5tfaC2yMEV8yC
	 uDybEAq0ZlxQg==
Date: Mon, 28 Jul 2025 02:03:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <aIcSu3LidOqoaVOS@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-4-sashal@kernel.org>
 <202507271939.D78EC559@keescook>
 <aIcGQR8tjmjr8dlb@lappy>
 <202507272219.4BF02B6@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507272219.4BF02B6@keescook>

On Sun, Jul 27, 2025 at 10:21:40PM -0700, Kees Cook wrote:
>On Mon, Jul 28, 2025 at 01:10:25AM -0400, Sasha Levin wrote:
>> On Sun, Jul 27, 2025 at 07:40:36PM -0700, Kees Cook wrote:
>> > On Sun, Jul 27, 2025 at 03:58:01PM -0400, Sasha Levin wrote:
>> > > +**80 character line limit**
>> > > +  The preferred limit on the length of a single line is 80 columns.
>>
>> Hrm, it is?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n104
>> claims:
>>
>> 	The preferred limit on the length of a single line is 80 columns.
>>
>> 	Statements longer than 80 columns should be broken into sensible chunks,
>> 	unless exceeding 80 columns significantly increases readability and does
>> 	not hide information.
>
>That's true, it's not called out well enough. 80 is "preferred
>limit" but not the hard limit, which is 100. See commit bdc48fa11e46
>("checkpatch/coding-style: deprecate 80-column warning")

Sadly it doesn't look like I'm the only one who's confused here:
https://lore.kernel.org/all/?q=%22checkpatch%2Fcoding-style%3A+deprecate+80-column+warning%22

-- 
Thanks,
Sasha

