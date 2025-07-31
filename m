Return-Path: <linux-kernel+bounces-752459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE121B175C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA72B581870
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28823816A;
	Thu, 31 Jul 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b="TRhExO+2"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE21C6FFD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 17:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984241; cv=none; b=ig1uof03n0yKxKMUjed54honT1HGA4xEJXcsSXQ20RdFBE1UN/WzubHy0kkpJxq6YaSNozhaUIm2KH/LBrcjE6TdFNtqupDzDqlIelJb7Pfkl8Z1B8P7HD3X0/eN8vrdgMaDQWTErWMYyOKGwTlYgkOlSB6QfVPZFNdaKHBLJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984241; c=relaxed/simple;
	bh=cBrPmQDdXQBHnUvQKAH0cXtVSYd3osdyNNWGGbP+Sik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMe7teyWnqhFiqUoZOLqaxlZxszZwk09VmXji9CMXAN76qDSbApHGWWH0r5vJ6n7L6kEL+KOzSVXDdwMFER5Umr3LDcPdRXMCjIcgj0fGhXzKVnND2oUGV84qQfrETQpWR/GUXXFSuPQ3DLnCFkPKf0AVr+F2Eok7zwjm0SAkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com; spf=pass smtp.mailfrom=simplextrading.com; dkim=pass (2048-bit key) header.d=simplextrading.com header.i=@simplextrading.com header.b=TRhExO+2; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simplextrading.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simplextrading.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5379498da7eso1574813e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simplextrading.com; s=google; t=1753984238; x=1754589038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBrPmQDdXQBHnUvQKAH0cXtVSYd3osdyNNWGGbP+Sik=;
        b=TRhExO+2E1qQ3G8OTXycr92ruvG3kq+kmEnFounR669+5v1XahKbbV7rvPUlcnfuIl
         Y5I4i8tPADjlrSB5xomyTSqpFNXQlFhUtgm05I7Fin2TBevG5PYI8u0oDWpbugTrcrRd
         LRs781Zz16YDH3znf5gm8i9zUwTlb36HgX2C+YthVo3Nf/1h9nU/hiYRMtG2jrdw5QFy
         sBA7c1DO44n2POIwOQF47hQ6A3ntw132CQ/O297ULmvpphsLx2qmrW24q8g4VSPoImY2
         TRdYZMfyRAcUnTRAPR7nkZ4FnWCk2LoPWv6dUPZcB6Rifuv2UAGdrQlgTlvD0arp+/Kv
         Yt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753984238; x=1754589038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBrPmQDdXQBHnUvQKAH0cXtVSYd3osdyNNWGGbP+Sik=;
        b=MuSDM3IDQb6A7QIP8bffelMNdfNXJDEbbXllShCLiCct2yGZ0GSCcZtI1sickj4vee
         n/khUa/pBHRxfqjPu7sWt4OZeVDeV8vZfB/PJtzM7HGiQ0SpWoc5aUrZIS7SZEK6EzJC
         TOvohPnbUdENr3qiKr7WfwujA1alQ+XOydvMgEjPnaIMAhZQalmXVDm1Q1bxWTcwRcXy
         0slG30zaWVeVNx0bSMde2omXJNrhbnjrPXq0BN+8feZ1AdWXDTXqwsZ1+TP1a/z/65Uk
         MOFKkBEUqNG7LW5IcB8RG0z3C+Qxots1p/9pVQbpm0WkyNdNFykbCSsLZmfZSqZip0Z/
         QDyA==
X-Gm-Message-State: AOJu0YxvLgxIrMhdkFQG/fRl3ughUINAM9wFxPuvQokohD5+04npnQHl
	ZWrTlk2i9oB284hGPXEsljPLo1xgz0s7fJsCjOMp8jUqYue5QqdlWZAJK/FfhiZ3nDh1yL+KhEB
	YKFydaiqqj4XuLo5sbE3b1NLMLDQ4PYiPiJfakKr0YG6/GKYtqnXBxAKzOzOdE7BhOUr2nG6nXo
	nuVPr1lPzaliqWXj63/g85Uf9ggrKX2RV3u/crRWmRs3S0NO4gz7KWXzT3Tzi9PewacdAyIu2v6
	qSlQATjRqnVyhHgArB3U4TG5MXSL2w6fpbyRZT+HqB574TPk/fqCVGCWggP8WvhkdxGPTmh6N+F
	feLo47U=
