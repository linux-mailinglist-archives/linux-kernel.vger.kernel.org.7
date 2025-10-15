Return-Path: <linux-kernel+bounces-854669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DDBDF147
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7134801BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88F27B4EE;
	Wed, 15 Oct 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyI8ECYN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6419122DF99
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760538674; cv=none; b=uvxYoqg0ceNDWrosrcN46zxCE8sSHIjW7f6hw2OHPHWhNwOP+RzoOSj4jGzb3WcviYXTDURUueobWtoEFOsZ71jmpndBql0QZ78+w/R5fQIlzXPnZMgUeTBCpFuYDBbFWk0EX/CEUX1Co1s6CZ9EfZzMwKWm+xkbvMZWEWvnH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760538674; c=relaxed/simple;
	bh=yt82KrxNfXdVlSHFooLsLFYI6ULrZb5+Mw+3DRwoWkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Konr8iFzc8G861h5KIdDJfQQ4Az9iQUeat0T6B9bLA5koFU5JOzLF/6vX4IkOo9S77qW5NQFvTp4v3JlIPKVm90MGQJ36/jPs/Jd6+zvdsWRDz+FojOFJifDwRDqhCccEW7/NJirtHSoSQaOPzClkzg+hikFIECbaFF37u4iVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyI8ECYN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760538671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+g5t7vBmEsvyk289s1w95IcopyPpfTHx/XwSb9VxMsE=;
	b=IyI8ECYN74PfF6RimdPgbBRM3SPp3Zk1gF1AavYCo9hR6bGDns0chEuNpfld6IO1M+Mekn
	jRXekAH177awjIdaX6OMKRkRfXS/9Kziep2q387UURJv8lrMAhx512hCLJEZIb/lD9s7Hg
	Nn0P3Tm8YouHqxKnXt3NGWvQus1cD/o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-9NA3Y7SrPSqocoHGhVDQsg-1; Wed, 15 Oct 2025 10:31:09 -0400
X-MC-Unique: 9NA3Y7SrPSqocoHGhVDQsg-1
X-Mimecast-MFC-AGG-ID: 9NA3Y7SrPSqocoHGhVDQsg_1760538669
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so4232019f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760538669; x=1761143469;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+g5t7vBmEsvyk289s1w95IcopyPpfTHx/XwSb9VxMsE=;
        b=tz/1xyvoV4cg/+CN6r0I1w1i9nyn4TzVkga7cSR5zAIvw/jo/6ojADKzNmBNDPbK0+
         ec4I74epU5XpHMGWX6M1aHX6Z6UjhOyRw0FDolg3CMFLP9GyBZM/fA/fHnIqn0WjP44s
         OypxMRsZ2L/LseLPZlgcZsw9lkLvAQu4dbS041LKbIT4lQrW8mwci8A11rdRcmdY1Iow
         +2EemoHFMk/4cRNirMtJXKxtA9dnD3WoB+VF92/QQ6hDl//bKMWgXuWqzWo8xaNw5uIA
         kiQQqOa0JJdACh/tFwrJbNCgwe7WtwIoexrzOnoHbXZpHlciyEDtlJioZTOYDbpkMiHK
         qfYA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ov6apXl1TNZj95BAbqWI1H5Jz/RWI5sOda6F0W8IolZqF277vNNmuwnz4r48D8cHjOUXfPmyG+OyYHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg7qL5NU2Cf3LBLvGonkinIcerm/k+zp8EXJejncQ3WwDrO1zd
	FN6mkgDWxY1RISxfPqrcttebjfr4G46nwDXWVopRCbre2/1kmXUEr+6FQo/SFzYRlnJGf+TFfur
	US+mQvEc8nvBIIeP5ZczMj/yyRu+bGKXINbFVpudB4VMyd6VV6nA6GJKn0WzpIcLU4Q==
X-Gm-Gg: ASbGncuBIv8vV3JPpXmmwPq2CxcMBfk0gz4QoXVRK10ceeTm8VUjm9W+BTqa7gavndX
	xlMKpIpdYLcR57QLkB/A5MyPCCCyv1TMUzf0ENiTBeqo3gZzqYHiDaZyBLSdvHd2TdFbKVmd1Kr
	sr+B/2ZvrYGR5P4ptJozIg+jNYQZwnSowqPFKEUqJdukLn9Y7aYHIxM6o3diqRPIZGxYCnDZgDj
	Oq0B2C9QysbcPa51CFEDZ7RJmpsP7yXHE38oce3G19Fyc9Q4zo5HhG+DsppVKIIfysNm6qcEeI/
	3pCJh0NRV2yDSadFcXdWn9Zwxa53Z4PIhqNPWS8deQqzldYDbsXyHsTg5MNGST4rgQ==
