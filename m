Return-Path: <linux-kernel+bounces-844911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A71FCBC309D
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 02:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 659A84E813A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 00:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A153B1D5CC7;
	Wed,  8 Oct 2025 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PpqdWa6x"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC419AD70
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882327; cv=none; b=MJnUTNzN+k1vB9StxvIfbM2SSukeb9Q7h+1lNT+h06aUIMHblquOxl06+rH0/gq3+nqa2wC/qmJtztnM2AIyHPOPJiIFKpZgSM90Sx3bNELh/3co2oDmrQLs4/hIyuBFGxK+UYZKsUipkPdD7pvNd8kyUu3aCR9Ja7PJj6UXnxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882327; c=relaxed/simple;
	bh=rSm8mFFZC/LlLyUlrwpbR/WW78/8FByCa6qtrBNnEPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=be/5ICFM+IsCT6ZMcxXXUmf2juL8nLhqyDbDSZGnngN+Z4l3BAhwpw61sPIU3l6of/kTAXASK4i4RLuUpzMviM4KYfYQgU13kR5D0WDishsLTykkCOIqZ6htoWcTgtt5wRpGyQKZp0Xa7C3cRSdnAbK9aMyDdIMDUXu3i+eGk0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PpqdWa6x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eeafd4882so114345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759882325; x=1760487125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4s+V4FbLGaf41FAvlBu/thUUG5t6W0OPczp2pqdLV4=;
        b=PpqdWa6xFgZMc6qjiXyNTC+84g0mGNZbmz0SYEGf41o8gksVF+XxoPf+WthiQgebe2
         a585772KDQij6+hmXdNV6Dca0u22ZAhu6wIm0wpppZ8KEgSJ5s0lYTvEhjCJwvxsJr2D
         NtIx+vINWLhEu+h0JVXBHImHWa3TodhTDgk/S74oA4REZ15mwYoOEBlWUI2Uw+psEXEC
         smKIk9aeFChY9okrpDTI/QEqPyy4GY5gwOFuaBoAu9f9WReqXmBd+LEs4LLaAxAhJN9C
         TAoNjW8c1oWfj2GtKELZv2kN+vNoqPp1C8yTvKs8Xi/OvqfhHizJ1XuVBs2cF0L9i8bg
         TevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882325; x=1760487125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4s+V4FbLGaf41FAvlBu/thUUG5t6W0OPczp2pqdLV4=;
        b=YxbkLl/2bmieT1uaB9fUq6s9XVuHAxOJ50qQdNBdFF/Zyw2Is/BhS9IwXvfWNCrIJb
         DV9pfeRyN3ZDpRmndj4pzoLwVGzhjU2bKaUiiePHCAltEWh/HJD0P6WA8SYia/3I5pta
         Q07WXvfyaV8DegVARQ6w/tajwcgblfaQ6D+xw+rV8cSj6w2dmK/OEJIEPl6SjbTw9mf9
         0b/9GZ9Dh+whM9sjoepcqedo8JMpfjF6GMoaGcOlQtnBWoDeJYhzEIcjAu8mRylwI3ai
         sPHjFYLJnztj46C0uP2em75VnDHKl+ffPOgrrraITeOqXYOSpUatf3KhuCsBPGswSeMl
         FA9w==
X-Forwarded-Encrypted: i=1; AJvYcCV9qIlf5q6kvL5yOvyC46liHrOiZvnrkWj5OO9HNBaeNQ4McoqE8edb6fVnhxu2/CrRtns6nx1EKNKm3sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq59iyFyXqRP1YQM703F9vf2adE3u3RM1bxFG5QifqReauCydZ
	w8I0Dp+lNA1e1hLIQeoeQTK9xaocdVQGFVfAZYoEKUOqNDZofCUaZ08TonNTWkkiwNamLsXPDOI
	2gFOUEWNqoESrrXiDySINexMA0sO24tG5l6nhpRJv
