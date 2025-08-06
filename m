Return-Path: <linux-kernel+bounces-757311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBEB1C0AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D354624698
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD119004E;
	Wed,  6 Aug 2025 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FP7ljyqD"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4E1D63F7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463082; cv=none; b=uz2SUzoORNNU1ykjZcUL0eetSVDFNjCQvy3z3TFCEOkp5cZaEnfjuGjuKaUaIyQSrii/lY1qOMovwiiZU9UC1logjSmxLC+Ja7LA4/Gz5d1Cipr0aLc1TYgf4XIQM5z3Q964G0HeOV1n8w9FvQgxkn1TbJbnr8lnhIX3HDaeaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463082; c=relaxed/simple;
	bh=/ZbQ8govFSIUs2bOQIpdvVW2jnxoxMQHhP5MEZyw3/Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B2B7qkggIXXzutx2XP7EtuLT9OMo6UaFG+nMS27OhV5q8uvmh2c631CPli1XvSc4APjmAK3uUngH4xZtcPcyd7OLS4N0RZeIWhiQkqd6FnBSeZVfouitfHROKeP7GlkG6v0rOWu2uznWdEvNHf3RsavAoZIg2C5ooHFvAjGwbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FP7ljyqD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5787168f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754463077; x=1755067877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3ZtOO3KoPZ/I7NSmve3I6N3iSKvHF5Yby7yuHTTKwU=;
        b=FP7ljyqDaffVTZ+Ofp/nsW+5kCNZFkn9Menxb1D1ulgO5opfeNJnplNz7YlCg8BvIM
         E6h/FFXaL2DdQZvNmylv3Hs9jYW4aRzKnyyyc3bh2F/sz1OcpGbP/wGDX9DRLJyBhPqZ
         ZE2u/KDCAX2SSD+V+yoE0DeCoY64Bk6pL1Dsd64N3/TaC1bLSGmRpdJFUCbJR651XinX
         LbFhdRr/NUgVH5IpsepFPLNr0UnCiTrzLmOCXmcZBM7E9hXOPq8AfX3y21cSXVY5LGJF
         z9wMvPc1UauhKAS0FPw+1FCbSFPzMRs6Tcd3WulKHfaf4KVVIzkK/KsKN11o2i/dRseR
         /BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463077; x=1755067877;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3ZtOO3KoPZ/I7NSmve3I6N3iSKvHF5Yby7yuHTTKwU=;
        b=Kuky8uDfFFm2pgXWUbe8AaGqiNBuJHZx5ABwBd6o9Ai+oWkG6p/T0i/KBspERxvvmT
         KvTMh+r+Osz7tiGrl/go+bu0/JISC+dLtaoojJdT+Z2i3l0aZWTotG/x/TK0Q5dbTQiC
         dTBPwpQlMbqjrNTykF702Afff+kM9Vwr+E8lPgmgcIm+LAb/GR+F3pxC9EhSPpJ762+S
         fGeKkRrA6v7KqxyhYycNBXLZpEElU6KL4XejkTLGibi4aB+DivK7alGZUWMq5Hw4Ny6Z
         S6uvm9ShifDEf8WToYx5JObeCOnmHTXTwKm4f7FXd+TxaNSm9V5aVUAho1b1lgXMnK7P
         1HAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUy3bDzcxqF1zsjtNnNwFQvVkfXVwk83X2DDDe2shiEyGzXrUDA6nOauF8NsRNglMKoL8EyiWlkHV7AbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwseqI1eugv+pSlINgkibpeywL0dQM1nAbh83orZkxqPypVNYT/
	JqiQmkYaXhGuDMFbciIlOYgMv24Eu2xVzbhwAwwt69kAegXfAiAITrt2i3yPlpIObYM=
X-Gm-Gg: ASbGncuEUBlsVgVpoyyE+Ec8xaFoQSJtk874QeIXDCj9s8ahE0Lp7WI5DRm4IzQhy5N
	+wCcW9/I4QKvc4fkqnxhAGzKBVEaaTEjfpwQmbn0BtDT7xh0ME1wc/N7cmJ9zb0VqZe2qW5rAfy
	bJE0Sawu/aEjZ7fO3VfVBL2vudvqCNouOgkwHIy0FYxjJAIJi6mj3+sejvTqpJcePeX21PMemmv
	fRrrLaRuV/YSAt8bcrhHydO9l/sJ0ubpsAYewKF2VA3C+SFf3KKG2Furzcdkf7/3a4x2ikHOmtM
	3903uPG+8xuqjRLCTwQGEHP1a4TLsVF+msypVrNQGKOLlgRCNZde/hwYM+zAcGxYEVyOE696qwD
	4leRBqE0RxbdUVg4X86SShRpkiYCJEqNxZI+mPU+ur6I=
X-Google-Smtp-Source: AGHT+IG5UAFATkP0zvIQx/j+Nr2FUYN6xi4uYKLlr2fwfvsMlDwmnESJC6grlroi3YZEydZFk1FwVQ==
X-Received: by 2002:a5d:5d10:0:b0:3b7:83c0:a9ab with SMTP id ffacd0b85a97d-3b8f41bf22cmr1375079f8f.55.1754463077196;
        Tue, 05 Aug 2025 23:51:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf33sm21932550f8f.7.2025.08.05.23.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 23:51:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Joseph Guo <qijian.guo@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, victor.liu@nxp.com
In-Reply-To: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
References: <20250806-waveshare-v3-0-fd28e01f064f@nxp.com>
Subject: Re: [PATCH v3 0/3] Add support for Waveshare DSI2DPI unit
Message-Id: <175446307628.1715407.12942298107316209335.b4-ty@linaro.org>
Date: Wed, 06 Aug 2025 08:51:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Wed, 06 Aug 2025 10:33:31 +0900, Joseph Guo wrote:
> This patchset add support for waveshare DSI2DPI unit.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/3] dt-bindings: display: bridge: Add waveshare DSI2DPI unit support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/01048738d6b618fc1dba564b38b3df06b0937eb0
[2/3] dt-bindings: display: panel: Add waveshare DPI panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/80b0eb11f8e0a504078c3b405b54cddaf535ff97
[3/3] drm: bridge: Add waveshare DSI2DPI unit driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/dbdea37add132a0f5d96006ea01fa73280984b88

-- 
Neil


