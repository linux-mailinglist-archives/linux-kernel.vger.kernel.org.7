Return-Path: <linux-kernel+bounces-879284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EAEC22BDF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636DA4E8AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0382E62A6;
	Thu, 30 Oct 2025 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="el/Bq85u"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92169299947
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761868406; cv=none; b=quSZu4kODM7UN5iEYQ6kSoK5k51tuZ7HrBTGSMoJFIhLixOMWm5YpaVJL40+gc5mjfiKTa9uhR9FJmO39vA7VUtrmgI3FUuoD4pooG+fKLHA//kdM38wUVCBGigqQAYXUkNCEiNaQRoS0/+tX1i8e9gflmGKiG2lppuaZwcTjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761868406; c=relaxed/simple;
	bh=XX2aCb5+s9t10YALjpUUh7WFGKN3QZbtrCnoV1INnRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHt+4uuXRrLjae8qYMRUqQCVRRl4SyBuN1OUEIOFuC50VVnk73vrGYZFSbF21xGGJXyq//UW4PfyAc3pc2AuWnr1DZb83uUrROTDp/XH5rQ1ORrxP6b7EwYRb+uglez4XM5Fo7XfFINZOCJJ3A6QmuMpyuSOD8nwmaoMLdPE/7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=el/Bq85u; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d83bf1077so330348166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761868403; x=1762473203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XX2aCb5+s9t10YALjpUUh7WFGKN3QZbtrCnoV1INnRc=;
        b=el/Bq85uXlZiMcnkZKvR4bHz9tcuPnE4bsFhEz7kfMt/SyAkGDmBBY4g5Bjzf0ZPvq
         Nn3P/Mm6f5VjdJZKqFLxU/j21IUKR8hJneQkjwhUH3saT1RAPr27LIWvtADacbDtX3Fr
         5Adx39WECsl5qe25riLfYLAbouD5e3AKqFdkZwFI/kxaxMzd9x3M/WzS57Bt4YU8yoiX
         CWox9GExJXSZFfbn0Ggo6DA49JC7Fio5DlT54vCinE5WbzwLrj2rEdz8fJ1xdfSHo+b3
         DhPOanF/KLKM2aFjVmBFq+LQrNsG0q60TcxieDD//Hd8nlU4/wwY6XNWh3ibtGaL9TfG
         VukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761868403; x=1762473203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XX2aCb5+s9t10YALjpUUh7WFGKN3QZbtrCnoV1INnRc=;
        b=Jq0IzplhWA+UGWqaJbZyYh++VjObcN70GJQGEMAz7o4cMuWV6hulFyoYQjPUgHDJ46
         /rCNf6DB089OFvthNxZcz093Hs5h5mmMtn1j+raK7+7PZzFOxyIi0+IEd0KSmcATxnVr
         A5rXZLZYlcoQ0dTr4h+ce5Vqd2iM/5NGZP60zjh6u5bvZdtf5a7/BnbY32l0+8itw/nE
         kE32rohcxSFBtU0zP5xwsuzWNVEB0c5yuiG2Qx/nPsZREpEEsM2KeoaF+q6ERVzfCv+f
         3DZ7QDH5dErXyzXM7fxN1Kjk7Hpq2k3RQPkVj2raJmiaEmX0QUWEa4rwwCDB4VjfKWr8
         FueQ==
X-Gm-Message-State: AOJu0YydhjsH2fhKQKlPpp2iI8sgbdIU0+gfMzOOSL155JjOhrXkkxq2
	QCJUfaFA3M09SEhPYNfWKHok3enaRa/7nz+FrIhQVEBzLklYCS9nkp855vwWBFrjx6Zo6OdsEVC
	2r28bKuTETFZIuc1AK7s7ilf/Kb+JATvC2PX4Wf4=
X-Gm-Gg: ASbGnctCRhH7/W2l69c1+iOya3cR7fwHfCTRZEe9dBQjccRuxsO4fY0McY3jUJEQ3RX
	MgC+qI6K2FEvyS4e5cvMtyxtsxjgHwJwGS+DfsHJROhQcrjo/vVk1AQZQtCLXVdg9bU+BnZcetD
	NW5VlnK29fdmYmPnxprfKA4VvH47Zdp+hGjRj2fOyfFir2x62AqYn/5ebQ5WFn4LRMtYw98x9O7
	Q0NFIyVsrZb2bIgPgcaBxPDTFJsi9NPMDp4/Zn6fvxrzvA11eLZSmouIAgcpphzP2ME8S22PdzH
	uMYqJHLmUFyEeg==
X-Google-Smtp-Source: AGHT+IHkXPjkwH3SMhk14rzprPLW46ER0DfDzilqxaK3cGsoA3JGiThCvf5SaMrd/qloMhbFdhMdOOxxyrH/QCYgs3E=
X-Received: by 2002:a17:906:794c:b0:b6d:5bc3:e158 with SMTP id
 a640c23a62f3a-b70701395bbmr155831266b.17.1761868402684; Thu, 30 Oct 2025
 16:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030001857.681432-1-jstultz@google.com> <20251030001857.681432-4-jstultz@google.com>
 <f3c78a55-0f09-44ab-8ce0-9658e534564d@amd.com>
In-Reply-To: <f3c78a55-0f09-44ab-8ce0-9658e534564d@amd.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 30 Oct 2025 16:53:10 -0700
X-Gm-Features: AWmQ_bll3wm7tfvS9DJZM04f0w2u8EGAZ0RtDz6i2yq9laQMAsPd6mhkS25StUo
Message-ID: <CANDhNCrOpsT+XiuB7qQMEFtAreCnPRqzJ1j35Kn508ohVdBvTA@mail.gmail.com>
Subject: Re: [PATCH v23 3/9] sched/locking: Add special p->blocked_on==PROXY_WAKING
 value for proxy return-migration
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>, 
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:33=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Now I can truly appreciate the need for the tri-state with
> that updated commit log. Thank you for the detailed explanation.

I'm glad, but the credit goes to Peter for his helpful explanation and
drawings I quoted from the last review cycle.

> Feel free to include:
>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

Thank you!
-john

