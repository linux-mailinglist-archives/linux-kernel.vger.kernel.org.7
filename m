Return-Path: <linux-kernel+bounces-787066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BF4B370EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEFE8E4039
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB2E3AE6;
	Tue, 26 Aug 2025 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="i6WEPL0p"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EA82E1C6B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227880; cv=none; b=EtDOYtMXDPpGwmp4ofDjG1H7ZBQ1+hvM8MSP8/pCi934Cj5/d3ciuz25Oyzv33n2HruCGV2PHX5Lz86Dh8HdT0qhKjall/fydTkw5VXC4Ynj+NfVP55YfxIio2UYCThMuu1IL5zjYEAeIALYRu/KuUJQzOw1fSGMiIiLcHlp/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227880; c=relaxed/simple;
	bh=4hli9x6NgPwP094pbyA0wxiR+cPcCetA3Wp28EfePcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UI893p03WJvv71i8uIX58Fm+elI5OysI+R5lhH17MKQPe5Bbho+pvZ0/FPGfDS3/JPONYSqdn+E4zndb1jvmJH38azcjatEOqr2hpCRESFwPMyMQwl0J8hGR2lZvUCrbh8489AQhqk/Sv/KW5Uuqc6kpZvfRp7E33k+DUjiyklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=i6WEPL0p; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b2d501db08so27491991cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1756227877; x=1756832677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=i6WEPL0pn88fDPnRYN45hj7gOcVCBERuZ1htsz9l/CTeeHj2yJkQyh/kwjR7I/du2F
         OOmppdVKnOz9UtjGaeC/ek8tlU+qZdGkzvtOXJyrhdNduwzOxIaS0Ag2/4hve/uJ27lh
         6MViq0s1o6dKjb+y/6TEb7+3NZSSELpdY29DxuWprqUoL6MWOaSu2OJql7+Fd/CiYkAK
         0DQfpzi6kdLrwqWyBkowG5vCTf/oYiOX/6bMmo7DR4xISJkGoUn7rSXHEhqbvjSiggq3
         M7ss2/L1eit4r9HSSLDmgtCzbYagzLjZboL0DpoeQe2see7mDltPbZ69hIwMafT2bwbH
         WHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756227877; x=1756832677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjIfaOrofazhAWITCaBIQC/PYR7khvFmaUUyG7Ja/eo=;
        b=Camavjb+uKK8QpTCMH/VO9VG3b9FDn5cEhIiBws5/NZqoMQltq21GDWKmDmYQFViR2
         tg9aVip2xOQbE5wBk6eTztbzCgIgjToJYIsbtrfqYSirwT9FqkYnZe7YhZptayOq/Han
         vXR8DMW/M3WjA8okFFK23jno1rK8HhyxPt3HDtXTBLe7xGV7kjsDaP7xo/EWI5rGai2O
         jZ9e7uRqamjleF4jT5cSOMxETh0xpZRJLTE32UVJICgNzCj79FRpHGTRsVy/0Af6c/1V
         ngCr3hVUyMH1tmguP1xVuJ6UbxaZAYI0L8ds1uFpSfPBk02Z+Q9w67INafDQ6+aSmc0O
         Cc5g==
X-Forwarded-Encrypted: i=1; AJvYcCW30DuTT0uKU9jmS/YqGymmRtN+SbZ7Cj2UlYYLcsY3dvGDdDyIZ3ezACp0wno24k0s8pDOq/1A2UYdFgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7EuRUdbILRMlLSpPzKBvhq21N8mT0x/ihVWWEp5bP3UJX80mS
	B0gxSoYIHcYw7xS5GVzk7X0RDwaxfkEFcRIdFp06qQjqsexXyKt/WRJ3Ff9bTUurqhPAG8eES2U
	DretYqTxuqyXXolA2GRLEDSiID0Y6S4PRKaGRUqo/eQ==
X-Gm-Gg: ASbGncuiLL05CE1ZjSl77gB3IPUqkLvbM79W8+YmXZPsfrlV1KjoZcF34pJkgsl+gLE
	eRJftjHG8PP5+Mx7Gphoe5cznCtAF8t5at1WDisLL1irJ2FZL81J3dXTNaI69xS1Y+aUEhJ6FhP
	RRiU+WOi3Y4Xlh0Uc0GkcGYHpxMaHC8P1fU8LdXzeMur9rYTVLLDvVH3l7KB7UU+nK5/4ds8ETx
	YXIGmteLM+mccA=
X-Google-Smtp-Source: AGHT+IGhz39NCK5Fxfc9IjxwgHAO3YphwmnNvrOuu/ULmHzST7LVx0PTJH1sOUstAe48pYCpPqjEksP24bvYcCphrNY=
X-Received: by 2002:a05:622a:1213:b0:4b2:edd6:f1a2 with SMTP id
 d75a77b69052e-4b2edd6f516mr4884241cf.63.1756227876536; Tue, 26 Aug 2025
 10:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
 <mafs0ms7mxly1.fsf@kernel.org> <CA+CK2bBoLi9tYWHSFyDEHWd_cwvS_hR4q2HMmg-C+SJpQDNs=g@mail.gmail.com>
 <20250826142406.GE1970008@nvidia.com> <CA+CK2bBrCd8t_BUeE-sVPGjsJwmtk3mCSVhTMGbseTi_Wk+4yQ@mail.gmail.com>
 <20250826151327.GA2130239@nvidia.com> <CA+CK2bAbqMb0ZYvsC9tsf6w5myfUyqo3N4fUP3CwVA_kUDQteg@mail.gmail.com>
 <20250826162203.GE2130239@nvidia.com>
In-Reply-To: <20250826162203.GE2130239@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Aug 2025 17:03:59 +0000
X-Gm-Features: Ac12FXz3lP2hDCkW5MtqBiPoAwifNenh5414D4bEhipE2lcPWQY4sTh__rhBUIU
Message-ID: <CA+CK2bB9r_pMzd0VbLsAGTwh8kvV_o3rFM_W--drutewomr1ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Live Update Orchestrator
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> > The existing interface, with the addition of passing a pidfd, provides
> > the necessary flexibility without being invasive. The change would be
> > localized to the new code that performs the FD retrieval and wouldn't
> > involve spoofing current or making widespread changes.
> > For example, to handle cgroup charging for a memfd, the flow inside
> > memfd_luo_retrieve() would look something like this:
> >
> > task = get_pid_task(target_pid, PIDTYPE_PID);
> > mm = get_task_mm(task);
> >     // ...
> >     folio = kho_restore_folio(phys);
> >     // Charge to the target mm, not 'current->mm'
> >     mem_cgroup_charge(folio, mm, ...);
> > mmput(mm);
> > put_task_struct(task);
>
> Execpt it doesn't work like that in all places, iommufd for example
> uses GFP_KERNEL_ACCOUNT which relies on current.

That's a good point. For kernel allocations, I don't see a clean way
to account for a different process.

We should not be doing major allocations during the retrieval process
itself. Ideally, the kernel would restore an FD using only the
preserved folio data (that we can cleanly charge), and then let the
user process perform any subsequent actions that might cause new
kernel memory allocations. However, I can see how that might not be
practical for all handlers.

Perhaps, we should add session extensions to the kernel as follow-up
after this series lands, we would also need to rewrite luod design
accordingly to move some of the sessions logic into the kernel.

Thank you,
Pasha

