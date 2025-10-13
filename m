Return-Path: <linux-kernel+bounces-850451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4ACBD2D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7C189D772
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580C426280A;
	Mon, 13 Oct 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTghB+NV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F625B1CE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356325; cv=none; b=kpl8MwZrQTqrp9bfRYmhse176lRx/sWKZxhso0tyUdMDAM3/ZaJOvrc5ESwmUcematZOvbldW7HPHxR07dbawIAahq1UEYrB99Gu27X2P/YivIjornb3iZ6I7OgfjlZ35nmf7nRDwSFHRzJT1R10ClO8K0oJIcK3rCjQJ5T/Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356325; c=relaxed/simple;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KmZ963l72E7gT+5ugtNwNH2kchHirnbsShBkqvJyI2yT/Y6IJwjlG3IN89IFKcrfu1GzDllF2GayW2B8JSzGI4CuaFO7sooaER3u7ZbA7az2bv3P6gsaJFLoQkbehRv224g4ZIbCDMrit2d3R2Y8JU51q4y28pE5AfcNx4CwhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTghB+NV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760356322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
	b=jTghB+NVUz3odoSjp4LpHsEHQRmSWKSzq4RDKYrSAn/8l8QpsG9vA2QoGllMndCEEbZFMg
	IhSdI94TPvX1c9TFKer1xxFguiUaWvLEWy9mc6mwzjvCiAvc6WEf193AAezD41IVHF7I+4
	4s64aGK5gXbBLmjQ6Xvji8ODW13iTIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-DzdKUnplP0S6VXjP_HKGIw-1; Mon, 13 Oct 2025 07:52:01 -0400
X-MC-Unique: DzdKUnplP0S6VXjP_HKGIw-1
X-Mimecast-MFC-AGG-ID: DzdKUnplP0S6VXjP_HKGIw_1760356319
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so27027935e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 04:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356319; x=1760961119;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ktdav36oYdJcqDA6My9s883MNaXSOg6GE7sL6+yOxY=;
        b=Ah5MZYYApPGL9CWjNU4meQD/5Sc523YVJbxHOz7w3ro2PuzY7e5MfqvQvc8FzXzOkN
         1SVJvSvR3VehdRLwACOZNAAviRvNNEyfsBx8KvL/RxZqANNRtGcMc6MTD223haW0Gxvh
         y6PygBH8w6y0qEvV70bPzM8w2cyvPYo7tvBO1pPfxZMLSBFEwRctFIFfGwDWBXwSM2gx
         LnnlOQbF8aWs+t2klFP6YkhUyzCWkcIpQhXZzzopOyOsZzH6LlBCz6iVqxuepLsdYO1g
         XIKKaZDGp8tgsrDNfABboAAinBemNzmHZ133Pjyym7Fy3yOYbYHWwBmg0VF6dZNBtd6d
         EpOA==
X-Gm-Message-State: AOJu0YyvDNC/DDfYZIs+x4H+gCn/Gq8dPe2B0OGXLcmtwMsdZn4W8rqB
	9/rUrVKJ3YYkpMyW/PgRrLlXVnrjsd8XLa0SgwONRMvN+B8IISBQAMZpdfLPbVKt87/5Ir0UH+X
	VqCyr9f+IN0d+1T0riLgAomqN47AbGd4mHM1vx2v8/lECtEF3G4opo1VPuG+ChKChV/uM0BeKwX
	JOULufeQd7tc+8Yhekh6rP5X2KVjWZiQCqddlfUlTS+lSzUkd/3hY=
