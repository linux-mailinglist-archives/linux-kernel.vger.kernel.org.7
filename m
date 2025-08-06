Return-Path: <linux-kernel+bounces-757746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6BB1C630
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A966356434B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00A28B400;
	Wed,  6 Aug 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKlS7+gT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588341DE89B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484329; cv=none; b=mX1UObDe8tIEJVcp9bU3ylm2AmsvJq8OJam08pXXfD+FGRfVzTPIahTsXIChlNxgzYfjDFsPCTfOOaq5B3ofWAwmFV/mRqPg6hnvivAKB/2udGn85wY3s8UJ450elv7xV/JKXxRTCxmxm56ySVRj6BH1EnscLeaONEkMZezOdCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484329; c=relaxed/simple;
	bh=Ja8eqE4UilGLkdfTXr/G4n4kO+Jow1TUt/LNR3e8WgE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMtCBe1voUJE12q3fHOHRlALgO0DhYPldN7KD74IvRNWwZUXBndtEeCWl7MbxH+ygjxR8PAsMTxmyYrKYKMgTRUDZNrmNB+eSLbPP0eBBVPKFDUud8BXySwH9SPYfU/NlHjD3sCIdXBikzt2WxZPPIdOk7uHcbLqQfz1opPd8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKlS7+gT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754484327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jMjNHNQ0G5LG4I1RqSHiwTb0enyDrEvAe+FlJh6jMwA=;
	b=aKlS7+gTcVXRvbrqqd54/otQisHB0JcRGAf0JUxwTNLoe+AWHMDXyMZR9r+in6pnpfi0So
	h9mQERynPTtk2O97ILLRVI3ussB+iERay+V8pqzPfM7g1aWyvcw6IAlN57mx0GgpYd3+ci
	pmCvvYH+DTt+8k9u8Wdmd0HK71um6Bc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-QF__EK-EPmasoR9ggporpg-1; Wed, 06 Aug 2025 08:45:26 -0400
X-MC-Unique: QF__EK-EPmasoR9ggporpg-1
X-Mimecast-MFC-AGG-ID: QF__EK-EPmasoR9ggporpg_1754484326
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4aedcff08fdso112356851cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754484326; x=1755089126;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMjNHNQ0G5LG4I1RqSHiwTb0enyDrEvAe+FlJh6jMwA=;
        b=dchSQRQf5X5dI/Re2kfXkenAtVPt3dOOtfv2H1QZybqcYZHQsNnr0OvfxD0UxJMWj5
         IVOyzllOg+Cu7OIzbdZIS5O5yWGy5TTVTbGhzssX4Ags5Y+swMMwZ+lSZ58s77zy/bXC
         RnLWjVbiihkI+Lr3ZzP6nZOytxU3NrN9z8qO/T9iGMbi5MdYxA9NDiHgpuvGPOP6og2l
         RAMWMZ1rZgVQrYIUzsIkeHUKF99eviNmcuIy95RnYi/F8MlZIBMp2o3L20Im9dT1Q4Tl
         LnsD5Mquy+WQ1bD7SvLWvlzDpU0X4Jb16ChliZDH8MxbEXq2CjXeGvISx1t+DQc5FKvS
         APaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJa7Yo4gFLWhbzv+QAfRfEsO3JSZ61lPzqIDZuzgGFx4pyf8erM96W3ug/sUGrIDxd5BT5R+AhkqLlTqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvsNadBfgZ9gLPZf4grjOtkwl+OR0AwTbAEZAPiuTexHSrc7+/
	2E2GJby1MZNkto3xGeyXi3iKIJU08OJbkdtD2ZYJJcgKRNDcoI7p+kigxrRW4E4KgWsD/GEldNd
	hVbZvND/mX6BFQIWbEHZEHmQzLSOWKYsObxp7VSLJCWGusjTgKztkWV8CLAvRGjEWwA==
X-Gm-Gg: ASbGncum1p9RjrWE3HZXW4C7UO/+Y4wBur9AcTzZ1I/hBI2AOHvQo3ngAtcP6p6c1EM
	kMi3Swz+8AhcfRslD0LMpYLbtSe4Nh4XA2PogXlgoaReJItJLVmZ3X+PztOllalHUkq2x+uTAtX
	/WpaGrbU5Mqgbdf5jewT0FsqR8jhVbNEg2WQ+GxK8L4vjCZlwWc2bhiEj7bYnRHl38IMfHjvcnL
	xA/3j1MVnYqaD6+N/A7GZ5HpiuSp9KL5FB7ghoCfkvkaAaBGNDSVHsy6S+5kv2lp3X4DACi3jIA
	I5Fz40fy9ObH0HIHqeBbx+MTKoRswUS6EN3ypJE3iFHZgdoKOQeNYVbnE0HcaADhCA==
X-Received: by 2002:a05:622a:355:b0:4b0:8f6e:d728 with SMTP id d75a77b69052e-4b09138c9c0mr38195671cf.21.1754484325750;
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTMYU08BgHnXR1+czy5QcVCMHzz8YG+OtEkdxRx4oxsXU/v8COQ+2pdCxkJHBTMz4Q6mU6DQ==
X-Received: by 2002:a05:622a:355:b0:4b0:8f6e:d728 with SMTP id d75a77b69052e-4b09138c9c0mr38195381cf.21.1754484325386;
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b085ad7d08sm19326441cf.53.2025.08.06.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:45:25 -0700 (PDT)
Message-ID: <8f379f2072ee12afda37455aa0ad4e37d53c4f2d.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Aug 2025 14:45:22 +0200
In-Reply-To: <20250806120911.989365-1-namcao@linutronix.de>
References: <20250806120911.989365-1-namcao@linutronix.de>
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



On Wed, 2025-08-06 at 14:09 +0200, Nam Cao wrote:
> Argument 'p' of enabled_monitors_next() is not a pointer to struct
> rv_monitor, it is actually a pointer to the list_head inside struct
> rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.
>=20
> This wrong type cast has been there since the beginning. But it still
> worked because the list_head was the first field in struct
> rv_monitor_def.
> This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
> rv_monitor_def into struct rv_monitor") moved the list_head, and this
> wrong type cast became a functional problem.
>=20
> Properly use container_of() instead.

Good catch, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index bd7d56dbf6c2..6ce3495164d8 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -495,7 +495,7 @@ static void *available_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0 */
> =C2=A0static void *enabled_monitors_next(struct seq_file *m, void *p,
> loff_t *pos)
> =C2=A0{
> -	struct rv_monitor *mon =3D p;
> +	struct rv_monitor *mon =3D container_of(p, struct rv_monitor,
> list);
> =C2=A0
> =C2=A0	(*pos)++;
> =C2=A0


