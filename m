Return-Path: <linux-kernel+bounces-767843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AABB259B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DC72A74C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EDB2580F0;
	Thu, 14 Aug 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO1XntBs"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD31146D45
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141185; cv=none; b=AbyY2im4kSgi+/8nLx4uNQsQfVxw49++VhMT+yznffhfTi1JR9nmlnZUmEDBYA2d/MDmOaJZPri7J2k7ZqxGWQiz9fSukIvkMIy+kgj1TWeiwmeOiYakPu5Ftuk1ZbbTwZ4SLbnu1gblh4j2Uk5FxMZwqR5JoJeXFvzIHxZ5n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141185; c=relaxed/simple;
	bh=UXVLIjBtUicak0gdn3qexGSyXMmCpKFSWBMs/kctJRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rpg2trfIVW2Wjvtkgt+BcSgUMWMvV77fmnq3bjjrRA+Heu0XEonLl4LR7II26E3TqwY2MsA2LUCw7/gMSSkSKxXnGfD9tis35DTkxvjP+wkb8HHkyN9KCoj4mcUxPHU2jhrPLMWmFWEZ+Rm3N2xUud9UCGCcsY3D4671g4kq0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO1XntBs; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <33f995c6-4db7-4e4c-ba12-eb5d05e8521c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755141178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qSWoLGpoBeaVe8/5iB8daNh799QMiX5SXuF8NWHr138=;
	b=aO1XntBsFkIC6g5gr+ZvLO+DMFB073C1lIsIaQrrGRAhfd8UaLMPHt6VH/ONhMuzn+MCi9
	VXIw7tF85+HjSplUxF5yXUfHl0YjI7x4ISWMlAQYEpnES4OAoeXBDHE5NUFntHyZyygTsZ
	hvAfQ3sTPan3NWUupplC/WV97H2oRyU=
Date: Thu, 14 Aug 2025 11:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hung_task: Skip hung task detection during core dump
 operations
Content-Language: en-US
To: "Nanji Parmar (he/him)" <nparmar@purestorage.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <CAEK+-Oe8GszRBDDF8jKAmVQNUEvgVqJYDp31P+mZTbqzneEZzA@mail.gmail.com>
 <20250813150155.81680178704c4652fd454a80@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20250813150155.81680178704c4652fd454a80@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Nanji,

Thanks for your patch!

On 2025/8/14 06:01, Andrew Morton wrote:
> On Wed, 13 Aug 2025 11:30:36 -0700 "Nanji Parmar (he/him)" <nparmar@purestorage.com> wrote:
> 
>> Tasks involved in core dump operations can legitimately block for
>> extended periods, especially for large memory processes. The hung
>> task detector should skip tasks with PF_DUMPCORE (main dumping
>> thread) or PF_POSTCOREDUMP (other threads in the group) flags to
>> avoid false positive warnings.
>>
>> This prevents incorrect hung task reports during legitimate core
>> dump generation that can take xx minutes for large processes.
> 
> It isn't pleasing to be putting coredump special cases into the core of
> the hung-task detector.  Perhaps the hung task detector should get an

Yeah, adding a special case for coredumps is not a good design ;)

> equivalent to touch_softlockup_watchdog().  I'm surprised it doesn't
> already have such a thing.  Maybe it does and I've forgotten where it is.
> 
> Please provide a full description of the problem, mainly the relevant
> dmesg output.  Please always provide this full description when
> addressing kernel issues, thanks.

Interestingly, I wasn't able to reproduce the hung task warning on my
machine with a SSD, even when generating a 100 GiB coredump. The process
switches between R and D states so fast that it never hits the timeout,
even with hung_task_timeout_secs set as low as 5s ;)

So it seems this isn't a general problem for all coredumps. It look like
it only happens on systems with slow I/O, which can cause a process to
stay in a D-state for a long time.

Anyway, any task *actually* blocked on I/O for that long should be flagged;
that is the hung task detector's job, IMHO.

Thanks,
Lance



