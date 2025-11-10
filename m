Return-Path: <linux-kernel+bounces-893962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1EC48E97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B39C4F8453
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8BC32AAD9;
	Mon, 10 Nov 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FNVlyJ1F"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FA21CFF6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762801567; cv=none; b=MGh1iBzpWOPxMnc3yQrwllBAkqpm9x8uv2N2GeP+YH/XcJ9f34JXjI+0+1eU/ZmK3YapmAIc8gxt5d/0xTHCN6Nu81rtKFDSFMgkw1f7mJm2gXXtO+Z+qUAQygQL606T3LYcd9GBOca+wGAFCeiCzUIW0I3g8SDXbgdYbsriCtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762801567; c=relaxed/simple;
	bh=CyW/t0jS8/xtCGVfRnRxA88iS/kNa3JHC6SPci4mWhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWAh8bc147nM9eyIE00RkoF4e6+M3JR0aWvg6pcD71gekZDnaD31ULwoGzHsbRt3sex/ONCdOiEzZyiuZ9SDcM1cUQQkBB3MBv695XKW0gRAHhTefC+arvuROBQu9+CzX8HY0k38WbRCb5qjmsZBIakaNH9COXq2fQLYzjqWZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FNVlyJ1F; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7277324054so500515666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762801564; x=1763406364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yC9h9KgevFORynm2Mt501XSQK9XREZd59bnsTtrcIw=;
        b=FNVlyJ1FQK13RcC5/cTXvsGqQf/eISQQXE662Qubw8dLCN1cqeRkk4FyubsQv3E3/d
         SJ8O0qqXejuej/fDFhxtI838Xz8YbOjPaCtA4p1nGoMXhJeqSuaLdjUVp7i0K1Z7t2ZO
         YyvuCJIHY0U6Xq7n09mZ4SZkMGIVf0vIcsbho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762801564; x=1763406364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yC9h9KgevFORynm2Mt501XSQK9XREZd59bnsTtrcIw=;
        b=Ty0h6Sq1xSNq3bFnWTb0dRQRtBlHUxIoG9DfNXGa8eBhHEr8x2bXaOf4NTb5el4uzQ
         nhNw1K3EWnnOJMZL2dXdqidaHqUV3xFCufAymYWbh97nBVgC5vFyTzwLp0NidfR0ymJf
         nDF6A0Uz70uOE1qImAHdkYbg0PCKuSA47SdSD9/gpGhlvtGdQ83tp17+zECcRmNMSqva
         KHiyWN70U/QPlCvQZuj4D3HVv/ukbLU26FX7dsqO+BdbABcAHymtHiopLt/CefGWU9mk
         yJPw/5fypuOIKHya+BMzfyKjnz8gOPNw5QkaZkTuPKohAsCaUBVQ54cDXSXPGI9OcEEc
         vFHg==
X-Forwarded-Encrypted: i=1; AJvYcCXEgVG3aCw9owPrtvOQcEVgSuDIUXmU2bLQBDNEzolSjtztxGxUAnQlb+Be7OpYxpdAUC3sFOrpeQdazf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFna+HdQuY9T9eQvpNpcXM/KnHPEFZg6stMH/N5HSYLJ8bBTm6
	iaNCeMMJUWqd6fMOzxE47RfS13CgOlnt34+6Xt9FGHJk68CkWFMNUknJtjdYz1P1teQmR91K1fc
	xs/jUp0c=
X-Gm-Gg: ASbGnctJWMH3gCLDtBxAWJ7/SAiAhsqqo+ZPyBxRVTL/C+iyAJ2myLyzIUCRv3EnG4w
	9lWY7PKwDdnYtAnmNWjz3Bd50jkHvZw43v33DoFTTkcvm+ryRrrSxwOwoRaYjBkJuCozunkVByV
	RIyPymgAGPhWvMzzcEfu41jvehZCW+oLWZO5L39R8S3T6VDGDBboKuzPvtZS0o+OBOyogw8oyPi
	0ThsjHxHv7HRmC+tyESDwoI4zvYjk0pvnK+QiKDJPN/XP/eVxJA8S4BtnAk8xgq8q9gkjDTewKO
	vkGd0Oj8+tTwFec4j2lNfYsaDYRaN+qt9v0u4vj4drQhlMkWPwwet9nC04abxzPpjUF3P64L2rM
	20yO/DtTxScPLwxTRozmchDGEPIC6n8QD2h4e7TZyN+ekUe4Y1cuyi/OuX/99yGGhbixQwNGPeU
	u4tPjYUVOAyR6FPEpIq+PlMayDRQoFHOOYgMxHtmkzYW5EGPj7ZIm1PKu3fYc5
X-Google-Smtp-Source: AGHT+IE6EYotoCAjekGoumWb1ua1dGJyZijzBU8rOJMBnV1POMqwk3D/hPCEWoX4hMXnWhTCRCxP4A==
X-Received: by 2002:a17:907:7fa0:b0:b72:91bc:9b35 with SMTP id a640c23a62f3a-b72e05215f5mr922767766b.39.1762801563647;
        Mon, 10 Nov 2025 11:06:03 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbd1ecfsm1132684166b.10.2025.11.10.11.06.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 11:06:02 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so4973272a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:06:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTaNc/fdstUKNpUu4sRQToOyKWz8RDb5bjOrvldmEemtDp+sOdCAZVrCPtQEk56jBsEznD3ru0cDPY5To=@vger.kernel.org
X-Received: by 2002:a05:6402:4405:b0:63c:690d:6a46 with SMTP id
 4fb4d7f45d1cf-6415dc17adbmr8488286a12.13.1762801561491; Mon, 10 Nov 2025
 11:06:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz> <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com> <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
 <aRIxYkjX7EzalSoI@kernel.org>
In-Reply-To: <aRIxYkjX7EzalSoI@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Nov 2025 11:05:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
X-Gm-Features: AWmQ_blqIHgBQQDHSwmkxkjAcHIrd3aWWcWyso6SGQ5JuQQ_nZmYCnfiBeXmcbA
Message-ID: <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for tool-generated content
To: Mike Rapoport <rppt@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Christian Brauner <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>, 
	"ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Nov 2025 at 10:39, Mike Rapoport <rppt@kernel.org> wrote:
>
> The novelty here is that AI does not only transform the code, it can
> generate it from scratch en masse.

And why would that make any difference to the basic rules for us?

  "Plus =C3=A7a change, plus c'est la m=C3=AAme chose"

It's a change in degree, not in any fundamentals.

                Linus

