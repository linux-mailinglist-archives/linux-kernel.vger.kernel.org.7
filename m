Return-Path: <linux-kernel+bounces-788595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DE2B386F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFF6461DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C91E2DCF4D;
	Wed, 27 Aug 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oJxAV0uj"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79AC2D781E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309775; cv=none; b=REjOlR1jpAuis/VGfeXWVnHAZAQZ36DKwfrkGjCM904ljVkGHG5TQfl3zhwpZi4xT99Y22AQ+vR/FOVArQLPQYH3hniGrialXA86DaSAvb66VyQMuFFE5SIR0XTleikgA979lmstQvHMbPKYgMeZfowf64nJF4EZudE4QlGxE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309775; c=relaxed/simple;
	bh=mg2MOk8YIxp+pkoKJqGQG0ts1r2tIbNhT6PxI0Xevmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1mFoqZkD50YQgQKR7OllrLTDvjr2kr92EiMI+u1sB7sCJAc7IyBL7lngx+z/EHyhuT5iRmvbWdRt4Qos6HD41opkYWlmJs9aGRIu2ZyegFgG05HYbkif1HdVQA6Dmz6G/PzEc0SAOZEU8rigunClgIJXSqbKLg8CANMkCJKXoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oJxAV0uj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tKmytt0VzhgrMc9LthgNNhU59XsVwnxC7vvJ82ZDDlk=; b=oJxAV0uj/RoamFCqP4atIM93CE
	RtuT0VBAl08Ls6oZ6rDKtpE4wRwT/Y57GNvzC4JugExh7bKV0r4flnU1fCh7ClSxoyU140W58bnnx
	3tqXSdsI5xqMRDzeieKmNmZlkENCoAzAW942KZW5wSIHXMOgeMqpkIvF/lscLhLQqx836RMq4tF9L
	qeEye1ZliU4DSDhQv2tN8HyBCawai47Z2Ds8LwsSqWUbYL7Q8+zfTCeETgTAkH9XzqjeNpMF3rnh1
	YU5m+paBoj1P3piOq1hTl76fxiMKMoDO0x3UIBWJCJu5iYL18Z9lmxvEfJ8fc2vZUh42V20C3G+1W
	bY8z5GjQ==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urIOx-002VYm-Bi; Wed, 27 Aug 2025 17:49:31 +0200
Message-ID: <257b13e9-1bce-49c5-ae76-a6eaa0fae0f4@igalia.com>
Date: Wed, 27 Aug 2025 12:49:27 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests/futex: fix typos and grammar in
 futex_priv_hash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Waiman Long <longman@redhat.com>,
 Gopi Krishna Menon <krishnagopi487@gmail.com>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
 <20250827130011.677600-5-bigeasy@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250827130011.677600-5-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 27/08/2025 10:00, Sebastian Andrzej Siewior escreveu:
> From: Gopi Krishna Menon <krishnagopi487@gmail.com>
> 
> Fix multiple typos and small grammar issues in help text,
> comments and test messages in futex_priv_hash test.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> Link: https://lore.kernel.org/r/20250819155755.4665-1-krishnagopi487@gmail.com
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: André Almeida <andrealmeid@igalia.com>


