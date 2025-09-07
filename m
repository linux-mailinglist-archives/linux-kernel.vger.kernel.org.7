Return-Path: <linux-kernel+bounces-804530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6327AB478E4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E8F3BEE2F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 04:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FB1DB12E;
	Sun,  7 Sep 2025 04:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaYVfPm+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D43E15B135;
	Sun,  7 Sep 2025 04:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757219093; cv=none; b=RPNJJ8n1QZvGJM/rOERY8HWAxdc4ZYLB/EwIkxpMlumZbR9Elvyu8ON1suiXFoCFCaIspS5jaavaj+2krwxPZ0AqFfxrZi6vdJG4p1x16iHIHxuiKnMjxcL5hnJ3EXY/kFMT5sASPEhwa8VWYWlLogAFWlaFylnyfRxKojQD+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757219093; c=relaxed/simple;
	bh=0N3eVpXC/D+64gQoRgXv87xuIkiqUUOVzPZ3VCpIvuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Al6/+CctuPZirmGgo6VBhub0qgM9oQus590XDdnGE4VxoTQE2omeRdSs+uZ/A6vbyv2xcpjRbTYnfpPAh+rvkZc2r6+uyGAYh+TNiLYXuyxAprqn6VMgeDJ5hgfApKnnCYajvp1Kiog3OUfrMvspk919cjwBsI/D2nFVYGTkXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaYVfPm+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so4186115a12.0;
        Sat, 06 Sep 2025 21:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757219090; x=1757823890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0s9c0ZHAHeIpOChkyK+9eSA8/gCyG1mdkJBEoUW9B2w=;
        b=DaYVfPm+D+/Q+8x43QR0bKiEOiQB47sZM9Ncy0bljmLRpjbw2QocZnJlFDnsxER24/
         gvKoS0TYqVeT7DlIkc72cN+K2XknaoKEPmnTApHk6xvmgAJ/Aaqbs8aTYSO/vLZ88wc5
         ttUvDFDHHnnHd2M/U7QJsUtWDhBq3FVhwiR6a4TqE/z5BUxR+F5jt3SGpVW/P9rJwWqc
         1mXS2p4+wj3wckj62u6lw8a8ymEk05A63ONh6mvH14S6uUXut+qPumKMriZt8/Dff5E2
         OMLynU7l4v6FQnxFGtyiWGa98NaqfcVkG/h6jUhzFdyMr7wZ83wxFK6ASgef5Jmy7V+V
         A/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757219090; x=1757823890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0s9c0ZHAHeIpOChkyK+9eSA8/gCyG1mdkJBEoUW9B2w=;
        b=XxvXlhAU/RhuyaFQpqdfODTkfidxdgkMamLIJJpqVDHlgX8fXlF/KbtcmzsdPFrAxu
         ESD0OWKhIG4yszIVJDXsRyA/se7X+RUAAqa6RYI5X/f0G4lnLfVircS3mF1WUZniW8ic
         S7xTPe1IVpUFicPACDikK0E84OvivNII3zcbSDzxa9E1kboA++i7KIHQj1GaGyH4fNzX
         Tw1hL7Wh6lIiLfg4wvNFwXbBf8WmMjS7GaT72y1ILb7FVd152loDHzE7UnYOKEi+tWA7
         g7RzmhmGfqRuQnPqwH8FsDECFG8KmmeFLclXlhPnLdx5VsBlR4A7VPpxPoe4Vg7DYGrD
         zX+g==
X-Forwarded-Encrypted: i=1; AJvYcCUSRHLGnNezAPhBfPI9h0QQNcpXo0lusrSc2UZvwZUAhwyot4owLK3NKn3b+w/NfZ96Ln08CZyP2174kTU=@vger.kernel.org, AJvYcCVdRYbDQYaynYB1ygZa9BoqX77rs98BUvmZgUpBsPqqqaBH1XeXBYMFYKGNhmmaYIw53mP8ImBenGPEL2wL@vger.kernel.org, AJvYcCX/jpHHao6o9QbUjXHup8mEmjTRqAeE8/y9Sk68v8g7DjEIkvst1P6A6w49uQMbETBZMWwzLBP99BUA@vger.kernel.org, AJvYcCXiP3LI7iSI0fuCNGTyLMoeJsaiBzl/kifOkS+rIJctlaM082e1Ssfz880be6YZdVUGD9GjjFFSUasz@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfLZpYRQfNgaKN2MR8bw7Trg6HyYF4Lwx/vTzURC9GTYvIYhl
	hYI9IEFz2iR3qfZIxhDGc3tkn8lgCLbO37G1xIE19wehVQQI4PiCToq6s29YiJZ+4xoc51MJ+GE
	ECbnTFWcvVVCyvHx9dkQhA3KRDFmYjg==
X-Gm-Gg: ASbGnctvulmbS9QWNgUuso1TjffFhrixD/CY9qx/iPoLLYd4wxJ0lBAClcJp3G1Cjjq
	dpralwlKOsSjBb/vgmT3XKrxj+y9YtXUe24kKELZhfFzgFcEZeQVUJj1T5nNNxO2Sa3gKcXTjAp
	deTpncLMhuam05yQEkV0Nx0PicfLLxBM59gJObq629438JCgWHATOaT1znVp+ziumSMlbb5tp+H
	MlDlh6AAjUcM6B86Q==
X-Google-Smtp-Source: AGHT+IGHfzcKiP9Te6PV3++IHvHUNAnAgu1e+fJM2ndSNvGKC0p8DoYdOnCCeRjEh31MMs7uRSn5elSnp8Bv187xwik=
X-Received: by 2002:a05:6402:5189:b0:618:afa:70f7 with SMTP id
 4fb4d7f45d1cf-623778cd7d6mr3269218a12.12.1757219090367; Sat, 06 Sep 2025
 21:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <20250904-hwmon-tps23861-add-class-restrictions-v3-1-b4e33e6d066c@gmail.com>
 <20250905-deft-porcelain-teal-a3bdbf@kuoka> <CAAcybutsMdXmqrA6kG9L5OTP9ZPyLzYrXTGUGLAkWs5+MH9ifA@mail.gmail.com>
 <9bd7beeb-0c11-4502-9d45-c85a0744ec82@kernel.org>
In-Reply-To: <9bd7beeb-0c11-4502-9d45-c85a0744ec82@kernel.org>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Sat, 6 Sep 2025 21:24:14 -0700
X-Gm-Features: AS18NWDyPgLCv7A7pvEren2ZJOSldFGXKh0s7fPVFLju_aNfFwxB2N-5d-Af1ro
Message-ID: <CAAcybusLMg+jCY5esvLgwkyRCu2Ma5Ph2+QFJsuCvTqJu0UssQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: update TI TPS23861 with
 per-port schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 12:19=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> On 05/09/2025 19:22, Gregory Fuchedgi wrote:
> > On Fri, Sep 5, 2025 at 1:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
.org> wrote:
> >> On Thu, Sep 04, 2025 at 10:33:44AM -0700, Gregory Fuchedgi wrote:
> >> What's the meaning of values? There are no other generic properties li=
ke
>
> Where is context here? To which part was I replying / commenting on?
>
> You are not making the process easy. I receive a lot of emails and have
> no clue what this refers to.
You were asking about meaning of ti,class property values,
commenting on this piece:
> +      ti,class:
> +        description: The maximum power class a port should accept.

