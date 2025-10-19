Return-Path: <linux-kernel+bounces-859884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462EABEEE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 00:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072123B8E17
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 22:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56248242D79;
	Sun, 19 Oct 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kEtCCcrp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB60C23F26A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760912588; cv=none; b=YMZzTN/NwY5bUqrTr1x9mdYV6XEN2B6VaeX/GhRk36DBB0dqj94bMR5Q72vCWoWStwtaAMMazMAoWJmyYm++93Zsbkyxu4wtA2Mp2XdJJe5t+yfOZVda3CRblZ+kN4FW8AMlF4IObj64O6wUuoUPrAKJcaNRjz1owi1EdRvdSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760912588; c=relaxed/simple;
	bh=ctmg1EXhueThiLWG0LsTRh1bigPEf+e1MHQVeRQghxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNTBR+/UoD+ETh1LzsmPhOpem05IX139fX6GOPKlz0UYubBf3aCLg5aFvCp0iyvJBEs65o860J+RRS7ljaZKFBkwZJNTA2rGMKmdSeJwNFwLrR3BiGsidlyM9gCQLpCdkDP78l633JIhKQcdi2FSP5/6X/C2TPwxlFxx0ji9F2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kEtCCcrp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sGrnNAs9+cdtm6OcOINRTbJyGmPmjotXDSPk4S0D4XA=; b=kEtCCcrpsmA2ZDuaU5wUA+ZHyW
	NIikt5kqRiFsa54BJN97KSIOGwSo/h/ZfiQn/lAzghPPL7+2CROTg2/5VN2JQ0jzszZczqWdswM+Z
	O8HAc7m7Ff4QTKk5Pq1EDrRfvu5vjZDCULeoIEHUeAlv0pqrFH8iyez1WJC0+FXutXa2VPbHvgpGW
	wh5ibMrsPTPb5jLkuMo8KvhcEtKG2oJrWkbeqTLdjoDOlBNLwm9Eh6JCSUqw7OhzgAfcnsZo4zZTR
	TuxeLb5uOlKSMasWzlICFnTu5SA5XLOCc7F7Btk6vX9q2/xHo68KxYgrx2eRjKh1+e3CRzxUXdlTG
	8LlxobJg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAbno-0000000BUzm-2Dbu;
	Sun, 19 Oct 2025 22:23:00 +0000
Message-ID: <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org>
Date: Sun, 19 Oct 2025 15:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
To: Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Cc: Andrew Chant <achant@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Francesco Valla
 <francesco@valla.it>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/19/25 10:06 AM, Douglas Anderson wrote:
> The kernel cmdline length is allowed to be longer than what printk can
> handle. When this happens the cmdline that's printed to the kernel
> ring buffer at bootup is cutoff and some kernel cmdline options are
> "hidden" from the logs. This undercuts the usefulness of the log
> message.
> 
> Add wrapping to the printout. Allow wrapping to be set lower by a
> Kconfig knob "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". By default, the
> wrapping is set to 1021 characters, which is measured to be the
> current maximum that pr_notice() can handle. Anyone whose cmdline
> isn't being cut off today should see no difference in log output.
> 
> Wrapping is based on spaces, ignoring quotes. All lines are prefixed
> with "Kernel command line: " and lines that are not the last line have
> a " \" suffix added to them. The prefix and suffix count towards the
> line length for wrapping purposes. The ideal length will be exceeded
> if no appropriate place to wrap is found.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  init/Kconfig | 10 +++++++
>  init/main.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 92 insertions(+), 1 deletion(-)

Is this (length) only a problem for the kernel boot command line?

What does _printk() do with a very long string?

thanks.
-- 
~Randy


