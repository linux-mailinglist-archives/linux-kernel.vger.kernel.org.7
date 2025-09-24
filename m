Return-Path: <linux-kernel+bounces-830604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFDFB9A17C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EF5189AFED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D37305058;
	Wed, 24 Sep 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eY9Wnyj4"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10392CA6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721511; cv=none; b=apAeSBj+xQNor9X06PWegMjQGsLclVQJJdaYKXDSPP7SY2Qd6OEj/mrZcnvjKqPtVo17qeDiQLeG+OvOxi9u+oeNZuhRitCSgiHOgTc5mbRVGIAYZTIeW+of2oVi/TEd5wH8dDn/V5Z5rj94nbe1N3myB6WA9BZUyxI6RjD6A30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721511; c=relaxed/simple;
	bh=XpovNoQrHLDRa2d3bvXHRdOCQ6hCK4CZOtSjxOfSRPg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=C9wA7CHLPlevxN+m7Mfm8/7Et5PqBmCP90AqbetxFhvkGt5k/plqB/CFR/UuZ1aWbnN5wTrhX55Oqqee9X5SbJAxjzZ9CR8D7xcpQe3bEwWptS2g/1K8jhoWKrEOEOMGoyS0AWwY4trwr4D2Qk2xgi4qECg3mSi6KHkFRW/TJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eY9Wnyj4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758721506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpovNoQrHLDRa2d3bvXHRdOCQ6hCK4CZOtSjxOfSRPg=;
	b=eY9Wnyj4ml/7oZauWpjSqHWXWOekHE9SguB1/bZ1rlD5f7QsVFxXwNDgdcaUdwGraeqHCY
	uScxc9Ij9xFTqJSUja/X+tpQPZGoRjQHiF6hYavlyiPwBYO6QhTxgkvj04fO/bwxYlRQq1
	UAHzy+1BzS0XBXvCWOUTIZi8GJ+T9VI=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] nilfs2: replace vmalloc + copy_from_user with
 vmemdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <CAKFNMonHxWSxW72Af8F_3Mhx39iO5hgVKAhTjpHVKsTBOQ-Z8g@mail.gmail.com>
Date: Wed, 24 Sep 2025 15:45:02 +0200
Cc: linux-nilfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2B76A58C-8AE6-4DAF-9B6B-7927FB301F6B@linux.dev>
References: <20250923120902.1844458-2-thorsten.blum@linux.dev>
 <CAKFNMonHxWSxW72Af8F_3Mhx39iO5hgVKAhTjpHVKsTBOQ-Z8g@mail.gmail.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Ryusuke,

On 24. Sep 2025, at 14:18, Ryusuke Konishi wrote:
> ...
> So, rather than rushing it into the upcoming merge window, please let
> me schedule this to be sent upstream in the cycle after that.

Sounds good as this was meant for the next cycle anyway.

Thanks,
Thorsten


