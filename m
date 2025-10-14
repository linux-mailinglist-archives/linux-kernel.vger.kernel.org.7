Return-Path: <linux-kernel+bounces-851884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286EBBD7873
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A7C3B7452
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B700630AADC;
	Tue, 14 Oct 2025 06:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPpi8ajS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3F21ABD0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760422090; cv=none; b=VXvyBWzKBcICzLJa8wY6FyILNJDpOQfwFEZIwMUVy92b/so+sq9TiMlHKFa5lbq+dTRvnkdjTnV+rwc4YkeF9kqWiKpTTmz5W6L1bY2U5Xkke5v2wqCM2ukMmhbuaiHOqe6fB+ZbKGtifnauWxA27GtFrohI69m1MdFL1yXw8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760422090; c=relaxed/simple;
	bh=zW1ufZJxGA7CwHYy8cjMizcBwZzDzUHbkJ0ZT7bCLSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJJfBIzKE+ciiAJQEiqC0GCL84kThg/ZzGFxT1Hl9W0EdB2R4b4Xq4SSlfJE+ZP6/cROnZo/7mpQi55O1RVJ/VaqOgzgssHJH3UyWXTrl5HJuo1oNX8I2N39AtNfSABaqrB5gfFYGxdToFdyOYUXVLu1T8H3QbACIQ8X8KsCKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPpi8ajS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so4444603b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760422087; x=1761026887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW1ufZJxGA7CwHYy8cjMizcBwZzDzUHbkJ0ZT7bCLSQ=;
        b=nPpi8ajShcyujRVyQtVGf/nsvvTofIR2JJ+uizIzIfrPBEHAlcZLkw5kz4Is2qCp1H
         62V7Dgf1D+4jFY9RetzStO5X/9rfpVngjgEA1vBRvZDwiTUZTqfnqEx8gQZeKN1JrLkI
         Dsvkk7WwZoubJkfbz7X/aos2sY0Mku4DgBZJ28lfJHWQz6QcmgHQywvi80vanf0CPtfN
         p8QICk51B3o1VpzYu+qK7wl1Xx7wgqPA+xi2x9iN7pjESr+SAxqcUop25VavngW7TcXg
         31EAhttRf4fWMVWnNap4tmrLGCzTABcbBzOMDUPwjVejXrlmsIaBVgFl8vluPdyKfe6c
         ozUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760422087; x=1761026887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zW1ufZJxGA7CwHYy8cjMizcBwZzDzUHbkJ0ZT7bCLSQ=;
        b=kZ1WeSgIXt64G2SuAHDEorwmCQhiAoLhKKim8YJaZjOouYbkAoUsd1z3Nll5nOWNNY
         gXe8eoazE0wqOsSU7yrqlcHSYq3Ke9VwNaO7wMIw1Jrka42CUkNsZAFG2IGkAr6TG8Hm
         +YdDQpHaSl4g8INvJlgQKDWholvPG++cqzwlVe1RMXaEX+k1Wv9RKTYZM5PB2mTU6gM8
         kJhl+p6o4J60t+//D6Ulzip7/hFWafQL71fsE7oLU8KHmtdrFV37eW9zu9rCRxEZ6Upn
         Tixx0QD1hJefPdefspvTOuMFDTiGLDw+vIHGiQV7C60BOFbqbJMecqc0J1G3cSyQ2wle
         jlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4PT2El4xmz/p6OJqbI0vCsqOoAc8jHXDNTMHWQrXWs0FtrhrOGrIMHnfc0QCYBmsXT1ScBDIGlAUYZuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmQUc+C0cp/wD4tE6W9shwAK2gNYAKzF11NU7UnFkyjc7gIN8
	bcK6Q/qUHK0k5EKGGSA2WbIIl1DDnlX2H+S2oARYFf7D+YCqPqDaM5t5GnVNpQ==
X-Gm-Gg: ASbGncu8iRXCky4D+i+d2ndaAc0AgMDanq2n6C/6YkysNhXSmhlyvmUgKCurTAnI1Sm
	T4iJhx3EJ7DR5R05oolfgRMoVZtY1Ws5wifo41u8VTyDvHKwHoTvlLM5dz/CjEnbQUggPNPDhto
	WhROMiSMatV2cjoo2pO+SDC0jxL6RZpz7PRqr7ey4PtydctXp/TYBa1BTZzn+twsvgcfKWquWeC
	leu99in9QFQNC3zNLXlQSk4x8Zfqm4rfU2ycimoPr+IhswVP8ajm9vpojM8+wZAWIyf28xiQPmO
	jZ5XP84dDrAWZrTPBjsB5DsSWtPXGDZ2GUdGGDPRxIKuKObhTOrm3gjvhP8h52cse75K62EnfLf
	Wk+Ti/T9/FExPk3u0sPYKXFYCL5BIdLNqP4jeuSQBpThkRz6F2TzbtJ95kybT7bY5nbc=
X-Google-Smtp-Source: AGHT+IElNIdqfxS6ykSK4HeHqahrbzYkLyHVFJw7oBK+qw1dJALOAqreq/dRuYGm3x/XwPoi1Zdsew==
X-Received: by 2002:a05:6a21:3299:b0:250:429b:9e75 with SMTP id adf61e73a8af0-32da83e54abmr31288118637.41.1760422087049;
        Mon, 13 Oct 2025 23:08:07 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5293f4dcsm9342434a91.1.2025.10.13.23.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 23:08:06 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: tessolveupstream@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm: bridge: ti-sn65dsi83: Fix LVDS output configuration
Date: Tue, 14 Oct 2025 11:38:00 +0530
Message-Id: <20251014060800.1913351-1-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003091911.3269073-2-tessolveupstream@gmail.com>
References: <20251003091911.3269073-2-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

Gentle ping on this patch series.
Just checking if there’s any feedback or further input needed from my side.

Thanks,
Sudarshan

