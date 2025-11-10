Return-Path: <linux-kernel+bounces-893101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDB3C468EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECE33BFB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED253311C3B;
	Mon, 10 Nov 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3IIs3is";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="owdrLyiz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422E930F7F2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776689; cv=none; b=Z43OVbQc/5soN2ezQwc2oFhgoTsc2BP3LqpCIKLmmKOB8/Jm23bpnA6fSehodzUsqJn24Dq9TvbCWYTYJny3LDDKFN4Udr+X5pzvYB+9CDUd2vl1x043BiZndyFB3s/TlOrNnZN/Z/BYVrKViSDXBmJekdMfDB0Huqww2P//r6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776689; c=relaxed/simple;
	bh=/tSpx15UsSyaiP+LSGuC/N/Kf99NYcuCuOorK8fkvcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oS8Fc9bh2MYpXNmAeEBswoBtAeij/6VoSVlSqvGdHN+43C7daNo+CJhixeYkQGpKU/WiMGg80XhdqgaqqteWsh19+jnRt5YrFNSA/lLhcvUgrN+So6IvbJ1UNg0taWqTU5Knz2w5bO6jeFZuOBP4dviaxqzkLeUD24k6zpl/2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3IIs3is; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=owdrLyiz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762776686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LTBjYBydZ0P2EgaHuZsKfPgw1EdAQeW/BWVTSClYnYs=;
	b=D3IIs3isrQTg1Ri6ApV3PBz0sVGiKmdf70krNhI8CY3jjrufR/AkYb6rLYu6aJ5UlwUcX+
	LVE3RuAi/qiJSHITBtFekUcVzhCWLg/OCY0co13srfJUNQoqJglvRZN1Ys7qnOHe6IiNYw
	98aRbPL/mUbuyJh/+8jHfo6qS/qt+Y4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-qBVGc_4ZNPugZl9gF53gtQ-1; Mon, 10 Nov 2025 07:11:24 -0500
X-MC-Unique: qBVGc_4ZNPugZl9gF53gtQ-1
X-Mimecast-MFC-AGG-ID: qBVGc_4ZNPugZl9gF53gtQ_1762776683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b72ad85ee9aso344073366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762776683; x=1763381483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTBjYBydZ0P2EgaHuZsKfPgw1EdAQeW/BWVTSClYnYs=;
        b=owdrLyizkb9o7IosKeotHx6wDjT9uVK3manQBVDOhXdKjDH8+90Hgq2mqAJAILdRB7
         HMqo3ZXU4L0JqJCX+c6KOg32c1vKwovXKyIDP8Pv3jDy6kaf8NcZb7XP+44JnVy6DfV+
         rTFBrGIW6YGgIII9Wd84Bn3F07728qsis5zovBVhG0dm7zm7N25s3iKhomSXW9SYkGJ2
         7wM6eG27HyG7H5vZIOCWRGvBzAsLCszHmjQcg+jNtDFPOAXm81Jimq1r6pVns+EEmA5Z
         1qdKiJNRCs+FyBXVjYXMi3357SvAw0EgJSAsTmQ5uiLKbzyk8AQ10mtrMWlqppRGmJx4
         VFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776683; x=1763381483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LTBjYBydZ0P2EgaHuZsKfPgw1EdAQeW/BWVTSClYnYs=;
        b=NndcTtQBhgb/6PyY97MmoSt3jw1RUyjJf3NyxDLibKRP5m9KHABJhKLYbXUzoksL6x
         BLCcp3pKv1TpccTqBzVnDItkyaKI79QziNh3wXPjhIxWEHcgrJW4WVOTIKaKpdsKSGQ/
         22+SrFt1oW8uS3JMagCzD89QYP0qgjNCzuaQ/B2R1ncwpt6abFclXyPWgJvm24UcRSbr
         JlQNggLKgcYj96vBP8GVIyPsMM313V8vTtsq8WNrY4qfmvht7uSAdF+Q0RMUHgivCf9b
         aoULKFCi09lARzDkwM3ji+E/vnGxmYL1yQO5AoPoIKQsQGVOtSp4LfC0FdqNrGdxBvzO
         LZVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMbH8fu+L9h/nd4yY7PtRMDkzIYgl+HriptoOXyHktjor+sf8jAo3z6INd/hil33+GEZ0fEREJJgfCzpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykUt0sEkZuGJGKwGgl7m8wNKui3bWHm0kEioFIv8wbQB5wZnPM
	KXhWbA7cRQAkNks3chiPirci9LGURUE8zNXagmWZLQ7llUIxrHKA3p2+KYfVt28+ujS06RSMKBu
	dgXZiyFQ1q7SjdAzZRXIUY5wu8f1CgwMXnpeE2qV6em1aYNoShspOnCc6PZOw9Ys1cQYrE1P9jd
	dh8Sr2yulgLaQVcaKaV1bdar1jS3kNbRNa+C3ocFzy
