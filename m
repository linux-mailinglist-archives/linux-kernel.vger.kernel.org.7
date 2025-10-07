Return-Path: <linux-kernel+bounces-844850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0594BC2E84
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 00:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B13E1F3B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CC325A2BF;
	Tue,  7 Oct 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hHZvo2Fn"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3682586C5
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877901; cv=none; b=XigKocWP2C+RM81+T4822V8unDRnGH95bxrFcjimhaNKVJ+dW9yvqTSyWCrcTi8wrMlT60GT3uP8zZrmcQpkmIbQaa1qwQr/BAIQgnpDGfMSLCyVmtu6r4R6xbAtsz4nFhsQ6vKgLcquG6fxJWnViw1kcBQOkxXAPJpBtEXPLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877901; c=relaxed/simple;
	bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrAC6WRDIv0eqITQWLdA7VrwI7hYjTZeYNJgFYGVQHbG69sdOHCqjh1NPf6PItQmbcOsb+HHcw2fHgFCzRJYzVpMEL1AOxSdjXrXTNK3a2Qzc55tqPibhe7y2vVCRPKjSJqOU8zOsskIv2oKgOaeq1Nt02zl4LsH8Beu7BK7z6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hHZvo2Fn; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77f605f22easo5806118b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759877899; x=1760482699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
        b=hHZvo2FnIpNzBtb0yH7xfpc+ZYkANXLRSlsZY4+A9eHHaRoTXD5ur087sW0U3kakzz
         udN7qgZNVtPKhJmY7UMosAuonCbj8TLn+J5ahzBL74XaWMzmgvci/g8VklbtShn5VPSa
         KIbm4i20efZbuDvtpJiGrUFrxRoyN3+clrM4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877899; x=1760482699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+KQiXKaE6mhudMxCJikU0TpZUEaf78Hz+t9g+4OaC4=;
        b=dwc+34LQ+G1J1Six5V2Ujkl6DJ68YuIh1y9AMCodVxt7njLyFfjt/fVIDC1jwMjbRm
         J9U8gdeRSKuAdFTcgVWkpezXI4bFOSwliHxi5Uhgv8SjQwfH/oA7lOiyXeT3aMtuwgHL
         wAV/SnxTpgh78WrdW6b1HnjilmpgKFjin+/LqgVnro80ecp8qJMZEVW+dgNq9xlqru3g
         Y3c9u03LTnq3lm/LPwOfpj4EDeFY8lC0MklLfvbnscwE1kKiV3JxJ2uhkHmS2w+HYBLZ
         3ggDrDC/a0WXMa0It/lJjP1m2Icg9/fQMGnBdVqANywb+MEVTKHMaLhT1ySAVqoJtSUG
         ccEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIemoYkhq0BZG716Bpr98Rf85gVp4IPtu0ZJqG2dV3CsEz+aQvBMv0ipgb/9i3Cd5Dzzg9N3pFnA8i8ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAeCh0zJAfObflgdJaQkB6QdEFzh3lrI1kQsCCI1jVh1w0X7e
	4NfIxV1lJgsNzLzniJoME9TzsUaeNfzD1hGO7ImTEc6LRCMw5oPk3zjv9Kmk4N5rb1MK4s9U/zW
	mKvU=
X-Gm-Gg: ASbGncuz+U30atDMRqvdAQ5oC3+a5/SDc0RatK2EBaJSaFVuH4OpoYdVDnpH10htYAt
	zbd+QN2LEP7HCv2cuZeNVdtW6zTyzeN6dT5NFBo8Xs7ZeLfQjFWGnk1U0LdTc8EHFQQjnepKZL+
	+DwN7j0mfi9/pQ66PORwoCT8H/g3OlMN7jCXxSSiiRHivO/VG8pjO9ga9clQYqjwJp+VmnQftK7
	6emZ4G0n1sR1Sjlwm/q88TNHdjkAVt91oCz3QQUwvy9fySSev9lqj0cAs7Sor3foLonHVKO6IhQ
	jFBA/VxcxNm78BKzKifYZcXOTfzwvjiwT4zkMBdz6IBM2wYvgSI9olz/oUYXvFffJW9Ru6siejA
	BJR1HkMijMbXaRnrnX4pWvVVsNJeagNhG8DxcPl5bXdxNzwKEfx62IH5/Uk8cbNbmn0XYK41KRS
	gJSi7GjwvzZ484eQ==
X-Google-Smtp-Source: AGHT+IF7m2pUMs00Tm6uDwJ/ulAtilwV4ndViRDuHi5cci8bu80YkvZ6243GWA8HsazHjeQyoa4/bg==
X-Received: by 2002:a05:6a00:17a5:b0:781:1562:1f9e with SMTP id d2e1a72fcca58-793880f0678mr1442680b3a.32.1759877899258;
        Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dcb3sm16805540b3a.11.2025.10.07.15.58.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 15:58:19 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso4497666a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 15:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUz27gwE/AsHn7euWB5EA5tcfgXObBs+4ukHsOsAjM6/VTnUHzm1Nv+Bw3ZVyUeETX7oAVkOkAnY/ldDI4=@vger.kernel.org
X-Received: by 2002:a17:902:fc4b:b0:28e:7dd9:5c29 with SMTP id
 d9443c01a7336-290274024e3mr13055185ad.51.1759877898085; Tue, 07 Oct 2025
 15:58:18 -0700 (PDT)
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
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com> <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
In-Reply-To: <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Oct 2025 15:58:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
X-Gm-Features: AS18NWCSxLhXMa6LWJavaPtuRN6XlQd4XglBJvkd9z7Rf77zdxFhI-J_rEr9-v8
Message-ID: <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Ian Rogers <irogers@google.com>
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

Hi,

On Tue, Oct 7, 2025 at 3:45=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Oct 7, 2025 at 2:43=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
> ...
> > The buddy watchdog was pretty much following the conventions that were
> > already in the code: that the hardlockup detector (whether backed by
> > perf or not) was essentially called the "nmi watchdog". There were a
> > number of people that were involved in reviews and I don't believe
> > suggesting creating a whole different mechanism for enabling /
> > disabling the buddy watchdog was never suggested.
>
> I suspect they lacked the context that 1 in the nmi_watchdog is taken
> to mean there's a perf event in use by the kernel with implications on
> how group events behave. This behavior has been user
> visible/advertised for 9 years. I don't doubt that there were good
> intentions by PowerPC's watchdog and in the buddy watchdog patches in
> using the file, that use will lead to spurious warnings and behaviors
> by perf.
>
> My points remain:
> 1) using multiple files regresses perf's performance;
> 2) the file name by its meaning is wrong;
> 3) old perf tools on new kernels won't behave as expected wrt warnings
> and metrics because the meaning of the file has changed.
> Using a separate file for each watchdog resolves this. It seems that
> there wasn't enough critical mass for getting this right to have
> mattered before, but that doesn't mean we shouldn't get it right now.

Presumably your next steps then are to find someone to submit a patch
and try to convince others on the list that this is a good idea. The
issue with perf has been known for a while now and I haven't seen any
patches. As I've said, I won't stand in the way if everyone else
agrees, but given that I'm still not convinced I'm not going to author
any patches for this myself.

-Doug

