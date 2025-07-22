Return-Path: <linux-kernel+bounces-741559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE20B0E5C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD03F6C446B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC1281370;
	Tue, 22 Jul 2025 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iucbrPu8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDFE38FA6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221227; cv=none; b=K2yCQfBGTCEfQbd6bzDIsvqYfROc+jDAgIjuu/FmTPBOXMFv269t7CbN4izagcq+cLoM+jnE4c0Q5RHbUjNQe7ObIZpO+ALyEbwq2755R6YJQrSK/FLtNQVSEhOEmOcFsIGaew2A9j99Z+296nfGyQDLNICEoG2ccmj0Fy61p2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221227; c=relaxed/simple;
	bh=B4ofYpB2WdXns/AekUTVXHwmAL4QuiORXU4cylbYwxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e41FjNZmDUZjRiFDjVlvuPNi1f9qEpX4bS2VRNwJcufBv8T39CnLkmUmxBjlGK4FtOuZYQV6ghO/ggLCLT4sJYVzMJS4w30hcOVZGgeDx1Vn7JbVkXTHuGw/YADZ4NbrmBJGIufAHJut7bWhAEgtKVA55V0ASFhjFlTrCPzWkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iucbrPu8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4561ca74829so65794005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221224; x=1753826024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+noQZJQEssIELWk3gewevOCpHHQdI8gAI2QzpSpoAo=;
        b=iucbrPu8cpdSq3WJv89fSSaqHKL+h6A+AXijo3rjDeeA302GHT7KYcv2aZJljOaWGi
         v2tg7x70v1AA+fAU+5AzLM9QbK90qL5Oo8hlJkzjUA0FE/fuVHtvZ1Xmg/LDS+1qSXsQ
         TDhMRzVFTL5sI1JLlauAIzi7I1BPoYb5l0HC3QUO5AMkmyRI/bW+OPmXlF1pLK67AAHe
         BLcFNU7yAosc29xRBBxEwAP7Y9JEkf8v1hWi1V5BsJtOPxWC0rWT20Xfmwhp27cBIlNv
         zfQTu0T19BXcWJ5BEcMKTpfTYic0/gCv1/iNUcObV2RjOCVVNgXlRitZDCa93MloS770
         Z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221224; x=1753826024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+noQZJQEssIELWk3gewevOCpHHQdI8gAI2QzpSpoAo=;
        b=qawmUpco6Egrxc8qrreJzBe4s/u6yddaWWVBdKRDJTThkFTjwA0Hol19FU7YDNpVTc
         916bgb7FUXsqkcUiDZ7GU/vM9I+1ha4J+u8EislYqCNC6qJ01vZRPcNB8TUCbvT5+3UC
         z/lWqLJT7eN9fw04SYZtTmF6NEv4P60YqFCduja4Yv635yAYShz9oofcxPzRAjRwqE/R
         wBT1wDM5MZ2k6IPOCZ4Yvnv57sSDJG3gqEWO0rGvN+6FhOo9gUjWJrT29P5IRHU20xb/
         qtWtP8iag04ufqYSqVs4jy9tXm49JmBm4XXtgBYZ7hiKPuqCuUDtOHUBfrRJ3D4BpB+M
         yphA==
X-Forwarded-Encrypted: i=1; AJvYcCUSW1dwWqtcViGvbzs9e6qaNCSHhr6vYOHX+Z7FculM2gZYJRBsfsORiPq3o4iyXbudRQeu8IUhz4KqouE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG0o7QVNxzYre1QnQlBs/ObXGSVp1BmiNEUEECyP9NzDdU3TCU
	+mgStW6UTtJKW3emPs0AQ70z5cGbwI9JmK1vkZbw1l2URWiSMj3I0mdU
X-Gm-Gg: ASbGncsMFrEmfEvj8xTkbPIhVnTzdqKpb9l4CWiuneBZdjjH3WrRcyWKrdvUCMrzlIc
	muzfSk3sv90vHAdoEEEk60z8L12hJ9kcB2MyCcyxMzt75toyVJ3RvidafhfJ/44nFyn1/XnWcOF
	Veis8pP4bc9j1iXW4w5g255+ZKa40s6GJNDXh+T6yyEhqDqiejIJMPPGixe0JGOimWn8+Dj3fDe
	oio0utnSRlMbTZymM7Cccs3nu8gt3tG1mJ3BmKPVPyHK1v9mlKREJzq1PXVjhn2vostzH+1vSUb
	DuSLRQlQJi4+e1zJmUpWsvV3x0x9Bp7C6ALzwEGl1wt/GQbgE0Z6Dw07waMtq/QOGiEZ5YPhCdd
	u/4QZwcqhD7r5r5lNfm9Css+hdaRFosGgCQDt7TqRzpy47UurCFS3f7SB3rOqegoQ/Mbp+F8=
X-Google-Smtp-Source: AGHT+IGKFGcmboU0QvjA6n4E9IvYd5dxa5l2PbX7q7Jloez5yb8qUzfbCnoQ3Xh/HxPmSimDkLJezQ==
X-Received: by 2002:a05:6000:1acf:b0:3a4:d6ed:8e00 with SMTP id ffacd0b85a97d-3b768f1e680mr526673f8f.33.1753221223784;
        Tue, 22 Jul 2025 14:53:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d48bsm14457627f8f.62.2025.07.22.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:53:43 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:53:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Li,Rongqing" <lirongqing@baidu.com>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250722225340.1b0b29fe@pumpkin>
In-Reply-To: <B22E6B1E-9569-4267-87E0-F442B86A49A8@zytor.com>
References: <20250721130422.GA31640@redhat.com>
	<20250721192053.58843751@pumpkin>
	<20250722105034.GA2845@redhat.com>
	<20250722130947.0c97c96a@pumpkin>
	<B22E6B1E-9569-4267-87E0-F442B86A49A8@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 09:53:21 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

...
> 
> Note that -1 for division by zero (not necessarily for overflow) follows from
> most natural division algorithms, and so architectures which don't trap
> on division overflow tend to behave that way.

Do you think that just returning ~0 is enough (maybe with a WARN_ONCE) ?
Code can check for it and the number of false positives would be minimal.

I have wondered about having muldiv(a, b, c, d, errval) that returns 'errval'
if '(a * b + c)/ d' overflows or if 'd' is zero.
Otherwise you are trying to return too many values from a function
(esp. on 32bit).
'asm goto' or 'flags' will only work for x86_64, starts being a real mess
for the generic code.
(Time for a language feature that lets the caller see modifications to
a parameter that is passed by value...)

	David

