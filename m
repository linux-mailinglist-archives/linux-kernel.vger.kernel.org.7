Return-Path: <linux-kernel+bounces-845800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC60BC6202
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B8F94EDB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F26A2BE7A3;
	Wed,  8 Oct 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bo71i0b+"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083942E229A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943572; cv=none; b=XgucLWqQPsE2MEmEdiE9ifYBtK8nIACJrc5gExfdFZcYOucwcZ5Iftcxts984/dgxmTcfcjBjMe6qx83SjyMWt5Get8qdTsQoQxH3G2uud/sTkXImE0b2LR3rPHg8tr7Okz1R2qh4+2/TmTOgF6qnnYKM8f7tO/tVM+GU35pu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943572; c=relaxed/simple;
	bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWAyBnyaOa1ZVIJGOM4YN6f5PToOZiE7MDBg9vL4Y4AbjSBAeMg2yWE90Y8wo32EbSr4sOaxiUhv5F5Ve02QkGbEeUGzm44tWCeEdryhbyts9UXrYJx2G59vzWlCww6CUbnvuUIH2s+7Fy7YdIy0iIa5dSeqPwZipaRU9v0Iv6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bo71i0b+; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-74f6974175dso906507b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759943569; x=1760548369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
        b=Bo71i0b+i59XE8ndqAGX+HyUNnuN9NvwMpvW4aTtrQSQlPpIMjH4u9QdyYNw9yP/5h
         V4TAabAjATR5PWsYQiK7gl6V46/K15pWImSTeOpEEkD4veVu0Q9Tmyomue5Vz1MCrO78
         EZ90Bns8SS34hTs3lz01GcMAAHy7wY3kruPjdcp+bkMVokj6l5JTB8BlpYBA86PneIEP
         xo9nAzwQeJUS4nXZx8Pp9CsSIF3My4bkw/IHYnE1dsrY/gDcXpT5blHYBHKcNoSO4b4z
         9GlfF5GwGCoZeCYPME5ILU+qvAjLW/LdfkcFan6nzbjQXi/58UgD8Y3DIMIgafPR7B7K
         uJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943569; x=1760548369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXRXen/paY2I8AfimuUYl6aegwK5TnJBROTQaPpMH7o=;
        b=uEdF6NGumqldZxVZbWnyvg6Y8s+kJlJgNEn0lyco1VK0vMQlYWRJCLsQuLsXZrSxjC
         9tK//iZ829JwoQL36rclYUA8aEu0cNTMa7iK3iFeBQAg1VS3GFoSpe8Dtk5+iCHLl6EK
         ZNY7CldvOSDCVjtMbZI1BJt7u2hoqdMbizXEqhtj3kYqCvgUtv3TuQRrrjXcYRfupzR7
         kkw0aElrnYRipPh+Yj48AH59HPgB5HNMEhe9YkLRFciL1tq4nRyjKd3H9SbXl8a2Mp+l
         AziJbNKOPvxnOAeL358PFOVUTGq3JFadrSSjgnHdK8aCdeSip61gRU3N1JTaYW7rDH8c
         oa0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF43Nc4e4mSZgTUEaBVQ9AzjMwzrtWd7cdOcGS8Y3l29xmXG8kewOdbqzV7cLt86W4kIiKA4Hltt5f6GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAfPrU9hzL0OPVEAv+GyW6TIssTez7GwDPAXBkEjkp+Mclkbg
	p9MM+LwBQQzF0MwJH4l1dpBGWc3kzKuR0g3muRAGymIi8Q8dHPRJx+fPTH6ze3oPaJu7SdMbxJz
	aSWlnJL1f5gPgJlIguZbpchgg70Mhcmzga6KJNLig
X-Gm-Gg: ASbGnctfR2zFBIq9qNmWsg5vv4WRuEzVenzqnEUY26OJcT1/EJakdZ5m4AM82j0Ixev
	1MvdGCOzsDqYAySjWiveKqKG+CXUp72SCImE7l9QgovNCcbNsy/kha7zyjc1kVWV6xzcp5rvwEo
	IpMaWssHWaewrZ+Z9e7lmQV6Ccvpt/8pdml6TzLUAiapSSMIP4L/3f3Bj7GpVzFLU2GBk5+Vmns
	jcS9hU9R+bebG3LN7I4ER5ayUPZV8y2LjbGbJcheigtci3MHz9QR9JUYDfrTBtquCs=
X-Google-Smtp-Source: AGHT+IHC6J7ndh3GhjpBhSyUbtmgShHSwrKImun5tVKXinNrao1jet7Nrip5xHU4l1aWy75vzkCWg2jOpuWyhQsCFpY=
X-Received: by 2002:a05:690e:4289:20b0:633:4a1d:f9d6 with SMTP id
 956f58d0204a3-63ccb90536emr3975966d50.25.1759943568487; Wed, 08 Oct 2025
 10:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007003417.3470979-2-runpinglai@google.com>
 <20251006221043.07cdb0fd@gandalf.local.home> <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
 <20251007154308.5b158d04@gandalf.local.home> <20251007163141.1034b120@gandalf.local.home>
 <20251007174208.11fd02da@gandalf.local.home> <CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
 <20251008123259.1dfc621c@gandalf.local.home>
In-Reply-To: <20251008123259.1dfc621c@gandalf.local.home>
From: Runping Lai <runpinglai@google.com>
Date: Wed, 8 Oct 2025 10:12:36 -0700
X-Gm-Features: AS18NWBZ_2jIHsOqsd1oLxaaH4vYuG-AVzpDFpi_S9SaadhDzofyG-wP9wS95Gg
Message-ID: <CABgk4RSb91kHHGG4hqyiSb7w1cOLQTXE1+TxCCu1WwSimQE5og@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Wattson CI <wattson-external@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 9:31=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 7 Oct 2025 16:25:41 -0700
> Runping Lai <runpinglai@google.com> wrote:
>
> > Hey Steve,
> >
> > Thanks for providing the buffer-based solution. I tried it and it
> > fixes the problem!
>
> BTW, I'm about to post a real patch, and I'm adding:
>
> Tested-by: Runping Lai <runpinglai@google.com>
>
> -- Steve

Thanks, Steve. I'll be looking at the new patch as well. I can also
help test if
there would be follow-up patches.

Best,
Runping

