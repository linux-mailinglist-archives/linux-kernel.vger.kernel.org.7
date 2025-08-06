Return-Path: <linux-kernel+bounces-758417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EC4B1CEB1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7582E17CE40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607922CBC0;
	Wed,  6 Aug 2025 21:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZG9YxTG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAB2B2D7;
	Wed,  6 Aug 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517182; cv=none; b=MWdt5+LMU9ixgr+FblGUTLvh69rvmOVE7DQ0/5Jd8e2Ph2DC204Rb6m5aZfmRSumwO36ylvO1bC3sg0AU/Bk0eSeL1m+EfFNNxkVS5AYjWlEW9R+jDO0kP1IO9NFTa5XKKOVgD0EuxQOkqLsOnWBgmCEDzh6e0PQ8LfVgZwRCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517182; c=relaxed/simple;
	bh=4+RibZOD3PKvAL0aTGHtf1C7I7RuxRiBBxm+ORxuP00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GISF9vY+gZmePwP1flFi8zJqyOYI7OD3NXHfCyud6lRTzW6U28XelFaJay9d3WTGiL0YVnEUdAakoO4qiQU9vWwodDww23ZP34vgkCQhG82VOnrKAgT8yj882anrpaxzRC2dxWHhBQDwFk5/amAxEbAH7mptXGPLQ618/3qmMjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZG9YxTG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2AC4CEE7;
	Wed,  6 Aug 2025 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754517182;
	bh=4+RibZOD3PKvAL0aTGHtf1C7I7RuxRiBBxm+ORxuP00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZG9YxTG4pJ0WWk7gp6P9YKbNvQ40uSWKqbruupb32bvl7E9HwXNwXEG1Kw0P/0saK
	 Wh6AwG9gHmQ3oo8G6aA7P60u/wReaNQ/F9z0qMee8ep4jQUZSwh6Wz+NCSmVIMMeOI
	 M62GpSsiAIK+nBTwSmwhn1Y3098D3/VeEV7oEkO0XCElB967H1NlVYBIidGlBxduWt
	 lMzPyb0Q+/xVJ4U/ywgznudE4azYyXbGEn5oQJpk/0bUsdKxKYAVzm+V2WIZHpJhwj
	 7HKY15Sxlrsv6NYeFojrCwIouRvB7+VVN0eZFMFijS9i9Opn3YYcx1NnUmEOvodGw1
	 tTJWKxG2s9dfw==
Date: Wed, 6 Aug 2025 17:53:00 -0400
From: Sasha Levin <sashal@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 4/4] agents: add legal requirements and agent attribution
 guidelines
Message-ID: <aJPOvNlC2CSiJR77@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-5-sashal@kernel.org>
 <20250806-impetuous-rainbow-octopus-2dcaab@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806-impetuous-rainbow-octopus-2dcaab@lemur>

On Wed, Aug 06, 2025 at 10:12:59AM -0400, Konstantin Ryabitsev wrote:
>On Sun, Jul 27, 2025 at 03:58:02PM -0400, Sasha Levin wrote:
>> +- ``Co-developed-by: Claude claude-3-opus-20240229``
>> +- ``Co-developed-by: GitHub-Copilot GPT-4 v1.0.0``
>> +- ``Co-developed-by: Cursor gpt-4-turbo-2024-04-09``
>
>FYI, this will break tools that expect Co-developed-by: to be in the address
>header format. I will add exceptions in b4, but it *is* going to be annoying
>that this trailer can be in both formats and I expect other tooling will also
>have similar problems.
>
>If it's not too late, I recommend picking a wholly new trailer instead of
>overloading Co-developed-by. Examples:
>
>    | Assisted-by: Claude claude-3-opus-20240229
>    | Auxiliary-tooling: GitHub-Copilot GPT-4 v1.0.0
>
>I like the latter, because this also allows listing multiple tools.

Definitely not too late. This was brought up a few times, and I like the
idea of not changing the semantics of Co-developed-by.

-- 
Thanks,
Sasha

