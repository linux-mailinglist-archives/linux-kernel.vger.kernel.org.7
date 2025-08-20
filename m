Return-Path: <linux-kernel+bounces-777533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5F3B2DA93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4845A0A60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052662D47F2;
	Wed, 20 Aug 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b="PPBU9NFY"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6FEEDE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688283; cv=none; b=OgZpuuJ7w/CwP5Kh5jO1XgmHvyi+f+nl2EGE8+YmlnWliUZPfhL4FYz4X+OW5xRGh+CYIanxVEf5QzEVj3X1VndBJ0/ZxaSBuFgkFI7RRnk1uYMc3j26RYegRRDbcF73KVplOXIac988HzX2j3m5KI5Q3BU1Ka8FlIir/Puq5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688283; c=relaxed/simple;
	bh=WUv7Cm0V3IgjuX2phzUSzG2Zen8LWdoFvCdW38C3ejc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mDnTWhbAfPuQSBZ/B/jPUieFhzOpKPeyJIAPfrKmRBTApZHP5ViMOhRMAoIHAG9ktGnXkavc1lq5I/3uwM+PUUnpOGh7/nLmtPksOua3Xl+kvRUUUXj+p47PC4prJv0tcLjx7zbNzWj0sDV0zSPB13OQuBc2PBJyyBnTvfW9upc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com; spf=pass smtp.mailfrom=watter.com; dkim=pass (2048-bit key) header.d=watter.com header.i=@watter.com header.b=PPBU9NFY; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=watter.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=watter.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e8706764d2so801258985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=watter.com; s=google; t=1755688281; x=1756293081; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2tCKj6fVsfc/EZ73lcI+v0RpeptC0tmIuUoVcciWQ4=;
        b=PPBU9NFYsM/aWlytIRjv3kd/pLmgRvpZNDr561NmwDHkf96jW8fQA+1mmtA3bKe8Gu
         P88ku9P+cEafQRnLtuTqc0ZKs12Y4l9P0fIf90E88hzszutuK6W+zJbtuqcCgbBOu/7V
         g5nlBZ/wALLZG0SsraILZe7/Idt50ZFKZB5vodQ8n/dUqkSyarefWj53mNslwP/dtKwx
         59mE/5km6OBkygTLCJ2HK/e9h5cRsS519zKiw5G6/lJ1nTFLT8+9e3PGh1uqWfrb5ijc
         hkF1y0qhoGb2BWrY/1nRgszcRwlk0Vvtky4hkalm8qxdtSD4bv2R7MCszEyNtJgxpssB
         E6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688281; x=1756293081;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2tCKj6fVsfc/EZ73lcI+v0RpeptC0tmIuUoVcciWQ4=;
        b=Wfn9QN8Umk6bpUPLX5qAOsMpW4ZAuRZtdWAvpb3MMF2OnKLFOTb9Th/PjM2X9WOHG/
         4U0JDqw4NZtphvK8oCE2Oz7bt3KaaQJoLY5R0xNzzIvkmIP6clCu8HK7VtV75nqoBzYp
         2N1xOe+e/PkBxqW3ykmvKrQp/EhRePNFEkNgJUwRt0tVxyn+z5WzoOtnMpuRh4fKZ6FR
         mwFXxaRuE2GCzNkDHO/gabiirmob9DGUorHj1ucd87tstFhV+tmIjrVZPlJBc9DeIMAL
         FRtnTphaHcNrjU8NsKZzfRCiR277PUE55+n3m8Zk/i2ooQlatM110reZXWD9KTX9O2Fy
         m+/g==
X-Forwarded-Encrypted: i=1; AJvYcCUMnBK6+FVDhaqYVF0zMMAJhCb1SWjfWIoatiNLxHQH00RhI+HdvPt7cgTpCTTBOOazu9EjX4pVml+mJls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxleJyoxL2FNL4CoKZ3EV+gvQn6y999WjCF6wVAlZI+tCljUrEX
	AFsISv+xR0nmaXVhYfAcOO+XLJBSQt9m/UWOTEE42qkPr5sJIBUYDe4PLWNpcAcX1w==
