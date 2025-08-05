Return-Path: <linux-kernel+bounces-756750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D52B1B8CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11E787ABF85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061C292B40;
	Tue,  5 Aug 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnPgiMYX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63B21A928
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412597; cv=none; b=Lf4Z/CcrU5REvubeZ0QayeRU3WmOuwse+nBDmQfKsWokxUMOrAntcaeZ8ZnzMZgPVHFUN6NRcpUo2QMmMVkN1iE9SNS2ytU87K56hMLzXQhm66hxfINfYcylB3kJi1oapZ4WcBByah46CYmDPLtWopA3yOdevacrk0T4rbgVmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412597; c=relaxed/simple;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMqwiO0Vs4B86avcN5Wz7kVWSf3ez9/N2lt3c7NTSXwMYPXD+EMVgXZNc2sXeJ5+b1zYpynDNy98gvhuKAPj4GnAW4TYVRVK3js8wAqgpqHONsxohv/cZWxDWbJ0mBPe8UCqQsfnTqPPZLfmeMcKrETI+yBC0R+4X1KNrTUdRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnPgiMYX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754412595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
	b=GnPgiMYXqspWqdZ0rDy5VM2hJQVR23jFxKVgxiplHEkFeYWmsObra+mchNajB2gghWUsIg
	h1FYg21jNAB2Qj7opQd4IUlbLdJTaDe9lEfW+LRlE4dZ3s52AtXg+ShAdJwGub7CGMKFo6
	Xk6XFEGlhYA6gRf/xwQaQE3B2WlVS2g=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-CZOpRwqoPo2qB8RNLWwmsA-1; Tue, 05 Aug 2025 12:49:54 -0400
X-MC-Unique: CZOpRwqoPo2qB8RNLWwmsA-1
X-Mimecast-MFC-AGG-ID: CZOpRwqoPo2qB8RNLWwmsA_1754412593
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3e51497be0fso7475365ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754412593; x=1755017393;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+M4Y/o1H8Mcv1YNx9VuHR1Yf1uCiW690U8nQKGjsgM=;
        b=ny5oeXRsVM+bj4AvZ2AtkaggiQwtRpsn5EU8FmDg+YmkMkeJgUYEfrsM2d+42Ft8IG
         kqcyXKLU+zyT7CIRNnMauSjg87lvTl1QLXTqdOFZGIhxR3fuHCjmx6Qvc2AixBsf/+3p
         V0rd9cUrJ37355r2JoPZwlHYKVjvKxHJpET7Mc7I9/UjfBz/DHGAHx3lXupmX+NAj2dh
         cYLVxGTeDgIyrzXGyutWTHwideyjISjZr+Uv6PaPmhwqOjutCOrCqCD63j3q7+VY3vTM
         7eQxZh6BArMqt1GAZ5ckOtK5JF6vAvgR8HhuirEsSdp46pHqrT0sAgOGeES8LQbw1D4D
         R4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX+3ncof8JczD5Z9H7Px4H92mO6YZBMhPDMFvNEkX5HfkyDB6i32GYE3Ij7/vs6Jmm9/dMpkMFiftc59Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvP1BffSny0S5R0jllJb/3+M+QRFIBVp9vQuQq3vrsAZTimN8
	HErx5m1J6dh1oy+6RSSUjwUJyxNKRDr0AuGgUktBHIXww2k2rexuynJ3XYAwP6xFjHNYEXjLvm6
	4xfxIrGANskBOYcIbJEdS2pkqjGctpqk6lUXJEvw/tg8luRKfLU8T91QW8q0DbL1Eqw==
X-Gm-Gg: ASbGnctAXqP0WA5LJOZuPhhb1mv94IuEM+Wil3mcr4foxwpUahc4Tmw4lNU8tCBqMdb
	kFWN0s9TqRVWhxpSaIo1P/MStw8Dj1KsWKcV2xaYPCSaaIjJyn+/4MHEAmjLMEY/BBifFykFMbr
	DTgCr15Tn0Q0ZvjFYgoZOgGnGVFsZ5aVMmD56t4cMvO8zrSYgR4Mac4SSdYk2a+dIQSfl5EIJq3
	AuJ8MW5MnjC3ey6q2RdmvZgLfEoe8rrUNPN7TFY9lJkdWxeagdA8gTZJwMcNLB84E1CL1e/3+K8
	iSH8QIoqM7x1awYL8JGh38sNgx1s56JB8HuPfqsOi+g6n8rqWS2loow6e8hTtXABABQVP1M=
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293423265ab.7.1754412593019;
        Tue, 05 Aug 2025 09:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkPZOoL5lfzhmEQ9P7S/kqjcyKFzOgHwdkMcJAPTqhlbXfksERnKXCLEw+tCLYbmu/SFyNjw==
X-Received: by 2002:a05:6e02:b:b0:3e2:aafc:a7f with SMTP id e9e14a558f8ab-3e416122d83mr293422335ab.7.1754412592444;
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55d5da1csm4057918173.65.2025.08.05.09.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:49:52 -0700 (PDT)
Message-ID: <540bd149b88a543e306762fbf00c366a4f9670ce.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
  John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan
 Carpenter <dan.carpenter@linaro.org>,  Jan Stancek <jstancek@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Tue, 05 Aug 2025 11:49:50 -0500
In-Reply-To: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
	 <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
	 <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-05 at 10:03 +0300, Costa Shulyupin wrote:
> On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> > If you want, I could rebase that on this and use container_of() to for =
tool-
> > specific params... but then that adds complexity with the top and hist-
> > specific params, most of which are common between timerlat and osnoise
> > (and not merged by this patch).
> I=E2=80=99d appreciate it if you could rebase your patchset on top of thi=
s one.

OK.

> This patch is just the first; I=E2=80=99ve intentionally kept it minimal =
to
> ease integration.
> My goal is to refactor rtla and submit a series of follow-up patches
> to reduce code duplication.

I have consolidation patches that are just about ready to submit; I'll
try to get them polished and pushed soon.

> So we might want to just keep it simple with one big struct.
> This is a god object anti-pattern.

I know, but I was trying to weigh that against pragmatism and churn
reduction, at least for an initial refactoring -- particularly given
that my motivation was to make it easier to make a timerlat-specific
feature work on osnoise as well.

-Crystal


