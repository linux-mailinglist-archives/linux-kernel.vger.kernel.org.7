Return-Path: <linux-kernel+bounces-794766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DEAB3E6F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8B517F01C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8631DDAE;
	Mon,  1 Sep 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Taf3q1Md"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E247C2EDD76
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736654; cv=none; b=H/lkCBxqBnkwmvZin580pyldQDDChfwKk4Wcax6Oyczf5l5BbXiG7OvTYkAbUN+x5SjR+TYYhnMZmanqoD8I3mg1oGJ9xevMg5dpw/s0ZoN6x36bQheiZiOB2poB0oG80tVa1/ED+gRrZampYyYNvi1gGgLOzYDBZ4Q4SBimRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736654; c=relaxed/simple;
	bh=qAAqpIJ1sZ+WXhv9jSL+yNgDxW9OQV2lwq5CpKUVeRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4kufR3z3cPP/TaFkcJQzMC2ALSRiHz1Palyfir9lNkJcsJujcDd7+CL18GeMXtHrIy8W7IMdV5XdLK6NftLrCflUQ++g7JfCPUDJIr45oG8x5I8XWN8iz9Q+GErgeiolg5ti06rkXGOy6NLeh/2AB/N53Rs6oEEzf31PLQ5kiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Taf3q1Md; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756736651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIgXc9xeVr9BBWUbZa2zZn7PQsTxZuClMXuY+mTcrPY=;
	b=Taf3q1Md13l9t/XFe03udI8KY30l3Kx+jd8BC8QX6jrdyLhIvBw7lZFDcYmgnov5RbWQ0x
	fLjEcIlxIdFypVI+mGFtgh0LSJa65RfzLSA4ZpSv8X1eiDNz1myl4F3gzGiwl0AyMq5kGG
	1f0EwqzdlO50y876YlgSg4SG92ShRIM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-GhcSiRnuP7yhq_GsFyjMhA-1; Mon, 01 Sep 2025 10:24:10 -0400
X-MC-Unique: GhcSiRnuP7yhq_GsFyjMhA-1
X-Mimecast-MFC-AGG-ID: GhcSiRnuP7yhq_GsFyjMhA_1756736650
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe81959c3cso393823166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736650; x=1757341450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIgXc9xeVr9BBWUbZa2zZn7PQsTxZuClMXuY+mTcrPY=;
        b=m665BWPN9F/TcpuaYrtVTGx/VeKrs0b4toNVr7hOAVOaj35ue84UYyr4dAxty97uwL
         DfpLx5iHhwOr8WnvcsXXa5NafAzpf/ewEL7jo2JlzytICXJ+n9GFYjnC5XvjbCxunZ9K
         2TSpj91Nz+AQD4CkfJsdCdhj7G7pkxJkBzyPe9GbxiISzwVDMYet4BINZubrk7R09ptt
         vP5ybf47KrCFPHwD7vHvTPSOwTJI9nhjmlKTrJjaih5ZkJKBkUCFUJcSEgXELYVQUXMU
         8KXs0gse1C7JsnrBVuA77P2Tw4k0QWDs4ruAi7zj5p/m87vYQ6Ibnw7j+QNTpFl4DNzI
         FIKg==
X-Forwarded-Encrypted: i=1; AJvYcCW+1gimK4La9HGf9WHVtTRCRJ5AiU4EG9iLlr7R6dAbaAON/juYF59qPhLVAWmaqwhTwj7x7aovLP5fRxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeR5s+xRCsL96y79H1pzrawvqDGq9SuHSYk72mOLanoLUjJxI3
	yQTbKpzVpMAm8H4nmC8FMJohrodyAvQaqHDfm0fO8CGoNHhaE74QteV9aIMEi5Gmvixi5lN1ezy
	TjbgCfi/cD3tBli6wDy4UmSdBHHPBQjFtL/wygOooPtFLZzhkz8yRBLnGITRepT3qXxm6jOY3TG
	lCdCozIOXmDx1Lgc/LL/cKpfaIuAIkoTjorV2rGYwk
X-Gm-Gg: ASbGncu85QVEmnUvMhkguSxtXyUDoqw7tPgti+K5YdRLtCca2z3MWJLvaeG0GdRkb5b
	snR6mNPAwLQRTJTQkSbvCVA0dmafxBacGBwPzGP70n37Cw8vx2yKTwtb5RJDcjh8YTET3s4bZPg
	mOth44c0pwtwUqdMOjlCRurjlp4qOOw2SiIoSiwIrV9sEbFJGBRrA=
X-Received: by 2002:a17:907:94c8:b0:aff:7:4f12 with SMTP id a640c23a62f3a-b01d8a2778dmr739983466b.5.1756736649578;
        Mon, 01 Sep 2025 07:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn4xY0HH8qCdFSyK5OTzgVVXjJ12ZvaUYluQIqf0B2o60S1nht1dzIxUJp1Vzx3IwFYsWYnxkzkFbv5Vovccg=
X-Received: by 2002:a17:907:94c8:b0:aff:7:4f12 with SMTP id
 a640c23a62f3a-b01d8a2778dmr739980466b.5.1756736649117; Mon, 01 Sep 2025
 07:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755018581.git.ipravdin.official@gmail.com> <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
In-Reply-To: <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 1 Sep 2025 16:23:55 +0200
X-Gm-Features: Ac12FXx63Tybu7ddN4dNpy-VZp0KptTHLkvU7Nm5KFnqWm7q4-qPMwNWVhWSlzk
Message-ID: <CAP4=nvRZ_SY_xdC6N8LkKUA=a-QP5gc5SMgBr4jod6+tu0TFeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rtla: fix -a overriding -t argument
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 8. 2025 v 19:22 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> When running rtla as
>
>     `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`
>
> -a options override trace output filename specified by -t option.
> Running the command above will create <timerlat|osnoise>_trace.txt file
> instead of custom_file.txt. Fix this by making sure that -a option does
> not override trace output filename even if it's passed after trace
> output filename is specified.
>

Yes, this should not be overridden, it's a bug in both the old
implementation and the new one using actions. Thank you for the fix.

> Remove clear_terminal in timerlat top as it removes "Saving trace to <fil=
ename>"
> line from the terminal and is not used in other modes.
>

This is not the correct fix for the issue. clear_terminal is needed in
timerlat top (and osnoise top) to clear the terminal before the
updated status is printed, the fix removes it without a replacement,
breaking this behavior. Also, this is a different issue that appeared
only when the actions patchset [1] was merged, and should go into a
separate patch with a different Fixes tag.

[1] https://lore.kernel.org/linux-trace-kernel/20250626123405.1496931-1-tgl=
ozar@redhat.com/T/#t

Tomas


