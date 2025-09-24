Return-Path: <linux-kernel+bounces-830205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7FB990D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9699918982D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0A287258;
	Wed, 24 Sep 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI7/qzD/"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D992D5926
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705221; cv=none; b=I8u8XBDiPc7vFnceCh/s0YXoT3GU/aackTnBug/2bTuDgzkm38QojjLjmGrhz5yP8Zlysq/DIVDgFJbqPo6g5R3hMi5/OdFyYg7SRSO6clOx3cPXpaDmLbHONEhzYGE6RtNQn9qgennVXKfpW2iAFWExDpYrjvfTyqbNBCFEWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705221; c=relaxed/simple;
	bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O64Lus3Qflr2pQeJIFnKDtx+THZJBwoP9gkZqmXBhG/VbqZgcAUSXiZ9DSUsZnqlfjpCj6aceq/7zxmVkRik6KdaZANcroouUrOuC+EJCXdSTiajNtjckizgDsrGKW0TaIDRLMWhGKvUoO6poNvIpFNDIG867oYtX4rauUg0ERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BI7/qzD/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57e7aae5af9so538341e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758705217; x=1759310017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
        b=BI7/qzD/A89JjyNVqj6KS9aMFeToLqqSQ2ht6XbUIiIwvTbJp01H74rteHxlWqfBQY
         0Ajr1xWyC8r6zdx8MGd93IefYjXWvzRCVBxYUfqs3uVqh1F258MYyXPKAHRMAWywDFPY
         7b5t5tFmSM4+RUwdwOk+a9al9LBi/TlvZSltN1cJb5Fh9UsvL5ML9iCt9/LH2JQLjuOH
         6JKsZ4o5oD8aJcgrj8vmgOMyM96kPnW8PKoPwXYtMKoMb//Zk124IBfhWzp/c2DgLhL9
         8yFfM2vlU0ZPN6gIAzyKqLYUzKB2HkvdmM4kVwuowQJ/brAoI84febJEwCW2XfVYQa8W
         NWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705217; x=1759310017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af4Ct/KfBWF7p2rMZKnvJgS35hmQrVUjUNoUpz5WfU8=;
        b=sNMZRZuZDypIb492rmlHriN9gZdjbpVqRuI1GaDs83eA6MbgaNBXmpWmf4UohURDmD
         /cFxAYkuAz8CjcOOqptCJZOlX36v+eonhUmlN+aY2HBM9dcisDD1SPcgBcoxRyYM7Yfy
         jHOQivx1Gkshjkwg/MHju4iPZsNWCZTDtRQSn1nqCdkSeDR/PX5StbSUMx5EByAMemX6
         l4QwkKwCw3fr/mmPos2Or1NlUNxf6h/OCWMMTbyW4gcqK6HDaHk8Nkdm+fUOTNYb0nNW
         BkxLLLeYe6DbdezyOJVm3KYps1J9OLUx3O6BqGq2mZxkkgblsBjGXN33MTs0f7TV7Yvt
         1uiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnIp5xz/kS0hCpyyWJWsxaq39+AhuyvsbDn4dqVacw43Z/DyrUPPRk6j9gYbjf2ruzxqKPIdSVhOjCiFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8jFgmfWsgt2N1gC1ZsKqhY3GPBBHCYAHemtIWUyak96nmLZB
	OWEPtSBhxEDV7/nOfyviCHf15B2XWxWXkJ2sJA/KyfQUOVmENPJR6BxlQzTzQB4cn39siRgBI9K
	eV7VzZGXEQFbfG32znVuLtADdqsJCUo0=
X-Gm-Gg: ASbGncubBGcu7y5u59LIGAnPSkHIyO6H02xH/oOgz3ZFiH15FguypIBBjTqmnoDT74+
	h91TfhwboOvZsHXRAtS+tebCug6NpcRHjlqPfe0yaFYXsPwJUnjau8TucWxUy7YcLSpw452BGQ0
	AhxF/5WCKNe1bk+38QlXhpngAjSNY1TOQQmiMD+5RpCU1Vx3G6xNPvIyakxC1BRdlAOZ82DP00i
	fadE6ry
X-Google-Smtp-Source: AGHT+IGs8N2Za5uD7V8CJlL7/UBfxVMm9tPDgKV7PBembRGnfUF9U37ImFXt0pqlo73lGmzPgv3o+6kGEtm+zgslSZg=
X-Received: by 2002:a05:651c:2205:b0:361:774b:8b2e with SMTP id
 38308e7fff4ca-36d121ba628mr9245421fa.0.1758705217099; Wed, 24 Sep 2025
 02:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org> <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
 <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org>
In-Reply-To: <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 24 Sep 2025 17:13:24 +0800
X-Gm-Features: AS18NWDh4YoKVvwiPJPTuArIa4_L6TIXxcKByByVO2my4d-ujrstbeY6JtaK-p0
Message-ID: <CAGWkznGv3jwTLW2nkBds9NrUeNQ1GHK=2kijDotH=DN762PyEQ@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Bart Van Assche <bvanassche@acm.org>, Suren Baghdasaryan <surenb@google.com>, Todd Kjos <tkjos@android.com>
Cc: Christoph Hellwig <hch@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

loop google kernel team. When active_depth of the cgroupv2 is set to
3, the loop device's request I2C will be affected by schedule latency
which is introduced by huge numbers of kworker thread corresponding to
blkcg for each. What's your opinion on this RFC patch?

On Wed, Sep 24, 2025 at 12:30=E2=80=AFAM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> > Yes, we have tried to solve this case from the above perspective. As
> > to the scheduler, packing small tasks to one core(Big core in ARM)
> > instead of spreading them is desired for power-saving reasons. To the
> > number of kworker threads, it is upon current design which will create
> > new work for each blkcg. According to ANDROID's current approach, each
> > PID takes one cgroup and correspondingly a kworker thread which
> > actually induces this scenario.
>
> More cgroups means more overhead from cgroup-internal tasks, e.g.
> accumulating statistics. How about requesting to the Android core team
> to review the approach of associating one cgroup with each PID? I'm
> wondering whether the approach of one cgroup per aggregate profile
> (SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.
>
> Thanks,
>
> Bart.

