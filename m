Return-Path: <linux-kernel+bounces-863318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18199BF78A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056B73B5BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1BC343D63;
	Tue, 21 Oct 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2CtZBHz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C801946A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062293; cv=none; b=bZQsjVLB0VsFq6OZ41cuZ+zdPpxyG7rIPcqKNvY25X4Ecok8kgyHuZu0+ojMLzj0niIGxUj/XymoxfikCspGd5Fmqd8SlLyX0Y+3vW2VrVP1VRiDjApq3pDKQyRKa6DG+dkN/9eTfx5tBPwDMrNhAiA7kNFjqsUCpID1NnRd+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062293; c=relaxed/simple;
	bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPb+44yfyaK5hNFEu4S4Gk5kPg1PpccpUlMjz/JH+mkxBRhg8mlB4jB3mAfwDLOiV4izBzOs7ZL8lKlgHRCIqmIPit8avLf8hKhWtA8EE0AlWhTXkaRsXkMWxRPDPDlk0vEaMP9wnxnoRgzE6IGSzE592lRrwWdDO8VUDcuz0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2CtZBHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
	b=D2CtZBHzU65O2ya+oRymHL8Cl+OY3I9PAVk44+sdbXoMzX1X0uC9JzafUfOulhLpfOifpB
	yHGbXvxhlr+cbUQ6lse71iiUZAYTuy6wUKOC2mQVcVhv5bblp1M7go1f44zKx0uVB/iJLW
	6Me91cX4nswnpiReuyRIlZbxN9NieS0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-nA2Ier7LN8mVMaReqazGuw-1; Tue, 21 Oct 2025 11:58:09 -0400
X-MC-Unique: nA2Ier7LN8mVMaReqazGuw-1
X-Mimecast-MFC-AGG-ID: nA2Ier7LN8mVMaReqazGuw_1761062289
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e884663b25so1265051cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062289; x=1761667089;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
        b=d9G2l4I42NVjFP01qPGJJqIvv5tKBDBwFycEVaH20lOJ+i4++aVsVE1AbvRD8uoWzz
         9D/vXt89UHKru5NSvvygmT8BeYkUBolEvMeaswqivfv7mh46IEk+IH9j+W0xM438S9KF
         DxkR0yOjC+Tj1AYFsqjvL+4WSSLbN/U8LKT7CvA7ia/vIaY1hf2r5HV6yEONF15z64Jt
         sU6u222+ohOdl1K2AjyfChoLBRkWjg44s401n+tsiaEjwkoH0xSA3i+KAqD/8I5FzQpy
         qsVMVUmkJs2jm/o9w7b9wBGhf0e37r7QLY4a4ZC73ao+KVVFcGsty13LClTAhO9VpIwI
         M1kw==
X-Forwarded-Encrypted: i=1; AJvYcCUJPPpt8bUHjuzhx/1A8CRaz7y3YfimTBExBCadM+UhtBGM72WPXB0xmrvIyLd9dEmDKCuEuGF/edxZHt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyjyi+RJFjZqBlH1ShuxBkcEv2hZudER/cB9m+T1/0JELGtKYx
	NOlU6NxmmFn2wCS8SK0phhSiTVPqEsPgU1ILKq/r6JcCI1V4Gv07+FN4W4YFXYSutVhmUKCqpus
	mB466HzcsaOGbYqZXcha8WSJIBhtPCj1zpmHTFQbhr22hWuxJz4Zwium31yeFtRGJVg==
X-Gm-Gg: ASbGncvHnKEiMmAzzyWy5cVCyfzVGhvdG2gXQk3pS1xxyXkbSJ5w9+EOr2SUPwgi4QK
	GxLqg2UIBihiLH8QpMcBO2LwJbs4EoiVI+5aX7e+VGqhoXHVDcxe1qEWHLEKoyS9Yn7t99Dac50
	HFzMNpdhm1+zoSlivsRspk3udJAlIcmSVK6i1DrIWbsisO6PRYNxP3PG7KrtcF2A82NL4vcY2fF
	slKCK4VbO6gfeOBxaMYn8YlXT6dZzlATeVFJWR9rEULoU0SYZ9AZ6Sh06sBwoYTOswLrjeXy1fC
	piWBKPts1w5ey/ynWrdNIADjO494Uc6Dz1uZzWdcrlI0CNY8nIWF+7o7neE/3bEZjPd6DmWRIUw
	ftANIXMaP11BSAZW+5yU8fv2HG6vNWuw=
X-Received: by 2002:ac8:5a4f:0:b0:4d4:a43d:316c with SMTP id d75a77b69052e-4e89d3de63dmr217194171cf.62.1761062288879;
        Tue, 21 Oct 2025 08:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5szTseO6I4FG2HD0vTjKdNDMZmPXaowNDyBlk3/ojACBLUbgg83sr1esbAzDc5Vj05+rEPg==
X-Received: by 2002:ac8:5a4f:0:b0:4d4:a43d:316c with SMTP id d75a77b69052e-4e89d3de63dmr217193701cf.62.1761062288301;
        Tue, 21 Oct 2025 08:58:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5edasm794643985a.7.2025.10.21.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:58:07 -0700 (PDT)
Message-ID: <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Tue, 21 Oct 2025 10:58:06 -0500
In-Reply-To: <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 16:54 +0200, Tomas Glozar wrote:
> po 20. 10. 2025 v 19:53 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> =
napsal:
> >=20
> > We should have the makefile build this, and add a test that uses it.
> >=20
>=20
> I agree. I tried to use the example, but it would be also good to
> check if the BPF program was actually executed.
>=20
> That is hard to do reliably for the current example, as it writes into
> the global tracefs instance, which might conflict with another user of
> the same instance. I will write another BPF program that will create a
> map instead, and a script that will check the map value via
> --on-threshold in the test.

Huh, so I guess BPF is an exception to the "no generic printk to the
global trace instance except for debugging that generates a big boot
splat" rule?

Speaking of which, why doesn't trace_osnoise.c call
trace_array_init_printk() given that it uses trace_array_printk_buf()?

-Crystal


