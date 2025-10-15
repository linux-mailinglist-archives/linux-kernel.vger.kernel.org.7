Return-Path: <linux-kernel+bounces-854442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973EBBDE63D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D874811DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F193324B31;
	Wed, 15 Oct 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="kv9LPWaA"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BE3324B22
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760529873; cv=none; b=je7MZiBBEO74acVaIZh9/0dgWSGFN74WiqE5lTH9y8Sk2/aqxJDe3+OGMEryQ3+hLKqhgSrb68tFRLOccYOUc9kD3zuvCk+WWGtVX2RvG60aGeZInZ9f0j+v7pDrLHjoo23XdNnsU4MI5wifYTmVaTUPjx2mmOGabFFKJjb3pUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760529873; c=relaxed/simple;
	bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzaWZLPZ5QoQm4nE/PF8tQkCdtjvxpa691+WF0krrMXAQj/JeQhC1aywCMJdKa1y7LR+04DCHiBEMa0O4dEigDoLavY7qcuOf6zOdRmmj/ZyG9FlJlnsIe5c83WkbwsdGUm7Bs3QqQFsMTrkz4+Eu4PKzPsAurXyOmpr4d/txhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=kv9LPWaA; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88e68c0a7bfso99553985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1760529871; x=1761134671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
        b=kv9LPWaACrhzDP5vfRvqjBapHVNw4VWvPePvx0fBJXIly7iCZVYR7sBVR7mrKtuXhb
         D+NkMSd3HveDEfLth2lwAYtTKspKR0+8cW2+TlTAWzASlyfOc73zTYGNGs9sONvPfIJz
         MO9opReUZQPNjtyBJe0dCrn2ELS30qyN2tYcvFPDvIgun2v23owx4m6SjRYL8PUNgnPA
         Jxsriswu2/tuyra3IH5u9Yj6h40a8eTWWxL+xJ406gEONH8uzwrSN+kxOXfMXou4vC8y
         3frZSKARvrft6tTdjvSA/yi3Le2+nxiJTbfAXzCQOis6VpZo5Wzjyvg7mxQ4YUr6m/el
         5vZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760529871; x=1761134671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIkDzOp9lOkC64phyHj+bKX1qlxxtXvg/X9w367rNpc=;
        b=gHyaK5mgu8IqIJQNuOhCu+9ZuYwkxg3xP67UHlV3HkKli6nRmjN5ux6UeLQpCk5e9l
         zO3mcD3c59ZUxkXjt2zh+CRIKs2wkDzY2ZYsURdAKPrlISK8vnMUHe4CFyhsHZzVaMMB
         Z4M9knY4z3/YGRaG5bix2MNa8nD71Yu565o1MuV/jBlrgbKEcbJOmBvx0pdlk67Am1nU
         ruOSJ/WQyBSFQ7mDa2Hjch/tQkNIvBsbiZTWoK4OFAFAOlfCnP+I4b1tCtu5IDKAxMoU
         GoCcvU9XlS1QEk1a1GA12n/9DlZ8GOWG9REf4+xuF7wLGSRI7BGH4DfZoq6BRWbrPKnY
         SR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsFYHQYJ8AnmlmuwnSiHLBs3nZAgquDVwc3xNSYnsvs9ZFd9VagU0SrIT0ORXHwofN+7Ug2rrB8u8i/JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwouXFIsgQiA3oebUEATt1C4EcFNdXYMpoVzqtw4TVCXVhHTrd9
	NAjOyDslmkVRZStccyxuPFidbz2ARVtKibcCTJ5R7Wl/dyjEn8Jc0kuVAUA5Gf0U1Ei+filC+hS
	sV7QIxKMo6+rwSQ00AwMDxbmMXDm5F0Fl6jUhclu0ww==
X-Gm-Gg: ASbGnct7FyS0JJYsMlYUMsf7V2RqafDPBz5H1ZpYuxb0HGPqbeFImE0Yzq6tA3n8z64
	l4swmihMDqUWRnWOJM2jGV5jqtx4rBQ2jE4sXwDqHLEJMfGMZt/8yFpjnGEv86xgKWBWH+ddDOZ
	DMFN0oZUeoJiaa8rSQbEo26LDYHahCawBxf6d/+YmbqjA/wLV2+qUAX9bk6cwuVV57DWKfwcBJK
	oBWXktewiH4/3gze3cn9TmtenwTMBnarw==
X-Google-Smtp-Source: AGHT+IGsy4ghNUujV8ICs5xCd3l4JFRIFi1WBGAyKhaZaEA9CMFYjjgZCN0vS1WL/9stf48sqTR9sa0kj6mJ0PU2Rkg=
X-Received: by 2002:a05:620a:800b:b0:85b:5fdf:69ef with SMTP id
 af79cd13be357-883524cb7c1mr3776426285a.30.1760529870781; Wed, 15 Oct 2025
 05:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013060212.14583-1-vignesh.raman@collabora.com>
In-Reply-To: <20251013060212.14583-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 15 Oct 2025 13:04:18 +0100
X-Gm-Features: AS18NWBrg_BqO2tS4RN_x8d2btqMDE8us2R2sNEBkP2IYKjicDOGCIjh3Jp7IkM
Message-ID: <CAPj87rPDppYBRuQ99mh=VqrsSErGKcw-ZRY+zPuGrDj77G5k6Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: disable broken MR check in sanity job
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vignesh,

On Mon, 13 Oct 2025 at 07:02, Vignesh Raman <vignesh.raman@collabora.com> w=
rote:
> GitLab recently changed the required permissions for the
> are-developers-allowed-to-push-to-my-MR check:
> https://gitlab.freedesktop.org/freedesktop/ci-templates/-/issues/81
>
> Until that=E2=80=99s resolved, disable the check - it=E2=80=99s mostly ob=
solete anyway.
>
> Based on https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37782

Thanks for fixing this.

Reviewed-by: Daniel Stone <daniels@collabora.com>

Cheers,
Daniel

