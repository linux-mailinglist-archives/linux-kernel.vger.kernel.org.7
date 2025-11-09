Return-Path: <linux-kernel+bounces-891788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD8C43795
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 04:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0824E4F56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 03:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5CC1DF27F;
	Sun,  9 Nov 2025 03:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmIuom7H"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83038DE1
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657274; cv=none; b=iEh7uIOVGIpT2RblAb90Ae8S3whyG3BWFGVCxijSZBpntEWF9Jcesmd15+jg97c6+l4fsyuJGp0a432xXQl9bFF2agW+zqy2SU/uNpHMLw2KabYaobfkShzbhnFsqgr/542oKQoalewnjVF49Oi8vXJ+RKd/pD+MThvDmTDDG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657274; c=relaxed/simple;
	bh=qESZOs7qVRRXh6bJdptBB7hTiAoMVKJFzBaPoCkk3EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEdKBDqN1V3wKTg7a3uBkXBs9oflWvWJlHxj30foyNMSmTyHQyED7FtvONCpAbVPfutXnQJWVNlSuJUw3yRRwbyhtmorwVGjIgoOnZmDUlUWrPAOYMjixYuQ9iz6Th47Yy5i3rdogwk+MeyC3078errf0U5ov/jclSyD3ZtMTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmIuom7H; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-786d1658793so17898657b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 19:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762657270; x=1763262070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=kmIuom7HWv5Bw3LKWVZzRD70GEbWouljPMMw3bkvJX2DiBvWEjpum1E3ODjEAe026c
         ToSXkTv4VBoDYU6JzptKBIn0iM6ngsgZZFOvnLXH9FaqA6Jwgu6qvE4ikHRQxzZPV5Nw
         CeUp9Y/es4e1VsWIMZtvfSc7YRsjFzEZXH8Lxuu++tX/9g6nFUeEsXav0x1Ox87DfvK5
         C60uDeX+PgzJjVsUbcTw+gCW+or976Yv5tToowvIHmvKETm9VyiOHhgIFaDcgfRJ44qD
         MuRK8X1vr31eErv4HL6zoZi4R3iIEdVfbIATpMdTLEptNnExCIWqpiMy7XC9O22Sc/m+
         5aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762657270; x=1763262070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=iQkscLacwNtdnxA8Q2xZum7KPC32S3Y5sWn9Hc0kserGicc6U3RDwB2SVxibi0pu9j
         iD2gwJxFPcen69xs3UrWD1tPi9A8NrN7q0TcUfAF3vppcRDvnKbfe7yzQetJj5bZGKRT
         4jOYIxQVQZ99EeCQyORpAwyE5CwhlCxuEcPPblUPnBQc4wU5CbpEPmQ5c4ctBykTzekW
         soJUTTY8cp2y5vmPY4zk5i+59OETYCxD7j7g3l5I5Z8QXwR3raDnK08UjwstP/JfH6Ch
         GFztt0clzaswzHnChvl+QEMyAWdnlYMEMW6Dz0PtlyS7xbUnhPKbVDlpJ5szE3H8iMTi
         xrTw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Q+ItxspOMhoLV7nl1Zq52QT93d88fm3TLz4PMn+XVYc4K9zWgddQxV5P97tAQXMCHLpQd2GVrAw+iO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1cUCDzBztH+OGnJnNfeDCPy8r3W1qPEb94nCqFPBNJ14kTHMC
	shBNc0jQPGi5qfq1Fv/WG+gZAdiv5fnTdGUiUnbvPa7tPt9BR2QuhuWGD0axoTEn55FtgNgmDCd
	LtBVJFKlljFA4rclsVVq6NucME+eM4tU=
X-Gm-Gg: ASbGncsi2g3ajOQWj9aqQg88HOfZv6lPZPA5uii+KsVCjRwB6xA2/Rrnrn3V1el1cWs
	nXJCWi31LNxgAxOZjaZ1lEvDQITVuivoPl4aWJDfjMh2RSg3YoZ0uOaiE9j1kmsedrgw1EwQYPq
	Bs8tbf/Z4/WAd3aX3IsPIogeg0KGKPRUURMmxp7XoGIi1srSlkc/fQKy/rQBWKlA9EyK0lbf5Q/
	8W012T6947EYwuZVOk8TZgOOdwMgm28NlRLLy3RZdN5yJzcjB6eSYpFUTvmXORkhYW+VRnB
X-Google-Smtp-Source: AGHT+IFl0PygBGVQDcDoux4KUpDZWbMWPvO9pvbbbb8+4rH/xr6b/zEQCBbAmTqX2PhbkuQ7hJB0oosFqP46oGnaGwE=
X-Received: by 2002:a05:690c:658a:b0:785:aedf:4ac6 with SMTP id
 00721157ae682-787d5355527mr68221527b3.6.1762657270013; Sat, 08 Nov 2025
 19:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
In-Reply-To: <20251107114127.4e130fb2@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 11:00:34 +0800
X-Gm-Features: AWmQ_bl4pAwU4DcdzQl2rZraMoW7kKSb0oYzeEjLEM0Qy75Y6egynRfDTOFL-tw
Message-ID: <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexei Safin <a.safin@rosa.ru>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:41=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri,  7 Nov 2025 13:03:05 +0300
> Alexei Safin <a.safin@rosa.ru> wrote:
>
> > The intermediate product value_size * num_possible_cpus() is evaluated
> > in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> > large value_size and many possible CPUs this can overflow and lead to
> > an underestimated memory usage.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> That code is insane.
> The size being calculated looks like a kernel memory size.
> You really don't want to be allocating single structures that exceed 4GB.

I failed to get your point.
The calculation `value_size * num_possible_cpus() * num_entries` can
overflow. While the creation of a hashmap limits `value_size *
num_entries` to U32_MAX, this new formula can easily exceed that
limit. For example, on my test server with just 64 CPUs, the following
operation will trigger an overflow:

          map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map", =
4, 4,
                                                     1 << 27, &map_opts)

--=20
Regards
Yafang

