Return-Path: <linux-kernel+bounces-840342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567CBB4267
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 16:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF84E1AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1233126A2;
	Thu,  2 Oct 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4hHjDOb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6211C2868B0
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759414406; cv=none; b=COTuf46wAL9+GiUAMjp3aVZzHVnB6FGu9HCSP3nq35ZHuXQk63w3v3i5jel3Aio9l3Wum6tc2IQW+w/nipcnvWLzh1BawqulR7QfbAwFg2389WYI3TE8itvbZ2aF6xB8p53bhL0QOrddeDQFSlugjH8lYGJB2FlfDdKyz/Caedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759414406; c=relaxed/simple;
	bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkF2xRO63qJAyW0hk8LffWn4c6NCiI9XSHijbDcIhm9qnK8xAZCo3TLzy3itjgErruLsOXjaEtDBj9ZrIENUsCul1d9LkoS/YtRF1kMJAf5xM0Af5+5YixiT1ZKGZzYe7rGVbQcn2Dlw5Xmg6gKJc/cJr+SVzBuNgM/OW32HZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4hHjDOb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759414404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
	b=K4hHjDObYe9PL7VJyTt7TVCUHEfeb+nlbW6uGLA1mzaz0UhAaKaAf4YTyeXj4vJRNcwtRP
	mZKh+bQdtxNdMiP/ar07tVGZUBX227PkzpUkZLljuS93lm0/7yNIj4xYNs6HAPOhiInC87
	35Q8NboZT3AOSGaSis0V2fzKNFi0qRs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-Qia5ZZ2UPtqa3I0f_cTd4g-1; Thu, 02 Oct 2025 10:13:21 -0400
X-MC-Unique: Qia5ZZ2UPtqa3I0f_cTd4g-1
X-Mimecast-MFC-AGG-ID: Qia5ZZ2UPtqa3I0f_cTd4g_1759414401
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb7338319so133244766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759414400; x=1760019200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV6jcoPImgeJBzsOGuPk5KSxVvC7fxh2pZvRddlPPVM=;
        b=jVS9wjSsOSWXHpgZcsMwpv6iTluKYYwJ8FrUK+GGpVeFQN9X4sbZrmSxz45GmVPVPJ
         tBKDCSRJKylFau9Dn/31lN4nLoYSxlRzEHZ+yhJgAHmGI/Ve4O05ul3tdwEvGi3AXn3g
         F+ymybWWUPNZjyO3zMIaaug9rnpXyphDWGFxGTLUqRrb60ZLqIGTYu/lbeJMTUVJXTfY
         38VcC35VyWMMny5Z7VCVkTX+VGjQheicjyX+Tr5mnZhvAblvFb5zXfLghSt+lOpi6ZQt
         XCi3SDrH89pduDI3wluKSWsTSI/B27bNyhHO1L2Vu/DyLTs7FSAMNKs5q7zr5m/PU5hi
         NKyg==
X-Forwarded-Encrypted: i=1; AJvYcCWU93pvvJOR2JwVws4ieuG59xL6wNjGGSTIGjysxq1cyR2qbQdrNckhs91Tr/8iD2wokPA+Yi9BHmFNQ0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw18EK1fRGTnq00QEa9pgt4yshXUVdg1h7lHOZA/wBj0TlNrRgd
	g/hZQNUvst9BO3kFOQb46bSO6BYmwMwYE6PgwCsfPecK6OHWwFj1b2azQBKvsQYZKNUUqxMo+yi
	b0SpgWnTGpIxvCywPvGYhg630qeo8DtHGNJ73xTjeG/tYBv2CvbZLPCut+VrP3vrrj21DYJ/LwN
	iJ2poDoyrkuWM0Jz+FmIIB/591PSNMkAWT+2JzKn/UG76QfeAO
X-Gm-Gg: ASbGnct8YONKI4C5toE3EnMXDRWVSs316QVhfujFiw9mPTPBmwcsa8ava7pMyKNsUaD
	lnlS6rujemR4Elxne/YOkryAUmFLeckz1ySVN4m6NezIwtl2TSYyERuuP/rbO6QHi+/Upe37PJr
	wKMMslGFIPvRvfJqBIAMpvt4zZ
X-Received: by 2002:a17:907:7fa3:b0:b3f:5513:5cd0 with SMTP id a640c23a62f3a-b46e2ff2dadmr931962166b.19.1759414400404;
        Thu, 02 Oct 2025 07:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXk+toomjEQdZBly5tWf6QhgCkT/IZoDzJRVf5J3LLN0uaDtazDg2BFzS/K2tcxfteSU5ooQZa3BalTHE+G+E=
X-Received: by 2002:a17:907:7fa3:b0:b3f:5513:5cd0 with SMTP id
 a640c23a62f3a-b46e2ff2dadmr931957666b.19.1759414399839; Thu, 02 Oct 2025
 07:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN54leQ54ozcUXBO@x1>
In-Reply-To: <aN54leQ54ozcUXBO@x1>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 2 Oct 2025 16:13:09 +0200
X-Gm-Features: AS18NWBxssDHkYDSV9h-Nf_qnhtVRpYYBj6ckIuLN0oW3dgIwLK9xAm9KzX368A
Message-ID: <CAP4=nvSekQeTZvxLdajCp8FH2Xva1eN4=a8XhXODR9TMHKK3+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Don't assume libtracefs-devel is always available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 15:05 odes=C3=ADlatel Arnaldo Carvalho de Melo
<acme@kernel.org> napsal:
>
> perf doesn't use libtracefs and so it doesn't make sense to assume it is
> always available when building test-all.bin, defeating the feature check
> speedup it provides.
>
> The other tools/build/ users such as rtla, rv, etc call $(feature_check
> libtracefs) to check its availability instead of using the test-all.bin
> mechanism, stopping the build and asking for libtracefs-devel to be
> installed.
>
> Noticed after applying Ian Roger's removal unused libtracefs
> configuration in tools/perf/.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tomas Glozar <tglozar@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Tomas Glozar <tglozar@redhat.com>

Perhaps it would also make sense to clarify in a comment that
test-all.c is to speed up perf build rather than rv, rtla etc. (which
don't use most of the dependencies listed there)?

Tomas


