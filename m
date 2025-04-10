Return-Path: <linux-kernel+bounces-598596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1ACA84802
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3CF9C34C7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Apr 2025 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F361E9904;
	Thu, 10 Apr 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKRyYtPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E661E883E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Apr 2025 15:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299139; cv=none; b=FFEeZwUSZELG52phBm0IJICvu1N/ydLcSgazaXkICZEdHIOEadN8qiCDEmsVx3nLvOPxQ0P2DWLaa3SwL4e8nE1p9pXJCo9ZjaeWSbUiQGxClqPn4erZkYTYxUwKHhU3QE/Z9nZir4S4XvzG4OuWadHY7iMITCI8oBYB/mSuwVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299139; c=relaxed/simple;
	bh=rTR8izFS9lWAP3rFzV1xKOJ6z1p95b59gQIWlUeyBDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT4dUwRy5jc/3NvCyrBEjK6dOHg6PjEILaFDeD7+bAXlbDyKhw4RanwSkodAsNyaqNsON/Uovz5sdYhcm4y5QqSrRD29b3IMbmY0qbPi679hjQMyDWWxq9kceN1cgOC/Ed9dphRSfZxAVdGnCqDsDiQ0paIAh7OSqTv1tXZOQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKRyYtPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B4CC4CEDD;
	Thu, 10 Apr 2025 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299139;
	bh=rTR8izFS9lWAP3rFzV1xKOJ6z1p95b59gQIWlUeyBDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKRyYtPO1uxmsibmq6Pzn6zQ1RklsrXr+5QDO4xpxSWiFBh+VKEecu7XFqheI6l5N
	 ROxcPl67WOTWNP9iN4dEwuX+qfK/ogpw75AXysmM/1Dbs+7DlRfK4d+XbCnOsee55Q
	 Ej3DJdNorm/5d++VM0ea4ZZLTIFqh6vKmmUY4PgSuG9aOTjsUzYxJ2Qtv0G5Nr3XPI
	 XWbOFMwbbfa98XxOwJOGCxU0N7CXlixtHsecxzBEUt/CTYUrLYV5hl7//PzLXRIb7u
	 SUuUazjewIbTd2jFyqFjsVVMZYw9dhOJtIXHwDlIlC3+MjqM4Oes/3YGpyFwqbZrZv
	 GubMvAtGZKKOw==
Date: Thu, 10 Apr 2025 17:32:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] timers: Exclude isolated cpus from timer migation
Message-ID: <Z_fkgN1ro9AeM1QY@localhost.localdomain>
References: <87ecy0tob1.ffs@tglx>
 <2c9d71fd79d7d1cec66e48bcb87b39a874858f01.camel@redhat.com>
 <Z_fBq2AQjzyg8m5w@localhost.localdomain>
 <87wmbsrwca.ffs@tglx>
 <Z_fHLM4nWP5XVGBU@localhost.localdomain>
 <4fdc6582c828fbcd8c6ad202ed7ab560134d1fc3.camel@redhat.com>
 <Z_fTmzdvLEmrAth6@localhost.localdomain>
 <56eae8396c5531b7a92a8e9e329ad68628e53729.camel@redhat.com>
 <Z_fcv6CrHk0Qa9HV@localhost.localdomain>
 <1c60e19d1cebc09a8fd89f073c3dbec80c8ddbf1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c60e19d1cebc09a8fd89f073c3dbec80c8ddbf1.camel@redhat.com>

Le Thu, Apr 10, 2025 at 05:05:52PM +0200, Gabriele Monaco a écrit :
> I'm not understanding what is going to be invasive in this case.
> Aren't we just talking about not allowing isolcpus to pull timers from
> other cpus?

Right, but in order to do that you need to avoid remotely executing
timers. And for that we need your initial patch (after reviews have
been addressed). Right?

> Let's ignore for now the global timers started on those CPUs, I'm not
> aware of complaints regarding that.
> 
> As far as I understand, the change would allow timer migration to work
> normally out of isolcpus and among housekeeping ones, we are not
> forcing any migration that would potentially introduce overhead or
> missed timers.
> Or am I oversimplifying it?

Global timers only migrate:

a) When a CPU goes offline (but they should be migrated to
  a housekeeping CPU)

b) When a timer executes remotely and re-enqueues itself.

In order to handle b), you must make sure an isolated CPU
can't execute timers remotely. Hence why it must be set
as not available like you did.

Or am I missing something else?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

