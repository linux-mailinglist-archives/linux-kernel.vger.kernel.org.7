Return-Path: <linux-kernel+bounces-809861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0457B512E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C2E1B258A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674233148B5;
	Wed, 10 Sep 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or5Hcgov"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BC2D97BE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497389; cv=none; b=hbinf4LLanOu4P4mCBUKrZJalco4xEHjsrAly/c1mNM7lREo7ZQ+NClXxIEJTAhqHvyNIVPFV7Rr8vARnmX4BZu5dhncgFhXUPx1+tk8B5BNZrEQQWGlXMJUpHqut+oL0JEfVVor5up3i5nKYdaSxR1pzFIYlO9XA4zcla6lIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497389; c=relaxed/simple;
	bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wx1dwfFSujb7zZGUXjRI8MVGBy11ereSk3Cj5+ejwlw4dKEdLc4uUfCTDJsli2qhKNWGHja69xLGQXYYLUK5GTBxh5xtQ3U8ELCn20k0J1rWV+cO5hg8mj+zx/nqRyeQAjU4jx0+fi48H3ARPX6/Axm27Dz/JTcO/LCNFu0cJbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Or5Hcgov; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b04abcc1356so650842266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497386; x=1758102186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=Or5HcgovTKy/+IdRILIG/rLTDfpglBw4XR2hYP0fBewGlv++OuOajO7F5raparnW0q
         q9LaTzIcL8fPvtgCq0s8dAzWs6ZGkZ1a1vtXN2pYq2nbpy8A5pEG3qvrBbk0Z9MiXR/A
         2ZLd9t0UQKRvjJ7WTQLBAkNO+IWNfLu6aNaa1MJ68PU2X3iRM7++lEZOIMmzFWcN5aio
         1iYR0MsYR5ur5DjJC28BjUPMDCfpBlgmlX2pWxC9Ye6iO3ss4Z/YLbFr635UrJ1PN6MT
         MzpEJrKJtoknIrcWAaWFxFO/IoK8WkLMJOBwuISkZ3Uf8/ubfl3xeikHgyXO8chXlyzI
         /sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497386; x=1758102186;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8u6FaARRtSREzbYeC4zN0fjp2DwVky7Eafbhh1jrDCA=;
        b=u3v6zaZUd06gv+Ckj9vv6NH50GO+EF8OLnMZ9QQHJf81ZaNoIMFtWdo1Z02/9mMAJE
         tm5kCba/8EoeNLzzYxi+gXJMClx48USmRYXcbDSGOYUM4p9EGwMBcX80jWDdMgaHWijf
         VX8qL/rEDV1isy1p7Da1IDuV5L+k//6xLfKvLG+PAahqLQFbSW8qkiY5fsEt0a/9C4Uq
         N23AHfl/5jwkMqGYQtr2GNcQzYPf44CZyaFvbDaaa8CdNbDGKVroxyayxBuKjFgiBhAS
         0CzHpv5d/H8B8LQ01EoRIMht/3/TC7kNGn7V3xEC+xAFD/v6EdeTu8CjdjlP8yFD0Hkn
         90KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKb44/J/BKBxpbVbTvRwpAVhJLa0OgW54j8Zfw6ux9FemBiUNQ1AZnqLEx9poTyVoSvgOBrLtVvusBS3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChnatQzc/YuJ1SGER5KNritiTfw4OQX16on5spFbSfuP8XHXm
	Fv9tysOUbEr2Fpm5z+Ox+H65983NwN3yx33zglEYsmE0hgmSS6/H3Fqs6bun1LgGqtc=
X-Gm-Gg: ASbGncvMYfJEdRdPejxhEi8sfv00sbs6rYTo9yjy7UGkwAPqROBn+GKUgD4SunPZ8uS
	H6/sCne6uE3RInSDlc3UAniAy4SL1/9z62BESnorzHAzIcS/YM8S6uamvQ7G52XYo1AyndXwoIQ
	DVNVO90nwD3ezYTKfAt6G73uVf2nSznjS4iu/qaPKHyT49+818kUss+TeBdI8zD+oTjmPa0gGwi
	mFEwUsYqxbl5D799ZBiyVvpi6I1lE4KJatm2CAftUrn5wZsHW/725vjJP0aWztZzpxS94QbO8nw
	Zkz1RZHryUGwzgsPflBDE4879WX0EE+efj5T7ejNerayWURqm//wsOfV4FYyBoLrqglam8GTgdQ
	iZxIEnKOmzslpRb/c+hgTrIw=
X-Google-Smtp-Source: AGHT+IFWuLSyNubOEP+haT1kxcJlsnbQvIZV9vTCdS/TLhc04cY3/upnJwzgMXGylHLDI8GWpEssXw==
X-Received: by 2002:a17:907:7f93:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b04b145f591mr1268961666b.9.1757497386292;
        Wed, 10 Sep 2025 02:43:06 -0700 (PDT)
Received: from draig.lan ([185.126.160.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830bb83bsm136246666b.42.2025.09.10.02.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:43:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id BC8215F82D;
	Wed, 10 Sep 2025 10:43:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: <andriy.shevchenko@intel.com>,  <harald.mommer@oss.qualcomm.com>,
  <quic_msavaliy@quicinc.com>,  <broonie@kernel.org>,
  <virtio-dev@lists.linux.dev>,  <viresh.kumar@linaro.org>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <hdanton@sina.com>,  <qiang4.zhang@linux.intel.com>,
  <quic_ztu@quicinc.com>,  <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v9 2/3] virtio-spi: Add virtio-spi.h
In-Reply-To: <20250828093451.2401448-3-quic_haixcui@quicinc.com> (Haixu Cui's
	message of "Thu, 28 Aug 2025 17:34:50 +0800")
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
	<20250828093451.2401448-3-quic_haixcui@quicinc.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Wed, 10 Sep 2025 10:43:04 +0100
Message-ID: <87qzwe63tj.fsf@draig.linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haixu Cui <quic_haixcui@quicinc.com> writes:

> Add virtio-spi.h header for virtio SPI.
>
> Signed-off-by: Haixu Cui <quic_haixcui@quicinc.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

