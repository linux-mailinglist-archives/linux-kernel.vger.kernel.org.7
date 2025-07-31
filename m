Return-Path: <linux-kernel+bounces-751812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6901B16DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3A018898C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AA29DB86;
	Thu, 31 Jul 2025 08:42:03 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1540F2E406;
	Thu, 31 Jul 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951323; cv=none; b=iUe7HflVsIua6GwiKBLQPvV39sZnSKbMQvgPx76fLXBI6wUZu5VyD4xKaWvrsQSQEKSjxHt2YDpB1fmw4de+Go03vnkdTB3uIn+H+gLLo3I3pizFjqxnjph3RS41fNtb+F3C+jI8OSlnOKBB7ak7AiMxBiQf70AaeMF8zdeTcSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951323; c=relaxed/simple;
	bh=F9tkCsL6a4gyeZZ4OKD6e3m8Wz8vci9RQ/qtrNhbjNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG3xvevJ1MCIh7nkPk0QCD1ZxEMpRgDZMtRF+1HnN3gqVWniCLwZiHzdwNGCP7JJqF/xUGP11P0npi6URE7CBmsIaQ/Wdi/DTc9bcKV32YtVUcBRRtp+YUPYQNjdkFcqedY1nSJqX9C79IE+I/xXt/TT3o/cnG9lBAQQ4EYwuIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56V8fNIV023009;
	Thu, 31 Jul 2025 10:41:23 +0200
Date: Thu, 31 Jul 2025 10:41:23 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: fix error return value of clock_nanosleep()
Message-ID: <20250731084123.GA22919@1wt.eu>
References: <20250731-nolibc-clock_nanosleep-ret-v1-1-9e4af7855e61@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731-nolibc-clock_nanosleep-ret-v1-1-9e4af7855e61@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jul 31, 2025 at 10:00:31AM +0200, Thomas Weiﬂschuh wrote:
> clock_nanosleep() returns a positive error value. Unlike other libc
> functions it *does not* return -1 nor set errno.
> 
> Fix the return value and also adapt nanosleep().

Good catch, I wasn't aware of this either!

> Fixes: 7c02bc4088af ("tools/nolibc: add support for clock_nanosleep() and nanosleep()")
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Acked-by: Willy Tarreau <w@1wt.eu>

Willy