X-Gm-Gg: ASbGnct4d1BssZ37Xsq9A8YLls+ejQX2UxMt/FKGgo6Gz+uby4rqGZcbl8GZn1TonfN
	N6zNOH/s4ChVhbuXbTQKntQrQgaUwxVHCCxrmFPlKtalvcqbjABptlYlB5DXZMl7ivoUncNR1wt
	/1ngrgG5ZFKpyctKXXbO2FkPBOhB0gNrzpJnSLTYgNE/fD62ZVMdQkeh1SJZgFDITQ8qNztFred
	h8KA6ce/OPbAJwowC4vwWOZLW8a5s/sbKCC8c64WLud48GvA04B7JiCLyjJ7mNZWNWuu6TBUBSJ
	3ne5RTFEs2PxoRYok73I7WQZpPt1Bywa/O7LyyuEnKxAgHExTAe1adyh/c7tXxuIO2rzNbYC59t
	1eNK0zkXZ7afCbK78ZGT/uZal0FJNPRJ4XYu3lnw2j9QwuDmcT70e
X-Google-Smtp-Source: AGHT+IENFTHgqmyZ0/tawf1SKqM3WedPfNSzmCLaXLgI5zvcpW5ND2KdzA6cEpKbn5YPQjDk/9LPUQ==
X-Received: by 2002:a05:620a:7105:b0:7e9:f820:2b59 with SMTP id af79cd13be357-7e9fcc1b27amr274878185a.81.1755688280380;
        Wed, 20 Aug 2025 04:11:20 -0700 (PDT)
Received: from smtpclient.apple ([70.32.192.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e191efdsm940327085a.44.2025.08.20.04.11.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Aug 2025 04:11:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.2\))
Subject: Re: [PATCH v7 4/5] iio: mcp9600: Recognize chip id for mcp9601
From: Ben Collins <bcollins@watter.com>
In-Reply-To: <CAHp75VfrRJmB-Q6TM+Tiy79_q63=cOvyrePMQwi6ZbvDNUPezQ@mail.gmail.com>
Date: Wed, 20 Aug 2025 07:11:08 -0400
Cc: Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <00D2ACBD-DE50-4132-8DF2-46DD97DBCE3B@watter.com>
References: <20250819-upstream-changes-v7-0-88a33aa78f6a@watter.com>
 <20250819-upstream-changes-v7-4-88a33aa78f6a@watter.com>
 <CAHp75VfrRJmB-Q6TM+Tiy79_q63=cOvyrePMQwi6ZbvDNUPezQ@mail.gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.2)


> On Aug 20, 2025, at 6:07=E2=80=AFAM, Andy Shevchenko =
<andy.shevchenko@gmail.com> wrote:
>=20
> On Wed, Aug 20, 2025 at 2:45=E2=80=AFAM Ben Collins =
<bcollins@watter.com> wrote:
>>=20
>> The current driver works with mcp9601, but emits a warning because it
>> does not recognize the chip id.
>>=20
>> MCP9601 is a superset of MCP9600. The drivers works without changes
>> on this chipset.
>>=20
>> However, the 9601 chip supports open/closed-circuit detection if =
wired
>> properly, so we'll need to be able to differentiate between them.
>>=20
>> Moved "struct mcp9600_data" up in the file since a later patch will
>> need it and chip_info before the declerations.
>=20
> declarations
>=20
> ...
>=20
>> +struct mcp9600_data {
>> +       struct i2c_client *client;
>> +};
>> +
>> #define MCP9600_CHANNELS(hj_num_ev, hj_ev_spec_off, cj_num_ev, =
cj_ev_spec_off) \
>>        {                                                              =
        \
>>                {                                                      =
        \
>> @@ -123,10 +133,6 @@ static const struct iio_chan_spec =
mcp9600_channels[][2] =3D {
>>        MCP9600_CHANNELS(2, 0, 2, 0), /* Alerts: 1 2 3 4 */
>> };
>>=20
>> -struct mcp9600_data {
>> -       struct i2c_client *client;
>> -};
>> -
>=20
> It's not obvious why this piece of change is needed. AFAICS it's a =
stray change.

The explanation is in the changelog above. A follow up patch needs both =
struct
declarations to be where I added one and moved mcp9600_data to. It=E2=80=99=
s just ordering
so I don=E2=80=99t later have to forward declare new functions for =
filter_type, which make
use of these structs, but need to be in the iio_chan_spec =
mcp9600_channels[]
declaration.

I guess I could move mcp9600_data in that series, but I had this in here =
before
I split that series out, and it seemed simple enough to leave in.


