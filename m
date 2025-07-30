Return-Path: <linux-kernel+bounces-751079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D790EB1650B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B183175553
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F412DCF45;
	Wed, 30 Jul 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b="NoXjzyWF"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8F13B797
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894319; cv=none; b=q9isaDd0E04gUUrUmtOcu1vNk7zo1DlmSt/1ATie2z3GP7H79fedmT1b0MD3A5xwo96H2lkKZBpXQR+7SCr8eqaWUhU/SZ5SFRPdo5wp4DGK9Yw/4YNlmb+OyczpEFZS0jhLC0ReAaII6PlQ42U2NKMZiAPQukxM+zl+uSX+z5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894319; c=relaxed/simple;
	bh=YXsmXSlUz8lqFeL6eNW9nN8fjWL3akwx2CrY28diUaU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=K+g6MxZ8Rwj/qXSHh9M8+d2pFgEzoNYTzz2PANv/o06NkWwx5mprNUhM+jsNDKSsA1HxSEHuEw1OJqIQrZIgDxa0x3Y7ZwH3Jss+BEBKxcpFOUE036BBnp0sbZD7em/iiaq1AzGWpPBxMVOjFouWNfm/3rou7i1jdKyLGmW4ZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com; spf=pass smtp.mailfrom=simplextrading.com; dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b=NoXjzyWF; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplextrading.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-539345ebfc8so3187e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simplextrading.com; s=google; t=1753894317; x=1754499117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NFg240Nt4UW1gzaEFZaoxTFT9SGLyQ6O3ehCJjglcOM=;
        b=NoXjzyWFWqV5LEyQL1oVOh/M5s/8+FrunURSsgODyUdMltSGmRRkof5sSHd41ei4NH
         EEYG9pXmKk1xWhkf2m2ew6iNq3VkOa0JzFXFUeF6vla6f+Nx8UcvbRUjod3ZxxehePMo
         /TTHMXAPvYqsAnn1Jhm+J4/Jhbo7+4wbG3QjRzbRue7pvYtnv2ezo50ZxJL2uA4cfHBj
         j/tLgoq1QmIk7oNli7cJ+AduxY+AtzcSW06A4cfbodnUs6CgyTKeSp7vkzZW2DQ68fBW
         wc/wuQilR265IXhAaPZ9QlPwZKzSSsQAw/rzn7wI1pzFX+AWXQzX4Z1I7SSQtyPvQx4C
         E9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753894317; x=1754499117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFg240Nt4UW1gzaEFZaoxTFT9SGLyQ6O3ehCJjglcOM=;
        b=R67KErU85PzZQE06cKnhUpM8xdSq+m7ePg+MKv+erUwWdCztAkigtDGJEwgYI0Fdfx
         Ymd/EwJudMI/ihFLeKDhbQdy61xFj2t7M2fZHVLuFCoCvUs7sEdfVZACTUW3Aownn0XI
         1uKssxgUkwoFk/UBISOey/r3Lsyq560ruk8Jb7aoW896Bcf5/tFG5c/i3+bxHw+Oan+i
         PBgdXEJk+ppQJJhy3Y0aCUnUPo7/uutnMzflbH8P721ByxDZtw50vS1MZOMZ7lN6vAl6
         gZWZtJXri6GIeBKsk00QwUm9jLVzMXCMlY89EqqdoqxbwDg8x7Y/LdavmIDrau3VV/Iu
         gbAg==
X-Gm-Message-State: AOJu0YxWyrUYjpPnswn3nczJ0akh9U9QPyeSKC9HCt7Df2NbhLsXZ2Un
	NXuZQIa5Tl1I3rx8zRmuvVJf1pyH2X+v6dakDSgZi14red+shslrRpwRjO3QqEwjeooTaqRsZZp
	f5601ymLHQ/6Tt+YwDLvs/zBPjFLfdjAkdPyQlEzLK7EvqTqtWy+IJfS0WOxiUh4Fahu0J4eu2z
	9Ww6/zB7bcG+GZE7+VsjZWO9ycOhOiwxXUb5FTDEqcLaDX417BXGz5gBsKC9vNRFFPBySzaYLij
	/eoZFg5RYLjpZ/exr+njDpIPbwCt2CRDxWZwtFFVgicMLk490g+ubsBZJ+m8gkj2yhA/8ZwNH7R
	ArBM4IC4rIQcKZ247buu
X-Gm-Gg: ASbGncv+6ztHBPgPEHazuhxkBjGGJFiMhDT2mNHtIkuEn2/j2lujyv4N1RH1p3GhDMF
	FYqppUxRRM37OXRCtzr7TwngofEPf15D3GUhGdTcWc0GSJ6jO+qWnC/sUG4ys1z/VNCwsmi3xaz
	qNiTMR57TtnYBvQpuEhlWnePCwEa7JAlyegtuVQrAAqBnDxVFFiq9FPr3xlxIRlHv3K1H3CtjD8
	vmYa+FE
X-Google-Smtp-Source: AGHT+IErxlkunWqr+t0V1zzSEB34EttBX7u00hcN8kH/0pXyRtwcrhXothmID8BHMprGeUhXeBPhplXbiTETSteBGd8=
X-Received: by 2002:a05:6122:520c:20b0:539:27eb:ca76 with SMTP id
 71dfb90a1353d-53927ebccdemr1003874e0c.5.1753894316688; Wed, 30 Jul 2025
 09:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Haufe <dhaufe@simplextrading.com>
