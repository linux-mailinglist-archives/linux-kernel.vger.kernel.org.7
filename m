Return-Path: <linux-kernel+bounces-751407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10626B1693D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 01:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A18165305
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148881DE89A;
	Wed, 30 Jul 2025 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KECMClRa"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227677111
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753917343; cv=none; b=qtm3Nfjc4bmxnsodYkUblW0G+ALmEaE+RJ0P76dVuCJjycGvySrmG+1eLbkUnHgPnE1MUfeAhBY4Mo4BvJC+op/dYUknpdX3SiyYbjw22eJ1jUWfT/JuujMcAW7IEQjHrg6ZsLJJ7Wkq6ZAZ4L/GWGKVDFg6ZIF9SKSqlxXlk74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753917343; c=relaxed/simple;
	bh=VaBo0qMXBUw6Qukm5bA/FuEZBJqFMknhXsZYWUD5ilA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qo+LdU9fduBHTLeuIhuwQblH+CtI1d39sgS5oPxJsRmbK13UcHSu8tTWEZAm7OcPnKLAAeEKIFL7KDo2UsYc3xUlYDTmeDCRAazZu+mi22qoFr2L+69uuijYZm4rJSu2RloG54Pmf/0PtEWKEiwZqlFGBnWwtc3gwu0QlMk0WG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KECMClRa; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af90fd52147so51984066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753917339; x=1754522139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zrorEb+Zqet9C5+oVSXh5W5YSkHv0u4TJBOY75jsBGM=;
        b=KECMClRaz2Zbmav2cF5uL/MrzLCUtllOt2js8WGtrfik7iQubWJfo4CUddtIUf53xO
         HRvRImj51v4J5mtRoJvHFh9HENd98cXxE+WhacaIsE5oKOBqlt9Kt4SP9uEkgYczEikU
         N6hUDNomH1gOP/neVjiA6vTRww2dJqRtx0CGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753917339; x=1754522139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrorEb+Zqet9C5+oVSXh5W5YSkHv0u4TJBOY75jsBGM=;
        b=eJV0M1B0tSEOrvDyRB8xVJnv2QmOFN4zojwpNhD2zh7eNnDKjPcitCMW4cOo9x7ztB
         i97NPJYVukZ5or2//IvwUpZph1QZJAL+DDFsof8HM3v/Hb1Kkqoyfx5xYikxxF0GvQNb
         Egh9Igo8TQXFBa3SV70pM7E2LuFl1RkdFyRs2og8eaMByBQThQ1Kzsjq0deILdE+v7GS
         o6jI5n/FKiIkXWNXFsswMVBsTpAg+7ABywKDUY14bdFHdwtOWKKcjJArFFQMvyJXa7yV
         /TtaBKwy5cu72vzmP/QUF9u0Z6fSX5APgHZ4mSw1xGEBxBs4blfzRbI9OATYxr+OqjZt
         s8ig==
X-Gm-Message-State: AOJu0YzWCqfXwDZ2jg8jHzxOs6EWHDBMmLjW4pR1TZlRiIzALnaxcloy
	HkdUOEHzs+wyE3AG63DPv72GH9NzpQnne8I2p3sdSd5n8r2Ln1Cb0ID4PHsSqMT0S4yvchH//Aq
	mTBcLzP4=
X-Gm-Gg: ASbGncvyq2psyfD2jJtCyKhaNYIZiKo82St+C1rxChbWmKYOfL/EpoGqAgU9wHV2pqV
	HoPOJ259rzfHNfF8+TWJkbXc+mPl28iJmHyPI7qRNca7q5tNjwNEtK2KOc3tTa8pOV/Wn4nKTxr
	Pw/OPQStzwUHFowq0DNXsz8WXfm/1I6NOZuM0cMkTTuVlBQyusmE1diT0n272jVeOCrWc60ez7g
	09VHFLDymlSf02pqrKEm9B1EI5Pe4lGwEbNUXKsyZO0nyTYT5xYYGQQYmhcOoTDI4Dt1xQxBGra
	kjIth86aaFQCwVwF4OXDkghVoer/UATUwPdaPImOCwlqw27TpenuOy6ETQEBhJ8FIvZL0gCrj6O
	1I48NJb6B0LeYaISJZkoi2zVFVCXengGwL6CRyjZ4suJiWoreerJYbKQknWI0+pOXNWQ7nH0F
X-Google-Smtp-Source: AGHT+IFux6zY/0ZyogCV9ld9emENWrqpTu3vdNia+KuCyOy3tWacNhxaQ9eXH7rKP/qXDfWIOMHlGQ==
X-Received: by 2002:a17:906:4fc4:b0:ae6:a8c1:c633 with SMTP id a640c23a62f3a-af8fd919698mr495384166b.34.1753917338827;
        Wed, 30 Jul 2025 16:15:38 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3cb7sm13337766b.55.2025.07.30.16.15.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 16:15:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6157b5d0cc2so342270a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:15:37 -0700 (PDT)
X-Received: by 2002:a05:6402:42c2:b0:615:8db4:2602 with SMTP id
 4fb4d7f45d1cf-6158db428a8mr4340389a12.22.1753917337349; Wed, 30 Jul 2025
 16:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729144226.6b72dca7@batman.local.home>
In-Reply-To: <20250729144226.6b72dca7@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 16:15:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+h2WR6f2g+3HyLD1Zjg-fXC8yOE5bQmetrPvWHCU-2w@mail.gmail.com>
X-Gm-Features: Ac12FXxFAH_zh2hgF6gUml--thoWzLsAGhMoPLICse8K6Cyzt_tZ0d_YEdj5GsU
Message-ID: <CAHk-=wh+h2WR6f2g+3HyLD1Zjg-fXC8yOE5bQmetrPvWHCU-2w@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Changes for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Artem Sadovnikov <a.sadovnikov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Jul 2025 at 11:42, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>   In print_graph_proc() the pid_ptr string is of size 11, but the comment says
>   /* sign + log10(MAX_INT) + '\0' */ which is actually 12.

Lol. Quoting the ancient Greeks: "Math is hard, let's go shopping".

That said, the comment is garbage anyway.

Because "sign + log10(MAX_INT) + '\0'" really is just 11 - if you
round or truncate.

So somebody may have actually done the math "correctly", but the math
was just stated wrongly.

Much better to actually write things out properly instead of trying to be fancy.

Becasue might be more legible to actually write it out and let the
compiler do things, ie just do

   // This includes the sign and the terminating '\0'
   #define MAX_INT_CHARACTERS sizeof("-2147483648")

which doesn't require people to know - or think they know - logarithms.

Random rule for the day: don't ask people to do more than third-grade math.

         Linus

