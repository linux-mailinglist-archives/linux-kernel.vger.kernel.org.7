Return-Path: <linux-kernel+bounces-832897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29588BA0B23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAB61888C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D12D73B5;
	Thu, 25 Sep 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="b8kwmaVI"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044815B971
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758819012; cv=none; b=G/eYLEWbJza6puT4+ekwcHyiTaZF9HblscaiqFSfOKAm2PJ8ixqL2THALgXCVckZFJmjwgMzW0CgMARvqQoVOjhPenoldKvhVIQVOVAgiF13UetSUnuxLrIUc77MlkkEc5dGZWFO7oElYbhSPNd8EUEuoCFCxayuNMjPYomNusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758819012; c=relaxed/simple;
	bh=pqhNLFE5537Zd7lm9ARTeL/eHjtEE3MTmkUfs/GFqaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnPFP7q5A16VWANwf6ZhyntJ0WzLwE/xmVjZJKEURncEzCSBoZajZspAJbGTrFVY9hJTQFm9kXr9UrNsO6QkPyAvrE846mxghNKwUV2NZL0r1e2NA8J+iMgjUAjNjv96nH8SL/ScGeF2UnoWLvCiAiVhcituSxJjPj+yavVqjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=b8kwmaVI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758819008;
	bh=pqhNLFE5537Zd7lm9ARTeL/eHjtEE3MTmkUfs/GFqaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8kwmaVI3MIXgHdPl2mix631cT/h6cIj1HsWrq4Y4j3ME27hpTq0HpyA2upQSa/o/
	 7NrJGeJ0xZ7hp7ilfI2R9x1ruWcAx/8gobevIg4HJogz+SklN7No0rfk8ukW+McAx1
	 ZhjDlI2Qj9+kJOtUITPX0Wz5bwwiTQc1ZiRuahig=
Date: Thu, 25 Sep 2025 18:49:59 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-dev@igalia.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] tools/nolibc: Add stdbool.h to nolibc includes
Message-ID: <f1c699e2-a371-42f0-931a-554ab0027c5f@t-8ch.de>
References: <833f5ae5-190e-47ec-9ad9-127ad166c80c@sirena.org.uk>
 <20250925141423.504427-1-andrealmeid@igalia.com>
 <7e8b9f3d-3888-491f-95ad-954fcf48dd00@t-8ch.de>
 <d0f4c018-bc74-4099-82b7-ade42db26c41@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0f4c018-bc74-4099-82b7-ade42db26c41@sirena.org.uk>

On 2025-09-25 17:24:18+0100, Mark Brown wrote:
> On Thu, Sep 25, 2025 at 06:15:07PM +0200, Thomas Weißschuh wrote:
> 
> > As mentioned in the other subthread I'm fine with this.
> > How urgent is this fix? Can it wait until my regular PR for -rc1?
> > If not, who is going to send it to Linus?
> 
> It's pretty urgent, this is a build break for at least the arm64
> selftests in -next due to the commit I mentioned with a fixes tag which
> is in the tip tree.

I pushed it into the nolibc for-next branch and will include it in my
6.18-rc1 PR in a few days. Let me know if this is insufficient.

Thomas

