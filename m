Return-Path: <linux-kernel+bounces-817025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A63BBB57C93
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865BE16873C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC430FC14;
	Mon, 15 Sep 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UJBN3LCq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/QOIps/o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DE30F7E4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941978; cv=none; b=fjJ47HmQqo4W56btPv5n7ofYmBhw4HZBwmVBXNiBKm5yOoLb7leprR2OZcMixOfgcv5mlUhfTHhfelGv3XniHsEbeAPZt8GzVLZatjZfQxIRXNl6gGqK7bTJKOlHDceZH51qPwXcDuaXrhk7yqlIsUh3AuxVWTVahuSD7Rbg0vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941978; c=relaxed/simple;
	bh=NLUjaxHelDWQCI0OiOkyW1fBEByxPBytiSRTS6mAVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRalZxbMqYyutD1jrunzkl7X2C2CAHSOCKdCdKLi8h0sRTIdjMyt2OyvLOUVNIfTgB9jMIqadX6B32P+lb9vkGAii+YWWWuTqg2zBQsE/2UEahb71CHW735J4Q9hNsR4n4Dw0OdBEjHWD8Vgi6Re3Iiuuj4By60ULa/tT4itGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UJBN3LCq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/QOIps/o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 15:12:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757941973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLUjaxHelDWQCI0OiOkyW1fBEByxPBytiSRTS6mAVPs=;
	b=UJBN3LCqrdWnvLBPDdfJl63JvsRubOF/6lDRpVgJg8bzKX+93wm/gteZTuRzsTWaK9jLJ8
	jDEVfr4vRuhkr8y7SoYprc9WGVqjULM1uJkJ7UAbCKjDDDZB5WhoV18W5VH/vERipv51S9
	so/WaK1/fCt4UTheSHHW9UID+CyNN0XiEdJpS+LPMrC3U2j4tZDjGqmqWAq4juKkBAT2r3
	JemoENaI5gnP6lYEjsI5QSVCdOsSvaZM9OnlQQZj1VFdIDjFWmq1FMbcF1QB122+eDF3N8
	7Wp49oMwCxiv63M7yTh51ipxFpCWFXGPxai+o5PjI/4ao/O9ldCqDCJQtogJaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757941973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NLUjaxHelDWQCI0OiOkyW1fBEByxPBytiSRTS6mAVPs=;
	b=/QOIps/oYkcCeUsjows6stFkEJXq0mlEPUoaQlCOKFUQpnaWC3KWC1z71QhAZ8lrcludCn
	X+umB8jwX+AIYGDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Waiman Long <longman@redhat.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 1/2] selftest/futex: Make the error check more precise
 for futex_numa_mpol
Message-ID: <20250915131252.6p0W4ZJ-@linutronix.de>
References: <20250904165556.56926-1-andrealmeid@igalia.com>
 <20250915075117.ts5Z9WGG@linutronix.de>
 <57ac07c0-d4a8-4839-8454-de19fdf2f3a4@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <57ac07c0-d4a8-4839-8454-de19fdf2f3a4@igalia.com>

On 2025-09-15 09:58:11 [-0300], Andr=C3=A9 Almeida wrote:
> Hi Sebastian,
Hi Andr=C3=A9,

> For now, yes. I have more selftests cleanups that I would like to send, b=
ut
> they will be done on top of those two, so I would prefer to get those que=
ued
> first.

Thank you for the confirmation. In that case let me repost this and the
numa related patch I had and lost=E2=80=A6

> Thanks!

Sebastian

