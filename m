Return-Path: <linux-kernel+bounces-895983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9659DC4F6D3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3118C0971
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3D36B06A;
	Tue, 11 Nov 2025 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="gkUFSSLG"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E772BEC30
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762885516; cv=none; b=bF3XmWgVd1vyCP+FTRaCw3EhNjiF1+2WtyKrztv9AX3j4I5Z/TYzAkrT+hyRQD5MZcgsdwqOtHjeqXq2JG5tJLWBRwmeBgO18y1JghAdHYzQEwsl8yq05TbiQGBAT7iJfEqL51k5RkWVv09ySb/QvHV5Vq/WVcFluRS81ba5dK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762885516; c=relaxed/simple;
	bh=IgfgsAUifcIa+qGktq+OSaugDBFWvLZ/6tmZQlu/PWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HA8yaDF2KlrK78ODc9YvRYeP85xc9jLWhdd48G4Jmds+jidml/nS/Hf0nRsntyNTkLLLALpK2mXpmiZemq5SWm3eVH3sBLNXlxJfOnoyAKZx8oBQniDhPSj+YJ65BgzP+MPKOq13H/XsFgH15fN64jzzIQXEupBf5WlLv85yW2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com; spf=pass smtp.mailfrom=lucidpixels.com; dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b=gkUFSSLG; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lucidpixels.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lucidpixels.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3e10d1477afso24233fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google; t=1762885513; x=1763490313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtpUxdxH6tHpXNqd2iO08w1vKvEg3zXiBARa+Otl0m0=;
        b=gkUFSSLG3tFwOG4qiNDy8uFGCp8wuL2bvlkbO3yPusrPwa7e5DbM9aY7T61eoiRm2E
         IPOO1TUBVWFyEuea/WZjLVv1NA17KIs9WxO7A3YnIAnv589Ex2mLXjbRGWiTvmm7nap/
         EGYhNizfRnrs72GBcBnDCNJRPD2DjElx6TYwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762885513; x=1763490313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtpUxdxH6tHpXNqd2iO08w1vKvEg3zXiBARa+Otl0m0=;
        b=bwj1zFzLhYW9Nu9yKTERrw9Tdqw7UHDZP0AGLSkmCPjSP7v//N+kjSDIlDzYfJF4Ki
         vQk1gCqxzBA9cX0jqJjQRhtiLiOjZxlhkKz9LFceJ7GiYO/QbaawARcx1crE4hDTg/Id
         eIYJSNRxp2HO6PoZf8iy7vKVAW3+qled7L0ezz3Qn0nfwJuKxmBm+xJ6iaCAJLr0x6pf
         0FHUHkzO9D6MgtZoFxEkC0Cgxsophy4XnlsJX0WaS+Gcbf8EUn9a46dbfIZ90ALg/pjH
         CRx/Jlpp91HDqPa31aijpfICEO7qXRPqh1P7pXVKVREMZ8YUy/mHFcwCTfbfvpJLQEfj
         garg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Ou17/PZi4ISMpsdoRa7YS21gK/RkHP535/JN3EjSw5qpbHBEF1Ex83XYar+KG5IdCtP8Qsf4i8DnD9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsslDIY/Zezu/zl8eGMhZsI0gp7rZmd9U6yOoCjMrPBSpXt70z
	aVH8ABepfRFGU6B99+ud1E2PXPYvgsz8l5To+lVllRqHD/S7AD49flDgT6x4ZDEV2vzLfN2q9yo
	ysaluOLGHeQK1LWEovWgvpyH/QPoGdv0T0APTcY3Qrg==
X-Gm-Gg: ASbGnctPC8h6hrE/wf8ZONrpLI6wEWeKFzX7JnyxZN9l0ux2pQvxYO6K0OP0vXr+Cs1
	nlCwC1bpgc81nMEHYtui3nqETxs3vddGY5nSIG9EHIl7J10Kawa9HES62P36KYeiw8/4zbi6IJ9
	zhCIxZ/203oMI9uvB+Y0C5vwkHTu7jaLfpPf6j/udsDNIBANRXuRKnCZR3Zvv+Nff1enbcCNEYN
	9XOlFsH8xpZzlZU31jVpVIjKQBAnSlPhCStCqiiQVyjgFo+SPDrBjmTLd2LR3NjGHxjcBuBjMU9
	PUlpFVATJS76b51E4iMLWR9Ppt/8BX/wanLKrKFys0lxzQ6u2Hc/WoOjKu44lEk=
X-Google-Smtp-Source: AGHT+IGVdcg1pExsgdw3sNUbMbWj2lV1fImaTNjRSyrzu1tSZotBcHq8osVRXnFb5AVR//+Vw+FtIRvg2dx8p6XhnhM=
X-Received: by 2002:a05:6870:390b:b0:3e0:788f:2600 with SMTP id
 586e51a60fabf-3e7c2530997mr5946058fac.12.1762885513036; Tue, 11 Nov 2025
 10:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
 <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com> <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