X-Received: by 2002:a05:6000:438a:b0:3d9:70cc:6dd0 with SMTP id ffacd0b85a97d-4266e7dfae9mr18492776f8f.33.1760538668560;
        Wed, 15 Oct 2025 07:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeCre71jxG+X+Hfh5F4gKmuYtG7/eFDwqqKhtwC0B6T+lYKAeGrDypqHeo2Jiahm0MG6Z/MA==
X-Received: by 2002:a05:6000:438a:b0:3d9:70cc:6dd0 with SMTP id ffacd0b85a97d-4266e7dfae9mr18492739f8f.33.1760538668059;
        Wed, 15 Oct 2025 07:31:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0a03sm29748739f8f.37.2025.10.15.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:31:07 -0700 (PDT)
Message-ID: <812029378ad6adb5121ef336505d4627d70c1c69.camel@redhat.com>
Subject: Re: [PATCH 1/1] rv: Fix the invalid address access when reading
 enabled_monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, athieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, Nam Cao <namcao@linutronix.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ahuang12@lenovo.com
Date: Wed, 15 Oct 2025 16:31:06 +0200
In-Reply-To: <20251015141445.969-1-adrianhuang0701@gmail.com>
References: <20251015141445.969-1-adrianhuang0701@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 22:14 +0800, Adrian Huang (Lenovo) wrote:
> When executing the following command (reproducible 100%), a kernel oops
> occurs:
>=20

Thanks Adrian for the patch, I believe your fix is equivalent to Nam's [1],
we'll try to get [1] merged for -rc2.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20251002082235.973099-1-namcao@linutroni=
x.de

