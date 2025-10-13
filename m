Return-Path: <linux-kernel+bounces-850871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954FBD490A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE013544EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C03101B1;
	Mon, 13 Oct 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0bZDSzlp"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050C30EF83
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368977; cv=none; b=f8cD5P+Yv4i3o7YQfqH+Vlj8Ax6Fl8W09GL7zGGfo8J5CXZMouhKJrWmEm1Ltnzdx4tRG9TaFRlfQdxSQ0Cwqc+gpeskr4SDKt4T42wgfK4Zty5PBstvZ8Nu7XA1VB2p4JrHlQeX4D2Ggn089rPNFLOwDKOHIH4gaPznd9oNuQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368977; c=relaxed/simple;
	bh=+efmRN52iBY0si6W7g6Mnet2zmDpA8tsmPUXX/58V5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4SfzPSyrM7mpxft4tDTSYxT2h/6QRfvoJDCMyuIkIWFGdswqb3IN23q+ZC4ouHSAGoX0J0Z8mRqCj+VZhUa2WxVXzOstkbbFrQPTBfNBuq9MN0BKQeijZe6i97obQ1OyjEn/8CX4lPeqvwCWGxaOzxmOCfKXFhOjFsAcD6a6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0bZDSzlp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d67abd215so431225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368975; x=1760973775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+efmRN52iBY0si6W7g6Mnet2zmDpA8tsmPUXX/58V5I=;
        b=0bZDSzlpQEIFXhxAOFMoVzELYlYIl9kDChQx7T7905fY8wFWm+KjWmBGWS7C3HCNtZ
         uR3A3zW6xCaFRShweSb8FpglafnQgAhmm8M0EVhgszpohu0LxUxbphTaHOL6OYc52RlV
         g3LPsauy/9xlU3E/X+YTGoN6DruB/q6SmI/IZ52bL7eyjKQ26wHFVtoF9vOXpzDJ6Uop
         7ppEmR3fps+aFvbUZl6Wlvi1wzGaMtWXt53ifsmvCc2uXxpada3nol4ybwhjs2aNm7CF
         3zXtTbsxVcjcggWgpsXWM/nP7TwoehwtFKj2Ao+QH8Q3O+wYf6t07+ATuw/meJQ+5vc0
         vC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368975; x=1760973775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+efmRN52iBY0si6W7g6Mnet2zmDpA8tsmPUXX/58V5I=;
        b=c1F+EHL+bjp7qpdXqKH4IWkXUE9e6h8SAH2bCM1DKmt+b0og66aAHCvj5zmrE40u1c
         PTPZWy+ctDeXTKg2Oow56WvTbzBE4+9ed/nSphvdJhJdq5JCRpoq9LVi5ptTuXSg7cps
         pgIagKqqF3fVGTrfbK0htaFB2XXIUgxUudzq0VWowc4CVCMvCvqmW0AkLOdBrX9IiBWW
         2quWgpw5AgDzCrU0w044ei94WPeZb7ALfqQyJBBiFTWNAaDz45NQerOHJObIYX5q3Wfz
         Nlo7jnwPyGhlNd0mouCbxqTt8Gjv/wZ9rxryKU04KuuDWBzTksr09svfKAoXN/E15SCx
         OL7w==
X-Forwarded-Encrypted: i=1; AJvYcCWI/z7MiiQWslqWjDl3nkyiNMT6VEf1iAc9HSDhCbaNAhNNV5eHhECQHThym+FXJAgQurE1hW9C0RoJUjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+JDaPAZgQ2m8pT7Jzq4j1tMMH6Bee6lYdBVXPEDlurrfgKA4
	1F6BSKTI/PAtcml4SDwlgJSctXNKW42yeL2Cj0z0XOw3hm0JmbQO+Bbbwd9JuS/UyB5UyPrHkr2
	n29a1D9vMJzBTn7NoCGmqZ+iXLYXYJLDepdp3fAo0
