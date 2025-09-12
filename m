Return-Path: <linux-kernel+bounces-814641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB9B556D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 21:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F03ACC93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC52882BC;
	Fri, 12 Sep 2025 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RQsIPVhF"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A40279351
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704444; cv=none; b=RtF5lSi7jkGm8cVTqkGy0rsfsnwzM7ONWaJZJ+pgzF7i2b6R7ZTgSnvyzcskeCpGU92adP0QxRYIcQoaAGV8v+DQiglph2Dboo6CV9opIteZLPN537vwzB4GoT/GGy7yXRHySCqBtpLlyC3OEzjHiKd1daq42kUGMUimVrwdP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704444; c=relaxed/simple;
	bh=RzKcdB2U25vK0xo3k/LkII+wAfKOAoNAkqH5fEdmS5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhD4t+42lcCPR0tLE6FByki19QosFpswFDIx3rqKg24WyNdb0SxAY3FWT6J/NCJ1nt5LIfiF7MCn/SrYZDUhlYHc9bpthaZi+KiMwKQnZotMrakORkcgBF5ruFRP5mAHtTwi50AxljBlhHuBAE2WQoXY8vy+dxupk+pzQjho5j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RQsIPVhF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/2nd4y8r0GKwqPqIPqcYWV+SKTvCtnO7L3h908eUL0=; b=RQsIPVhFO7RVf9jAck7CAUKmk1
	n/+LrrFzCqKrugPzeppYErYinPXzZ4c4IlC+vyehTmVMu+XjIncKD/Utg9H0HpEINfK6PyAM1nzls
	wFNtEaFbM59sEmMuoJg1cAj96H1Qjc67Z2JU65j5pDX9OHZD9RahmT3YCYs6B3h8ZhS6x7S4PEiVh
	WKCXBrnS+Qu1y85iIQj1RLvwQmyXG+55vaP8tOUAYeaYePSmlVSM9jXuINeaQilQYE746nQfIFnHZ
	BqFNix1NdyKOdrclPvj6FCwvT2ETJSyuLc4XNnDzpwKCsJ/ZvanCCaggVxcSJ0ryMK7hkJ/Fkdcba
	1gJA9kjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux9Dc-00000001r7m-2sK2;
	Fri, 12 Sep 2025 19:14:00 +0000
Date: Fri, 12 Sep 2025 20:14:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit Links [was: Linux 6.17-rc5]
Message-ID: <20250912191400.GA39973@ZenIV>
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 08:24:06AM +0200, Jiri Slaby wrote:

> OK, can we have Submitted-at: or something for the above which you could
> completely ignore?

Sigh...  Same question: what am I supposed to do when posting a branch
for review?  The only answer I've heard so far had been "well, you could
discard that branch later and apply what you'd posted [git format-patch
output, that is] via git am or something similar to it", which is more
than slightly ridiculous.

IDGI...

