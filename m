Return-Path: <linux-kernel+bounces-872055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA1C0F330
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9432F563180
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403B1E5B7B;
	Mon, 27 Oct 2025 16:00:27 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A52475CF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580827; cv=none; b=hAt4foUfGq/Ps8v0JO6JWknt8tigB5T01jYegBO/8jEoUjIoQ1gzx7NV/VBKxuZBTlclKEhgHx8ybkEHaW+8K6hOGSdMCBAIkCLyFAZ6myQY6M1+tfrvaEUO5u1k/OU/OdoEbnyXIG8KqTbkG3Uh3VTHSKIifKsT0bKW/LqVnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580827; c=relaxed/simple;
	bh=TruC5Rz7hFXrB8am5aWkkTb/6jKbCZdXFPpjwUZibfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaWaPCvctxsdQxAvlMoc2uJ5HNSzvlMi5rUnzw0VHoPGWzTMU5OC7PWc8QSlhk/CIwnKZGGKYaEVRbgxomw+5YZg4oURp3PAtshuc4JFu+21eAkZHI0E44ag33BTVmcwA4An6c8bwnuVvoDT3ioyHJEaFakq2LAB+OSh1j+vxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-592f1988a2dso5453063e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580821; x=1762185621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YwhOXZKSbw/QgDI8R5plvx25chz++lg8tg98IFV5D8=;
        b=oY6GG4XGyD2M5xFQRkdSfBkoJIL0jhTc7J5cZUQECODYWjlL8DHZGI5XKVLFfBRqgF
         iI6c2X03kA+aD/4FO4/7sV5Aojsn9eKDXwv0SBVKoBlVK0TsE4Uv0iShfMAhWk1czZs2
         d+1t1guTSVGQ8ILxY8Zmisy1Z073rr6ubgNiPTOy48VcPoLs4d4vZm7FdhTlecVmmFdG
         44LPNwYzN3yXnl+GeqH1tUvabqeSA/WO3Ti8ysqJgNdFqlOImfRAK7awVVMlC7JhGoNz
         DJWqjz0zDhwJN8ecef/otV5vNEqOGxAtD9mhuavoasnbEOyptyG2+bwY0b2YGx/oQ/ZT
         c23w==
X-Forwarded-Encrypted: i=1; AJvYcCUyJyg8E90PM57dHCvKMv5daCOYMMfQtDvzvg8QDmJxWZZQPQTftt1dxW9CqJH8FGjx2u6ejtY4TZYi80s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoRewijGRhpVoIG2Lcl5lIE3JfEgJr3NBiY1j1NJsXhZkvmexm
	jhWS6MwTKbVx59QwfIERn6ULckbRygOCri9oln8v5QlvrhsARw82dzJksFfJnmir2u0=
X-Gm-Gg: ASbGncthwBuXmrlE/RlCki5ooinTK49yTGM0NjqjfJWVT2uayzm+PnjqBdNL6tHgVML
	HvIWIsgPLkO/IY/duaZJMrwMfylQAl2IkKaFC7t/QIqm+0ts6Qn8PQpUhReekiZz0L9Y8JpEXae
	FfAhStNpbpss6trE+JtXB5UA9Stnqv85oe7E/PkR9UXrsHFwva/aVYZvYWauQRruMwkcAsvluyD
	7ewba2JUdaJm73PxOVtTBwCg7Lr1V6NqKv8uWSW3mieb1DCShNaUFoSFMfv8VhJMqaSz77U+eu9
	5RvQQ5FgyFOJ/wzycrp9cTZvKaKmjZwPU+Dh+iV6OC0mRh3xdCXvyL+9cKxXIRUfQk/R3DC+eaF
	IGRi4wpOnRhUr4tNow6IDOic0oShjwE1tdQoiNOMLyPH2CVkgkXsYrM9Ivo7nqOR0GQBZLtFlhx
	+VedPkwe+JlMNg08P7frn2Ba0HQ4GDH1DnFCon4j+ukX8=
X-Google-Smtp-Source: AGHT+IEBwqqBg3FlY1bTl5bN0hgDtJS6l82OIAQP6iwUSUkCwm92NiY5p9baNmylwCflohy5sn9dow==
X-Received: by 2002:a05:6512:224e:b0:57e:575f:145d with SMTP id 2adb3069b0e04-592fc137487mr4119457e87.22.1761580820512;
        Mon, 27 Oct 2025 09:00:20 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-593097eb2d4sm763297e87.66.2025.10.27.09.00.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:00:19 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-378f010bf18so20738471fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:00:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNDgipw5sltUNZcpNcX6i1TXdmPQEAy6zfbg/ohoRKomoH8Y53QiXpqvrKisUgrasIm/j+9bFBCUL14TY=@vger.kernel.org
X-Received: by 2002:a2e:a7ca:0:b0:377:d151:c090 with SMTP id
 38308e7fff4ca-378e3e0adfdmr38098431fa.1.1761580819015; Mon, 27 Oct 2025
 09:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-8-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-8-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Oct 2025 00:00:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KEKPtg=WZw9su_DBc5JKsjjYV3DmpUD+LXGhX96sEfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkrUs29MfoNSjd071G9lNzBwjNkUIcpLZfwjGgRDO3VQYGwungCMVXDTOo
Message-ID: <CAGb2v65KEKPtg=WZw9su_DBc5JKsjjYV3DmpUD+LXGhX96sEfA@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/sun4i: Move blender config from layers to mixer
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> With upcoming DE33 support, layer management must be decoupled from
> other operations like blender configuration. There are two reasons:
> - DE33 will have separate driver for planes and thus it will be harder
>   to manage different register spaces

So if I understand correctly:

- the "layer" is from DMA up to CSC, which is the last stage before routing
- in DE30 and before, routing was limited to within one mixer
- in DE33 and onward, routing is global

> - Architecturaly it's better to split access by modules. Blender is now
>   exclusively managed by mixer.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

