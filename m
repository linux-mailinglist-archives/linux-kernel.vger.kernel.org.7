Return-Path: <linux-kernel+bounces-738994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336F9B0C061
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3159189ADFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BCA28C00C;
	Mon, 21 Jul 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS1091Ii"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEE4280CD0
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090487; cv=none; b=BGAyTzEQdZ1/+CyiuWrvyBqEJZvp3TV0zjgIuNJ5NvQAKQIex7nXLulIGD20tbV0DgBma9jfnmrIKZCCKWyR+M37IEiiAQrRXuFpk9D8QzrXC5gs8K/t5dZr2AVTI62qTWnc+4l33tcRn9pQn+Fs5KxdJoA6bm2OqbHn2cQGq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090487; c=relaxed/simple;
	bh=hFJkT41c+gnQQeID9FIJFDmMd4D1vkyvls/Gb93lGH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIJpDGk4j8dgZxxRHKMG9I6maFs3WwerGImkfct7WcFsJDX4mnvUl+BroBqDLU0eChz4DOOEytm63vLGShhpc4ktYpyxV1ZMLEyQBadi+vOl6rteSOsjThjcAdQSOTj3YS2lbcAzH1BavIKpxNUY3bHY7+MtYA0lowg/OfC2ZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS1091Ii; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so2326816f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753090484; x=1753695284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiKY+gefrBe9EMW0i2SyjyFG8IsTq/Rd5H8hxmm9+Ds=;
        b=VS1091IiGnUktp32/I2qBl1NDJaKXCc4gjbrfliktn1AQ3sWYJiT2VKRneiK50Alqc
         +4+kBA39fj6xPo9nu+cMISU+vE4iB4/TPbAHFeLGeGzscV3RnG+lbZcTe2yPTcYOFBob
         RAWXXyX80Tr702wIeqpehw7U+yHffkscH3EXPXDOHDmff9QkYzfDZ5dLo/OCjaLLcXY1
         O/Ryw4eFKxyEhAEUdja14om7FZ8bdHG5Llj16g6D7h5OjhktGnHln5zIzgeWCIYzAjXu
         By8nGfiiSya3ofPVmQwXvqKDBjofhhbleWskaEnTBeT8gzt5DpJnD1e2ITomMmyy/QDe
         ZU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753090484; x=1753695284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiKY+gefrBe9EMW0i2SyjyFG8IsTq/Rd5H8hxmm9+Ds=;
        b=c0rGhypiFGvSsPmzgNRDD7loEc63ny7qWboitMsEiJ2uCday/X9id3sqsqrbYUVo03
         LJp2vNLpW2zsc5qbYvAjaA2Ge/D3QwlVivzp+7qMd7uMX3V7smpPklZJ8OLOubF5lVWe
         /fOnPqJJ1o+dajhrjMtWim4URgW77PRtZFTcSVQ2Et+FGZtz2ZOGYNw6p/BC6YQYuQpV
         h08JpnnwOE7gn0XFPe0Bj2D/eLsqXGl72l8Iio/tUCbvPeX5fir2b0n8GkjQSceQJG8j
         58X2tJxbgOUtbe4nU182Emlh31aoc9rlNzaGUoNwmvPLAqKx0NUmrECOU88PoHv2NhUP
         2Fcw==
X-Forwarded-Encrypted: i=1; AJvYcCUw34ns6FycVmYuHt1/hh8UPQRzYv1yY4aObR9r/dCB6uEw3mrZXSZ0UNodOtEqBFjvx1rN+VcBdpWExhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykKgBjvVlmYY22rLwEINtTAuGPhKqY2XdMY38NAcoqXzVCdKoA
	M9gmurVuLGfsE0OOHTiLLFE7G9QcAtC/x6bsbyfge74rS10DBLDFObZ9
X-Gm-Gg: ASbGncsIsA1kcqY7xtB5xfj2oh42ilkiwJbP5yi5UiC+IoGCZLZV4qyrBKF/EGL7f1e
	53Bi+6dpFoBqUVbkXickR7CLB3sOB/7rrIJtZe0I4VkfVw6ZAXvlK6rv+EYxRIigPG4U2WGBcA3
	YhJZfDUwRAzKUUiJWrdtukUQcTnAJ4qBOnlru+KRreZ2sFE1EOXSL1ix6sa4PUse6fPMTtLoRBK
	VMOn71tvAP8q6n7MwGDSxWI1JCDBx5W5elkYYcAySlQHK6nQFX3P/6nXNt8vhA06ei4Ixk87mNg
	sJLomFuoz89wDA7AjlXs6S/QPM5uHLXG00j6FwQdfWxdn6YbpeGGShaeFX6YLmH8dG6oj+Z4hcI
	4AeQF8Oqj/EzK9VJBU3g=
X-Google-Smtp-Source: AGHT+IEF7dx86NKcSq65MM+Lhefi6sj61xOy3ryvPKnGSrMUIpUYysW60EzYiVncCfMlnEMIEBRWlw==
X-Received: by 2002:a05:6000:643:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b61b0f34efmr7535559f8f.21.1753090483517;
        Mon, 21 Jul 2025 02:34:43 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f5f3sm93178795e9.25.2025.07.21.02.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 02:34:43 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: juri.lelli@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org,
	luca.abeni@santannapisa.it,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yurand2000@gmail.com,
	yuri.andriaccio@santannapisa.it
Subject: Re: [BUG] Bw accounting warning on fair-servers' parameters change
Date: Mon, 21 Jul 2025 11:34:42 +0200
Message-ID: <20250721093442.244074-1-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aHpf4LfMtB2V9uNb@jlelli-thinkpadt14gen4.remote.csb>
References: <aHpf4LfMtB2V9uNb@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On 18/07/25 16:53, Juri Lelli wrote:
> On 18/07/25 16:22, Juri Lelli wrote:
> > Hi,
> >
> > Thanks for reporting.
> >
> > On 18/07/25 13:38, Yuri Andriaccio wrote:
> > > Hi,
> > >
> > > I've been lately working on fair-servers and dl_servers for some patches and
> > > I've come across a bandwidth accounting warning on the latest tip/master (as of
> > > 2025-07-18, git sha ed0272f0675f). The warning is triggered by simply starting
> > > the machine, mounting debugfs and then just zeroing any fair-server's runtime.
> > >
> > >
> > > The warning:
> > >
> > > WARNING: kernel/sched/deadline.c:266 at dl_rq_change_utilization+0x208/0x230
> > > static inline void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq) {
> > >     ...
> > > 	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
> > > }
> > >
> > > Steps to reproduce:
> > >
> > > mount -t debugfs none /sys/kernel/debug
> > > echo 0 > /sys/kernel/debug/sched/fair_server/cpu0/runtime
> > >
> > >
> > > It does not happen at every machine boot, but happens on most. Could it possibly
> > > be related to some of the deadline timers?
> >
> > I took a quick first look and currently suspect cccb45d7c4295
> > ("sched/deadline: Less agressive dl_server handling") could be playing a
> > role in this as it delays actual server stop.
> >
> > Could you please try to repro after having reverted such commit?
>
> After that (w/o the revert), could you please try to see if the
> following helps?

I've been performing some tests as you asked and indeed the culprit seems to be
cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling"), as
reverting it on the current tip removes the issue.

I've also tested the fix you posted (w/o the reverted commit), and I can confirm
that the warning does not seem to be triggered anymore.

Thanks,
Yuri

