Return-Path: <linux-kernel+bounces-692836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4180ADF778
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 22:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FE93A9B04
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004621A452;
	Wed, 18 Jun 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh9gVp5H"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E2204F8B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277370; cv=none; b=nUKiuQLSk0VSVB5u503xPo0xMj5rQqU3hsUsGk+vgPdsO7tM1LHojEfUt19384DWAFscLPfVTVfdoyPi6PljUTynOv3Ev/AQC05b7pbvludd8QslWtrPafDzNdItNyqgIrDlnwglb006zGBN7KSlQGSoE6lAkPtxEb8330yVpsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277370; c=relaxed/simple;
	bh=2J49yz9pNcE72b5D5TolQtAZvZxmITB02ykRWrNL3aw=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=la6ql6AvFVbIt5PrzValMvKNbhRIiALaxh/Q1YM3kEKaNvoq8dxEsXG4X6OIhZuk32y+mFg942OrCLODW+ssuAgqb1Re7tkhhE0SdMlWq70ha1ajL2mijgHAYtyOq9VFmMZPQq8vQhMYS3I2JNzXH9blToBdK6QzL/2oG8UXAQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh9gVp5H; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-237311f5a54so1071155ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750277368; x=1750882168; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pUV4FJeLCWEp1Wa197m5XGgB+0bBh+FGeQM/nio3iG0=;
        b=Rh9gVp5H1zuqwsUbhYQkxUFUOk/zLstIQ0s3vG+UaEerBa9IdewYS7v+6kzaIBc2te
         DyCWSuVsYtedW2VvazCI7dB5ymONr4GcMFe6CVGVkx1J3y5I0DQP1gIjPg9m1cv6Dc+v
         4YJJU0VadmVJnmt6vXJG6Z3+mdUmmXP6WWF/ShCkLKky4GZ6NoP417uz8D+bFCMKZM3X
         UcpBhw1V6kMCEAgtSw4kqTMtVTSLW+REHDtoIa4amPr3w+iZ5rkM017lmekyD62Nb3jW
         cYBdWDcyb1ey9CBsJVNq9QSMcuv+GEqW+SrIQfiYubgGRDm69NjeTXvM6jqROAFftSBY
         flJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277368; x=1750882168;
        h=to:cc:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUV4FJeLCWEp1Wa197m5XGgB+0bBh+FGeQM/nio3iG0=;
        b=N+Rx6iWdaf0xdv3nmm6yK9m42z9341/zZCh1vFu7vOxeXBe60DBWUTXYN1qQjE7WXK
         7ytOjdaziGODFUPSEwW9myRugUg9vNSwhAaAzKKLlcbAETLp2x4yaeRyBKPboJD49bso
         h4YXywsh2pgCtzcKUio3hK+SIBCcDoDrKNAC0Vw1QccMACUYl0p0mJfKHYVnG1C4a1Rw
         WoSs13UxyqP2Zat4cC2naDxLLXsgZS3tOVMVMsxyjQHYX0SVhfINy1nsa/tSvHyGq2BJ
         rAeScfz/EZKZhERkV2Rqb9K41Mzx5TRVm3zQTwwZPH4cj/65kmuMlOBmsRD5bLEPp+Ox
         hrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT1quwRFasc/j2usa+7WzkdjXgDuNgWUbQy3NzBIg6jSbC1Gb0vPHwmhersM0Q8Ur8lSnT7KUFV83U8fI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTO3MsJ6a2LDCPMvwkQYnAwUBO3dAMN3H9Vt0CaZCm3kUBru9
	CQSC9iBHmFrxINJCVpIrzzwAG8pu/ca4IZZilBdd4kSYQwM6Xs9/a7DH
X-Gm-Gg: ASbGnctRQKdQhWzgqaq497jD9vj8NsecvYEpt3ti0ZNGHUbL2NjPAuTKuIPENih9g/y
	FJWbXiSTWfpnw/AscQrGkuWYtRZIwbI4BGhJEk66P2FFThGMmWlffo94FJelzYU4rpfioZtBEdE
	mAGAzW7tNvlPl2ZCr8KdxYoXsG4Z0x2J9YS0ABkH+hKkL3KYlmvaMVO3F+tj+D8txZvUNBADBlD
	kQiOEicVQ6eYi45tw1Vz/zMFMPCH1cGaRwaxibdeCN9iFN5Ff+PFfQEOef44N0iWtgWoyaJbtRO
	P1enHJ1e87yp4xuFzoxv93JrUWVwI6f4h8XE/T+i+JiMw8n5c7Qa9nqpbnIWzBQCyw==
X-Google-Smtp-Source: AGHT+IE4uHGe9Iy1CaVo1qm2Bffavn7dLXIcsKdpFm3jkO7PZSpM9dMx3PMcdmwDYaSPw6JiiUGjBw==
X-Received: by 2002:a17:903:228a:b0:235:1962:1bf4 with SMTP id d9443c01a7336-2366b32ce3amr291073365ad.14.1750277367851;
        Wed, 18 Jun 2025 13:09:27 -0700 (PDT)
