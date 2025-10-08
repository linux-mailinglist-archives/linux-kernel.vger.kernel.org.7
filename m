Return-Path: <linux-kernel+bounces-845220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D723BC4025
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2978B352A55
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85A2F49F4;
	Wed,  8 Oct 2025 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g70vdSNH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F75A2ECE8C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913764; cv=none; b=Nxd9jnY886KfgCfr6prbFC/cBDoZeYsuhxluaXKnPgql4dFV4XL/fzXNTqNSXtF1NdQv6LvRhIjbEQgQzCNmGL6S3kt2iTzbS9gYXIvGYIu+/S6aBQJ1aTThkgniLI98tx7vPlj0enKM75KJH0KA+V/Y3kEXUH/jxbnlP9bm/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913764; c=relaxed/simple;
	bh=u5MMr100rtEA08BaWHHgA+sasRbKdAq9QCFOKJi4Oio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSOxTWDGGopBjdKnTghbvhC4iZtTQdj9YalVivuL5d+Mvt/TqzJ6Wl37XgXAaW8D/rDBhJBDQd+pfdusOXIpaz5CCBwB2zoERI92fnuEcbq1E2JtZRPBiKfdM/qbqbnlFiLSMrHql6EsRTgcijtGypg5VsqBrLhk6sarxz/36Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g70vdSNH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmZevF5PTde87YSaZT3Xg+uQUGfauJNRDPEZI/VcPlY=;
	b=g70vdSNHnWakurJUwBoh1NF2fXrnT9o9OcJB0miNENtNaUvJX3Vn81bLAh7HcYb2Rx4oQc
	gO71YHDIRakiJ/37+e49mZIHLS4DcMrbYwId4/WVNywTbU9a2ON11/Ox/4v6TeQWeZ4/4c
	tOAYKLR6ji6sgmfBsf30+o14y3eiG9A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-WplYsemcNKyaZPPnZ1iaew-1; Wed, 08 Oct 2025 04:55:58 -0400
X-MC-Unique: WplYsemcNKyaZPPnZ1iaew-1
X-Mimecast-MFC-AGG-ID: WplYsemcNKyaZPPnZ1iaew_1759913757
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3afaf5defdso877767566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913757; x=1760518557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmZevF5PTde87YSaZT3Xg+uQUGfauJNRDPEZI/VcPlY=;
        b=jsGtih9cWYZUh/z2Aoscq+lvI5kvJslRqdAuS6gIU86M4lHjCwLu+3wyauTveMOsJ5
         0oCZAVcWbW9K45nqrmjfJsnwULYSoBsrDT7Di/ecQNomVWdSxbBgjJabdMZycKFV9In0
         Z0CG0gOt50T8bmGPLLMTtfdu6yWfO0f51cbvw0344piQAglK89iG/eZwvnQfd6j1WnUl
         3ImtQ680R9AJpOKtlVKpulr8HQsNPga5U35jyALLOtX3His3qG96QQtxURjtHZKe5ob1
         2/Q7JCeZ55+FKdmLoX3v18yrjTEq3HZGotR+RutO4J6FStyYu40bMfQ40Qm9AqxljpwS
         a/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoM+lKHtWSGX1KP42Dn27kca+e7DzuhBuUTfmVDOgFbmzcc5s6PqZuPDm3p/PeakLtiLHEY/umEWYmKZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJ6txtsa/fAZL5cb+YBkVZjBg6E64vlg6Y2n13SqBpJpIuHCl
	sB5mumvQafQZZ0tDoaqnUKYulmAUwgxxCqJYufwp4g3+hzgQVCu1nLZRRZujvwwZHVXLrf9bSHs
	o8DimndBkIiM1JcSKBuLtkE4de44B/kMpQRHTTXNzdCi9bp8Y56AgXNG68SopaeOqPux8zyDwMh
	4VW0toZbIlBtCpm5HrjW8lqcibCw+I34mRRNtyIOw9
X-Gm-Gg: ASbGncv0lycVyaC/IvyjdR2guN4CqgiambAJq+diezzcF+8JY7JVJowoPIF3Al9256I
	pq2pnO2fOjE5dOytFyMZWUlS5dmCDvv9f3QafH6e82QjwbkcFt6XqJpt3WxKCO7BAM9FLyuXxZJ
	Kw1QFgNPFMIK6Eqd3OhSJIuxfEAUIJ/zVrur0S8f70P7RcFXXAcT8SZ7U6
X-Received: by 2002:a17:907:97c9:b0:b41:c602:c746 with SMTP id a640c23a62f3a-b50aa48da0fmr287436066b.20.1759913757242;
        Wed, 08 Oct 2025 01:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwDn/7ZQH008AVGRVzX3xl8S3wEet83yeV03ET1vAJj3u2Og5YpJNeojyb8tG8SneCqFvrdKDeitzutNVPpqE=
X-Received: by 2002:a17:907:97c9:b0:b41:c602:c746 with SMTP id
 a640c23a62f3a-b50aa48da0fmr287433966b.20.1759913756904; Wed, 08 Oct 2025
 01:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008064500.245926-1-costa.shul@redhat.com> <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
In-Reply-To: <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 8 Oct 2025 10:55:45 +0200
X-Gm-Features: AS18NWBCA23-6OFIlvrHSY8E4tcCHEcJLjRidM7TL23KHQVxPHb-wwoMpAqdnd8
Message-ID: <CAP4=nvTDsoejezFNcS1uWftF5CkuKNb-QbBDYzZjrnHHj5RVzg@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 8. 10. 2025 v 10:46 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Actually, osnoise hist also lacks the --quiet option, and this appears
> to be intentional.
>

Yeah, --quiet is used to suppress printing every second, hist has no
such functionality, so it doesn't do anything there. See:

[tglozar@cs9 rtla]$ grep -r 'params->common.quiet' src/*.c
src/osnoise_top.c:      if (!params->common.quiet)
src/osnoise_top.c:                      params->common.quiet =3D 1;
src/osnoise_top.c:      if (isatty(STDOUT_FILENO) && !params->common.quiet)
src/timerlat_top.c:     if (!params->common.quiet)
src/timerlat_top.c:                     params->common.quiet =3D 1;
src/timerlat_top.c:     if (isatty(STDOUT_FILENO) && !params->common.quiet)
src/timerlat_top.c:             wait_retval =3D
timerlat_bpf_wait(params->common.quiet ? -1 :
src/timerlat_top.c:             if (!params->common.quiet)

Tomas


