Return-Path: <linux-kernel+bounces-895766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D7C4EDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A60334E57E9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917AE3590C5;
	Tue, 11 Nov 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omyOI1JR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A80836A033
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875996; cv=none; b=cJivEbN1HIdJOw+O3H8MSwz2o3aDGHuomraWd4yyFs8a4G0QQZuZFiS2skxzQIliYvXbWSefuR51cC7rYz8wzWvP1Z2fo4I2jfZKR6/nMNCrXT03V0rgA5SnahCo0RKWYRT5cgJ4aAiNNwcfjn02qXX2yLzSSljOiAcK4S2gCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875996; c=relaxed/simple;
	bh=ERnZBlwh830mwLoldZOqqvJ8QgCiVP3NFpUKwuH37cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rCXA0iDXLb1A8HWEon//klEzACepOo0WoTc+LgyJdKt7HWwJVEQeAh7F0QhTb2DPWOjD4GfFgPJrnQPOYmQ70/ku5+JoEKZWOwfmihXRSqLKYfK5kxdu2m6gDiYebct4uKWDP4HbR7ySVsx5J25IUUAgz+h3BjeQJDoEjETs0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=omyOI1JR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so34040035e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762875991; x=1763480791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HMARtZJuraEYMooYga7m65rMsGPE/c/b4abR0gmXnI=;
        b=omyOI1JR1OwCPno1hh7iynWwjPSUPnsHTuLs7XAkTkegwPGmk+u1ujJX3gvpuQMggG
         sMATcBSHG7XeihnfgwzVMo0MXjmqtjeMMaPa1oc+z/xhpsfkmRDqmuntMHMAaMA+tiZU
         M3nFybxoDrJjmyOplO3UHzSOamq4TtSirI5n+t+G6n6MtQWzTjL7SjGkNG9+QJjOX2SK
         yVkD3amZ62tindxmNC5OLjVFpsE8Fw3MgSJndThEkKvvlmKTeosGgC4xK9gqnVeWDoVX
         3qnjPCU1X4T+TfKi/P0PfYyJs31tsiG2ATPq5lc35RxDN0CLUytVfCyWqLAzKZyOowB0
         w7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875991; x=1763480791;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HMARtZJuraEYMooYga7m65rMsGPE/c/b4abR0gmXnI=;
        b=B0BbPuGyuAteBjFX/7TOJHDsVpNyBcmaQrheY9lWNUFIDL06hZKWpH6cGv5IpQfUaT
         fclDtxSj71hitD8IttVpWo8JnWep5Obk5tXxLmKiS90VXIDJjcEkjHBVwV+/ibHKZ1OY
         wZ5ToqMOWA6xnvnm0VqrwQlTLDpT3yqbI+UoWZRWvGY4FdcwAMLkvRrrDCCV2psJQhq3
         fyPc3u3TLWSgQ5T2tOzKY+SmWWpOGEUz+/NrFdUWLKFyZkpIAnJFJUtmc+aXArRofNEN
         K1+K5zO+qrpFmPmX8g0i0V2hTzh/rxZVIXxknVKP81bg7JFMqUDO1apUYLwQRiY1suaN
         5+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWDKzx1buP0n6ALZMGckJZp6mphg0AHsTQhu+6EpWEOF27nmcfBU7P/sMw0KE+0YPUECLw7nA+eURpzYTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxacocoz4ZiT3eIDdfVTID/cI0fx/xyYm4vlxM4RDDXineSBHhh
	ArvogDSDJL92MtUEtiUD/+AItKWVXab8fd6srdJo39pvsoTt/ckQ1qjACbt1Eu/7H2M=
X-Gm-Gg: ASbGncuMsxfWKvxCjVFJXXVt6zfJ0JoUGgr2Nqmxw5wf2qxm7vrpru1CpgblLmK1UNL
	Ma4ReRK/RPdNQoSyoicovPQUrdBfcQPI6eXiST/r4fhpgMjHNxph2bVzfuoA6oyTpa4EdFcss5p
	dyCB/AZC6T3ZowRzgsyGXpkr2NGq50smNxIXN6QxprGCAR7/tksmv90YZzchSdnVVZU66FfW/hc
	94H/49VZL0S0dDBBMug0E1GRbBNgdxAgLxmpp2fZsKay0TBd4s3hlHzj4YwBxTmO+BIzQK9Y/Te
	/lvSxzyzBH/T0NSHg3f/5DjgKbPXckvG/GsAShNRa8JRcgfD7G4UbG6nxaZ8OukxYBq4b6Bb5Mx
	07w/NarH9HtntdoSAdX417kLUOiZYryDut+9K44477JEXQKHoJ4bhTF+s0zYKED8jec2AMWj+Hk
	gFY3EN9E8R
X-Google-Smtp-Source: AGHT+IG/mjf20bwbB9ulOVh4z563amE05UyfIyNIY5aYHGSZyB1LNnu3YZ77PJ1u1Qd3j2JGeLOsNg==
X-Received: by 2002:a05:600c:a41:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47773271aa5mr102937745e9.22.1762875991319;
        Tue, 11 Nov 2025 07:46:31 -0800 (PST)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33bdsm377541625e9.1.2025.11.11.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:46:30 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20251024-auxiliary-v2-1-a353dc9e6b1a@nxp.com>
References: <20251024-auxiliary-v2-1-a353dc9e6b1a@nxp.com>
Subject: Re: [PATCH v2] clk: imx: imx8mp-audiomix: use
 devm_auxiliary_device_create() to simple code
Message-Id: <176287598917.23558.10560877169801867963.b4-ty@linaro.org>
Date: Tue, 11 Nov 2025 17:46:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dedf8


On Fri, 24 Oct 2025 09:45:51 +0800, Peng Fan wrote:
> Use helper function devm_auxiliary_device_create() to remove some
> boilerplate code.
> 
> 

Applied, thanks!

[1/1] clk: imx: imx8mp-audiomix: use devm_auxiliary_device_create() to simple code
      commit: 9d97a2fe48ae77976baff441edd5b30ea4e179c0

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