Received: from smtpclient.apple ([2a05:dfc1:8bc4:feda::11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a32bc0csm414153a91.42.2025.06.18.13.09.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2025 13:09:27 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: [PATCH v0 00/13] [RFC] sched: Add more Scope-based Resource
 Management Support
Message-Id: <406C7288-E330-46D3-94A6-F42FB828F613@gmail.com>
Date: Thu, 19 Jun 2025 04:09:08 +0800
Cc: Jemmy <jemmywong512@gmail.com>
To: mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 rafael@kernel.org,
 viresh.kumar@linaro.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 peterz@infradead.org,
 hannes@cmpxchg.org,
 surenb@google.com,
 linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)


--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0000-cover-letter.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0000-cover-letter.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=200dc6cbb0bd06fe2c29999b7c6b3c2206b612d1fa=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Thu,=2019=20Jun=202025=2003:28:50=20+0800=0ASubject:=20[PATCH=20=
v0=2000/13]=20[RFC]=20sched:=20Add=20more=20Scope-based=20Resource=20=
Management=20Support=0A=0AHi,=0A=0AI=20greatly=20admire=20the=20=
Scope-based=20Resource=20Management=20infrastructure=0Aas=20it=20=
elegantly=20aligns=20with=20the=20Resource=20Acquisition=20Is=20=
Initialization=20(RAII)=0Aprogramming=20idiom,=20improving=20code=20=
safety=20and=20maintainability.=0A=0AI=20am=20interested=20in=20driving=20=
a=20comprehensive=20conversion=20of=20traditional=0Amanual=20lock/unlock=20=
patterns=20to=20use=20guard/scoped_guard,=0Astarting=20with=20the=20=
sched=20module.=0A=0ABefore=20proceeding,=20I=E2=80=99d=20like=20to=20=
confirm=20if=20you=20believe=0Athis=20effort=20is=20valuable=20and=20=
whether=20you=E2=80=99d=20support=20such=20a=20conversion.=0A=0ABest,=0A=
Jemmy=0A=0AJemmy=20Wong=20(13):=0A=20=20sched/completion:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/dealine:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/psi:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/cpuacct:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/syscalls:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/core_sched:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/cpudeadline:=20Scope-based=20=
Resource=20Management=20Support=0A=20=20sched/cpufreq_schedutil:=20=
Scope-based=20Resource=20Management=20Support=0A=20=20sched/cputime:=20=
Scope-based=20Resource=20Management=20Support=0A=20=20sched/stats:=20=
Scope-based=20Resource=20Management=20Support=0A=20=20sched/wait:=20=
Scope-based=20Resource=20Management=20Support=0A=20=20sched/swait:=20=
Scope-based=20Resource=20Management=20Support=0A=20=20sched/ext_idle:=20=
Scope-based=20Resource=20Management=20Support=0A=0A=20=
include/linux/completion.h=20=20=20=20=20=20=20|=20=20=204=20++=0A=20=
include/linux/rcupdate.h=20=20=20=20=20=20=20=20=20|=20=20=204=20++=0A=20=
kernel/sched/completion.c=20=20=20=20=20=20=20=20|=20=2032=20+++------=0A=
=20kernel/sched/core_sched.c=20=20=20=20=20=20=20=20|=20=2030=20++++----=0A=
=20kernel/sched/cpuacct.c=20=20=20=20=20=20=20=20=20=20=20|=20=2012=20=
+---=0A=20kernel/sched/cpudeadline.c=20=20=20=20=20=20=20|=20=20=209=20=
+--=0A=20kernel/sched/cpufreq_schedutil.c=20|=20=2041=20+++++------=0A=20=
kernel/sched/cputime.c=20=20=20=20=20=20=20=20=20=20=20|=20=2039=20=
+++++------=0A=20kernel/sched/deadline.c=20=20=20=20=20=20=20=20=20=20|=20=
114=20+++++++++++++------------------=0A=20kernel/sched/ext_idle.c=20=20=20=
=20=20=20=20=20=20=20|=20=2029=20++++----=0A=20kernel/sched/psi.c=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20|=20=2071=20++++++-------------=0A=20=
kernel/sched/sched.h=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=2014=20=
+---=0A=20kernel/sched/stats.c=20=20=20=20=20=20=20=20=20=20=20=20=20|=20=
=20=203=20+-=0A=20kernel/sched/swait.c=20=20=20=20=20=20=20=20=20=20=20=20=
=20|=20=2029=20+++-----=0A=20kernel/sched/syscalls.c=20=20=20=20=20=20=20=
=20=20=20|=20=20=204=20+-=0A=20kernel/sched/wait.c=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20|=20=2043=20+++---------=0A=2016=20files=20changed,=20=
171=20insertions(+),=20307=20deletions(-)=0A=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0001-sched-completion-Scope-based-Resource-Management-.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0001-sched-completion-Scope-based-Resource-Management-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2044681a9c8dea41c8b765158e850ef08d7e6236ef=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:25:30=20+0800=0ASubject:=20[PATCH=20=
v0=2001/13]=20sched/completion:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
include/linux/completion.h=20|=20=204=20++++=0A=20=
kernel/sched/completion.c=20=20|=2032=20++++++++++----------------------=0A=
=202=20files=20changed,=2014=20insertions(+),=2022=20deletions(-)=0A=0A=
diff=20--git=20a/include/linux/completion.h=20=
b/include/linux/completion.h=0Aindex=20fb2915676574..fcd987b56fa0=20=
100644=0A---=20a/include/linux/completion.h=0A+++=20=
b/include/linux/completion.h=0A@@=20-32,6=20+32,10=20@@=20struct=20=
completion=20{=0A=20static=20inline=20void=20complete_acquire(struct=20=
completion=20*x)=20{}=0A=20static=20inline=20void=20=
complete_release(struct=20completion=20*x)=20{}=0A=0A=
+DEFINE_LOCK_GUARD_1(complete,=20struct=20completion,=0A+=09=
complete_acquire(_T->lock),=0A+=09complete_release(_T->lock))=0A+=0A=20=
#define=20COMPLETION_INITIALIZER(work)=20\=0A=20=09{=200,=20=
__SWAIT_QUEUE_HEAD_INITIALIZER((work).wait)=20}=0A=0Adiff=20--git=20=
a/kernel/sched/completion.c=20b/kernel/sched/completion.c=0Aindex=20=
3561ab533dd4..9d4efdce9d23=20100644=0A---=20a/kernel/sched/completion.c=0A=
+++=20b/kernel/sched/completion.c=0A@@=20-15,14=20+15,11=20@@=0A=0A=20=
static=20void=20complete_with_flags(struct=20completion=20*x,=20int=20=
wake_flags)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A-=09=
raw_spin_lock_irqsave(&x->wait.lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&x->wait.lock);=0A=0A=20=09if=20(x->done=20=
!=3D=20UINT_MAX)=0A=20=09=09x->done++;=0A=20=09swake_up_locked(&x->wait,=20=
wake_flags);=0A-=09raw_spin_unlock_irqrestore(&x->wait.lock,=20flags);=0A=
=20}=0A=0A=20void=20complete_on_current_cpu(struct=20completion=20*x)=0A=
@@=20-66,14=20+63,11=20@@=20EXPORT_SYMBOL(complete);=0A=20=20*/=0A=20=
void=20complete_all(struct=20completion=20*x)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A-=0A=20=09lockdep_assert_RT_in_threaded_ctx();=0A=0A-=09=
raw_spin_lock_irqsave(&x->wait.lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&x->wait.lock);=0A=20=09x->done=20=3D=20=
UINT_MAX;=0A=20=09swake_up_all_locked(&x->wait);=0A-=09=
raw_spin_unlock_irqrestore(&x->wait.lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(complete_all);=0A=0A@@=20-110,13=20+104,10=20@@=20=
__wait_for_common(struct=20completion=20*x,=0A=20{=0A=20=09=
might_sleep();=0A=0A-=09complete_acquire(x);=0A-=0A-=09=
raw_spin_lock_irq(&x->wait.lock);=0A-=09timeout=20=3D=20=
do_wait_for_common(x,=20action,=20timeout,=20state);=0A-=09=
raw_spin_unlock_irq(&x->wait.lock);=0A-=0A-=09complete_release(x);=0A+=09=
guard(complete)(x);=0A+=09scoped_guard(raw_spinlock_irq,=20=
&x->wait.lock)=20{=0A+=09=09timeout=20=3D=20do_wait_for_common(x,=20=
action,=20timeout,=20state);=0A+=09}=0A=0A=20=09return=20timeout;=0A=20}=0A=
@@=20-303,7=20+294,6=20@@=20=
EXPORT_SYMBOL(wait_for_completion_killable_timeout);=0A=20=20*/=0A=20=
bool=20try_wait_for_completion(struct=20completion=20*x)=0A=20{=0A-=09=
unsigned=20long=20flags;=0A=20=09bool=20ret=20=3D=20true;=0A=0A=20=09/*=0A=
@@=20-315,12=20+305,12=20@@=20bool=20try_wait_for_completion(struct=20=
completion=20*x)=0A=20=09if=20(!READ_ONCE(x->done))=0A=20=09=09return=20=
false;=0A=0A-=09raw_spin_lock_irqsave(&x->wait.lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&x->wait.lock);=0A=20=09if=20(!x->done)=0A=20=
=09=09ret=20=3D=20false;=0A=20=09else=20if=20(x->done=20!=3D=20UINT_MAX)=0A=
=20=09=09x->done--;=0A-=09raw_spin_unlock_irqrestore(&x->wait.lock,=20=
flags);=0A+=0A=20=09return=20ret;=0A=20}=0A=20=
EXPORT_SYMBOL(try_wait_for_completion);=0A@@=20-336,8=20+326,6=20@@=20=
EXPORT_SYMBOL(try_wait_for_completion);=0A=20=20*/=0A=20bool=20=
completion_done(struct=20completion=20*x)=0A=20{=0A-=09unsigned=20long=20=
flags;=0A-=0A=20=09if=20(!READ_ONCE(x->done))=0A=20=09=09return=20false;=0A=
=0A@@=20-346,8=20+334,8=20@@=20bool=20completion_done(struct=20=
completion=20*x)=0A=20=09=20*=20otherwise=20we=20can=20end=20up=20=
freeing=20the=20completion=20before=20complete()=0A=20=09=20*=20is=20=
done=20referencing=20it.=0A=20=09=20*/=0A-=09=
raw_spin_lock_irqsave(&x->wait.lock,=20flags);=0A-=09=
raw_spin_unlock_irqrestore(&x->wait.lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&x->wait.lock);=0A+=0A=20=09return=20true;=0A=
=20}=0A=20EXPORT_SYMBOL(completion_done);=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0002-sched-dealine-Scope-based-Resource-Management-Sup.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0002-sched-dealine-Scope-based-Resource-Management-Sup.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2035cdf70828f8b9f9eee819c7b19846e67fe12100=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:26:00=20+0800=0ASubject:=20[PATCH=20=
v0=2002/13]=20sched/dealine:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
include/linux/rcupdate.h=20|=20=20=204=20++=0A=20kernel/sched/deadline.c=20=
=20|=20114=20++++++++++++++++-----------------------=0A=202=20files=20=
changed,=2050=20insertions(+),=2068=20deletions(-)=0A=0Adiff=20--git=20=
a/include/linux/rcupdate.h=20b/include/linux/rcupdate.h=0Aindex=20=
120536f4c6eb..b1aacdb89886=20100644=0A---=20a/include/linux/rcupdate.h=0A=
+++=20b/include/linux/rcupdate.h=0A@@=20-1166,4=20+1166,8=20@@=20=
DEFINE_LOCK_GUARD_0(rcu,=0A=20=09}=20while=20(0),=0A=20=09=
rcu_read_unlock())=0A=0A+DEFINE_LOCK_GUARD_0(rcu_read_lock_sched,=0A+=09=
rcu_read_lock_sched(),=0A+=09rcu_read_unlock_sched())=0A+=0A=20#endif=20=
/*=20__LINUX_RCUPDATE_H=20*/=0Adiff=20--git=20a/kernel/sched/deadline.c=20=
b/kernel/sched/deadline.c=0Aindex=20ad45a8fea245..21c0f32726c2=20100644=0A=
---=20a/kernel/sched/deadline.c=0A+++=20b/kernel/sched/deadline.c=0A@@=20=
-478,9=20+478,9=20@@=20static=20void=20task_non_contending(struct=20=
sched_dl_entity=20*dl_se)=0A=0A=20=09=09=09=09if=20=
(READ_ONCE(p->__state)=20=3D=3D=20TASK_DEAD)=0A=20=09=09=09=09=09=
sub_rq_bw(dl_se,=20&rq->dl);=0A-=09=09=09=09raw_spin_lock(&dl_b->lock);=0A=
-=09=09=09=09__dl_sub(dl_b,=20dl_se->dl_bw,=20dl_bw_cpus(task_cpu(p)));=0A=
-=09=09=09=09raw_spin_unlock(&dl_b->lock);=0A+=09=09=09=09=
scoped_guard(raw_spinlock,=20&dl_b->lock)=20{=0A+=09=09=09=09=09=
__dl_sub(dl_b,=20dl_se->dl_bw,=20dl_bw_cpus(task_cpu(p)));=0A+=09=09=09=09=
}=0A=20=09=09=09=09__dl_clear_params(dl_se);=0A=20=09=09=09}=0A=20=09=09=
}=0A@@=20-738,14=20+738,14=20@@=20static=20struct=20rq=20=
*dl_task_offline_migration(struct=20rq=20*rq,=20struct=20task_struct=20=
*p=0A=20=09=20*=20domain.=0A=20=09=20*/=0A=20=09dl_b=20=3D=20=
&rq->rd->dl_bw;=0A-=09raw_spin_lock(&dl_b->lock);=0A-=09__dl_sub(dl_b,=20=
p->dl.dl_bw,=20cpumask_weight(rq->rd->span));=0A-=09=
raw_spin_unlock(&dl_b->lock);=0A+=09scoped_guard(raw_spinlock,=20=
&dl_b->lock)=20{=0A+=09=09__dl_sub(dl_b,=20p->dl.dl_bw,=20=
cpumask_weight(rq->rd->span));=0A+=09}=0A=0A=20=09dl_b=20=3D=20=
&later_rq->rd->dl_bw;=0A-=09raw_spin_lock(&dl_b->lock);=0A-=09=
__dl_add(dl_b,=20p->dl.dl_bw,=20cpumask_weight(later_rq->rd->span));=0A-=09=
raw_spin_unlock(&dl_b->lock);=0A+=09scoped_guard(raw_spinlock,=20=
&dl_b->lock)=20{=0A+=09=09__dl_add(dl_b,=20p->dl.dl_bw,=20=
cpumask_weight(later_rq->rd->span));=0A+=09}=0A=0A=20=09set_task_cpu(p,=20=
later_rq->cpu);=0A=20=09double_unlock_balance(later_rq,=20rq);=0A@@=20=
-1588,7=20+1588,7=20@@=20static=20void=20update_curr_dl_se(struct=20rq=20=
*rq,=20struct=20sched_dl_entity=20*dl_se,=20s64=0A=20=09if=20=
(rt_bandwidth_enabled())=20{=0A=20=09=09struct=20rt_rq=20*rt_rq=20=3D=20=
&rq->rt;=0A=0A-=09=09raw_spin_lock(&rt_rq->rt_runtime_lock);=0A+=09=09=
guard(raw_spinlock)(&rt_rq->rt_runtime_lock);=0A=20=09=09/*=0A=20=09=09=20=
*=20We'll=20let=20actual=20RT=20tasks=20worry=20about=20the=20overflow=20=
here,=20we=0A=20=09=09=20*=20have=20our=20own=20CBS=20to=20keep=20us=20=
inline;=20only=20account=20when=20RT=0A@@=20-1596,7=20+1596,6=20@@=20=
static=20void=20update_curr_dl_se(struct=20rq=20*rq,=20struct=20=
sched_dl_entity=20*dl_se,=20s64=0A=20=09=09=20*/=0A=20=09=09if=20=
(sched_rt_bandwidth_account(rt_rq))=0A=20=09=09=09rt_rq->rt_time=20+=3D=20=
delta_exec;=0A-=09=09raw_spin_unlock(&rt_rq->rt_runtime_lock);=0A=20=09}=0A=
=20#endif=0A=20}=0A@@=20-1808,9=20+1807,9=20@@=20static=20enum=20=
hrtimer_restart=20inactive_task_timer(struct=20hrtimer=20*timer)=0A=20=09=
=09=09dl_se->dl_non_contending=20=3D=200;=0A=20=09=09}=0A=0A-=09=09=
raw_spin_lock(&dl_b->lock);=0A-=09=09__dl_sub(dl_b,=20p->dl.dl_bw,=20=
dl_bw_cpus(task_cpu(p)));=0A-=09=09raw_spin_unlock(&dl_b->lock);=0A+=09=09=
scoped_guard(raw_spinlock,=20&dl_b->lock)=20{=0A+=09=09=09__dl_sub(dl_b,=20=
p->dl.dl_bw,=20dl_bw_cpus(task_cpu(p)));=0A+=09=09}=0A=20=09=09=
__dl_clear_params(dl_se);=0A=0A=20=09=09goto=20unlock;=0A@@=20-2234,11=20=
+2233,12=20@@=20select_task_rq_dl(struct=20task_struct=20*p,=20int=20=
cpu,=20int=20flags)=0A=20=09struct=20rq=20*rq;=0A=0A=20=09if=20(!(flags=20=
&=20WF_TTWU))=0A-=09=09goto=20out;=0A+=09=09return=20cpu;=0A=0A=20=09rq=20=
=3D=20cpu_rq(cpu);=0A=0A-=09rcu_read_lock();=0A+=09guard(rcu)();=0A+=0A=20=
=09curr=20=3D=20READ_ONCE(rq->curr);=20/*=20unlocked=20access=20*/=0A=20=09=
donor=20=3D=20READ_ONCE(rq->donor);=0A=0A@@=20-2270,15=20+2270,12=20@@=20=
select_task_rq_dl(struct=20task_struct=20*p,=20int=20cpu,=20int=20flags)=0A=
=20=09=09=20=20=20=20dl_task_is_earliest_deadline(p,=20cpu_rq(target)))=0A=
=20=09=09=09cpu=20=3D=20target;=0A=20=09}=0A-=09rcu_read_unlock();=0A=0A=
-out:=0A=20=09return=20cpu;=0A=20}=0A=0A=20static=20void=20=
migrate_task_rq_dl(struct=20task_struct=20*p,=20int=20new_cpu=20=
__maybe_unused)=0A=20{=0A-=09struct=20rq_flags=20rf;=0A=20=09struct=20rq=20=
*rq;=0A=0A=20=09if=20(READ_ONCE(p->__state)=20!=3D=20TASK_WAKING)=0A@@=20=
-2290,7=20+2287,7=20@@=20static=20void=20migrate_task_rq_dl(struct=20=
task_struct=20*p,=20int=20new_cpu=20__maybe_unused=0A=20=09=20*=20from=20=
try_to_wake_up().=20Hence,=20p->pi_lock=20is=20locked,=20but=0A=20=09=20=
*=20rq->lock=20is=20not...=20So,=20lock=20it=0A=20=09=20*/=0A-=09=
rq_lock(rq,=20&rf);=0A+=09guard(rq_lock)(rq);=0A=20=09if=20=
(p->dl.dl_non_contending)=20{=0A=20=09=09update_rq_clock(rq);=0A=20=09=09=
sub_running_bw(&p->dl,=20&rq->dl);=0A@@=20-2305,7=20+2302,6=20@@=20=
static=20void=20migrate_task_rq_dl(struct=20task_struct=20*p,=20int=20=
new_cpu=20__maybe_unused=0A=20=09=09cancel_inactive_timer(&p->dl);=0A=20=09=
}=0A=20=09sub_rq_bw(&p->dl,=20&rq->dl);=0A-=09rq_unlock(rq,=20&rf);=0A=20=
}=0A=0A=20static=20void=20check_preempt_equal_dl(struct=20rq=20*rq,=20=
struct=20task_struct=20*p)=0A@@=20-2574,7=20+2570,8=20@@=20static=20int=20=
find_later_rq(struct=20task_struct=20*task)=0A=20=09if=20=
(!cpumask_test_cpu(this_cpu,=20later_mask))=0A=20=09=09this_cpu=20=3D=20=
-1;=0A=0A-=09rcu_read_lock();=0A+=09guard(rcu)();=0A+=0A=20=09=
for_each_domain(cpu,=20sd)=20{=0A=20=09=09if=20(sd->flags=20&=20=
SD_WAKE_AFFINE)=20{=0A=20=09=09=09int=20best_cpu;=0A@@=20-2585,7=20=
+2582,6=20@@=20static=20int=20find_later_rq(struct=20task_struct=20=
*task)=0A=20=09=09=09=20*/=0A=20=09=09=09if=20(this_cpu=20!=3D=20-1=20&&=0A=
=20=09=09=09=20=20=20=20cpumask_test_cpu(this_cpu,=20=
sched_domain_span(sd)))=20{=0A-=09=09=09=09rcu_read_unlock();=0A=20=09=09=
=09=09return=20this_cpu;=0A=20=09=09=09}=0A=0A@@=20-2598,12=20+2594,10=20=
@@=20static=20int=20find_later_rq(struct=20task_struct=20*task)=0A=20=09=09=
=09=20*=20already=20under=20consideration=20through=20later_mask.=0A=20=09=
=09=09=20*/=0A=20=09=09=09if=20(best_cpu=20<=20nr_cpu_ids)=20{=0A-=09=09=09=
=09rcu_read_unlock();=0A=20=09=09=09=09return=20best_cpu;=0A=20=09=09=09=
}=0A=20=09=09}=0A=20=09}=0A-=09rcu_read_unlock();=0A=0A=20=09/*=0A=20=09=20=
*=20At=20this=20point,=20all=20our=20guesses=20failed,=20we=20just=20=
return=0A@@=20-2909,9=20+2903,8=20@@=20static=20void=20=
set_cpus_allowed_dl(struct=20task_struct=20*p,=0A=20=09=09=20*=20off.=20=
In=20the=20worst=20case,=20sched_setattr()=20may=20temporary=20fail=0A=20=
=09=09=20*=20until=20we=20complete=20the=20update.=0A=20=09=09=20*/=0A-=09=
=09raw_spin_lock(&src_dl_b->lock);=0A+=09=09=
guard(raw_spinlock)(&src_dl_b->lock);=0A=20=09=09__dl_sub(src_dl_b,=20=
p->dl.dl_bw,=20dl_bw_cpus(task_cpu(p)));=0A-=09=09=
raw_spin_unlock(&src_dl_b->lock);=0A=20=09}=0A=0A=20=09=
set_cpus_allowed_common(p,=20ctx);=0A@@=20-2962,11=20+2955,9=20@@=20void=20=
dl_add_task_root_domain(struct=20task_struct=20*p)=0A=20=09rq=20=3D=20=
__task_rq_lock(p,=20&rf);=0A=0A=20=09dl_b=20=3D=20&rq->rd->dl_bw;=0A-=09=
raw_spin_lock(&dl_b->lock);=0A-=0A-=09__dl_add(dl_b,=20p->dl.dl_bw,=20=
cpumask_weight(rq->rd->span));=0A-=0A-=09raw_spin_unlock(&dl_b->lock);=0A=
+=09scoped_guard(raw_spinlock,=20&dl_b->lock)=20{=0A+=09=09=
__dl_add(dl_b,=20p->dl.dl_bw,=20cpumask_weight(rq->rd->span));=0A+=09}=0A=
=0A=20=09task_rq_unlock(rq,=20p,=20&rf);=0A=20}=0A@@=20-3187,7=20+3178,6=20=
@@=20int=20sched_dl_global_validate(void)=0A=20=09u64=20cookie=20=3D=20=
++dl_cookie;=0A=20=09struct=20dl_bw=20*dl_b;=0A=20=09int=20cpu,=20cpus,=20=
ret=20=3D=200;=0A-=09unsigned=20long=20flags;=0A=0A=20=09/*=0A=20=09=20*=20=
Here=20we=20want=20to=20check=20the=20bandwidth=20not=20being=20set=20to=20=
some=0A@@=20-3195,24=20+3185,20=20@@=20int=20=
sched_dl_global_validate(void)=0A=20=09=20*=20any=20of=20the=20=
root_domains.=0A=20=09=20*/=0A=20=09for_each_online_cpu(cpu)=20{=0A-=09=09=
rcu_read_lock_sched();=0A+=09=09if=20(ret)=0A+=09=09=09break;=0A+=0A+=09=09=
guard(rcu_read_lock_sched)();=0A=0A=20=09=09if=20(dl_bw_visited(cpu,=20=
cookie))=0A-=09=09=09goto=20next;=0A+=09=09=09continue;=0A=0A=20=09=09=
dl_b=20=3D=20dl_bw_of(cpu);=0A=20=09=09cpus=20=3D=20dl_bw_cpus(cpu);=0A=0A=
-=09=09raw_spin_lock_irqsave(&dl_b->lock,=20flags);=0A+=09=09=
guard(raw_spinlock_irqsave)(&dl_b->lock);=0A=20=09=09if=20(new_bw=20*=20=
cpus=20<=20dl_b->total_bw)=0A=20=09=09=09ret=20=3D=20-EBUSY;=0A-=09=09=
raw_spin_unlock_irqrestore(&dl_b->lock,=20flags);=0A-=0A-next:=0A-=09=09=
rcu_read_unlock_sched();=0A-=0A-=09=09if=20(ret)=0A-=09=09=09break;=0A=20=
=09}=0A=0A=20=09return=20ret;=0A@@=20-3237,26=20+3223,21=20@@=20void=20=
sched_dl_do_global(void)=0A=20=09u64=20cookie=20=3D=20++dl_cookie;=0A=20=09=
struct=20dl_bw=20*dl_b;=0A=20=09int=20cpu;=0A-=09unsigned=20long=20=
flags;=0A=0A=20=09if=20(global_rt_runtime()=20!=3D=20RUNTIME_INF)=0A=20=09=
=09new_bw=20=3D=20to_ratio(global_rt_period(),=20global_rt_runtime());=0A=
=0A=20=09for_each_possible_cpu(cpu)=20{=0A-=09=09rcu_read_lock_sched();=0A=
-=0A-=09=09if=20(dl_bw_visited(cpu,=20cookie))=20{=0A-=09=09=09=
rcu_read_unlock_sched();=0A-=09=09=09continue;=0A-=09=09}=0A+=09=09=
scoped_guard(rcu_read_lock_sched)=20{=0A+=09=09=09if=20=
(dl_bw_visited(cpu,=20cookie))=0A+=09=09=09=09continue;=0A=0A-=09=09dl_b=20=
=3D=20dl_bw_of(cpu);=0A+=09=09=09dl_b=20=3D=20dl_bw_of(cpu);=0A=0A-=09=09=
raw_spin_lock_irqsave(&dl_b->lock,=20flags);=0A-=09=09dl_b->bw=20=3D=20=
new_bw;=0A-=09=09raw_spin_unlock_irqrestore(&dl_b->lock,=20flags);=0A+=09=
=09=09guard(raw_spinlock_irqsave)(&dl_b->lock);=0A+=09=09=09dl_b->bw=20=3D=
=20new_bw;=0A+=09=09}=0A=0A-=09=09rcu_read_unlock_sched();=0A=20=09=09=
init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);=0A=20=09}=0A=20}=0A@@=20-3291,7=20=
+3272,8=20@@=20int=20sched_dl_overflow(struct=20task_struct=20*p,=20int=20=
policy,=0A=20=09=20*=20its=20parameters,=20we=20may=20need=20to=20update=20=
accordingly=20the=20total=0A=20=09=20*=20allocated=20bandwidth=20of=20=
the=20container.=0A=20=09=20*/=0A-=09raw_spin_lock(&dl_b->lock);=0A+=09=
guard(raw_spinlock)(&dl_b->lock);=0A+=0A=20=09cpus=20=3D=20=
dl_bw_cpus(cpu);=0A=20=09cap=20=3D=20dl_bw_capacity(cpu);=0A=0A@@=20=
-3322,7=20+3304,6=20@@=20int=20sched_dl_overflow(struct=20task_struct=20=
*p,=20int=20policy,=0A=20=09=09=20*/=0A=20=09=09err=20=3D=200;=0A=20=09}=0A=
-=09raw_spin_unlock(&dl_b->lock);=0A=0A=20=09return=20err;=0A=20}=0A@@=20=
-3462,18=20+3443,17=20@@=20bool=20dl_param_changed(struct=20task_struct=20=
*p,=20const=20struct=20sched_attr=20*attr)=0A=20int=20=
dl_cpuset_cpumask_can_shrink(const=20struct=20cpumask=20*cur,=0A=20=09=09=
=09=09=20const=20struct=20cpumask=20*trial)=0A=20{=0A-=09unsigned=20long=20=
flags,=20cap;=0A+=09unsigned=20long=20cap;=0A=20=09struct=20dl_bw=20=
*cur_dl_b;=0A=20=09int=20ret=20=3D=201;=0A=0A-=09rcu_read_lock_sched();=0A=
+=09guard(rcu_read_lock_sched)();=0A=20=09cur_dl_b=20=3D=20=
dl_bw_of(cpumask_any(cur));=0A=20=09cap=20=3D=20__dl_bw_capacity(trial);=0A=
-=09raw_spin_lock_irqsave(&cur_dl_b->lock,=20flags);=0A+=0A+=09=
guard(raw_spinlock_irqsave)(&cur_dl_b->lock);=0A=20=09if=20=
(__dl_overflow(cur_dl_b,=20cap,=200,=200))=0A=20=09=09ret=20=3D=200;=0A-=09=
raw_spin_unlock_irqrestore(&cur_dl_b->lock,=20flags);=0A-=09=
rcu_read_unlock_sched();=0A=0A=20=09return=20ret;=0A=20}=0A@@=20-3486,14=20=
+3466,15=20@@=20enum=20dl_bw_request=20{=0A=0A=20static=20int=20=
dl_bw_manage(enum=20dl_bw_request=20req,=20int=20cpu,=20u64=20dl_bw)=0A=20=
{=0A-=09unsigned=20long=20flags,=20cap;=0A+=09unsigned=20long=20cap;=0A=20=
=09struct=20dl_bw=20*dl_b;=0A=20=09bool=20overflow=20=3D=200;=0A=20=09=
u64=20fair_server_bw=20=3D=200;=0A=0A-=09rcu_read_lock_sched();=0A+=09=
guard(rcu_read_lock_sched)();=0A+=0A=20=09dl_b=20=3D=20dl_bw_of(cpu);=0A=
-=09raw_spin_lock_irqsave(&dl_b->lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&dl_b->lock);=0A=0A=20=09cap=20=3D=20=
dl_bw_capacity(cpu);=0A=20=09switch=20(req)=20{=0A@@=20-3550,9=20+3531,6=20=
@@=20static=20int=20dl_bw_manage(enum=20dl_bw_request=20req,=20int=20=
cpu,=20u64=20dl_bw)=0A=20=09=09break;=0A=20=09}=0A=0A-=09=
raw_spin_unlock_irqrestore(&dl_b->lock,=20flags);=0A-=09=
rcu_read_unlock_sched();=0A-=0A=20=09return=20overflow=20?=20-EBUSY=20:=20=
0;=0A=20}=0A=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0003-sched-psi-Scope-based-Resource-Management-Support.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0003-sched-psi-Scope-based-Resource-Management-Support.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20314d093c8e6cc7e761092e1b5f038ed587e19a04=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:26:52=20+0800=0ASubject:=20[PATCH=20=
v0=2003/13]=20sched/psi:=20Scope-based=20Resource=20Management=20Support=0A=
=0AThis=20change=20replaces=20manual=20lock=20acquisition=20and=20=
release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20and=20=
reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0ASigned-off-by:=20=
Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20kernel/sched/psi.c=20=
=20=20|=2071=20+++++++++++++-------------------------------=0A=20=
kernel/sched/sched.h=20|=2014=20++-------=0A=202=20files=20changed,=2023=20=
insertions(+),=2062=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/psi.c=20b/kernel/sched/psi.c=0Aindex=20=
ad04a5c3162a..6b2a8f403d65=20100644=0A---=20a/kernel/sched/psi.c=0A+++=20=
b/kernel/sched/psi.c=0A@@=20-563,7=20+563,7=20@@=20static=20void=20=
psi_avgs_work(struct=20work_struct=20*work)=0A=20=09dwork=20=3D=20=
to_delayed_work(work);=0A=20=09group=20=3D=20container_of(dwork,=20=
struct=20psi_group,=20avgs_work);=0A=0A-=09=
mutex_lock(&group->avgs_lock);=0A+=09guard(mutex)(&group->avgs_lock);=0A=0A=
=20=09now=20=3D=20sched_clock();=0A=0A@@=20-584,8=20+584,6=20@@=20static=20=
void=20psi_avgs_work(struct=20work_struct=20*work)=0A=20=09=09=
schedule_delayed_work(dwork,=20nsecs_to_jiffies(=0A=20=09=09=09=09=
group->avg_next_update=20-=20now)=20+=201);=0A=20=09}=0A-=0A-=09=
mutex_unlock(&group->avgs_lock);=0A=20}=0A=0A=20static=20void=20=
init_rtpoll_triggers(struct=20psi_group=20*group,=20u64=20now)=0A@@=20=
-613,7=20+611,7=20@@=20static=20void=20psi_schedule_rtpoll_work(struct=20=
psi_group=20*group,=20unsigned=20long=20dela=0A=20=09if=20=
(atomic_xchg(&group->rtpoll_scheduled,=201)=20&&=20!force)=0A=20=09=09=
return;=0A=0A-=09rcu_read_lock();=0A+=09guard(rcu)();=0A=0A=20=09task=20=
=3D=20rcu_dereference(group->rtpoll_task);=0A=20=09/*=0A@@=20-624,8=20=
+622,6=20@@=20static=20void=20psi_schedule_rtpoll_work(struct=20=
psi_group=20*group,=20unsigned=20long=20dela=0A=20=09=09=
mod_timer(&group->rtpoll_timer,=20jiffies=20+=20delay);=0A=20=09else=0A=20=
=09=09atomic_set(&group->rtpoll_scheduled,=200);=0A-=0A-=09=
rcu_read_unlock();=0A=20}=0A=0A=20static=20void=20psi_rtpoll_work(struct=20=
psi_group=20*group)=0A@@=20-634,7=20+630,7=20@@=20static=20void=20=
psi_rtpoll_work(struct=20psi_group=20*group)=0A=20=09u32=20=
changed_states;=0A=20=09u64=20now;=0A=0A-=09=
mutex_lock(&group->rtpoll_trigger_lock);=0A+=09=
guard(mutex)(&group->rtpoll_trigger_lock);=0A=0A=20=09now=20=3D=20=
sched_clock();=0A=0A@@=20-693,7=20+689,7=20@@=20static=20void=20=
psi_rtpoll_work(struct=20psi_group=20*group)=0A=0A=20=09if=20(now=20>=20=
group->rtpoll_until)=20{=0A=20=09=09group->rtpoll_next_update=20=3D=20=
ULLONG_MAX;=0A-=09=09goto=20out;=0A+=09=09return;=0A=20=09}=0A=0A=20=09=
if=20(now=20>=3D=20group->rtpoll_next_update)=20{=0A@@=20-708,9=20+704,6=20=
@@=20static=20void=20psi_rtpoll_work(struct=20psi_group=20*group)=0A=20=09=
psi_schedule_rtpoll_work(group,=0A=20=09=09=
nsecs_to_jiffies(group->rtpoll_next_update=20-=20now)=20+=201,=0A=20=09=09=
force_reschedule);=0A-=0A-out:=0A-=09=
mutex_unlock(&group->rtpoll_trigger_lock);=0A=20}=0A=0A=20static=20int=20=
psi_rtpoll_worker(void=20*data)=0A@@=20-1046,9=20+1039,6=20@@=20void=20=
psi_account_irqtime(struct=20rq=20*rq,=20struct=20task_struct=20*curr,=20=
struct=20task_st=0A=20=20*/=0A=20void=20psi_memstall_enter(unsigned=20=
long=20*flags)=0A=20{=0A-=09struct=20rq_flags=20rf;=0A-=09struct=20rq=20=
*rq;=0A-=0A=20=09if=20(static_branch_likely(&psi_disabled))=0A=20=09=09=
return;=0A=0A@@=20-1060,12=20+1050,10=20@@=20void=20=
psi_memstall_enter(unsigned=20long=20*flags)=0A=20=09=20*=20changes=20to=20=
the=20task's=20scheduling=20state,=20otherwise=20we=20can=0A=20=09=20*=20=
race=20with=20CPU=20migration.=0A=20=09=20*/=0A-=09rq=20=3D=20=
this_rq_lock_irq(&rf);=0A+=09guard(rq_lock_irq)(this_rq());=0A=0A=20=09=
current->in_memstall=20=3D=201;=0A=20=09psi_task_change(current,=200,=20=
TSK_MEMSTALL=20|=20TSK_MEMSTALL_RUNNING);=0A-=0A-=09rq_unlock_irq(rq,=20=
&rf);=0A=20}=0A=20EXPORT_SYMBOL_GPL(psi_memstall_enter);=0A=0A@@=20=
-1077,9=20+1065,6=20@@=20EXPORT_SYMBOL_GPL(psi_memstall_enter);=0A=20=20=
*/=0A=20void=20psi_memstall_leave(unsigned=20long=20*flags)=0A=20{=0A-=09=
struct=20rq_flags=20rf;=0A-=09struct=20rq=20*rq;=0A-=0A=20=09if=20=
(static_branch_likely(&psi_disabled))=0A=20=09=09return;=0A=0A@@=20=
-1090,12=20+1075,10=20@@=20void=20psi_memstall_leave(unsigned=20long=20=
*flags)=0A=20=09=20*=20changes=20to=20the=20task's=20scheduling=20state,=20=
otherwise=20we=20could=0A=20=09=20*=20race=20with=20CPU=20migration.=0A=20=
=09=20*/=0A-=09rq=20=3D=20this_rq_lock_irq(&rf);=0A+=09=
guard(rq_lock_irq)(this_rq());=0A=0A=20=09current->in_memstall=20=3D=20=
0;=0A=20=09psi_task_change(current,=20TSK_MEMSTALL=20|=20=
TSK_MEMSTALL_RUNNING,=200);=0A-=0A-=09rq_unlock_irq(rq,=20&rf);=0A=20}=0A=
=20EXPORT_SYMBOL_GPL(psi_memstall_leave);=0A=0A@@=20-1146,7=20+1129,6=20=
@@=20void=20psi_cgroup_free(struct=20cgroup=20*cgroup)=0A=20void=20=
cgroup_move_task(struct=20task_struct=20*task,=20struct=20css_set=20*to)=0A=
=20{=0A=20=09unsigned=20int=20task_flags;=0A-=09struct=20rq_flags=20rf;=0A=
=20=09struct=20rq=20*rq;=0A=0A=20=09if=20=
(!static_branch_likely(&psi_cgroups_enabled))=20{=0A@@=20-1158,7=20=
+1140,8=20@@=20void=20cgroup_move_task(struct=20task_struct=20*task,=20=
struct=20css_set=20*to)=0A=20=09=09return;=0A=20=09}=0A=0A-=09rq=20=3D=20=
task_rq_lock(task,=20&rf);=0A+=09CLASS(task_rq_lock,=20rq_guard)(task);=0A=
+=09rq=20=3D=20rq_guard.rq;=0A=0A=20=09/*=0A=20=09=20*=20We=20may=20race=20=
with=20schedule()=20dropping=20the=20rq=20lock=20between=0A@@=20-1194,8=20=
+1177,6=20@@=20void=20cgroup_move_task(struct=20task_struct=20*task,=20=
struct=20css_set=20*to)=0A=0A=20=09if=20(task_flags)=0A=20=09=09=
psi_task_change(task,=200,=20task_flags);=0A-=0A-=09task_rq_unlock(rq,=20=
task,=20&rf);=0A=20}=0A=0A=20void=20psi_cgroup_restart(struct=20=
psi_group=20*group)=0A@@=20-1222,11=20+1203,9=20@@=20void=20=
psi_cgroup_restart(struct=20psi_group=20*group)=0A=0A=20=09=
for_each_possible_cpu(cpu)=20{=0A=20=09=09struct=20rq=20*rq=20=3D=20=
cpu_rq(cpu);=0A-=09=09struct=20rq_flags=20rf;=0A=0A-=09=09=
rq_lock_irq(rq,=20&rf);=0A+=09=09guard(rq_lock_irq)(rq);=0A=20=09=09=
psi_group_change(group,=20cpu,=200,=200,=20true);=0A-=09=09=
rq_unlock_irq(rq,=20&rf);=0A=20=09}=0A=20}=0A=20#endif=20/*=20=
CONFIG_CGROUPS=20*/=0A@@=20-1246,12=20+1225,12=20@@=20int=20=
psi_show(struct=20seq_file=20*m,=20struct=20psi_group=20*group,=20enum=20=
psi_res=20res)=0A=20#endif=0A=0A=20=09/*=20Update=20averages=20before=20=
reporting=20them=20*/=0A-=09mutex_lock(&group->avgs_lock);=0A-=09now=20=3D=
=20sched_clock();=0A-=09collect_percpu_times(group,=20PSI_AVGS,=20NULL);=0A=
-=09if=20(now=20>=3D=20group->avg_next_update)=0A-=09=09=
group->avg_next_update=20=3D=20update_averages(group,=20now);=0A-=09=
mutex_unlock(&group->avgs_lock);=0A+=09scoped_guard(mutex,=20=
&group->avgs_lock)=20{=0A+=09=09now=20=3D=20sched_clock();=0A+=09=09=
collect_percpu_times(group,=20PSI_AVGS,=20NULL);=0A+=09=09if=20(now=20>=3D=
=20group->avg_next_update)=0A+=09=09=09group->avg_next_update=20=3D=20=
update_averages(group,=20now);=0A+=09}=0A=0A=20#ifdef=20=
CONFIG_IRQ_TIME_ACCOUNTING=0A=20=09only_full=20=3D=20res=20=3D=3D=20=
PSI_IRQ;=0A@@=20-1349,7=20+1328,7=20@@=20struct=20psi_trigger=20=
*psi_trigger_create(struct=20psi_group=20*group,=20char=20*buf,=0A=20=09=
t->aggregator=20=3D=20privileged=20?=20PSI_POLL=20:=20PSI_AVGS;=0A=0A=20=09=
if=20(privileged)=20{=0A-=09=09mutex_lock(&group->rtpoll_trigger_lock);=0A=
+=09=09guard(mutex)(&group->rtpoll_trigger_lock);=0A=0A=20=09=09if=20=
(!rcu_access_pointer(group->rtpoll_task))=20{=0A=20=09=09=09struct=20=
task_struct=20*task;=0A@@=20-1357,7=20+1336,6=20@@=20struct=20=
psi_trigger=20*psi_trigger_create(struct=20psi_group=20*group,=20char=20=
*buf,=0A=20=09=09=09task=20=3D=20kthread_create(psi_rtpoll_worker,=20=
group,=20"psimon");=0A=20=09=09=09if=20(IS_ERR(task))=20{=0A=20=09=09=09=09=
kfree(t);=0A-=09=09=09=09mutex_unlock(&group->rtpoll_trigger_lock);=0A=20=
=09=09=09=09return=20ERR_CAST(task);=0A=20=09=09=09}=0A=20=09=09=09=
atomic_set(&group->rtpoll_wakeup,=200);=0A@@=20-1370,15=20+1348,11=20@@=20=
struct=20psi_trigger=20*psi_trigger_create(struct=20psi_group=20*group,=20=
char=20*buf,=0A=20=09=09=09div_u64(t->win.size,=20UPDATES_PER_WINDOW));=0A=
=20=09=09group->rtpoll_nr_triggers[t->state]++;=0A=20=09=09=
group->rtpoll_states=20|=3D=20(1=20<<=20t->state);=0A-=0A-=09=09=
mutex_unlock(&group->rtpoll_trigger_lock);=0A=20=09}=20else=20{=0A-=09=09=
mutex_lock(&group->avgs_lock);=0A+=09=09guard(mutex)(&group->avgs_lock);=0A=
=0A=20=09=09list_add(&t->node,=20&group->avg_triggers);=0A=20=09=09=
group->avg_nr_triggers[t->state]++;=0A-=0A-=09=09=
mutex_unlock(&group->avgs_lock);=0A=20=09}=0A=20=09return=20t;=0A=20}=0A=
@@=20-1407,14=20+1381,13=20@@=20void=20psi_trigger_destroy(struct=20=
psi_trigger=20*t)=0A=20=09=09wake_up_interruptible(&t->event_wait);=0A=0A=
=20=09if=20(t->aggregator=20=3D=3D=20PSI_AVGS)=20{=0A-=09=09=
mutex_lock(&group->avgs_lock);=0A+=09=09guard(mutex)(&group->avgs_lock);=0A=
=20=09=09if=20(!list_empty(&t->node))=20{=0A=20=09=09=09=
list_del(&t->node);=0A=20=09=09=09group->avg_nr_triggers[t->state]--;=0A=20=
=09=09}=0A-=09=09mutex_unlock(&group->avgs_lock);=0A=20=09}=20else=20{=0A=
-=09=09mutex_lock(&group->rtpoll_trigger_lock);=0A+=09=09=
guard(mutex)(&group->rtpoll_trigger_lock);=0A=20=09=09if=20=
(!list_empty(&t->node))=20{=0A=20=09=09=09struct=20psi_trigger=20*tmp;=0A=
=20=09=09=09u64=20period=20=3D=20ULLONG_MAX;=0A@@=20-1443,7=20+1416,6=20=
@@=20void=20psi_trigger_destroy(struct=20psi_trigger=20*t)=0A=20=09=09=09=
=09timer_delete(&group->rtpoll_timer);=0A=20=09=09=09}=0A=20=09=09}=0A-=09=
=09mutex_unlock(&group->rtpoll_trigger_lock);=0A=20=09}=0A=0A=20=09/*=0A=
@@=20-1546,22=20+1518,19=20@@=20static=20ssize_t=20psi_write(struct=20=
file=20*file,=20const=20char=20__user=20*user_buf,=0A=20=09seq=20=3D=20=
file->private_data;=0A=0A=20=09/*=20Take=20seq->lock=20to=20protect=20=
seq->private=20from=20concurrent=20writes=20*/=0A-=09=
mutex_lock(&seq->lock);=0A+=09guard(mutex)(&seq->lock);=0A=0A=20=09/*=20=
Allow=20only=20one=20trigger=20per=20file=20descriptor=20*/=0A=20=09if=20=
(seq->private)=20{=0A-=09=09mutex_unlock(&seq->lock);=0A=20=09=09return=20=
-EBUSY;=0A=20=09}=0A=0A=20=09new=20=3D=20psi_trigger_create(&psi_system,=20=
buf,=20res,=20file,=20NULL);=0A=20=09if=20(IS_ERR(new))=20{=0A-=09=09=
mutex_unlock(&seq->lock);=0A=20=09=09return=20PTR_ERR(new);=0A=20=09}=0A=0A=
=20=09smp_store_release(&seq->private,=20new);=0A-=09=
mutex_unlock(&seq->lock);=0A=0A=20=09return=20nbytes;=0A=20}=0Adiff=20=
--git=20a/kernel/sched/sched.h=20b/kernel/sched/sched.h=0Aindex=20=
475bb5998295..c2929f6be25f=20100644=0A---=20a/kernel/sched/sched.h=0A+++=20=
b/kernel/sched/sched.h=0A@@=20-1893,17=20+1893,9=20@@=20=
DEFINE_LOCK_GUARD_1(rq_lock_irqsave,=20struct=20rq,=0A=20=09=09=20=20=20=20=
rq_unlock_irqrestore(_T->lock,=20&_T->rf),=0A=20=09=09=20=20=20=20struct=20=
rq_flags=20rf)=0A=0A-static=20inline=20struct=20rq=20=
*this_rq_lock_irq(struct=20rq_flags=20*rf)=0A-=09__acquires(rq->lock)=0A=
-{=0A-=09struct=20rq=20*rq;=0A-=0A-=09local_irq_disable();=0A-=09rq=20=3D=20=
this_rq();=0A-=09rq_lock(rq,=20rf);=0A-=0A-=09return=20rq;=0A-}=0A=
+DEFINE_LOCK_GUARD_1(raw_spin_rq_lock_irq,=20struct=20rq,=0A+=09=09=20=20=
=20=20raw_spin_rq_lock_irq(_T->lock),=0A+=09=09=20=20=20=20=
raw_spin_rq_unlock_irq(_T->lock))=0A=0A=20#ifdef=20CONFIG_NUMA=0A=0A--=0A=
2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0004-sched-cpuacct-Scope-based-Resource-Management-Sup.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0004-sched-cpuacct-Scope-based-Resource-Management-Sup.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20409c82ef25583f35ec53d0f574484d3c3c4fb5f1=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:27:13=20+0800=0ASubject:=20[PATCH=20=
v0=2004/13]=20sched/cpuacct:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/cpuacct.c=20|=2012=20++----------=0A=201=20file=20changed,=20=
2=20insertions(+),=2010=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/cpuacct.c=20b/kernel/sched/cpuacct.c=0Aindex=20=
0de9dda09949..c6ba078ae4f6=20100644=0A---=20a/kernel/sched/cpuacct.c=0A=
+++=20b/kernel/sched/cpuacct.c=0A@@=20-109,7=20+109,7=20@@=20static=20=
u64=20cpuacct_cpuusage_read(struct=20cpuacct=20*ca,=20int=20cpu,=0A=20=09=
/*=0A=20=09=20*=20Take=20rq->lock=20to=20make=2064-bit=20read=20safe=20=
on=2032-bit=20platforms.=0A=20=09=20*/=0A-=09=
raw_spin_rq_lock_irq(cpu_rq(cpu));=0A+=09=
guard(raw_spin_rq_lock_irq)(cpu_rq(cpu));=0A=20#endif=0A=0A=20=09switch=20=
(index)=20{=0A@@=20-125,10=20+125,6=20@@=20static=20u64=20=
cpuacct_cpuusage_read(struct=20cpuacct=20*ca,=20int=20cpu,=0A=20=09=09=
break;=0A=20=09}=0A=0A-#ifndef=20CONFIG_64BIT=0A-=09=
raw_spin_rq_unlock_irq(cpu_rq(cpu));=0A-#endif=0A-=0A=20=09return=20=
data;=0A=20}=0A=0A@@=20-145,16=20+141,12=20@@=20static=20void=20=
cpuacct_cpuusage_write(struct=20cpuacct=20*ca,=20int=20cpu)=0A=20=09/*=0A=
=20=09=20*=20Take=20rq->lock=20to=20make=2064-bit=20write=20safe=20on=20=
32-bit=20platforms.=0A=20=09=20*/=0A-=09=
raw_spin_rq_lock_irq(cpu_rq(cpu));=0A+=09=
guard(raw_spin_rq_lock_irq)(cpu_rq(cpu));=0A=20#endif=0A=20=09*cpuusage=20=
=3D=200;=0A=20=09cpustat[CPUTIME_USER]=20=3D=20cpustat[CPUTIME_NICE]=20=3D=
=200;=0A=20=09cpustat[CPUTIME_SYSTEM]=20=3D=20cpustat[CPUTIME_IRQ]=20=3D=20=
0;=0A=20=09cpustat[CPUTIME_SOFTIRQ]=20=3D=200;=0A-=0A-#ifndef=20=
CONFIG_64BIT=0A-=09raw_spin_rq_unlock_irq(cpu_rq(cpu));=0A-#endif=0A=20}=0A=
=0A=20/*=20Return=20total=20CPU=20usage=20(in=20nanoseconds)=20of=20a=20=
group=20*/=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0005-sched-syscalls-Scope-based-Resource-Management-Su.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0005-sched-syscalls-Scope-based-Resource-Management-Su.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20903c2521f9a1a8020033614c7f6733c8cafc1968=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:27:31=20+0800=0ASubject:=20[PATCH=20=
v0=2005/13]=20sched/syscalls:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/syscalls.c=20|=204=20++--=0A=201=20file=20changed,=202=20=
insertions(+),=202=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/syscalls.c=20b/kernel/sched/syscalls.c=0Aindex=20=
547c1f05b667..cc677f5845c2=20100644=0A---=20a/kernel/sched/syscalls.c=0A=
+++=20b/kernel/sched/syscalls.c=0A@@=20-1353,9=20+1353,9=20@@=20=
SYSCALL_DEFINE3(sched_getaffinity,=20pid_t,=20pid,=20unsigned=20int,=20=
len,=0A=20static=20void=20do_sched_yield(void)=0A=20{=0A=20=09struct=20=
rq_flags=20rf;=0A-=09struct=20rq=20*rq;=0A+=09struct=20rq=20*rq=20=3D=20=
this_rq();=0A=0A-=09rq=20=3D=20this_rq_lock_irq(&rf);=0A+=09=
rq_lock_irq(rq,=20&rf);=0A=0A=20=09schedstat_inc(rq->yld_count);=0A=20=09=
current->sched_class->yield_task(rq);=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0006-sched-core_sched-Scope-based-Resource-Management-.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0006-sched-core_sched-Scope-based-Resource-Management-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20b9859f2d49c79f25702406e28504aac8603050dc=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:27:59=20+0800=0ASubject:=20[PATCH=20=
v0=2006/13]=20sched/core_sched:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/core_sched.c=20|=2030=20++++++++++++------------------=0A=20=
1=20file=20changed,=2012=20insertions(+),=2018=20deletions(-)=0A=0Adiff=20=
--git=20a/kernel/sched/core_sched.c=20b/kernel/sched/core_sched.c=0A=
index=20c4606ca89210..4dc6fdc8bae0=20100644=0A---=20=
a/kernel/sched/core_sched.c=0A+++=20b/kernel/sched/core_sched.c=0A@@=20=
-54,11=20+54,10=20@@=20static=20unsigned=20long=20=
sched_core_update_cookie(struct=20task_struct=20*p,=0A=20=09=09=09=09=09=20=
=20=20=20=20=20unsigned=20long=20cookie)=0A=20{=0A=20=09unsigned=20long=20=
old_cookie;=0A-=09struct=20rq_flags=20rf;=0A=20=09struct=20rq=20*rq;=0A=0A=
-=09rq=20=3D=20task_rq_lock(p,=20&rf);=0A-=0A+=09CLASS(task_rq_lock,=20=
guard)(p);=0A+=09rq=20=3D=20guard.rq;=0A=20=09/*=0A=20=09=20*=20Since=20=
creating=20a=20cookie=20implies=20sched_core_get(),=20and=20we=20cannot=20=
set=0A=20=09=20*=20a=20cookie=20until=20after=20we've=20created=20it,=20=
similarly,=20we=20cannot=20destroy=0A@@=20-91,18=20+90,15=20@@=20static=20=
unsigned=20long=20sched_core_update_cookie(struct=20task_struct=20*p,=0A=20=
=09if=20(task_on_cpu(rq,=20p))=0A=20=09=09resched_curr(rq);=0A=0A-=09=
task_rq_unlock(rq,=20p,=20&rf);=0A-=0A=20=09return=20old_cookie;=0A=20}=0A=
=0A=20static=20unsigned=20long=20sched_core_clone_cookie(struct=20=
task_struct=20*p)=0A=20{=0A-=09unsigned=20long=20cookie,=20flags;=0A+=09=
unsigned=20long=20cookie;=0A=0A-=09raw_spin_lock_irqsave(&p->pi_lock,=20=
flags);=0A+=09guard(raw_spinlock_irqsave)(&p->pi_lock);=0A=20=09cookie=20=
=3D=20sched_core_get_cookie(p->core_cookie);=0A-=09=
raw_spin_unlock_irqrestore(&p->pi_lock,=20flags);=0A=0A=20=09return=20=
cookie;=0A=20}=0A@@=20-145,18=20+141,16=20@@=20int=20=
sched_core_share_pid(unsigned=20int=20cmd,=20pid_t=20pid,=20enum=20=
pid_type=20type,=0A=20=09=20=20=20=20(cmd=20!=3D=20PR_SCHED_CORE_GET=20=
&&=20uaddr))=0A=20=09=09return=20-EINVAL;=0A=0A-=09rcu_read_lock();=0A-=09=
if=20(pid=20=3D=3D=200)=20{=0A-=09=09task=20=3D=20current;=0A-=09}=20=
else=20{=0A-=09=09task=20=3D=20find_task_by_vpid(pid);=0A-=09=09if=20=
(!task)=20{=0A-=09=09=09rcu_read_unlock();=0A-=09=09=09return=20-ESRCH;=0A=
+=09scoped_guard(rcu)=20{=0A+=09=09if=20(pid=20=3D=3D=200)=20{=0A+=09=09=09=
task=20=3D=20current;=0A+=09=09}=20else=20{=0A+=09=09=09task=20=3D=20=
find_task_by_vpid(pid);=0A+=09=09=09if=20(!task)=0A+=09=09=09=09return=20=
-ESRCH;=0A=20=09=09}=0A+=09=09get_task_struct(task);=0A=20=09}=0A-=09=
get_task_struct(task);=0A-=09rcu_read_unlock();=0A=0A=20=09/*=0A=20=09=20=
*=20Check=20if=20this=20process=20has=20the=20right=20to=20modify=20the=20=
specified=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0007-sched-cpudeadline-Scope-based-Resource-Management.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0007-sched-cpudeadline-Scope-based-Resource-Management.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20bd17d15ad082a4288e45be1679f52cba691a8e0d=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:28:15=20+0800=0ASubject:=20[PATCH=20=
v0=2007/13]=20sched/cpudeadline:=20Scope-based=20Resource=20Management=0A=
=20Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/cpudeadline.c=20|=209=20++-------=0A=201=20file=20changed,=20=
2=20insertions(+),=207=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/cpudeadline.c=20b/kernel/sched/cpudeadline.c=0Aindex=20=
95baa12a1029..7959c9383e72=20100644=0A---=20a/kernel/sched/cpudeadline.c=0A=
+++=20b/kernel/sched/cpudeadline.c=0A@@=20-173,11=20+173,10=20@@=20int=20=
cpudl_find(struct=20cpudl=20*cp,=20struct=20task_struct=20*p,=0A=20void=20=
cpudl_clear(struct=20cpudl=20*cp,=20int=20cpu)=0A=20{=0A=20=09int=20=
old_idx,=20new_cpu;=0A-=09unsigned=20long=20flags;=0A=0A=20=09=
WARN_ON(!cpu_present(cpu));=0A=0A-=09raw_spin_lock_irqsave(&cp->lock,=20=
flags);=0A+=09guard(raw_spinlock_irqsave)(&cp->lock);=0A=0A=20=09old_idx=20=
=3D=20cp->elements[cpu].idx;=0A=20=09if=20(old_idx=20=3D=3D=20=
IDX_INVALID)=20{=0A@@=20-197,7=20+196,6=20@@=20void=20cpudl_clear(struct=20=
cpudl=20*cp,=20int=20cpu)=0A=0A=20=09=09cpumask_set_cpu(cpu,=20=
cp->free_cpus);=0A=20=09}=0A-=09raw_spin_unlock_irqrestore(&cp->lock,=20=
flags);=0A=20}=0A=0A=20/*=0A@@=20-213,11=20+211,10=20@@=20void=20=
cpudl_clear(struct=20cpudl=20*cp,=20int=20cpu)=0A=20void=20=
cpudl_set(struct=20cpudl=20*cp,=20int=20cpu,=20u64=20dl)=0A=20{=0A=20=09=
int=20old_idx;=0A-=09unsigned=20long=20flags;=0A=0A=20=09=
WARN_ON(!cpu_present(cpu));=0A=0A-=09raw_spin_lock_irqsave(&cp->lock,=20=
flags);=0A+=09guard(raw_spinlock_irqsave)(&cp->lock);=0A=0A=20=09old_idx=20=
=3D=20cp->elements[cpu].idx;=0A=20=09if=20(old_idx=20=3D=3D=20=
IDX_INVALID)=20{=0A@@=20-232,8=20+229,6=20@@=20void=20cpudl_set(struct=20=
cpudl=20*cp,=20int=20cpu,=20u64=20dl)=0A=20=09=09=
cp->elements[old_idx].dl=20=3D=20dl;=0A=20=09=09cpudl_heapify(cp,=20=
old_idx);=0A=20=09}=0A-=0A-=09raw_spin_unlock_irqrestore(&cp->lock,=20=
flags);=0A=20}=0A=0A=20/*=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0008-sched-cpufreq_schedutil-Scope-based-Resource-Mana.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0008-sched-cpufreq_schedutil-Scope-based-Resource-Mana.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20072805c802590a9e0e76cd6a0cc214fe10d7ba93=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:28:34=20+0800=0ASubject:=20[PATCH=20=
v0=2008/13]=20sched/cpufreq_schedutil:=20Scope-based=20Resource=0A=20=
Management=20Support=0A=0AThis=20change=20replaces=20manual=20lock=20=
acquisition=20and=20release=20with=20lock=20guards=0Ato=20improve=20code=20=
robustness=20and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/cpufreq_schedutil.c=20|=2041=20=
+++++++++++++-------------------=0A=201=20file=20changed,=2017=20=
insertions(+),=2024=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/cpufreq_schedutil.c=20b/kernel/sched/cpufreq_schedutil.c=0A=
index=20461242ec958a..72bad0d98177=20100644=0A---=20=
a/kernel/sched/cpufreq_schedutil.c=0A+++=20=
b/kernel/sched/cpufreq_schedutil.c=0A@@=20-449,9=20+449,8=20@@=20static=20=
void=20sugov_update_single_freq(struct=20update_util_data=20*hook,=20u64=20=
time,=0A=20=09if=20(sg_policy->policy->fast_switch_enabled)=20{=0A=20=09=09=
cpufreq_driver_fast_switch(sg_policy->policy,=20next_f);=0A=20=09}=20=
else=20{=0A-=09=09raw_spin_lock(&sg_policy->update_lock);=0A+=09=09=
guard(raw_spinlock)(&sg_policy->update_lock);=0A=20=09=09=
sugov_deferred_update(sg_policy);=0A-=09=09=
raw_spin_unlock(&sg_policy->update_lock);=0A=20=09}=0A=20}=0A=0A@@=20=
-515,7=20+514,7=20@@=20sugov_update_shared(struct=20update_util_data=20=
*hook,=20u64=20time,=20unsigned=20int=20flags)=0A=20=09struct=20=
sugov_policy=20*sg_policy=20=3D=20sg_cpu->sg_policy;=0A=20=09unsigned=20=
int=20next_f;=0A=0A-=09raw_spin_lock(&sg_policy->update_lock);=0A+=09=
guard(raw_spinlock)(&sg_policy->update_lock);=0A=0A=20=09=
sugov_iowait_boost(sg_cpu,=20time,=20flags);=0A=20=09sg_cpu->last_update=20=
=3D=20time;=0A@@=20-526,22=20+525,19=20@@=20sugov_update_shared(struct=20=
update_util_data=20*hook,=20u64=20time,=20unsigned=20int=20flags)=0A=20=09=
=09next_f=20=3D=20sugov_next_freq_shared(sg_cpu,=20time);=0A=0A=20=09=09=
if=20(!sugov_update_next_freq(sg_policy,=20time,=20next_f))=0A-=09=09=09=
goto=20unlock;=0A+=09=09=09return;=0A=0A=20=09=09if=20=
(sg_policy->policy->fast_switch_enabled)=0A=20=09=09=09=
cpufreq_driver_fast_switch(sg_policy->policy,=20next_f);=0A=20=09=09else=0A=
=20=09=09=09sugov_deferred_update(sg_policy);=0A=20=09}=0A-unlock:=0A-=09=
raw_spin_unlock(&sg_policy->update_lock);=0A=20}=0A=0A=20static=20void=20=
sugov_work(struct=20kthread_work=20*work)=0A=20{=0A=20=09struct=20=
sugov_policy=20*sg_policy=20=3D=20container_of(work,=20struct=20=
sugov_policy,=20work);=0A=20=09unsigned=20int=20freq;=0A-=09unsigned=20=
long=20flags;=0A=0A=20=09/*=0A=20=09=20*=20Hold=20sg_policy->update_lock=20=
shortly=20to=20handle=20the=20case=20where:=0A@@=20-553,14=20+549,14=20=
@@=20static=20void=20sugov_work(struct=20kthread_work=20*work)=0A=20=09=20=
*=20sugov_work()=20will=20just=20be=20called=20again=20by=20kthread_work=20=
code;=20and=20the=0A=20=09=20*=20request=20will=20be=20proceed=20before=20=
the=20sugov=20thread=20sleeps.=0A=20=09=20*/=0A-=09=
raw_spin_lock_irqsave(&sg_policy->update_lock,=20flags);=0A-=09freq=20=3D=20=
sg_policy->next_freq;=0A-=09sg_policy->work_in_progress=20=3D=20false;=0A=
-=09raw_spin_unlock_irqrestore(&sg_policy->update_lock,=20flags);=0A+=09=
scoped_guard(raw_spinlock_irqsave,=20&sg_policy->update_lock)=20{=0A+=09=09=
freq=20=3D=20sg_policy->next_freq;=0A+=09=09sg_policy->work_in_progress=20=
=3D=20false;=0A+=09}=0A=0A-=09mutex_lock(&sg_policy->work_lock);=0A-=09=
__cpufreq_driver_target(sg_policy->policy,=20freq,=20=
CPUFREQ_RELATION_L);=0A-=09mutex_unlock(&sg_policy->work_lock);=0A+=09=
scoped_guard(mutex,=20&sg_policy->work_lock)=20{=0A+=09=09=
__cpufreq_driver_target(sg_policy->policy,=20freq,=20=
CPUFREQ_RELATION_L);=0A+=09}=0A=20}=0A=0A=20static=20void=20=
sugov_irq_work(struct=20irq_work=20*irq_work)=0A@@=20-822,14=20+818,12=20=
@@=20static=20void=20sugov_exit(struct=20cpufreq_policy=20*policy)=0A=20=09=
struct=20sugov_tunables=20*tunables=20=3D=20sg_policy->tunables;=0A=20=09=
unsigned=20int=20count;=0A=0A-=09mutex_lock(&global_tunables_lock);=0A-=0A=
-=09count=20=3D=20gov_attr_set_put(&tunables->attr_set,=20=
&sg_policy->tunables_hook);=0A-=09policy->governor_data=20=3D=20NULL;=0A=
-=09if=20(!count)=0A-=09=09sugov_clear_global_tunables();=0A-=0A-=09=
mutex_unlock(&global_tunables_lock);=0A+=09scoped_guard(mutex,=20=
&global_tunables_lock)=20{=0A+=09=09count=20=3D=20=
gov_attr_set_put(&tunables->attr_set,=20&sg_policy->tunables_hook);=0A+=09=
=09policy->governor_data=20=3D=20NULL;=0A+=09=09if=20(!count)=0A+=09=09=09=
sugov_clear_global_tunables();=0A+=09}=0A=0A=20=09=
sugov_kthread_stop(sg_policy);=0A=20=09sugov_policy_free(sg_policy);=0A=
@@=20-892,9=20+886,8=20@@=20static=20void=20sugov_limits(struct=20=
cpufreq_policy=20*policy)=0A=20=09struct=20sugov_policy=20*sg_policy=20=3D=
=20policy->governor_data;=0A=0A=20=09if=20(!policy->fast_switch_enabled)=20=
{=0A-=09=09mutex_lock(&sg_policy->work_lock);=0A+=09=09=
guard(mutex)(&sg_policy->work_lock);=0A=20=09=09=
cpufreq_policy_apply_limits(policy);=0A-=09=09=
mutex_unlock(&sg_policy->work_lock);=0A=20=09}=0A=0A=20=09/*=0A--=0A=
2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0009-sched-cputime-Scope-based-Resource-Management-Sup.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0009-sched-cputime-Scope-based-Resource-Management-Sup.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20507782856b661027f8b25fe77fdd77986857295a=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:28:47=20+0800=0ASubject:=20[PATCH=20=
v0=2009/13]=20sched/cputime:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/cputime.c=20|=2039=20=
+++++++++++++++++----------------------=0A=201=20file=20changed,=2017=20=
insertions(+),=2022=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/cputime.c=20b/kernel/sched/cputime.c=0Aindex=20=
6dab4854c6c0..1bff83476183=20100644=0A---=20a/kernel/sched/cputime.c=0A=
+++=20b/kernel/sched/cputime.c=0A@@=20-292,12=20+292,10=20@@=20static=20=
inline=20u64=20read_sum_exec_runtime(struct=20task_struct=20*t)=0A=20=
static=20u64=20read_sum_exec_runtime(struct=20task_struct=20*t)=0A=20{=0A=
=20=09u64=20ns;=0A-=09struct=20rq_flags=20rf;=0A=20=09struct=20rq=20*rq;=0A=
=0A-=09rq=20=3D=20task_rq_lock(t,=20&rf);=0A+=09guard(task_rq_lock)(t);=0A=
=20=09ns=20=3D=20t->se.sum_exec_runtime;=0A-=09task_rq_unlock(rq,=20t,=20=
&rf);=0A=0A=20=09return=20ns;=0A=20}=0A@@=20-326,7=20+324,7=20@@=20void=20=
thread_group_cputime(struct=20task_struct=20*tsk,=20struct=20=
task_cputime=20*times)=0A=20=09if=20(same_thread_group(current,=20tsk))=0A=
=20=09=09(void)=20task_sched_runtime(current);=0A=0A-=09rcu_read_lock();=0A=
+=09guard(rcu)();=0A=20=09/*=20Attempt=20a=20lockless=20read=20on=20the=20=
first=20round.=20*/=0A=20=09nextseq=20=3D=200;=0A=20=09do=20{=0A@@=20=
-346,7=20+344,6=20@@=20void=20thread_group_cputime(struct=20task_struct=20=
*tsk,=20struct=20task_cputime=20*times)=0A=20=09=09nextseq=20=3D=201;=0A=20=
=09}=20while=20(need_seqretry(&sig->stats_lock,=20seq));=0A=20=09=
done_seqretry_irqrestore(&sig->stats_lock,=20seq,=20flags);=0A-=09=
rcu_read_unlock();=0A=20}=0A=0A=20#ifdef=20CONFIG_IRQ_TIME_ACCOUNTING=0A=
@@=20-984,15=20+981,14=20@@=20u64=20kcpustat_field(struct=20=
kernel_cpustat=20*kcpustat,=0A=20=09for=20(;;)=20{=0A=20=09=09struct=20=
task_struct=20*curr;=0A=0A-=09=09rcu_read_lock();=0A-=09=09curr=20=3D=20=
rcu_dereference(rq->curr);=0A-=09=09if=20(WARN_ON_ONCE(!curr))=20{=0A-=09=
=09=09rcu_read_unlock();=0A-=09=09=09return=20cpustat[usage];=0A-=09=09}=0A=
+=09=09scoped_guard(rcu)=20{=0A+=09=09=09curr=20=3D=20=
rcu_dereference(rq->curr);=0A+=09=09=09if=20(WARN_ON_ONCE(!curr))=0A+=09=09=
=09=09return=20cpustat[usage];=0A=0A-=09=09err=20=3D=20=
kcpustat_field_vtime(cpustat,=20curr,=20usage,=20cpu,=20&val);=0A-=09=09=
rcu_read_unlock();=0A+=09=09=09err=20=3D=20kcpustat_field_vtime(cpustat,=20=
curr,=0A+=09=09=09=09usage,=20cpu,=20&val);=0A+=09=09}=0A=0A=20=09=09if=20=
(!err)=0A=20=09=09=09return=20val;=0A@@=20-1071,16=20+1067,15=20@@=20=
void=20kcpustat_cpu_fetch(struct=20kernel_cpustat=20*dst,=20int=20cpu)=0A=
=20=09for=20(;;)=20{=0A=20=09=09struct=20task_struct=20*curr;=0A=0A-=09=09=
rcu_read_lock();=0A-=09=09curr=20=3D=20rcu_dereference(rq->curr);=0A-=09=09=
if=20(WARN_ON_ONCE(!curr))=20{=0A-=09=09=09rcu_read_unlock();=0A-=09=09=09=
*dst=20=3D=20*src;=0A-=09=09=09return;=0A-=09=09}=0A+=09=09=
scoped_guard(rcu)=20{=0A+=09=09=09curr=20=3D=20=
rcu_dereference(rq->curr);=0A+=09=09=09if=20(WARN_ON_ONCE(!curr))=20{=0A=
+=09=09=09=09*dst=20=3D=20*src;=0A+=09=09=09=09return;=0A+=09=09=09}=0A=0A=
-=09=09err=20=3D=20kcpustat_cpu_fetch_vtime(dst,=20src,=20curr,=20cpu);=0A=
-=09=09rcu_read_unlock();=0A+=09=09=09err=20=3D=20=
kcpustat_cpu_fetch_vtime(dst,=20src,=20curr,=20cpu);=0A+=09=09}=0A=0A=20=09=
=09if=20(!err)=0A=20=09=09=09return;=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0010-sched-stats-Scope-based-Resource-Management-Suppo.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0010-sched-stats-Scope-based-Resource-Management-Suppo.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20ee28e9e123bc4557008a38652d78de5019c41be0=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:29:04=20+0800=0ASubject:=20[PATCH=20=
v0=2010/13]=20sched/stats:=20Scope-based=20Resource=20Management=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/stats.c=20|=203=20+--=0A=201=20file=20changed,=201=20=
insertion(+),=202=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/stats.c=20b/kernel/sched/stats.c=0Aindex=20=
4346fd81c31f..1497a244eb40=20100644=0A---=20a/kernel/sched/stats.c=0A+++=20=
b/kernel/sched/stats.c=0A@@=20-134,7=20+134,7=20@@=20static=20int=20=
show_schedstat(struct=20seq_file=20*seq,=20void=20*v)=0A=0A=20#ifdef=20=
CONFIG_SMP=0A=20=09=09/*=20domain-specific=20stats=20*/=0A-=09=09=
rcu_read_lock();=0A+=09=09guard(rcu)();=0A=20=09=09for_each_domain(cpu,=20=
sd)=20{=0A=20=09=09=09enum=20cpu_idle_type=20itype;=0A=0A@@=20-162,7=20=
+162,6=20@@=20static=20int=20show_schedstat(struct=20seq_file=20*seq,=20=
void=20*v)=0A=20=09=09=09=20=20=20=20sd->ttwu_wake_remote,=20=
sd->ttwu_move_affine,=0A=20=09=09=09=20=20=20=20sd->ttwu_move_balance);=0A=
=20=09=09}=0A-=09=09rcu_read_unlock();=0A=20#endif=0A=20=09}=0A=20=09=
return=200;=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0011-sched-wait-Scope-based-Resource-Management-Suppor.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0011-sched-wait-Scope-based-Resource-Management-Suppor.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=201cea7c63e8d44b4ec5c8a3e7d7911200a4458047=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:29:20=20+0800=0ASubject:=20[PATCH=20=
v0=2011/13]=20sched/wait:=20Scope-based=20Resource=20Management=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/wait.c=20|=2043=20=
++++++++++---------------------------------=0A=201=20file=20changed,=20=
10=20insertions(+),=2033=20deletions(-)=0A=0Adiff=20--git=20=
a/kernel/sched/wait.c=20b/kernel/sched/wait.c=0Aindex=20=
51e38f5f4701..8c5dba8fc312=20100644=0A---=20a/kernel/sched/wait.c=0A+++=20=
b/kernel/sched/wait.c=0A@@=20-16,44=20+16,32=20@@=20=
EXPORT_SYMBOL(__init_waitqueue_head);=0A=0A=20void=20=
add_wait_queue(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=
=20=09wq_entry->flags=20&=3D=20~WQ_FLAG_EXCLUSIVE;=0A-=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09=
__add_wait_queue(wq_head,=20wq_entry);=0A-=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(add_wait_queue);=0A=0A=20void=20=
add_wait_queue_exclusive(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=
=20=09wq_entry->flags=20|=3D=20WQ_FLAG_EXCLUSIVE;=0A-=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09=
__add_wait_queue_entry_tail(wq_head,=20wq_entry);=0A-=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(add_wait_queue_exclusive);=0A=0A=20void=20=
add_wait_queue_priority(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=
=20=09wq_entry->flags=20|=3D=20WQ_FLAG_EXCLUSIVE=20|=20WQ_FLAG_PRIORITY;=0A=
-=09spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09=
__add_wait_queue(wq_head,=20wq_entry);=0A-=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL_GPL(add_wait_queue_priority);=0A=0A=20void=20=
remove_wait_queue(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=
-=09spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09=
__remove_wait_queue(wq_head,=20wq_entry);=0A-=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(remove_wait_queue);=0A=0A@@=20-99,13=20+87,11=20@@=20=
static=20int=20__wake_up_common(struct=20wait_queue_head=20*wq_head,=20=
unsigned=20int=20mode,=0A=20static=20int=20__wake_up_common_lock(struct=20=
wait_queue_head=20*wq_head,=20unsigned=20int=20mode,=0A=20=09=09=09int=20=
nr_exclusive,=20int=20wake_flags,=20void=20*key)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A=20=09int=20remaining;=0A=0A-=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09remaining=20=3D=20=
__wake_up_common(wq_head,=20mode,=20nr_exclusive,=20wake_flags,=0A=20=09=09=
=09key);=0A-=09spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=0A=20=09=
return=20nr_exclusive=20-=20remaining;=0A=20}=0A@@=20-228,14=20+214,11=20=
@@=20void=20__wake_up_pollfree(struct=20wait_queue_head=20*wq_head)=0A=20=
void=0A=20prepare_to_wait(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry,=20int=20state)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A-=0A=20=09wq_entry->flags=20&=3D=20~WQ_FLAG_EXCLUSIVE;=0A=
-=09spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09if=20=
(list_empty(&wq_entry->entry))=0A=20=09=09__add_wait_queue(wq_head,=20=
wq_entry);=0A=20=09set_current_state(state);=0A-=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(prepare_to_wait);=0A=0A@@=20-243,17=20+226,16=20@@=20=
EXPORT_SYMBOL(prepare_to_wait);=0A=20bool=0A=20=
prepare_to_wait_exclusive(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry,=20int=20state)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A=20=09bool=20was_empty=20=3D=20false;=0A=0A=20=09=
wq_entry->flags=20|=3D=20WQ_FLAG_EXCLUSIVE;=0A-=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09if=20=
(list_empty(&wq_entry->entry))=20{=0A=20=09=09was_empty=20=3D=20=
list_empty(&wq_head->head);=0A=20=09=09=
__add_wait_queue_entry_tail(wq_head,=20wq_entry);=0A=20=09}=0A=20=09=
set_current_state(state);=0A-=09spin_unlock_irqrestore(&wq_head->lock,=20=
flags);=0A+=0A=20=09return=20was_empty;=0A=20}=0A=20=
EXPORT_SYMBOL(prepare_to_wait_exclusive);=0A@@=20-269,10=20+251,9=20@@=20=
EXPORT_SYMBOL(init_wait_entry);=0A=0A=20long=20=
prepare_to_wait_event(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry,=20int=20state)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A=20=09long=20ret=20=3D=200;=0A=0A-=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09if=20=
(signal_pending_state(state,=20current))=20{=0A=20=09=09/*=0A=20=09=09=20=
*=20Exclusive=20waiter=20must=20not=20fail=20if=20it=20was=20selected=20=
by=20wakeup,=0A@@=20-297,7=20+278,6=20@@=20long=20=
prepare_to_wait_event(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_en=0A=20=09=09}=0A=20=09=09set_current_state(state);=0A=20=09=
}=0A-=09spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=0A=20=09=
return=20ret;=0A=20}=0A@@=20-355,8=20+335,6=20@@=20=
EXPORT_SYMBOL(do_wait_intr_irq);=0A=20=20*/=0A=20void=20=
finish_wait(struct=20wait_queue_head=20*wq_head,=20struct=20=
wait_queue_entry=20*wq_entry)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=
=20=09__set_current_state(TASK_RUNNING);=0A=20=09/*=0A=20=09=20*=20We=20=
can=20check=20for=20list=20emptiness=20outside=20the=20lock=0A@@=20=
-372,9=20+350,8=20@@=20void=20finish_wait(struct=20wait_queue_head=20=
*wq_head,=20struct=20wait_queue_entry=20*wq_en=0A=20=09=20*=20=20=20=20=
the=20list).=0A=20=09=20*/=0A=20=09if=20=
(!list_empty_careful(&wq_entry->entry))=20{=0A-=09=09=
spin_lock_irqsave(&wq_head->lock,=20flags);=0A+=09=09=
guard(spinlock_irqsave)(&wq_head->lock);=0A=20=09=09=
list_del_init(&wq_entry->entry);=0A-=09=09=
spin_unlock_irqrestore(&wq_head->lock,=20flags);=0A=20=09}=0A=20}=0A=20=
EXPORT_SYMBOL(finish_wait);=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0012-sched-swait-Scope-based-Resource-Management-Suppo.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0012-sched-swait-Scope-based-Resource-Management-Suppo.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=20c70921420ddedfa08fed87d08bcb7130e63dcd7d=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:29:35=20+0800=0ASubject:=20[PATCH=20=
v0=2012/13]=20sched/swait:=20Scope-based=20Resource=20Management=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/swait.c=20|=2029=20+++++++++--------------------=0A=201=20=
file=20changed,=209=20insertions(+),=2020=20deletions(-)=0A=0Adiff=20=
--git=20a/kernel/sched/swait.c=20b/kernel/sched/swait.c=0Aindex=20=
72505cd3b60a..cf4eda166cf0=20100644=0A---=20a/kernel/sched/swait.c=0A+++=20=
b/kernel/sched/swait.c=0A@@=20-46,11=20+46,9=20@@=20void=20=
swake_up_all_locked(struct=20swait_queue_head=20*q)=0A=0A=20void=20=
swake_up_one(struct=20swait_queue_head=20*q)=0A=20{=0A-=09unsigned=20=
long=20flags;=0A=0A-=09raw_spin_lock_irqsave(&q->lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&q->lock);=0A=20=09swake_up_locked(q,=200);=0A=
-=09raw_spin_unlock_irqrestore(&q->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(swake_up_one);=0A=0A@@=20-63,9=20+61,12=20@@=20void=20=
swake_up_all(struct=20swait_queue_head=20*q)=0A=20=09struct=20=
swait_queue=20*curr;=0A=20=09LIST_HEAD(tmp);=0A=0A-=09=
raw_spin_lock_irq(&q->lock);=0A-=09list_splice_init(&q->task_list,=20=
&tmp);=0A+=09scoped_guard(raw_spinlock_irq,=20&q->lock)=20{=0A+=09=09=
list_splice_init(&q->task_list,=20&tmp);=0A+=09}=0A=20=09while=20=
(!list_empty(&tmp))=20{=0A+=09=09guard(raw_spinlock_irq)(&q->lock);=0A+=0A=
=20=09=09curr=20=3D=20list_first_entry(&tmp,=20typeof(*curr),=20=
task_list);=0A=0A=20=09=09wake_up_state(curr->task,=20TASK_NORMAL);=0A@@=20=
-73,11=20+74,7=20@@=20void=20swake_up_all(struct=20swait_queue_head=20=
*q)=0A=0A=20=09=09if=20(list_empty(&tmp))=0A=20=09=09=09break;=0A-=0A-=09=
=09raw_spin_unlock_irq(&q->lock);=0A-=09=09raw_spin_lock_irq(&q->lock);=0A=
=20=09}=0A-=09raw_spin_unlock_irq(&q->lock);=0A=20}=0A=20=
EXPORT_SYMBOL(swake_up_all);=0A=0A@@=20-90,21=20+87,17=20@@=20void=20=
__prepare_to_swait(struct=20swait_queue_head=20*q,=20struct=20=
swait_queue=20*wait)=0A=0A=20void=20prepare_to_swait_exclusive(struct=20=
swait_queue_head=20*q,=20struct=20swait_queue=20*wait,=20int=20state)=0A=20=
{=0A-=09unsigned=20long=20flags;=0A-=0A-=09=
raw_spin_lock_irqsave(&q->lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&q->lock);=0A=20=09__prepare_to_swait(q,=20=
wait);=0A=20=09set_current_state(state);=0A-=09=
raw_spin_unlock_irqrestore(&q->lock,=20flags);=0A=20}=0A=20=
EXPORT_SYMBOL(prepare_to_swait_exclusive);=0A=0A=20long=20=
prepare_to_swait_event(struct=20swait_queue_head=20*q,=20struct=20=
swait_queue=20*wait,=20int=20state)=0A=20{=0A-=09unsigned=20long=20=
flags;=0A=20=09long=20ret=20=3D=200;=0A=0A-=09=
raw_spin_lock_irqsave(&q->lock,=20flags);=0A+=09=
guard(raw_spinlock_irqsave)(&q->lock);=0A=20=09if=20=
(signal_pending_state(state,=20current))=20{=0A=20=09=09/*=0A=20=09=09=20=
*=20See=20prepare_to_wait_event().=20TL;DR,=20subsequent=20=
swake_up_one()=0A@@=20-116,7=20+109,6=20@@=20long=20=
prepare_to_swait_event(struct=20swait_queue_head=20*q,=20struct=20=
swait_queue=20*wait=0A=20=09=09__prepare_to_swait(q,=20wait);=0A=20=09=09=
set_current_state(state);=0A=20=09}=0A-=09=
raw_spin_unlock_irqrestore(&q->lock,=20flags);=0A=0A=20=09return=20ret;=0A=
=20}=0A@@=20-131,14=20+123,11=20@@=20void=20__finish_swait(struct=20=
swait_queue_head=20*q,=20struct=20swait_queue=20*wait)=0A=0A=20void=20=
finish_swait(struct=20swait_queue_head=20*q,=20struct=20swait_queue=20=
*wait)=0A=20{=0A-=09unsigned=20long=20flags;=0A-=0A=20=09=
__set_current_state(TASK_RUNNING);=0A=0A=20=09if=20=
(!list_empty_careful(&wait->task_list))=20{=0A-=09=09=
raw_spin_lock_irqsave(&q->lock,=20flags);=0A+=09=09=
guard(raw_spinlock_irqsave)(&q->lock);=0A=20=09=09=
list_del_init(&wait->task_list);=0A-=09=09=
raw_spin_unlock_irqrestore(&q->lock,=20flags);=0A=20=09}=0A=20}=0A=20=
EXPORT_SYMBOL(finish_swait);=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3
Content-Disposition: attachment;
	filename=v0-0013-sched-ext_idle-Scope-based-Resource-Management-Su.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="v0-0013-sched-ext_idle-Scope-based-Resource-Management-Su.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=200dc6cbb0bd06fe2c29999b7c6b3c2206b612d1fa=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=
Date:=20Sat,=2014=20Jun=202025=2015:30:26=20+0800=0ASubject:=20[PATCH=20=
v0=2013/13]=20sched/ext_idle:=20Scope-based=20Resource=20Management=0A=20=
Support=0A=0AThis=20change=20replaces=20manual=20lock=20acquisition=20=
and=20release=20with=20lock=20guards=0Ato=20improve=20code=20robustness=20=
and=20reduce=20the=20risk=20of=20lock=20mismanagement.=0A=0A=
Signed-off-by:=20Jemmy=20Wong=20<jemmywong512@gmail.com>=0A=0A---=0A=20=
kernel/sched/ext_idle.c=20|=2029=20++++++++++++-----------------=0A=201=20=
file=20changed,=2012=20insertions(+),=2017=20deletions(-)=0A=0Adiff=20=
--git=20a/kernel/sched/ext_idle.c=20b/kernel/sched/ext_idle.c=0Aindex=20=
6d29d3cbc670..0d280ab06b6d=20100644=0A---=20a/kernel/sched/ext_idle.c=0A=
+++=20b/kernel/sched/ext_idle.c=0A@@=20-458,7=20+458,7=20@@=20s32=20=
scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20u64=20=
wake_flags,=0A=20=09bool=20is_prev_allowed;=0A=20=09s32=20cpu;=0A=0A-=09=
preempt_disable();=0A+=09guard(preempt)();=0A=0A=20=09/*=0A=20=09=20*=20=
Check=20whether=20@prev_cpu=20is=20still=20within=20the=20allowed=20set.=20=
If=20not,=0A@@=20-485,7=20+485,7=20@@=20s32=20scx_select_cpu_dfl(struct=20=
task_struct=20*p,=20s32=20prev_cpu,=20u64=20wake_flags,=0A=20=09/*=0A=20=09=
=20*=20This=20is=20necessary=20to=20protect=20llc_cpus.=0A=20=09=20*/=0A=
-=09rcu_read_lock();=0A+=09guard(rcu)();=0A=0A=20=09/*=0A=20=09=20*=20=
Determine=20the=20subset=20of=20CPUs=20that=20the=20task=20can=20use=20=
in=20its=0A@@=20-528,7=20+528,7=20@@=20s32=20scx_select_cpu_dfl(struct=20=
task_struct=20*p,=20s32=20prev_cpu,=20u64=20wake_flags,=0A=20=09=09if=20=
(is_prev_allowed=20&&=20cpus_share_cache(cpu,=20prev_cpu)=20&&=0A=20=09=09=
=20=20=20=20scx_idle_test_and_clear_cpu(prev_cpu))=20{=0A=20=09=09=09cpu=20=
=3D=20prev_cpu;=0A-=09=09=09goto=20out_unlock;=0A+=09=09=09return=20cpu;=0A=
=20=09=09}=0A=0A=20=09=09/*=0A@@=20-550,7=20+550,7=20@@=20s32=20=
scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20u64=20=
wake_flags,=0A=20=09=09=20=20=20=20(!(flags=20&=20SCX_PICK_IDLE_IN_NODE)=20=
||=20(waker_node=20=3D=3D=20node))=20&&=0A=20=09=09=20=20=20=20=
!cpumask_empty(idle_cpumask(waker_node)->cpu))=20{=0A=20=09=09=09if=20=
(cpumask_test_cpu(cpu,=20allowed))=0A-=09=09=09=09goto=20out_unlock;=0A+=09=
=09=09=09return=20cpu;=0A=20=09=09}=0A=20=09}=0A=0A@@=20-566,7=20+566,7=20=
@@=20s32=20scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20=
prev_cpu,=20u64=20wake_flags,=0A=20=09=09=20=20=20=20=
cpumask_test_cpu(prev_cpu,=20idle_cpumask(node)->smt)=20&&=0A=20=09=09=20=
=20=20=20scx_idle_test_and_clear_cpu(prev_cpu))=20{=0A=20=09=09=09cpu=20=
=3D=20prev_cpu;=0A-=09=09=09goto=20out_unlock;=0A+=09=09=09return=20cpu;=0A=
=20=09=09}=0A=0A=20=09=09/*=0A@@=20-575,7=20+575,7=20@@=20s32=20=
scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20u64=20=
wake_flags,=0A=20=09=09if=20(llc_cpus)=20{=0A=20=09=09=09cpu=20=3D=20=
pick_idle_cpu_in_node(llc_cpus,=20node,=20SCX_PICK_IDLE_CORE);=0A=20=09=09=
=09if=20(cpu=20>=3D=200)=0A-=09=09=09=09goto=20out_unlock;=0A+=09=09=09=09=
return=20cpu;=0A=20=09=09}=0A=0A=20=09=09/*=0A@@=20-584,7=20+584,7=20@@=20=
s32=20scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20=
u64=20wake_flags,=0A=20=09=09if=20(numa_cpus)=20{=0A=20=09=09=09cpu=20=3D=20=
pick_idle_cpu_in_node(numa_cpus,=20node,=20SCX_PICK_IDLE_CORE);=0A=20=09=09=
=09if=20(cpu=20>=3D=200)=0A-=09=09=09=09goto=20out_unlock;=0A+=09=09=09=09=
return=20cpu;=0A=20=09=09}=0A=0A=20=09=09/*=0A@@=20-597,7=20+597,7=20@@=20=
s32=20scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20=
u64=20wake_flags,=0A=20=09=09=20*/=0A=20=09=09cpu=20=3D=20=
scx_pick_idle_cpu(allowed,=20node,=20flags=20|=20SCX_PICK_IDLE_CORE);=0A=20=
=09=09if=20(cpu=20>=3D=200)=0A-=09=09=09goto=20out_unlock;=0A+=09=09=09=
return=20cpu;=0A=0A=20=09=09/*=0A=20=09=09=20*=20Give=20up=20if=20we're=20=
strictly=20looking=20for=20a=20full-idle=20SMT=0A@@=20-605,7=20+605,7=20=
@@=20s32=20scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20=
prev_cpu,=20u64=20wake_flags,=0A=20=09=09=20*/=0A=20=09=09if=20(flags=20=
&=20SCX_PICK_IDLE_CORE)=20{=0A=20=09=09=09cpu=20=3D=20-EBUSY;=0A-=09=09=09=
goto=20out_unlock;=0A+=09=09=09return=20cpu;=0A=20=09=09}=0A=20=09}=0A=0A=
@@=20-614,7=20+614,7=20@@=20s32=20scx_select_cpu_dfl(struct=20=
task_struct=20*p,=20s32=20prev_cpu,=20u64=20wake_flags,=0A=20=09=20*/=0A=20=
=09if=20(is_prev_allowed=20&&=20scx_idle_test_and_clear_cpu(prev_cpu))=20=
{=0A=20=09=09cpu=20=3D=20prev_cpu;=0A-=09=09goto=20out_unlock;=0A+=09=09=
return=20cpu;=0A=20=09}=0A=0A=20=09/*=0A@@=20-623,7=20+623,7=20@@=20s32=20=
scx_select_cpu_dfl(struct=20task_struct=20*p,=20s32=20prev_cpu,=20u64=20=
wake_flags,=0A=20=09if=20(llc_cpus)=20{=0A=20=09=09cpu=20=3D=20=
pick_idle_cpu_in_node(llc_cpus,=20node,=200);=0A=20=09=09if=20(cpu=20>=3D=20=
0)=0A-=09=09=09goto=20out_unlock;=0A+=09=09=09return=20cpu;=0A=20=09}=0A=0A=
=20=09/*=0A@@=20-632,7=20+632,7=20@@=20s32=20scx_select_cpu_dfl(struct=20=
task_struct=20*p,=20s32=20prev_cpu,=20u64=20wake_flags,=0A=20=09if=20=
(numa_cpus)=20{=0A=20=09=09cpu=20=3D=20pick_idle_cpu_in_node(numa_cpus,=20=
node,=200);=0A=20=09=09if=20(cpu=20>=3D=200)=0A-=09=09=09goto=20=
out_unlock;=0A+=09=09=09return=20cpu;=0A=20=09}=0A=0A=20=09/*=0A@@=20=
-645,11=20+645,6=20@@=20s32=20scx_select_cpu_dfl(struct=20task_struct=20=
*p,=20s32=20prev_cpu,=20u64=20wake_flags,=0A=20=09=20*/=0A=20=09cpu=20=3D=20=
scx_pick_idle_cpu(allowed,=20node,=20flags);=0A=0A-out_unlock:=0A-=09=
rcu_read_unlock();=0A-out_enable:=0A-=09preempt_enable();=0A-=0A=20=09=
return=20cpu;=0A=20}=0A=0A--=0A2.43.0=0A=

--Apple-Mail=_ABE04500-563B-461B-AF59-6C0249FA1BF3--

