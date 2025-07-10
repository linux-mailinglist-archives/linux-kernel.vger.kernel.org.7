Return-Path: <linux-kernel+bounces-726134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A973B0089B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686141CA0B62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0F2F0C49;
	Thu, 10 Jul 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eB7P6HKp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25A2F0055
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164868; cv=none; b=SyeVB2rrvrraAzT5GbWpqyAmBMfQVBLwo1TzFXiXz+mJ1PEj/w9fbtJwgNyZfX/ungp89dqlTUE17mQtGsnyfxG8FHWB9338DeT1goNz51cSLMpbfX4T4pvZffA0DiC8JS99JWpmjxGviCQHWWsFci53E90OXT5utCGivXnmngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164868; c=relaxed/simple;
	bh=xQIpiz5lD/bls3IWf/AfloR32mzM7DVpFPfsrt6iToY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8byL7OXXlpccYznbkGTmVEs9753AinCi2leSHupNDTb/kktx2yM/B4I+lNYC0lXwdXUEWZu1G33TvOn+YHPQ2GHtyB8gOV4pf+v2uwyWxHEI4u+0zwwLZtwSptOPfcm21wnlyuVnULRXGPiK2RdoXAXIAkHtfZgSnuZuC+vmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eB7P6HKp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so833213f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752164864; x=1752769664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84FdCvCUSgXKena4hhKXlV6cX3eSmuEG5N2VfDQNd40=;
        b=eB7P6HKpryP51dlEx1rPVlihVNN9JqRAFfQCJNolDd2Nu1IVgk9zQdmei100UN14Zf
         2dSwT43bA8OK/9x29O2hZV1gkHUhrkqj7e7cbfVCVWehCnIPpnU8HYCitQBzGFI2HnwV
         s7N5IkoZNKTv7mxkIO/da9NZHETmMXFVvvlk4XsJBUzR0DSPhYCwDQm++LJL8Ebziw13
         9dUsTlKD4jF2aw+Me5DfhkekStfg+Jwo1DxaazXGZ+L0SLDUcH0qFAACAc7rdDROA0FA
         mN30OLFKp+yBauwDgcMpxsQYUI08Cwd5APXYfvdk4eaGQYF0yHsEjDYyVOoFYgI2NADs
         isnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164864; x=1752769664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84FdCvCUSgXKena4hhKXlV6cX3eSmuEG5N2VfDQNd40=;
        b=eLRwzLAg0P8rlazUfp0TmCA3am2qztHZ8APg665Cs5su5/Tw+p/T9AWLBlS9AUbzVJ
         fknaXSTV8b9jiuP4leFh+OmDDIwSULOTKjYRZjzNR9m/lGXJJni5EhTKxskOdhGT9wiT
         VNJ3uaDZV90Y4nskcuPVyc9qesbK01zivPEdXU7es1V6232hbTidxnvXOvYxOCX8SxzF
         3jek51TaTY1/p+1brwiMj0o/buO/TT3nLUDl0AWAKITEd2dK8lUBbBnHuplECSZ+kWnG
         QdFdsqxVpA5D8J9N/JsydLbcmSV2YEpBoWouiampBOZZx+UwPKeef0SyXDLlAUy+yJmF
         NqRA==
X-Forwarded-Encrypted: i=1; AJvYcCVGVkSUZjAzq+IS2Vf908Y0jGwK197Q5eX/lg4iJYliNvbQtfkVBDSl0hnu1q94DTAjWFBtpdLGcBo9XlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuXM0TVyFBOMaB/shzIMT1q6Z0wFaJ80iGus0ZeUtxtJJiSNO
	rq1KAIHM+9uXYCmw+RFaMrPJRb5kIknfiFF51MN8lmFCNApT9YAp8liO/OmQkgn/Muo=
X-Gm-Gg: ASbGnctn+2dZaBbXcJuhowEN9gOnUB6sTLlaBHk6q2iD07XYyHNngsYmBOI7a8RJDjk
	RH8QCwZyO5QLauoOUhkNS2aO8p6YTfYSNayzujoUJ1zK6vavCvTwgKAYmu4BQ1jZK7bQL0ATzLP
	j0DxntP8TSx7ur4aMgHXGFwLGK7Zm0etnWPLE1manN/WPq32UJ4Q7HPMwqdHANm21KeQBowjBZ0
	zY3cuC+B1PtPmYulfGFaiGQQl9FZh4/oFcsrRp1sA/FsmSWnag/xJhaC6O16yf/dsB3aMTsLaQe
	zcYRlpS52eMvZpt0Rm9BWz9uBS2ckJU7V1AfEyj4wIo01B/2Z8706mRAvGuFop3D
