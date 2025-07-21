Return-Path: <linux-kernel+bounces-739249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE914B0C3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD8A3A6EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DB62D372B;
	Mon, 21 Jul 2025 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZFWyXmD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6342C15B5
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753099849; cv=none; b=Rqrf63EXJJVS22DfqCUwSfmLnTSFNOOo9II4i+CrTH+jd8rbAZENuxK4ZkwWyyiaau1wwnhByoySbNY23bSyZxC9ckoSs31MG/3XTVQ44vS+hL2IU6g0Ik/8/MQYkC17UCD3pTVbRZmXA/4MqiFLduWSaDqZWkEhFACjQNJN4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753099849; c=relaxed/simple;
	bh=n2r3B6altUPpKltXRh6LT7irfPPbs+66nbggbg37vs4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=allyts+MxUhDu1hFjd+9v1iyT0jBwuGV+tERMVOr1g2iAWX/K5TXOu0U3CdN8RT99/J8h2ejpREnkUhUf/zP7F/speIF6mTFgoA6e1IYH8PrvCvzm1wk1uGuZdl+Z7kNvTTPeUbmSJkyejjvajSsPCMk09GNNv/gY8BoVYpcQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pZFWyXmD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a582e09144so2213429f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753099845; x=1753704645; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQGYtSjwm8ZBk8yiUr1gkmcZ3W0DPvO/dSFuH1qnolA=;
        b=pZFWyXmDMCIw1Pz54uBsxL5O/hbHgfShSMewwgV8mszkO68YOBIiYGQr3iwGZ4NwkN
         Sljvkh+yYlvET6fmkU3cV9e75o54kIoe/VrEmRkStzquFrXMvrzFHmQLykN4UAVhviJu
         LWGrdVQlio+VOe97rth/9fLisrHRgqsXPnmynWcLxNSebTBLo91L0Tnq8ga3X9Y2vlOg
         CCX4V8DAwyVjZvFWEnWu2bRQSMuywcJZBRsmiHgxR0NUHWAutAVmCyQf8kWaD44Q993V
         ZRMHAd0bYYpRy/cZt76Ul/s6NUREYHSfTOiVChiSOwj7A8HXbW8xNY1xHoEQLye2S8bS
         6hKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753099845; x=1753704645;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQGYtSjwm8ZBk8yiUr1gkmcZ3W0DPvO/dSFuH1qnolA=;
        b=AJ5tGCc0j7smymRCuC1aKptrlSXq0VsvKxy53X0ebXFugmWv1CyaMeLfsbiCJT8BRk
         ufjchrx5iOOXx7co2AbJG5NTO5iF1l0mhH9PVXXSXR49CBr+TFnI4Q3vbvKUMloDf0oi
         b9Kmile9pVc9CHwogjHSHwBTplE2BnAMZPmbZzEAXmxiBh/ouyjm0JIhOAimks6D2TYc
         HmgK/rpCu/lXbP3rnpIZPBkWAIkvkqAnOTm6oED2v6/mJIMXvvbGvlHQlskDsojWalZ6
         XN5TsPeNs6QDM4dQn6Xzk35qcfwA6tvQXcjMAWimZ2blppoRx3yHM1Qy9ZgJaSHGEOfS
         +m7A==
X-Forwarded-Encrypted: i=1; AJvYcCVYiE6bCKasSvhT6UCe1cRjioHHY4CF0zfDYyAPZKmBB1naCArmzEQ854ZfbWGW/hv1PRyIH5yFWdvCf3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kfZhdD9BP4tg97m1x9RvzHBVosolmhl65X+5Mbwhmqcu073T
	ouIdBqQTHnZhKzfTjHkDd4ptGVD4CRJC+ReVoGetQJy5VjaIxTaTmNwE5rjUUvbJgSM=
X-Gm-Gg: ASbGncv5/wZWW33VeSDqjpshehiIXCH5KYJJFhGXmy56Tk8P6uiwmFN8wFwtWgTIxvq
	qJkkDMw2cp8ZHU8/kfaOfqUGsXkhJEN98HzgAgb9TNwwfOv3AyOAWPX9F6eSSR6AMgy/6bSQh4o
	ARaexNL6/EIOTPDr8IA9iQm556NGWKQbIeP4mswmbyVEya75OGXiPsKTIRGLhv2dKiCkopKueZu
	ue5oTGlYNNHmuUgIe2e6U6Pg+FjsYR3ZHeM8F9XFoL/smqPPsb2b95DnSvGd9v8wesMOMKG3v2v
	qesM2uHSBwIsGSPv9eOrKHSTPqTT8M3l45EMzmWLTOabjRjR5908IIZR0Am38onPmGOZeFuZfAq
	LFo1tyPyrDYl2kX7+8EpQ7WaQlA==
X-Google-Smtp-Source: AGHT+IFC0ohH6DhVvOUrM3tqnXguszZ6/TVXCACeW4yApUHn6usADv/+L6MBPOWG7pJVIWX8OuqrJw==
X-Received: by 2002:a05:6000:2c12:b0:3b4:9721:2b16 with SMTP id ffacd0b85a97d-3b60e523deamr17084415f8f.36.1753099845431;
        Mon, 21 Jul 2025 05:10:45 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d95esm10266983f8f.75.2025.07.21.05.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:10:44 -0700 (PDT)
Message-ID: <4935395591bc8baef39d2acc491c6c40889090d9.camel@linaro.org>
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
Date: Mon, 21 Jul 2025 13:10:43 +0100
In-Reply-To: <1e06161bf49a3a88c4ea2e7a406815be56114c4f.camel@linaro.org>
References: 
	<20250407-topic-ufs-use-threaded-irq-v3-0-08bee980f71e@linaro.org>
		 <20250407-topic-ufs-use-threaded-irq-v3-3-08bee980f71e@linaro.org>
	 <1e06161bf49a3a88c4ea2e7a406815be56114c4f.camel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 13:04 +0100, Andr=C3=A9 Draszik wrote:
> Hi,
>=20
> On Mon, 2025-04-07 at 12:17 +0200, Neil Armstrong wrote:
> > On systems with a large number request slots and unavailable MCQ ESI,
> > the current design of the interrupt handler can delay handling of
> > other subsystems interrupts causing display artifacts, GPU stalls
> > or system firmware requests timeouts.
> >=20
> > Since the interrupt routine can take quite some time, it's
> > preferable to move it to a threaded handler and leave the
> > hard interrupt handler wake up the threaded interrupt routine,
> > the interrupt line would be masked until the processing is
> > finished in the thread thanks to the IRQS_ONESHOT flag.
> >=20
> > When MCQ & ESI interrupts are enabled the I/O completions are now
> > directly handled in the "hard" interrupt routine to keep IOPs high
> > since queues handling is done in separate per-queue interrupt routines.
>=20
> This patch adversely affects Pixel 6 UFS performance. It has a
> UFSHCI v3.x controller I believe (and therefore probably all
> devices with < v4) - if my limited understanding is correct,
> MCQ & ESI are a feature of v4 controllers only.
>=20
> On Pixel 6, fio reports following performance on linux-next with
> this patch:
>=20
> read [1] / write [2]:
> =C2=A0=C2=A0 READ: bw=3D17.1MiB/s (17.9MB/s), 17.1MiB/s-17.1MiB/s (17.9MB=
/s-17.9MB/s), io=3D684MiB (718MB), run=3D40001-40001msec
> =C2=A0 WRITE: bw=3D20.6MiB/s (21.5MB/s), 20.6MiB/s-20.6MiB/s (21.5MB/s-21=
.5MB/s), io=3D822MiB (862MB), run=3D40003-40003msec
>=20
> With this patch reverted, performance changes back to:
>=20
> read [1] / write [2]:
>=20
> =C2=A0=C2=A0 READ: bw=3D19.9MiB/s (20.8MB/s), 19.9MiB/s-19.9MiB/s (20.8MB=
/s-20.8MB/s), io=3D795MiB (833MB), run=3D40001-40001msec
> =C2=A0 WRITE: bw=3D28.0MiB/s (29.4MB/s), 28.0MiB/s-28.0MiB/s (29.4MB/s-29=
.4MB/s), io=3D1122MiB (1176MB), run=3D40003-40003msec
>=20
> all over multiple runs.
>=20
> which is a ~26% reduction for write and ~14% reduction for read.
>=20
> PCBenchmark even reports performance drops of ~41%.

Additional fio results (numjobs=3D8 instead of 1):

current linux-next:

fio --name=3Drandread --rw=3Drandread --ioengine=3Dlibaio --direct=3D1 --bs=
=3D4k --numjobs=3D8 --size=3D1g --runtime=3D30 --time_based --end_fsync=3D1=
 --
group_reporting --filename=3D/foo
   READ: bw=3D52.1MiB/s (54.6MB/s), 52.1MiB/s-52.1MiB/s (54.6MB/s-54.6MB/s)=
, io=3D1562MiB (1638MB), run=3D30001-30001msec
  WRITE: bw=3D74.7MiB/s (78.3MB/s), 74.7MiB/s-74.7MiB/s (78.3MB/s-78.3MB/s)=
, io=3D2242MiB (2351MB), run=3D30004-30004msec


with patch reverted:

fio --name=3Drandread --rw=3Drandread --ioengine=3Dlibaio --direct=3D1 --bs=
=3D4k --numjobs=3D8 --size=3D1g --runtime=3D30 --time_based --end_fsync=3D1=
 --
group_reporting --filename=3D/foo
   READ: bw=3D83.5MiB/s (87.6MB/s), 83.5MiB/s-83.5MiB/s (87.6MB/s-87.6MB/s)=
, io=3D2506MiB (2628MB), run=3D30001-30001msec
  WRITE: bw=3D83.3MiB/s (87.4MB/s), 83.3MiB/s-83.3MiB/s (87.4MB/s-87.4MB/s)=
, io=3D2501MiB (2622MB), run=3D30003-30003msec



which is an even higher 37% reduction for read.

A.