X-Gm-Gg: ASbGncuYiRgWM8iw6Q4KULTEgpJSuJwUF/GkfdcrC5HfFdL9WixhIBfsX0lp7EcyISB
	QjGKrkfq7kxbxoxTGJW9q7msTKayf0kWv44dd8LDcS3PSsAP+tWzh6nnFXV2Fwn3D+QlwqrjsH1
	nzADJj5W1Xk9Fhvl5V1zCK+cEAqrgT64+EgqLebf/4Dv189rqOpUyFPqzFwJKVC4B6EJ30QKxyr
	UaWWEVRVn7k1R227HVGx0I9aoSTSbdM8/Ol7Roh8LOPqycrlq4LPkRJ4+URj6O59jQI6lreeA==
X-Google-Smtp-Source: AGHT+IEdUAiSKFrmjYar3G9IgpPKXQygapAxfBI5r4itrM9lr/rPvWOGAsk6Rix2MCTP+i8IMM+7NAuwUGCcG9YIquE=
X-Received: by 2002:a17:902:d548:b0:25b:ce96:7109 with SMTP id
 d9443c01a7336-290275de5a5mr22172595ad.3.1760368974498; Mon, 13 Oct 2025
 08:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMpRqlDXXOR5qYFd@mdev> <CAP-5=fV05++2Qvcxs=+tqhTdpGK8L9e5HzVu=y+xHxy9AqLMmg@mail.gmail.com>
 <CAD=FV=VNmjTVxcxgTQqjE7CTkK2NVGbRxFJSwv=yOHU8gj-urQ@mail.gmail.com>
 <CAP-5=fW64xHEW+4dKU_voNv7E67nUOFm27FFBuhtFii52NiQUQ@mail.gmail.com>
 <CAD=FV=U3ic707dLuUc+NfxtWF6-ZyRdE0OY2VA6TgvgWKCHUzg@mail.gmail.com>
 <CAP-5=fVkw6TLjVuR3UCNs+X1cwVmYk7UFABio4oDOwfshqoP_g@mail.gmail.com>
 <CAD=FV=UWkZx8xQD=jBkOO6h2f5tw_KCoqhHciw5hkEOYU=GM8A@mail.gmail.com>
 <CAP-5=fXTFHcCE8pf5qgEf1AVODs2+r+_nDUOiWgdQeEgUBHzfA@mail.gmail.com>
 <CAD=FV=VuDYiu5nL5ZeZcY2b+YXOzZtSu2E4qBBHz9fWTW8gPhg@mail.gmail.com>
 <CAP-5=fX4=fV70N3GCdXgV6o-YoJynnSppxJp0MwdRrtsyDrs0w@mail.gmail.com>
 <aOdbRI3BaMCbyvtv@mdev> <CAP-5=fUAato=+jyNNESCX3SjWMEEJQ697VvWiBFCi5wKs_JQCA@mail.gmail.com>
 <a4c80b15-fed0-4ba5-acc1-240ceb7278e4@gmail.com>
In-Reply-To: <a4c80b15-fed0-4ba5-acc1-240ceb7278e4@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Oct 2025 08:22:43 -0700
X-Gm-Features: AS18NWDlTWFT3HdpYqKdSgipTpAwpisZNXm-xTCknWJmQs9BUsH8yue1GTfzRbI
Message-ID: <CAP-5=fUECw2RLvzPrf+jvJ24+cJOecrm_FaB1_qUJ8y5Lr1p1w@mail.gmail.com>
Subject: Re: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Fri, Oct 10, 2025 at 5:54=E2=80=AFAM Jinchao Wang <wangjinchao600@gmail.=
com> wrote:
> Addressing the PMU assumption that all counters are available would
> resolve the issue. If perf managed reserved or pinned counters
> internally, other users would not need to be aware of that detail.
>
> Alternatively, perf could provide an interface to query whether a
> counter is pinned. Having the NMI watchdog supply that information
> creates coupling between otherwise independent subsystems.

There are lots of ways to redesign the perf event subsystem, counters,
etc. These things are being pushed upon. In general the API is trying
to hide details like the scheduling counters.

I'm in a loop, but the change here is bad because:
1) the use of nmi_watchdog in this way is misleading (outside of the
perf tool) because of the name;
2) it is bad because it is altering the way a kernel API has worked
for close to 10 years meaning old code doesn't work as intended;
3) it incurs extra overhead in tools.

Thanks,
Ian

