Return-Path: <linux-kernel+bounces-739242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133BAB0C3CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1BB3A34DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB71329188C;
	Mon, 21 Jul 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ty9Sb9yT"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E728C871
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099499; cv=none; b=EWz+NKScBd4RXERhuGhgHKEt7WJV92sHzMQ0Yyo8jzNsDnipNVJ9WCMOHiVXRxu7OM47FrZOUHYlrDzZeSG6WdUQceczyevo032/whYWNr8E8LN2u1cim6OUNsJKX/5R3s8cRs4tbj/KIxdWknwpqNCG513zMC0Ogrh/YFiTD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099499; c=relaxed/simple;
	bh=AgmplPpBkqPJHRgbv/ilKQnYSL6wMtJX7Lhc35iZubw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxBW2pV+qQUwTCOpv0tpeRkulaXE3GCviTDqDtf8KQgrudG6dDgVFkJFcZUycJ7m0u3LixnSscl+jRLOVxuKXRurMQ4jN3s5zsJUBgu4w+GNXQVmWJYGV7AsQkm/LA7g8CCMP8Zo9BQ4yYrI88fj6UaH9C7TpxOj+OZy5l73WsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ty9Sb9yT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4f379662cso3166711f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753099495; x=1753704295; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFsy0N8dFit2yuYg6+8lEXnZLwOaEpoo8BHtjGWuFq8=;
        b=Ty9Sb9yTvEGhe+x2nQJ7otZm+LVhHzxmFeZiJMi1mx4cbrFQFhSkTRX2mXujpFZBDm
         GoZvGwi86N9M3oiigTLQ0b4Xef6cqHIHsCfjd6Hkx+80AA0EPTiWYk9H07sGC3xDItz+
         FeZ+oEZN3qMRDnAzl9DxmEjs3lxW8ZS01uQA22EtAk91T3I/nH/CJut4vbqO2S+tTEGu
         +DSAOt2aLsTLwFUsp7fWHluV+wkSBJB8wJWX4ntV3JSEK7E8itbCeWkNotRIpVoBCB7v
         lmjZCpoMT079EvDKplnS6ogXSSfZQsFt4CItGIaj2ul+NNX6j5C2oC0dect5mR1MLNrX
         a9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753099495; x=1753704295;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFsy0N8dFit2yuYg6+8lEXnZLwOaEpoo8BHtjGWuFq8=;
        b=de7HXIb1DkEV+ZYX9XjXS0vGf1MSvixWKFIXLs33sldqdUO/Xit7sEa6sD5NgUM5yn
         mmMTgRqiec7ob/GiMqWWqp2L6xOR+hcVWx9/RM+EZR1uUDbV+WFHvp2hW6YJBbyEPUTm
         R88SWxNwVRUgWmvV2GjiIlA7IC9JOgKusU2KnLMV4noVbMdlMlnpVWlLL1jiHztFZb0/
         6PRx2vmFYDhds5Wby2ZgbPFcs5R6jiVmZ8FvW/7e/cboVCW1wOzRBNa/L96VIccXAEbt
         NcHpI8/ty4Is9rnaWH07Nx8w2Rr3mZS10Bf8SzjqFR9Zr5/LLxGRvTdOlgF9sYxbYGge
         T17w==
X-Forwarded-Encrypted: i=1; AJvYcCX05upUApuaAHtWKBQCxfmRdHHVM/Ry/JFyioYqIZ5yrqqGWyOKMgNLP60kuEw5w6iHFTb30z7kZ2zN2oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCIjtXOh7idR7pnsRKw1HfkJ7Gnw1gwcDgKSI2+q5QlpeELot
	NA8qR7+UWbdu3gehSNn14KvlwCy9/Pv5Zu5IUWGWLGg0K7eZY8GJjjolyetxfEGth4k=
X-Gm-Gg: ASbGnctLGLxRarK78J+v9WRCBiDCjA6WmV1m8oKFqzmJnDn12v8p80C+Ng6uBkROaSK
	oAEt8dipPLW4ml9RopqlHpYGV5RIWtNrqtaDyeyPomNDPwfwoLxN8cZwD4Pm7JJn0gBjqEPCr5H
	In/UDHpp2ngz5V/5LkkY1Sak4lgxcq2/8/AJtcahVYiLXSGeqwmsDFGgKyj32x4RSrwwrUMV4Sm
	wtqCflTuo0bf/ZWdJ8o/qPciC0Iia1EIYNQNP4koqo+5AFQ5HKURDb6Z+3i8bNGjcbscgf8U8M7
	Eve/O5YXsZ8FzkE21tmwy0/HCxjpMLzCtC/dZl3Kk44k7SSk/hPp72qGDmfMp2HGdC0QjScQ8j8
	kfPiZ1dDEiJZ/abIOgpCXmeTbdA==
