Return-Path: <linux-kernel+bounces-798802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 842B7B4233B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C84AF7AFDB6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54830E829;
	Wed,  3 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkdM6X5O"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E85789D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908469; cv=none; b=aNpfSxiFoW5/hcvfjEwbNFcIg9ngPQAThnoqX4MT0XPBMSaZmYD6WvrrQkQ0YOAKhbVyJmqXMn5gjctS38256ljzv/WdGBEtEnYDvtdcFQpK54viVJ9kqwEk8J/MrCYxeAb+Y3HLUZhyRLwjvKkkpbWGDaDrv8trLFlcQrNKigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908469; c=relaxed/simple;
	bh=xlzGY4Yj9sYg5TqCahXFHFeJRqNyyqdjAs9NeYa1910=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KL8qvgvEj/fE0gsqqKwaU/w0M/XqiyKhf22SKfz0P76oPjOni5LGCG+Fee/bk/nswYgMoFGUSwgsNCVvpw6YhOiWqWl7URichHRhGAxK95AI9ed4hzxPPfigmGspBd9CysPCGi9Ti4hPD1tUcaGSXL7ec+0sHYAjXHoZZHxlKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkdM6X5O; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326e20aadso7178736a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756908467; x=1757513267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5K9EI/c+PZFvJEHF5Aa1VFvLskC+dFsbaSIMq7wWgXc=;
        b=IkdM6X5OdWYIp+kkjplvZnPHntpELCVHt3nzCR+TsGDLk3V42S7l2VylagBbjHVAHK
         /pSlVPjG3lc0WelDBXMmpIXR6R8kVdXrKghsbsSAt7obM/2YUugpGisiZZn1oGJB8NpW
         2GebhwWAllxcfl93voljtMZa62qmb9Kzdb17XRCFKsnLxli194RVT7jBfmsgINvZmy/o
         Sv0g9NYdk+GYEIocNV2iogNTMelkuQxWrQShD2Cc7WKhg7El0p/ykHIq04I9VkdsAIFy
         JFe5TVkw4/xkhL4BE+Z9+YyYEYp+YCZO0VAV6M4osUFSlCBZIs2ikPoYN5/jR7Qv0N0u
         74dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908467; x=1757513267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5K9EI/c+PZFvJEHF5Aa1VFvLskC+dFsbaSIMq7wWgXc=;
        b=d2C9mrVe8x0tYaGvh7EaDWtNfW5FFknaEVpOd4LBvZnWNuC66Ambsr3p+TCHnvTcPE
         r+Ly2yRuH9wubU0rL/F4p6xP9sO3YAeCXyvD1Poa+GtDekTiAWUTbKSvXTh+/yRUJnr7
         +ZACzaZLD4fJlJk9qr7WQEKzgkK1BdctnXudR7oKDLaG3vBG5HdzonRmicJWt4Ih3Jla
         rbzv3DaOub87rtpGyZ6RiD6DU3vkXIbzhiyRLh/T/d5v8DkZ8ay5qDf2BP09Wk/HS1S1
         BmGxMY3r4CMj4g8LeAiUWSeXfoz6wlL8QaYN45EC8I7SWaZJeacB/QDflM8LSoCf9cVE
         oFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTz1psn85U6tebWH6wyZ9VCOggL9o/627bASa2pccYXcshyiUd+R80QE508MDXwQDtsxhxtHZeEgRulg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNe65/EZSQeN/xN/TTCHGInwDGvGd6FHomp1BLVaDzNCiCvcX2
	+ZMERDe+WeMc4Oke62HhRMsXYyN5olt9eVUI3vacq6cuRt+YVHh/V8Ieom/Xpwue9WSLPfzxbUz
	Bc1ra10A0YJNyLUKvolABWDhCQpYZAqI1h0/cLs/P
X-Gm-Gg: ASbGncsc6s67FPxE8DE1R9OtgPhhlt7td/U6B1yhYPsFQzHIsgll3tR6MSlv79LqBD0
	NH04UdJvWiNlDP15aHV+FcHQFKmQ9a+1BZqoQYSh2+X8UUvZIpq6tcZYnvcyDVjGNRUvob9iPfO
	bbQwLQegYmIHSyDZ9Vfb1wKJirs+eJacyvNK/FWg1OX8daSlAgUOqXp3K7T9pjqnpuWgsiLd0lZ
	oaLojF8IMr3FrvdaRDt4kz02VJXfuM7uUtxboDu9P2qHOxjbFLZcg==