X-Gm-Gg: ASbGncvawwOnszd9TnFLKp+Q1LDe4Zp0InLj/eqH2C9MLJG2505ewuJK6BmN3+K8TdE
	kdpeThWJPAeaszsD6KceALaY0VIv4xY0QEcGfyiHT3sKRMev3Q5jSU9oJDqWd9Cae03auYCU6iy
	9L32f6zfOTCdgk/cLYM2xAXawbFfLJpwPR8+fi9bHuqzE567mXCCCICOPYrekn3rmtMFKYlwGoG
	fVih58bRMFE6sEWUlELpJpIy19JyP70RwD7nANAYeUooZZqZw==
X-Google-Smtp-Source: AGHT+IH+yIGcsp4+CFLpohDGf/cUkctKYAedGH2G5UnTvDt75JS4P+J8+FQ8PDuGaGOvQ1lq/+LMPX2feI/OOwB8H0k=
X-Received: by 2002:a17:902:dacd:b0:248:f683:e980 with SMTP id
 d9443c01a7336-29027602620mr3056445ad.2.1759882324220; Tue, 07 Oct 2025
 17:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916145122.416128-1-wangjinchao600@gmail.com>
 <CAP-5=fWWOQ-6SWiNVBvb5mCofe0kZUURG_bm0PDsVFWqwDwrXg@mail.gmail.com>
 <aMoTOXIKBYVTj7PV@mdev> <CAP-5=fX7NJmBjd1v5y4xCa0Ce5rNZ8Dqg0LXd12gPrdEQCERVA@mail.gmail.com>
 <aMpIsqcgpOH1AObN@z2> <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
 <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com> <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
In-Reply-To: <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Oct 2025 17:11:52 -0700
X-Gm-Features: AS18NWC-sVWRHhiacA7_GdnjNxZp2uG6VtSCGmRNgb1MOSdJV-yT9mBtxj51skw
Message-ID: <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Doug Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jinchao Wang <wangjinchao600@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, akpm@linux-foundation.org, 
	catalin.marinas@arm.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	kees@kernel.org, masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com, 
	gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com, 
	zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com, 
	arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com, 
	coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com, 
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org, 
	yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 3:58=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Oct 7, 2025 at 3:45=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Tue, Oct 7, 2025 at 2:43=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> > ...
> > > The buddy watchdog was pretty much following the conventions that wer=
e
> > > already in the code: that the hardlockup detector (whether backed by
> > > perf or not) was essentially called the "nmi watchdog". There were a
> > > number of people that were involved in reviews and I don't believe
> > > suggesting creating a whole different mechanism for enabling /
> > > disabling the buddy watchdog was never suggested.
> >
> > I suspect they lacked the context that 1 in the nmi_watchdog is taken
> > to mean there's a perf event in use by the kernel with implications on
> > how group events behave. This behavior has been user
> > visible/advertised for 9 years. I don't doubt that there were good
> > intentions by PowerPC's watchdog and in the buddy watchdog patches in
> > using the file, that use will lead to spurious warnings and behaviors
> > by perf.
> >
> > My points remain:
> > 1) using multiple files regresses perf's performance;
> > 2) the file name by its meaning is wrong;
> > 3) old perf tools on new kernels won't behave as expected wrt warnings
> > and metrics because the meaning of the file has changed.
> > Using a separate file for each watchdog resolves this. It seems that
> > there wasn't enough critical mass for getting this right to have
> > mattered before, but that doesn't mean we shouldn't get it right now.
>
> Presumably your next steps then are to find someone to submit a patch
> and try to convince others on the list that this is a good idea. The
> issue with perf has been known for a while now and I haven't seen any
> patches. As I've said, I won't stand in the way if everyone else
> agrees, but given that I'm still not convinced I'm not going to author
> any patches for this myself.

Writing >1 of:
```
static struct ctl_table watchdog_hardlockup_sysctl[] =3D {
{
.procname       =3D "nmi_watchdog",
.data =3D &watchdog_hardlockup_user_enabled,
.maxlen =3D sizeof(int),
.mode =3D 0444,
.proc_handler   =3D proc_nmi_watchdog,
.extra1 =3D SYSCTL_ZERO,
.extra2 =3D SYSCTL_ONE,
},
};
```
is an exercise of copy-and-paste, if you need me to do the copy and
pasting then it is okay.

Thanks,
Ian


> -Doug
>

