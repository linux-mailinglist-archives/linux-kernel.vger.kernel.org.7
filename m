Return-Path: <linux-kernel+bounces-762619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E068DB20906
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95A554222AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9302D3A9F;
	Mon, 11 Aug 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlQiHuf5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AB223B613
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916022; cv=none; b=GukO5EkpvSvTiSjrk6nwNB9xldFreAEIndNmmbI3/TadKdFJe2LBEzHAdkqUzFYNWwhI9bosR9qX+UsYFAt3rF/NAy6cKIkcV0FBPk7vYXjPlz3SITpe2SPGUxW6lKKsQ/I1NCpl6/4sPeDpJpw36jxTpiZMucsqNw3Bf9Ey3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916022; c=relaxed/simple;
	bh=9xaM4Pt2YCauMrxzFhfs7UN/WCmCUiUw/jxQbnBrR1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tBlRKbOHnFfTHkWU4igr4mA1r0Q+giWYYxRxzRnc7wwOCk7FoizC58Nf0Xqz60fHTI4px1Er3y58EFQJJhOSL+CJIWe5m1lc+eHRqrQ+eW8IauWfwTAeS1wXqRlT69CDZzU2RW+9IWoCuN189cto7MeMx75WJR5SaJU0KXgiKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlQiHuf5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754916019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H5BUV8YhRn/Ax4dIkTjLV1BItSPJ4aeJpn68BpS8ZZc=;
	b=XlQiHuf5rzGC0Iw9jRoz3Nw4prAkS13GWn2VvFQTzbpJKVsZQ3w4A0NN6UNvCkOYOOPqvr
	w96YQ+Vdp2AB8Sl0ADFMtcdm8XxiBsVOvwTrzG4NX3B9b+5QI7sZSutTmAaQV+D05DKM8Q
	JARiNfDR69ydAg5Y4NDWIvfQl4eVzjU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-XNoINA29Ng6IJGuRfzD1Gw-1; Mon, 11 Aug 2025 08:40:17 -0400
X-MC-Unique: XNoINA29Ng6IJGuRfzD1Gw-1
X-Mimecast-MFC-AGG-ID: XNoINA29Ng6IJGuRfzD1Gw_1754916017
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e667b614ecso939325085a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754916017; x=1755520817;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5BUV8YhRn/Ax4dIkTjLV1BItSPJ4aeJpn68BpS8ZZc=;
        b=UpoeXzFj0t6FmpT1Br8Bp1smqm/P6dzOokJqbRchDQZ7GfBnA5bYWgzZRelZYqzftH
         Cl6DFMCmwS39B8xCs8ZhFf2by+3cE4En1MlPJHjnxa//5ZuHF33En63JH88IhHd596ee
         VKs445/2CZKQ+CJ7U2wQqMO7TgY8q1T3oZDRuHxPVnrzJrb2DDgjyt49eZYuTzGrpoQs
         S4lZ4z7l2JdofcLNgWtE8NYOFL3JEN15XH98cX6Aupwp6HXXDG4T0z+103PHrO6R4KSM
         kqJcIXUgwLffJQxXNduy5389extrSr1aJ9W5gSpF355mSu4HkqPgq4DZa4SfPVffIu3s
         y4gg==
X-Forwarded-Encrypted: i=1; AJvYcCVUhBOaeCzItDHCmIwima+cYkxXfAU2Yh76NHpBBsD3BUkYlpP2de015n/umcabFrzya7OtLuLOkcp57vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkg7A18H8NIdz7FobXA5HZcWwG2lMw9iHUNJq57KkyKXz0KwWK
	v3PWfS3H9ZnhLgJi8xsMtJoRdAfDDEkWg4JIovNwb+zVUXlFis/EsfXPtEj9x1fSIwO3assnpOW
	pB/vON2txYnSNVQCBCfY89pXt6C4pJdDfENzN5EzyGZ/bmmRZDOvMQpDG7xMvwvzZ4Q==
X-Gm-Gg: ASbGncsZ8Inansec4i5ez1xEoWYOa3BDF++q6Ax5gajdVtoQFjMSK32OJa2JD3livmz
	mv/4n/0XFjUX+7+HKM3G7hyDc4NPS1S/y7jjGA+GwwD1VlMhKzT+KfU2O0lQYd0pJVwyHxedJ4k
	Pq1TDxyakzs8GYebq9iL9Fgk83RkZnk3ReofCTTyqRQQju4kSj/XVR0KOEAkqk41K1k+CIesoIE
	vMLxNutrjinSYYR0zzsbKqfY14yCsOB+dOR1lZI4RTUp9ISGcjec54+QLVhg/WiOP3F3F1nTgK9
	s1Lt3lBIVKAr0iQAKPP/7cEmc48IE/WDGjf1D5MLPpbINsqsS61KV8eNPkRLB8bo9g==
X-Received: by 2002:a05:620a:a50c:b0:7e1:9357:85df with SMTP id af79cd13be357-7e82c7bcaf6mr1624714285a.55.1754916017190;
        Mon, 11 Aug 2025 05:40:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG9QTo9AdNmsvOYlTc5kHQZC3mxnMpfJ5588uXlgec0XggbhPVrUQNodSuN9JBendrRyxPOA==
X-Received: by 2002:a05:620a:a50c:b0:7e1:9357:85df with SMTP id af79cd13be357-7e82c7bcaf6mr1624708485a.55.1754916016521;
        Mon, 11 Aug 2025 05:40:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80235288fsm1093882885a.22.2025.08.11.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 05:40:16 -0700 (PDT)
Message-ID: <9e3d1c141c1e6609252aa38348986fe1436052b7.camel@redhat.com>
Subject: Re: [PATCH v2] include/linux/rv.h: remove redundant include file
From: Gabriele Monaco <gmonaco@redhat.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	akhileshpatilvnit@gmail.com, skhan@linuxfoundation.org
Date: Mon, 11 Aug 2025 14:40:13 +0200
In-Reply-To: <aJneRbHGlNFg7lr9@bhairav-test.ee.iitb.ac.in>
References: <aJneRbHGlNFg7lr9@bhairav-test.ee.iitb.ac.in>
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

On Mon, 2025-08-11 at 17:42 +0530, Akhilesh Patil wrote:
> Remove redundant include <linux/types.h> to clean up the code.
> Move all unique include files inside CONFIG_RV as they are only
> needed when CONFIG_RV is enabled.


> Arrange include files alphabetically.

That is usually not necessary. Also, it shouldn't happen, but sometimes
the order of inclusion matters. Anyway this isn't the case here (builds
fine locally) and when it is, the test robot should notice.


Looks good to me overall, thanks!
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor") [1]
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/r/202507312017.oyD08TL5-lkp@intel.com/
> Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> ---
> =C2=A0include/linux/rv.h | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..9520aab34bcb 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,16 +7,14 @@
> =C2=A0#ifndef _LINUX_RV_H
> =C2=A0#define _LINUX_RV_H
> =C2=A0
> -#include <linux/types.h>
> -#include <linux/list.h>
> -
> =C2=A0#define MAX_DA_NAME_LEN			32
> =C2=A0#define MAX_DA_RETRY_RACING_EVENTS	3
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> +#include <linux/array_size.h>
> =C2=A0#include <linux/bitops.h>
> +#include <linux/list.h>
> =C2=A0#include <linux/types.h>
> -#include <linux/array_size.h>
> =C2=A0
> =C2=A0/*
> =C2=A0 * Deterministic automaton per-object variables.


