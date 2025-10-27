Return-Path: <linux-kernel+bounces-871700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C63C0E19A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E593E189CAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500103064A0;
	Mon, 27 Oct 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P8vvbycA"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF7305E2F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572143; cv=none; b=GgzGqVTXMXgQGRIP6VK1JLZqG+ZXNeXp9A7xqwBETVWUjtqtdth1drMA8UlVj/+n+C0OlfKJ5e+FgONxUBev9iykXH/adRCiHA0GX0tbCOWxk+paZjV+3Wc02mam6DdhF2Hex4LBiW6cRfXTOI8dxwtFwUdzYcnZBwoyIuBhKNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572143; c=relaxed/simple;
	bh=q1xHjAi6E4wi3oQoijyEgXm7p5tzOjAHqmVcqhQq0wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1rjQ+WoAFcqFzPSEwg4oap6q7bo+5oUSDvQHU6UHLQYI6cUlf1Pt5hhFwSRdoQGHJPrRWUa2HtuhJ4GSK5lKvF+29G8o25qn3IQ8+3V7N97vqXjC6xH8elwfudXG0s7sIosmwAyMMnPT6G6xBA72yMXFUiS9X7hvyZuH1K/IG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P8vvbycA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so26140115e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761572139; x=1762176939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=coMQJHEII5UHdUF+Ekj+pHGgsN6WEYzWi8tdyRdD9tw=;
        b=P8vvbycAR7YrdLbLsZK9MsF8LIJaG1AUecd4CONxCa9Bm256AZZujM2MjtVUVQwh2L
         wjQw2Ag/XcnrUCu0xW/eCq7E24V2QsqnyvDwPRGhJds5NXMWizxT7liQy3yEsgbR4Ec/
         j9eubyUMw46E0Pvqq7iVHqbXUzUJ3dipvKZjSSHHEJ5n6NWZN/8HX5+topoMXgIOf0lx
         BUO3FgFdVYkKygha3VYXZaoHz2yrqYEBGnzBZeWVKPBxSWfiSp8hoKuvsOmrpctvoXUI
         MFpPyCPhjYLyJRTaaDxdCeieFvXjKWq2vsMV/wJ4FAMFQfPziPMvHN81/W6NEDdRPwvw
         lXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761572139; x=1762176939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coMQJHEII5UHdUF+Ekj+pHGgsN6WEYzWi8tdyRdD9tw=;
        b=sqZ3gEtqSqEqzVHLBb3CO80YMLfq6hX3VtHFg2n+NCTBBGYE8kNco6pqgOQ8zi9qkv
         1HJOlDrRlzMOAAzfhLvTWiXctshbdRbLLKPuQn+4hjh5nU39UFPA/zROBtLIISsE6z6e
         lGBF4OpC0GfD1OLU4MWcXbSmDa8wMoKSSSVqcLoJq+Wr+tBcGvbeYnO5WfOx532FHoBK
         wplu9st5N2byhQvVNqoWKQK7QxurIXzhqPc1ZZN2vY3EZp32R/Y0TmTAABnOpbOc5ES7
         Csk8Nfv0ZS8V+fk/pmETfYGgaWwOQXYh3i2KPhixbWw9FbLqlXhimxN+0V5s/AftSYhV
         E/cw==
X-Forwarded-Encrypted: i=1; AJvYcCXRJ9riZj3kB/hD25Y12W+vBWqLzVlqWI7sdxtzbuvH6dXycma0IJsWunYC9C9HhzqQZ47WneQ22jwyEZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMT7rOdAde+42bNIxV7BYorSfsOwSWW57OSvFqXj5JBI72H523
	gJGnTpNa38Vur9lESD9fbkAjL8jb1K5kDZ1fJT0t37BVKALMZsiSMvZe0Al/rcqffvAOzj012U7
	HDW/v
