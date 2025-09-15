Return-Path: <linux-kernel+bounces-817892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3DB58830
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 008A54E19AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297828CF5D;
	Mon, 15 Sep 2025 23:24:38 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5ED27A93A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978677; cv=none; b=IwnEvjnAkpI/qsdcKCsgvcs92K8YzC+ZwHE8e5VsBUbavUAFT3MIxVTmv9txorBxIp9vPV1ZwKJLtqfXhZZI6F88TUmY6lx/ubZwgQBxPrz/uNPJaZD2IdA5lUYLbHUoBo4kSLjMiKIcJoyqu44WlYiGmuOgB5ZIGbaNB96f8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978677; c=relaxed/simple;
	bh=YBGSr20gCEOXjQbEZIKirtJLcEsf7gczZA1ljfbtJn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKd+81PM5Fb/SG8iJao6oAH0Z3GbD8B+FW43hxXKegdvpRA+vEXqy/tm8r/7baKXvNxua2zLu9soRy3ppHkj8e/teSUWaABNbKlMhNKq3tCiGBw3APig5X0sHd8QoygGIStAheeVGWJzhVpn5x+1pVd2VrfTWbk6/wIdznXNr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 82C161407B7;
	Mon, 15 Sep 2025 23:24:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id BAE4020029;
	Mon, 15 Sep 2025 23:24:25 +0000 (UTC)
Date: Mon, 15 Sep 2025 19:25:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Akhilesh Patil <akhilesh@ee.iitb.ac.in>,
 Nam Cao <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>, Zhen
 Ni <zhen.ni@easystack.cn>
Subject: Re: [GIT PULL] rv fixes for 6.17-rc7
Message-ID: <20250915192527.38f80056@gandalf.local.home>
In-Reply-To: <20250915073529.20364-2-gmonaco@redhat.com>
References: <20250915073529.20364-2-gmonaco@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bbiurxi95usotmpwfa6ntky1hj1x14mj
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BAE4020029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/WkyYs4yskSbuSx8K63DGsp6Els5mJffI=
X-HE-Tag: 1757978665-690942
X-HE-Meta: U2FsdGVkX19Ri4VPG9fvXMCdc+Ls9vW0yMXhBuLANE/iKLLhBc5fIpY2dikSW9IrQdttk1upsTJ1usEUseKfuPE+G6rm9jm4bJ/frgNKqWvyF/CaDKzHBF3b7UZpuzHRLxSOVi/Vow1T+86H9Ng/sMTsKaFRwhiF9NhcF1+RD7dZC+nzOn4Ai4/oO7q+tTwQKshWUe/R0lqRX4yIie14G8dTiXJrJgUFr/Xk4oz+QPseGm9ZmdkqLzH+5UCOmmyAuNe6x5+n1wYhvB1mL5zttdHwUgFgcTEg2Y5Rh9O2yUOksxXac+kY5+/MBawuOu1c3a7c7QGnUPqTOGiCIw6rDYXCsrA+0ZjFTRiryFPHEfsnOvr3X21Jwaw/RbmxPqfTZDv7qmSfHAG3EyL4xEttfkGodBbYWlz3

On Mon, 15 Sep 2025 09:35:30 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Steve,
> 

Hi Gabriele,

> The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:
> 
>   Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitlab.com:glemco/linux tags/rv-6.17-rc7

Note, the above git path requires having a git account and permission to
your repo. Is your repo public? I can't even see it on:

  https://github.com/glemco?tab=repositories

Also, it shouldn't be "tags/", just show the tag itself.

Thanks,

-- Steve

