Return-Path: <linux-kernel+bounces-853069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD20BDA930
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7BEED356946
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C02302168;
	Tue, 14 Oct 2025 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gN3+XUfN"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B730217C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458261; cv=none; b=q9MMeRM2tIGMfY7Kq2dD5ZB2Ag8vrYC79v9qmO4PcfS+IMHs3hpryZjOz2qARtOuyvG8qIXhC11HshQQtEL4gm2mT/383W/Fd23g2LHJFxRDRpHpBrtydJg5Rb9G7v3KyYDrEq9lNRX8mzvP5NCnIdXkqgNsYt4yXQUD1yalAns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458261; c=relaxed/simple;
	bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZjl8MOGF7HJD7TI00QaPCQCWQXTQbZ3nYbysSEvq1MEwpsAp7C8uYx9obtSbe7zsB0GpBZr3sO/HyyFbhHVKz1zJmRqdaQnt0/DhQYcISXjOgSd3s3/fPEXCGmCBtUPtBonCQ11XQLPcLFPtm+mV1SYzQzgnGMBDWCwMRA9cYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=gN3+XUfN; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78f15d5846dso91218686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760458258; x=1761063058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
        b=gN3+XUfNl5I+bNisuheUReVqm65hJFnW6xxQP+JdUGFN+EF7bWcJUVmZZ3KQep3rPs
         Y6GupbvMVOwuTq4TkAQ0a4SYLAtNs6GYP4HJxi3h7SsckIRqpY9iEWuU/QIhmIxoOqQZ
         As6yVfZQU6YbehwvQbAq904tCpzeHsYsrfzIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760458258; x=1761063058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V/DlGFRm8c+yTAONErW1Wi9DHbAGb76Wu6pjxTlj1+Q=;
        b=A8SCFMsQ7lh5ipvp6p5dq3VvDVgVPCg0nUVz2nTed/uj/63FlQpl8K2AFAXtEgA76e
         0N0lA5YwmRgkncwRRkZiIuGf9uWNzZTSsL6Zj2OjM1Wiw3Ic71/8wpIwrRRF3iiaji1F
         q98VlQ4HoW1KeBv2UoPH5J2WX0+DRmkJpdvp/RBu8g3ry8mnMhAxYOPldEb2cr4McaYl
         lBPj5Z+51I/8eU8fONrKSBZsP72S0W6oKKN3JuWavki1KhooILgJZNkQNoxVf6CkGWO1
         svFnkUjCqKoteL7keLtf5d1fMewJy438U8hmXm/kkThhSt8Ft2dKa+RwivkdS7DjvhPS
         T9mA==
X-Forwarded-Encrypted: i=1; AJvYcCUiJEcNsv0LleGoIrp/w8EKtn4kvlrch5zYXALsg0MCJinJlgu3ohDkOuNGGct8t+Dw04RSblSlC8ajQtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+v7qscYhp9r4AU+yo9+3T60DGkFNlXXz+NjgcdGVdh86KQ80g
	PnK5+i3uEDusOpzQJYvxyKXNGbdhT3/FbTNtFS6Ct+WMK0MZsdwKN1/5nFscWtZgMdsEgob6ry5
	nfVD4LeqpkZwH7WyDrGHNcuq/NNNp0joestF0BxOafw==
X-Gm-Gg: ASbGnct8z+P7OaXhLrpJ59xy1Y4A1FFFO579dr7yIa43jHw0uW4AsI/26xYHnmcVuOE
	9gxCIT6/EUbR9xMXWAS0LqO4ClnTtJwHQuYmOXxIGGz8wrIZ5/DoESMT9TU99h0vu9OdPIDlLBJ
	ut6kpcP/rxEf8z74T73HhGUrwCwt19eQTu17J8GA2RDjsGo3ec/rEWGoPjZ/k6ayIJi5Yxr7VPe
	RT/xSqAWP95VtVFBy9T+nFnLj7zXE4VDEfPaXNX7KMiEu9Lox8Wm+hcMIWceG9ZlkaNkQ==
X-Google-Smtp-Source: AGHT+IFQRjAKAJYbp6V1WiZeFCyECjXuO5jrrPa49DgUlI1WAPf13+vaPEkcaT2yeshZtbmjCqkb6pcUiXEcfb2su+M=
X-Received: by 2002:a05:622a:11d5:b0:4e2:f1b3:3462 with SMTP id
 d75a77b69052e-4e6ead4c89cmr348585611cf.52.1760458257727; Tue, 14 Oct 2025
 09:10:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster> <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster> <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <aO5XvcuhEpw6BmiV@bfoster>
In-Reply-To: <aO5XvcuhEpw6BmiV@bfoster>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 18:10:45 +0200
X-Gm-Features: AS18NWAdgN8KhodM1ygh5h7LAeZnHjtur6SOKA5u8RJBQMjsBZqEVkdui4mizyA
Message-ID: <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Brian Foster <bfoster@redhat.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Oct 2025 at 15:57, Brian Foster <bfoster@redhat.com> wrote:

> But TBH, if the writeback thing or something similarly simple works for
> resolving the immediate bug, I wouldnt worry too much about it
> until/unless there are userspace fs' explicitly looking for that sort of
> behavior. Just my .02.

Agreed.

I just feel it unfortunate that this is default in libfuse and so many
filesystems will have auto_inval_data enabled which don't even need
it, and some mixed read-write workloads suffering badly as a
consequence.

Thanks,
Miklos

