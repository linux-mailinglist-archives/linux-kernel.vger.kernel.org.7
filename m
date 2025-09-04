Return-Path: <linux-kernel+bounces-801592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA1B44758
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7294717C276
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FB283130;
	Thu,  4 Sep 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyHqr5hq"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFA28152B;
	Thu,  4 Sep 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757017895; cv=none; b=IzS6Ng70F87YCGfn7f0xXnQ6Mtudye4L2gychBIK7WMEk1ouShZVwWc80CWgCeYRg2BQMRIESsvDpjK65mjKciSWRqJrCnQU9ZYKMNXZ5y4g8c9Oktmk4CJyMLxM8QU/KyXm9zJ5HDUPM3Uwg3WXdiWykj9nNenvRR9TfPo3NCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757017895; c=relaxed/simple;
	bh=5DIduYK1kLwJqhXjz4cNAQ6NB00dUFKopSsUktBL01c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0HVOrzxdLP8kDlKgWHZpDo1WXruajeKpmwAr2djCRLd84XRDQOusfJzQuuvudEC9VdD0d6VuE2CTPyJZSLs/niWSCsaTfxKcePN1XPrYFUev0YnFGKdw6a/fFk/3PrJPo8Ieha0oS9cy4TYa515uzh5cHqCBFFGl0xgdDwqI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyHqr5hq; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-724974fc5f8so13894287b3.3;
        Thu, 04 Sep 2025 13:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757017893; x=1757622693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G44qT3ppm0NrZKxqg/zbbhuYOayOg+q8MSz2CLb5bks=;
        b=YyHqr5hq2RPEOEWcVwOLuJAuR8mRc+x5LN7/DQQzc/9/cXq+YcPYhWk+e1ABApbGiN
         UOECbLNK9BzGOcRRinaqC9D3idOL/JKmI4v8y+uPv030hhSlevGOPYegKiJUDGJs3oVx
         HhotbtbMpiE8wKGH59rIox0L5mPjK3Trd+JyuUlK6OuVZe7GWJqHWPvAQ1IbqXK0F/uh
         CBwKDCIqE0IKwsikZX/IITsltTDfUWkP+Ilgh7vdWCa+EOYJVjsjOVbAWrtAy2ErjKCJ
         ZZZ+e1SDvkLwA3Cmr7MXK+G4gRmCZTr2UpOusJSMcXqodxLJ1095cdoLETZPQGMP/QaU
         R+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757017893; x=1757622693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G44qT3ppm0NrZKxqg/zbbhuYOayOg+q8MSz2CLb5bks=;
        b=VFsqRF3eq+CJszVEZcYoPaXdKVSFW5lGUSQZBLTktmEdLBixDdxd+kDYA1crCVEH44
         yccY2fq7MSREmr/JQvU9VrTm6GQkaZDW/H0rrwo4GdPennwNT/HgFjoX5zCYeMLeCzQI
         JLgrRTqTWydLMpzm0NdNKCX/KDMNHufMh1VwM89UKiXVqAY71xtZec1/m1JgBIVTDML+
         5TIBN3F2Le1psMJJ3x3NEVQ3rqtKiAVE5UNMfeN4O9XbPhuuK0FNHhhOkrXKkH9Kz/3Q
         F54jALbBfypG4KTlxn3EyVhjVdNW2vB/WQV7VvWbnCJklOtq78m8gs0xiqoUV9jxuLME
         7XCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWToi7ZR7C3nPIwL8x7qkOfU5O4I/sBn9NqEvz59dbNlnxAXERfveR4lS61b0j7350HVPLhMwg6nIm5ZXOw@vger.kernel.org, AJvYcCXPnsJlZXBDa+HiVXfdabj0+ooarcqxmlN6ScKtBUfy/yalHWKLnuKQ+aH5fgwj1y6L4PuVpyoEBrL6@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWRh4hlR9R9Ed8PDZ3Q56srhjgZlUVcsvk6L2fB48h3nqcBUY
	CZcvB3D5lvbBXFntXTdu/DO3uwQ99EY3GHo96fAvuoJk41pEmMMVf91gmJzzHrZ2KrOcrJFBDUn
	CAWi799P4vYO0TSDKVgBLt4Zo+W3OQLE=
X-Gm-Gg: ASbGnctL2+Lz8D9hkDBRkXFsbOm6UGXKRxvvR1vuGKXr/GR0rjINqZFi2l7ZZ9ALi+5
	aJgBVLFVUiPB4m/JzH+TR3ROSSh8XoCzDA0JuPVYMn5t5gEEykb6JnW1h9dlpMMp4lasDlXljby
	PVQ+JzkhrMGyB/mP8LfXspPHr95IBFBvEOp9dC124ka1tDu7Eu0JpC/h3wxQh+MBhsUYK55GiKy
	W3zf2ZLt4416kxxEzYu6WKeBvZQoQrBXeBmcmfKvX28SnhYm2hQxh3P5DjMVYVSyZ+6UFea
X-Google-Smtp-Source: AGHT+IFZZhEHQ2i0PMUPdNUhuJd8vApgTrRB6dKWPtsXXKNyP2QHk/29i5uL4JCCIaB/197BciHOQ0zwuy7aQHiDCkg=
X-Received: by 2002:a05:690c:6803:b0:720:73:1a11 with SMTP id
 00721157ae682-722764fe1a4mr194168877b3.34.1757017892676; Thu, 04 Sep 2025
 13:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903225504.542268-1-olvaffe@gmail.com> <20250903225504.542268-2-olvaffe@gmail.com>
 <20250904-practical-dazzling-quail-f1bebb@kuoka>
In-Reply-To: <20250904-practical-dazzling-quail-f1bebb@kuoka>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 4 Sep 2025 13:31:21 -0700
X-Gm-Features: Ac12FXyq4YSAlCgSb1X4fgGqu2j04uBunN9ulHXu5oWCguf8BsghjVTucyWzm4M
Message-ID: <CAPaKu7TDQxJZW0b8hR7S=tAX7G+S2oGTeB5h0+2Qp1joqLPo2g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 2:30=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Wed, Sep 03, 2025 at 03:55:03PM -0700, Chia-I Wu wrote:
> > MediaTek MT8196 has Mali-G925-Immortalis, which can be supported by
> > panthor.
>
> What is panthor? Please describe here hardware or provide some
> explanations of not-that-known hardware names (if panthos is that).
Panthor is the DRM panthor driver (drivers/gpu/drm/panthor).  It
gained support for Mali-G925-Immortalis a few weeks ago.

>
> Best regards,
> Krzysztof
>

