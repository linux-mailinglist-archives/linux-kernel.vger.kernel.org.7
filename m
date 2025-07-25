Return-Path: <linux-kernel+bounces-745556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21199B11B90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D26A1CE2AC2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731F2D4B71;
	Fri, 25 Jul 2025 10:07:04 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736772D29CE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438024; cv=none; b=uLCjcM6vKgLa9mQrXHrCjG4vnNMN+gxngrRlTzxA5L1tDT+c7pwvUmdFCazxJBnVF2YBnsAF7szG4m+gX0WwJzdmZm8ygRdfm3blxoOIHsuMCJpDYEDoqnMFXd3E1LsyhyYKBEVT7zNaxmJjX/mwAOc8A+7v1sAeA5SFCBru4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438024; c=relaxed/simple;
	bh=/ab/H0Mwsx3SFtXiJPAdMu1Sx0L6lDNHpvttIidUETo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJTvMZ65BS8ilvZQFfPdKKCRYQWSvtiwR8UV1lTuHoFJRYwab6WmHgZShxrI56ynEm15rhqoddUV0i1gn2tJPs/P6Vxj/o3CRIDqBHFTNmXIpUNGkYKKvvj2+T/2hA/YYEz0WzF0uXhnku5u7jSW5atYPnO0Rk6Th20JtDQmtWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from [10.48.132.14] (unknown [15.248.2.230])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id 2BDA8401B5;
	Fri, 25 Jul 2025 10:07:00 +0000 (UTC)
Authentication-Results: Plesk;
        spf=pass (sender IP is 15.248.2.230) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=[10.48.132.14]
Received-SPF: pass (Plesk: connection is authenticated)
Message-ID: <aad48f3d-64c5-481e-afae-91702b14b44b@arnaud-lcm.com>
Date: Fri, 25 Jul 2025 11:06:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] comedi: zero-init data in do_insn_ioctl
To: Ian Abbott <abbotti@mev.co.uk>, hsweeten@visionengravers.com,
 gregkh@linuxfoundation.org,
 syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: jannh@google.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <20250724210451.108177-1-contact@arnaud-lcm.com>
 <7cc194c0-1ce2-411b-92e3-fb1b6c63f062@mev.co.uk>
 <89c2e255-fd5c-4533-8ec2-1864ddf5eaa3@arnaud-lcm.com>
 <a7ab6827-771b-48b4-98b2-4789d78e19e0@mev.co.uk>
Content-Language: en-US
From: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
In-Reply-To: <a7ab6827-771b-48b4-98b2-4789d78e19e0@mev.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <175343802067.11650.13505986939322559381@Plesk>
X-PPP-Vhost: arnaud-lcm.com

Thanks Ian !
Keep me in touch on how it is going or if you need my help at any moment.

On 25/07/2025 11:04, Ian Abbott wrote:
>
> Actually, I'm just building a (hopefully) fixed version at the moment. 
> I'll add you to the Cc list for it. 

