Return-Path: <linux-kernel+bounces-721945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAEEAFCFC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5C7718933B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA212E4240;
	Tue,  8 Jul 2025 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Af990yjW"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F012E3AE3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989958; cv=none; b=je4BBi3fvFRpnGhP0f6CHZUSZ5fVYZ14FnD9oDw3xRVEnFqg4hxZUDMKGASRt0dRfgSaJwWSl5Hbfu9XhXkdjykZ0F5vYClNpd0e/aabF1CS2DhAgG22N3E7apzyHOTvlNdkQg4aJjE9ODUgEDgJ1kB41EHxpDAFdS3VQzgBALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989958; c=relaxed/simple;
	bh=VB4DKDbnFxxhgT4wajWqmZ83svuBw+tft3pDkE9FqT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yp0FKAKE3LhG08CONV4ApgcRtdtVQilekT48dpNurKgvYjlieMuI9i+QKTyVPCg6AH2y5ytwNSqcxKzb7V7Ssw3wdJ+QH0ROKUhfdH+O5WU9A30ak08oP2ZvF+EZvYOXrHYaErBqz3GCUGBQkaB3mbFVBztSVfKg9GV7WSFfyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Af990yjW; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so797902066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751989954; x=1752594754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=Af990yjWdUtKgeDM6qgEQuHhgfzmL7G3v2uLEMxhqK4HvvaU3K1DRwnudMFD4qePiG
         mWSbFqNJ8VMzN70DE2286Qv7PyE0Txpzn8XNHziHo5c5QSPuMQkSIdvOGtU61AcN7gpl
         9Pdt/LqRYDtdMfJx4u4l3a79ihSadDLp1+ZdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989954; x=1752594754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1jzCZfbh+UOZgumo9HhTaPJort8G39J3Qx1CDHd6zY=;
        b=P9aIa6adItHHIiUEmOBD0in3+xtQ20NRYqoUgie8eeLTWN07dAsYiVxxfij8hOk4S2
         WZaeBDNgOCTZtZTCdkI+zhBd846aO5tMx2I1K2OWdvJf4D+1P7VHcPbvI+4T19U4xquV
         5VZ75KXEbhtfSD5xo4N9+4zWwWQPvAnMmy52PF4Yc/D38GxM3nfYEAlEJuWc3lWu1XKT
         OgLcvYulw0TsbN+d8bf7aKj59WT7X1dAPLHALGh3NQnLbFLDWNLOpfXrbSMaBoQcwW+n
         PYSXR3dr532NZyPXemmjz3Gi8ZACIZl0NPWHZ9vJmUiI/mGa/ZVUHU69NIJr9v2sLunJ
         YHSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqmBMobkOjrGO9/sDJlqNiVST4wVSc6gg84LxGIc7lnQzIEnmjR0Ewq01Rylcogq/JYI/zquGep2eYcb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/5coLtfktdjZJTqw5GDjYu+uOsriO74ecq09p9d3kyELzstO
	8If6grfBmjlw4Ua5pRJ2i6cjj7+VvFYcAsi4SRW3hDqGMfTcO34jXCiQmMqGK9I4Sa0aZXZsrZU
	U9sVrpuZcBw==
X-Gm-Gg: ASbGncszQKMQ9Wd3u/ji7ZFsKmB9TV91gzYYknV0DrHvu8L4iAH0nf5g4dARBvmFSaa
	qrw4bQNZd2EqRxUb3Et8vREdGup6Dc71DOXXjO0KmHI968QvWfViARZmrXk3zEfXt5Rh47/yYhY
	qYvmesvKdEv93jESiRLc8+QPKio2LflV5DgYqDkUPhzJdFpErkAKpi2d78dqMnfC2gzXFrqfi19
	FpvVkVUUDh2vvYlWoAeZ+lkzkENrzKAoQZ3RxWDxP2fqtOJYw1HJgx+N4kpvGUSCDlzPRbL5/4p
	IsIkIuzq0yH4dfMlP7HMwao2kLNhON+JIRqxKABOdLnQgGx+Kz1YjgMOrrkT6npsfkLgdO8LfF2
	D4+9+pdfxhhC+JvbZ/iS+icMcomlYXYTp70LG
X-Google-Smtp-Source: AGHT+IEsKtdtV82DduOAcaljTZut6VlY7ydXs4awwU1lPkXG313DlNurOaayAP2qYmoOIzVsibXlow==
X-Received: by 2002:a17:906:6a0f:b0:adb:9e8:8f17 with SMTP id a640c23a62f3a-ae3fe82b351mr1662605466b.52.1751989954419;
        Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02a2esm910955666b.119.2025.07.08.08.52.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso7036881a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/ptvaH//ORDn6ooluGNYIJQ/kjVLaBb+a5qVoxiUc/6N7yVRzDLAhrJP7h5OHJHWtHsuse/TZCMk0d0A=@vger.kernel.org
X-Received: by 2002:a05:6402:5191:b0:60b:9f77:e514 with SMTP id
 4fb4d7f45d1cf-60fd6510ce0mr14317873a12.10.1751989953772; Tue, 08 Jul 2025
 08:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708021115.894007410@kernel.org> <20250708021200.058879671@kernel.org>
 <CAHk-=widGT2M=kJJr6TwWsMjfYSghL9k3LgxJvRard0wtiP62A@mail.gmail.com>
 <20250708092351.4548c613@gandalf.local.home> <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
In-Reply-To: <orpxec72lzxzkwhcu3gateqbcw6cdlojxvxmvopa2jxr67d4az@rvgfflvrbzk5>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 8 Jul 2025 08:52:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
X-Gm-Features: Ac12FXyovZoowk3cIPdznURFGER3H1uO2rBwoO22YC_nLxVaqUCimxKTzLI7nYw
Message-ID: <CAHk-=wjOnFbRJ9V81VEeSK+=HuD8ODSq+S3STTh1JwYQLWXXXg@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] unwind_user/sframe: Enable debugging in uaccess regions
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 07:34, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> I had found those debug printks really useful for debugging
> corrupt/missing .sframe data, but yeah, this patch is ridiculously bad.
> Sorry for putting that out into the world ;-)

I suspect that code that is still needs that level of debugging should
just not use the 'unsafe' user access helpers.

They really are meant for "this sequence turns into three CPU
instructions" kind of uses, and the "unsafe" part of the naming was
very much intended to be a "please don't use this unless you are being
very careful and limited" marker.

Now, I do think that the "goto label for exceptions" part of the
unsafe accessors can be very convenient, so maybe we should make
_that_ part of the interface more widely available. IOW, without the
whole user_read_access_begin/user_read_access_end dance?

That model is already used by "__{get,put}_kernel_nofault()", but I
think it's limited to just some unusual code in mm/maccess.c.

             Linus

