Return-Path: <linux-kernel+bounces-756044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17238B1AF1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D29E0189C8A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A8218AB3;
	Tue,  5 Aug 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rs9mahRf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0C221A445
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 07:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377463; cv=none; b=XaqWcuMtzeZBgnxWOX2RLmkmP5Q7jxqgu9Ou6/ByeykFVbTOfcqLuxkiGVbKH9p1SKTGcvS6GBwucOBw5FJbdKcb+Dl20md02oT9sgeiHmx3//zPyEf5QAQN53JSVwft5N/FIC2c3VYXoJJrf+utdfmtp6aoeNlP/bHAjUMp6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377463; c=relaxed/simple;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4XNdEjlFW04CA5sFT5G+OqkQmogKmt3wyfDUL+xPdPmj7piNgOt2zOs53MlnxflT9rh7wW5TpFwBQJfEJfdfpiCkAuWjXa02jFnNvEUZltkLh8JNS/y3A3kIPEadpggHTyHSI+CA3l1oBtkCE32nDNUDns7b8DFOh3jvC3FXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rs9mahRf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754377460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
	b=Rs9mahRflMIyhhWasKmqNofwe9iQ+9C7NMU+H2CW1MLHcvb+X9wnUEg8Ip+DIQQmQzHgJf
	LHLNuALKdzC7u0k7C8E+/tYfK7fnUdiSx22dxeahaxpH3ASMe3uRBQNC/J7SwnHg9VGYN4
	X3K1IYGQCsV46zSV/Y7MFFB2Y6cxWDc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-4GndNKktPB-fBSVMJl641g-1; Tue, 05 Aug 2025 03:04:18 -0400
X-MC-Unique: 4GndNKktPB-fBSVMJl641g-1
X-Mimecast-MFC-AGG-ID: 4GndNKktPB-fBSVMJl641g_1754377458
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af9637ac74bso187465466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 00:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754377457; x=1754982257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGYonKGyaMFSCfv/S5Qgyq0Ie5dVTihFme0wevOqbyo=;
        b=pJu4E4mGCnjYEVd5CRNPBNsNA42uqwMK2tTsFBHr1sDOgBqEVOOMf5E+E2anDmXnuW
         +behZi28zBolbLvTpOE+nxn90VYc1vhexaZHpBUbYEbrznF3T+a0e5pQezoil9/LCcQC
         VL+PfxilZ8YWlgHuPuQpNeF8YozTSeeMYNkCdA78lPflKRvnzm1mzPwC+NvlCYr5/yRr
         Ok2BzL+xXuPyEyz7Lp8EN93R+gluIx3kt8RDt7IFamEZa+Xv3wcW9lCcxiEGkh7rxVze
         yrZIZ+g4EJUG5TNv+Roz6Q5dsaXB2STmYTDusrg60gSjJvshdS5aUwTS180EWYMYbp6T
         JJDg==
X-Forwarded-Encrypted: i=1; AJvYcCVobM2gOOLSddKcOcscbr11jmBYiCmjhVL2WsDV9Euigezm6hd9bHDjdPZ+1M3wq3HTODB/Jn39ejbY2wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJKFVywfR/tpYjzRExopLdchjZGq+wSZJGeKGzoKw8yA93ktl
	FWvVJ3piuQs0TEzXXFiDBPWIVVUJO7V5wZHlqLircNC4hw4/XpW57KeTtI1Su4SRMkizYbuYzua
	mhi6IQD0bkwsNs9Vl0RHUmgPRtrvwEInx2f1yItlWTQXgXfrNhx4Ph/GU7wy+EFH3v9Wdtzh0v9
	6LCizEMyJ/g/U/ZnfJtIMeMR4WV3b1IApM5ybJ6qDQ
X-Gm-Gg: ASbGncsvdI1vArYTA5jbujNSa0wqMV0rqU+/mVPyfJC7bCqFAi57p7WsDRpfeBCp+CC
	xRJx+u58U4GOvgMLM66KcGujGdmKz0aAHxaJKzVxY/gjVLq2I8+sJmBNK74oA1SAmEgXE8Xlxgx
	pICGwhLjV500Hv3iT2tD8lgBNkonnlB7+nz5baH9VzC3KMmPv95pq1fsw=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-af93ffa2d63mr1238256266b.12.1754377457471;
        Tue, 05 Aug 2025 00:04:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMbyK9gScuElH5NpUEMJ41EUPRyaWEQ72uvHWKJnSabm/rqvUckY7aYInaqvU/TD5yzgsTDQ1Qxrs3ymnlCVE=
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-af93ffa2d63mr1238253166b.12.1754377457043; Tue, 05 Aug 2025
 00:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com> <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
In-Reply-To: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 5 Aug 2025 10:03:40 +0300
X-Gm-Features: Ac12FXzlcHTYAnu-YG9PepEFtGlUSJiRNcUXl9U2QsYIFClYRFSRgHj4wuksd2s
Message-ID: <CADDUTFzWBkrKx6=fOMXp=y5cyecOvWLx5jZG6m3BMTAvL067Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Aug 2025 at 21:18, Crystal Wood <crwood@redhat.com> wrote:
> If you want, I could rebase that on this and use container_of() to for to=
ol-
> specific params... but then that adds complexity with the top and hist-
> specific params, most of which are common between timerlat and osnoise
> (and not merged by this patch).
I=E2=80=99d appreciate it if you could rebase your patchset on top of this =
one.
This patch is just the first; I=E2=80=99ve intentionally kept it minimal to
ease integration.
My goal is to refactor rtla and submit a series of follow-up patches
to reduce code duplication.

> So we might want to just keep it simple with one big struct.
This is a god object anti-pattern.

> new common.h if we want to keep the actual-osnoise-tracer stuff
> separate
I agree with the new common.h and separating things out.

-Costa


