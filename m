Return-Path: <linux-kernel+bounces-833493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF59BA2262
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D472D1C803A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7509C1A2545;
	Fri, 26 Sep 2025 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ7wWAl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960E1373
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758850270; cv=none; b=pU5Oj6cqm0SczRwRIiE0OV9qnnm75dY9YU5QMoI94Xk+A2ah0NLzbQadwR7eXDwYs4lzb0Rj1oUXKXTbln7/FkmFEUiGmK4/g+NROGWTHX6XclrzRUJAvIJgH5M4DJParViTGBbg6b0RvIyuZSKYS5RIhU6VTp4UWQBB7HGIGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758850270; c=relaxed/simple;
	bh=iNA+wJMZ+8s7eRbsfY94GPURAntNPp1CCNjYGaoZuGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpWrZ39UMPu7o4PkePBlrVKgmMJtCPSSXdKPrTNem5akYpCPvekXEPpFBSTn88v08aTJ8JtLPmags4Y/SEnEGHXKGyDqpTLJVsMnE4UCs/rkcuvvsgYeTlotUyCmwozPZYWPAFMAubSS3cOsQk6gxTR8v0SRXwU2jQjIuEP/v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ7wWAl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48938C4CEF0;
	Fri, 26 Sep 2025 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758850270;
	bh=iNA+wJMZ+8s7eRbsfY94GPURAntNPp1CCNjYGaoZuGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lZ7wWAl0IiYK6QEwtk/6h1LZb17zcXVIYX53Si8jBKaqSaYDsothM+q1GSFuqeGAX
	 /1N5x4zwR7PpWVKmPjTXWes8lGt6bo66YKzw+H3IxQ4OqCuYit49YJzYlFwnMUpapT
	 BVs6asaeMSMPIEJhYgiw5zCLCplFUKNjeBuFHAnejbeoBPIbJ73HN4d3js6JBofmlW
	 BihppjMhG9FEXMU2xbHdFQ3sbVd/ifY3wYoIDFcbqGGZgjWUtlstd+rxRPbUdvhDh9
	 VxehmzO3Fk6kaswjBl5LxSLwTsV2mG1rmUBdk7NF7uve+2xHkiqs2QEhwxZt28iVIB
	 GuJ0UwGW7QblQ==
Date: Thu, 25 Sep 2025 18:31:09 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alejandro Colomar <alx@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v1 0/3] Add ENDOF(), and use it to fix off-by-one bugs
Message-ID: <202509251823.1B974C7@keescook>
References: <cover.1758806023.git.alx@kernel.org>
 <20250925134814.1f68d84a951572245893abbe@linux-foundation.org>
 <202509251657.F4ED4CF@keescook>
 <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2M+v5wFQLK3u3DuchpCbuHF8Z7_if3=foECVRXF+8vg@mail.gmail.com>

On Thu, Sep 25, 2025 at 06:05:25PM -0700, Linus Torvalds wrote:
> On Thu, Sep 25, 2025, 17:00 Kees Cook <kees@kernel.org> wrote:
> 
> > And it's really ARRAY_BEYOND. ;) I don't really like having APIs that
> > require holding pointers that are actively invalid, either.
> 
> That's not an invalid pointer. At all.

Sorry, I mean to say that it points _to_ an invalid location. The
pointer is not valid to dereference, but its _value_ has meaning
(relative to another pointer).

I can have an opinion about the relative safety of holding pointers that
can't be safely dereferenced, though. :) But yes, I've long since lost
the argument that C should avoid these kinds of past-the-end tokens.

-Kees

-- 
Kees Cook

