Return-Path: <linux-kernel+bounces-798380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A0BB41D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B768F170E98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CAC2727E3;
	Wed,  3 Sep 2025 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnCY/tt7"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D743596B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899071; cv=none; b=TDDJ1v+oauxMSZ6sTrLzIzBv8fOEWw8KeSqSOA9+nntxyKvXcjJJZC73F+nmhOUWgWykdckSOnDxq1GJ8gc86QNznQK2K0JtppG2dxfqRxa13niatDEIFfxnA0fQ7cpHntshi7n7iEtjZfoxmUEYaGk/L4Iy56uRk7Yk6LIBSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899071; c=relaxed/simple;
	bh=gLGpFQOlh9fVpCc5Sv2hMLhbdiPNAX3AiAUw8sJSAdM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WaOL1FouY5HklbEn2wCJadHi6lKV5yEv7KPofKdhPlq2LsaYzzb7dSBq9z0x3sK7xzlvfG12/R0DsPtWyYatH/TmZdmeIAqOX3+clDx9arYyt1IYwJvf0FI/DKJmWP9KKezXmng/noHHmKmKjCQk4KhXZWWbJJ4CZNEtB1TobSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnCY/tt7; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7222f8f2b44so9991396d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756899069; x=1757503869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dav2D4V4qcHRZpP0WVJVvIh4YIqoVgswaSBw9ZlajUw=;
        b=OnCY/tt7Uga0wgQ2z6MKm2orHdhWA+xU0qeRqG5Ejataz+PievGrn0MbJDae0WH3W5
         ofO2wWLj2lUEOXQpgU+iN1F9T1H+y2ECr1oMefZ4SSzZnwPFVTiY4DwDSHcZglrO29ix
         drMsxTLn5w/Y/DmeYXw21Ai3EyCQgBW5MZu964AhoV/FqxwsWYP7Xj5nUmnYLixWw5u8
         NJPQmFfjYR/zeJUpwdJ0MESxqmEaG2zZpP5M2Xd42qeB4zVCrj9F4kygYfExRLQ1Lbqp
         r0UdM9czz8x/AGsBY0HSnD8R7qWjKosCJhM83ZUZb/b9WrwWMEkAZALVistTC4ANp6Pg
         t0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899069; x=1757503869;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dav2D4V4qcHRZpP0WVJVvIh4YIqoVgswaSBw9ZlajUw=;
        b=qvgnBdh32tLi1E89LaRqTwCPaC/Uqi/Y0fekWM9Sn9V2Q2Wp+6PZod4EdfYJkPrghx
         p3pBtfgzus/M6hKrbMhAFwz3C/msY+H8pYsMWjncFP6F6RLQPqCYpLMw6juK+ZKKkkYv
         AQV7M1xjUTkYRADJ4qqoaknKtadRFI37bqeCwLKv+N2sS1+jFj28kxqsSUGOI6uuZpEG
         XHrujPQ7V1yhmM6Y6ufj9chj++d1zXv7vxvxFClfTJ82TFiJq12QF8UZJIHUbN1x8YL3
         ogn3GYqHPVP6c3PakSfG7JbVfRBsP9faG4qWJqV0sk96TkCLd74pRGoUP8ipuyQEY5Kq
         xoUg==
X-Forwarded-Encrypted: i=1; AJvYcCUDHbnZquryDeGRV2A8gudAcvKFFhnQg0EENm/UQJIvgoYCEppzIjtING6SeHxMwV+H1oMRtdE6dtxdq2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjZnGMisw7Ef+pUCV55jayVr0wRkPzLhvVuubiDzSzW1eSYqoL
	3OUhnX+ZbZe0CfiZLFjU40H74RKccplhbQSo2nw66zzjHLT6Pz0YXXt0dorWDBlC
