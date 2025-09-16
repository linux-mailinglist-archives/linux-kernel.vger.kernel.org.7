Return-Path: <linux-kernel+bounces-818105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CA8B58CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12AA87B1A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2961521018A;
	Tue, 16 Sep 2025 04:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0GsWpC0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB972610
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996303; cv=none; b=Nq7QIO2fnp8sA9ao5AIEa2U4MAzOkrC868vGHvRJZwC3oAX45zGnURLbawJOb63Mz3Q9OncYVDcxiu1JpB34slku9DfsfmDSFMfEIpGJ+cAlCu3NfVUTPA06ubgX6JVChni1nJrsphQMBX0awbti6fXBWpGCSxrGWiK0ohHym0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996303; c=relaxed/simple;
	bh=C6dV338ymu+/gyGLDuEaNA6dYPqvf+Lf8iiEvwyaMXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUq7KtYG+LGSPIuww1an8xyIkVzQQazA/DheZQO26LgbCVoQ8taYuUVpfuHRwyK0NpPCkQmnnT/3VmnO33XTAic4gkZamoB/HhLSReCeR1V4FA2Sha127F8s7E6TxlvIIux6ugvmVr2xFIO/ecHfaol1lAeNsRV5vNLolg0ji2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z0GsWpC0; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33ca74c62acso45243781fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757996300; x=1758601100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3gIbBvSTMVTmTzAF2o8La1xhOnztTpPgX6dUoQiGdY=;
        b=z0GsWpC01CzEj6vojTseTfbGZ1kyg7+UveiaSpH+PR/h76qifXcBuubOiNRURLScW6
         bcwHvic7YXdQZtjTI3IWqiVFYaeRqH8if4OtwG0rPkqi/UBTwsc1eZSApuqyQomMh1+x
         5GTm6jZ4dZcYS660BLv+hOQEAQWV1oMy4QtQE0j9ez6B/pYeEPDrBTKvsYVZfrdQcAPJ
         8lZQDMcmSgWnY0aMpqxMbHAO8B2/LmIEjpFvNtNuUfaLfNUuL57hB3rAJ0UW+9T+hCFs
         uq/HJMKfA9LktrvsfSiigKbuwiIUuxo4DNz/IT/FLnwXQ0T3VZK5iBluDCFaPZZpxb6U
         Xmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757996300; x=1758601100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3gIbBvSTMVTmTzAF2o8La1xhOnztTpPgX6dUoQiGdY=;
        b=SBhI2JLhPYXy1+AJzDs+qUucJaR93AIdw+yXNpu25v4VL7KM7faqnQ8PdpF0BdV+Uh
         5dAoF+BaBsB6uA89mf0YGQOZZlI4xrLhW1Ruo3TZ2+e+UzpB9IJGWOQZ4l+rbMotVwJv
         a7Cy4m5/ot8iX18R8Urrpu3Kje9IxyNZarGNLfznzrJpc86CgP5i0TkvzMDjisvrpQTH
         0p46ge8dRJgC6tIEU3AoJmfq4A9miEgt1kUZSCUM723CXU8t6RoidWlRPNTi+iqHpz4u
         L0z2FJ6etrCLsS4Ol/HlwKaySToj21qlRDpIReaDhqKKXAX7nF1U4Y5TiOEPkZFQIGUC
         84Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUdATF/coTPgIzGRNQkbUyS09Qyc04kDBOhsMvQZQ9wFN41dJoDiINxUtOxDnKgxLAIoAMWsspkWTD2n7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMcHDaIkaGdgmMJ5K1AOHQW1b9mrcBc+eUiC0u9iOhnjvhYc1
	FiCaCUkvUg9yR+uvo8Kb06JKPSYXQ91+/ut8SmnbW4oF2SKJGStS/6FFhFFczOFOkxbl3/69I/v
	aiZ3WXPxmMJxpsSzSU4afu2bZ7Yr74Q8Xn8gBszo=
X-Gm-Gg: ASbGncsBWge2b3AFmq1SfzRd/Bi8sk2IWrkCCZduCA7OFD5pUV+VrNYjms7VP557Anr
	45fMdmFdpiwgkWwSvyubzVacBz3mdeIxgAx7SY6nW0mS4F4lh1PouwX7OGo7HLAFtUU47WbCUfG
	TVvuOxjzPrSVfpGHgbeReF9hGUKCOtIhNZ1L9xLYGWMlqVxQfoMW+gvPJhWZGmHLPQekbfTn1SV
	5IrZkC8Ejo8nK2/LHb5/xujuU4tPbSToZ+dHora8g==
