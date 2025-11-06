Return-Path: <linux-kernel+bounces-889461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D2C3DABF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 23:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 414B94E57E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 22:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C43043B5;
	Thu,  6 Nov 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lzfrC05A"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A34305E28
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469231; cv=none; b=AZAGKCxItRII4VafRKsiEDkP2FGO6vxg/BdkZMN+5DBWwildxeVFXFroQeLRh5vE8k5AlIpVZsFNmSVq0aIW7G4fUMd9pJ2tTOng56durAZUug6Q9GqaazODDXMSZl4Is+5Fe18L6MJKqIEryVI7JMq3iP327i5BSNLuqKnlBUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469231; c=relaxed/simple;
	bh=bxCK7Am/J/1Ddo7TSZsvpwD8cdBJyrYfhoG3eyACE28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdOG05XDcTU95C641rMGf4Z5lLaOA8EtWs1W9mW89zKcLlYDRrmhFnjh2bc+96wUhUO5FlzkXRqTNoPWWN9X/F0RhYvJSLb/u2rO6aGRnLU4goHNejH+yNMapwzXP7dCSbqt0ryF9mx8xgHhdaPZi59jzUgdT0dfp//QLt5CbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lzfrC05A; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7FE6D4E4157C;
	Thu,  6 Nov 2025 22:47:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 54BC1606EE;
	Thu,  6 Nov 2025 22:47:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 720C811851833;
	Thu,  6 Nov 2025 23:47:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762469227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=SPs8R+Z4eyPWDXZ8OJOkk6d7mA/bu9hQxInYciv//+A=;
	b=lzfrC05AemjRCIC6Ku3CAja8qwjKogVYQ/w+c8EYAhIP/GI14XolTamie8Cf1In1gelr1E
	f4I8sw0w3575yy1wI0YRlnd307ii3hDzhjmvtDeA/1Z92Ku96VmMGG11prrZ/5sWzQvgcZ
	6yspWAUgPS53Rgfi2SV5nIkwn7c2Nz9C1oOHGDNeWAtXJ8ZkcBCEjNsIno0gkCbFzQUt3u
	eR3OyIfQMtDKVf5Ua7ngabNWt5G2o+mauFonhhWwpWJtDsO8lOJh5DHMrs4aojM62QFV5F
	k1+pcM5rQNHJm1yDrQOybBh3aWIV3ilgF7W+W80ORLWHCv/Qb1tfxnpFk3lQwQ==
Date: Thu, 6 Nov 2025 23:47:05 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	CL Wang <cl634@andestech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, tim609@andestech.com
Subject: Re: [PATCH V6 0/3] rtc: atcrtc100: Add Andes ATCRTC100 RTC driver
Message-ID: <176246750570.34507.967877032441742538.b4-ty@bootlin.com>
References: <20250915031439.2680364-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915031439.2680364-1-cl634@andestech.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon, 15 Sep 2025 11:14:36 +0800, CL Wang wrote:
> This patch series adds support for the Andes ATCRTC100 Real-Time Clock.
> 
> The series is now based on the rtc-next branch from:
> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git.
> 
> This V6 patch series is built upon the V5 series and has been rebased
> exclusively onto the latest commit in the rtc-next branch, which
> corresponds to rtc-6.17."
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: Add support for ATCRTC100 RTC
      https://git.kernel.org/abelloni/c/e1794c59730a
[2/3] MAINTAINERS: Add entry for ATCRTC100 RTC driver
      https://git.kernel.org/abelloni/c/a603092d5be1
[3/3] rtc: atcrtc100: Add ATCRTC100 RTC driver
      https://git.kernel.org/abelloni/c/7adca706fe16

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

