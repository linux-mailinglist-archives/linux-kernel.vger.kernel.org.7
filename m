Return-Path: <linux-kernel+bounces-846010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F7FBC6B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E95407818
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E02C08B2;
	Wed,  8 Oct 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IrjGezrx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BE271447
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759960558; cv=none; b=t2winFFqhqoafId7SjS6RzU8B2MpA8eOAF2IAIE/+kOa3VZT3OBnspX3jddebe7ImD7/xEjTR7EL0uzpnWpYHoBXkgFGNom74Uq7J4yugv3IiQSr5zCnRVyh4kMdnns8XWv3JiB5EOzcaRWxnC4JnBF6tO+e+jtockaLbEamEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759960558; c=relaxed/simple;
	bh=yoHL2zHG1g3mjQjQsW3JiNMFR/9S2cMiZd9L1WH3AZ4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F97wHDFGK44k0ViKB4D2bd+6LB67uhxR1OXhiAQdIsTp3BE621UHfFGcRxhkVIxG3KD0FMAcXhUUi1l7K7kKPAc3RtXvU0aL645dWhc+EC5tobbGq48aZ747mDgwsXSCvAr2pmN7GWceN99IyCkrHPzhh9SJLzV798HtkeH2U0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IrjGezrx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759960555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Fb6inNO4ZYHk+tKoE55ZAUExgHgw8lZ1Jb7JHUHIP8=;
	b=IrjGezrx7jbYnAKcUqreUFlcMUvabFkP8BlTpi3tz4fAxUHqzWf1NvL197/l26BikGj+dU
	tLc0/2IcbGlMsSXWNIzPaqtMnoIMUiaFd9ThhOmYdxFtW3qedZhwDlqPjcrHe8e8cPZHhK
	K50Mzrd4ak5epdcNwHR6hoWrA/JJCwU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-0W4qt-7PP6qpWq2xZBUOFA-1; Wed, 08 Oct 2025 17:55:54 -0400
X-MC-Unique: 0W4qt-7PP6qpWq2xZBUOFA-1
X-Mimecast-MFC-AGG-ID: 0W4qt-7PP6qpWq2xZBUOFA_1759960554
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88375756116so144582485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759960554; x=1760565354;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Fb6inNO4ZYHk+tKoE55ZAUExgHgw8lZ1Jb7JHUHIP8=;
        b=b3JD/AM4xF8rekMhmaoUJsOHzoMwzPbR4rhH5fpLCH1pxvv0BorylLpkVWWa17yD6P
         NhaFeSk0froP2VzftX+euDtcdIbwOOV5oTGJA0lwLV56jCSOeij61V1VrEbFlI/p8lY2
         zft/2uTFRDboV9Uvz7tKJX9X1RL+iV+WDPhEKMTI/ETcPivuX6McmWwrRvJRN+MM+qni
         Q+oh2QhWwsBC4cUh5kbBsEsUDcxP8JhMjSYVCoDP6zwbQsCHrvWlmVpFxKFCIo2D959j
         ORUidVykrQVnFOrlj8iqUGtUWt7HULKu+PES25gbEnkfDAq+S74Qe9RXhmkYSsOuNMYs
         H9yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVy23vnkNl9BohScMye+YYHvVVE9SnDcfDJB5vSUsoYg2sUfb0GV9sKssrkCypRStn/cxx5wB3ADDPueto=@vger.kernel.org
X-Gm-Message-State: AOJu0YytUvHW+Zjy9pMLNDBNoPyZukBDZu6zfwzRfOpefzZbC+vQCX3g
	0B4tONjfh2SpoU2vweIt0LjPmlkeVYoN/oMwATw9lOqT3xgyRe4xi/bpnJ42z61ycJakCbmkWrn
	opZj8xOFtrKJ+w7mo8THwjrlgv1wKUfENqnu6+yzwBNbZwPAFkBoFdkI0pofwmmUMUQ==
