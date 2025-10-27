Return-Path: <linux-kernel+bounces-871961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E6C0EF4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CA188B2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2130ACF7;
	Mon, 27 Oct 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzvEqUJ1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A430B511
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578784; cv=none; b=K89WDnO3cKNRO3hZojSpwK4/lK/qdDdNz9DfLtfzZS8XNPZsbBM5wKpP03SGXLc8jH0PDSjLAgLyzBkBFqmJP/KHIVqJTbDUmyxuXLNvFlqxHKwPQcAg3dNNw42tPXej4xGwQ3z/9POL2Sk0SVW7SshKtexPfefRtWDR/kdCFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578784; c=relaxed/simple;
	bh=EMBraBs8daNiJCKlZz99Kc9Uwh/7oGCL3rnwj6gVCVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM2p7ixhtOExoVb0qlPkv+HodyPXIwhZhSJOz4N3329bJwyxf9XNAG8g3xk9Y8CTYToJuPfFYyhGtW0nKBEQW/Fdw3EbeRxRD1uXSDBVwGi6lM9ogbu3j7Bal3zYm5YrsP8y9a17wTcIAv0FqXfbJ10f0PI3TH9cL1ObPm1mDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dzvEqUJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761578782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wUoSKh4ptdU13ldJNqwZ2zHLjAmqFPPlpDyTGSZSyQ=;
	b=dzvEqUJ179AA9aLCfusiIgtqwLR6+UHvHGmx6fsuDLKcQQpohzlwqsZ4W+tC4SU7MVNIzk
	P9V+vo68Pg5HSTU3c1uDTTLbH950ii6ziGMRLSs4E8fxVYK+lvWo1wfRz82HBoiR2W3M4Z
	2Iedv6DD8KdI1ncYTe4aCyDrwuacmZo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-ltr0XCBAPgu4eDlxM3msLw-1; Mon, 27 Oct 2025 11:26:20 -0400
X-MC-Unique: ltr0XCBAPgu4eDlxM3msLw-1
X-Mimecast-MFC-AGG-ID: ltr0XCBAPgu4eDlxM3msLw_1761578779
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b3cbee9769fso687720266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578779; x=1762183579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wUoSKh4ptdU13ldJNqwZ2zHLjAmqFPPlpDyTGSZSyQ=;
        b=uY/G3Nr3P9CHjH54VzeXO4zOR68539eJAra2vv2dNWtRcmG6QzgMertznTLj19qrKZ
         G2nRBWYheIZmVg3SCA9T4WfODN5cD56koG8UKbG6vJHsYSHWADeOEFm1pMZSIZQ/Gx8h
         U0jEbohCQbds7HUJ6+WbSwaNW83zwnc077j3kaNYzyf/vJ2MvDaYxD+O+ZdFBWBTs9bg
         5pG69N+mUYVN4GklP8ojgOf5FA0wbHC1C9RoRhDksuDml9vvpmx+pu7p9kXLwSTfXb2x
         +bMstALQV48SMFcmgP0rA+OaGv18G6VS4ipxOnPF+FpoeaIBeuIP5KHICsBufmOiMgi/
         j8bA==
X-Gm-Message-State: AOJu0Yz4UuQleuglxkt4zI2jVItzHFgSIsbKQ5cRZip9U2AvjNN5oQyK
	Jj4GEFZkLxC24/u8k83ffCHtnojLTkmd3sIpL+Kw34gLqMitIc/8jdpkH2SaQIohHOC1atauM0d
	qi5BawKHjpQ9wooDzt1SDbNZKpKdx7PE8MHMlG1wDHoOmxXWHjZWBXtu5o1Gbr49wZeSYcR8gpn
	DFf1BIWsv65BphoBXoW9ZmpMu35Vo+pbxDG2qtCAue
X-Gm-Gg: ASbGnctJ5nvjIug/IbbT+Is2n7HNtGpTa5tvsob72IhKnTdTqxpMsxTgSwIKjhJHlek
	CTpJ+hrorwXBFxzhUQ9Cuz5R91bhTPR5Iq/NLSK1vdy8cDDWAXGOz08mvtNgpkBdHsSGM/AJScp
	41yQeU49WyL8Tpu784A6cA7iY+aGlyEA/cxpqn7QqONyBdyYJ0CQOePFYFsMTffgFdc0nCfiMJj
	lF+SqcVcAMdrg==
X-Received: by 2002:a17:907:3da3:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b6dba610ff5mr26356966b.60.1761578779297;
        Mon, 27 Oct 2025 08:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLo1ZwaZIFeuJXVwFzBBQ1SpO66mEAfnYV9CYSHn1od6IOfi/WXaTASbeK7sdUdigXxhHX38jLLYZ+j/v7l7I=
X-Received: by 2002:a17:907:3da3:b0:b04:2533:e8dd with SMTP id
 a640c23a62f3a-b6dba610ff5mr26353866b.60.1761578778781; Mon, 27 Oct 2025
 08:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027144819.1034041-1-tglozar@redhat.com> <20251027144819.1034041-5-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-5-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 27 Oct 2025 16:26:08 +0100
X-Gm-Features: AWmQ_blAhCDUkFOO5Ihq_UEhuUW_4WgK_7PG_2rl87mzwI4N3JTIUNzoUYRpVGo
Message-ID: <CAP4=nvQOk_3_YqTFrLfJVPf5xU+SB2X5AUyUu3T8-GPkTAQbRA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] rtla/tests: Test BPF action program
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Wander Lairson Costa <wander@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 27. 10. 2025 v 15:48 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> n=
apsal:
>
> Add a test that implements a BPF program writing to a test map, which
> is attached to RTLA via --bpf-action to be executed on theshold
> overflow.
>
> A combination of --on-threshold shell with bpftool (which is always
> present if BPF support is enabled) is used to check whether the BPF
> program has executed successfully.
>
> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/Makefile         | 10 ++++++++--
>  tools/tracing/rtla/tests/timerlat.t | 15 +++++++++++++++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>

Oops, I missed the actual file with the test!

I'll send a v3, sorry for the noise.

Tomas


