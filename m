Return-Path: <linux-kernel+bounces-755022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38CB1A023
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2211B3A5E8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9049A23D294;
	Mon,  4 Aug 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsZz9DDL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619A4D8D1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305485; cv=none; b=CcHl/9t5NXBQUdXOCxhCjxxZ5NN7cMBg11Shftxe4pKH6jUL28VvGB++5NV0UBSFV6cHMxVb41xjvTgeI/HCCfIg7NTNCWOqEiDUS5e//kYBFqXXWDQMnGrv57VTdrV4FSTFwgQ4WbtrgGBz7Z+nktVM5cWq0ojUv4dPvB1Umk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305485; c=relaxed/simple;
	bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTWMk5Kecf3OERjPmksEsaDzDC9eGJErBrU0S7yaIzEgzBLquVnj0wGP4PJJVDn0qOLoKVz5JAztraQQS5S2dileivnishg2dvxE2wbvWTCIV6rqqZXYRiHAwhaWyq9GdB1fa4PjIPSwkUneV0A/FsBHreQyZBh+e/Ly0fRrPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsZz9DDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754305481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
	b=IsZz9DDLXhhYPGfoWugt9jUcQrpAj04rrub0D7xCvJ+3piZESrvVv3dMKOSJnwxNh8NG8L
	FkK5yv5RqSjrZ+VsjrfexHjtYsquoFQD383x9EGKcNNtAQKcJ3K/hp7yNKFHmXrtf94M50
	ehrgYJCMyWmnP0XQwTcAjSXPV7BFgf4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-PhUa8VG-PoKBb84AtEkBMQ-1; Mon, 04 Aug 2025 07:04:40 -0400
X-MC-Unique: PhUa8VG-PoKBb84AtEkBMQ-1
X-Mimecast-MFC-AGG-ID: PhUa8VG-PoKBb84AtEkBMQ_1754305479
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af91ca00e41so289983566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305478; x=1754910278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlMaGkAWIp33XVD6gYnhzdujTiQCBHSv7RY66Elv5fs=;
        b=k8Cn28ZEBe1wTP4Qp6r8Aw5sch11qoEHelhIlgHU5QJHtDwWI3+J08s1Y5K3L7aAPp
         Eohz49oM0G64cYKg7oGP+58p2jasPUbcYMImvHTDE5Rt0w9/qy4Xa536aTfoVc24w2Nd
         WI3oKQcm8oAT/habo1gWTvS0KifIVLOf6AfLQQ6xyfua7XrDKoCmcnebKPQnGBlM4Wvo
         +pOxLQ7KjVl79MLS8ezTdUYdXdwZEZzrPVyE/weHZhrv+c+NyGZ/AMA6J94DMg2WmCER
         8NGGIqXJ88ILJI7GHPCnGkXbiTT+jnrGXcdb53dYq1Aqj96omGI/olkmjEHgC3xHKr3o
         Vjgg==
X-Forwarded-Encrypted: i=1; AJvYcCU42ls0c8p+MWw5yGBM87ex+B4vrt5oLJR+J6n0ixNFnTPQmDKzWm9MV3XRvjLli5ksKFl1964oV/0MO14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6tYPFzY4Cs3Ob2+AThoT7fFTTRkv0K65+0JQfqGoll9VOCGH
	DvoERPefVGTrt5IeYfJXNVcNnMy6IaszoijT4n/5HqvuRdz5+0qIASR51hTuSdV+w4eUL25wZWu
	AFsV7Bf16PrpU5YzlsdWJMSk4wDYEWLYxxrRcdvR8Ud75ejEwypd5HxRb1KkqQcZ48gutEfvYmr
	+cSlz8vzpD3uI9ZM5QfOiZY/1ymAr/b92j7XJiumUyf0epYObCCoU=
X-Gm-Gg: ASbGncs2Isi8qdOADNSDtuZ+aVAJpXlA5rXML/lgGNWIobFtvrmKFP8DR6cdGHAXrol
	bbeyNxGVa9hmGtU/myLLnXKGQPth5ksDgkOJDCLE7sfC47aULJgrokD08xNIQRdjNFYTru3nXo9
	MDXETtUscpwO2xCGLJ1k/5DxJuoKmUkJPVCDZmpG9Awh8Oz6YNvAE=
X-Received: by 2002:a17:907:6e8f:b0:ae3:bb0a:1ccd with SMTP id a640c23a62f3a-af94006657emr999149866b.26.1754305478465;
        Mon, 04 Aug 2025 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYv6saSy1ylfhTj/Jz/JQpBZyAQZBk9EeSPyhAKJXHG+//8QADIyR4pm7NN5d3EM6/5VqHVVyekcVuIXPvf/Q=
X-Received: by 2002:a17:907:6e8f:b0:ae3:bb0a:1ccd with SMTP id
 a640c23a62f3a-af94006657emr999146466b.26.1754305477941; Mon, 04 Aug 2025
 04:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611135644.219127-1-tglozar@redhat.com> <20250611135644.219127-3-tglozar@redhat.com>
 <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
In-Reply-To: <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 4 Aug 2025 13:04:27 +0200
X-Gm-Features: Ac12FXxijqs_f0jwCTFb5h27rcz3weL_6C4DRAy_TX7Ih5MQ7W204gk5XYVwzPE
Message-ID: <CAP4=nvQ6mcka9GAKOYY=M3LWo7qGoXy7GuMB8c2M92si+yMFcw@mail.gmail.com>
Subject: Re: [PATCH 2/8] rtla/timerlat: Add action on threshold feature
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ne 3. 8. 2025 v 13:08 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> The term "threshold" is ambiguous. The use of the term is inconsistent
> across the tools. In osnoise top and hist, it means "the minimum delta
> to be considered noise," which conflicts with the semantics of the
> `--on-threshold <action>` option. To avoid confusion, I propose
> introducing "low" and "high" thresholds and updating the sources and
> documentation accordingly.
>

There is already existing naming for that: "minimum delta to be
considered noise" is called "sample threshold" while the timerlat one
is called "stop tracing threshold" (well, the source simply calls the
latter "stop tracing" or "stop"); timerlat also has another threshold,
the stack threshold (specified with -s).

The patchset (well, the v2 of it) has been already merged upstream, so
I'd prefer keeping the naming for rtla-timerlat, and if this is
implemented in rtla-osnoise in the future, a different name can be
used (--on-stop/--on-stop-threshold maybe?). The documentation clearly
says the threshold is the one specified by either -i or -T [1]. What
do you think?

Tomas

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/tools/rtla/common_timerlat_options.rst#n62


