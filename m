Return-Path: <linux-kernel+bounces-743297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA9B0FD04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61C25631E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914741F3B98;
	Wed, 23 Jul 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIK5SOZp"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120C3D81
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310572; cv=none; b=PHR5dtHiKQoHugrQABVOfcvKUe3p2T6H8Kt9CW4WPSF16u/w5PYPhGgZZKMPWnIsZiJXbiu0EB0jOf9vroDRfwDbbKAgHGefLqNAn9P/ILv3ro1umCgCxvC6wgA3bJBF+lbjV/HOPFTmSIXSI/Jfqr1nQWFAL/VgDeqk0SpQ28E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310572; c=relaxed/simple;
	bh=NcFgU4eNGvoSGy7anFFW9iRH19ypHWHoPs9zAvmuiOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeUkn+sHdkkn3ztr4QVN4GdUe79IrksimcLmMvGjvWcHoxV5dok7ftB1kcbAOuqemLbI26lR/1cJUwzEBpXRnn1htPK2uepWZOkbNcrMVrjsXCJ6JzemZoEu/fuhA2009IPaYRIYguIQalyLtK+peqvVgLlTMkJUCWc3Kdi8DmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIK5SOZp; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so487635e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753310568; x=1753915368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaa6m8hKwLIXXdBN0KpRVhNGU/wcpYkPgCrfrsTAbi8=;
        b=VIK5SOZpL3P8CYak5nEhfbLIzn8+23cITNsDHmeiyhRjS/TMl4He3d+w0OiDP+e4pE
         qG5xamc3XnTV2ZDJKiFn3j1+jemrc2v3Pq7AF+r2BUY9jjOUjvtrrY4ljU5aLVE2LA5r
         oMZm4IfcMlzH/E5QzsEJamJCbkJWICd16UNBojSIFnnxPKFFPH+aTmPqRbkQboBadAwz
         KKinEVWIrgmlnJyyWEWFeK3x9w9h4aR7fiv2h8nudahPsvzqaV/dzEMuORo6qjMIv2wi
         jkQxOT2jO2oVoVR+H+BjMuIsfmQfDPkE83C8wuhit8MYLoM26QmXvYjC59rkZp2tsdmO
         rkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310568; x=1753915368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaa6m8hKwLIXXdBN0KpRVhNGU/wcpYkPgCrfrsTAbi8=;
        b=cxsWowW9siMlGpEm4RKHRcg5M5pyZhqQquZFB8gVRKecY5zbbL9lIQSt2sHX3F4FYl
         pEkcbtJTGAtRyb7MuAH04bzlB0AVrdYMnf3o4d2JvdmJySw0qg/QyibvyqV6LGs6CQ1C
         jwPCVdy+KnR9hl6S9Ox90zQnHUx/t1AqnIcF+YTmLKssGyZ4DA79E1SfwVwAYfGMQ2Tw
         x1K75YTZWAV+iBTO2a9MBZF4PiY/vWspctOFWpIkgEs0I1V4JmOnsNzAMexuMgmPXc4u
         jPmPxy5ivoLCty0efB2TN1/17QN3xq6c8n1UTB3nzksX6tYYsHKxyIdPHSBd+NimKC+4
         F96w==
X-Gm-Message-State: AOJu0YxRstm6nGjQ15cCPl4K7mwXsFlJuCnkO8oIJBOoTfmeb42DdUM+
	yHtIRZCVR8l8t70RbqimrgyT3Qi3RDlN88jwAkaPW21oXXu37Gox7JGkJoTZTFMLPpy5k9cSTi+
	bCn6VGPr7IApS7ChNh6WlaX3lL4YGAbj6AI2iAUw=
X-Gm-Gg: ASbGnctz7P6vFziWjZcFStIQ7V18NrUAZhQZJjZ4esI69UNELukX25VArz6ocdPGJvo
	AmKzOoT822E+yi/92UmeMj2rlcmxfSh6Am26LQjwU/gWE0FCisFLfHWXg5TPuaxV0BQvwI1KNYf
	WPSqIDxqczn4Bvxd/N3XWK7e7UA7PPGhoiF//rjbcd4n19ZV7VavDiYgJpjboR1pw4P1UaaA23K
	SEuBO/+p54XllLM9zv7Reyg1eTAkTCrS6nJ
X-Google-Smtp-Source: AGHT+IFLf4LXQeblaqv2SgnaEl5hIUoQYOzPLyGbGV2XWTuCofaFOHKlfbcD9yhpyn6LMqqJuD4UnjZ+exRAkkMDvVc=
X-Received: by 2002:a05:6512:1394:b0:55a:4d9e:652e with SMTP id
 2adb3069b0e04-55a51369e13mr1753670e87.16.1753310568024; Wed, 23 Jul 2025
 15:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722070600.3267819-1-jstultz@google.com> <aID1MQEo2UeDewVr@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aID1MQEo2UeDewVr@jlelli-thinkpadt14gen4.remote.csb>
From: John Stultz <jstultz@google.com>
Date: Wed, 23 Jul 2025 15:42:35 -0700
X-Gm-Features: Ac12FXyDbOnbRSjxxl37rv_ImBVgPeY5RqH-7rrVm5mzONxfrgI6o_BolUkjB6s
Message-ID: <CANDhNCo+G4_t8jYU-QNPz42uZsKdMgEmTnr8pYSKbgm26NJUCg@mail.gmail.com>
Subject: Re: [RFC][PATCH v20 0/6] Donor Migration for Proxy Execution (v20)
To: Juri Lelli <juri.lelli@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 7:44=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
> On 22/07/25 07:05, John Stultz wrote:
> > Issues still to address with the full series:
> > * There=E2=80=99s a new quirk from recent changes for dl_server that
> >   is causing the ksched_football test in the full series to hang
> >   at boot. I=E2=80=99ve bisected and reverted the change for now, but I
> >   need to better understand what=E2=80=99s going wrong.
>
> After our quick chat on IRC, I remembered that there were additional two
> fixes for dl-server posted, but still not on tip.
>
> https://lore.kernel.org/lkml/20250615131129.954975-1-kuyo.chang@mediatek.=
com/
> https://lore.kernel.org/lkml/20250627035420.37712-1-yangyicong@huawei.com=
/
>
> So I went ahead and pushed them to
>
> git@github.com:jlelli/linux.git upstream/fix-dlserver
>
> Could you please check if any (or both together) of the two topmost
> changes do any good to the issue you are seeing?

Thanks for sharing these! Unfortunately they don't seem to help. :/

I'm still digging down into the behavior. I'm not 100% sure the
problem isn't just my test logic starving itself (after creating
NR_CPU RT spinners, its not surprising creating new threads might be
tough if the non-RT kthreadd can't get scheduled), but I don't quite
see how the dl_server patch cccb45d7c429 ("sched/deadline: Less
agressive dl_server handling") would be the cause of the dramatic
behavioral change - esp as this test was also functional prior to the
dl_server logic landing.  Also it's odd just re-adding the
dl_server_stop() call removed from dequeue_entities() seems to make it
work again. So I clearly need to dig more to understand the behavior.

Thanks again for your suggestions! I'm going to dig further and let
folks know when I figure this detail out

thanks
-john

