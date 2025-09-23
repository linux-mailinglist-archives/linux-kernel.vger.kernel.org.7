Return-Path: <linux-kernel+bounces-828731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED82B954C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B2016F3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A507320A3F;
	Tue, 23 Sep 2025 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy7S9H/Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EAA313536
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620601; cv=none; b=o0CJDBiZ1tsymqJBgMDm58/tdqXLsm+xHtLQ8LAsLyE6+Yb8rgUFau57es3LRFkQL4E4u1QoXr6i6S0Gln5t4aoTFz5ND86DwdK4b4L/G+glDTdeviCSPzK2IvQBBCCQxLABzQVIQHL8Er/kKZ66BmatVzLH8mfmT12Lm6a6AuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620601; c=relaxed/simple;
	bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1UgXcCqtuKY6M0Jmax1rrzEhjxROjNt1AIxbCqUBoUgI3PUVtgFn+fhx/UuwCeBh6iyaUtzFfv23RGwVIQW3SictylWtDpMcfxfdPWHQLuakaEnsNT9CiDnKt5xKphucZRWXHOjDUMs9mFpT0UnruMQ9VyQD7po4MbjwKXp6qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy7S9H/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758620599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
	b=dy7S9H/YKg1+z6wopWhzbX5vTEnq01VH2UisRH5S12uNd7hf/bX353sgF+NGWELfp4Zgn9
	bYEUJFL/wTIrBYCthe3KOKHcjqdA58vhcyhk4AWny5CGkFp3DOCxf1vgSveCm/GUzrDC42
	KHT1xUVRjuwQvp3emHn9l4KfWfpLYhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-OqtFnmhrOziLJH-60PLlUA-1; Tue, 23 Sep 2025 05:43:17 -0400
X-MC-Unique: OqtFnmhrOziLJH-60PLlUA-1
X-Mimecast-MFC-AGG-ID: OqtFnmhrOziLJH-60PLlUA_1758620596
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45e037fd142so46927685e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620596; x=1759225396;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
        b=wekv9DaED+n/V3ktGIAL4kgcFFXXoisnQW+gqTfoDZUAQJgse3DlyBnyV2pFFzgVBb
         KVpb1WLzTL/jSOO2STH7tA3X4WwkhJpKA5i99FoTa2Zt6wyM+OuPpnADsyiZwLRXrHdg
         6mvP/g1QHgwbJexJiYiEvCUWxEdl4A91VKS/AEg1bAjLbZdTzjrEe6Oax5RDeMeHqIw5
         mGMHrLULJhVPGiIVfgmcHQ/hHZZgLOg668pTJydU/UOjJtmrAgcj2D446x3O3+63QfoQ
         l03L+P/2KRgAhqrcEODLQ+kof1asuah90ZfGfRUXA6J9WxV/muLDI9pjmMPd9Xa3IZq8
         VcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU51iM0P2GShjkXTF3UWLXBUWLwH7fztoUtwDYsYrHH4S9kQAN0L0kaGy3ubX4kObcvFX2GEmdMqUu8Dw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3r7AVR9+ZkNHUnZHlQfaVTIQb3y0en6shQedDsF8Tlft2AMtz
	itl4t1ZeGqzrhUoPmGBYJ+ZK0JfuekAdzfwDJnzla1JgbVGQqaCDiEUhRscO/xRGt8FeoCl0W31
	jNjgL7EHmgitTNOpV5HYnDOGgvPAe47Ih+6ed6UqYBlWd40jMapton2a9N4WsbDQ3TA==
X-Gm-Gg: ASbGncv59HRjzhdZiOGzPOxpzGGYlWTgaW2tSBwtY4/6Sej6K7uhMzXhndGHBtKSSrF
	8iNOabdRu47t8vC9HwVoNXN8igT3YLzOtj+0P+z7OjFFfwhkmzINpZ7ZZ/zYox4Jjy9GXMWaDyy
	D38VbeAOOVqHeZYpzhlR8guplytthl+U0nBnK5U8KMYeLhOXHZuWc8+afy3K4YCmqkqqlFSIJa/
	brmYI0pmids5cdpNNSRVcBZbaJI/8VhFqPTdkSOdMsZLNK/G2JoBsQnmQBIAIc//GUK88NCWhSX
	M0PbaE99t8Bh1FOKND4FWbO/P453G1b/WmMmwwZ+HD3rUOsBi341J1HUMBq5J98GBA==
X-Received: by 2002:a05:600c:4fd4:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e1d988d12mr21304915e9.12.1758620596471;
        Tue, 23 Sep 2025 02:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJXoBtXvTd2Kf4hEtQgZIhNcJSjfgeo+qO9jd2CEytfhVkTcGIYGRMzua4UGM/hH+Xob6mIQ==
X-Received: by 2002:a05:600c:4fd4:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e1d988d12mr21304705e9.12.1758620596079;
        Tue, 23 Sep 2025 02:43:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-402188ef7b2sm5018824f8f.34.2025.09.23.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:43:15 -0700 (PDT)
Message-ID: <f5836a1d3400581a6352d36474be4cc72a802342.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 11:43:14 +0200
In-Reply-To: <87v7l9r225.fsf@yellow.woof>
References: <20250806120911.989365-1-namcao@linutronix.de>
	 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
	 <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
	 <87v7l9r225.fsf@yellow.woof>
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

On Tue, 2025-09-23 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Looks reasonable, can you work on the fix?
> > I see Steve is out for conferences so this won't be too urgent.
>=20
> The fix is in my previous email.

I confirm enabled_monitors works with your fix. Feel free to post a patch a=
nd
I'll battle test it and include it.

Thanks,
Gabriele

>=20
> I am guessing your email client is hiding the diff from you ;) (among
> wrapping quoted reply, but that's not too important).
>=20
> Nam


