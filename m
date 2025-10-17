Return-Path: <linux-kernel+bounces-858585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4ABEB376
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6251A65E80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F733321AF;
	Fri, 17 Oct 2025 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRl2jWvR"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176632ABEC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725661; cv=none; b=O+RlbWNrm/cEFHmOrc76gB4DEAEW/Xy64mLTtP7VbjAPKG6g+4qdBDFhpRDXaiKKqoTm82Df716HHqGvBN3CL6U96GU/PW8+pkLLFtVfXSh7PaZMfPmjXHazPgcNP7h1IcOWl0NZnrHKLKi2IjaBn70oA0ZisIjT9oZy+cmR7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725661; c=relaxed/simple;
	bh=apyeGrhT2B4cjSomRBMirnJK1iCiphU7E8kwZ4eFRPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ2hDTPF/R6UUQZj76Vwnks5G3Wr1PKOyA40uFEE2yKhRl7T4xx+ypCEClAVoOhoF+qz8378cXk3n83HdPeka7tCEgZI42u0uHLzx+bcxxUUeX/ipVSpoHCN5yXLqW1crRB4g966O7zN6skq1zooC2SolX+IaOR3WcxdpTBw57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRl2jWvR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471075c0a18so23088185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760725658; x=1761330458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=lRl2jWvRw+n/iLhCD3xpKuP83ZE3tpzetVsSBAj0bBXyQezXVf3unacJZRJ0WQnmSA
         XgpciaMSHuvupkgV+rXJiKWyQRYNUOppzy/wKOKooClafXZxfeLhbNKLjhZT0ihWp+tI
         ueZBdU4waox/w5i9wVV9+rm77LqtZLquUy3vhUcO0+MfGWX9Cm406yvju6wtKW2S9RHm
         WWvSK1GmecZ1eTnrKTSCpGfCbrmHM1hejSylO2gZ/x7Ec02RYt1lh4nJViYKmVKuGsrg
         amGoHeV9E8508I62WGhJCwSOvmIWbK4HCynxoEVJ14RP4/HzaOAqt4uQOj5ZNXdiWCOr
         7p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725658; x=1761330458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNOsTI510GPBzBmWLlky+fzOisjB58DBhaGG4R2nBM8=;
        b=Ho7d1MKXIiBPAOqWsfuxsmaoSuTujf6ygUykjeSonqw++sGLSWZQ1YpFETIuHMkwD0
         4/5D7o8wMm+fV9133dS3Y51ewNrcY58DTE3DvOfORvdzj2Uf9p0camDS9rblvtGuuZWH
         Fbj4TtjdqcxegnHOR6ppzv0ZV4+DtgBmm/epmqar+278oj8F6NvqNKbk52r6UFdT7OlP
         iXuivr+5/zpQrqraJ2UhH1tsyC5vEIGy5dorhzUUrh63i932rYLYiDpL4Fau0tZN9eQS
         SZ3heyIbabtrChXY9JUamTF8QkEjocKe5q27y6EZ0rRLwEFnPfSsHzWDW9X4iRUIs0c6
         8H6g==
X-Forwarded-Encrypted: i=1; AJvYcCV3W/zdshtoX1ak6wX7h25cCxutVjyKxk2vLnW4OCnuAPu5t5zL+iHWon3eSR8FM47M2lGY3MCOQ6vH3BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBuR9Yw2sU5bu0Cy79YxwC3jY6VQXxi7yOAcDHU9Vd+DbqcNWt
	X7dzkvdLE9CLdN3j1IeUakb39S/fRLqx6AM0iiC9k1fU2E96eSB08s/CIpof4BxKPoyp/sclWmt
	LB4wZpPPI2JRzveDbH97jXevReLRng9E=
X-Gm-Gg: ASbGnctZNXBqWQdB3oGXbhyPhiIkwqG19bAQ7em7tfPwYgvyv0qp+Xgeql3cgb4SA2k
	itHfAf1IBG6nHcxFVEQ4dV6VAI5Ih4ZtQbTnFnIgnqPfBC7xiqlyJthbQZ7u1l9RMhyCYeQthZ2
	HvSd0Ci0W/txH6hPmrOCXANXFhaGCbdxtDTInwwX9jUsuJhXN8r/OpIVLGNUqHb1NDmJAni5rZ1
	d70kHiJ7zruZr3300zkWCYhf8kPxSdqPwcGWMdDyJkYvNXSr+JWQ/gyj2LLfR6fgH+h2ruyxB0G
	HoiVSQrn/hG+IaBr/4zfjx/b4vSc
X-Google-Smtp-Source: AGHT+IHrzD3MV8piW/3R5bZbNm50DZwa+/IsxY+cp8lTiOj949EZXhc7lXjq+S0IuHDeamFjuoLV5tVj/VL0xY2uTU4=
X-Received: by 2002:a05:6000:2387:b0:3e9:b7a5:5dc9 with SMTP id
 ffacd0b85a97d-42704d6d12fmr3503910f8f.23.1760725658228; Fri, 17 Oct 2025
 11:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
In-Reply-To: <20251016-xsk-v5-0-662c95eb8005@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 11:27:26 -0700
X-Gm-Features: AS18NWCyoIqaofAQbkOXYwS9xLsYBlc0BUliOKOZEhJe6-LQzeQc4XxtZWuyB4E
Message-ID: <CAADnVQLLBrawW6N4BcPvhYD2Cg_qaxSZDRU53Jq31QxR3mPDkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/15] selftests/bpf: Integrate test_xsk.c to
 test_progs framework
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Alexis Lothore <alexis.lothore@bootlin.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:45=E2=80=AFAM Bastien Curutchet (eBPF Foundation=
)
<bastien.curutchet@bootlin.com> wrote:
>
> Hi all,
>
> Now that the merge window is over, here's a respin of the previous
> iteration rebased on the latest bpf-next_base. The bug triggering the
> XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF failure when CONFIG_DEBUG_VM is
> enabled hasn't been fixed yet so I've moved the test to the flaky
> table.
>
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
>
> Some tests are flaky so they can't be integrated in the CI as they are.
> I think that fixing their flakyness would require a significant amount of
> work. So, as first step, I've excluded them from the list of tests
> migrated to the CI (cf PATCH 14). If these tests get fixed at some
> point, integrating them into the CI will be straightforward.
>
> PATCH 1 extracts test_xsk[.c/.h] from xskxceiver[.c/.h] to make the
> tests available to test_progs.
> PATCH 2 to 7 fix small issues in the current test
> PATCH 8 to 13 handle all errors to release resources instead of calling
> exit() when any error occurs.
> PATCH 14 isolates some flaky tests
> PATCH 15 integrate the non-flaky tests to the test_progs framework

Looks good, but why does it take so long to run?

time ./test_progs -t xsk
Summary: 2/66 PASSED, 0 SKIPPED, 0 FAILED

real    0m29.031s
user    0m4.414s
sys     0m20.893s

That's a big addition to overall test_progs time.
Could you reduce it to a couple seconds?

