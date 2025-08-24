Return-Path: <linux-kernel+bounces-783709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C94B33180
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 18:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A5D3AEF1C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542422D543E;
	Sun, 24 Aug 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV5rKo/p"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24928F4
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756053587; cv=none; b=myBMpq3QvbUpi2JoK5XGgZnW5xe2b6HKylp4ElA4ZArncuvL98yMiGdFtVDeDuLU1qury/Td1dYrISCP3iHqIfVm0jkt7TgJAeT0WJfsyMdGfTW3trCEXXFJVcC4ElQeBIqPHkatFxW9PP2MI0rM3uzKK0GtsEuDC/J0tvGuEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756053587; c=relaxed/simple;
	bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHtih9hrSzCmmTFvRKY3RdrgsrgOJQ90mZLhFM16HGbCNuGlCKO3DrE7hqOVH3JD9BWoH3+YYlvx8m75opG+djdkbQPj1CZujfFkmak4xmgHaNYWzbUUVqnialL5kFqM7jEheoWg8Y594iHxd1KfaE4SjgdB7GccuUEJ6bkOmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LV5rKo/p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24611734e50so186415ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756053585; x=1756658385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
        b=LV5rKo/pDnlDxCadrKn7gQiyWBGex4q/wQMItY9ZxUtZAYveLgp5L2u1a+1Do6ywTy
         i8aHWGzh0raJG9uFhCnxaBTTel4GdgS+ek34mh0DjAzgWCvyi6Ry/F63T6Yi5Ldk3oLc
         SB4hY9ncfA0apnNAoc9hRuzp8BoQslOwhFE6bfGFpwlN7u4fqPQ8SQTCs2707mOBaAGH
         Wle3EIqByDxbHidD15jMGvQnquEAbE7drC1Nknq8E73gC9Wvs5e9K+AGWTXgd2sYAXCM
         lZhpP3+LXYYOFVqiXmky4YM1H2YMKFeh3uvj6GT0URMkRx23li0Ln3KLW3ladIpBnZcM
         UcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756053586; x=1756658386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzbrFRokTuoA/BGlN6chg/kU+YDV0lrR5n5SZHBY0yw=;
        b=PCvMIQq4gZG1Vbr84P577xTzxso2sVbGBSCzNmLF+H/yFg1m+zLn5rd5CWgkDoEPRh
         9WxarU2JrcZgGHl5S+OPjqHtPYttReKEDCKKSLpGOMEAPp6X5pjaJTzicCdJONk9y1VN
         A3U+t0AJu1G3gTBqOeHwqwqtKjKns1ROJmUMxUs5hfuXEnbEpTE2wGP94u6mJj3NA4sB
         jJta8Q+n1ivc6rBrdUTEA4RHbLjRRmURO0BOfB3QPgdtGRKy3sp6pXrEVtGvEEaTIrsN
         BpGFG5QxZfYBgCRYIjPWLeNfaCnXtEdYk8ZtErGSgMkc+PoNEhVI5t5+UpS/VGVMp3Ye
         kjFg==
X-Forwarded-Encrypted: i=1; AJvYcCWdR6wssF8OGH8DRjzGzWf1B3XWp4i3o0aadR3AhkrUAnhx12hGq06B2BSNcr1lNNcYz3h303txIG8G89A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+7gDTZS1uiTy290hW6lF7W8tc7tvtMZZGhfFPY4RRQQa+9pF
	WVoYgkzKPIy5XM+pvpfMknG56fMI54/wpnDrOgdEIIdVr2vwCSpc5VUkJVW0Zgn0AvvkXXnp+Sw
	Pze5JOW7xd+mupIPGF/pKSRQuBXWi+xT5t/Qv5PbY
X-Gm-Gg: ASbGnctyVkQHKl+tNKU+OPrTbYipW9rylix9xRZW0c053pNbGvsEOotdJqGQAIXZ80m
	FUwWorfBujkahynptzYudvbM+bwjVtx0p3fRNm4gzKStAeIoWFAvoHCJUgcmj0rixH0CbCmQwoE
	OZ7/iAUx94NdR//qMoYzC3nMwCDODCiWQRhXyBfxtQpGELlqG0cGSP13QQJLtDwDyPZdfFkJUpa
	CBukH69WTUlI5qb+N3/bziSyA==
X-Google-Smtp-Source: AGHT+IF8ztkEHXB7jHNLH5b0qoR949xdKvlTltrfHLNI9mn4T2PAdsWoPgL0Nz5jySsDqNoznj8VNBGkS1VgvZI1Uk4=
X-Received: by 2002:a17:902:cecc:b0:236:7079:fb10 with SMTP id
 d9443c01a7336-2467a21e4c1mr3101485ad.3.1756053585241; Sun, 24 Aug 2025
 09:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com> <aKpP8yn7hoyQJe9h@tassilo>
In-Reply-To: <aKpP8yn7hoyQJe9h@tassilo>
From: Ian Rogers <irogers@google.com>
Date: Sun, 24 Aug 2025 09:39:33 -0700
X-Gm-Features: Ac12FXzo4nNl7CWXzsGv5Kuj8o4HmwvIozQ_8cCU8zkwDdeVOkH53u0lihj7JbY
Message-ID: <CAP-5=fUa6xcn7j6_SGrmK7pTPTcUADodXo6o3UTLbFWBAeUUAg@mail.gmail.com>
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 4:34=E2=80=AFPM Andi Kleen <ak@linux.intel.com> wro=
te:
>
> > BUILD_NONDISTRO is used to build perf against the license incompatible
> > libbfd and libiberty libraries. As this has been opt-in for nearly 2
> > years, commit dd317df07207 ("perf build: Make binutil libraries opt
> > in"), remove the code to simplify the code base.
>
> The last time I tried the LLVM stuff was totally broken, couldn't
> resolve many things. The only workaround was to go back to the actually
> working libbfd. Please don't remove the only working option.

Andi, did you report a bug? Does the non-libbfd stuff work? Yes, as
every distribution has shipped it since binutils went to GPLv3 (in
2007?). While I don't want LLVM stuff not to work, bugs happen, libbfd
is license incompatible with GPLv2 and maintaining it in the source
tree is a burden. When something doesn't work, create a test to repeat
the issue and then we can make it work and ensure it doesn't break
again. In general I've not had issues with the LLVM code.

Thanks,
Ian

