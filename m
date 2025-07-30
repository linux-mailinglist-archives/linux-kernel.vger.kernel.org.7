Return-Path: <linux-kernel+bounces-751378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B24A5B168D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7087B122A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033822A804;
	Wed, 30 Jul 2025 22:06:30 +0000 (UTC)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96519C556
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913190; cv=none; b=TJuqNZWd5jmhMiqGK3B3PPoYZVtSzEJoeLtwUK14tOlKl8IGCAB+xk8k+ZA6JJtNdobGkQOCcoqhUaI/bBhepsQuKkVgho4N89LvEXbeYoMos7/QoRwBxaSC9q1zPIlflcV2JVal+d/Pe+8C1pckcHo2h+h57b+I5fmMJyl3xxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913190; c=relaxed/simple;
	bh=5FDyXQRbCQzjtmA0ZBTa4CrTmcIqeuFjE7UZ+wGrZ08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=da/tn57foBk3LQEGD3N1oTIRUFt2ubaObmYeX2rGAk1N8DZZx+DHe79uIXOHY++z4ykryBPF0IJsxaFWKq5dFcc6zydsYJvr0a6R9BR1IX65A7L/4yo+FnoiQAPi3C2wNUOedGPigVjsmM8Xdx1mOumTpLLcZLR3IvSXKpen3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=baylibre.com; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-747e41d5469so316979b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913188; x=1754517988;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEntMuJf8K1VWn94KVCjax79vkBqXY4AtaSYgFOY52A=;
        b=MSWqHfgtID4CdxXF2yaDME0ot9/JrwfonNCYgf/nzV+ShCL1pSJlHOspUagURKsdpK
         GL+ClU19JEQOP17QBdBM2g4F9oeMD0xGWRbhoaAeQ6PT3A270cpnipoPqsxlxFDvSVJn
         7kZBrY2Nb7nNQ0Pc/BKqwQTYalp4RK+q33nNRrgSlHumhVszN7Z8TvJWWd+4CjbGC+d5
         MiGMAewyt1tF7h+rXdxOaqGO9IJQKP4LNOqUuL9kq2JcbChyH3ZTaAvGLmIkJI71Q3Jb
         Q7f/e6WA4JRoL6rZCpXF8K/esaitHTz+dK9A9y6aHkjzkZS1FzR51+NzE4bp710Au+cq
         9afQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6mrmyEeEfEZ/o3VIgkFabJKn5fl3HBYD9Sv7wPCff9ELgHDNjDFrFdWlibtQ7+9NLxmrwKWin2HK+iS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1WO7N/Ygk3aCmbqh8eRlXixV6jDEXe0COyc3FeqyLiZprAnP
	PlT4Hk4mY4KhcoQqcRiH3NtOZGTi5SwpVsQTkrakRkIlIS7vEJ0h4QbdLcgtxSPJT6dsXUWCBPS
	t9gNTk8gkpw==
X-Gm-Gg: ASbGncuoziRqqkEnboass5XaVpIJ/kfVuvNuWskX5+27NksTYXd8VBxONEORRj+2Uf5
	9pO/Tyk1p2515796LFgt7CzBvAIdtKjmkp50J6wma8zHnDYBEwuXWBOAllGImBL7moIspoTVvWs
	BUR/p0DhrGkOV0qQNtELGevZIcgkVOSbOtmak5dmSyLfazNhkre1GaoQDiJh07sCHmqi0HxWaOV
	I9KlKKXeJ4MI+3lzh9LL0n7Ouja0EHTf3k0mNZJFOI3VdMNps9aagpvW0dkOZsSsi7AI2aYIg8m
	Mk1+6x/gKS0r5diISPXjgHpHMN8wFagOG+NkKSeu3zG0fS3EGcVcUEWqtbziL8b7ySHzcSjbcQc
	esnAmodI4JdcUUC5gVFbh
X-Google-Smtp-Source: AGHT+IGKMwSJ63Nd2yH1XeUzJy9fbrTtsLW845jouCtlujT+wryYRIBOXBjfDANPssG0sgMTm8sLcA==
X-Received: by 2002:a05:6a00:4b4e:b0:740:5927:bb8b with SMTP id d2e1a72fcca58-76aade688a3mr7553796b3a.0.1753913187759;
        Wed, 30 Jul 2025 15:06:27 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640872a180sm11482407b3a.29.2025.07.30.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 15:06:27 -0700 (PDT)
From: Kevin Hilman <khilman@kernel.org>
To: Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org
Cc: sashal@kernel.org, josh@joshtriplett.org, kees@kernel.org,
 konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
In-Reply-To: <20250727195802.2222764-2-sashal@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
Date: Wed, 30 Jul 2025 15:06:26 -0700
Message-ID: <7h1ppxcp0d.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> Create a single source of truth for agent instructions in
> Documentation/AI/main.md with symlinks for all major coding
> agents:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - .aider.conf.yml (Aider)

This doesn't work for aider, probably because the .md it links to is not
YAML.  When I start aider with this, I get:

  aider: error: Couldn't parse config file: while scanning a simple key
    in "/work/kernel/linux/.aider.conf.yml", line 3, column 1
  could not find expected ':'
    in "/work/kernel/linux/.aider.conf.yml", line 4, column 1

Not related to this series, but related to aider... I'm curious if
anyone has got aider to work with the kernel repo.  It seems to have
problems with large repos.  When starting in the kernel, I get:

  Unable to list files in git repo: cannot close exported pointers exist
  Is your git repo corrupted?
  Unable to read git repository, it may be corrupt?
  cannot close exported pointers exist

but neither claude nor gemini-cli have any problems with the same repo.

The aider FAQ[1] mentions using .aiderignore to ignore parts of the
repo, but even with an "ignore everything" rule, I get the same error,
so something seems wrong with aider and large repos.

Kevin

[1] https://aider.chat/docs/faq.html#can-i-use-aider-in-a-large-mono-repo

