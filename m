Return-Path: <linux-kernel+bounces-882677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ECEC2B1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614BE3A8389
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404EA2FF144;
	Mon,  3 Nov 2025 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXkc/7eb"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86862F12A2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166357; cv=none; b=oqG59ixL0gioSfGQALIhYy0fvijT2X/0hruspQJrvjZ/vQzqdpq3adjrwIvYk2TG4gFYWMQfGESt+p5C9DshqAivXWg4PVr3AmcLUdiacBwW0vcsMrbkrCZAT+oNZTy5c8JoT7/l6tp7PE9q56/hbNfgc5BBjkDv6+eTIjw0DVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166357; c=relaxed/simple;
	bh=aN4jHnFKLJmrrVFiC61nBGQU04WOjWPB7TfPkA4l2fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=du5I1b5cOEvJMPBNzvsRAXz9OO+/j+v0ty6aOznQmAO+CFLwkpDrPvuLDVeR3rF4ouiwCuvBlxXmr4c8Ax8TugnAcU53TVWRWHLq++fZ9dHgGBnnkraY3Kr/glwD9Jfjqy/6ZPhD7+srUHmhJihrfZkZeV/MumkBcUMWHWBbcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXkc/7eb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b70bee93dc4so103074166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762166354; x=1762771154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7QAGk21oDk+cSsBLWtKw3jOdrYejlT+3u4CkIN7esk=;
        b=CXkc/7ebRNNFGjKq/AyZ7994IvLQGVTFTBRut+lf1YlBRKBHuN7MUSaS6wse47wM8l
         af2kN4UHclKoYU5IjbyyM+mASX0LBPUlL56BtHGnR0EZoIKEMMx2iiMuu4wo7Musq5X2
         4QA7Gx7eXjHH4aEoYZ5gTfUrlNMMsy+/HDGHXpHD6gbP2fJ0x1gLEzXuNQ0kjT3EdCbs
         TWZqs58ZRfqUqsasIyJC7nAlqEe494TJgCzAAm+Ga1F8gZioeCX3afpRi19b23tlXgFO
         kdCpUx0AvmHQ0uTPumd2cfeFRxhlrmyOLDNpXfPhA5TNSMApiJHs+Y0NOUFSL2hkETJy
         km8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166354; x=1762771154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7QAGk21oDk+cSsBLWtKw3jOdrYejlT+3u4CkIN7esk=;
        b=xOjp4m7Srpfvv9Awdi8VhECaeRQCHabGhSHqjIht6jJto+qzOsnDobpIkxVgPfQPSP
         692WBQOzRGRk3agz5wWgtD+mYVL63GG1Cg9++fRp1+67hrTeNdElSXU8ipoHqrxfH4WT
         MvfRW9OTVCfsX2I3NXI5wcZxhaSSkX8aSXtMWYjl9NlAtvABw5hTO3YtwhVq9WGnNBJ6
         Vb4j26XCUOTHXmXpJMDT6VQYclndHdvMgnvtFwFBgBIvBSqAjsCnROwYpmPhcV1efVez
         ZHyo1myViRHe5Dzt3KMoU7nezvGmte7nSPelpfPl9PN+XDXxGTFQ3AQTa0oG+lFiQNv/
         IoeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlhs/ZIHbbd0KR0jYcWhxxQg6oZcdDDVkhNQx6i+YLliEWjB0Xljxw4g0KRZ690BmfuiNjslrRcVOKla4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3Jdg4BhvjM3TJ8oln33ZM+kskSNcUSTjHxvCWHWpmFtnEVXI
	aFr1VlJ7Ud5xxsUbn1AH5ghxdJRWSAMJlH8+0jHMENQGPa3XojzLcFxX
X-Gm-Gg: ASbGncsxOYaaU0WYu6AjUHsyEYF+F6kYQTFsorrnHUlU114qRPN+G8gxlkTzuRtnEG0
	Ewr5pnEuq/yH+roP97s7rregKCd8wus6MssWdeibZJvXAmHEmX4aUcKNMO9dwDvSuVeYnrL8YVp
	q4+uhDWMgfHv43IwZ8z6T+uX3XzsITj0CDV2swr12DPoovgQ0XO/6DM1lqNgaUBV+PquOu+YTu1
	TJzrmw4uIzrYZbv32AEU4GkxO+/KE2zGzwsDDWBHVlyYdE65aY3cNF+xEvqUvxcKl1axkl5kcNG
	Wex7kDE+IpsZPpgcTS6I0rU1lYLReMRK8p0bmgBgqD1QVIeE9Psi3qRl9evQ0gJVtohr7xAcMzV
	M/3TYibEY5Dzl5fEZNaVXiw6VWjv1i7bATrV9x52ToTpSKvsdWbZiym7Lt0ahFd8UFOd5HeVZs/
	e3+ey9CtQk+6C2
