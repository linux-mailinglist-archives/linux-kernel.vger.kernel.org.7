Return-Path: <linux-kernel+bounces-877349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9C7C1DE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 01:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE8DB4E5646
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 00:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B11E1E0B;
	Thu, 30 Oct 2025 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlF5m9Fn"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300A3A1C9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783990; cv=none; b=f/9zI2yVfi3zNQjdV/wWnTlscEmXchXScX3m+GXjz1lMxALT2pDHIJDzIRXZUSB2Xk68UWpvOPFiQasE3/CfR1J1I9s178j8svlXagZXOs7yW06c3AVadQ1mMyjyLMRkHSR/sb1gd6NiNNqrQjoDcNrD5Dtn9AuV9gTZOOeatGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783990; c=relaxed/simple;
	bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dw81g/bs3CYVsEsbkAWsFi2i0uQy9YXF/mrB7Ywb54bHafHkL3kIgrn5s9MQU2OzbrOrrgvtL5ZN1SrwdxPbWOOpHaONyu+znK/eDbCFxCJIxucMaYDHXkm6AzRIvgjPAGwFyVftaqGs880Zcl5PwktoDDV7KOYbWlnHxKw2RGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlF5m9Fn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426f1574a14so288503f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761783987; x=1762388787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=JlF5m9FnkbbVGp8Cz3NpbfW2l4rqF5UkP1hf9/jq504lzHJTGac9E+bakybWEXQvIB
         Gl9dDe1BbZjBIrR7io6i82v+UDiY/v5PPECg2Qs3kukLcvTvXweRDUFmKjoX/e5O6SAx
         FL53ny1ejERTGMsm4zaDi7oyj0qoPCr7EFI6BwsJ+0h0/J4k7ZoFKmPAwwWIiU3wbNpo
         LmmwgZIObb5pyXKDqJFD3SmPa+MzF61Uy9eDdhNbHodnAzzfxrQ86hnr6b/st5BwR+DO
         3uDbP5aSQSb/hu+mJiPzO3nNUDBsbfqun4JurAIF8eAIasRKEMwgNaCBbbjIU7YcAHcD
         2noQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783987; x=1762388787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPUsAbPnavZ4td1AfI8HdK6vuKE/XGdHzWIQ9Lztg84=;
        b=aQ/UBS7Njd5WXCGVH1vnVcvysE3O016ZtR3/kLibJIKYyAYMuMSEfXwsTmh6PMyMNL
         dVsu7hFNGDOk0zuFjuHvncdF1plPkm2ZR+iNOi2KwuNNmr/6lb3EvgaToi85KDDwz60D
         nGmHiVtBQiAb/Wf8m2xT6QJYe7tU62CvuvOerNOV+flnWrGoSQ9GaeSHI9GRiboEM+dv
         IPJkx69nfVHJdTLhmplnWm1AIgaquTMTsss7JXvdi1VvUAsjNo6U6UKUyq9+z4NrUR1s
         SmTcIBfLgYEaPiOtmuqOxFqeBF9CAOTWbKZFxq11dj2/LDcTqgqQmg/anhSfVy0iMxkk
         34XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCGkoPNsbpc10ZpFKoj+IZSxTzDpFJzg//jhngiN3xuqwOVu5wax5mz80kbVHpZoeViIp0do3leP6CS8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2S0Xnq7x5UycoD2S0hQIJiZvZibDCkvH+KSMaZKW085kiJN4a
	bxmPyW58U4Hop2PJYj4xjqQWDPtN4+MJV7GO8QL1vkYaViSY+euJBciZHbTOEt0NEYLYXmbcSIy
	g9s4fjs+udkQA/T+YXNDxjn2jRYsNyOc=
X-Gm-Gg: ASbGncuCYtEiYUABPFNcSAsp5xCvRlFo6rkuJsaIEvFvXLKDwng3mA/fAHJlweq+EuL
	AJePmrxa+V+9QnUDnufnysj34GGuB6NQ7yhFcQi9KGHRsK9lQursqoq7nC5jrZncpYcH9sY3FtW
	K2oHlEizajRES23UPr82AYEC8TSkDhZYAnq7wvPkZrtr+vLxAvuhDL3td7pG6V3eZWoBf0S92wQ
	yp5kDt5SnVJ9pF1eOMcNHr1Qt/zrdeyJsT12GoLzemN567+nwxpJeZBIzU120pAXiRZsJuD/fV9
	WL4G8bVT0sZCVmOHAXGJxUGi0DzUjrwpmcWgNz8=
X-Google-Smtp-Source: AGHT+IGkQ/Jwdz0hen+IZZordaBwb0FnIsLHdm9Vab1VmHts7m1t5JFOOcsAaPj7+O5XwKDwKAOewvz8pmWBLAdPVtg=
X-Received: by 2002:a5d:5f90:0:b0:3e8:f67:894a with SMTP id
 ffacd0b85a97d-429aef715f6mr5362079f8f.5.1761783986804; Wed, 29 Oct 2025
 17:26:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz> <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
 <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
In-Reply-To: <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 17:26:15 -0700
X-Gm-Features: AWmQ_blIRE7qylf1r00bSF1LUzzYB2Ikdwsc9BuLrth2mRvMZNLO8ddWxSZ_asA
Message-ID: <CAADnVQ+TQZXhOhfG27kKdX8QUmua6AAqX81CnkS2W=4TANPUiA@mail.gmail.com>
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:31=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> > but... since AI didn't find any bugs here, I must be wrong :)
> It's tricky. I think we could add a "bool was_partial =3D=3D (prior !=3D =
NULL)" or
> something to make it more obvious, that one is rather cryptic.

That would help. prior and !prior are hard to think about.
Your explanation makes sense. Thanks

