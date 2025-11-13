Return-Path: <linux-kernel+bounces-898534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C09A2C557B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266AA4E43BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A183826FA67;
	Thu, 13 Nov 2025 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7/foJwi"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4324225BEE5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002236; cv=none; b=s9jkJF1gPnGI4pq/ePy6hwhDgz20tg7qjSWqJbGnmXId6b+5epVeNYisF3EJwXPZ4M1j2r3bS+uqWUq/ciH08QRuvQ7NO0E68LPjbTVN/MBiKOZ8xln8h72gCkXdpBRciotkXpdNFcnkwdxjiO2kuG0Q71OqF6j159zffdoxPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002236; c=relaxed/simple;
	bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAJxF7oMovU+kmUnZ3ExU7N+Bn+3wHIPmIOheVbnLxPA9HZ1bWwQKT1nf6afcRl+djLI4wvwhvjf9SP1OGAPD29DNcbR2MuUEFcJ0bdMa76T5plCs8pGfPHsuRLb7xMjuoHkVctdYo/C18XmO/OQoU1sEJbCIBq7wQIpwTdzH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7/foJwi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so138571f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763002232; x=1763607032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=A7/foJwih5tODU6mGE56M+xIRYocWBiG/pexRxN3jFMXT3bAERCE0iR2tVvnmJNPPv
         zqhOV+8gk2MU4zrJ3u6AcjImkwQjQL/V/TQqstpSF8eeCj2SjSDJ2ZWug+hQb90IrMVE
         ySH8bacZznHRMx6UULqycj+tOxEB21GmrHiEN7dsAVmYb5JPcAGlXjD5jeD3CguyLNnq
         8/yuElRV8rX4D76Yh/sGXTHuutKpGxqQPk+BrE5cp8UsuzyZpzt1tCkb7CL6jjDint21
         PUCbdNIrr9Yjq9HOCtdmub1ZNUK5uQ+bevYHj7m4UXpYDnm4YCOqQZHdKn3LzgG3tCYT
         coVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002232; x=1763607032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1UywZ5EspbYYlW6xtPXW+5JF7MzvE+fk4ld2AVk511Y=;
        b=sKGDPPBv21iWj9Wwh2BMqOdlaZVhGSIwjkSeoLwn/xt9r4qUJ30qhB6ej9F/KYSO8T
         cavXdiJhyGb0nEG27CGypq/l9auWyhd74UCtWp5SwhZ/U6U7xnaVL+JsEK5VFlhCewAl
         FDv7YBPldbsdn7NGGyoQmgQfnwsneOJsO12M6Ko2MDyxmxT+uJ81psKhWyPY14cFqb5F
         0jqCnzSou0sPXmZLHT2nXqeqmBibUPevKV+oamKwyaaM9fdb46MQEVljnTQ5JFKVWmpW
         QkeQy4acPvekBi8byqnX+hV6I+lMjUuJGwE6GJA9j7/F2qLvCMZa4T2JoaglT4FgJCkH
         bxnA==
X-Forwarded-Encrypted: i=1; AJvYcCXNyUiQJyXd1c9vKU6CxKagH6gIdnJ7vLxde97WfZO4OgSbjRSraPbIIOfzLdEAP/G5+QsDJY3N87wtkWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPXN/qUqsZeVHUC4TFycisKhk2MLRZkzWLjgIDAxlbf0voqdz
	9pBx0Qu2khRjTCpyaeIhBFzuV9cDZPlgKCOwoJqRGSsJTBv9FjuiMMwyDL9eT24gKX6J9kha2qA
	S2lqjnlOq//9YW4fDNnzFLrw3ujQ3qzM=
X-Gm-Gg: ASbGncvQqo5kFUNxEnBU318Rh0rjDoSSCVhHY0d+cq0ZZ64Li/PQgZaNOUyeuYPwuqQ
	ObQ43MFyC4a+4EiYGtYqQ79K5ObExzEGnc5RGYpNfiArbyJyiTR4hrQE22A2n6pP3uXqCus719T
	WiSap5u+kzxeZaSZXLkLw+ObEIJ4+xQY4MVx7ZjSy3nP3Q+FzITsJ7P7YhU7DlN2BHHc6x+vDpb
	wtnNtNuYSK/oFxcc2FF7kc8s7x4blORP8+VGPzkJaiEjn5mn7qt1NdL3C4bXDP9X/CIUXaOmvJ1
	HV3dlU1ELd+HgWdfLA==
X-Google-Smtp-Source: AGHT+IEGxkHsLlDeqqKYYxVV4qPNOdwbtTL8tifx+l6rLgWuNnhOTSmN/RLFv9iuIJNS51+mPUGAeqeerVG2TSOJBiA=
X-Received: by 2002:a05:6000:4310:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-42b52814d8dmr1346241f8f.17.1763002232446; Wed, 12 Nov 2025
 18:50:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112142003.182062-1-pmladek@suse.com> <20251112142003.182062-6-pmladek@suse.com>
In-Reply-To: <20251112142003.182062-6-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 12 Nov 2025 18:50:21 -0800
X-Gm-Features: AWmQ_blTyug6l3_C6LlEH8I8hAO4t3AT5lTjYea505BxtYynZkMNHSFE3MVvFng
Message-ID: <CAADnVQKUffyGCmpoGcvSTF1hwN58c7X=Ebvn70Y2Z0ZWJS0p=g@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 6:21=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> bpf_address_lookup() has been used only in kallsyms_lookup_buildid().
> It was supposed to set @modname and @modbuildid when the symbol was
> in a module.
>
> But it always just cleared @modname because BPF symbols were never in
> a module. And it did not clear @modbuildid because the pointer was
> not passed.
>
> The wrapper is not longer needed. Both @modname and @modbuildid

is no longer

> are newly always initialized to NULL in kallsyms_lookup_buildid().

are now?

> Remove the wrapper and rename __bpf_address_lookup() to
> bpf_address_lookup() because this variant is used everywhere.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>

other than typos in the commit log it lgtm.

Acked-by: Alexei Starovoitov <ast@kernel.org>

