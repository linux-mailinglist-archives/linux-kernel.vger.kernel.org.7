Return-Path: <linux-kernel+bounces-876950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB8C1CD56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B1B4E0800
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE789357A38;
	Wed, 29 Oct 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEsbGL2Q"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF32F5478
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764075; cv=none; b=CqUXgf0qUAkZ74FYmskgQYJWvb1MXNngi8z5S7jK/Sjc/zg1Tt4KUoYWWhgM7r4RBg3NmbGO4ijZdAdu41Wvls2F/+SiGQPonWdugjUBwKWz0Dzo1tgaBrHXa9Oh9Af7h3n4Qbm8RQ1vS5l1ZXF17K6myQjDO9l5j1AYp3mFzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764075; c=relaxed/simple;
	bh=tfrrqiHlm+2CRiFs/ycrLpo5VsMmuPxIYN2ybQlzcdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxiXsDlDDdsmguvVqTGOJZ5GTbY8yZ712uYBy2uByDjf5u1gWmhJHODPfBbTeyx+w9CQbIGkaC9TbXuhBStkpIsFKyCGEzws124qac7LNWY7Yh0SKhgHDALDxeEN+Yc4UAWWbVk+sPtF7aHvmuAsHuo2L9cJklQ0J+sBfT0bUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEsbGL2Q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bcb25so100088f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761764072; x=1762368872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roxFu9ym+QUdO36nnH4tAkn59H/+sYMPT1Nh/9cDSsE=;
        b=NEsbGL2Q0saxaA4dUzrXfAgbNiTZ0MHxUHGzcCYzwLVwnKTHZJEhfTTxGfy6kFLeDt
         7JiQ4XcfpgfmB+hYjDbq4Vw0seCjDmG0Wpa8BvON/9mXeBXRZWVe6O2CXJG11ILUUHKw
         MgKCf/4ibNfabDKoxbnGPYhx92Irv1m8b8Q00gtPtN20nOf3jTrhsYwCQtgZmQdfEYGx
         4cv7WZjZliCzOXGLQpLvoskM5nX5sk9c/TCqJqAvaH0XXoV6MiXzYJR3S+PzZzeN3xEP
         SRb2HrbjiBLkS20Z9tY4zAbLoLyEKM+L/rPozjxfZy5qxDlNkBYGfS2XSB0tuoO5MCRl
         WaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764072; x=1762368872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roxFu9ym+QUdO36nnH4tAkn59H/+sYMPT1Nh/9cDSsE=;
        b=NHP6x2SeSTMszDBUAxcURwIXXiBq738r9ukHmjVPfbwnPEtvyAq/yAI7zlPZsxaKwd
         4m2t15PxToTwBJBy0aegRPI0d2nNp7fRM9uV67eh/bsfF6vDuyZnEDZw5YZq66IM6IWf
         3FBJ47HVCR/xCKrkZR5oxRSNe6N0wjlOU9rNIsdwlk6EjwQCji7Py4k2ar2oyHu67YeQ
         mrFT+2TzkbT1FSmngvWC9o1NgAmo+XBB2cGuv9c7qqadcR6TgfevFGc7rLKbbfGJhJTL
         LBE3SBSC6QodfVEthrRCDUhTY3944980Sgp/yYhk56VkB2WijZWP5e7pHBjmhZqxyd/b
         lGaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXauh6fU85BxwmKhuW2G9aFb/g7ZajW9HUiAGvrw2dieb9Mj12x8v95p/LCJYxVgzaCN1mbSCQ3wPjDfNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DduCBa1iwbjVpyZEz/sftSaJG8M/vLmPEMF/C/9EOl/MaJet
	pIuKY9TAsd/gOlo7LFziNKjrmR2bTgSblVw2ExeYl050Fnh1xpNGAAk1s+OVBPFseGEz3CmyqC4
	Q+TCgg2fCXPCb1KQZtmBZ+WA5ueQfIrQ=
