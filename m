Return-Path: <linux-kernel+bounces-887093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE62DC37422
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA753B4702
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF1285060;
	Wed,  5 Nov 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CGGZMa0B"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE015D8F0;
	Wed,  5 Nov 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366347; cv=none; b=dVMDIyBxtzrRv+jfjpgGOJyT7gs/+7bKG02aO0Lxb7J0G13doKRQiIwFrWHe1dbNjemQK7P/ocmmZDdyBolYagf0pgKJV/ydZWkRHu0O4ruXvqqujHO8uxmHNvsLNOkELYnRbxs0ClNdfCjnA9aStZ+XD4jvl6psC2Wv5pr5MBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366347; c=relaxed/simple;
	bh=Kr4AUg5c8tYA0fSxDJXGDbo7ezUmg1Xn/Iw0mevV2CY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awPV9Ha7B8pWBcEaSYNf/qO+S/PybWGcr2GC4A1Jgnlg7QBunBChoTsu6J4JnnAk49mLQ+eH5iie2vv/JhITTwSfjLQgJrhh0vKEhDz+cdpyAmBn5hlxSLSEKy7yWTmXhTasz73BT7/vZdfaX/ln37hv+9jeg8txPo137vREh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CGGZMa0B; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 42C4E40AFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762366339; bh=nbMZFueQZmHBRLNRoW9wQ+q3tHwKsMZwDfsDwdImn9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CGGZMa0BAxjYip2v8SgEXyWKzUZO1N0kg9G65YMUFQiJQB3GxJb9z5w9Snzwi9uju
	 Jmea0aMHUIptB7LhlktHKECBHhdLNszMJUfG0YogtCul+9MQ6hD/yaEL6J/s7SrANr
	 jK8aBw+ihAwV0HhokC8fgPQV8nVYcQ/UZ/71H4afXINGrF2sF4UAN+12RIUVW7guP+
	 e7vF+NiVsEHrI5ZWOv6KohIrKuxuHE7P3uUTbg+2Jq5HhiZ3eu56j17SMNqb7xf3b5
	 3s0NNUKw9+iGYd0IrLV52AQlXQjXn7NdOR+TVZ+MHgNrGQOcnfWMYFjsG1pT3syLAY
	 7O0gZAlsG2jMw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 42C4E40AFB;
	Wed,  5 Nov 2025 18:12:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mauro Carvalho
 Chehab <mchehab+huawei@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] kernel-doc: Issue warnings that were silently
 discarded
In-Reply-To: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
References: <20251104215502.1049817-1-andriy.shevchenko@linux.intel.com>
Date: Wed, 05 Nov 2025 11:12:18 -0700
Message-ID: <87sees73i5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Heads up to Stephen: this change will add a bunch of warnings that had
been dropped before.]

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> When kernel-doc parses the sections for the documentation some errors
> may occur. In many cases the warning is simply stored to the current
> "entry" object. However, in the most of such cases this object gets
> discarded and there is no way for the output engine to even know about
> that. To avoid that, check if the "entry" is going to be discarded and
> if there warnings have been collected, issue them to the current logger
> as is and then flush the "entry". This fixes the problem that original
> Perl implementation doesn't have.

I would really like to redo how some of that logging is done, but that
is an exercise for another day.  For now, I have applied this one,
thanks.

jon

