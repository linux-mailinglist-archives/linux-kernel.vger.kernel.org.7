Return-Path: <linux-kernel+bounces-883152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D4FC2C814
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F121888F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA29231063B;
	Mon,  3 Nov 2025 14:56:32 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94F21D3F2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181792; cv=none; b=RGt3s5nJTWz6co56mn4+ayu2Tob6wGKQ6rmFChdDpNzX5FrEu5nD65MSPlmQWf6ZdF51WedB0a0v49nQTcRiHCzOSdY3TQWVpGlP4hX/9Qz+Epu2ljAtMTr0WeAUike1ji2P0wYHCXnyfWJlDdNQmUv76P9/bp271YhJhiTnLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181792; c=relaxed/simple;
	bh=s5HhCqdsQfAH71nlBy5jT8rmemhezTVFDs0Da9TumsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo+Yia87V+rSIRFpmti0BM+teHI4AJsX0qzUI4lF7/6PO2so8IPmDvQJSnMrPqAAqt1JmxdJFP16VFxaMMlGDq1gSE83pi+IlowsFCG4f8cInth1tvtmhQgp6Ws+MtyHSQWBtwYEtuUs7hhJ0vBy/gt8sy9dmYs17hgfI9TP2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57992ba129eso5523469e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762181788; x=1762786588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5HhCqdsQfAH71nlBy5jT8rmemhezTVFDs0Da9TumsU=;
        b=BDL5SL1YzZv/EpnMXsXZDYhY1QtSh2wg78N3Ss5YJhwi2V6o6CrPwIw1WSxjUej3RV
         0n6USz9WyyPavmupZ7HhnNgrrnUo/pyM9elCDz+t7HUK7XHPry37ISH6Jr69w9MzJohl
         JdhGOcA2Mwglx/8EVjtleRtwse24ruaU82nQeCKZ0DcOqZp2enZPdwm7Ml9uJ47OgPGn
         qIjjasr3Bgf4r8jrHIcV8wrA4th4Q1aENIa4UqUuOLPwQ8cLN+R9az5leSPn/XxuxN7D
         LqKR9h4wONE//Kn4yRnzTxIPFPOQxKeJIv2AfP4ZcHAdbK6/Z+fLn+odTQoAPK181e99
         PATg==
X-Forwarded-Encrypted: i=1; AJvYcCXB71MNTMfIwYVjIeSm7V0UK+mDm+7qGxIucEgMp1uHIDmz66tYkXOd8YL8K9G+zMtU5mOgJg9vlbh899s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSpsqwR9KcuU65Z0gH5Wz5bgxEvi8U+EgFCzF2lTUcHjkLfbA
	oGqsNLHLMQXRKxiyn/MH52vLgeQmp6x9dUvEOvIQ3XNhO2mYXucBm1KZ5uijcaWp
X-Gm-Gg: ASbGncvZn70aDpmHKXKBY10AuKQrWxZNS6HrE9qOvnFtakv+N11iSyQKyUXYrpg2C8l
	HqSmzrDcIImmwqwb3bRpFZnO/N47wuAXEVSu3rTipu5jF9EWSgZbikfPKTHYdoDxQgWBRVkSq5E
	8sJueUmHMhgbX+iXbhKpZrWefOfVqDz6Y9eEdJwh/4SHy6qSmdVxCkBbp4+Ue8DxpPJTdg+b8UA
	tFYdMDkDN65NTZNobO0IRIbEHdVnxYxXm9bRS+t61RHTvp7aI5gh9Ymr/9EgryPgE81XlN7/wAf
	wbdnRzHoazcCTEPKPb3Cd/aTstoT4QFHdEnrDwBosxsCwUbydWpq0N4e+aRcC4em3w3t6L5JY9p
	bkIjFTQe+dZ9h9Fmp/bBJW4N0cWMeqNfMlXTAS9opPIezFHCiDpNQFywBykTCKKOtqyMi3sqlSB
	LNBWZurIsOElVYdtOUPqAKALjX4jodRH9RfFQLLyDfKoU=
X-Google-Smtp-Source: AGHT+IH4uP1xr0CSNTmjS2+87Y4V04d+qISk9h2ej70hDt7sN18P5IpggbC9gf0U6LsT285I85QvVg==
X-Received: by 2002:a05:6512:4014:b0:594:2c64:54c9 with SMTP id 2adb3069b0e04-5942c64587dmr1218277e87.37.1762181787506;
        Mon, 03 Nov 2025 06:56:27 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc07fsm2982481e87.89.2025.11.03.06.56.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 06:56:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-376466f1280so57013341fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:56:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVx0VVFVMYqhvUYCcRNw8ryTUL9hx2Rjs8nerNUtlE+kOeu1B/WDYTqkQfmGYYhv/EYeVG2u4ZdGs4yW70=@vger.kernel.org
X-Received: by 2002:a2e:8317:0:b0:375:fa47:14a8 with SMTP id
 38308e7fff4ca-37a18dc644fmr33438281fa.31.1762181787126; Mon, 03 Nov 2025
 06:56:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-22-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-22-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 3 Nov 2025 22:56:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Sfk7WvEXNnRfKRehtyn-4KhPBER9tV0E2_pX4JxGC8g@mail.gmail.com>
X-Gm-Features: AWmQ_bmDRSdirXrFZY61Rit-O4eYxqlNFv0KMpQajaon1izsKkp3c6YIV8hGfRk
Message-ID: <CAGb2v64Sfk7WvEXNnRfKRehtyn-4KhPBER9tV0E2_pX4JxGC8g@mail.gmail.com>
Subject: Re: [PATCH 21/30] drm/sun4i: csc: use layer arg instead of mixer
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Layer will be more universal, due to DE33 support.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

