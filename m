Return-Path: <linux-kernel+bounces-627756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3988FAA54B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 21:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD5B4A8021
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 19:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9161E5B63;
	Wed, 30 Apr 2025 19:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="csttqmiJ"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9FF19F11B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746041763; cv=none; b=eKQv0GCpAZ2J2ndn97/bGKYoiByjCigQqkP6fz7HU3mNj4XXaXDRYEBoCHg5R1xKJYosezZDZCy2k3ZNJer0vNn46VDZAA38fjtjlQVa2mbUqIYqrKxOZOG0I1WqNVxguYW23WbKPNxV3qqNfETdhBdVcdCJ1RDQp7gZHqfk65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746041763; c=relaxed/simple;
	bh=VKBACTm3rLlga04gA2R7WrNWXUzo22seS903vbgz8k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpKPEOdC/l2wK1uTzO71eiVUghEtRz7A13mzIb3vO7YN38ms10EcYVQYiaBgSs1+8c/BeIhTAHL51ggoWqBLJoAU64zJuidWsnpcpnnK6sLPa8LFCwQesw8lHdc+uJFqLzMuLR0KNRNAXwoXuhZb9DZfFi0DRZ0VEZEAM+u5Dcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=csttqmiJ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 30 Apr 2025 15:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746041749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=by7iT1Lkxuic4hLl3vZg4XTvPyRtN1erZjBAaEQxpvQ=;
	b=csttqmiJbbLNzTNs9KXlja/4IeptEJYrpbW5t5yXxpj6YMDg7iNnHA2c5Zw/g67T0nMKNY
	E8zXYDrhyoukw/RhEQ9M4ubCIX8ZfHSWzDJPLdHUfbmaLS7FGT+TPjdkj/R9Zch/U6w7ym
	CUJ7D7awJWqnIS3/XCQRVweILvF6GEk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] bcachefs: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <zn74qlanwd3b4wmyecn7ostb6i42ceycaa2myijimfsrs3eglc@tsgoa3zbe6ue>
References: <aBJ4WVcvHv9sD1K6@kspp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBJ4WVcvHv9sD1K6@kspp>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 30, 2025 at 01:22:01PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Refactor a couple of structs that contain flexible arrays in the
> middle by replacing them with unions.
> 
> So, with these changes, fix the following warnings:
> 
> fs/bcachefs/disk_accounting.c:429:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> fs/bcachefs/ec_types.h:8:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Applied. Presumably you only need this in 6.16?

