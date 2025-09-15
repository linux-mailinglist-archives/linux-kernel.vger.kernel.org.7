Return-Path: <linux-kernel+bounces-816994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4DB57C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB07188D9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9748330BF58;
	Mon, 15 Sep 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g+RmTuZu"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E701B7F4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941106; cv=none; b=aq5wwO5Xb72m9wCNGy2Ct6CLvuKUecdocGbRTExkD0PAWKIZDQo7tocs1twgqGG5gbuVSLSq595qfp2vFUIHn8wiMnoZknPc1SVRm8QmnED4Rl7VOLQ80xDIKm0WboQDXQqormFUjRKcUZOJ5hKH6z8ree2/1lN5dlJpUBMPD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941106; c=relaxed/simple;
	bh=ebhkGIruC5i/FbgEaRjCiwG2YW6JYIRkGe7tknIt6nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmuOxnUrRYcmPByGchLjrb30AjeGQ6f9D45+tlu4q6RX4NBg2sB3fNAz92GUBicGo0QBHhuwqh1OMTUKLIHIHZHAWv4JGjQl6vF08qC0YS9RzmQWqr2geHnshG/ByV12QybW0os1Xmn+rx0TRK93cn+uY40JIMKfUA1w55O1YE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g+RmTuZu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TVj8P4Pj5fCQ12Bix0xX+D9gH7f1HIB+aFF57H5Z4+Q=; b=g+RmTuZu0WlkQxw4q1vgBaFT9M
	fyFwD6FFncLND04Gc3ps++Q/CroAP6oMHNWVyXZPpRuOeOL0G63EVpFRL6poeDnUvfnqNf7k6b/BE
	VlReFs5QSepLlfc2EYEigeSNfteEXsKWAPN7om60js2/kSQG9LWhaMRsvEPmEddmjrB9nw2/diWeC
	GZy3f3YLCwKYOAOiK8+rir6h5jJvSAvyFT//D92bE5vn93Ps89aeE0+jtoIDynib+e3BjR1SOuXQc
	y/hKW/7GZX/YzqPE5V2QWc638gNOU4tHbH5AF+zGir75I/EHlxA+e86wl7rl7W5Ci8/WCw1+ft1bp
	JP+veUnA==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uy8mf-00Boro-AK; Mon, 15 Sep 2025 14:58:17 +0200
Message-ID: <57ac07c0-d4a8-4839-8454-de19fdf2f3a4@igalia.com>
Date: Mon, 15 Sep 2025 09:58:11 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftest/futex: Make the error check more precise
 for futex_numa_mpol
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Waiman Long <longman@redhat.com>, kernel-dev@igalia.com
References: <20250904165556.56926-1-andrealmeid@igalia.com>
 <20250915075117.ts5Z9WGG@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250915075117.ts5Z9WGG@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sebastian,

Em 15/09/2025 04:51, Sebastian Andrzej Siewior escreveu:
> On 2025-09-04 13:55:55 [-0300], André Almeida wrote:
>> Instead of just checking if the syscall failed as expected, check as
>> well what is the error code returned, to check if it's match the
>> expectation and it's failing in the correct error path inside the
>> kernel.
> 
> André, these two are the only ones that are still pending?
> 

For now, yes. I have more selftests cleanups that I would like to send, 
but they will be done on top of those two, so I would prefer to get 
those queued first.

Thanks!

