Return-Path: <linux-kernel+bounces-851204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A8BD5C35
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 589F03512CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114422D7381;
	Mon, 13 Oct 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjkR3Pjw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670CA4C81;
	Mon, 13 Oct 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381068; cv=none; b=N0N05/WAKcrwy8kOz6qk4+eVX43Ymb/QQeYMNK+4uVRV9fnT7TIdyRibKH8iIJncNYz2FDLsvTE0NTwKUfgJ3I6+IaTcBYc8HJDpgFLj/syKMoIPinutHil+QWKOXYVaoQ7ShWJe1jFRNKLndlouQoS4YCUWEXoGOhb/n9aiY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381068; c=relaxed/simple;
	bh=InByBTsCq4HZFvNKDvEYwuUxU9EgT7FAJcnx8+I3AqU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Izf0xIdk5ZALmdJFevyM4bh2tFktJ0dF+PWV2eWqsXJ0lOIT7HbOhjASyNouVyRpVefGxrq0w+VOJG6oMIT0dVUJRtRaOiTUdU5HI4kf+8eWH7xFjyL2vMF6NbMr5jsJojgT0E/793dMUKGHEfmvrXOQrs+SXjBvzf9WVWnQQOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjkR3Pjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BE9C4CEE7;
	Mon, 13 Oct 2025 18:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760381067;
	bh=InByBTsCq4HZFvNKDvEYwuUxU9EgT7FAJcnx8+I3AqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjkR3Pjw87qxlJf9Bu1B1vfXDDpZCb2Y5yuLD0AhVdeV+OS1WwleYceE9LaZ9c++Z
	 6XSJk3uh83G1QOaST3l1Q3aP8cZeXqT+2WN1QLd9kKXjMyRSB+WMNhzFTSmbgL5Cfs
	 lrzt0bvV1Okj3ZYFhe6+9HGXjGgsYVsmXcQlrc2r8CwzgzMCnjtBbRM2ic0epnLlLK
	 vcLxQ++VGzV4kCPjX8g7SrSWtwZskRWyMJuK3HrcADopJYgJQigaD7tqfy76gxgfde
	 5qxfQlKFaGOiSQDzS+bnMQXwU2+r7igJKwkPnCV7fhDxcTwNsazcYQ2HTnfnY8pfUZ
	 TDc5ITnv1p0Iw==
Date: Mon, 13 Oct 2025 08:44:26 -1000
Message-ID: <27ed885043e6dc3e9c2feb2e9a247658@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Phil Auld <pauld@redhat.com>, Andrea Righi <arighi@nvidia.com>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()
In-Reply-To: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
References: <aOb3Hv0uPv9G7N33@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Tejun Heo (1):
>   sched_ext: Allocate scx_kick_cpus_pnt_seqs lazily using kvzalloc()

Applied to sched_ext/for-6.18-fixes.

Thanks.

--
tejun

