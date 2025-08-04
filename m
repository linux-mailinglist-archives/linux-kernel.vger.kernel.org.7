Return-Path: <linux-kernel+bounces-755423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3FB1A61C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E96E3BE830
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF402741BC;
	Mon,  4 Aug 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pW7xPGOS"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3B2701CC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321587; cv=none; b=pqFlf1lC9XhNbOqWlk7EHqr/fdaEsp81ZvauWc+gIBeNQ2hqA13wSt977W/G6llDJi0CWpMKZn6bwYo2ULr1tgU+4U/pY+7VJmbWzdl5a1qBNU71lf3r+jCGHTZfgZXD/1M4dXw7idWcb3tCIIuNfYLJVJMk7hiGl748I6VuiA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321587; c=relaxed/simple;
	bh=RjNhaLUzCHncxHPl50vAGrdAnw461SVKj2hgSRn4yE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L9ro09j2bBQxkYdHDiPcE9QRTrShfGSJT+1qOo/zDzekTeMQbLqbKvG2GKRBKGGvC0xuiZdfn8n7BvgXfisoniA/vj4LuYu+Bx/pXnFHaeq7bfSM/L6N/T+9mTBtk9u2IskTOIYKcrY9v1jVN6gPRtZhARDfFoLATbenxnl9cLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pW7xPGOS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so2568884f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321584; x=1754926384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNqaDE0XRwMT9nDKDCZRUJSQjxM5DO6M30BKsMqcjqM=;
        b=pW7xPGOS2ESJnJ6blL2T7zv1kPJ1HR6r8jmf9rnKfZ0Ecku/k9WR5Z5c8sk+gbDEFX
         VZu1JoxV0BoMQUZnzPWRD+O3PbCcvflGcAqIeJQDzKleoUP2/8tzEUO2UFA1srCu0SCc
         Q6+vjzkQJvfNoEAYgfJNscTmfKXppX1MTD5NGT+ONFXWVc8lVQtMQ13C8g2U+9jBouyB
         C130vWr2cyL3if3dLePS3DcXJifpR7XKqgCqr38oAZaQd7W8QOm2HojPhWuclEDSRHBb
         v/w4Jc7RrnpxmizoO/H5rq/KcXocI9ZQ+1zCz8/2FYGXQ1rim7y8YAWHK4KMkSGXMV81
         O7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321584; x=1754926384;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNqaDE0XRwMT9nDKDCZRUJSQjxM5DO6M30BKsMqcjqM=;
        b=ewEExxaIkiUFlZFFcMItI4RhmhnBJtueMP/j/Xf2k/OgrQdO/c0pUjZoVT32jEojM1
         sDZPKFiqRRuSutwJamaDFOnzfJJpGquj5aijIGD0m/uB5UjpB2CwVEwgaA4fxkYBtNMd
         GijnMN5aeQl6gDyyK+7vGNbMXw8u4zaoGe6X8j3j303XvwE6mtFrCUJmyK8mIjBTjlIy
         yW+aXSHSJEaLKsgzSZtr5f7MZywGPRnc1BPadHqX6/eYpFqMsUX7vTisNbJrI0dVXkM3
         0ogQr5lY/9BJnvdID/iTKHKYnKo6K1BxVqZO9KimuPA4he4sP0KDDoOk7KbIAcwwW+xL
         wFKw==
X-Forwarded-Encrypted: i=1; AJvYcCV5/wq3Qnvq2kdV/khCx31Npyt24QK4UlWwPsU20okjH6t1dKAfdEOr+W601RRJqaAFVR0CIZKAJHs7Fos=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIDz+XK+GlEJZlhyVpdtYIX5Ke8aV0IxwZSkDA4arhGJckz2N
	IcKLYnGcyiZQlTc/ZzeOdmxZM6yt6sDWHvDsLFkE6TQiUaK+uT58PWfL5GiYsmlyjZM=
X-Gm-Gg: ASbGncsM10aqngvMlOBuhGOBAgoALhZxLoLbV3nyRX6Cw7nLlmGRPFgq9GaZTm1/u+r
	5ok9tyo+36DCnsGUn6+YjOTe0zSorsG10D5dqWPj4DAxLlx21Dh4dwlvZbSYdH3FzErdk+F4Hzr
	GQpKVVbgMSxFM5NXWqNoKVeBWAVZWqDB5fEr+Mt4YUlMdI55m6VHolBVelCxDkd3lMQcqe5JQB5
	cZWeaYz81gBQdO972PevSHAYLCtz6tshZaccg1On+GJX9oOMurazv27ZSAIbiAYswEuX9B6Bef8
	+0S/aT2MeIVok+jpIbLAWkod7QZSbMh5Dvz5sfTMtpQwN/GGnSupQB5+9f6ObH7iGxIHEVDws98
	r8hd8Cyf/goBQceM+6M4k4qjRaru1zwkgzz3ui8fRXyc=
X-Google-Smtp-Source: AGHT+IEH7J1aEyt847RMQ8pSGEOtrPbTd6+jjxQIc6w8XSKcTYDqjv4qErJpnuzKoW61kb/HVPQIFQ==
X-Received: by 2002:a05:6000:2007:b0:3a4:dc93:1e87 with SMTP id ffacd0b85a97d-3b8d9464a92mr7863001f8f.1.1754321584448;
        Mon, 04 Aug 2025 08:33:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47ca5fsm15664010f8f.63.2025.08.04.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:33:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: jessica.zhang@oss.qualcomm.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729054214.2264377-1-nichen@iscas.ac.cn>
References: <20250729054214.2264377-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] drm/panel: himax-hx8279: Remove unneeded semicolon
Message-Id: <175432158371.3671011.9003968976517689248.b4-ty@linaro.org>
Date: Mon, 04 Aug 2025 17:33:03 +0200
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

On Tue, 29 Jul 2025 13:42:14 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: himax-hx8279: Remove unneeded semicolon
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/05efa7f1d14febf0cd230c4950abfa6add1344a2

-- 
Neil