X-Gm-Gg: ASbGncuDyUPDeijKkVEFR3vTTV1vdwvZYo2kdhwOb0P6H4Kh2kW7JAygWyX3s0aP8o0
	MTMRI4LaLdILJ7WgdTiPrL7fYIKN8akordUAtRu2jYELoQAv8nqCNJVRD4ghb3n/4NyXjGY2UUY
	S9jUtzpf6A+J+6J8asqyXX9Iyq9CMqrKkqQvGKYytlDUWMo364Hef3sEH3d4wQXet/saxsTA9rC
	T/yxJnKfvGhIu9tWwOYXJHSJztUg2y2+w5uslqtY6l2Lt37uen6kYQ6cnM2BIEUt4TWUqFTkq9w
	XM8Yb1dezx6/jsfZPUA23nAjwqrarB7C/IkA7cuZ2hwBDdqGj7Wo1KyE0jTCsjuMa8J9bm4ZKHf
	pOi199qAm708ER7AqHGVwWmdJlRmkQutKr3W1VnRxJv1x+k6cLJ3mNKnUdgWxJwdYTxqge3NK0F
	pGysKYw32dCBmZmotn
X-Google-Smtp-Source: AGHT+IEFXe8HVugToVA7isdChGko1a/9zPOjsl5jTYpFfOTakLRY2uhWvSH4UBbfVK54wiasBGSZ6g==
X-Received: by 2002:a05:6214:e6d:b0:71a:27fe:4d6a with SMTP id 6a1803df08f44-71a27fe4e4amr114469416d6.38.1756899068084;
        Wed, 03 Sep 2025 04:31:08 -0700 (PDT)
Received: from ehlo.thunderbird.net (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e418sm27710586d6.4.2025.09.03.04.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:31:07 -0700 (PDT)
Date: Wed, 03 Sep 2025 07:31:05 -0400
From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/5=5D_auxdisplay=3A_linedisp=3A_suppor?=
 =?US-ASCII?Q?t_attribute_attachment_to_auxdisplay_devices?=
User-Agent: Thunderbird for Android
In-Reply-To: <aLgV6lcxvs5JLUdk@smile.fi.intel.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com> <20250901020033.60196-5-jefflessard3@gmail.com> <aLbEcN44RT58ywzq@smile.fi.intel.com> <9223FFA5-2B0F-4A74-AFE2-CB7C9703CFAB@gmail.com> <aLgV6lcxvs5JLUdk@smile.fi.intel.com>
Message-ID: <CB8AD4ED-5E01-49EB-A177-9C7431E87181@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 3 septembre 2025 06 h 18 min 18 s HAE, Andy Shevchenko <andriy=2Eshevche=
nko@intel=2Ecom> a =C3=A9crit=C2=A0:
>On Tue, Sep 02, 2025 at 01:37:52PM -0400, Jean-Fran=C3=A7ois Lessard wrot=
e:
>> Le 2 septembre 2025 06 h 18 min 24 s HAE, Andy Shevchenko <andriy=2Eshe=
vchenko@intel=2Ecom> a =C3=A9crit=C2=A0:
>> >On Sun, Aug 31, 2025 at 10:00:28PM -0400, Jean-Fran=C3=A7ois Lessard w=
rote:
>
>=2E=2E=2E
>
>> >> +static DEFINE_SPINLOCK(linedisp_attachments_lock);
>> >
>> >Why spin lock and not mutex?
>>=20
>> The attachment list operations are extremely lightweight (just adding/r=
emoving
>> list entries), making spinlock the optimal choice because:
>> - Very short critical sections: Only list traversal and pointer assignm=
ents;
>>   avoids context switching overhead for brief operations
>> - No sleeping operations: No memory allocation or I/O within locked sec=
tions
>> - Future-proof atomic context safety: Can be safely called from interru=
pt
>>   handlers if needed
>
>To me it sounds like solving non-existing problem=2E I am sure we will se=
e no
>driver that tries to call this API in an atomic context=2E
>

Yeah, I should have skipped "Future-proof atomic context safety"=2E
I don't see how attach/detach would be called from atomic context=2E
Maybe to_linedisp(), but not in the current implementation anyway=2E

