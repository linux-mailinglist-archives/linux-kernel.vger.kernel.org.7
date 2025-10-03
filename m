Return-Path: <linux-kernel+bounces-841799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CAFBB8436
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B88219C7229
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871B726B742;
	Fri,  3 Oct 2025 22:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjtrbN9E"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEF26A1CC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529446; cv=none; b=mBfryxFFbxuESDdBr8svQ/suthE1bBHaTC281cKsJh/qgIashh0fwI4e0AKRIqAYd1i1AoKgUK4hkNSvaVtWxM1eddC4UP1gwoEVFVAmzXyNB40RdOEzosDx397xoY1DFj/LqgLpVcjYA2T9fue4JB6GGN+vQl8A9leGusg2gP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529446; c=relaxed/simple;
	bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCQEln1JQmZqvWXlSY+Xci+p3dQziUeWnj2rlih6NgchLjr348skB83Qn2gguMVblPWbjbIKbHB80I6IgEp0a709ktzEQhRsdI7lnatXr2cemlk/B+1LMu1ebgYl0HcZ8uQ5hz5u7R97YpiaTPrCoiwr3lpQOBIR81XJaPdwYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjtrbN9E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eeafd4882so70625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759529444; x=1760134244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
        b=vjtrbN9Ejen1vdPduqG8rNi7IpxNs3fPe+445nnRniDQBqzvyNqSGS+1tJgiyJo5ch
         qW8YdMGeKD5fAf6W4iBbmoEpkJ4K6W3L5b14qrz9AgA7bC6ACgrm7wpMSYyiuQL7zc+T
         YxnwfTBOTuTrnZjiT/Guqc7MDbffeKK45D6qUBTP7TMqzbaaPfCggu5Auv18cTeotX9s
         /6ayiyBceH+naQy99n5Tkzus7iOe7pzvfZMky1JWYMD77hyA3U+hAcM/CqLlqFBt41QU
         trAd1Gjp7moDTp9GGIKCcVppwA+U06K5kuANtIWxOhj5HPuyU7iSdK0x941EvjNOUQ7V
         G2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529444; x=1760134244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7SGEevs/NqrFx2Be9PAd6YuSM2YEZFevaJ2O9CJ2qI=;
        b=MXHdYesssKT6CwSKh2kbcZRPqwndbXct6pkhAZSz6mQ5kfpdTQBRqZoPmO3nXnFrbN
         /GGejL0Cyt+fQax0/oAhlCoZ+S3bIT5sPAHsV4vL42gZRurweRJ7eFl9VGBQPssM1VAu
         VFQGjrdme5Kgs+bclCaHCGMUnydz4B0NkHDQJHTzKhO7RU/Fj8XZW2wvXuo2zMJ9mzZV
         7eMrBY4jrqocgdkupQpCYUPz1zXo/eCAE+4zUl0BsQxVl6gqo2wyvRn4c/XfeLSGgJ8X
         VjuwHZwcmNraG1eJUncWDs7N+64uYYDCA/vVtjIgUCbcZ7XdamxxqovP1p1SShtqYNta
         f6Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXMudCHLJsZs+uflpcJwNB8674glkHGemU8nlirDx+RQZV2GpZavIsA1WjN751RSTb1v+5ILL4VO9guVbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijlIpu21PI29loX5imY2WMhpe4Gu6+lgjbUxzeev6IO2XCe3F
	TISmtfjguL+spZyW42z/Y0lVMKzYopoW0NUjXJcLvw6iW8qmMBwQGCvC7hflFLVq82EdsYzpi7f
	u4Yi847yFFGDf9AwyiE1vH2EWGUZaWjKmJ4NEYkf6
X-Gm-Gg: ASbGnctDntWz5PAvHbPA35yZb2CMBcwzaZLMBPwRMzBV0pn34+2+9UoLxAS302Pt65t
	kjol4Z/mNPrL+rjK81RE0YWHO2dqu1qpAhv88WuHE1TDOM9UC8tlQwJibYBZAE7sBkOpDAJ4jhT
	8ixi/OzHGPPUv4OdGdkjHEGrpBJICJNvJ4/Z6ywxY8IjLbMblVKJOIKCQdm/ghVG4RIyc1bQ3Mo
	KcQae0t94q9lbZ9wCn9Y3KkSh6oEZlaqcXlBGAL+mmp/fR0LQ==
X-Google-Smtp-Source: AGHT+IHTIkYhcz3yGT63jCfY6vWA+KoaTKDZUeq5EvU/4RPSdc9aI9E5foFa8pMoK3ht9W6OMqyEDWGmuRN1dR1TghE=
X-Received: by 2002:a17:903:19ec:b0:270:bd33:f8d0 with SMTP id
 d9443c01a7336-28ea7f63c95mr1388985ad.14.1759529443485; Fri, 03 Oct 2025
 15:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002220727.1889799-1-irogers@google.com> <20251002220727.1889799-2-irogers@google.com>
 <4a49c58a-4b07-456c-a2e6-67d04b905944@linaro.org> <aOAfPZch7tqNy9Pn@x1>
In-Reply-To: <aOAfPZch7tqNy9Pn@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Oct 2025 15:10:32 -0700
X-Gm-Features: AS18NWCjqoAaIyyP9ujehpFLwYIcZC-oq-rDTZKvlK7Ln2nmxMfmtf49po2v4ms
Message-ID: <CAP-5=fVLkpr11v4MRUgV6XQD=P1iRLix-NCY26TqJaCA3uqEiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Refactor retry/skip/fatal error handling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:08=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Oct 03, 2025 at 01:03:25PM +0100, James Clark wrote:
> > Reviewed-by: James Clark <james.clark@linaro.org>
>
> Thanks, applied to perf-tools-next,

Thanks James and Arnaldo!

Ian

