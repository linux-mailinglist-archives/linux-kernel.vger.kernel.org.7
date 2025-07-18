Return-Path: <linux-kernel+bounces-737273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC0EB0AA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEC25A23FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74162E7F0A;
	Fri, 18 Jul 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oUK3fxHj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447F2E7F06
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863773; cv=none; b=cZjmEJkSNIybQ2k5dTdxkiU1capGQQOeHxFZDctnTDPK30tPSRHav9DyqLw1Wi3HswJe7mWtbSftIENjNKMa15gMZ2orHTsVE3KSZ5n+jd7Q0gP4mJJmPJyq8BTzib9BI3hFuwYk+GqsS+IZ/GsW9WwQjkapqfLZxboObCOu3es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863773; c=relaxed/simple;
	bh=5qlQ+761hn6OrnIDwaSrOkWt9c8/47BkXB3UXwRLQss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5SIdIZCKjo26PBNCELFI6AJx0ZkT+1m0BhhKOUIK2WygfavRlP5aKg1yw8F55OKgVR0+R+Bo3m0oKwn3OYO/ZOQiO7+rDaf9UfjcnAFl7nhjg427OCoXRL2Vy16YYO8qCfWvVdHpLWCA7fu8lACZvtRloGI4leoMctvzXyYsB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oUK3fxHj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so2109135a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752863770; x=1753468570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YHZSIH4QXyQQjmvIqyrjSbplelhoOzEiXOXvbUIHNY=;
        b=oUK3fxHjQrvNljhNQYlMGlMMbdSzoi0ax3lVkfmRynN9oXzvbwYfsc70R4z/4MJowO
         JC4lXcIu5NMSmmiosi7y4hiEguGlxoQTSn85CuMp0MUtG2Kb8lgcEEvTGxXVzpLSTtbw
         2obSk6KPuB8Rl12vbo+hu59JlxZbSpZnaxkwzBzdq+JXkNQ7iF6tS5vosuWBjDduf5xB
         95X8YKpvwhbr7S4rZD9OxTopoPu4/MuL86tlcs41v5KxgPHaCaag1GM8HeODko46NWhF
         f1WsOC22pGhwwQEZPCIT0uB91WXVA6emw9brkaqG7w8wBg8A0QotfLmINl61CrctcmCx
         wEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752863770; x=1753468570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7YHZSIH4QXyQQjmvIqyrjSbplelhoOzEiXOXvbUIHNY=;
        b=DNfuUjq25RntQf5otiK3CPaMpmOtCnqq836OKxANGaFxUSql2vF5ppiajqJ4DCjR3z
         wsg6XVm1A6Qzx/aronBuN9zjWW/krDPilvD0gsRQPeYRcDmH/9/RishAdEx35Mwtfvv5
         jUMBwLxysAF2XiBR0uduTrxx00ZtezeoKJF9psMwed7TWJLSwpwEivtKBSeGhrXeLx9+
         VYxnzND0Kc8fzNt6XKX/Gj28PcCKHh6uF++sAQ1UMbSI2YK5FsG+zfmZygaDQ6SfPwrT
         ZSot0QOnIsGhCCgRLbhbA0z1Zxe7DlplSho6ZZno1zxsMIDBR4NOa0o+LxATiXE53PKk
         tI1A==
X-Forwarded-Encrypted: i=1; AJvYcCVL5MZy+z6RIrx3oQEPgoK2GYh88ydRwypquGTs7Opg9JzMXqlDzVy9UWawLRoqWTqhO260pc9Z/dDcm5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdSnM38q9LSC1axgr0wQ240NQD2mPcOMWSdogxyv8ZFU5FgRh/
	9f38Z0EAjTpMUBTVDkjcUSZrhLcXLc229SDxfPPkm00VKApwrF7h2lt1+ZM+/mLbrMC4L51yY1o
	/Ws0B
X-Gm-Gg: ASbGnctUyKqkwc815be3Mhdovd3+pDrTJf+Hsm21SfL4opfOrGVsyZWL65dkWkr5t6d
	VuW4P8JTAQOIW3N6ymLcMVlcsqAxBFm2CWZi25H4F8NpRQ25LGen1wmOtcbJKvotjX56dzlHJrJ
	bpzVt6X3fDbMO3qYGfKZhQLgu2TXlW6VnWGCAktr1XmpnkHHPgIEO6Hq3IVdM2+d7IJxK07Ofry
	ENfYaU42rEBB47rMyhF3XxoRqfg6xTdPXZM7w4OujDXSjA0xnvD+Ts3nh8Y4COJY0mDLkVjYzaI
	WlYuXj08/OA0s44xLFkTxC0iK8mkfPnuoY2U8FJO3H/B2qEE4/pnPZPwT9SNqoEDDP4+FpmLIZ4
	Se9N/uvsH8i1sTUa7C6q2CVFoHmycDqNL06Q4y2PiCzoji3KH83IudgCRnowL8Y4QBCo=
X-Google-Smtp-Source: AGHT+IHNjCZ1lF5IxEcSK7Q336xvA2JqN/FhLb91/xqIHcN1SLy4r5JEGGmXyt2l3qmS+/4JJPp6Gw==
X-Received: by 2002:a17:90a:d88c:b0:312:25dd:1c86 with SMTP id 98e67ed59e1d1-31cc25c5ab0mr6395789a91.18.1752863769794;
        Fri, 18 Jul 2025 11:36:09 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b404sm1687820a91.12.2025.07.18.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 11:36:08 -0700 (PDT)
Message-ID: <72eeb282-2e9a-4c06-ac5c-54f226a8500d@kernel.dk>
Date: Fri, 18 Jul 2025 12:36:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] io_uring/btrfs: remove struct io_uring_cmd_data
To: dsterba@suse.cz
Cc: Caleb Sander Mateos <csander@purestorage.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250708202212.2851548-1-csander@purestorage.com>
 <CADUfDZr6d_EV6sek0K1ULpg2T862PsnnFT08PhoX9WjHGBA=0w@mail.gmail.com>
 <bb01752a-0a36-4e30-bf26-273c9017ffc0@kernel.dk>
 <20250718172648.GA6704@suse.cz>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250718172648.GA6704@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/25 11:26 AM, David Sterba wrote:
> On Fri, Jul 18, 2025 at 10:58:07AM -0600, Jens Axboe wrote:
>> On 7/17/25 2:04 PM, Caleb Sander Mateos wrote:
>>> Hi Jens,
>>> Are you satisfied with the updated version of this series? Let me know
>>> if there's anything else you'd like to see.
>>
>> I'm fine with it, was hoping some of the CC'ed btrfs folks would ack or
>> review the btrfs bits. OOO until late sunday, if I hear nothing else by
>> then, I'll just tentatively stage it in a separate branch for 6.17.
> 
> I've taken the first patch to btrfs' for-next but if you want to add it
> to your queue then git will deal with that too. For the btrfs changes
> 
> Acked-by: David Sterba <dsterba@suse.com>

Thanks! I guess that works fine, it can go in separately. I've queued
up the rest.

-- 
Jens Axboe


