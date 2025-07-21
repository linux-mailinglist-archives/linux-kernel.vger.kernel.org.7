Return-Path: <linux-kernel+bounces-739524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852BAB0C754
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED315411E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF92D949E;
	Mon, 21 Jul 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqeQj11c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694262D23BA
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111046; cv=none; b=TZ/UNG4tUkyhXycxpa6aSbZq367nn4KgZDbPYcevnIdG08sM/c4cYyBVa/4dcJ6VNvnPljW+Z3DGIoTMFEVjVOuKjXAnAyytXftZfORqdTB4yHZdfSkmUl8PGyc4ROkEXnNOSF+mHP33VRQS+ytvCSDQL5N3eSvPH3cB3NVm2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111046; c=relaxed/simple;
	bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P/Awy0x6CFn2v35ZpKm1LwrPTIDzIa7e88silxSy8HRq7trH/R8Qy5GDAvrB860S41h67rMzq2r7MyDUs6GrnJBptVjYKtH35Ge8H6GDztx+55vJHhAMNomvL4d3sIECyS3OL8SrSjqZPqOZyk06XCEYLdOrLoX9HUvjDF9i9F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqeQj11c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753111043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
	b=FqeQj11c03Z/qtmXnnm//xLU1EoT8HQpWp/DXJrvOFZNSXO2+RFgZ1JFsV6aUnIM2p2zQs
	/N8osW3+PDBvg8MiAdarUo+cQRTCqx3e5qReTNxhijdcfQyo9j0l2x71urSrFfIks3uEpN
	mrWt4l/Q5LNDcrcmbY50wIDDtHImYaE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-vpM0TZleNNy5V_IbKEeU9g-1; Mon, 21 Jul 2025 11:17:21 -0400
X-MC-Unique: vpM0TZleNNy5V_IbKEeU9g-1
X-Mimecast-MFC-AGG-ID: vpM0TZleNNy5V_IbKEeU9g_1753111041
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso46092895e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111041; x=1753715841;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bOJc5qI9pCU+UqFRuIS96bGyY+Q26kbVpDQJ2rtWBcQ=;
        b=sVztTVzY/ZnhH2MCCs8pGbHDx2dlCSywHGvBxoMV3ICxkbxq9iLLc6ZLQcFaJrJXWE
         VaQFyNrlW9nFc9PZpmmCU5DuJUyZ6zgAN/Szpt0RA9z1FK6O/P7wmJv7Gutb/CBZTOpr
         TETJesfokEFTwu2tUTmkJdS1IIsslo3j77ZdtZNmi7yfoYOdPEZBCafxncQLtcDa/3KY
         hkwAXIw3FVKH8qUSWZtglZFHqovYYLHNan8SGLmtZNmsWDyLxl7b2LNRzMe5CBlvsc/Q
         zSSZztkcfWaXnCZUiwegetGQveGL43oACojx47NM0gl7lJZD0m0StuRWDmiJb5DIEbbL
         WS1g==
X-Gm-Message-State: AOJu0YymzmexaHD14JSyu0/1AfOOEPM52Ujxs/5N+QUEX5s/VX4J0I5p
	7Is4PmD3NK9+Dofo7QpJ+JprBiUvqpqzwznZn2o0VBWGAHT7x7zDppsofjMo0m4qOmVFEDWBPBp
	bpYZud48M1eUMapwbw+vEcLfpSe/6G0oPwFkDF5Xjdu12rRhF7203ML9Yf/e8GYfbTA==
X-Gm-Gg: ASbGncup0t8WRHN/ovb6aOB9ARYaWgB3LgH3T0AvZJ6HPeTYMjVUjSDnnMOKrzYeWQk
	vmFu9Io61Trf1uZjfYLByl188dU/7DFcTXjlreBZNMdKRrmxWxv9EfAyNvgFemGyz/rB1ED3zjx
	Y4jwN/LknZNDBE2U87rra76A5jb7/+1/NTrv1d9yyRv5qYry70cTz5pqeiyXxTOWCvDUcC6lt0Q
	n4+PlWzBZpBFYGhh774+lVbjuxBuwCa5ig2mgBNcEPlSPMb2437TrOhH2+M+yEEEk4fOj/ngbhR
	/uuXTGYQDPkkUjoXr8z+Lla7x6/of/upi0Ay1OpeWEUuyIdqx99TC0xLpkoL/XVVjg==
X-Received: by 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr161756265e9.7.1753111040492;
        Mon, 21 Jul 2025 08:17:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0awfMQ1BLm9hV3QJO3Xy4wzwk/kIIZ2C8+KN2Vjm5PmNJzgT2V/sA1FHtGbF+Op2uKJWykA==
X-Received: by 2002:a05:600c:19cb:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4562e37a0ecmr161755925e9.7.1753111040048;
        Mon, 21 Jul 2025 08:17:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b762bb4f6csm314827f8f.4.2025.07.21.08.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:17:19 -0700 (PDT)
Message-ID: <85876b4f36c4230c0be34fb0b95f539179dcd445.camel@redhat.com>
Subject: Re: [PATCH v4 08/14] verification/rvgen: Organise Kconfig entries
 for nested monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 17:17:17 +0200
In-Reply-To: <20250721143814.waTN9e5C@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-9-gmonaco@redhat.com>
	 <20250721143814.waTN9e5C@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 16:38 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:18AM +0200, Gabriele Monaco wrote:
> > The current behaviour of rvgen when running with the -a option is
> > to append the necessary lines at the end of the configuration for
> > Kconfig, Makefile and tracepoints.
> >=20
> > Adapt rvgen to look for a different marker for nested monitors in
> > the
> > Kconfig file and append the line right after the last sibling,
> > instead
> > of the last monitor.
> > Also add the marker when creating a new parent monitor.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Some nitpicks below. But regardless:
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20
> > -=C2=A0=C2=A0=C2=A0 def __patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0 def _patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(self.auto_patch)
>=20
> Nit: follows PEP8 unless there is a reason not to: assert
> self.auto_patch

Well, all the python best practices I follow are the ones reported by
pylint, I guess I need to configure it to follow those.
Thanks for pointing that out!

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_to_patch =3D os.p=
ath.join(self.rv_dir, file)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D self._read=
_file(file_to_patch)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D content.re=
place(marker, line + "\n" + marker)
> > @@ -146,7 +147,7 @@ class RVGenerator:
> > =C2=A0=C2=A0=C2=A0=C2=A0 def fill_tracepoint_tooltip(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_class_type =3D=
 self.fill_monitor_class_type()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.__patch_file("rv_trace.h",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("rv_trace.h",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "// Add new monitors based on
> > CONFIG_%s here" % monitor_class_type,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "#include <monitors/%s/%s_trace.h>" %
> > (self.name, self.name))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return "=C2=A0 - Patching %s/rv_trace.h, double check the
> > result" % self.rv_dir
> > @@ -156,10 +157,15 @@ Add this line where other tracepoints are
> > included and %s is defined:
> > =C2=A0#include <monitors/%s/%s_trace.h>
> > =C2=A0""" % (self.rv_dir, monitor_class_type, self.name, self.name)
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0 def _container_marker(self, container =3D None) -> =
str:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "# Add new %smonitor=
s here" % (container + " "
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if container else
> > "")
>=20
> PEP8: container=3DNone
>=20
> And this function name is misleading, it is not marker for only
> containers.
> Perhaps _kconfig_marker() is more appropriate.

Good point.

Thanks,
Gabriele


