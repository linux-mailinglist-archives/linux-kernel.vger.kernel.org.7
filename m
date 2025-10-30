Return-Path: <linux-kernel+bounces-879169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC24C226E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3DB34EB837
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1272625;
	Thu, 30 Oct 2025 21:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evh5FF7N"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAA30E83E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860228; cv=none; b=cd448QeH4uFgbrE9VrwWZECTwWpQgfFJlV2KCmX0ntM3tCOWvasRIw7pW8JWkHTER71xFWEJxGF9zuK66aBOgg/KAtRnGRPLyIDyxx3gW/rEmHSxAMjTHKR7s5pU0ZvWIgfk/UHd3R90IrollHd8xG2ihIV6IJAHfeNzXNBbqI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860228; c=relaxed/simple;
	bh=45jfdJnyJ32bvuggaDRa8h9Sl7RrgHGsxTBiE2SnqnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LioulhSdl0U5bg0Y8D5zGiWOyvDQBp5/UDm8lkyPEUOC1itsumwLFRA/Nqd2Y+BiJuUjiZXuBcgHopvjciLWMVdwYC5WVbq8qWW8bOpwpx6MgOQN5ph8lfP/t25Zp38sKLH0r173peGDpwGOnjscSgJUqO66bJpet0jESSMbcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evh5FF7N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47114a40161so17224935e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860223; x=1762465023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBQJ8NZZeDhVExk7zItWUyrPMSm4Navew7MC0raFrQo=;
        b=Evh5FF7NeH2CdnS6fyJOz0yuZNQpRoE39f8hPOsiPZSAa4r0HO4Td40cQ2JqR7p98s
         kW9sC6uVKHfymR6Bwc0RHT0UiLqB+1c08pkfJ9FwC0m2t65GZbMbJ7B1qzNteXyY+ZWk
         cu9OkXFtQpgpuzCF84asi+QaaZDkun3OgofDQX8GxG5rzyXsyY4scEYMV+LesWfF5HRN
         stIClQywZY0X9Y//nNewmkxAHUX6V8TogoKwg87rS8jC22n7mhPoDr4zCV/shaUFAo3k
         Vlm4CPXn7Z1RpurzoP3d/1Fs5OcKWDetXRQk9Uz7YfLPG3w5xlKoeVDAVNrQ92KPsKLN
         kv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860223; x=1762465023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBQJ8NZZeDhVExk7zItWUyrPMSm4Navew7MC0raFrQo=;
        b=J29ECuR0e7sAAA+NPH+A1VuRyloeHBY3OcAQO9WTKbs2Zu3mcANqsJUnYxFE9ReXrA
         GDgVqtn3OeVY9iBs/YQeFVYwT+6Yo9oDaHpW9XUlBZwjTaTqpIKKBHzp17V2zJIp/Lqm
         7rN0aNTe7lXBON6qwRiACTVAhRbOliKp3jth36ranf777EZ3ZurvT/VIsgspBpu+sYvA
         66rC4H82eJV3+53lfy/9KBeC46YS5lbjdqdkG4zmNOyfdXVRaV8iuOOQosn6ROQmhVwm
         ywv6kE8QijFqucs1NmAsqgktGutvDsFfrklB5UjeY4InqLLX/1+UkIWv8odv2jue0gX5
         mjPw==
X-Forwarded-Encrypted: i=1; AJvYcCXcSV72NKSOkD5dZpXSZ5nFgx4hgmpglIFPPt/C30yMa/DeDVsv+e+J8D3zT20EqOb62ZS/UKCskh5hORI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeGQtUBwAdmqhdTZwNZVBcLMYaO8DY3O3gThlPsSFHEzkYWe8O
	HNJ9HOHQvbxfrX+P5SszwzH5BnBk3h2c/0Xj1dcOsgqyybP0MZV14tgb
X-Gm-Gg: ASbGncuv9urwQJqK2fJgRpiYKBaNzcx5vxmRKiswX3vy70RLbYqvDS4UPVYViqEtkL6
	RbyXReyC4kZbOJ1bQKNviyX3+UUMRIGvuSwiS1xuL8nxOy7G/u7XouTIrAKg8gDEvpzzjnZIVZz
	dwemLeYLnEUNMvPTtkYAlOED59okCYz+bNjNFwUuQseXNEAc8skx+Zb4Tdfg6wMr8OSRI4yZ8MC
	8lv9vwveBuboKfJ3ZAZfn18K12ADeCepZln+5/uGs+fApsAgR2u2uQWS/HK3yXumJu5p7E7Rj1Q
	MNeYgtajnrUWlrfT4gtB8VDOr7/WlWM/RCqCvTLEfTlSQxhPUN5nYAFLHfVlV7BHXT1f3EEdGzt
	n6NIIUnDBwQPYHiYWeRcv+plsfFUlfrEY3DztUXGh2Srii4TtEzqrr46+JrugXObssONyxnQoeh
	/Q5djABcCMRNrfRDykIE7m1llMdnZMWp7H989wRp05rQ==
X-Google-Smtp-Source: AGHT+IHL5HKRR2VQHGsF+tRPHFz6hmgUmkPnqqQQjatvWEU2WCyYG6/w1jSGFQ7BPsCBPfDzFNjvNQ==
X-Received: by 2002:a05:600c:528e:b0:46e:450d:e037 with SMTP id 5b1f17b1804b1-477307c213fmr10872665e9.5.1761860222541;
        Thu, 30 Oct 2025 14:37:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba445463sm4164266f8f.10.2025.10.30.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:37:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:37:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Ard
 Biesheuvel <ardb@kernel.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Kirill A .
 Shutemov" <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>, Vegard
 Nossum <vegard.nossum@oracle.com>, Xin Li <xin@zytor.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Kees Cook <kees@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Message-ID: <20251030213700.1e98203e@pumpkin>
In-Reply-To: <e3c7987f-7f8d-41bb-9d4d-966f35941757@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	<20251007065119.148605-9-sohil.mehta@intel.com>
	<a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
	<3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
	<f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
	<e3c7987f-7f8d-41bb-9d4d-966f35941757@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:28:52 -0700
Sohil Mehta <sohil.mehta@intel.com> wrote:

> Thank you for taking a look at these patches.
> 
> On 10/30/2025 9:58 AM, Andy Lutomirski wrote:
> 
> > So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vsyscall case.  (As submitted, unless I missed something while composing the patches in my head, it's only checking user_mode(regs), and I think it's worth the single extra line of code to make the result a tiny bit more robust.)  
> 
> I probably don't understand all the nuances here. But, the goal of the
> check seems to ensure a 32-bit process running on a 64-bit kernel
> doesn't ever go through this vsyscall emulation code, right?

Do remember that there is no such thing as a '32-bit process'.
Changing to/from 'long mode' isn't privileged.
OTOH in 32-bit mode you can't generate an address above 4G.
(But I've no idea if the high register bits get cleared before the register
is modified.)

	David

> 
> I guess a user_64bit_mode(regs) check wouldn't harm. I'll add it when
> the vsyscall series is posted.
> 
> 
> 
> 
> 


