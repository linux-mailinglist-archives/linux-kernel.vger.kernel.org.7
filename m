Return-Path: <linux-kernel+bounces-880117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2812C24EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5023BD52A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C6F3451BD;
	Fri, 31 Oct 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5gKH04S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31017284690
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912450; cv=none; b=GUEut6j4LDzv6uYE9NwyyfbmRTpzWk1L4lWrM1MD0SmhNxx95Az3KtVrmEXKjNrYJ/lCfr4qsRWYnBWCzUaCq/5zMsxGpyqB8W5TKlNqXX44Pdg+9iA/7pBcXY80e1w/t2Auzoi8gkMAVQFcgwAY2v99GuKKQvBOzsBQufpjOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912450; c=relaxed/simple;
	bh=eO71I9W1dx8mvITpEO1BclFCPoZukcO0DrufYccwfTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVTaOmBY00FNsQ8DsusE2381NH7NDsgQnbIij7A4hbOQXYPoZgpVp7dy3eeYdb4kittHV3KZh2LJBhO8fJo5lzmi3IGNWAqH4x0Km4oBhneHaBkGZ/5vF3mYYdK/pEu3PI3eMv3aVIXo8tDQwNMb4J4eddrY6PXgN0zz/l8J1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5gKH04S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69586C4CEE7;
	Fri, 31 Oct 2025 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912449;
	bh=eO71I9W1dx8mvITpEO1BclFCPoZukcO0DrufYccwfTY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L5gKH04S/giSYZZlwXqLRrUywFFLS5WeEcSwMLUH7pT2+C1ndqs1/s7CG9bK3VD/q
	 xZS4ya4UCCMxd95HpZMHLx8Q7X5w67uCXoARLnvtWacGRUH+8YzSWjOyrfpDUhndSx
	 46nDnHRqV9jxvyTUQApePzZu5RD4Yd1FL0N7T07P63l27KjUyBXZStiXWoScwPxm/a
	 KOrA+ozh2v8b0PWuxZJUfK0bL9mdoZJ/iPjEZ1OR9JvVOr+u/1LDt4iFBLrmHSZpYy
	 oeGJVZuNlc8wksrk/qKAFn6FLaiHaGD1QzEXjmckzaNUfxbKXPz+75EwduE4bkrYTL
	 3socSl6zWSM4Q==
Message-ID: <aae9050c-af14-4171-9874-d6c0ae74d85e@kernel.org>
Date: Fri, 31 Oct 2025 07:07:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Some subject line
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: linux-kernel@vger.kernel.org, tiensung.ang@altera.com
References: <4e60eee9-5afb-4c97-8c05-96ab39da62b1@kernel.org>
 <20251031001355.49874-1-khairul.anuar.romli@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251031001355.49874-1-khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/30/25 19:13, Khairul Anuar Romli wrote:
> From: Khairul A. Romli <khairul.anuar.romli@altera.com>
> 
> Re: [PATCH v2 1/1] firmware: stratix10-svc: fix bug in saving controller data
> 
> I am using the same approach for sending the fix to stable branch like the
> I sent and get accepted like the following example recent example.
> 
> https://lore.kernel.org/all/910aad68ba5d948919a7b90fa85a2fadb687229b.1757491372.git.khairul.anuar.romli@altera.com/
> 
> Can you point out what is wrong with
> cc: stable@vger.kernel.org # 6.6+

It should be Cc.

Dinh


