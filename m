Return-Path: <linux-kernel+bounces-790696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCCB3ABD6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F0B189D38A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7522877FA;
	Thu, 28 Aug 2025 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8EIouBG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6630CD84
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413758; cv=none; b=PfCHAi/reYpczufuPLOdaIUZIBmdk157HgDLlAe2u/KlB0ckImB8VnzIGFElg4cmHyhpsYo0h6Y/fAPk3Rx5EyTr+0KxrF3tODV9uDeE9QF00TG9rEoI9AzRVbiGapJ0i6nFnlvg6ZuSNgJYYfDgsBVvjW+uFLHamtXlsrBrS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413758; c=relaxed/simple;
	bh=61464PJI4DWr8JkU7InPmzajWChIA2O3MGIoKRnsdwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpGM7LmLISSWxy9aE2kzliR3UkJG6iv3t76LEbJNQDFeTPizCvSllWg4w3AfZbzAQA2dV1fqTRNxgJ+RuRmtG49QUG7JDPSN/H94sC57t5eqvGV7aprdRnB26N3W4YHftWbQ1irNCbiZptUxU1FARJv9Xy3spoDzVFAwAl7IysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T8EIouBG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so1836778a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413755; x=1757018555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=T8EIouBG3D2Se6+lZ9Y8Y6gs3nrHr8gKHvLULn4zm17Zv7dekl8BbjF1sl6ZylIH4g
         2IlPw/y0jLPMGScgpU8R7h2BEqRv2G4RxrvCHlcxYfSForyG7RPhhGf+CFCgUxeTDzpk
         2GZmqIJn4cELT7HvVtPI3FBHZGilANs7ztFOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413755; x=1757018555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGc1B4o6TX250gyAUYjD7hu3uwBxPYd8xYyFmYM2QfE=;
        b=vPAIQBdVN1EaAs8Pi0F4dzeS609hpipQ9adzXZ1WFqhw7lr5f8w2rFkvj+LkL12jGH
         nbq8uQYIMPpfbKchbYuF1VqC6A4fN/BCdbEI9KYz1KFVEpykpvEL2Rk3A38rR7n8Qhns
         EWOxIBg0h3CHA5a9RgShYICLJCyrgDVkQad4+1PtkXw2cLZDpMDka75ux5VqfrWaFNeu
         ekp49tPW04GQmxOfwV/HgfflqZZzBd78xVn/s88WehQDCdP3meVO8sLbGftg+283CNsm
         Z0cXvcwjJ5l3ma5C5KLwkH4GTqOX2YMUYQ4e0miJAUQS7i12jSyzN87t6Iq2A2AcARk5
         zciA==
X-Forwarded-Encrypted: i=1; AJvYcCVgjlXJBqt5ltSOEQLYKUUxQOK4qd72WsdZaN1YQioTM2IIxN14H0yzJp7QwIRGwPF+ubb9D1WmUA8ROHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFDpAHw5QWN5Vw4ZWpM+GOeuXW8iwG7V5Dz+L/y6xYOvra9wS
	YU13RdLDZfxZErjfBG7Gy7YXCVPJthLfPOyWNz5sSsS76dOtQGep4HESbL40qtme1z/KasbHWO4
	wfbn4O0o=
X-Gm-Gg: ASbGncutOGdSQtcZ1MEsYnAc4p9a6kFb01t1Du0C2BLVRZ+RFAJh8eWfeEPxd9OjCHO
	w/1dSGTbZhhqZeeFRZVlC1glp8tqqPFuVAiNy1Z8M7sfBiB0/I8noSP4VNNLPxACvYZASyuU3mz
	f/K9rRf3vxrXQw1BN3xu58jyp3uk4CiZpieFRYgU6O3DtDjeC+nSkjic+yI78blHrJ8wA20pLJi
	qloGpsyv6GAh9ALAWY88SltOURh7eVntfzQxAhqaaPN7EYeXooMivGeXif9rIvBccyeOHZRZh4O
	tVaNNzDTZuS9A27x96ibaNcfvxqrQy2G1opbz59CvaIt7qJHIWmrKy78sDm+5gEgHZMo25hS9s8
	YJsZWyGAiTOHP4uIwjnMNJDNabDhTgi7W/NCCfINpJP6cT1e9XT3p5Dlk8RHDk8J23ikRt7GTt0
	yasoFMsfM=
X-Google-Smtp-Source: AGHT+IFlrekYV79YMjNjpLY7hS2Rq5Ib4HXoDQeDlS+1gNkfbFymmleBSH9v7F93z0nadHtNoioeYQ==
X-Received: by 2002:a17:907:3cc9:b0:afc:a190:848b with SMTP id a640c23a62f3a-afe2904652emr2403191966b.39.1756413754719;
        Thu, 28 Aug 2025 13:42:34 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8ed2sm34754866b.66.2025.08.28.13.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:42:34 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afe84202bb6so175908566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:42:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWgQIQc29jFxRp0C5nkYp0um4X7PcYeZOmeHJ4O/MmqLtzHHwbBS7dVZPJzSdwft57wNx/HGa1rs8EK304=@vger.kernel.org
X-Received: by 2002:a17:907:da2:b0:ae3:f16a:c165 with SMTP id
 a640c23a62f3a-afe290466e3mr2506319066b.31.1756413753770; Thu, 28 Aug 2025
 13:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
In-Reply-To: <583E1D73-CED9-4526-A1DE-C65567EA779D@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:42:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
X-Gm-Features: Ac12FXw_0KhKfihCzO_aKUdUYEG3s81RDFh7edU8NIuCUQQEYmMIvEmP-xmYRFk
Message-ID: <CAHk-=wjTUP7Xogf+owMM_J7GOR4O2RUbiQiL6gdwrKobhD-N=A@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:27, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> The path name is a nice to have detail, but a content based hash is what we want, no?

No.

We want something easy and quick to compute because this is looked up
at stacktrace time. That's the primary issue.

You can do the mapping to some build-id - if it even exists - later.

               Linus

