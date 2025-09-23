Return-Path: <linux-kernel+bounces-828195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C854B9427D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF2445298
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5616208AD;
	Tue, 23 Sep 2025 03:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C74ecbyB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AB2AD25
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758599451; cv=none; b=RruUe8VTCxVsHOFHaBKVpu0J388iMraC9y1SgMoYqNlLYB0cwxhDlUl14Zc5TEm2jq4S+ymuamhTyAVfRZcCP1tlkmmavrAt9SVSecnImCjzFk27eODSSFVndWstGtb4JmGwE6IiXjtpFF9O4FBCrUJtC+fJNnJ1AgrN8aIBDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758599451; c=relaxed/simple;
	bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8Vd8Bgd6Z8Ug7PPsdXoHYB7n0kELEX1wiQ2ARUg5R2OszJCYCUE1XnLrVgNWyzdeKZooxAuSqkNPkV6KApOlOwg9bHxoiXKkk/beZpxPFt9ql8mPxwClEnd+iWJXdzUqwtM+HEjxNL/fnOGJdpGOPJkmegfxfTLEUZ+UTSK/4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C74ecbyB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-363c852d6c3so5693091fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758599447; x=1759204247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
        b=C74ecbyBk52CjvXX7Z8+CsaKJJEX5t1LX6dvZqkAPyap+Srb2QPTQj8kyeakOc/+TQ
         LYnWqLn8MxUVVYmAJWIAiG4YC2GhRvERAOBUUUj0QpEBg2B8Tj4a44iUsxTNLy2Au9wK
         /VVUL8v8HYSK9Z63ocNqLIcL02sCqEcysl1ct+PPfeM8PC1ifHUQ49Kiqnecde+qXGL1
         goZ5MVlM65E8IufXVJbNJI/7TPnsG/61UWooXcraxtc9CFX4+fC/htUYroT5dWT75x1T
         tnPFImbGZZxAH3QBbAFbQgoRZE4bnM4TF9nHvmXHi5WyeoUus0t4agzGK416/tScsN6I
         3orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758599447; x=1759204247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9rIm2Qr+sxmWg43C3LjSRMHytvWzDOz0PNv61PwIN0=;
        b=umfRZLGu36DnMn9WvopliLtBg8IDLWazoXCZGXBbVlHn/5/x38FiEsPYT5y8Qk6zqR
         vuIahxc1NrSbKFsDbPjKMYgfB1Sb+/EZBwi5WJLuUbtY42wWlHRiTw3z9oAqq2tOryGI
         Va8Qfkx/A+mTmXvRTMLGBA2XVB6nZspU4kvZpdQmZ2htiRq73KcZgOHwvKBjkzNtO4uo
         CKtSVqmN/hjuKo6y6xgQKivFP02DWn4DuVENiGqaetaSxvbVqvw5nBha/sEm17IjdGZQ
         KYmXgobkMZgcXzqzHIeMFLJrxQWnajDbtVTmv7X5gMC3DZz9ela5wsGo40uVCeQvP9QN
         Im2g==
X-Forwarded-Encrypted: i=1; AJvYcCX0T1TBtcNvdiWpVG0y91ieSgtCH4bSvDYiAM3vJBxxAWaFOV+hA6iDP9VrsNdiFVAr8bLvedoehPtPHic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4y9fzvQE4GCCRXM3XQQmtziYFoNX45muJoMOw1RLJMTh91+Iq
	OSWe9kD8DhXHxAc1ccGgD/Hxva4cIUsUUaWngBhsMc28JTDGnNBDuWw0noMYPjvutIdCpEsc3k2
	RzNFjysR0sJioiJeAuuYEMt9P3VrNrCY=
X-Gm-Gg: ASbGncvorhdyJVzAzpVGUXBmUoV4Um59dqGXN+mU6g3bteOnguymYKmd9U2My9KLERC
	Md8TnXZHoM1xHnj3NQ49tJoGVBQkkviPeeygYiaOILUzjTJUtAXp9UBkXMGcyzT3ay7ZBOdTtVv
	kis7/Sw3JmgZ4/qTb3hheJf7cOgSTWdaKRMtbEDTTV7BA9Tk5d0jt55gc3lTfVAYi4HCa7oZcJu
	Fon8Xj8
X-Google-Smtp-Source: AGHT+IFPR/ojxUbcunSqFj95BptI/0qdsAjMPxxte1rg/TtRftlIXBiGgzI+t0qpAtOcsZydxPV/Sc/0QBJ8p57foMo=
X-Received: by 2002:a2e:a587:0:b0:338:1a1f:1152 with SMTP id
 38308e7fff4ca-36d176d9e37mr1511201fa.8.1758599447268; Mon, 22 Sep 2025
 20:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com> <aNGQ66CD9F82BFP-@infradead.org>
In-Reply-To: <aNGQ66CD9F82BFP-@infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 23 Sep 2025 11:50:35 +0800
X-Gm-Features: AS18NWDFEH5uLKDpswEZriajtkKtRdC-YZKxVLp-mDKwLqx69RhYurkjBEuTo54
Message-ID: <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop driver
To: Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, linux-mm@kvack.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 2:09=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 22, 2025 at 11:29:15AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > For now, my android system with per pid memcgv2 setup are suffering
> > high block_rq_issue to block_rq_complete latency which is actually
> > introduced by schedule latency of too many kworker threads. By further
> > investigation, we found that the EAS scheduler which will pack small
> > load tasks into one CPU core will make this scenario worse. This commit
> > would like to introduce a way of synchronized read to be helpful on
> > this scenario. The I2C of loop device's request reduced from 14ms to
> > 2.1ms under fio test.
>
> So fix the scheduler, or create less helper threads, but this work
> around really look like fixing the symptoms instead of even trying
> to aim for the root cause.
Yes, we have tried to solve this case from the above perspective. As
to the scheduler, packing small tasks to one core(Big core in ARM)
instead of spreading them is desired for power-saving reasons. To the
number of kworker threads, it is upon current design which will create
new work for each blkcg. According to ANDROID's current approach, each
PID takes one cgroup and correspondingly a kworker thread which
actually induces this scenario.
>