X-Gm-Gg: ASbGnctET5UHNc+FyLN4kMiT+jWfPiKUtB+xDs3HzFoAiEoJk112SZiKqNSQH1n8hJP
	Cy9Uwwz+qJvKF4jsGMFnJk188h5ltVAnWCKrhdLciwrwWyNZbpLSzY/pX/AN5j7b2sT+xy0PXk5
	w9xN2Aqji03x87x/O09A34W+EImQTfKGp7qyPpIG0UTZPI8oNr4YSx28M2HRtwe6W+pS3bWT1xs
	iBxjwJDAPVuXQb4INZHqGcl+7LZt3sc9WH3weS+1hLm7a36kOu7/y0B30RuEMdSF8nwDFpBYov1
	h6uGjub4USa1YzI4h4UrycpD9VFj
X-Google-Smtp-Source: AGHT+IFxIb7bNC1qwVAw0u5ykRrFlzlmlmI3GOlPxtbfY1thoEM0CrkK6Ie988xkFO1EgUD8c/G7q6CFgK/yrR8Vvkk=
X-Received: by 2002:a05:6000:4028:b0:427:e1bf:13db with SMTP id
 ffacd0b85a97d-429b4c9dea4mr497598f8f.54.1761764071322; Wed, 29 Oct 2025
 11:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
In-Reply-To: <20251029-xsk-v6-0-5a63a64dff98@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 11:54:20 -0700
X-Gm-Features: AWmQ_bmBJf_PxnDtsc_z2JtFmdbUNa75aAnfXrHEJ4pN3hlfPLu31Ua4sAtQpOE
Message-ID: <CAADnVQ+ESBTW-+NOQ55HXLwODFZa+uHWzMpPAq1FfjPP4otH_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 00/15] selftests/bpf: Integrate test_xsk.c to
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

On Wed, Oct 29, 2025 at 6:52=E2=80=AFAM Bastien Curutchet (eBPF Foundation)
<bastien.curutchet@bootlin.com> wrote:
>
> Hi all,
>
> The test_xsk.sh script covers many AF_XDP use cases. The tests it runs
> are defined in xksxceiver.c. Since this script is used to test real
> hardware, the goal here is to leave it as it is, and only integrate the
> tests that run on veth peers into the test_progs framework.
>
> I've looked into what could improve the speed in the CI:
> - some tests are skipped when run on veth peers in a VM (because they
>   rely on huge page allocation or HW rings). This skipping logic still
>   takes some time and can be easily avoided.
> - the TEARDOWN test is quite long (several seconds on its own) because
>   it runs the same test 10 times in a row to ensure the teardown process
>   works properly
>
> With theses tests fully skipped in the CI and the veth setup done only
> once for each mode (DRV / SKB), the execution time is reduced to about 5
> seconds on my setup.
> ```
> $ tools/testing/selftests/bpf/vmtest.sh -d $HOME/ebpf/output-regular/ -- =
time ./test_progs -t xsk
> [...]
> real    0m 5.04s
> user    0m 0.38s
> sys     0m 1.61s

This is fine. I see
Summary: 2/48 PASSED, 0 SKIPPED, 0 FAILED

real    0m8.165s
user    0m1.795s
sys     0m4.740s

on debug kernel with kasan which is ok.

But it conflicts with itself :(

$ test_progs -j -t xsk

All error logs:
setup_veth:FAIL:ip link add veth0 numtxqueues 4 numrxqueues 4 type
veth peer name veth1 numtxqueues 4 numrxqueues 4 unexpected error: 512
(errno 2)
test_xsk_drv:FAIL:setup veth unexpected error: -1 (errno 2)
#664     xsk_drv:FAIL
Summary: 1/24 PASSED, 0 SKIPPED, 1 FAILED

Pls fix the parallel run and not by adding "_serial", of course.

pw-bot: cr

