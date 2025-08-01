Return-Path: <linux-kernel+bounces-753619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243CB18559
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8681C8314A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7BF28750B;
	Fri,  1 Aug 2025 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMpdt0JO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE072874ED
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754063958; cv=none; b=Kj40ZVAw5YY7gSmyNk/LgB4Tt1WkLFy+RGGle9QoQ32dUjCjT5m2pzXorZhHZx5IKtNQQXZJnvePKHIb6+PJKF7Nc2vdZmhPB+9BiffFw775wEBbO+crjgyzHV4Psn/wXv12Cby+77ER6I3EP0ZjfbNq01BXW2H9sSXeyVvt4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754063958; c=relaxed/simple;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+erfT09DRBN9VL1aHYLjBdu10H2mBvMtFFpS7TCGlXgAashLBT/T7azmh9YNriewQ7iC+8YjCXGQOpE/6dys/XSBZfgPyb6WFihYpMlIvXSxEJu0E4053n+WRRLq+ieJLIHqTSbnIx0n/MZGqN8B3Ok/zl+y7r1apZS857LJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gMpdt0JO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754063955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
	b=gMpdt0JOGbJ6/ljXnWogy388rEGLqcyMV6ulXXDm/b7zBSamJCvQU70NaB3MqK+N9voXw0
	4ciy+PgROB5oXU+HBrriNOHgGX139arxzXLfjYeZSfDaBkHf2vGu/a6DA+TE27rKNzV4hB
	c1NuQ4LK6zH0gXP/T0e8/mPeUHal/ME=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ybQ3Ii_qNC6w0j1w4FB99g-1; Fri, 01 Aug 2025 11:59:14 -0400
X-MC-Unique: ybQ3Ii_qNC6w0j1w4FB99g-1
X-Mimecast-MFC-AGG-ID: ybQ3Ii_qNC6w0j1w4FB99g_1754063952
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-615ad109dadso1528836a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 08:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754063952; x=1754668752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWS+qszPxynxUdX7fOxWHDslTPoHW3w9/GGcefClUyo=;
        b=lwv6JO3L9izQ9hGSplK3ohy0QfQiQaTA1v434yFs9PJP6wolQNY+63C2Vi/MV9MUZG
         YsSdaTnioY0EO2Z8n042vean4vCOcJ4mIKfr4i5o5y7873w9eyR46bpYxNf02q4WAO6k
         hKXm4hbxDvfA1k1POvqjNVRD+/jT8S9XV5iRfcmH1hERXB0gvOGmmR9+/sarok3rasXd
         CfFqxf9y6xHfLlPBFLd0z0rUTi7alurF0v0+v3y0dUX5q2JYGkvEw646iQyt5CcNZ4EG
         Mprldb/qrweCmtqx3/y0lEufatPTcdaGk3hZLKUT1JXi9pS45IFgpazUVUKqzKEOxm1k
         r0tg==
X-Forwarded-Encrypted: i=1; AJvYcCWyfYgONzy6Ijz6tiy5pZ/gCngzErIF0t0Ak/AqHPwvHoKO8YlMHePC5uPMQBUiwPXLDyXz8Y0s0Y55lgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQVtKVrKdxIKT12Y7U7X9cv5JspNoXWf6Mj3h6Wzv96oFj3ZK
	PI/wnPEpcMtsOmeoQ3bVvz2dBB7oXpkO7zEOfKnZqOquNrrJ+mVxsMoukAkpI2zAnO9J3rSJ1RZ
	mWigXUKx9stN4Ed+tQy3nJUHx/WmAb4Cuu/oApBUNL8uQF2o07UnYufiPA2ymNIk7r7vggWlDRl
	v6aEtD2z/5RIiIZQH4w+tLk3dnpive3LO7W+YHdKV/
X-Gm-Gg: ASbGncsdI9m7WhDXJApX4P6yw+tb/44yoKQuXodcMa6wglYjLLqc6wSlcSY8RywqnC2
	ijAJQVoK9CisL9gunWvQZUMrdpbdBawmKQlR55EbCpfOQWMeI3m53V6z6eO/c9hmoN+V9Id4p5K
	ASEPFu5PPj18biiPVXrJtXID4gaTbE40hreB1+hbJv+CTODCHVQ9o=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id a640c23a62f3a-af93ffce9e9mr31675166b.9.1754063952278;
        Fri, 01 Aug 2025 08:59:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gDLgqDRY4tShzR8qch1OHQdTeFZwbZn86L1VGXm8xMl9d9FjpVxU37mgy2WPfkCsyOBoNeq6AkntpSnGTks=
X-Received: by 2002:a17:907:72cd:b0:ae3:eed1:d018 with SMTP id
 a640c23a62f3a-af93ffce9e9mr31673166b.9.1754063951899; Fri, 01 Aug 2025
 08:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801071622.63dc9b78@gandalf.local.home> <CAADnVQLky+R-tfkGaDo-R_-tJ8E3bmWz8Ug7etgTKsCpfXTSKw@mail.gmail.com>
 <20250801110705.373c69b4@gandalf.local.home> <CAADnVQLFLSwrnHKZUtUpwQ1tst71AfYCcbbtK2haxF=R9StpSw@mail.gmail.com>
 <20250801111919.13c0620e@gandalf.local.home> <CAADnVQJnTqXLNT9YWWkpLqjxw7MGMrq_CTT7Dhb__R0uO2-COA@mail.gmail.com>
 <CAP4=nvSNeviiHg89L3dB9pGzi4Obf_s=bWJ8v89Q-fsJbuqymQ@mail.gmail.com> <20250801115649.0b31f582@gandalf.local.home>
In-Reply-To: <20250801115649.0b31f582@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 1 Aug 2025 17:59:00 +0200
X-Gm-Features: Ac12FXwcKBqQk5Q39rPaZjcF8K0IpRgeY7lVuPr9-grtekwZqZCa6oQn2sVe4Us
Message-ID: <CAP4=nvQEtaMY9t81ZzyWFtDzy+jVfQubotW7ypg-Kt9aoA-hbQ@mail.gmail.com>
Subject: Re: [PATCH] btf: Simplify BTF logic with use of __free(btf_put)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 1. 8. 2025 v 17:56 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
>
> But regardless. This will just be a difference of opinion, and I respect
> that Alexei doesn't want to use it in his code.
>

Of course.

I just wanted to point out this is (in my opinion not nearly) as bad
as what C++ is doing.

Tomas


