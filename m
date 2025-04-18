Return-Path: <linux-kernel+bounces-610470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53545A93569
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40197B39CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DD26FDAD;
	Fri, 18 Apr 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="BfQUkBeB"
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB7270EA8;
	Fri, 18 Apr 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968912; cv=none; b=dxCyOf/IB43+10XKAYdda9jSo9LgEf+VMWF2e8N8BSgPZSHax/bBSMRzN1tXTUiZZVHC/V6KYNzjoulrQyqTsgl2Y4P+sivQnzG3HGwIHggKQGADWBp6xq+zTRYp/nNhydry865UwAHpy3x/bsbNRYqTwTGMPRh6LpkwBHyeH+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968912; c=relaxed/simple;
	bh=rJO4vviO64bwktMRl8q9a/drY1vYVilmScFMDO/IFi0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Jt/hQpsXBZ+QO9c8R1DQHV0DXkMgNcrTs5b9MrheyTYOsKsRrDMigYy3g9Er7qFA8nbTPvQ1IND8eSRyxHy8UaK0f4cwb5x4YRLOZUpKz9mWyPK8eA9EH8fLmtxzZTFeLX2j9IPsUsHP7HJr5MSioiTYHXt5DzmhYHeBc+FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=BfQUkBeB; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Fri, 18 Apr 2025 11:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1744968405;
	bh=rJO4vviO64bwktMRl8q9a/drY1vYVilmScFMDO/IFi0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=BfQUkBeBGtq2dWZlnhxw7vc9TVnNc46p0T/nJBm3ZUS3vL3oyW9IhhQS1Jch56XaF
	 JdXOXEysfdse7AkmcVi+R7G+lWtZa+JhJW9vVLgox2cMc/2VEYLilnJvtjaYe/k7PE
	 SFtE+eHG34QIvs5B00o3TTcQfPGU15avQBMjATPmVbfzZay+Ud8hjCWNTYIOJmzLaX
	 ZKsLXfQ58o6p4tezbKJHUlL7s2YDYfucbPA8jmp7Mw21XeZN+qVzvz4cLxBxjR9T6F
	 lGwdLHxAzeIya+NgFeEKb/jQ4JqEhR8zZIHjNrM02wMLhwhwzD/ETbzXk+zLEHNXuP
	 96223WA/MQiFA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/393] 6.12.24-rc1 review
Message-ID: <20250418092644.GC19185@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250417175107.546547190@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.24 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.24-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