X-Google-Smtp-Source: AGHT+IHzPoGgykwebyupupNSD2WrE0n1OLGYOzoqztVP3XAzi0GgrZBbMusw2lBh/FNZsjFGmRbeeq0P44/f3vNN8+s=
X-Received: by 2002:a2e:b8c6:0:b0:356:25da:89df with SMTP id
 38308e7fff4ca-35625da948bmr32206241fa.20.1757996299431; Mon, 15 Sep 2025
 21:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702114924.091581796@infradead.org> <20250702121158.465086194@infradead.org>
 <CANDhNCpDW-fg6DK8Wcgwq-1fgaYSkxL1G6ChUkC4K6Mpk04aEQ@mail.gmail.com>
In-Reply-To: <CANDhNCpDW-fg6DK8Wcgwq-1fgaYSkxL1G6ChUkC4K6Mpk04aEQ@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 15 Sep 2025 21:18:07 -0700
X-Gm-Features: AS18NWDZgx6RgZHU7TGQy2DPVEQL1XWJjYR8dSNG1TwCKegUMyLIhwriJNK8QO8
Message-ID: <CANDhNCreD8f6pPjUa--UzXicJr=xnEGGbKdZhmJCeVPgkEV-Ag@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] sched/deadline: Less agressive dl_server handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, clm@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:29=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
> From my initial debugging, it seems like the dl_se->dl_server_active
> is set, but the dl_se isn't enqueued, and because active is set we're
> short cutting out of dl_server_start(). I suspect the revert re-adding
> dl_server_stop() helps because it forces dl_server_active to be
> cleared and so we keep the dl_server_active and enqueued state in
> sync.   Maybe we are dequeueing the dl_server from update_curr_dl_se()
> due to dl_runtime_exceeded() but somehow not re-enqueueing it via
> dl_server_timer()?
>

So further digging, it looks like when the problem occurs, we call
start_dl_timer() to set the hrtimer, then when the hrtimer later
fires, we call dl_server_timer(), which catches on the `if
(!dl_se->server_has_tasks(dl_se))` case, which then calls
replenish_dl_entity() and dl_server_stopped() and finally
HRTIMER_NORESTART.  With dl_server_stopped() having set
dl_se->dl_server_idle before returning false (and notably not calling
dl_server_stop() which would clear dl_server_active).

However, dl_server_idle doesn't persist for very long, as we
dl_server_update is shortly called setting it back to 0 before calling
update_curr_dl_se() which I suspect is dequeueing the dl_server.

From this point it seems we get into a situation where the timer
doesn't fire again. And nothing enqueues the dl_server entity back
onto the runqueue, so it never picks from the fair sched and we see
the starvation on that core.

After we get into the problematic state, the rq->fair_server looks like:
$3 =3D {rb_node =3D {__rb_parent_color =3D 18446612689482602296, rb_right =
=3D
0x0, rb_left =3D 0x0}, dl_runtime =3D 50000000, dl_deadline =3D 1000000000,
  dl_period =3D 1000000000, dl_bw =3D 52428, dl_density =3D 52428, runtime =
=3D
49615739, deadline =3D 217139555275, flags =3D 0, dl_throttled =3D 0,
  dl_yielded =3D 0, dl_non_contending =3D 0, dl_overrun =3D 0, dl_server =
=3D
1, dl_server_active =3D 1, dl_defer =3D 1, dl_defer_armed =3D 0,
  dl_defer_running =3D 0, dl_server_idle =3D 0, dl_timer =3D {node =3D {nod=
e =3D
{__rb_parent_color =3D 18446612689482602384,
        rb_right =3D 0xffff8881b9d1cbf8, rb_left =3D 0x0}, expires =3D
215349181777}, _softexpires =3D 215349181777,
    function =3D 0xffffffff813849d0 <dl_task_timer>, base =3D
0xffff8881b9d1c300, state =3D 0 '\000', is_rel =3D 0 '\000', is_soft =3D 0
'\000',
    is_hard =3D 1 '\001'}, inactive_timer =3D {node =3D {node =3D
{__rb_parent_color =3D 18446612689482602448, rb_right =3D 0x0, rb_left =3D
0x0},
      expires =3D 0}, _softexpires =3D 0, function =3D 0xffffffff8137faa0
<inactive_task_timer>, base =3D 0xffff8881b9c1c300, state =3D 0 '\000',
    is_rel =3D 0 '\000', is_soft =3D 0 '\000', is_hard =3D 1 '\001'}, rq =
=3D
0xffff8881b9d2cc00,
  server_has_tasks =3D 0xffffffff81363620 <fair_server_has_tasks>,
server_pick_task =3D 0xffffffff8136c2d0 <fair_server_pick_task>,
  pi_se =3D 0xffff8881b9d2d738}

I'm still getting a bit lost in the dl_server state machine, but it's
clear we're falling through a crack.

My current theory is that in dl_server_timer() we probably should be
calling dl_server_stop() instead of dl_server_stopped(), as that seems
to avoid the problem for me, but I'm also worried it might cause
problems with not setting dl_server_idle, though again my sense of the
state machine there is foggy.

thanks
-john

