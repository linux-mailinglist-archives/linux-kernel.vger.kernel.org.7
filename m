Return-Path: <linux-kernel+bounces-799425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B506BB42B76
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25391783E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2652E7622;
	Wed,  3 Sep 2025 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTtHJBcY"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA11514DC;
	Wed,  3 Sep 2025 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756933279; cv=none; b=BrH5xKV3rQkRrzckpB9Cdnr42sF9DICyyTnposB5hxBLpto5v65cPZVYvRsBIZf8rDn9DmxgJFymIaYIaUs/FLPnFv96DVLeWMJSHNZT40xTj4UCHm7BgKG2S+5hgvuI4sdzjlc59t8tx66VgRQrEx0/qedIczCn4+GWYS9avaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756933279; c=relaxed/simple;
	bh=cBrRzcoNHkzrUHBkxhAmRFmiTIEByRdJJkp89ORV764=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5vONMHJEjcZZp1MLTjiXdkMJk7gqTsRUn9KYMPeGK6oMoIyg4KNLozj3Nb87Z3rWlCOMF9ql6Z6/jvJUIT6h9fIZft0kcExyMfoLDmA7ATyr+cA2JBvu11dH9DLF8UF+d8DB+VtQXgrThXNEkIJmSMwmZLDawDLBmtirTqi0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTtHJBcY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772843b6057so322618b3a.3;
        Wed, 03 Sep 2025 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756933277; x=1757538077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t/ulgWiFwR6WnPcNdoSAtJQKq5PncNuo7vNG7WHcRgo=;
        b=LTtHJBcYUr7YGjnENrXeO0cg2atI5ylU/qvoliFf/vaGxynWYFKfS9qveztT5m0J5V
         tbZq8WyZ9LoTbVKV6+b9e/nnnKKJGrZWnlr1HFm4HjRclbcvXNoDSzaPmFxpQnUqC4/s
         VvUhVfPKNdjGmpAVKBwcWfRv6hie/jt4Yi+ebkW8kKIDYkUBxgjrpxHlGi7nrWaN8Pal
         v+M2TjeQixh/mBNesT1v6uvHlKo/FgZvmD5OElPL0sPXmvDGjMMBZp1H9GfUhqjkrP1H
         HmvEUzHTV3EQCvZj4rXKtj68dPBVd/PIGXyGfYs2iKsdfRa7JGCUTLztO/mM8pkzlR5M
         2DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756933277; x=1757538077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/ulgWiFwR6WnPcNdoSAtJQKq5PncNuo7vNG7WHcRgo=;
        b=bMh2D3gaxA14vdnNBA5yQBPccGr38pWDWmbmmacZoQfYsdM/wWoDVzxmxT6STW/kkr
         UYTPGSof9R+GNv1Ri/fDJof5QK8CyKT5Nxgbor0MT0EdzF2dX4o595A6xtHypg9tzX8K
         +9iNbr9154PSgGnf8gcQlUUK3+wXIlFapwCDJ+iPomhrf+JbMcsgSglGLuwS2uzlLZNk
         rmxe6uzIIuMdvGH0DUdmyMgs28EXTaymRU7vCMHkMLBmEqajsaDoBuAoDKNTTC/rGVBV
         3ku/leiYJILjG9/9VHfM8geIlYoT8J96Wut1HgjMGjt10T+x4DEqUMwFUtKgsJp8rF7E
         OQEw==
X-Forwarded-Encrypted: i=1; AJvYcCXjGrfOIVWpZmHRPOu7V1zwoYsJRW9HrURq5t3x9wtIzsa3BfznD6cRiR8ZcePIyR9LXWwLLoQCLHAO@vger.kernel.org, AJvYcCXmrhnn9Qo31Rz+GHQh6kPMYoTYRLS+lkfV8FJygrXnVASNQA18ld6ObvKtuptvM00LfdUtlolneJLqntic@vger.kernel.org
X-Gm-Message-State: AOJu0YwtPWfLHXqrVQRJuTJeZMNT/9cRwFTBFUh7s7sxX/OEVkPsHt17
	tJnvWuOGvBSVijBwmWyFfryHRYZ4TvGGIk3GuadcgzQkCX3hGkTFQEQA
