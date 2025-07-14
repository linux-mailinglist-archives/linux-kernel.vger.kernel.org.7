Return-Path: <linux-kernel+bounces-730691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6BBB04833
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B21F4A44DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD71E9B29;
	Mon, 14 Jul 2025 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hzO1PJQ+"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D513D521
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523249; cv=none; b=ZZkIBukg/9YKNTTr7DwUYt6jID9df6B+0mOQrHEWaVlus4LT38gbrv9euMG6bmSVLK/zSy/zStlVDJnl7nIOoYtXnnvMG8mw/I0Ma43eZW5ZVti/vB7cq5drBYwOGp23bsd6JHyNI0uTrm/gQbYfHaW8sXn1LH1irF+P71s/WbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523249; c=relaxed/simple;
	bh=CxW9zyaWbfvxUJ5FH+u8zmiebVqSyPkg1iQH5D1Swew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTMuDsqT63/3DcuJGbFcEK4ouLukpMhMhqCN9UUCVX3Cs9k0OCdgvMf2QavNf+BdYzGYINinbndbhmeiHsyOZrDc7Fo0B2fDuPu5Txi/rzXDv18OKl77FhBlGKvIqCr4aKFi2GWEiHdwkFB3gIMay3H+EGjkmFY/8qOfvCkhhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hzO1PJQ+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae36e88a5daso942890366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752523245; x=1753128045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CjSXQ4ZPCY7IV0/8120JDz4fl10wx9faWYSddMpp5gE=;
        b=hzO1PJQ+v0Rfd5/iQz4gC/0WIsQi6KHU3MUnYvhxyjkCuG7OY2TrZV0ZFVlyqILGtr
         UWisa6uBYQreglOpiPasCY7mAnxlcdP7nYXRh7hQOcc99TwEN5q3yxFLpYS5wQ3Em7Lg
         GhB1FDJ9KASCs6SFJU+z74n4K3arI1Oca3rAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752523245; x=1753128045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjSXQ4ZPCY7IV0/8120JDz4fl10wx9faWYSddMpp5gE=;
        b=Uhx7G/wl+n/yM0vOg7smx48gIpFcLpEd1ffmXQ8Lwm/ABqjCj4AfOuOI75U5lDaWzo
         7cHYeyRRQNlePiZfN9bIz3XV+MRG9yUPSpU6me+b5oZKcL2WtmDG/hSbT0lrWT8XWMJg
         PuyoOqGcuCpiDHuAeIdjiqYyMfj0mNbSPf/otpP06BvHFz+8l9+K8j4//qOkf+G+2WOa
         SXRBOFSAIlGrF9FA1Rg6BFJ5SoGlxM9zobz1iTEkBE5OkzElFmG5JBiBCZdftuvG8jc5
         nmp5oQJiim5YjtOgjmL34w+jRIF5rKKZTa8HDqU3D7oBfUtGYQs/MTYeNA0AlxVms2Wd
         R8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSu/BO3Jn4EjMlMu28qYPwRNSS47GoHP+6UJv9qBqtqkWfnqnGCyaFn5UR8q38fl0QdLbihimvNfYTsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeBbJAeq4dK+Te4h8k+lymigqwz8GrpRAEkOgeaEvcGcxzkav
	rMQGosD/5VjqLOcH+BJ25cYUBQaQih5uNb7P4yg45kPA+9IV6ELxhNeLhwB+VTLyFr0y2sUw5+v
	yxH0gzVA=
X-Gm-Gg: ASbGncshQduzhxhtCOzvZueq1IgAwPbfzWFToQr75Dv8BsGRrYuJCvIpk54ISOBAcI/
	CxmOeBnNYyc8da23osu91W49HKen5J72HEkqhSJcl0Q+D0ZRGqnS7vKCd3mKASQHXG2CdTsU4qb
	wM7l2aln8GpS1Uky9WUja1zqfK/3Bt4I22z6xwWhLPRRgx8H0knQEzrAQ3l4MDI97LmDhk4tsf3
	a6c4bzJhB7GwooiDdz7QWJ9+/URNzg+hrP+K+ZAo83I/6iGStA14kXkDdWUAE2MQcrctyP/Cnek
	VU+Q2X0M90vsUZX3ZcnZC9bteMiUxTNTBC0LVyzPi4mpiExgo8ttXbyDPZ03nHo+5yvPiBf7pfD
	kvMJetc1tw0lYhm4JmQ6fdPW8OUDTB9WSp+h06EoiOzGBw5lqAVTSYL7hJLW1muFnI3o4MM7u
X-Google-Smtp-Source: AGHT+IH+PIcUvIUpS8lvx/lgPcI9zAI+mulTChydo9QHrg3S6nksU+hywZkwjEXAWKWjqCwq/Ni6aw==
X-Received: by 2002:a17:907:78c:b0:ae9:8dc8:4f32 with SMTP id a640c23a62f3a-ae98dc851b8mr937233766b.27.1752523244912;
        Mon, 14 Jul 2025 13:00:44 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910d2sm872079566b.2.2025.07.14.13.00.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 13:00:44 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so9304175a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:00:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSBMtque/44VP2rd3Bi7yCZR39rVXcrogVvhFOGhXyJM3j43VTC7syV47R6ncVTyJlGpoujy39caruMfs=@vger.kernel.org
X-Received: by 2002:a05:6402:2109:b0:60f:be9b:a2cc with SMTP id
 4fb4d7f45d1cf-611e765076emr11335991a12.9.1752523243917; Mon, 14 Jul 2025
 13:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
In-Reply-To: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 14 Jul 2025 13:00:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
X-Gm-Features: Ac12FXxEwj76rBnjNiSKWrG4545ZDG92vEKpvEMqe2y_grVL7YGP-d-bLGOQCcM
Message-ID: <CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
Subject: Re: [RFC] LTTng upstreaming next steps
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Christoph Hellwig <hch@infradead.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Jul 2025 at 12:41, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote>
> A) Bulk upstreaming

Honestly, I don't see the point.

The reason the current tracting infrastructure got merged was that
people were willing to do it incrementally.

I was hoping that there would be some kind of eventual merging of the
different ring buffers etc. That was discussed as a hopeful end goal
originally, but here were are, decades later, and it never happened.

And honestly, I am NOT interested in just having two different tracing models.

If people need two tracing models, then the other one will be out of
tree. It's that simple.

Because if people haven't been able to agree on common models in the
decades past, I really don't see the point in maintaining two models
indefinitely side-by-side in the upstream kernel.

So as far as I'm concerned, this discussion is not a discussion.
Either there's a way to merge things incrementally with SHARED
infrastructure, or there isn't.

No "two different and disjoint trace buffers".

No "two different and disjoint trace interfaces".

And very clearly - based on history - that unification will never happen.

            Linus

