Return-Path: <linux-kernel+bounces-872304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B5C0FDE1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DF504E97C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B192195FE8;
	Mon, 27 Oct 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGX2uF5d"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEA3101DF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588717; cv=none; b=mHmoNneQdWUsN+/sZ6AJAFo/OoYHvcrJdoRdj3oCgc5k5weTCz/QE7ugsGJwhqZc88DZzWdx6Zy2WIXYo+cc0iW0jVw+RtIsO/f63Gm/jmIF9AzQab3EdLsLMNzgyzrv1xmmSZaZiqeQpSRiY7PFy2Ktm8K945QDtz8wEKDglxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588717; c=relaxed/simple;
	bh=0K4nXT5/Js7e6nb85QjbFOWa38zA+AS+tQP3Aiw5h+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlqD0DMYSsyqh8nH3OnlJxK/Z/e0zWnVdnP8QOo08XvbNgTPj5XiPiv7szpxN3GyWLbCUOgHJgSCmgkLoZclr28dTYZS0a1sgs6stYZKwqmO29TL2iGA0KZnNMVVf+y44scv3XTaahzxkENDxnnWEJceTOp+EozgrpXuvQ5dp30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGX2uF5d; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so50134365e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588714; x=1762193514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/tr4wNuP/viUV2bLwDGJ/MFnyH+q9BQY2mO1mUn+Lc=;
        b=FGX2uF5dgjoCBzO2V8QzR5tHbSMFjqtBjypzh8aNg9Fd8CxIr3x/sfixcphY8KDQzY
         XUUR0KaAETnhe2Ih6731OIiUo1StqKcbhqB4zeiKyPp1PtBGd4Twf27ukGksnnrag1SG
         wlGMju8F42a6yo7u6DMo2kiIpMESwQ8NdcPwSC65zjBGTA7Dbugo/UGE52AA8CwJDiyO
         YtxikUOdgsHnFmB6Q0vNb0X8+0/jgMdVAW6o4skGiGV9T+KQRMDZxgt6HTl6Hrn6IWwl
         /qM9bVWaBTyG1LZKzy7LkyyaZlLRurWeP/JEfWwESqa4HZsdBjcvezps4a3Fb0x9pUQu
         g7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588714; x=1762193514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/tr4wNuP/viUV2bLwDGJ/MFnyH+q9BQY2mO1mUn+Lc=;
        b=t/45zFn2GUj29jim8kNMTqe4T5/fouxAJVeHa3eCjXZESVW3wLaZX+uOEgNO8LohSm
         JYe7JOKkjJ9nMlSsTYQzJyKUMRpCjbW334MHIR3ckOideO+EuI+oVbAGxcMO6OMU51rF
         Jce3bt7l6Lqslub53MDpQh75E0oxHIWaRpB4xKN/WfaK8DFnJ6P4LRotVGWD+0x8d/Ut
         ZXtQEnQz1qtChluD/LDjdD+YEREfKBK+d/zZ7fZyN5dCh2hlFtmV8UBDPD0IyF0z5P2/
         28Z6s2PXgjgPwJlrgUiogvKzlWefqexfBZN0il7ghZlukY525AVha1f++kPLoshHEuZ3
         HsqA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUE/SBXcEVbj87/8K6kUB0zyLw6SNk4Bc+SEULKNagp1TUO8/JYXOGr0Szcz0ktb0RJDsXh2lbMoQbzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3ESFUTGN0GEG2J9Q2fPcUjzS9i9aWyq4sR3kGRtpR9CicGOO
	BRbv4A7HaqfFOdADtca5sIfEkEW7q64skVoR70dzUYgaSLYuGYCEvXr8
X-Gm-Gg: ASbGnctaWh1hwvuITed04y1pzGLi7QdhANO+yMMa6PfaiwmkLenfttopXDg0W3B7a8t
	0qCIXeDsM+Psnzp+e94U9KTNrD3KiSnMZFeYJpJUB36MODLeJtmfFwYe5P5DbPRL/f3Ijd6eQKW
	Xmb2+fabvF3SYUf/6f6/KAtu4deh5HBZOJcxjBB/jdYZcJkj2ZuT7QKBaHxdtJw5s8maoLg8XX9
	+tiFzEmseYaWXSM6RvYeOuDFizoTDr2jErc8/8PSrudpGrJkaP0/FrDjIb2LPN7EK4MA+UVdz5r
	xV/RJksZGErQ+TPcd5y/QqJmKPRbXVe5J0bxp/EziMBA/7xcj3EiNw4u/QcqpMBLU2bNnL60LLM
	18oDpU22jD0Dvn0skqKpeVd033Vw2T/i6QJqQ3Qyaym9Oiqw2/q7vE0mEKm0dE68Osl5CfpFAmF
	FmuXb4GuQlMjgqO1z4dPId1GMErjADJKxh9fRniKHOFvkCyuzzGKNZQJOOagVQC8yZrsnB
X-Google-Smtp-Source: AGHT+IGXaCcfOwLIrQj9yH9WMbrO4UAf1AZg1ch/afDpC4pXgTmkjf1NdqvThLXtmMqqXSWGbWSmXg==
X-Received: by 2002:a05:600c:4446:b0:46e:4a30:2b0f with SMTP id 5b1f17b1804b1-47717e6ab4bmr5964995e9.29.1761588713974;
        Mon, 27 Oct 2025 11:11:53 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952da645sm14913054f8f.30.2025.10.27.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:11:53 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: wens@csie.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/30] drm/sun4i: Move blender config from layers to mixer
Date: Mon, 27 Oct 2025 19:11:52 +0100
Message-ID: <3382705.44csPzL39Z@jernej-laptop>
In-Reply-To:
 <CAGb2v65KEKPtg=WZw9su_DBc5JKsjjYV3DmpUD+LXGhX96sEfA@mail.gmail.com>
References:
 <20251012192330.6903-1-jernej.skrabec@gmail.com>
 <20251012192330.6903-8-jernej.skrabec@gmail.com>
 <CAGb2v65KEKPtg=WZw9su_DBc5JKsjjYV3DmpUD+LXGhX96sEfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 27. oktober 2025 ob 17:00:05 Srednjeevropski standardni =C4=
=8Das je Chen-Yu Tsai napisal(a):
> On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gm=
ail.com> wrote:
> >
> > With upcoming DE33 support, layer management must be decoupled from
> > other operations like blender configuration. There are two reasons:
> > - DE33 will have separate driver for planes and thus it will be harder
> >   to manage different register spaces
>=20
> So if I understand correctly:
>=20
> - the "layer" is from DMA up to CSC, which is the last stage before routi=
ng
> - in DE30 and before, routing was limited to within one mixer
> - in DE33 and onward, routing is global

If you mean routing layers, then yes.

=46or example, you have pool of 4 UI planes and 3 VI planes. You can assign=
 them
in any combination to both mixers. Later you have additional Z-pos routing =
too
within mixer.

>=20
> > - Architecturaly it's better to split access by modules. Blender is now
> >   exclusively managed by mixer.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
>=20

Thanks.

Best regards,
Jernej



