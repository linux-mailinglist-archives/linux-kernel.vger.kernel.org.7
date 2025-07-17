Return-Path: <linux-kernel+bounces-735809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EBB0941E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542FA17BED9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB1D204F93;
	Thu, 17 Jul 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Yl5g2Jxy"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3F1DF968
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777668; cv=none; b=j+bAqBEog+Ljgm7Npmo++mXesQn5FvMLf+bbkmzoLuU6c4Ott9IzOXwzf7sOHzLFkMxAy7c0VhKHdwB0zDL7EM/iuujwIMJLLSrAFbgvr/XtS92CKQOYGpTdjlfeATL+cb9pXBBl6Gc8zB7RHPOqW70IYHg9p/1l5Wuw9M2kPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777668; c=relaxed/simple;
	bh=oOsxMfNQT/qsQwwKg0YZL6vPa28xMbHs+2C6Y8zV2dw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=D8RzeF3eWQVB4lCP7hu9ApLoJNv2WK3zcVi0OWxwAR8vD/TgiGPWVRKHGqEqUT6Ukh13nyvkqCW6o1zWE11RbxRHNmaryuxDwErc6KylocuVUsaiRuT26HXhavWEn5yg5mb+D+AG+7g5BnwuT15CgE7E4+UwNEU/nsX21OAuaSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Yl5g2Jxy; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b27c1481bso944115b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752777664; x=1753382464; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOsxMfNQT/qsQwwKg0YZL6vPa28xMbHs+2C6Y8zV2dw=;
        b=Yl5g2Jxy6PDfkL6/DK0P+X78cH6PGX0yaEw8BqxQjdoqwrCR87XhhFZyww8GKAE+Ir
         I3nteefRMyIz6YMADle63WuNMPHA+/y4B+zLN7w18FTUraxfor9e6ivhHUPuOgFg67NB
         IXVJLESKxC1d5yHUl1X5BQyk0ramA2S/q3+5mMo2fucQ+h+I1MHEkKOAj2k4nrP1x/Xf
         /Nns0dDIOnP+7xXdKedXeh24dNlbUy4W3UpmIvq/xV/kUf+u+GgKz1PQGoRS82pseEHF
         Lv4ocx1UKUZbMNjhOQ8TSOmo6tuYUGf1G8ISXk4opalhTesSBT4DFcIUkqgMZRIQUWE1
         8/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752777664; x=1753382464;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOsxMfNQT/qsQwwKg0YZL6vPa28xMbHs+2C6Y8zV2dw=;
        b=lvAYq62k5YQlgvB4JxLw/g2WesPT1WMqcUk26EHpOP7q+he5OowD7YJyFj+bCHeDLn
         grno0uc+BXyXY3DDvIkDpDPmxsHK4YoEFmqZsawxW+iHmPCsMUexCtvbMXgPTKZrr4xz
         5CyfpKOkp+qpVozL5OzrS8LiAAd+Khml8oyIkSHbkQOymNXkehoiB9yNsKAOS2ZHD2ew
         ADD9UCKFey1XsDh76z1zjH2+UflGKS4u7LZt0PNtFXJ3WqN59kS/xP6yLQNd0aD9uFe6
         jWNcYu0wFBrfrm3qy1Itrxbtbybye0BXOs6/fdZ3YldsqjDk+u+LqRmPRsYqCVA/2JUb
         adRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ptFb9ZGUPyEABD5egU4PbdcofIZ/J/jDL+vZ00AQPXsgcHYnhJg/ImOx0YAkOKbOqwg0JK/FO1V62+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlD3AjwTyGFSZGkSDhtqW5Z1T+RF2ank7BV8SmJpTJd5U/tlWq
	oFzVe5OxFjp5S2ryS0lVL+rU1V5VJIx9wzwM1qyyeA2CAOoEmX/dEeAXFhTpaD8tRJ8=
X-Gm-Gg: ASbGncsryN5/Flow01KyO3nInC8Jc/CuoTayZwoTP/NjEjiZwJu5eC7b/r8rm0vVJtf
	aOopT8+Y0b+bJy4ApnA+GMmHLpdFBLVJBwcYq2a+aRa4ofjY1B9/ky2UV+RLbU5XaROR4sTFWT0
	oHENUHdXQAz9qb2+h9TV02cAqlO4dmWASIaJFkvkjBDn+krphGoGV2McZO8RYjhM2C0EEje+rrR
	Fgx8mW7yzzT4D3fkmj230yTEmO83hUbQXER5493r74I5ZVHzA+t0enOy+DexKbARBVi5lhSRCD7
	B4LcHylH7w8USem7ZQRxMJuqTAqSmgsyuPFxrfjCN+D854DaKjeoss39W3prEGoMkLrVJfnuBj9
	9oPqdGENq05QLivaLCaA=
X-Google-Smtp-Source: AGHT+IGJSiqVRqEqNHtQKOugHVGaBNjYMDOrySpKjtT1rTqdZu4A+8+NkiaILNEtNNDxpHEp7TmBLA==
X-Received: by 2002:a05:6a00:814:b0:748:f3b0:4db6 with SMTP id d2e1a72fcca58-756e99fafffmr13108030b3a.11.1752777664328;
        Thu, 17 Jul 2025 11:41:04 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06890sm16623945b3a.48.2025.07.17.11.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 11:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Jul 2025 12:41:02 -0600
Message-Id: <DBEJTQ0J7H88.5X7XSNC712Z1@brighamcampbell.com>
Subject: Re: [PATCH v3 0/4] drm: Fix bug in panel driver, update MIPI
 support macros
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Brigham Campbell" <me@brighamcampbell.com>, <dianders@chromium.org>,
 <tejasvipin76@gmail.com>, <diogo.ivo@tecnico.ulisboa.pt>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250717164053.284969-1-me@brighamcampbell.com>
In-Reply-To: <20250717164053.284969-1-me@brighamcampbell.com>

Woops. When I copied over the subject from the previous cover letter, I
accidentally overwrote v4 with v3. I'll issue a v5 if that's a problem.

My bad,
Brigham

