Return-Path: <linux-kernel+bounces-742634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A4EB0F496
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62B4189E47C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052C92EA476;
	Wed, 23 Jul 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VUhkBz0F"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49B02E8DFB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278837; cv=none; b=duiRG9KzQyD5b5QGAkUFsiEgrjtQN0PU4uDVewXjkvVPdorVZ7wdux2IHofzRCk6YCggxYxhbrSFuwxHlkbhd3LXIqO83rTHrT1r7l3JXAFzTthplC599xLo0MI/XHDS0gdGESTDTFQ7lwNvU7h+yqpxT1LE59n2V07nJT6+iPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278837; c=relaxed/simple;
	bh=hByHGrth5zdeb5TgCiwXXXAzfAWK6MDyTN/grdnGXO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SS/S+/4Wnyv22wDMcRjPby1cU+4F89gjMUoX/HrTEi5fb42R9Si4gFJxyN1zT+maQ3OZimw9XYOovWpUT6E4KthJ/o/EtaGFgABLkXDD6hctU7EbWk9r8RLqZwxSgMcQLqfUOUUzD3BhT9nlg5iAnBJe+TvaqokodhrBFecVrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VUhkBz0F; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ae721c2f10so5637991cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753278834; x=1753883634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nYQ1nxWVgdB6FCVcfOrCHIYHLuEY3Xl4xttYXGmsTA=;
        b=VUhkBz0FovqY5h/QVPdB73Klq4kCB3HeRqIw1lDXbDXRf9++Bui89TnRiUXjQI8WvC
         F/GfF0KrhXNxEk2+JDBcBosXSdx8PYUEKHOx+vQqQnKS4HHaJfVQ6MGRJ8F/7YcJwcQs
         MzpC5xCP4RPuQJIULXKmgoXfNO7xLUEAXvceVg7M40wBIHyrh6R7ox+CI1yLP4FHfsLI
         FC3jiZntXEQG5IdEM5RTLBw4S8rvJNc6NOq3NC9FkTk+XoASAriBXxrBQ2F5vxDccwKL
         vkjze2pjI7NA2Q8sWWBKQ61OiEq5uOkVoOE89pshBkZa389e2pP+402UOWCLzvLDYoA/
         JpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278834; x=1753883634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nYQ1nxWVgdB6FCVcfOrCHIYHLuEY3Xl4xttYXGmsTA=;
        b=LOt5f9/ZF791Lac7xouVacRSrHRHhT6pqI+xp9Rt72Rc53NtF0FYQdSPNvLbqTgePU
         9POg6XwSrpfz1Axff3D+rP3lq7DUD0Y3+sP1hj0A93Ke65N8C6zMxSOS4JH6uDpzStkr
         n1KEgEC9XmOJvKuN4L/lnrrom27LvypPA9sBlFxHUsrqPnka7d8q5/Z037pohV33trFE
         KmO8HM2n8yC2hqfOlQbn3shDoaxoiNl3m6JBoEhYaorqnV1zFfhf9SZflwPHEFQm2r54
         eZZ2hPjUsyYoNba3vJMRvJxQ8m9sCnlTpl0l1lUZX7MOnmEyKv1N5wTVnFIHnYdxWmq/
         GOIg==
X-Forwarded-Encrypted: i=1; AJvYcCX4b98pXhVJwgFXrwbfJHS5x6bKb3tpvJj23bZm5o1sD90355cMHna6NEus9pKXMdQRA0xfSfqVABKbvF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1er5W16q8lTwLbRq1tyh7L05KnLDIMkSbtr8tIYGpH562jTpw
	NruX0W9dWWf4dErvXHY3ZWhbP0KBV7De/FVGwZ4fHbvkj1n3MPvhB522DUI59cozcj0Q9XzrdEi
	843Qmm0jmqPNGmMwoMRfYxATdAzRBKNefEK7FoZ93BA==
X-Gm-Gg: ASbGncvc2HIpGYn3uapK2075s7kJwTjHILV3th9OXXJoKm1aVPrxPKnSzviWuDEoWQB
	SjQeOI5JIbu6rJxCYYFQAp4WTp+7GOn7vLh5zmxJRMzy0Fj+j3hTXCMbON3TKYagzPlGziG4Ooj
	prMK9wX+Fl27Ybg9nhRZ0OqszubR+jWIkLJgw7agxX971HC+dG+gr9arBOg+1fqk7nrUZFC9UK1
	F7x
X-Google-Smtp-Source: AGHT+IHnUuhdrD9l7/UqXUCaUGkjpnut9RPkUhkRsYy8dMo95ULrH9zUrOnS3/mgiyGB2gnOI0df5GH4vloe3EzyqoM=
X-Received: by 2002:a05:622a:13:b0:4ab:65c3:37d5 with SMTP id
 d75a77b69052e-4ae6e009e59mr39018621cf.27.1753278827759; Wed, 23 Jul 2025
 06:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-18-pasha.tatashin@soleen.com> <d6e44430-ec9c-4d77-a00b-15e97ab9beab@infradead.org>
In-Reply-To: <d6e44430-ec9c-4d77-a00b-15e97ab9beab@infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 13:53:11 +0000
X-Gm-Features: Ac12FXycG_A7VpBGI0ZPxdi4OoC_3NChOWXSX3JfSNxhPZyJt2s_1oWRajx-S3I
Message-ID: <CA+CK2bCpY3xnPeEyWCRYVpRcs3maKMqZnApQtm5upkwmM80a3g@mail.gmail.com>
Subject: Re: [PATCH v1 17/32] liveupdate: luo_sysfs: add sysfs state monitoring
To: Randy Dunlap <rdunlap@infradead.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 12:29=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi,
>
>
> On 6/25/25 4:18 PM, Pasha Tatashin wrote:
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-liveupdate b/Docume=
ntation/ABI/testing/sysfs-kernel-liveupdate
> > new file mode 100644
> > index 000000000000..4cd4a4fe2f93
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-liveupdate
> > @@ -0,0 +1,51 @@
> > +What:                /sys/kernel/liveupdate/
> > +Date:                May 2025
> > +KernelVersion:       6.16.0
> > +Contact:     pasha.tatashin@soleen.com
> > +Description: Directory containing interfaces to query the live
> > +             update orchestrator. Live update is the ability to reboot=
 the
> > +             host kernel (e.g., via kexec, without a full power cycle)=
 while
> > +             keeping specifically designated devices operational ("ali=
ve")
> > +             across the transition. After the new kernel boots, these =
devices
> > +             can be re-attached to their original workloads (e.g., vir=
tual
> > +             machines) with their state preserved. This is particularl=
y
> > +             useful, for example, for quick hypervisor updates without
> > +             terminating running virtual machines.
> > +
> > +
> > +What:                /sys/kernel/liveupdate/state
> > +Date:                May 2025
> > +KernelVersion:       6.16.0
> > +Contact:     pasha.tatashin@soleen.com
> > +Description: Read-only file that displays the current state of the liv=
e
> > +             update orchestrator as a string. Possible values are:
> > +
> > +             "normal":       No live update operation is in progress. =
This is
> > +                             the default operational state.
>
> Just an opinion, but the ':'s after each possible value aren't needed
> and just add noise.

Removed columns, thanks.

Pasha

