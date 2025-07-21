Return-Path: <linux-kernel+bounces-739941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84881B0CD5D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 00:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FC96C1A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0D242D63;
	Mon, 21 Jul 2025 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c+YxvjEw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FDE8F40
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137807; cv=none; b=G2LaF/JEhB0pWKVxYYNwZ8gZTNiVs7nXh0J6bjQD4eKPfh+/mck8D5/X+VeAamrp+dSUVDnV1UCj70u+g1fKY6C0GYmH57I2eplYGr4SvDsYvgBq91KXkfG4Zt0aOzobpgKCZN2shoy0gg2deFErgx8U3V0uogzAn2MNvDkFYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137807; c=relaxed/simple;
	bh=N7MEnGPgiNjbf9/JxewUUYr9KxuBLTGr0DWG7tEXrhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mfK7YzYXIr8mqYAw13cw7NslfPt/cEPZyBCemeCDpBkYxevTeuLqQK2lznvaamg1xveKA6t4Gs0/CF4A3gAVCUMbFFsr/01dl8rOqhEiiP9nQvxZltFnwpTJrlxalVpZJP9jYeKTPhT4Et6F96LUt/h47uHiFia2XfuN7LSYzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c+YxvjEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6830FC4CEED;
	Mon, 21 Jul 2025 22:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753137806;
	bh=N7MEnGPgiNjbf9/JxewUUYr9KxuBLTGr0DWG7tEXrhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c+YxvjEwL4sJ6gBiebFHp8LJSrbzxUM4Gr3Q105ypgeRo2A4vGcxBEvZ6zhSMd0Nr
	 P9RCDcsCcplwzVITVpXHnAJ9iJmKzvPdY+ygNpQuyzvSEeQfYS8sappXrpEE9bPG1I
	 G7PtE08RDkyJpS7S2xV2PoROwJIJ8KScLL50h7Es=
Date: Mon, 21 Jul 2025 15:43:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman"
 <ebiederm@xmission.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, Alexey Gladkov
 <legion@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, MengEn Sun
 <mengensun@tencent.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <linux@weissschuh.net>
Subject: Re: [PATCH RESEND v2 1/2] ucount: Fix atomic_long_inc_below()
 argument type
Message-Id: <20250721154325.476b87e09aa5d778bcead478@linux-foundation.org>
In-Reply-To: <20250721174610.28361-1-ubizjak@gmail.com>
References: <20250721174610.28361-1-ubizjak@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 19:45:57 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:

> The type of u argument of atomic_long_inc_below() should be long
> to avoid unwanted truncation to int.
> 
> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")

Please (always!) provide a description of the userspace-visible effects
of the bug.  That way I (and others) can decide whether the fix should
be backported.  And people will be able to determine whether this patch
may fix problems which they are observing.  Thanks.


