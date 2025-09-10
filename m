Return-Path: <linux-kernel+bounces-810140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7A0B5168A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D5F58033E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854530EF69;
	Wed, 10 Sep 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HzclpNTk"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760C23FC4C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506244; cv=none; b=KrV7TSi7CgkOA/9p0bjq2cjfhi+SyEJKfwSkF2BXujMoTfyRy04mGywJ5kCE89F6DYIzaPtMMvRHdaOTd6Gbc5abIWvDjxqNIYB5wZp8CbxMbLuMAxWvt1Q+YFo5wlnwH2UYEw9iwUMpBT9w9bKhAQtGpkEZlrwbqleUZLwHx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506244; c=relaxed/simple;
	bh=SAJzAqzm8/wLjldsK42GZDtxANEbwfJEV1fsqIPU6aA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NC6bKwgwt7SVRKSGl0AorVFqxidJYpxjtSQ0qThDr4BloAZnHhKIL1rNJovECGnFFC2j7Uko1NrfVSIT7J+AM643a04WhdvVcqMzGc+6u+I1lE+dy4vaFsIR9y+rGdFu3Bka3B4Dlf7QH2SqcHko1g6OSsCnn7jgxH56CGGfWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HzclpNTk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SAJzAqzm8/wLjldsK42GZDtxANEbwfJEV1fsqIPU6aA=;
	t=1757506242; x=1758715842; b=HzclpNTkmRpi4wfL/vwRMQlvFob6LeUcBpO5FJQhDpF5Wt1
	3NG/ab5yOW69tTL3mxCfHeA4WGXb2Fb4kxxpPyem3QF/tIx68bddVtMXYrvBPXQeWueuipYA25aHg
	RB+7/HM66U4QdLthDHTvSmZeqUck4dqWH63wwuJQmy8d6Dgk7tb9dDVm8krRxIlw2pbMDzN+IaXHW
	euAUWPzPiru8IwHamLp3B0bSEC8Bv14tnaj1faQVn/fmyFPXw648VvGQ9Y/Thl0gkzSkngm1+2Dps
	10uGmglGnkBINQ6vf21RRFmukxuVzOaIdLY2nT/8e+/I34l0Nj18q8P8nire3CCQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uwJeo-0000000CoJx-1M3m;
	Wed, 10 Sep 2025 14:10:38 +0200
Message-ID: <55cace5b8e1078bd04b4a1acb5df9faa6a83b6e8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 05/10] um: Determine sleep based on need_resched()
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.bie@linux.dev>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	benjamin@sipsolutions.net, arnd@arndb.de, tiwei.btw@antgroup.com
Date: Wed, 10 Sep 2025 14:10:37 +0200
In-Reply-To: <20250810055136.897712-6-tiwei.bie@linux.dev> (sfid-20250810_075306_773702_0F58F2CF)
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
	 <20250810055136.897712-6-tiwei.bie@linux.dev>
	 (sfid-20250810_075306_773702_0F58F2CF)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-08-10 at 13:51 +0800, Tiwei Bie wrote:
> From: Tiwei Bie <tiwei.btw@antgroup.com>
>=20
> With SMP and NO_HZ enabled, the CPU may still need to sleep even
> if the timer is disarmed. Switch to deciding whether to sleep based
> on pending resched. This is a preparation for adding SMP support.

What's the rationale for need_resched()? Is that somehow defined for
this? Is it what other architectures use? I guess I'm just not entirely
sure what it means.

johannes