X-Google-Smtp-Source: AGHT+IGjfeFn2Z+6zri73vruVzHD1bBxX9f1u0kiaMUuw25HI377CkPNalTMB/vUfycg6NzuXJEDNg==
X-Received: by 2002:a05:6000:2385:b0:3a4:dd8e:e16d with SMTP id ffacd0b85a97d-3b60e4c2194mr16565406f8f.15.1753099495341;
        Mon, 21 Jul 2025 05:04:55 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487a5sm10222123f8f.42.2025.07.21.05.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:04:54 -0700 (PDT)
Message-ID: <1e06161bf49a3a88c4ea2e7a406815be56114c4f.camel@linaro.org>
Subject: Re: [PATCH RFT v3 3/3] ufs: core: delegate the interrupt service
 routine to a threaded irq handler
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, Alim Akhtar	
 <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart Van
 Assche	 <bvanassche@acm.org>, "James E.J. Bottomley"	
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"	
 <martin.petersen@oracle.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, Tudor
 Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 21 Jul 2025 13:04:53 +0100
In-Reply-To: <20250407-topic-ufs-use-threaded-irq-v3-3-08bee980f71e@linaro.org>
References: 
	<20250407-topic-ufs-use-threaded-irq-v3-0-08bee980f71e@linaro.org>
	 <20250407-topic-ufs-use-threaded-irq-v3-3-08bee980f71e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Mon, 2025-04-07 at 12:17 +0200, Neil Armstrong wrote:
> On systems with a large number request slots and unavailable MCQ ESI,
> the current design of the interrupt handler can delay handling of
> other subsystems interrupts causing display artifacts, GPU stalls
> or system firmware requests timeouts.
>=20
> Since the interrupt routine can take quite some time, it's
> preferable to move it to a threaded handler and leave the
> hard interrupt handler wake up the threaded interrupt routine,
> the interrupt line would be masked until the processing is
> finished in the thread thanks to the IRQS_ONESHOT flag.
>=20
> When MCQ & ESI interrupts are enabled the I/O completions are now
> directly handled in the "hard" interrupt routine to keep IOPs high
> since queues handling is done in separate per-queue interrupt routines.

This patch adversely affects Pixel 6 UFS performance. It has a
UFSHCI v3.x controller I believe (and therefore probably all
devices with < v4) - if my limited understanding is correct,
MCQ & ESI are a feature of v4 controllers only.

On Pixel 6, fio reports following performance on linux-next with
this patch:

read [1] / write [2]:
   READ: bw=3D17.1MiB/s (17.9MB/s), 17.1MiB/s-17.1MiB/s (17.9MB/s-17.9MB/s)=
, io=3D684MiB (718MB), run=3D40001-40001msec
  WRITE: bw=3D20.6MiB/s (21.5MB/s), 20.6MiB/s-20.6MiB/s (21.5MB/s-21.5MB/s)=
, io=3D822MiB (862MB), run=3D40003-40003msec

With this patch reverted, performance changes back to:

read [1] / write [2]:

   READ: bw=3D19.9MiB/s (20.8MB/s), 19.9MiB/s-19.9MiB/s (20.8MB/s-20.8MB/s)=
, io=3D795MiB (833MB), run=3D40001-40001msec
  WRITE: bw=3D28.0MiB/s (29.4MB/s), 28.0MiB/s-28.0MiB/s (29.4MB/s-29.4MB/s)=
, io=3D1122MiB (1176MB), run=3D40003-40003msec

all over multiple runs.

which is a ~26% reduction for write and ~14% reduction for read.

PCBenchmark even reports performance drops of ~41%.


I don't know much about UFS at this stage, but could the code simply
check for the controller version and revert to original behaviour
if < v4? Any thoughts on such a change?


[1]: fio --name=3Drandread --rw=3Drandread --ioengine=3Dlibaio --direct=3D1=
 \
         --bs=3D4k --numjobs=3D1 --size=3D1g --ramp_time=3D10 --runtime=3D4=
0 --time_based \
         --end_fsync=3D1 --group_reporting --filename=3D/foo

[2]: fio --name=3Drandwrite --rw=3Drandwrite --ioengine=3Dlibaio --direct=
=3D1 \
         --bs=3D4k --numjobs=3D1 --size=3D1g --ramp_time=3D10 --runtime=3D4=
0 --time_based \
         --end_fsync=3D1 --group_reporting --filename=3D/foo

Cheers,
Andre'

