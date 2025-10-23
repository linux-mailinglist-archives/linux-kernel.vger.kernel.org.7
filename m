Return-Path: <linux-kernel+bounces-867257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49015C02105
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AFD3A9C61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7233321C2;
	Thu, 23 Oct 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMTADMlE"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296E315766
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232171; cv=none; b=DSOrN7e3F324LwuNe6Nr+Utvw+G5CNsWrmOt6j9HZXEESWOP11T821Bb8FV19rnCx4cCjbkI1tDmHbbZzdyu4vNmp2RHckvPjzmFqYQRNyzR9L9ks47uEGqvA1JoNHhw/81CK1JX2ltdyM90m006VUf9jazNfluNNkHHMBisw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232171; c=relaxed/simple;
	bh=5X3IgpM/ixFUUNAM9uIBuAadN03MLsIicS3hc4c7CY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgLO3RI/IhYuS3wcQiIBuMZ2ySVeubvqmSVUkpIdHdFqyK873CTuYEl7dH927FSlJ6CNxQ4+PktbTE8RBjbW8Vb1d+PsPfL0LvHeGdMDBgXVZ/6eto4cjs1GYN0wV0wkB+cfLyOhhcwemmQqRh33jh2vtQhQjBimLiFe2xY5dK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMTADMlE; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so203211666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761232168; x=1761836968; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5X3IgpM/ixFUUNAM9uIBuAadN03MLsIicS3hc4c7CY8=;
        b=bMTADMlE7c3xHIZ6EV8URigXqs67Tu2FForU4ScFR/sou/nW7cuUpwcJJMju3qCqDy
         6zs5pj90bfGw5HziTjMB9MiVcm1urkdTe9UjENG6Ab6tbJXecAVXCB8T+XelN8d8n+JP
         tvReAAhLqIIJRltbdQ4Emsd3K/Jo1C7VGw7W9FzUar3ecHIxlzt/02hLyGlGzt9JFpKx
         wYrKKE4Ihq6/rxpNHQXp2Ot6baOlYA3qj+pnp1uyHNxd3RoD3ywUiXmZI/LlfqGcxnD2
         SRc+BGR/8cnbn5c7Bu6ZgByHDRh7BmhTZfhGJUD/RfhZR7KZ3nOvoXnL2m2PlPx+x/aw
         J7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761232168; x=1761836968;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X3IgpM/ixFUUNAM9uIBuAadN03MLsIicS3hc4c7CY8=;
        b=BUehdYEDR2i05LxkZxZVYJZQzwGR1QRNdMF15G1iDfE61TicEJ9/DoiKz/899lTOUa
         CnegbBP/6uaU48SJB+XEi62ST8O+0a2BQCbpGji0uTWP+GxxNFXo6DY/gaFYn2R7fmjJ
         UjkHKYnh/D8dTL+d56pPnCUqQ2bec9+k5XTwYzvPdsHYYpsst7s8boY+rn3P5F05d9A+
         3prxXAxr7S9uny5lvGOZKB95ejCyjEOVdaTCOf+0jFULpYiECaSTsIpaMeZlRgESeaLb
         NW5s70NHZ0xVUV3qso58OgZfdwj4ABURFU3IX+PAyNSXznNQDe4VlMAJuVSgqM0gJ2aD
         lVqg==
X-Forwarded-Encrypted: i=1; AJvYcCXlDDem7JLMtz5sKPeuUYt1a1XIJXLaASy900xk7JdqkYnQ/C/4zO5r+z6RgjY45BtjoA7Z1/FQ38rANRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWMjy59sbkNy4zNjmdiydS82v8Vri/60AlytrOSd11V3849Tv
	9CZBe20W0dCtlRdIdvCi0L4dwFKjUgEQkWd1D984nk3s5Q0JOarDrkgx
X-Gm-Gg: ASbGnct25Vj5lvJnof27w8LCsHlqRfvF408Kbdqj0Ih+kcM64gdTL24BhzKHaZBqfnl
	zgob6Hmi6cRqIB/zILNSt28uGOckfzAqW55k/dTmuAahYhtkW3vBxe0JxvAC1K4MfdXZ8K1iaGp
	tbWutsD5vneColn3FiEBMEHrZVgJQN7KBJkCb7enw0XPctjbpCskINz2DDIXiGbK8v4Gg6nmc+L
	cPbPvBDhtwALe625PvnU3k1Rdjtp6qmSWp5EVSDvCmUwc09+WZHScUpGMDKwWy2FVU95mFDvPM9
	BeRXXRaTZ4LXIqVzvLYCUYTcrbgt8SSAzc5rGzwyY0kh0HR2MxSaO0Hkvig3/cgn4e8OhLXpQPz
	9OnE8lBCGUszcpTsCnt5COhW3dbX6mgjmMeNZoSgQUMbnDffbUsV0AewdANTe9+uKD9eg8OVh00
	/IhTA3isj3N+Ws8Q==
X-Google-Smtp-Source: AGHT+IGjQzu4HQMYvVKaEXQllFhwmuknoqmx0ur/s+VfbFfwCPYQWL9phbO+RD9JNTxazfFwVowNIA==
X-Received: by 2002:a17:907:984:b0:b46:8bad:6972 with SMTP id a640c23a62f3a-b6474b3725fmr3075602666b.38.1761232167735;
        Thu, 23 Oct 2025 08:09:27 -0700 (PDT)
Received: from [10.176.235.211] ([137.201.254.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d119asm240701666b.6.2025.10.23.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:09:27 -0700 (PDT)
Message-ID: <9f3d1d277b0d102b5d912b533be21ed78103e142.camel@gmail.com>
Subject: Re: [PATCH v5 3/3] scsi: ufs: core: Add OP-TEE based RPMB driver
 for UFS devices
From: Bean Huo <huobean@gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: avri.altman@wdc.com, avri.altman@sandisk.com, bvanassche@acm.org, 
	alim.akhtar@samsung.com, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	can.guo@oss.qualcomm.com, ulf.hansson@linaro.org, beanhuo@micron.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Oct 2025 17:09:25 +0200
In-Reply-To: <CAHUa44FfQAPWGgVbfrCnZfF9HkGwW=fgUhV-y9RKrUQf1V6yNg@mail.gmail.com>
References: <20251021124254.1120214-1-beanhuo@iokpp.de>
	 <20251021124254.1120214-4-beanhuo@iokpp.de>
	 <CAHUa44FfQAPWGgVbfrCnZfF9HkGwW=fgUhV-y9RKrUQf1V6yNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 15:53 +0200, Jens Wiklander wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_id =3D kasprintf(GFP_KERNE=
L, "%04X-%04X-%s-%s-%04X-%04X",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_info->wmanufacturerid, dev_info-
> > >wspecversion,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 dev_info->model, serial_hex, device_version,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 manufacture_date);
>=20
>=20
> The device ID is part of the ABI with the secure world or the firmware
> we're serving. It might be worth adding a comment so the format isn't
> changed without understanding the consequences.
>=20
> Cheers,
> Jens


Jens,=20

I can add, do you have suggestion for this reminder message, for example:

/*
 * WARNING: This device ID format is part of the stable ABI between
 * the kernel and secure world (OP-TEE). Any changes to this format
 * must be coordinated with firmware updates to avoid breaking
 * communication with the secure world.
 */

or=20

/* Device ID format is ABI with secure world - do not change without firmwa=
re
coordination */



or ?



Kind regards,
Bean


