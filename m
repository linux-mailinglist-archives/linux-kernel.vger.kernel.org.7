Return-Path: <linux-kernel+bounces-788580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA6EB386CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802117C0AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB72D1319;
	Wed, 27 Aug 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f+f4DCT+"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B768236457
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309142; cv=none; b=b9w8ophp1S0JIV3DjHvDykbXqB/FM0ZnCJVXhCVSMTdE/IGwgMUTnmbJNe32LMxZBJgqsEbJNPEd3UJofwZQImx2XD0A57i2WBOT3qFCB9zutd5n11qBqIxZmXdw0aebYbyUK+BmXKFuCdi/nWROYrdmUFWE9i2e8ZXX5fROVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309142; c=relaxed/simple;
	bh=S9e1A/fPLFK4FLuweDkVtG/BiMoIO14X2aTJ/0/YCTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Use5GzRbGVOYyBqUsc4S2X/i1oIGw58A4x5MCZjn1cqJKqlVypGBfD/qkeFVe3kpquAgfo/jj70zAtJC14Dpc37cz/r4ghT43uqJ51CJtqcCi1XYXFLD+ODhUKbGQ76biMzPguMIyiaRRmMC+UIXRhJbYySJnJms75tKe7WNBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f+f4DCT+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S4xCQKtLXIKx1k2pxdwPfJKy+N03F9cREUisMJ+/pCA=; b=f+f4DCT+Ah3oyQ0ynLIag2O7sL
	VxUu6xY1frxWjJgS6jLFkB7/HqgT36C75trjC+ueo+Eu9zf73hYewwMNVtWIqx3TH7zeI2JYKVfdz
	0YjsSGc6NsCxHUsk07JPQrQK5iEWTx9H6De498zDk4XZf1667qV95PfVjf2fRkMLpDsHKEHX8wxac
	W1OF+A0FeqZImSVqBBg/b7vhKlTxWKsJB5wEvg4WYixnHEWwTQDfME3PWsq9hx1N0ng9AvUgpPmSQ
	jv82TGk6h2ORJSBYHkNAbN8duirtuCoFKgR/HSvno96t2BzFoV34BkAe36rURprKL8g1iuSqoosTU
	yceEJ3Mg==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urIEh-002V8Y-3Q; Wed, 27 Aug 2025 17:38:55 +0200
Message-ID: <2bd58b09-a461-4e6b-a2c6-673435333e48@igalia.com>
Date: Wed, 27 Aug 2025 12:38:50 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] selftests/futex: Remove the -g parameter from
 futex_priv_hash
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Waiman Long <longman@redhat.com>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
 <20250827130011.677600-2-bigeasy@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250827130011.677600-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 27/08/2025 10:00, Sebastian Andrzej Siewior escreveu:
> The -g parameter was meant to the test the immutable global hash instead
> the private hash which has been made immutable. The global hash is
> tested as part at the end of the regular test. The immutable private
> hash been removed.
> 
> Remove last traces of the immutable private hash.
> 
> Fixes: 16adc7f136dc1 ("selftests/futex: Remove support for IMMUTABLE")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: André Almeida <andrealmeid@igalia.com>