X-Gm-Gg: ASbGncs7quednziE28fKLB+2YRNiOi0AQWDzRcXiDve0VgNMC92UnrtAz5GVwGBH4x+
	6pMtOxPQBNBjUlUy16GrNSW5ssL7xzDBSaS/8KQO7mkTQuu2YWzdAKlU2EONvlh8W+9IlI/G4yC
	k87Qe7or6ajXQgVgiU+GpU5koA1B7r0vWRVs1NZwguHbCv2x7ARsQvzNi5OQZ3/aS/AjV2msxMJ
	sXoMl3Ic4tO4cHc
X-Received: by 2002:a17:907:849:b0:b72:7eb6:c5c with SMTP id a640c23a62f3a-b72e033386amr694393866b.19.1762776683483;
        Mon, 10 Nov 2025 04:11:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENfZNQDOO48M2cfsnX0tl3fK+b/EphUyt313f3RyAn0vffBWZLIhi6bnnSjKc2DN5qCQgc2CT4OdZ/hH8ioyg=
X-Received: by 2002:a17:907:849:b0:b72:7eb6:c5c with SMTP id
 a640c23a62f3a-b72e033386amr694391466b.19.1762776683147; Mon, 10 Nov 2025
 04:11:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031123328.1758743-1-rrobaina@redhat.com> <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
In-Reply-To: <54043277138c6499c0ced9bbdcae7cf5@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Mon, 10 Nov 2025 09:11:11 -0300
X-Gm-Features: AWmQ_bnbNfdhYfS3cRBtkLmIap5Ox1jnANfIeomSLr8LzEVBWB8HsX9Se5Vg5co
Message-ID: <CAABTaaA9qy8P-LLuT8mfv5a8Sc_g2MJcjRDcFMET0dwGwRoj1g@mail.gmail.com>
Subject: Re: [PATCH v3] audit: merge loops in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Paul!

On Fri, Nov 7, 2025 at 6:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Oct 31, 2025 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > Whenever there's audit context, __audit_inode_child() gets called
> > numerous times, which can lead to high latency in scenarios that
> > create too many sysfs/debugfs entries at once, for instance, upon
> > device_add_disk() invocation.
> >
> >    # uname -r
> >    6.18.0-rc2+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m46.676s
> >    user 0m0.000s
> >    sys 0m46.405s
> >
> >    # perf record -a insmod loop max_loop=3D1000
> >    # perf report --stdio |grep __audit_inode_child
> >    32.73%  insmod [kernel.kallsyms] [k] __audit_inode_child
> >
> > __audit_inode_child() searches for both the parent and the child
> > in two different loops that iterate over the same list. This
> > process can be optimized by merging these into a single loop,
> > without changing the function behavior or affecting the code's
> > readability.
> >
> > This patch merges the two loops that walk through the list
> > context->names_list into a single loop. This optimization resulted
> > in around 51% performance enhancement for the benchmark.
> >
> >    # uname -r
> >    6.18.0-rc2-enhancedv3+
> >
> >    # auditctl -a always,exit -F path=3D/tmp -k foo
> >    # time insmod loop max_loop=3D1000
> >    real 0m22.899s
> >    user 0m0.001s
> >    sys 0m22.652s
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  kernel/auditsc.c | 43 +++++++++++++++++++------------------------
> >  1 file changed, 19 insertions(+), 24 deletions(-)
>
> Looks good to me, merged into audit/dev, thanks!
>
> --
> paul-moore.com
>