X-Gm-Gg: ASbGncviP88cIZLksobLBhmRaRdttrjZXZdLke04cg9jscw0K2s7XVd/Xf30ccP+mLc
	pnOGDwyiSj5jZHADYkoKDzjjLQy5rJGd4JZIW253CdnTbta77IJxkjFMyI1TVJJGCGXr8nVMLB+
	WRkSNuk5L4kxaTUSCpW+r6OQujvcAMFQcPcYCx2ckwYETknGe1WTHOoGqZ6AXpBLw1LMN5NRVFS
	z7zX3TBehvCwG0TB4iERjAOgTNvrzpmKO8gHw49nOry/xobCB0etRHOOfXQqtWvEuxfUlT4MxIG
	r4AEdLhInTOMJJwHEJ71O7CoP9gnHPUmtE0eqgbujffufYQnPVmflTzminFtEyZacOAv0hTlyHz
	vRw==
X-Received: by 2002:a05:620a:444d:b0:81b:dd0:5877 with SMTP id af79cd13be357-88351de74demr750709885a.15.1759960554128;
        Wed, 08 Oct 2025 14:55:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyXJIObkdvCZoIJoDQaDDons28azkjFba719CWRdD+uDKH5oAPdKHT7+yBu+QOkrA2yszOgQ==
X-Received: by 2002:a05:620a:444d:b0:81b:dd0:5877 with SMTP id af79cd13be357-88351de74demr750706985a.15.1759960553688;
        Wed, 08 Oct 2025 14:55:53 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca2f1bsm74263685a.33.2025.10.08.14.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 14:55:53 -0700 (PDT)
Message-ID: <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error
 handling pattern
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur
	 <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, Tiezhu Yang
	 <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 08 Oct 2025 16:55:52 -0500
In-Reply-To: <20251008195905.333514-2-costa.shul@redhat.com>
References: <20251008195905.333514-1-costa.shul@redhat.com>
	 <20251008195905.333514-2-costa.shul@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 22:59 +0300, Costa Shulyupin wrote:
> The code contains some technical debt in error handling,
> which complicates the consolidation of duplicated code.
>=20
> Introduce an fatal() function to replace the common pattern of
> err_msg() followed by exit(EXIT_FAILURE), reducing the length of an
> already long function.
>=20
> Further patches using fatal() follow.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 42 ++++++++--------------
>  tools/tracing/rtla/src/osnoise_top.c   | 42 ++++++++--------------
>  tools/tracing/rtla/src/timerlat_hist.c | 50 +++++++++-----------------
>  tools/tracing/rtla/src/timerlat_top.c  | 48 +++++++++----------------
>  tools/tracing/rtla/src/timerlat_u.c    | 12 +++----
>  tools/tracing/rtla/src/utils.c         | 14 ++++++++
>  tools/tracing/rtla/src/utils.h         |  1 +
>  7 files changed, 80 insertions(+), 129 deletions(-)
>=20
> diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/s=
rc/osnoise_hist.c
> index dffb6d0a98d7..43c323521f55 100644
> --- a/tools/tracing/rtla/src/osnoise_hist.c
> +++ b/tools/tracing/rtla/src/osnoise_hist.c
> @@ -592,10 +592,8 @@ static struct common_params
>  			break;
>  		case 'e':
>  			tevent =3D trace_event_alloc(optarg);
> -			if (!tevent) {
> -				err_msg("Error alloc trace event");
> -				exit(EXIT_FAILURE);
> -			}
> +			if (!tevent)
> +				fatal("Error alloc trace event");
> =20
>  			if (params->common.events)
>  				tevent->next =3D params->common.events;
> @@ -615,10 +613,8 @@ static struct common_params
>  		case 'H':
>  			params->common.hk_cpus =3D 1;
>  			retval =3D parse_cpu_set(optarg, &params->common.hk_cpu_set);
> -			if (retval) {
> -				err_msg("Error parsing house keeping CPUs\n");
> -				exit(EXIT_FAILURE);
> -			}
> +			if (retval)
> +				fatal("Error parsing house keeping CPUs\n");

Looks like there was existing inconsistency with newlines... maybe have
fatal() include the newline automatically to simplify callers slightly?
We're not going to print a continuation if we're exiting.

Otherwise, for the whole series:
Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal


