Return-Path: <linux-kernel+bounces-794570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08329B3E377
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE8171B45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D842561AF;
	Mon,  1 Sep 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qW3KDGAw"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2F14A4F0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730403; cv=none; b=DQmdlt3keRco1v1Xx3fruZnEiZYRI5etXPOI7ykCYx+ljiT75CkwRLEDXEJwXgjSWNdRlorQb///rODtCDE1wwq3kbXoWpTeUgNARUDKuWz2+MIYxVxv1/HAXwWUVXuWLwGB+o8fR8Qn0otbKnS0us0019a+028xNu9r1n204Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730403; c=relaxed/simple;
	bh=YU9zzwUAqqIqnW5kcV44u9Y8/Xl63sX0Ykd+8E4OQBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eg+54RX9c/d7xJbRvW5oAOr2UhPhc76CYWEtfs52+cXVW98OByiTus/b9uUW9yHN4vOD0Zlm3VfyqdhXAhNnI3291ACh7zX2JyMNeB1uoGDMoJJGUYbi/vDS0QBt0F7fGloxGWoXkD6vIB6PC4Cfgj57lPAUXImxlaRKv8Y02XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qW3KDGAw; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DD41F1A0A08;
	Mon,  1 Sep 2025 12:39:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B6DCB60699;
	Mon,  1 Sep 2025 12:39:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2582A1C22C8BB;
	Mon,  1 Sep 2025 14:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756730398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hjSaWwNhUdo85L2FwvDbHX0Dn1OV+iWxON47HA30DAg=;
	b=qW3KDGAwEBP+3rUrRyGUnSkw+Shiu1ezwLwgDAGu7hIapG7oUje42O0AEYYZehBKhjyzH8
	+A80Ho75wc7DHUsJ+Cqs3/EQsRlKyB4gsZETw2LGyH1hfbbGPdhClvd0iZSBGAI9Oojilj
	3sOhVdRRBG3141TlNwp7jC8WfxD9o9aD1ESTo/wY/N6c0yH9GQ8++a5qIuFzOcLAGyv7C1
	cUB9K2A2TdEnbjufdbOwX9g/X85bP/9IhVR6k/1fyipwoScCsfc9fuy7IKejQ5XlfJjMAI
	LnG63rs/MNym10s6Dqk15//zJofIcImQOndalGKOyAd8uo78uwtt5WWejx9OCQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: core: always verify OOB offset in mtd_check_oob_ops()
In-Reply-To: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>
	(Gabor Juhos's message of "Sun, 31 Aug 2025 16:40:10 +0200")
References: <20250831-mtd-validate-ooboffs-v1-1-d3fdce7a8698@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Mon, 01 Sep 2025 14:39:51 +0200
Message-ID: <874itmpcrs.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Gabor,

On 31/08/2025 at 16:40:10 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:

> Using an OOB offset past end of the available OOB data is invalid,
> irregardless of whether the 'ooblen' is set in the ops or not. Move
> the relevant check out from the if statement to always verify that.
>
> The 'oobtest' module executes four tests to verify how reading/writing
> OOB data past end of the devices is handled. It expects errors in case
> of these tests, but this expectation fails in the last two tests on
> MTD devices, which have no OOB bytes available.
>
> This is indicated in the test output like the following:
>
>     [  212.059416] mtd_oobtest: attempting to write past end of device
>     [  212.060379] mtd_oobtest: an error is expected...
>     [  212.066353] mtd_oobtest: error: wrote past end of device
>     [  212.071142] mtd_oobtest: attempting to read past end of device
>     [  212.076507] mtd_oobtest: an error is expected...
>     [  212.082080] mtd_oobtest: error: read past end of device
>     ...
>     [  212.330508] mtd_oobtest: finished with 2 errors
>
> For reference, here is the corresponding code from the oobtest module:
>
>     /* Attempt to write off end of device */
>     ops.mode      =3D MTD_OPS_AUTO_OOB;
>     ops.len       =3D 0;
>     ops.retlen    =3D 0;
>     ops.ooblen    =3D mtd->oobavail;
>     ops.oobretlen =3D 0;
>     ops.ooboffs   =3D 1;
>     ops.datbuf    =3D NULL;
>     ops.oobbuf    =3D writebuf;
>     pr_info("attempting to write past end of device\n");
>     pr_info("an error is expected...\n");
>     err =3D mtd_write_oob(mtd, mtd->size - mtd->writesize, &ops);
>     if (err) {
>             pr_info("error occurred as expected\n");
>     } else {
>             pr_err("error: wrote past end of device\n");
>             errcnt +=3D 1;
>     }
>
> As it can be seen, the code sets 'ooboffs' to 1, and 'ooblen' to
> mtd->oobavail which is zero in our case.
>
> Since the mtd_check_oob_ops() function only verifies 'ooboffs' if 'ooblen'
> is not zero, the 'ooboffs' value does not gets validated and the function
> returns success whereas it should fail.
>
> After the change, the oobtest module will bail out early with an error if
> there are no OOB bytes available on the MDT device under test:
>
>     # cat /sys/class/mtd/mtd0/oobavail
>     0
>     # insmod mtd_test; insmod mtd_oobtest dev=3D0
>     [  943.606228]
>     [  943.606259] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     [  943.606784] mtd_oobtest: MTD device: 0
>     [  943.612660] mtd_oobtest: MTD device size 524288, eraseblock size 1=
31072, page size 2048, count of eraseblocks 4, pages per eraseblock 64, OOB=
 size 128
>     [  943.616091] mtd_test: scanning for bad eraseblocks
>     [  943.629571] mtd_test: scanned 4 eraseblocks, 0 are bad
>     [  943.634313] mtd_oobtest: test 1 of 5
>     [  943.653402] mtd_oobtest: writing OOBs of whole device
>     [  943.653424] mtd_oobtest: error: writeoob failed at 0x0
>     [  943.657419] mtd_oobtest: error: use_len 0, use_offset 0
>     [  943.662493] mtd_oobtest: error -22 occurred
>     [  943.667574] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> This behaviour is more accurate than the current one where most tests
> are indicating successful writing of OOB data even that in fact nothing
> gets written into the device, which is quite misleading.
>
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>

Thanks a lot for this contribution, I'm ready to take it. Just one
question, do you consider it should be backported? I would tend to
answer yes to this question, which would involve you sending a v2 with:

       Fixes:
       Cc: stable...

Otherwise I can take it as-is if you convince me it is not so relevant
:-)

Cheers,
Miqu=C3=A8l