X-Gm-Gg: ASbGnctnDTgaOHqSvHO/1etVXWuMYJEJtaEYDuFM8LrN5SE3b1XsxxccNtHkF2Xj3Yi
	y85BZCvsMUw9+Mogsl7MF/MCP1QAq5LRqIR+TBFiXdy5lhvWaePL7tTTTtxtsiG9T2fcrL1IfKZ
	U2pvLG2LErj9nv6PD7K9mHEHZvpLdgTRPvX79aBxTSr64fJ37y89oZZz7taZlVjgS5Pv4JRKtg7
	1eDgdq+
X-Google-Smtp-Source: AGHT+IEkwh/gkbuiuMk01KMFB8FcWTWNPnifyFa6NPhuF66Q5t4CELPtgiUeiBkPpK0mpXJNhiQfIyQAVze/uGU0OTc=
X-Received: by 2002:a05:6122:6003:b0:534:7e7d:e70b with SMTP id
 71dfb90a1353d-5393855c263mr1428864e0c.2.1753984238146; Thu, 31 Jul 2025
 10:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKJHwtOw_G67edzuHVtL1xC5Vyt6StcZzihtDd0yaKudW=rwVw@mail.gmail.com>
 <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <aIsUwT1Ai0zcMRpT@jlelli-thinkpadt14gen4.remote.csb>
From: David Haufe <dhaufe@simplextrading.com>
Date: Thu, 31 Jul 2025 12:50:02 -0500
X-Gm-Features: Ac12FXy8uGmesvmx44YbVgoNYIPwfRoNHgbGmtOJyniBK5joOD2fqUcg3Ec3a9A
Message-ID: <CAKJHwtPyF_2xvdQb0b3b=6qsgZXrn5CQNA7pk5PKWJV63_TO1Q@mail.gmail.com>
Subject: Re: Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
 Interrupts on isolcpu/nohz_full cores, performance regression
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kernel 6.16 shows the issue. /kernel/sched/fair.c calls
dl_server_start() and there is no assessment prior to that point or
later of the isolcpu/nohz_full+single-process condition of the core.
Same function_graph trace generated. Code is the same at
tip+sched/core.


On Thu, Jul 31, 2025 at 2:02=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> =
wrote:
>
> Hello,
>
> Thanks for the report.
>
> On 30/07/25 11:51, David Haufe wrote:
> > [1.] Kernel 6.14.11 dl_server_timer(...) causing IPI/Function Call
> > Interrupts on isolcpu/nohz_full cores, performance regression
> > [2.] The code for dl_server_timer is causing new IPI/Function Call
> > Interrupts to fire on isolcpu/nohz_full cores which previously had no
> > interrupts. When there is a single, SCHED_OTHER process running on an
> > isolcpu/nohz_full core, dl_server_timer executes on a housekeeping
> > core. This ultimately invokes add_nr_running() and
> > sched_update_tick_dependency() and finally tick_nohz_dep_set_cpu().
> > Setting the single process running on an isolcpu/nohz_full core to
> > FIFO (rt priority) prevents this new interrupt, as it is not seen as a
> > fair schedule process anymore. Having to use rt priority is
> > unnecessary and a regression to prior kernels. Kernel function_graph
> > trace below showing core 0 (housekeeping) sending the IPI to core 19
> > (nohz_full, isolcpu, rcu_nocb_poll) which is running a single
> > SCHED_OTHER process. I believe this has been observed by others.
> > https://community.clearlinux.org/t/sysjitter-worse-in-kernel-6-12-than-=
6-6/10206
>
> Would you be able to check if the following branch, containing multiple
> fixes for dl-server, is still affected by the regression?
>
> Thanks,
> Juri
>

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