X-Gm-Gg: ASbGncuOO0ZjPwWRzLKLfcQamoH6OSCuxNT7Nlteb/IxJHwRi+qfeNcRWWTROIMEaaI
	4hnoO1QtdrtmqqEbHXrOwYTyPukFNHFIeeqnvK8GW3zfRIZZw7x5n2g9UAxpkKFOeH7T1S6Zqt6
	ltriJ9Fcadn0h5FsZBT2Otg7s0+kgUAS6xLvHOadrG0bcy1P+hgy+Mn3pqoEcvax3iv/5cPVUBP
	2KpC+C7tywwpA4SA10xmzW/3EDs4EMneFwoHdNsbt3lO/9MuCnQ74xceq78sAY4XrXC/k0P3HI3
	ALvj5wmVvWVx5AxF2zw3MvVcYH3ejCJZfpOVJIj+me3G9jlWwrEc0wwvtFIattOp331g
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144924035e9.22.1760356318963;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBQpARqDOhgdRULDkvfVrdX/nnJcPItjHHJgTf6QftjMtGStmELASnMi5DCd1IOYQRiBjoDA==
X-Received: by 2002:a05:600c:1383:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46fa9af1697mr144923795e9.22.1760356318519;
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm16400021f8f.13.2025.10.13.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:51:58 -0700 (PDT)
Message-ID: <03365f64c7f94daa39bcc7df45cac2928af2a570.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Mon, 13 Oct 2025 13:51:56 +0200
In-Reply-To: <20250926094613.34030-1-gmonaco@redhat.com>
References: <20250926094613.34030-1-gmonaco@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-26 at 11:46 +0200, Gabriele Monaco wrote:
> Add a series of tests to validate the RV tracefs API and basic
> functionality.
>=20
> * available monitors:
> =C2=A0=C2=A0=C2=A0 Check that all monitors (from the monitors folder) app=
ear as
> =C2=A0=C2=A0=C2=A0 available and have a description. Works with nested mo=
nitors.
>=20
> * enable/disable:
> =C2=A0=C2=A0=C2=A0 Enable and disable all monitors and validate both the =
enabled file
> =C2=A0=C2=A0=C2=A0 and the enabled_monitors. Check that enabling containe=
r monitors
> =C2=A0=C2=A0=C2=A0 enables all nested monitors.
>=20
> * reactors:
> =C2=A0=C2=A0=C2=A0 Set all reactors and validate the setting, also for ne=
sted monitors.
>=20
> * wwnr with printk:
> =C2=A0=C2=A0=C2=A0 wwnr is broken on purpose, run it with a load and chec=
k that the
> =C2=A0=C2=A0=C2=A0 printk reactor works. Also validate disabling reacting=
_on or
> =C2=A0=C2=A0=C2=A0 monitoring_on prevents reactions.
>=20
> These tests use the ftracetest suite. The first patch of the series
> adapts ftracetest to make this possible.
>=20
> The enable/disable test cannot pass on upstream without the application
> of the fix in [1].

Steve, Nam, would you have time to have a look at this series.
If possible, I'd like to get this minimal selftest to next together with Na=
m's
(urgent) patches.

Thanks,
Gabriele

>=20
> [1] - https://lore.kernel.org/lkml/87tt0t4u19.fsf@yellow.woof
>=20
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Nam Cao <namcao@linutronix.de>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Waylon Cude <wcude@redhat.com>
> Cc: linux-trace-kernel@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
>=20
> Gabriele Monaco (2):
> =C2=A0 selftest/ftrace: Generalise ftracetest to use with RV
> =C2=A0 selftests/verification: Add initial RV tests
>=20
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/ftrace/ftracetest=C2=A0=C2=A0=C2=A0=C2=A0 |=
 34 ++++++---
> =C2=A0.../ftrace/test.d/00basic/mount_options.tc=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0.../testing/selftests/ftrace/test.d/functions |=C2=A0 6 +-
> =C2=A0.../testing/selftests/verification/.gitignore |=C2=A0 2 +
> =C2=A0tools/testing/selftests/verification/Makefile |=C2=A0 8 ++
> =C2=A0tools/testing/selftests/verification/config=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/testing/selftests/verification/settings |=C2=A0 1 +
> =C2=A0.../selftests/verification/test.d/functions=C2=A0=C2=A0 | 39 ++++++=
++++
> =C2=A0.../test.d/rv_monitor_enable_disable.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 75 +++++++++++++++++++
> =C2=A0.../verification/test.d/rv_monitor_reactor.tc | 68 ++++++++++++++++=
+
> =C2=A0.../test.d/rv_monitors_available.tc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++
> =C2=A0.../verification/test.d/rv_wwnr_printk.tc=C2=A0=C2=A0=C2=A0=C2=A0 |=
 29 +++++++
> =C2=A0.../verification/verificationtest-ktap=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 8 ++
> =C2=A014 files changed, 278 insertions(+), 14 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/verification/.gitignore
> =C2=A0create mode 100644 tools/testing/selftests/verification/Makefile
> =C2=A0create mode 100644 tools/testing/selftests/verification/config
> =C2=A0create mode 100644 tools/testing/selftests/verification/settings
> =C2=A0create mode 100644 tools/testing/selftests/verification/test.d/func=
tions
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_monitors_available.tc
> =C2=A0create mode 100644
> tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
> =C2=A0create mode 100644 tools/testing/selftests/verification/verificatio=
ntest-ktap
>=20
>=20
> base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe


