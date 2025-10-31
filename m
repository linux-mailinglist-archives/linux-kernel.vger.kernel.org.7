Return-Path: <linux-kernel+bounces-879747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 150CCC23E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 035544E1FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007C30FC36;
	Fri, 31 Oct 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ES1AhORT"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B434D3A4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900545; cv=none; b=YtOi0VVz1Qy7PquQoVgR4Z8voAwNYKN8mAWA6P52+ZJDXEvqIS8A4mCIGF7F6Ya4MhdsE3iB3b/PzspIhrxVRy8V9+EwvmixY5quAPEeL84j9ppjESkYsoyQGPocT0KZrSFIplEWi3uyb4WBhPrqraTKIQdH8faEaTQd2bjLX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900545; c=relaxed/simple;
	bh=YcNQB2cz7cmMdG+LgLrQkA0i5OOSEJyUpwul2usY/M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGYrTN1tQwQhWK+RYXogOo9KCT3tN8BU2YPbuNcmEi6DV+uA57AFY1RP16GH34v/Ls7q7nDhG7oeAzNBakYzVn7+z/xkO1BTiAfl87bI/UBNJEwWBbaRtHTY+fcVZTsokhX04M8AKQE7cK5AgzNZojYtjZi2KDR3TBjevMjOkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ES1AhORT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592ff1d80feso1295898e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761900542; x=1762505342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcNQB2cz7cmMdG+LgLrQkA0i5OOSEJyUpwul2usY/M0=;
        b=ES1AhORTcFP+eICMXeqcLTCQoZsSpw5pONY9MgHui+8gGtuf+p7CRb1xh3DR0fcugR
         qVxJpPzng5BKO36vcfjTfT+3Ysgjx5EzP8NefZdyqWdWee3k5+BCmpVNsoJkncVxeiAf
         OYNM2OQyIZ5Xgv+8ib5Zs5zf0GLkajTJP+KC9RKboK0O+vib3BxO9o7VyOQzb2mEKxbO
         XM+YK4xnmS1OEB4gyw8HUOmlAWxBGydyn/sPH+JGhHAR3LHMcG10IeFGXmO/W1oOXS+S
         53ff+KtLyUtcXED5MtRsFNiw7FdoBG1lQY/HJG+sY3/FPm4W6V7QnQEYqdWZ7RWYydwC
         SZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900542; x=1762505342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcNQB2cz7cmMdG+LgLrQkA0i5OOSEJyUpwul2usY/M0=;
        b=qN2Zr6juXhwL5A9LNiMSO+yKwsxDb9MAD3TWr/qTp9CTm7URDyc0sfAt8CbW1h3Nc9
         DD8Az1hvmzcfqkApDvOWcrNFPJaldyaaSAYO6DVyGedzOVIr4EQJYqfQaaHxXFRwSy6b
         0UKPluzR2i5/iyesR/v/w3RIyqZauUSy9yc2zO0+mtQlSaeT/o/F5DqFPNMKoLsbsytp
         hk8ZgwGXsauZdtbw+dfS43D7vCy0ag1GJ07AiU6XOo/LXBABiFpNc7BWXlomdetmbKks
         JPSzfaM53wmjcZIn04SMf1C31KeADA75RmTP0RR4OvPvFPPal6GEt9RiHx3b5SBJfN8G
         3Qjw==
X-Gm-Message-State: AOJu0Yxg7TgGNrHG+KJe/RrVzIqcaPfaixoR2WMoNK1oBiWLhbbEhQBb
	IsHc60qZ6qyvwpbnv6IgsAJe14HZpOyhbQQq/v1DcFJYfb/U5TZjVDT3Pokow7c/fzsUkBUbpCW
	nYWLI42QXUDYVLOH0SYlKgUIArfLjpv8hS3mGynkhXA==
X-Gm-Gg: ASbGnct71yXnjXajHuqzLO1bSqZ5Fo4AwJiWGwzht1J8fLrh/PiKe5TvRAn9BArAPJH
	HO/NJt1AXwq1FE9c2zfBypDV4b0L8gh1Xup9A+oUL73B6P/8QacgjMrKb85zaQ4ZBATPs/3ujFm
	Km8jGEjlxQBqjz4k0socCo3OOOavORk0w6yjHsEfIQlSj4mipyuqrf/TohrJwZFMxXu3YxlnHFi
	kiKWDRB2HPZM+pYXXXJxsLRf1nY02k/y+gMZyexbAXSd+wlBgFih0liCepVS8E7ZVKf2OLttXtA
	JW9eFf4MXXkKuUOOtg==
X-Google-Smtp-Source: AGHT+IG5f9LrT5nyeUFiNlUT6SjibsgaFtcZ7lVM5kJmZgFZMKb75gWV2jzCfnyesEQtIpQyfU8LfCkUsKtRhTh/eAQ=
X-Received: by 2002:a05:6512:3d8a:b0:575:c6:edae with SMTP id
 2adb3069b0e04-5941d5561cdmr988285e87.53.1761900541585; Fri, 31 Oct 2025
 01:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-4-marco.crivellari@suse.com> <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
In-Reply-To: <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 09:48:49 +0100
X-Gm-Features: AWmQ_bn-4zPvtMBML6N9b1bZZjys-qRUhwoiBnh0rijwWGoJyeJGXQ7WQEI95VM
Message-ID: <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "Yang, Philip" <Philip.Yang@amd.com>, 
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:15=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> Adding Philip and Felix to comment, but this should most likely also not =
execute on the same CPU as the one who scheduled the work.

Hi Christian,

The actual behavior without WQ_PERCPU is exactly the same: with 0 it
means the workqueue is per-cpu. We just enforced that, adding the
WQ_PERCPU flag, so that it is explicit.

So if you need this to be unbound, I can send the v2 with WQ_UNBOUND
instead of WQ_PERCPU.

Thanks!

--

Marco Crivellari

L3 Support Engineer, Technology & Product

