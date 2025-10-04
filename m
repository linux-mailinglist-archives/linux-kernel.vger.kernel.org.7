Return-Path: <linux-kernel+bounces-841914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D037BB8842
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA243490D6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8632927F727;
	Sat,  4 Oct 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UVBohL8c"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA3E1A238C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543727; cv=none; b=G98+GKpepeloZd5743+sul7Ke0QK9VrU/kafpxfGVQqBS2huq+Xf/0rWruPDc0p8Wp8TjwYVNUy4Tned1DWCbZLJw3iowAcPGZtiC9lDqu5PmzIgiCc4eQVrk9530B6F2yk7V9jInYY3ZHpIjzCyf9tqK+GeZXDMq2M9xMH1hXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543727; c=relaxed/simple;
	bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BavpwGMIYr9DTMdoOrmEiuwP0ldtcg4FiO/cv2F5Wk+CgTW2gcUbkVH8bxp1ibgNjTSd6gtmWyZIlxal2RNW0OWkL0A7T8E5jslMy+osAKkceng+KUA9g+K3LHfE+U6pFblXbItV4Av6C9qk0T94HBvCWQtmHL0wtKdh0Wt/ts0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UVBohL8c; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso19718531cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759543725; x=1760148525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=UVBohL8cU+t8AHNXNBFMhP3Q1+ncT7/G64axJBW6tt6F87RkpDFR51Fn6SnQuXE1sW
         zMlqgn85RiMJx+APlHTL8Mupunuf3Mto4vwrClsFZwF3iZu2ccU9dJ6JRlRyzPECC5DX
         +M+8OuzvGRyJ3scu3u4q1CRCWAVaTDN/SL2ohwmfAUp/ZIDkfJWAqRidOCH6iJ3qUG71
         R4MVttxjbYVr0YOEpK0kBQD+5W2+BJo49b+lmv91vUqvuVTBcXKwlv+u/1pgjruKvZsq
         k9OApD4/bcxXXIN5TVARF+5M/3dM9Gfnj5jkiDnFxHRwZZQCkr6/X7O9MYejnitZ4oOt
         D5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543725; x=1760148525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nob5kKRkv8Qml7C9lk2znkph3asIUJ+dkyoMrrTUiew=;
        b=L6J714pUAdvyFeF5faS7NHKlBRdwRtCPMMSZ629QAEJYFopa5tTmQzkjlDJjPOkrHJ
         vOhyhmJE0cl0ViAmaKk55e7qT7ERXyUnqinHswtQkvlTfzirxWcHxuZRVI9nGA63QD4/
         dIday2k7DEUb9RMsXI865/Sr8rExxTS1CTph2fnOzXtSQaT9eGgwd0LmoZQISqwYv658
         XpD0H2DjBweJsEh9e6NwR1hnVILGvuaP22PAdJ7BdBE9mYaPMsWq0gSh34Bc5EnQaRob
         wQyipN+ZMAqinggbzxT8DHsIRnXB6vrwW3rW0a1yZkajjnO9QIOTU14I99plfq1kbFr9
         61ew==
X-Forwarded-Encrypted: i=1; AJvYcCUg+fu9e83nqK1wZQgNQd73fAFwHpc6P5qbyDwvJotnrW6M4FEqMfOigkyjqInnQ/JDMyCpdUM6TIzuZOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqOpz0pPLvSx50kNfnZWztRe/j1MqvlTh/lfbs2bPrYXxmP8m
	L+vcvnAc9gyglEqgoexidEvt8ka++JHhUraCqm/OEoc5q29uWSnsXMBLKIGwq3BWBI8SI9D30/A
	VaPTpNWsNTpXbp3FCbLZ4kKLYogsUcWJR81hGAV9K/w==
X-Gm-Gg: ASbGncvVC7LyH08tHlAhJWQzBybeD5OXsiyFh7dvjP8qPdPsxgvUD1cHx/b4V9J1nP9
	ZCZs+pKxUSP7s6LFPGAyv92iuKOZwTpDvaHF1yytC2+I6WeWvqHVM+aHVrEz9q96VLQm1EvtXyq
	sKtlgCBZjxW2JiojVsHu65thTwDJ/TvCVZTiMqoplkP8ONM/PFCAsm7nohNCGGR4K+qBHlWVMw/
	sLzYqUOoROWaBiajl2vewqSU3F7
X-Google-Smtp-Source: AGHT+IHbUzSApGmCRxnFWZElbyxsoU4/P0TZBLF0BzTvLsCV+miCnogbHJNniWq337bBkZeh/jjC8xT2gDd4cs+U3JI=
X-Received: by 2002:a05:622a:5c98:b0:4d6:173a:8729 with SMTP id
 d75a77b69052e-4e576a44213mr72478001cf.10.1759543725080; Fri, 03 Oct 2025
 19:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-19-pasha.tatashin@soleen.com> <20251003231712.GA2144931.vipinsh@google.com>
In-Reply-To: <20251003231712.GA2144931.vipinsh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 3 Oct 2025 22:08:08 -0400
X-Gm-Features: AS18NWCqgXSjTPwyDSbb0KSJXp4c4gz9L9NTQCHF71G2zcSqEq0ghlLm9Q7hBiI
Message-ID: <CA+CK2bD+gG41LA5=kfuWh=zsYm5L9Dq+M8Bhg9-2sn05YvNfaw@mail.gmail.com>
Subject: Re: [PATCH v4 18/30] selftests/liveupdate: add subsystem/state tests
To: Vipin Sharma <vipinsh@google.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
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
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org, steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:17=E2=80=AFPM Vipin Sharma <vipinsh@google.com> wr=
ote:
>
> On 2025-09-29 01:03:09, Pasha Tatashin wrote:
> > diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/=
selftests/liveupdate/config
> > new file mode 100644
> > index 000000000000..382c85b89570
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/config
> > @@ -0,0 +1,6 @@
> > +CONFIG_KEXEC_FILE=3Dy
> > +CONFIG_KEXEC_HANDOVER=3Dy
> > +CONFIG_KEXEC_HANDOVER_DEBUG=3Dy
> > +CONFIG_LIVEUPDATE=3Dy
> > +CONFIG_LIVEUPDATE_SYSFS_API=3Dy
>
> Where is this one?

I removed the v4 SYSFS interface, and this line is a leftover, I will fix i=
t.

Thanks,
Pasha

>

