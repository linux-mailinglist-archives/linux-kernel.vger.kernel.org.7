Return-Path: <linux-kernel+bounces-837731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E42BAD0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3E2189340D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3A303C9E;
	Tue, 30 Sep 2025 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjgiDAm6"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001886347
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759238933; cv=none; b=qBI/Ix9GYlBkyd/bmYhSxw2colo5rQPatx2BJNsR71Z/4qMR6seXXJHu+7jfE0lxtbdi+k4EUnn8JCm61uGIex+zSaeVDF59f9+cG/xxHBrfP0pZSUuCKLpnLNzm+XjENfSvQqFxWCwQ8AkgC2WpAt5ICR5KwSqX+b4nhqO0FIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759238933; c=relaxed/simple;
	bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lb/JvGZXDz2fz/ByqoTuX3Tjro5PtI9++18ktWbVYTW14mwIv+0IFKQi7UClgfhPTAPmgckBgo7rHYd6VrjSpPZB6GXJhQ7LbUZfg3Zke3GpXBR3bHN5jdTR+5AT+WlOlVoRLEIN6TrIAg58lEeaJ2dyP3YPbQ6r3cvZxA6LSw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjgiDAm6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b463f986f80so53918666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759238930; x=1759843730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=YjgiDAm6eY+UkUSBYSZn0Sk2Ax9nGsWUueV9rmcCSQkxCXyKHNC05yRmGQZGTlRFNo
         64Wo4iN0ACEQ6Edm8GeV7V8OhtjJKwnfOsZw63k9YxVWi7CH7jtDS/Mt9QoIqKNWmlfo
         yovJWq1q9BqUEyDszpShmrvqPvDqwcHCbfo2t8km/zSiN5Pbc9cMc/MUJSYGCsOPKIwC
         OfaTRfIEsGRVFWvaeP17hOgf6JC8vZW3LoXXaQDYzbRMWpup6OB5H9U/N3EWN52+hASb
         8m7slGXb4WWnTIsabL5ZOu3mhj03hKBGdarlBbyudTPuJBANNRQ9ZsXpXnF9+CKx0sB+
         iyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759238930; x=1759843730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VfR0+ZpkXifBGlKA227sKAgFzJSeMlUIjsSH2QVw/c=;
        b=EdLyQtFDtqAoH12/9s7rWSCBtCwRCsJJw+ifZ+poSaN8IUamhdscl4Vp5Iqh12yscF
         5yV56SiJmc2pPHgha6RZOlcelU149ecybMEgfDxpWyHChWfbJ7hho4+HI5GbpGRc2WkD
         exn0Yr6aL4hu45griw2JCOcgCeoA03PjFhEATe0/hI/L0+VMWNAv7GI2XvDQJDnuglZQ
         AuydqV0OXoNt/JJz8P7pUXZZ6F+epW4s/B09FamDoNfH5NsGrucg5hggy/1CVY7IUIRD
         la1/UxZZKzDaPVKFiTfQGZIGOdq97dp/7ZK+r0S4LefWEtEm2gjwGG6SeGrJkfaPdXwH
         LiAA==
X-Forwarded-Encrypted: i=1; AJvYcCXwadvy1KHFrj0k2oGKleA13ZmPHSRsMfcGAhkk/ql2O4Gdy9mTEMYEaOgxhb32MBtI0vsoq1V//CC7IdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+GKEbTd5JjwRBAPsQnOit70A1cAlK5+5mXuzn0nKgSeIQ+Td
	QI3hhmu5+C3qXVKCqm14S8vIVUxI7euWaA5X7LNGJwS6q19FZNTtjtq5g0w2lvkSxqEX0eWfnIP
	39DU0kP6Rx+Z8U8Y6/E7J4RyrAoV1IxQ=
X-Gm-Gg: ASbGncuIGMrsq8XG6pJA8PwHX9zj0ycUrVOQJdZ+CCjjT3wlJOXWsqsqefJCWBQn0gc
	ZKGJS0hV3pmudInr7Cg5o8gD5up/OPQs4gs8QGWoc4ZFQL3yO1/XNPiklycqIRTRIAenNCXOtbY
	hkKu9P4FqIJNlRPoeFGdbvxDaDydW7OlFM3nhccM6SmRDWFHnXOIwGAlS0MY6D2mEYQ6Iz1ryrN
	Aadvjr0K5xuA3R0XNycPWRkcGuN1NKQEs/mZVurO2SvCRpFH4lF/qWhQA7HuWrQZLk//+KndpUy
X-Google-Smtp-Source: AGHT+IHaQVYd6ImpL5YTGVs15/2JsWNu+7AeBWUGR9qjk8XTSmLtzWaty3ikvQfPDC2IEaImvJGIcGSNpk+GMDcILok=
X-Received: by 2002:a17:907:7f0f:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b34b6449b22mr1942736366b.5.1759238930230; Tue, 30 Sep 2025
 06:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930120028.390405-1-sidharthseela@gmail.com> <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30a447f86eaaa@gmail.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 18:58:38 +0530
X-Gm-Features: AS18NWB4ZnK-hPHM15k8TTyVg96siZ4T3dlet_JRM5E66GuSMxv9aaJCvUWVRAM
Message-ID: <CAJE-K+BN8iAShdMkPUATbDD5pAgSrMUakst2+OzOvH3WkZWEfQ@mail.gmail.com>
Subject: Re: [PATCH net v5] selftest:net: Fix uninit return values
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: antonio@openvpn.net, sd@queasysnail.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	kernelxing@tencent.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 6:20=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
> Since it's now only to ovpn, better prefix, which matches other
> patches in that directory, is "selftest/net/ovpn:"

Alright, this makes sense.

> Btw, review the posting rules. Leave 24 hours between reposts:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Thankyou for pointing me in the right direction.

> stray line
Ah, will remove in the next v6

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