X-Gm-Gg: ASbGnctZzCvwumpopmiv3HIFfwyyoahrffzMW8aw4+UvRfjDNlXby0B6smxbrzxrPoI
	/A4FTrSZkXYV1q6BhDtd5qPyhTR6UBHvbS0+xPHJB5w3ZQehfM8kQhgoM0vToeyNiSxrN2PiJBE
	OxIwH+NhwQaDLf5UtNbnAlipL5YneONjwAUF7iRbrSNmLMBz87Kpf3ktZSJEs1EoG90g7pEzaH7
	2c6PxOBJvWYwwrrWvUVQWEUMVI0nVY7ysqfXw4mt7S2xZ8xnwihTfXW6xKYWzLSN8Byks110t5K
	+SUf5FGfLSJdw+JpEUBovkqAWp0vzESJsFl1DEcZ0POis4Kz169eE5wQvpf8enl5cs1jOI3wo1W
	rhm6UaofteDT7jOqRU23ddzg/XffYRCBYOmtkL9ARoJc=
X-Google-Smtp-Source: AGHT+IFmpCYt7p1ydoAkbSRULtTV0VpiAIvlL44IcB4e4sl/UMWQQ2dm1zJl84YOPMOhIdmIlupGmA==
X-Received: by 2002:a05:6a20:5493:b0:243:78a:8273 with SMTP id adf61e73a8af0-243d6f8b258mr23472656637.57.1756933277061;
        Wed, 03 Sep 2025 14:01:17 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd366a909sm14914404a12.52.2025.09.03.14.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 14:01:16 -0700 (PDT)
Date: Wed, 3 Sep 2025 17:01:14 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
	mripard@kernel.org, neil.armstrong@linaro.org,
	andrzej.hajda@intel.com, jernej.skrabec@gmail.com, jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
	simona@ffwll.ch, tzimmermann@suse.de, knaerzche@gmail.com,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v7 1/2] drm/rockchip: inno-hdmi: Convert to drm bridge
Message-ID: <aLismmDJfusG0x0Z@yury>
References: <20250903110825.776807-1-andyshrk@163.com>
 <20250903110825.776807-2-andyshrk@163.com>
 <5255838.1BCLMh4Saa@phil>
 <4ox7yh3i47odinoaalzjz7d3gvx36bxbaspo6qfvvvl3jqhdiv@24ownjco3ud2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ox7yh3i47odinoaalzjz7d3gvx36bxbaspo6qfvvvl3jqhdiv@24ownjco3ud2>

On Wed, Sep 03, 2025 at 03:30:47PM +0300, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 01:59:51PM +0200, Heiko Stuebner wrote:
> > Hi Andy,
> > 
> > Am Mittwoch, 3. September 2025, 13:07:38 Mitteleuropäische Sommerzeit schrieb Andy Yan:
> > > From: Andy Yan <andy.yan@rock-chips.com>
> > > 
> > > Convert it to drm bridge driver, it will be convenient for us to
> > > migrate the connector part to the display driver later.
> > > 
> > > Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> > 
> > more like a general remark, this essentially conflicts with the
> > big hiword-cleanup [0] that was merged today, as the inno-hdmi driver
> > "lost" its separate HIWORD_UPDATE macro in favor a nicer generic one.
> > 
> > I'm not sure what the best way to proceed is, apart from waiting for
> > 6.18-rc1.
> 
> I'd say, the correct way to handle would have been to:
> - merge only FIELD_PREP_WM16 addition into bitmap-for-next using
>   immutable tag
> - merge the tag + all other patches into subsystem trees. Otherwise
>   that series can cause a lot of conflicts with all affected subsystems.
> 
> Yury, would it be possible to implement this plan instead of pulling
> everything through your tree?

Yeah, this is 100% technically correct way of moving things.

The problem is that driver maintainers are usually not quick taking
this type of changes. In my experience, if we merge #1 only, we'll
end up with just another flavor of HIWORD_UPDATE(), maybe adopted
by a couple of drivers.

This is exactly opposite to the original goal of the series: nice and
almost complete consolidation of scattered HIWORD_UPDATE() versions.

So far, there's the only conflict with the others, and Andy said he's
OK to hold his series.

I would prefer to have all those patches in bitmap-for-next for a while.
If there will be more conflicts, then yeah, I'll follow your route.
Otherwise, let's keep things as they are, and encourage developers to
test their patches against linux-next, as they normally should.

Thanks,
Yury

