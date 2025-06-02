Return-Path: <linux-kernel+bounces-670881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E159DACBA73
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 19:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59E73B26F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jun 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C769226CE4;
	Mon,  2 Jun 2025 17:47:03 +0000 (UTC)
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B21A28D;
	Mon,  2 Jun 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886422; cv=none; b=a/5QknkWoAXkEQFO8L2ytPCD4MOp+qdPvhiXuLxWjrbMlheOqmKmpagDaPsi+/YCHhm59wySgA/fPs8hLKgBu55PKOvTyKv0QJB8ewsV0sBln7klbi2Cw5zOyRz4cm7tDAW/0APyXWWdzgt2EyAeIqbJEUODWQQiRcV+20ClTIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886422; c=relaxed/simple;
	bh=ZRP8C5tV4Lf4EEr8yH2sse5dwTbENYOSXQ8PYBVP9j0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ck5PfzeyWFRhCO/dD8Ref3Mfbcr4SW428J4Zh0pvhWpIjSngHzQP/UrWmtO1cZBeZc0i0l/lu2pLxqD4PbTTwNmQZQJgR0EHo2NlI5/icyvj3DepleLxiO9EZvAi2xgr/dvaN9s1AUrkHEhqGJwuV4+/YhwPqWp3glADhALeqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id b6d5fd31;
	Mon, 2 Jun 2025 10:46:54 -0700 (PDT)
Date: Mon, 2 Jun 2025 10:46:54 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Linux stable <stable@vger.kernel.org>, 
    Linux kernel <linux-kernel@vger.kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.15 000/207] 5.15.185-rc1 review
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
Message-ID: <2cb71dc9-a16b-5694-cb3-60a1815bdd84@aaazen.com>
References: <20250602134258.769974467@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Jun 2025, Greg Kroah-Hartman wrote:

> This is the start of the stable review cycle for the 5.15.185 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

The new kernel works fine on my miscellaneous Intel and AMD machines
running Slackware 15.0 both 32-bit and 64-bit.

Tested-by: Richard Narron <richard@aaazen.com>