X-Gm-Gg: ASbGncs0b/sYD8hmDnpi3ASPA+jZIaaefKauECB+wNfLB+fTzM/j45SBCpbssF829YX
	CCuNyeYV16RjBtTitDWDmfrOMIWfolkFMztpMr8t1rKBxHLxkcJWd2sgBaGx9c2aFuFKwmUDI/2
	lGRQsk8u1bUgqIB0AbPqnjgrAx1A5FvAxkOPn2kUZ5W40N7MYK8Vqk1N2MEZRKD4R+mntsQ5qKc
	rUsL9IkVy0DWAzrHo9DJBa9V/EnjZsIusz0Ucwj3DQBUo/ugX/xbLOBvOgNqpijJP1yonZQ0CDo
	iP2q0a2bg4dT+R1sICZx0JgZZdueEUyArVyiOoCBFy9su/qRTC3ZG9DcywnjGX4wqo0j3VtIwLr
	XI+rEjeLjCJKB0HRDxLbUX1SH0m9e33sYbFucl6O2a8kzLg9l03YD1fhQ/2kaLCf/eXPt3JZ3bD
	j0wDL2RnTA7q0PO14FvCydCUNQOkBCBbZQLjtwoU4u6zRwjXjtom0BBpxqX19JrcKIkQ==
X-Google-Smtp-Source: AGHT+IHqAIVjFyYDoJjqcp/dMd7ZvxXUjRECSaszUpt0012U8VY/hZ9NeJngEtVEdLXk+JU1qrULHQ==
X-Received: by 2002:a05:600c:3b82:b0:475:daa7:ec60 with SMTP id 5b1f17b1804b1-475daa7ee4amr74939795e9.21.1761572139493;
        Mon, 27 Oct 2025 06:35:39 -0700 (PDT)
Received: from ?IPV6:2a02:3033:263:99eb:3ee8:c1a0:6fbf:4510? ([2a02:3033:263:99eb:3ee8:c1a0:6fbf:4510])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc16sm13967859f8f.15.2025.10.27.06.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 06:35:38 -0700 (PDT)
Message-ID: <8de18ee2-ccdd-4cdd-ae49-48600ad30ed4@suse.com>
Date: Mon, 27 Oct 2025 14:35:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: uas: fix urb unmapping issue when the uas device
 is remove during ongoing data transfer
To: Owen Gu <guhuinan@xiaomi.com>, Oliver Neukum <oneukum@suse.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
 Yu Chen <chenyu45@xiaomi.com>, Michal Pecio <michal.pecio@gmail.com>
References: <20251015153157.11870-1-guhuinan@xiaomi.com>
 <aP8Llz04UH8Sbq5Q@oa-guhuinan-2.localdomain>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <aP8Llz04UH8Sbq5Q@oa-guhuinan-2.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I think I was unclear the first time.
Sorry for that.

On 27.10.25 07:05, Owen Gu wrote:
> Hi Oliver,
> 

>> This patch modifies the error condition check in the uas_submit_urbs()
>> function. When a UAS device is removed but one or more URBs have already
>> been successfully submitted to USB, it avoids immediately invoking
>> scsi_done() and save the cmnd to devinfo->cmnd array. If the successfully
>> submitted URBs is completed before devinfo->resetting being set, then
>> the scsi_done() function will be called within uas_try_complete() after

This requires that uas_try_complete() is called.

And I am afraid uas_stat_cmplt() cannot guarantee that in the error case.
I think the following sequence of events is possible:

CPU A						CPU B

uas_queuecommand_lck() calls uas_submit_urbs()
COMMAND_INFLIGHT is set and URB submitted
						URB gets an error
						status = -EBABBLE (just an example)
						uas_stat_cmplt is called
						resetting is not set
						if (status)
							goto out;

						uas_try_complete _not_ called

The scsi command runs for indeterminate amount of time.
It seems to me that if you want to use your approach you also
need to change error handling in uas_stat_cmplt()

	Regards
		Oliver