X-Google-Smtp-Source: AGHT+IH7tD/g/IQCrKyP3qGvaIF/j2KDNoOYlpW5O8KOtw1qkuDoTcq4dnPbAOrKwFhJrkM/wdKBQw==
X-Received: by 2002:a17:907:3da0:b0:b48:4966:91a5 with SMTP id a640c23a62f3a-b70704e1783mr1273862966b.30.1762166353813;
        Mon, 03 Nov 2025 02:39:13 -0800 (PST)
Received: from foxbook (bgu110.neoplus.adsl.tpnet.pl. [83.28.84.110])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077c8e323sm1015515366b.54.2025.11.03.02.39.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Nov 2025 02:39:13 -0800 (PST)
Date: Mon, 3 Nov 2025 11:39:07 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bp@alien8.de, da.gomez@samsung.com, dave.hansen@linux.intel.com,
 hpa@zytor.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org, mcgrof@kernel.org, mingo@redhat.com,
 paulmck@kernel.org, peterz@infradead.org, petr.pavlu@suse.com,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH v3 22/28] x86: Use RCU in all users of
 __module_address().
Message-ID: <20251103113907.4e647f33.michal.pecio@gmail.com>
In-Reply-To: <20251103103434.D6m23Iud@linutronix.de>
References: <20250108090457.512198-23-bigeasy@linutronix.de>
	<20251103110835.1dca378c.michal.pecio@gmail.com>
	<20251103103434.D6m23Iud@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 11:34:34 +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-03 11:08:35 [+0100], Michal Pecio wrote:
> > Hi,  
> Hi,
> 
> > There is a regression report on a distribution forum which involves
> > an out of tree module on a patched kernel (yes, I know) calling
> > stack_trace_save() in task context, which arrives here and apparently
> > calls the various deref_stack_xxx() functions with preemption enabled,
> > which in turn call stack_access_ok() leading to a BUG:
> > 
> > Nov 02 21:44:30 ArchBasement kernel: BUG: using smp_processor_id() in preemptible [00000000] code: Xorg/1183
> > Nov 02 21:44:30 ArchBasement kernel: caller is in_entry_stack+0x11/0x60
> > Nov 02 21:44:30 ArchBasement kernel: CPU: 0 UID: 1000 PID: 1183 Comm: Xorg Tainted: P           OE       6.16.12-hardened1-1-hardened #1 PREEMPT(full)  6edb90a7a07fab33bbee72d6d5ef53ba6eec3b9c
> > Nov 02 21:44:30 ArchBasement kernel: Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> > Nov 02 21:44:30 ArchBasement kernel: Hardware name: ASUS All Series/Z97-E, BIOS 0803 02/23/2016
> > Nov 02 21:44:30 ArchBasement kernel: Call Trace:
> > Nov 02 21:44:30 ArchBasement kernel:  <TASK>
> > Nov 02 21:44:30 ArchBasement kernel:  dump_stack_lvl+0x5d/0x80
> > Nov 02 21:44:30 ArchBasement kernel:  check_preemption_disabled+0xe5/0xf0
> > Nov 02 21:44:30 ArchBasement kernel:  in_entry_stack+0x11/0x60
> > Nov 02 21:44:30 ArchBasement kernel:  get_stack_info+0x2c/0x80
> > Nov 02 21:44:30 ArchBasement kernel:  stack_access_ok+0x51/0xa0
> > Nov 02 21:44:30 ArchBasement kernel:  unwind_next_frame+0x1cb/0x7b0
> > Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
> > Nov 02 21:44:30 ArchBasement kernel:  ? __pfx_stack_trace_consume_entry+0x10/0x10
> > Nov 02 21:44:30 ArchBasement kernel:  arch_stack_walk+0xa6/0x110
> > Nov 02 21:44:30 ArchBasement kernel:  ? _nv003168kms+0x42/0x50 [nvidia_modeset 90775ea8a26c5e58b97ef4b3f46eb45efa040eb2]
> > Nov 02 21:44:30 ArchBasement kernel:  stack_trace_save+0x4d/0x70
> > 
> > Is this nvidia doing something wrong, or a problem with this commit?
> > 
> > The removed code suggests that preemption is allowed here, and as far
> > as I see, this call trace is still possible on vanilla 6.18. Perhaps
> > preempt_disable() needs to be restored around this code?  
> 
> Do you have the complete backtrace? Is this SMP or UP build?

Sorry, I forgot to include the link. There is also a similar warning
regarding __this_cpu_read(). Pretty sure the kernel is SMP.

https://bbs.archlinux.org/viewtopic.php?id=309960