X-Google-Smtp-Source: AGHT+IFs11u8p4/tfESn0TofvkX8RnO+CDmIMzUtaw9WFnRpsa5dKBjmjRbsOWgYvAmRfAqPxRF0aQ==
X-Received: by 2002:a05:6000:d46:b0:3a4:f90c:31e3 with SMTP id ffacd0b85a97d-3b5f18ceb8emr159822f8f.31.1752164863850;
        Thu, 10 Jul 2025 09:27:43 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm2312030f8f.39.2025.07.10.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:27:43 -0700 (PDT)
Date: Thu, 10 Jul 2025 18:27:41 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: syzbot <syzbot+f3188428a0ed36870056@syzkaller.appspotmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: [syzbot] [cgroups?] KCSAN: data-race in cgroup_migrate_execute /
 memcpy_and_pad
Message-ID: <wuoepqhwfz3akami7wigstoszqhmb6t5tflnso47kedxrtg23m@qofn6qxq3tyn>
References: <686bb62b.a00a0220.c7b3.0083.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sazofghkbejx3flo"
Content-Disposition: inline
In-Reply-To: <686bb62b.a00a0220.c7b3.0083.GAE@google.com>


--sazofghkbejx3flo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot] [cgroups?] KCSAN: data-race in cgroup_migrate_execute /
 memcpy_and_pad
MIME-Version: 1.0

On Mon, Jul 07, 2025 at 04:57:31AM -0700, syzbot <syzbot+f3188428a0ed368700=
56@syzkaller.appspotmail.com> wrote:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in cgroup_migrate_execute / memcpy_and_pad
>=20
> write to 0xffff888133646ad0 of 8 bytes by task 4554 on cpu 1:
>  __list_splice include/linux/list.h:533 [inline]
>  list_splice_tail_init include/linux/list.h:589 [inline]
>  cgroup_migrate_execute+0x6b5/0x7f0 kernel/cgroup/cgroup.c:2689
>  cgroup_update_dfl_csses kernel/cgroup/cgroup.c:3135 [inline]
>  cgroup_apply_control+0x3ab/0x410 kernel/cgroup/cgroup.c:3375
>  cgroup_subtree_control_write+0x7d5/0xb80 kernel/cgroup/cgroup.c:3520
>  cgroup_file_write+0x194/0x350 kernel/cgroup/cgroup.c:4183
>  kernfs_fop_write_iter+0x1be/0x2d0 fs/kernfs/file.c:334
>  new_sync_write fs/read_write.c:593 [inline]
>  vfs_write+0x49d/0x8e0 fs/read_write.c:686
>  ksys_write+0xda/0x1a0 fs/read_write.c:738
>  __do_sys_write fs/read_write.c:749 [inline]
>  __se_sys_write fs/read_write.c:746 [inline]
>  __x64_sys_write+0x40/0x50 fs/read_write.c:746
>  x64_sys_call+0x2cdd/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:2
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> read to 0xffff888133646180 of 3200 bytes by task 4561 on cpu 0:
>  memcpy_and_pad+0x48/0x80 lib/string_helpers.c:1007
>  arch_dup_task_struct+0x2c/0x40 arch/x86/kernel/process.c:98
>  dup_task_struct+0x83/0x6a0 kernel/fork.c:873
>  copy_process+0x399/0x1f90 kernel/fork.c:1999
>  kernel_clone+0x16c/0x5b0 kernel/fork.c:2599
>  __do_sys_clone3 kernel/fork.c:2903 [inline]
>  __se_sys_clone3+0x1c2/0x200 kernel/fork.c:2882
>  __x64_sys_clone3+0x31/0x40 kernel/fork.c:2882
>  x64_sys_call+0x10c9/0x2fb0 arch/x86/include/generated/asm/syscalls_64.h:=
436
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xd2/0x200 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I assume the data race on parent->cg_list (not child->cg_list because
the parent is read).
The clone vs migration should be synchronized via
cgroup_threadgroup_rwsem but there's a window for the race:

	copy_process
	  dup_task_struct
	    child->cg_list =3D parent->cg_list
	  ...
	  [race window]
	  ...
	  cgroup_can_fork
	    cgroup_css_set_fork
	      cgroup_threadgroup_change_begin

	  ...
	  cgroup_post_fork
	    css_set_move_task
	      list_del_init(&child->cg_list);
	      list_add_tail(&child->cg_list, cset->tasks)
	    cgroup_threadgroup_change_end

The writer is
	list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
i.e. the parent is either migrated itself or it's the last (tail) task
in destination css_set of another migration.

But whatever value child copied over from parent doesn't matter because
it is overwritten when the child is inserted into appropriate cset in
cgroup_post_fork (properly synced via css_set_lock).

I.e. I'm not overexcited about this race but thanks syzbot.

Michal

--sazofghkbejx3flo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaG/p+wAKCRB+PQLnlNv4
CFczAP9TRMw8SYi0RTuaICD3vnEOgvpuKn4/ETEwcN5XzzrYBwD+KXSs6XP9qIqG
TRU8dEKWB8/hs3fx7rrjRWxTWy8mSAQ=
=FFot
-----END PGP SIGNATURE-----

--sazofghkbejx3flo--

