Return-Path: <linux-kernel+bounces-863469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D131BBF7E88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86ECB3B1EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6234B181;
	Tue, 21 Oct 2025 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjrQ3hqk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FF346E5D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067929; cv=none; b=NpCC7aFC9PjW6gysWacfncHMOy1S8yKh7OsClAxoGSrhIXpim67zTK+KvpI89/CHaJy58hoYQxuxpl7EFvt4hKhRknzTjR/tGfckL/Jv4VoULnO3FpLEfsMhg4eI3YcwmBZFChIrpmEdqNaUdCjAipdw6xyjRFgoTH0hhYNBYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067929; c=relaxed/simple;
	bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XOX4dei+kKn7jgISOUjn3jsdafRS/TFGWchT2MGjq7OYimfr+ABFilXpjrmy2LygJumv8fp9xLEFR8g7crCYwEDLEeWpoQUqXm9nzP8LOV7ekO7WWFuDwgh2ZFd1s2urgOmNr4wZnf4hkt0JPfFLwpMQ4uIURiOSjzCLYCnNPEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjrQ3hqk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761067927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
	b=fjrQ3hqkgKWY07keImJEIxujn3gxxFjxzNEdxIuYxtGcZWC7dlnBQszKiohBmjVqIxmoS4
	qVtSrMHy2NUk/BNb3BaOgslFKkq6bKggZAFMHznDaPUUsQjb/TVDq1UDDgGS3Y0cVBBBLS
	ejgXHMBwFtwurtFCL5GwZhIFsYd/TK0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-njgxaVDvOgWwZnGSKG_IwQ-1; Tue, 21 Oct 2025 13:32:04 -0400
X-MC-Unique: njgxaVDvOgWwZnGSKG_IwQ-1
X-Mimecast-MFC-AGG-ID: njgxaVDvOgWwZnGSKG_IwQ_1761067924
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88d842aa73aso233062085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067924; x=1761672724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
        b=X1Io3FXW2YMy/JZnlY968NUGO7U1j3xFCnxdzmOh1KmyOFNplkg4ztEK4A/4450AqF
         umFzOb1t7iaf6nMhkNDGa/R8qQFaWvzPpiKfNH3HUiTALz4pgFM7VoE+LiyQ0BlQYN5N
         MJq7vR4Xlml8qd3QpKWxkqIHwC8THtLgNYtQzLnVXUXldn73NZZap60VFXVmGecx3uaV
         MuH/1zxihQMQUDiJSIJYIj4ST/5lFkepfE1t+xDDm/kWz5iNFvWL8uY5FRWT6JYR9tKW
         UrISlelGchtYM7QSn5KvQI9bUM3fRVSrkdPcSjydhCxjuzM976rN2sCVvAKHL9SUj2rG
         tcDw==
X-Forwarded-Encrypted: i=1; AJvYcCVJw1LAonzCGcm/qscjkHB5+akauFcBag9e7XZzGSKljRcJSdrXXa7eylgPBSUfBmbu5pp/ETixyIUBmlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzC7dJ+Hncvj+qxRkUyJFeKLH+f7C6/MloewQhzKs1tr53AI5
	Ttzvb80yesgMdSqVxScTNAP7qmtzBOGOFUNN1kdbW8Gssb8GX/IyPGRx8l7VrlgpudUUTKn3mX3
	HYN+0LuJHHw7XB9+iu1b/nzRmjSuFBs6DjIWyHmzv5YWMuGB5uSXmBhZHxCN5PqtPkA==
X-Gm-Gg: ASbGnct6I891uv4H23d4zz4fU8kILgASBaVR+kgcicS0pTHkweMiQVTI7cwZfxfS17r
	TeEWri/Kdl1r9P7CdNSW9ibdQDGIKjf4s9iTSeNSRKiGXHuGhp4KOaoPqlQLMvm/Tn2MTwHk0UE
	QEv+Ec6/Nh8LEp/RKLMKjYsMVWHeCaOvugOYQzCfRKe0LctDxLBYbIw3gDEEl97d1UgfAcNPFSb
	54rb16TAwK8YeBt84Fl7wye58gWPvjgwM5seuwqk9C9DCHFK5muedoOrKQ31g8a/+Fe6LLowlt/
	vWCI4+zUVYGvyDZZnuu7+mdNixjNLNnGdOsomsskiK6SAzmMvsyC32B5CyvBYeM4sILzHJrprma
	2ihkLz9Sy8jZGtLvNuXOZorFidfhsfdQ=
X-Received: by 2002:a05:620a:319f:b0:891:c248:a513 with SMTP id af79cd13be357-891c248a792mr1509680985a.66.1761067924067;
        Tue, 21 Oct 2025 10:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJnTDhJjNQ1qpexZXHyE5h/wTUDGSCb6wrNmM2suFXRMcNKfVQbc8YiNqvmKsKuM3t83MyBw==
X-Received: by 2002:a05:620a:319f:b0:891:c248:a513 with SMTP id af79cd13be357-891c248a792mr1509677585a.66.1761067923717;
        Tue, 21 Oct 2025 10:32:03 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5d8bsm804157285a.8.2025.10.21.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:32:03 -0700 (PDT)
Message-ID: <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur
 <jkacur@redhat.com>, Luis Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>
Date: Tue, 21 Oct 2025 12:32:01 -0500
In-Reply-To: <20251021130232.2ca75863@gandalf.local.home>
References: <20251017144650.663238-1-tglozar@redhat.com>
		<20251017144650.663238-4-tglozar@redhat.com>
		<c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
		<CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
		<aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> On Tue, 21 Oct 2025 10:58:06 -0500
> Crystal Wood <crwood@redhat.com> wrote:
>=20
> > Huh, so I guess BPF is an exception to the "no generic printk to the
> > global trace instance except for debugging that generates a big boot
> > splat" rule?
>=20
> bpf_printk() is an event and not the generic trace_printk() that would
> cause that splat. You can turn it off.

Ah, I see.

> > Speaking of which, why doesn't trace_osnoise.c call
> > trace_array_init_printk() given that it uses trace_array_printk_buf()?
>=20
> Note, trace_array_printk() (which trace_array_init_printk()) only works f=
or
> instances and does not print into the top level trace buffer.

Yes, it's for instances, such as the ones rtla creates.

-Crystal