In-Reply-To: <1e4dd261-0836-4eea-b7fd-8dec9a7453d9@nvidia.com>
From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 11 Nov 2025 13:25:02 -0500
X-Gm-Features: AWmQ_blcsc3mycJcTUxkKy46KcX9boZcZZKVUf7YKxs0lHKkJ_pwLPE_zw9uDCk
Message-ID: <CAO9zADydZ=WrHbeREhWfetAupvzewM_A9Sz0RV8tY0h9CctoFA@mail.gmail.com>
Subject: Re: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chris Murphy <lists@colorremedies.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 1:08=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 11/11/25 08:56, Chris Murphy wrote:
> >
> > On Mon, Nov 10, 2025, at 10:05 AM, Justin Piszcz wrote:
> >> Hello,
> >>
> >> I am using an ASUS Pro WS W680-ACE motherboard with 2 x Samsung SSD
> >> 990 PRO with Heatsink 4TB NVME SSDs with BTRFS R1.  When a BTRFS scrub
> >> was kicked off this morning, suddenly BTRFS was noting errors for one
> >> of the drives.  The system became unusable and I had to power cycle
> >> and re-run the scrub and everything is now OK.  My question is what
> >> would cause this?
> > We'd have to see a complete dmesg at the time the problem occurred. If =
the same device holds system log files, seems like a pretty good chance non=
e of it made it to persistent storage.


> >none of it made it to persistent storage.
Absolutely correct!!  Luckily, I do have remote syslog enabled and
captured the errors that were not logged to persistent storage, do the
errors below point to an NVME firmware issue?

"2025-11-10 01:42:51","notice","user","","machine1","[4043499.402974]
BTRFS info (device nvme1n1p2): scrub: started on devid 2"
"2025-11-10 01:42:51","notice","user","","machine1","[4043499.403000]
BTRFS info (device nvme1n1p2): scrub: started on devid 1"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.683686]
nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.684742]
nvme nvme0: I/O tag 3 (c003) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.685778]
nvme nvme0: I/O tag 4 (1004) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.686802]
nvme nvme0: I/O tag 5 (c005) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712274]
nvme nvme0: I/O tag 6 (0006) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712483]
nvme nvme0: I/O tag 7 (4007) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712698]
nvme nvme0: I/O tag 8 (3008) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:22","notice","user","","machine1","[4043590.712906]
nvme nvme0: I/O tag 9 (5009) opcode 0x2 (I/O Cmd) QID 2 timeout,
aborting req_op:READ(0) size:131072"
"2025-11-10 01:44:53","notice","user","","machine1","[4043621.419061]
nvme nvme0: I/O tag 2 (a002) opcode 0x2 (I/O Cmd) QID 2 timeout, reset
controller"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.821452]
nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850059]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850351]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850630]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.850903]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851173]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851440]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851705]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:14","notice","user","","machine1","[4043702.851971]
nvme nvme0: Abort status: 0x371"
"2025-11-10 01:46:34","notice","user","","machine1","[4043722.877036]
nvme nvme0: Device not ready; aborting reset, CSTS=3D0x1"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.941289]
pcieport 0000:00:1b.4: AER: Multiple Uncorrectable (Non-Fatal) error
message received from 0000:06:00.0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.942254]
nvme nvme0: Disabling device after reset failure: -19"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969046]
I/O error, dev nvme0n1, sector 86788096 op 0x1:(WRITE) flags 0x100000
phys_seg 1 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969083]
I/O error, dev nvme0n1, sector 464581888 op 0x0:(READ) flags 0x4000
phys_seg 3 prio class 3"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969128]
I/O error, dev nvme0n1, sector 45027984 op 0x1:(WRITE) flags 0x4000800
phys_seg 1 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969127]
I/O error, dev nvme0n1, sector 117882144 op 0x1:(WRITE) flags 0x1800
phys_seg 8 prio class 2"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969146]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 2, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969163]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 4, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969160]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 3, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 5, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969167]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 6, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 7, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969179]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 8, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969184]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 9, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.969187]
BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 10, rd 0,
flush 0, corrupt 0, gen 0"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972280]
BTRFS warning (device nvme1n1p2): lost super block write due to IO
error on /dev/nvme0n1p2 (-5)"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972938]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844493824
on dev /dev/nvme0n1p2 physical 237354287104"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972957]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
on dev /dev/nvme0n1p2 physical 237354614784"
"2025-11-10 01:46:35","notice","user","","machine1","[4043722.972960]
BTRFS error (device nvme1n1p2): fixed up error at logical 782844821504
on dev /dev/nvme0n1p2 physical 237354614784"
[ ..]


> > Chris Murphy
> >
> Isolate the problem between kernel and SSD FW by:-
>
> 1. run the same workload on different vendor SSDs.
> 2. run the same workload on qemu nvme emulation.
>
> This will allow you to remove the SSD FW out of this question.

Got it, I was running 4B2QJXD7 firmware on both drives when this issue
occurred.  Recently, Samsung released a new NVME F/W update 7B2QJXD7,
which they note "address(es) an intermittent non-recognition and blue
screen issue."  I've flashed the drives to 7B2QJXD7 and will see if
this issue recurs.

>
> -ck
>
>