Date: Wed, 30 Jul 2025 11:51:20 -0500
X-Gm-Features: Ac12FXw3dChFKuZa9RhVxewDGY5t32TXRXDQncXhVfTtpct8uiDtYBPEeBUwu7A
Message-ID: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
Subject: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[1.] Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
Interrupts on isolcpu/nohz_full cores, performance regression
[2.] The code for dl_server_timer is causing new IPI/Function Call
Interrupts to fire on isolcpu/nohz_full cores which previously had no
interrupts. When there is a single, SCHED_OTHER process running on an
isolcpu/nohz_full core, dl_server_timer executes on a housekeeping
core. This ultimately invokes add_nr_running() and
sched_update_tick_dependency() and finally tick_nohz_dep_set_cpu().
Setting the single process running on an isolcpu/nohz_full core to
FIFO (rt priority) prevents this new interrupt, as it is not seen as a
fair schedule process anymore. Having to use rt priority is
unnecessary and a regression to prior kernels. Kernel function_graph
trace below showing core 0 (housekeeping) sending the IPI to core 19
(nohz_full, isolcpu, rcu_nocb_poll) which is running a single
SCHED_OTHER process. I believe this has been observed by others.
https://community.clearlinux.org/t/sysjitter-worse-in-kernel-6-12-than-6-6/=
10206

dl_server_timer() {
  0)               |    raw_spin_rq_lock_nested() {
  0)               |      _raw_spin_lock() {
  0)   0.051 us    |        preempt_count_add();
  0)   0.160 us    |      }
  0)   0.357 us    |    }
  0)               |    update_rq_clock() {
  0)   0.115 us    |      arch_scale_cpu_capacity();
  0)   0.498 us    |    }
  0)   0.222 us    |    fair_server_has_tasks();
  0)               |    enqueue_dl_entity() {
  0)   0.056 us    |      replenish_dl_entity();
  0)   0.050 us    |      sched_can_stop_tick();
  0)               |      tick_nohz_dep_set_cpu() {
  0)   0.051 us    |        preempt_count_add();
  0)               |        tick_nohz_full_kick_cpu() {
  0)   0.052 us    |          preempt_count_add();
  0)               |          __smp_call_single_queue() {
  0)               |            /* csd_queue_cpu: cpu=3D19
callsite=3Dreturn_to_handler+0x0/0x40 func=3Dnohz_full_kick_func
csd=3D000000001d10a127 */
  0)   0.178 us    |            call_function_single_prep_ipi();
  0)               |            /* ipi_send_cpu: cpu=3D19
callsite=3Dreturn_to_handler+0x0/0x40
callback=3Dgeneric_smp_call_function_single_interrupt+0x0/0x20 */
  0)               |            native_send_call_func_single_ipi() {
  0)               |              x2apic_send_IPI() {
  0)   0.084 us    |                __x2apic_send_IPI_dest();
  0)   0.203 us    |              }
  0)   0.298 us    |            }
  0)   0.713 us    |          }
  0)   0.053 us    |          preempt_count_sub();
  0)   1.080 us    |        }
  0)   0.052 us    |        preempt_count_sub();
  0)   1.586 us    |      }
  0)   0.237 us    |      cpupri_set();
  0)               |      cpudl_set() {
  0)               |        _raw_spin_lock_irqsave() {
  0)   0.053 us    |          preempt_count_add();
  0)   0.176 us    |        }
  0)   0.141 us    |        cpudl_heapify_up();
  0)               |        _raw_spin_unlock_irqrestore() {
  0)   0.052 us    |          preempt_count_sub();
  0)   0.158 us    |        }
  0)   0.725 us    |      }
  0)   3.014 us    |    }
  0)               |    resched_curr() {
  0)               |      __resched_curr() {
  0)               |        /* ipi_send_cpu: cpu=3D19
callsite=3Dreturn_to_handler+0x0/0x40 callback=3D0x0 */
  0)               |        native_smp_send_reschedule() {
  0)               |          x2apic_send_IPI() {
  0)   0.084 us    |            __x2apic_send_IPI_dest();
  0)   0.200 us    |          }
  0)   0.296 us    |        }
  0)   0.580 us    |      }
  0)   0.678 us    |    }
  0)               |    raw_spin_rq_unlock() {
  0)               |      _raw_spin_unlock() {
  0)   0.052 us    |        preempt_count_sub();
  0)   0.159 us    |      }
  0)   0.260 us    |    }
  0)   5.436 us    |  }

[3.] SCHED_DEADLINE, CFS, nohz, isolcpu, nohz_full_kick_func
[4.] 6.14.11, code appears first in 6.12
[5.] 6.4.16 does not have this issue

--=20
DISCLAIMER: NOTICE REGARDING PRIVACY AND CONFIDENTIALITY=C2=A0

The information=20
contained in and/or accompanying this communication is intended only for=20
use by the addressee(s) named herein and may contain legally privileged=20
and/or confidential information. If you are not the intended recipient of=
=20
this e-mail, you are hereby notified that any dissemination, distribution=
=20
or copying of this information, and any attachments thereto, is strictly=20
prohibited. If you have received this e-mail in error, please immediately=
=20
notify the sender and permanently delete the original and any copy of any=
=20
e-mail and any printout thereof. Electronic transmissions cannot be=20
guaranteed to be secure or error-free. The sender therefore does not accept=
=20
liability for any errors or omissions in the contents of this message which=
=20
arise as a result of e-mail transmission. Simplex Trading, LLC and its=20
affiliates reserves the right to intercept, monitor, and retain electronic=
=20
communications to and from its system as permitted by law. Simplex Trading,=
=20
LLC is a registered Broker Dealer with CBOE and a Member of SIPC.

