Return-Path: <linux-kernel+bounces-890029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D34C3F18D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB2F188DF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A2318141;
	Fri,  7 Nov 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZJ+Tzia"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7143115A2
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506774; cv=none; b=kSUXIgeCYk8h53B/A1P7OiqqQ0pnaS/V1nqeHXGa/yOJ33s6aWKKph2Q+jDc1P8AAR0JTNkkeKKNHA5O9t+H5te/uXtEVLt+g5TuP0K3Eeg6lWZFo9lbtdZDcwxynuBmMlZK594UT8yw1PMIzOBFtVF89O5IJtucjC5EHQHdAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506774; c=relaxed/simple;
	bh=ySb+pop94SqpdbyZsYpGfmunwgkKv5LASXUw8Mbt2b0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaX50VLeZg22HRbvg6cTUs4xtXqqT4753b6A8h/tiFw+yJ9U+afH7JFh6FgJATpl09iF+e82osY/J+OK9zQiKSw9z2AHR8059bW/z8arv6LlxnbAZ98AhDomxeaD61MVjKliB8qu3pbilr3eFbN5js4Zdwaef8/woFL+2FPrQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZJ+Tzia; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so282813f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762506771; x=1763111571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwbNx98NAV67oyTmVbgDZ/t5BsyU5lLwVlOoJ6t3e0g=;
        b=mZJ+TziathtEj0lCeVghoJ8qe5Og/eCculTzvtfLW7O4TCQmbpYaopK8zm+OfFQAVe
         50Cl9A9mjJX1v6BDyftxzxMIOK4K4XmF3xdtLz3dYY2n2dHduLbqcBrc7lpEZc8/pSQ+
         AmtSmiTIa/pswSLxfcxQ6a8wS+HWHlofa2FnCPKICvxo9m1PL0BDQHMVQWwd0nKgDuf4
         /aIq3e3Uy0tGEmL6tBbwmdlRlqdG0e8xcVU+ovpw2qE+R9zEOuNXpFezzj4R2XDNVFZ3
         wZS1kAIAlLEzs63cLGCBj+4cmz9hmrM97e5HMceViOtkiGL/8jACByqHknakrcpI76XU
         cY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762506771; x=1763111571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwbNx98NAV67oyTmVbgDZ/t5BsyU5lLwVlOoJ6t3e0g=;
        b=Vyq184oX5O1rcb6y9OUZE+kSlNCstP31z9FTvsUfXn1AIVJYAFnPJ4yBKkrRHHPJ3U
         d7hwDfzvjAJdWGZR7WJp4WCe6cHpCMwZuk2Mc/lgv0JNt/qQpD0d9gHB6D73tTqPbwrl
         YraMnEdYfd9LG5KF/q9IU9GHWxkmeUUeBd6kRKjRHIVv1yPyafzytaW0m6XZGoarHT8u
         DL/YnwZtJx7PBwf8l99qmxTzn6SXnu0hGgy/0jXARmsD3+QrG6ZkfhN+GjEWFZo7vP8h
         LAl4mEDd1LoX+cZNDgUNtCN1O2UseYHKjtKCSwp7HjaajkkiZ+eaArPGOJqpnkQRlvZS
         wheQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTGY4OxVgF5b7ov5tdpli9Pugp9D8ossbp/saSn7efYPkFYp1KzVSfD6IXGux6KLP2fzgHA3be3IBMsV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWPm3W1y0bEhW8poOBVlxldb1uUFRHnLah+DxQSsNrd9nwWdr
	7B2tjkUYTVGGapETnwNv3q4xCC3/Hh77IC3ddFwPVgkcLlFO9yQwk8e5
X-Gm-Gg: ASbGncvcO/0Vhy+r+Hmp9e/ZdsgE9SW8/OSnu3gy2ETn1ULdki356u2etfAAaftjmOu
	2tNK5mzvRHOhDPo/07Csjkliv59kJJRQxmojQ6UHHaPIopHO0h1VmKNNc0xJkH5pCpGC7i7DhmS
	SwuZV6Jh9kMcVrmvtoAte8meiZ8OK+syPUkqSqM+y7gps4N+6M+ycdtsljOj1a+ZYu1aub8SQws
	wmw4QFPYuEktWogiY9cROcJx8g/86lcdulkT3AB9Q7ygYj91PqlHI+BAyBnhg5DZaKJKcEo/jaQ
	PusR3HvtNNxa533C5NoFPu6aEEMBvBpCkQYlLLQndsDRzm14ahDrtaV7spapqoWEjBOhxz79d7/
	lhUVmyUaTKHMaQgRYG+5ewrN8Oj61tqZUdPEuzEPyfY4yGiSkZoWPiR7mMouQX3cbEv7Mm4Qb80
	4BbXccIiWNKiIaRPPIJnvscfkrjnHmbX7uByguX/Nv2g/lIRQYs8kH
X-Google-Smtp-Source: AGHT+IG9saNXs40oR1IEnqn2ZJqpHZqHgNAPFU5PXOa3lUzB4P6UMLrs3Ay2s/I5KpU2wmqmBc0PbQ==
X-Received: by 2002:a05:6000:40db:b0:3e7:5f26:f1e5 with SMTP id ffacd0b85a97d-42ae58812c9mr1862887f8f.23.1762506770833;
        Fri, 07 Nov 2025 01:12:50 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf35sm4130393f8f.7.2025.11.07.01.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:12:50 -0800 (PST)
Date: Fri, 7 Nov 2025 09:12:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Junrui Luo <moonafterrain@outlook.com>, linux-kernel@vger.kernel.org,
 pmladek@suse.com, rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
 tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org,
 mchehab@kernel.org, awalls@md.metrocast.net, linux-media@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] lib/sprintf: add scnprintf_append() helper function
Message-ID: <20251107091246.4e5900f4@pumpkin>
In-Reply-To: <20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
References: <20251107051616.21606-1-moonafterrain@outlook.com>
	<SYBPR01MB788110A77D7F0F7A27F0974FAFC3A@SYBPR01MB7881.ausprd01.prod.outlook.com>
	<20251106213833.546c8eaba8aec6aa6a5e30b6@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 21:38:33 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri,  7 Nov 2025 13:16:13 +0800 Junrui Luo <moonafterrain@outlook.com> wrote:
> 
> > +/**
> > + * scnprintf_append - Append a formatted string to a buffer
> > + * @buf: The buffer to append to (must be null-terminated)
> > + * @size: The size of the buffer
> > + * @fmt: Format string
> > + * @...: Arguments for the format string
> > + *
> > + * This function appends a formatted string to an existing null-terminated
> > + * buffer. It is safe to use in a chain of calls, as it returns the total
> > + * length of the string.
> > + *
> > + * Returns: The total length of the string in @buf  
> 
> It wouldn't hurt to describe the behavior when this runs out of space
> in *buf.
> 
> 
> 
> The whole thing is a bit unweildy - how much space must the caller
> allocate for `buf'?  I bet that's a wild old guess.

That is true for all the snprintf() functions.

> I wonder if we should instead implement a kasprintf() version of this
> which reallocs each time and then switch all the callers over to that.

That adds the cost of a malloc, and I, like kasprintf() probably ends up
doing all the work of snprintf twice.

I'd be tempted to avoid the strlen() by passing in the offset.
So (say):
#define scnprintf_at(buf, len, off, ...) \
	scnprintf((buf) + off, (len) - off, __VA_ARGS__)

Then you can chain calls, eg:
	off = scnprintf(buf, sizeof buf, ....);
	off += scnprintf_at(buf, sizeof buf, off, ....);

    David

