Return-Path: <linux-kernel+bounces-813936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96B0B54D45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D7F48038A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B511322A3E;
	Fri, 12 Sep 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USFRPLME"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A63218BF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678933; cv=none; b=Pv3DQrd/uvaZcqmW8lx5jnCWUH3u6BnT6WxfUwgk45yYD1CRrp6SqOAg+6xYxBsPbnAGDCKe9qF3f1DagxKpun1G7N365DsLKJ5OHQ+pplJdeJRVTqGdwLVNS9NBGvuoerlRSjh5fiykq4Kd/0XJ9wrmgcY0h3KwQ9hWaAAf7kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678933; c=relaxed/simple;
	bh=V8fbqWQOTCOVVu7/P1rim4+IvcAYfNiZG/w2GK6cab4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=k+l/9a2KRjMdE/uaYD11ENEQk05E677vVN3S/azuZTntdJilyQ3cPL7Wg+8pOIUj7FyiRhfp7TO1ZAihvarvn9q0hbvOA/peZ205yYf+VujmSuWXwTpjbY8QpxRFcCbzrS8XVOLRVPVmZl5VlwMku0dM2TbuClcF4PGFSrfUzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USFRPLME; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1481227f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757678930; x=1758283730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eyXwEntkUq/1IvyuiiJejzbrGCs0SwPC/bonUwQtC/g=;
        b=USFRPLMET8iMeq4zcZ8E8+nwdjL3RtSi1H1/nHgsrDXabFKMpGZKBVLsQ71tvWuSyE
         FL17fUmbMAA+/wOyy+fAV1pYhYDM0QqWraHBLcDA1iXEzNTzdblYIBtzMpn+HUCw7qjK
         wFK/gwa9ORNJ2KJGBhAn7qX2N04p14IzJu1cNz1thEbDs1n+IuYXqCbRKC6jFK2ChiMd
         qzt2XGJprlrSLEaWE2hReK7Pc2fGc3HQPgWCHN/oM6J2FF5SuHy5MZgnKPZW7/fRTgOC
         cvDxNEbCOp8JQQJMrSUVuGWyqYeg59NGZwGRrzBp67w7raL3aIxPJMNPCg9wyA6gJaPG
         46+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678930; x=1758283730;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyXwEntkUq/1IvyuiiJejzbrGCs0SwPC/bonUwQtC/g=;
        b=mvLOQOpn8bNtvxCq3+NXUiLbkhnDDWZ2lJAbwfrs1X7/cU4rAw53qOICQKdCKXEzr4
         boikSToMV9FeB7M11alVcHy8iqFOkg/+g9jUBmZurSa26HKK1cTg3yTa9EmcDvoPHtg1
         OjDJQP00XzXbD+akDAeNG9DKsJThObIlXe1OJPblnAlb9B8OLWjqIoZqLgkbTo5xiUEd
         AmgYf9EGeicLdprCuqIlO1p/tEomosuGDAo/CEajmpaDVxtAjP3RGOarPX/6yN+bwl3T
         DbQjA9BglCWU3jhV0+MaeWAJlCDRqkf8APoTs4wyrvHgPIWIEeO9gKZElD8lHyM4zb7x
         fVQg==
X-Forwarded-Encrypted: i=1; AJvYcCV+esjwABAKDMYORIoVkBn1nQzpMM3yN1B61yOoSzq9iBo92xCDSalPthhE0J2/xYMgtj85wfeo9Wga7AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIm5SOfZ6N6+MwcGMl1yPwNPkj/tkT60K5DF1FC5G16kg/EJF
	UU5zy+j6E30kVcrWQHUNSxZ1jOCUfn4YQwOdVwPM0i85QrxJDv77ZRRQPTB9iw==
X-Gm-Gg: ASbGncvjCe3UaPfUVZCbC0GXc5FxqIz/D8vS6SazfGoOakCFSp9E9Y9AI32KP2q+uAg
	LnXMnS1dtB6qanwDhE6ZT7aYtPhNJvEBajrv0GFeWdXiqwmcwrAf2JZJY3zmSrCMh25Yh2MHbWO
	lC26SFcFcc2vW4rOFo5lhjM+0gcZImrLGMtB1zLcc6l8N+jqnKDPaXW9VxTsVeGVXeNvakQ4gIy
	73k4mzLRHLe6LP4vA7cpEKUjYpyVBuXc3EPI8bAO/BsNdlXvGdiN2GdLCySpJqPLimacAU0FFL6
	dSgYt1PkbSx4Y2XW6NfB8r+x70gVGR/2P2oa+Iad4MoUFNIBE+hYir7wYCmRsGBYfRBgObKQpWv
	rIcfVKuxOo9F7EDavtk//dnITvFzHwUE+lg==
X-Google-Smtp-Source: AGHT+IGrPhMBp6GuaPq0wxjpFhNWXqcAEvg0ats210AmO2YrMj5yxfhfipC1GHiYP5KrwliKQotJCg==
X-Received: by 2002:a5d:5d86:0:b0:3d6:1610:1b6a with SMTP id ffacd0b85a97d-3e765798581mr2392936f8f.22.1757678929127;
        Fri, 12 Sep 2025 05:08:49 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:18f9:fa9:c12a:ac60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2d43sm6364880f8f.59.2025.09.12.05.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:08:48 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Jacob Keller <jacob.e.keller@intel.com>,
  Sabrina Dubroca <sd@queasysnail.net>,  wireguard@lists.zx2c4.com,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/13] tools: ynl-gen: refactor local vars
 for .attr_put() callers
In-Reply-To: <20250911200508.79341-5-ast@fiberby.net>
Date: Fri, 12 Sep 2025 12:23:37 +0100
Message-ID: <m2a52zvrra.fsf@gmail.com>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-5-ast@fiberby.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net> writes:

> Refactor the generation of local variables needed when building
> requests, by moving the logic into the Type classes, and use the
> same helper in all places where .attr_put() is called.
>
> If any attributes requests identical local_vars, then they will
> be deduplicated, attributes are assumed to only use their local
> variables transiently.
>
> This patch fixes the build errors below:
> $ make -C tools/net/ynl/generated/
> [...]
> -e      GEN wireguard-user.c
> -e      GEN wireguard-user.h
> -e      CC wireguard-user.o
> wireguard-user.c: In function =E2=80=98wireguard_get_device_dump=E2=80=99:
> wireguard-user.c:480:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in func)
>   480 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~
> wireguard-user.c:480:9: note: each undeclared identifier is reported
>                         only once for each function it appears in
> wireguard-user.c:481:14: error: =E2=80=98i=E2=80=99 undeclared (first use=
 in func)
>   481 |         for (i =3D 0; i < req->_count.peers; i++)
>       |              ^
> wireguard-user.c: In function =E2=80=98wireguard_set_device=E2=80=99:
> wireguard-user.c:533:9: error: =E2=80=98array=E2=80=99 undeclared (first =
use in func)
>   533 |         array =3D ynl_attr_nest_start(nlh, WGDEVICE_A_PEERS);
>       |         ^~~~~
> make: *** [Makefile:52: wireguard-user.o] Error 1
> make: Leaving directory '/usr/src/linux/tools/net/ynl/generated'
>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

