Return-Path: <linux-kernel+bounces-899430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC7C57CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C66421F66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59841F63D9;
	Thu, 13 Nov 2025 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5r1Qgto"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB192184524
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041022; cv=none; b=AtS7WHPH4nWT5hm8YdjLVF6DeluYk9B0X6cx2CuXsZJ9mcoHeKHH6uUGqPG/zEN96dt6ju8lxt+tXVOu8/ncGJPxr036Q/00KnEUhYpwMo1auWTEUXm4DqogMRfANfMiVME0N+jYHywz6MPAETTX+ddOQ0pYNEH2FhkcZuwm4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041022; c=relaxed/simple;
	bh=a0fXOPvSK/odPMM+7mQmmudqNo2P8UQWfaofKLWzgAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0wfxAdjYEXvuMjalgn8KUxb3NA++hxqotA5hZHQWLS8D1BK2+MJM6EKYcROODiSfvk0GpElQn85i77grTNzBCHJhUA9ByM9bjS432W5d8XOqZhSbSTngVONC9Gbe1CMjlVas2gmXE6l880+Axtff691AmVkgQJIjU/iDung3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5r1Qgto; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-343d49b7227so1019733a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041020; x=1763645820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSJ2L4MT2I2gCHEpg9vmTrs2bYH5rDeQpfubY+Hgw5c=;
        b=T5r1Qgtor88LJV3CrH/cKFxoZU35zEZw2QvswMfpf9RaDOE5Bu0vEwGnxePdBr0KJ/
         6bJlB1r/LpM91X/A1YJ6chPcfKibK1wIjZ3/NtrmagmbXCLwUnQNnEmU3ZtFSWw3JWTK
         VsMop/AdYd9ql+clM37Bj3qSzn8y2wDuqyLgtxIAoARDypQ1eYeurwRIbWJDS2jtrc9f
         ISevUWMvlJjXJD9djkVhvEcX0sk7tanK9XBIDu/aDUNakQJ9Iws6y0k0rGVdOOoQ5dGT
         NQ2v+PuG1LAaoOGs0ImGo0hmsG9+NG2bi0nHPGhZRz+I/QHQvMZmpVflfv1sWTDGUCgJ
         QHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041020; x=1763645820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSJ2L4MT2I2gCHEpg9vmTrs2bYH5rDeQpfubY+Hgw5c=;
        b=NPSX+r29p4aurL5Nwos4geZRz9vAYqpQIdZH1OzQRWCo3B4oJaQVVbgxlBJ6OeJ0rd
         TuDjQlW5CTfGWBhjAMGaPasH8disCzPta5yZaWacpI4Kt0By/zE0psHz3g8qNT4YEwjd
         yhKBP+VCx8CYk1hFLvSJhLqsB7W/GN+wYT0ahW7mWFG4CbqRIfg47n8SgAsHu9q53cNM
         rE5htIg0MuR2tQy95MELTJVYcZQgMdBnmzXF8GMuAuaq4bPSm4TqRxE0jUpe2JqaNv1K
         Vexpuy5IYPh912iNDcsX8SKP2QwSHYcofaoXW0N/ED/WRocKed46fZ77KVtU2HTv4rnZ
         dlcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/UGIn8Ca1HrJHG2hkuLWFzsUQkZNrwBewvr03Czowa9M3xsCniCLxgK07VFrLu4xLxUveNVc/2L1/e68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvyl3MdYBXqXnOzh+O2Bpw7kPHIQekkQvJbUYquomDN0mCD7Qd
	QpzfOYnGsG+3hqy4u7d/oHGW0ONwoarpGWNkPeGK7PxgR3iuHsRhFcfJoDJyjA+8P3dBL+/LqbX
	w8VR6OdsYk9DfWGpBetnfm9eznaIRFi8=
X-Gm-Gg: ASbGnctaGA6YncLSA0SG8gSodC0e4W1f6iFexo8VhQlAAyYY7+nmXTMfsa5Tvuci5ES
	1fyRabAjuHeMAmCmxTsps75kVv8+qrU7mTOc8bhEcYrLDZ3vhghK7mR3snpahheFteB7Ta5qKRq
	kwptIauEML7f7Ndafuxo3rmvtxpuAsSmt8mY1EDrBeuX0zJwJ0JuADGXG0BoHFAdZSoSRJL0kDB
	JXqQZ9s+tIQCzSQs+c169Iu4U40pnN8I9DeXsx9Gqg7gNvOCDwTE9mPSEcw
X-Google-Smtp-Source: AGHT+IFMnnQX/hQFlma8t33w+3/sb1UazZlXFWzIBjAqm32zUEfsFdbDtvFTFKlaO1GUq9wj4UcYLSywqtKSaChulzY=
X-Received: by 2002:a17:90b:384c:b0:33b:8ac4:1ac4 with SMTP id
 98e67ed59e1d1-343ddf0cf3fmr8549056a91.35.1763041019969; Thu, 13 Nov 2025
 05:36:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110033232.12538-1-kernellwp@gmail.com> <20251110033232.12538-3-kernellwp@gmail.com>
 <015bfa4d-d89c-4d4e-be06-d6e46aec28cb@amd.com> <b56f1c06-b935-4018-adb9-3702d8ff57cd@amd.com>
In-Reply-To: <b56f1c06-b935-4018-adb9-3702d8ff57cd@amd.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 13 Nov 2025 21:36:48 +0800
X-Gm-Features: AWmQ_blAqyZ_N_z0MX2ESexsnzeWazvrKVLEJqauvim1Aci9-8mofKdR-zuB1Xc
Message-ID: <CANRm+CzOPieLG6bg=2XJ3jkEw268ua4DFZyubL5jT6Pu7nfk7A@mail.gmail.com>
Subject: Re: [PATCH 02/10] sched/fair: Add rate-limiting and validation helpers
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek=EF=BC=8C

On Wed, 12 Nov 2025 at 14:44, K Prateek Nayak <kprateek.nayak@amd.com> wrot=
e:
>
> On 11/12/2025 12:10 PM, K Prateek Nayak wrote:
> >> +    if (task_rq(p_yielding) !=3D rq || task_rq(p_target) !=3D rq)
> >
> > yield_to() has already checked for this under double_rq_lock()
> > so this too should be unnecessary.
>
> nvm! We only check if the task_rq(p_target) is stable under the
> rq_lock or not. Just checking "task_rq(p_target) !=3D rq" should
> be sufficient here.

You're right! Since yield_to() passes rq =3D this_rq() , the yielding
task is guaranteed on rq . But p_target may be on a different CPU
(yield_to supports cross-CPU). Our deboost only works for same-rq
tasks, so checking only task_rq(p_target) !=3D rq is sufficient. I'll
remove the redundant task_rq(p_yielding) !=3D rq check. Thanks!

Regards,
Wanpeng