X-Google-Smtp-Source: AGHT+IFuhXZJrFj9HYn4+7oas4LyVhrv+Mi5Jn59BmW6xsC0VtOu4EqtvC/C0bP5fykXZiH8qLFls+MaLNs5naVgZ74=
X-Received: by 2002:a17:90b:2888:b0:327:ad83:6ce6 with SMTP id
 98e67ed59e1d1-328156bab71mr18212350a91.21.1756908466847; Wed, 03 Sep 2025
 07:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901164212.460229-1-ethan.w.s.graham@gmail.com> <20250901164212.460229-5-ethan.w.s.graham@gmail.com>
In-Reply-To: <20250901164212.460229-5-ethan.w.s.graham@gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 3 Sep 2025 16:07:09 +0200
X-Gm-Features: Ac12FXz0U-3N7wPl6bYh7KGL8GiZ-rYE3Roev_WD4ikilRDTuvPr9ZMXra7VBOo
Message-ID: <CAG_fn=XxRoZJtxKJrLGTTV42H7gDMFEaQZiYQ+nFgmhexzgW9Q@mail.gmail.com>
Subject: Re: [PATCH v2 RFC 4/7] tools: add kfuzztest-bridge utility
To: Ethan Graham <ethan.w.s.graham@gmail.com>
Cc: ethangraham@google.com, andreyknvl@gmail.com, brendan.higgins@linux.dev, 
	davidgow@google.com, dvyukov@google.com, jannh@google.com, elver@google.com, 
	rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, dhowells@redhat.com, 
	lukas@wunner.de, ignat@cloudflare.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +       fd = openat(AT_FDCWD, buf, O_WRONLY, 0);
> +       if (fd < 0)
> +               return fd;
> +
> +       bytes_written = write(fd, (void *)data, data_size);

We need a check for bytes_written == data_size here.
There's no way we can use a while-loop to ensure everything was
written (because the debugfs handler expects us to write the whole
packet at once), but at least a sanity check won't hurt.

> +       err = tokenize(input_fmt, &tokens, &num_tokens);
> +       if (err) {
> +               printf("tokenization failed: %s\n", strerror(-err));
> +               return err;
> +       }

I would probably make tokenization part of parse(), but that's up to you.

> +
> +       err = parse(tokens, num_tokens, &ast_prog);
> +       if (err) {
> +               printf("parsing failed: %s\n", strerror(-err));
> +               return err;
> +       }
> +
> +       rs = new_rand_stream(input_filepath, 1024);

You probably need to destroy this stream after use, like you destroy the buffer.
Same for the tokens.

> +
> +int append_bytes(struct byte_buffer *buf, const char *bytes, size_t num_bytes)
> +{
> +       size_t req_size;
> +       size_t new_size;
> +       char *new_ptr;
> +
> +       req_size = buf->num_bytes + num_bytes;
> +       new_size = buf->alloc_size;
> +
> +       while (req_size > new_size)
> +               new_size *= 2;
> +       if (new_size != buf->alloc_size) {
> +               new_ptr = realloc(buf->buffer, new_size);
> +               if (!buf->buffer)

You should be checking for !new_ptr here.

> +
> +static bool is_alpha(char c)
> +{
> +       return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
> +}
> +
> +static bool is_whitespace(char c)
> +{
> +       switch (c) {
> +       case ' ':
> +       case '\r':
> +       case '\t':
> +       case '\n':
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static void skip_whitespace(struct lexer *l)
> +{
> +       for (;;) {
> +               if (is_whitespace(peek(l))) {
> +                       advance(l);
> +               } else {
> +                       return;
> +               }
> +       }
> +}

while (is_whitespace(peek(l))) {
    advance(l);
}

> --- /dev/null
> +++ b/tools/kfuzztest-bridge/input_parser.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Parser for KFuzzTest textual input format

Some description of the format would be useful here.

> + *
> + * Copyright 2025 Google LLC
> + */
> +#include <asm-generic/errno-base.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include "input_lexer.h"
> +#include "input_parser.h"
> +
> +#define MAX(a, b) ((a) > (b) ? (a) : (b))
> +
> +static struct token *peek(struct parser *p)
> +{
> +       return p->tokens[p->curr_token];
> +}
> +
> +static struct token *advance(struct parser *p)
> +{
> +       struct token *tok = peek(p);
> +       p->curr_token++;
> +       return tok;
> +}

It would be nice to check for p->token_count here.

> +       region->num_members = 0;
> +       while (!match(p, TOKEN_RBRACE)) {
> +               err = parse_type(p, &node);
> +               if (err)
> +                       goto fail;
> +               region->members = realloc(region->members, ++region->num_members * sizeof(struct ast_node *));

Missing a NULL check here.

