Return-Path: <linux-kernel+bounces-806190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564AB49329
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34E3920455B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2908030DEDD;
	Mon,  8 Sep 2025 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="h5PWWhI/"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28ED2E8E12
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345157; cv=none; b=pnq9/0aosENkynncG29YLESrrFmT6+nDdZM8+VHf8P0bDBKlfQp1ha/kl8XdlYvm+zvYpR16MMR9K9Wl5Pm2yPsc2nMjxK0EFS8QlGVbUC44ynLrGWv3wUbO9lI8GHcX0A58QvC2kavpHjz3zpbDXhdGaV0ETUlOgUI95UrfzKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345157; c=relaxed/simple;
	bh=kKNgUdnpjbd19H18Gsk3GITQ9Z67++kPL7jTcMUjT1Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sfulYKcLZtpEmp8lkIJhBuo+RZs/AEY4KDII3rsMicGJClMLDSG+HRCwcju9roCYVExsm9WUg9gaueuKiCvEQ79IQSqS2ICDKRjC5mXkkOm/x/T3iP4BJz1viBBCPIoGC2cgyo27lXTYfEG4SIKMFeEmBcev7gKJqsQpHlZ1a3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=h5PWWhI/; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1757345148;
	bh=kKNgUdnpjbd19H18Gsk3GITQ9Z67++kPL7jTcMUjT1Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=h5PWWhI//okwWzSN9htNz0pCilywJtE0zHgRPyp5HJwv1seYORkVbGWxEwxxBbWdb
	 k7TJrHlhbRA2amPYcxUDjkolyec+6P+izJEIWmNRBsArmn9yhzdpdC6g6apr0v37Ux
	 u6WVQJgzExlV4UBlVb1OQm9PwWStdveeL0DDYQ58=
Received: by gentwo.org (Postfix, from userid 1003)
	id BBD60401E9; Mon,  8 Sep 2025 08:25:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B9D02401DB;
	Mon,  8 Sep 2025 08:25:48 -0700 (PDT)
Date: Mon, 8 Sep 2025 08:25:48 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Frederic Weisbecker <frederic@kernel.org>
cc: Adam Li <adamli@os.amperecomputing.com>, anna-maria@linutronix.de, 
    tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, 
    juri.lelli@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com, 
    dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
    mgorman@suse.de, linux-kernel@vger.kernel.org, patches@amperecomputing.com
Subject: Re: [PATCH RESEND 1/2] tick/nohz: Fix wrong NOHZ idle CPU state
In-Reply-To: <aLrN4KQ1vDsqRTwM@localhost.localdomain>
Message-ID: <8fcea325-ca5f-0abd-34e0-1ac7b092e2fb@gentwo.org>
References: <20250821042707.62993-1-adamli@os.amperecomputing.com> <20250821042707.62993-2-adamli@os.amperecomputing.com> <aLm4wRwKBMGkekkT@localhost.localdomain> <6f14ff5c-cddb-f450-b4bb-fcc995b5ce5b@gentwo.org> <aLrN4KQ1vDsqRTwM@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 5 Sep 2025, Frederic Weisbecker wrote:

> isolcpus for domain isolation is indeed in the way for long term deprecation
> and the only replacement possible is cpuset, which overhead is only visible
> on partition creation and update.
>
> We could argue on the interface, the point is that nohz_full doesn't make sense
> without domain isolation.

Most use cases I see use nohz_full on all cpus and rely on the OS to
exempt the sheperd cpu.