> =C2=A0 # cat /sys/kernel/debug/tracing/rv/enabled_monitors
>=20
> =C2=A0 [dmesg]
> =C2=A0 BUG: unable to handle page fault for address: ffffffffffffffd0
> =C2=A0 #PF: supervisor read access in kernel mode
> =C2=A0 #PF: error_code(0x0000) - not-present page
> =C2=A0 PGD 3ddf828067 P4D 3ddf829067 PUD 3ddf82b067 PMD 0
> =C2=A0 Oops: Oops: 0000 [#1] SMP NOPTI
> =C2=A0 CPU: 479 UID: 0 PID: 15237 Comm: cat Kdump: loaded Not tainted 6.1=
8.0-rc1
> #25 PREEMPT(voluntary)
> =C2=A0 Hardware name: Lenovo ThinkSystem SR645 V3 MB,Genoa,DDR5,Oahu,1U/S=
B27B31174,
> BIOS KAE139B-5.70 06/11/2025
> =C2=A0 RIP: 0010:enabled_monitors_next+0x41/0x60
> =C2=A0 Code: c0 66 a6 bb 75 24 eb 2d 66 66 2e 0f 1f 84 00 00 00 00 00 66 =
0f 1f 44
> 00 00 48 8b 50 40 48 8d 42 c0 48 81 fa c0 66 a6 bb 74 0b <80> 78 10 00 74=
 e9
> c3 cc cc cc cc 31 c0 c3 cc cc cc cc 66 66 2e 0f
> =C2=A0 RSP: 0018:ff565a8b1e653d38 EFLAGS: 00010203
> =C2=A0 RAX: ffffffffffffffc0 RBX: ff41e057260eabb8 RCX: 0000000000000001
> =C2=A0 RDX: 0000000000000000 RSI: ffffffffbba66640 RDI: ff41e057260eabb8
> =C2=A0 RBP: 0000000000000000 R08: ffffffffbb313406 R09: 0000000000000034
> =C2=A0 R10: 0000000000000000 R11: 0000000000000004 R12: ff565a8b1e653dd0
> =C2=A0 R13: ff565a8b1e653da8 R14: ffffffffbba66640 R15: 0000000000000000
> =C2=A0 FS:=C2=A0 00007f8da78a4740(0000) GS:ff41e076cde6e000(0000) knlGS:0=
000000000000000
> =C2=A0 CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> =C2=A0 CR2: ffffffffffffffd0 CR3: 00000001b6b26005 CR4: 0000000000f71ef0
> =C2=A0 PKRU: 55555554
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 seq_read_iter+0x2ed/0x480
> =C2=A0=C2=A0 seq_read+0x12e/0x160
> =C2=A0=C2=A0 vfs_read+0xc1/0x370
> =C2=A0=C2=A0 ? count_memcg_events+0xb6/0x170
> =C2=A0=C2=A0 ksys_read+0x6b/0xe0
> =C2=A0=C2=A0 do_syscall_64+0x89/0x810
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =C2=A0 RIP: 0033:0x7f8da79a0321
>=20
> [Root Cause]
> enabled_monitors_start() calls enabled_monitors_next() and passes the
> address of a struct rv_monitor instead of the address of its embedded
> list_head.
>=20
> Commit de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()"=
)
> assumes that the argument p refers to a list_head (the embedded list
> anchor). This leads to the miscalculated address for the corresponding
> struct rv_monitor object.
>=20
> Here=E2=80=99s what happens in detail:
>=20
> =C2=A0 1. Address of rv_monitors_list =3D 0xffffffffbba666c0
> =C2=A0=C2=A0=C2=A0=C2=A0 crash> p &rv_monitors_list
> =C2=A0=C2=A0=C2=A0=C2=A0 $1 =3D (struct list_head *) 0xffffffffbba666c0 <=
rv_monitors_list>
>=20
> =C2=A0 2. offset of rv_monitor.list =3D 0x40
> =C2=A0=C2=A0=C2=A0=C2=A0 crash> rv_monitor.list -x
> =C2=A0=C2=A0=C2=A0=C2=A0 struct rv_monitor {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0x40] struct list_head list;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0 3. In enabled_monitors_start(): The local variable mon is assigned
> =C2=A0=C2=A0=C2=A0=C2=A0 using list_entry(), resulting in:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mon =3D &rv_monitors_lis=
t - 0x40 =3D 0xffffffffbba66680
>=20
> =C2=A0 4. In enabled_monitors_next(): The argument p becomes
> =C2=A0=C2=A0=C2=A0=C2=A0 &rv_monitors_list - 0x40. However, container_of(=
) subtracts the
> =C2=A0=C2=A0=C2=A0=C2=A0 offset of rv_monitor.list again, making mon equa=
l to
> =C2=A0=C2=A0=C2=A0=C2=A0 &rv_monitors_list - 0x80. This double subtractio=
n results in an
> =C2=A0=C2=A0=C2=A0=C2=A0 invalid address and triggers the page fault.
>=20
> Fix the issue by returning the address of the list_head from both
> enabled_monitors_start() and enabled_monitors_next() instead of the
> address of struct rv_monitor.
>=20
> The following verifications make sure the issue is fixed:
> 1. Without enabling any monitors
> =C2=A0=C2=A0 # cat /sys/kernel/debug/tracing/rv/enabled_monitors
> =C2=A0=C2=A0 <No output; no kernel oops.>
>=20
> 2. Enable monitor and reading enabled_monitors: Test #1
> =C2=A0=C2=A0 # echo 1 > /sys/kernel/debug/tracing/rv/monitors/wwnr/enable
> =C2=A0=C2=A0 # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/sleep=
/enable
> =C2=A0=C2=A0 # cat /sys/kernel/debug/tracing/rv/enabled_monitors
> =C2=A0=C2=A0 wwnr
> =C2=A0=C2=A0 rtapp:sleep
>=20
> 3. Enable monitor and reading enabled_monitors: Test #2
> =C2=A0=C2=A0 # echo 0 > /sys/kernel/debug/tracing/rv/monitors/wwnr/enable
> =C2=A0=C2=A0 # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/sleep=
/enable
> =C2=A0=C2=A0 # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/pagef=
ault/enable
> =C2=A0=C2=A0 # echo 1 > /sys/kernel/debug/tracing/rv/monitors/rtapp/enabl=
e=20
> =C2=A0=C2=A0 # cat /sys/kernel/debug/tracing/rv/enabled_monitors
> =C2=A0=C2=A0 rtapp
> =C2=A0=C2=A0 rtapp:sleep
> =C2=A0=C2=A0 rtapp:pagefault
> =C2=A0=C2=A0=20
> Fixes: de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()"=
)
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
> =C2=A0kernel/trace/rv/rv.c | 14 ++++++--------
> =C2=A01 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 48338520376f..021cc9bc57ab 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> =C2=A0		if (mon->enabled)
> -			return mon;
> +			return &mon->list;
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> @@ -509,23 +509,21 @@ static void *enabled_monitors_next(struct seq_file =
*m,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -	struct rv_monitor *mon;
> +	struct list_head *lh =3D &rv_monitors_list;
> =C2=A0	loff_t l;
> =C2=A0
> =C2=A0	mutex_lock(&rv_interface_lock);
> =C2=A0
> -	if (list_empty(&rv_monitors_list))
> +	if (list_empty(lh))
> =C2=A0		return NULL;
> =C2=A0
> -	mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
> -
> =C2=A0	for (l =3D 0; l <=3D *pos; ) {
> -		mon =3D enabled_monitors_next(m, mon, &l);
> -		if (!mon)
> +		lh =3D enabled_monitors_next(m, lh, &l);
> +		if (!lh)
> =C2=A0			break;
> =C2=A0	}
> =C2=A0
> -	return mon;
> +	return lh;
> =C2=A0}
> =C2=A0
> =C2=A0/*


