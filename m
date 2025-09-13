Return-Path: <linux-kernel+bounces-815358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFF6B56338
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69ABE179B87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89CF25EF97;
	Sat, 13 Sep 2025 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCfEnNQT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3E19E97B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798586; cv=none; b=XfG+SLJ80jp2saMMmbRKR9ag0I1KNzV9P5TFpVsQ6RLypEsgSRF8KqpP6d+O+dOwVesGaPqJTAN+QuKdMRhSZ6+ST/7bQiD1JqDN6uqA/0sAi6+xFhabkuXAzWIt5+YsnyacTdzKr+y9RYPd40/fLjhIl6YRIXBgVx2nRYvjKBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798586; c=relaxed/simple;
	bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVo6Y55/uFXFUklC2lfj/roSZVJ0efnx5wI2T0mej82x2HlyfuvFF/DLTSFM9LeaMdhCmYx1dE8dxuGNQJOwJLJ5Kw7QvH/Etu1uupQr467lf9gUXNcJR1SOSJtlLtOtx1vr+0Ryu5L9KJ7L2FT02Ro4SGVBvoxXiBQFyno9kmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCfEnNQT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso24400675e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798583; x=1758403383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
        b=LCfEnNQTkDc3WZXvNt+khxghbuibFKNLjrncEpTucIfGJC033gS3YoVt5PE0zNZx/z
         vt1n64nrPQCdmNokuSaZchHywnumop+wglV2YeKDBY9kP2OMnoBMRh+wAB+xtOjroEPl
         gozt3JlGjm/YXhwmPOr+FlDTDhiRyLQCW9RY80TgpnDWqk4IzuqklIXl+WTHl9EqX1ow
         aND0IhBYyvvVzsGXIroeaDQ22aEDG/PmrCb8sBrLWo3Uynh7sd/tTaNRbisg48nwU7a7
         WXNOj8/G3SkFrI3tlzU/zZ73FhxUc+OxPvNErZwu7yihYqoeU4dZ8lBsDNuX4Nd/amLE
         0RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798583; x=1758403383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iywYQxRz9CS7up3Rb4XVNLQEC9bvPlsrkIVlIPpDzfw=;
        b=RXdaiMJToxA33NRaJn2+Q+focV9nvj2/5BYeoWZJ3xFvKUDOdejzndS10EH/4y8pBH
         H2PirV6aJyyy58eRUEVJqwfY+lM7XMvBxsAj5LDa4+xVbI5e061pMOmDOT6fxzxn67fX
         zAsDIXTi+S4uYGL73ObOyI9OuuVXTaJaflPknaJ2L0zTks/rcsRIyiiM/Js/sWgcc6Jy
         l2dZBg2bATBfH9+TbB3VpLQP9wRLX4tMi3Y7E1Bc+Rde3MhyhC8YTTX2pOqQr2/yo1tl
         3GxyWJ8HxvdzgUbVnlfE6ck/UTVaKUs+aQ2gRHcSnNsq72jUg9Ng9JneoCLEiuzAP6B9
         aF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv67JarbJ1GbAMGeIY4mjm4SFFsZKnakeISJgLizNaKOMYhj3Qpj/CP3ZkqZJX/tHxmUvhIBdjEI+DVws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZBZfG27NQQJMOx06pbFq0+kzX4HuH06xoF9qIRLsLVNcs6Hl
	rHP+/8ii+ni2vU5x8/L1pDQs8uIiItwYH294jesS1k0S8Bm/kB8dF2Sj
X-Gm-Gg: ASbGncsnOtZLWdgyLnE6xAq+3zMUR/Q4REULYv1nChcldjI1r2WunTdYLleOjcrmQvd
	DC/4oxqGKyGUPJXQLIkSFw1+rntY+kQJ4AAscWbeR9ObV2UFw7sdEe/XSn/mjaspdGbXNArunai
	rIxp+yDfpbGQQi6Fx7sKiXpqTovRN+crQ6DNK1x4RtjsKuLOW9rl65Dr5Ik6qJFEx+IBYzYhuXg
	X4V4yVwAv+OCV5DaLK+vpJJQX2xedjHFJ7JmSuIFKDCIvjkrwBUIDT3LP4V/VGK3W7XZh20dVaO
	xgU2DUj58uZM47Af6/ru9BpVMsThQj784aybAKM10/oQhvwJK0rzYGTLZIWgdFA62Ux/yHmq2HB
	VkYzlgYvalaV1E0FZEzIc2jxeC7GxSn1IiKhicFARFUO1QIpp
X-Google-Smtp-Source: AGHT+IEW20rf2hIhimdxJS1T6kk93raCiCsoiaFO2LWxY/a237S3KFMKKEA8B3zumhUKy7Hqe0S/gA==
X-Received: by 2002:a05:600c:605a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-45f211cb5c2mr51983385e9.1.1757798582965;
        Sat, 13 Sep 2025 14:23:02 -0700 (PDT)
Received: from radijator.localnet ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5c5dsm114475115e9.14.2025.09.13.14.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:23:02 -0700 (PDT)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <dujemihanovic32@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND 0/9] samsung,coreprimevelte DTS additions
Date: Sat, 13 Sep 2025 23:23:00 +0200
Message-ID: <12753058.O9o76ZdvQC@radijator>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Resent due to mail server issues with the initial send.

Regards,
--
Duje



