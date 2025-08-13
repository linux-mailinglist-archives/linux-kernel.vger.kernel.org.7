Return-Path: <linux-kernel+bounces-767095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F371B24F43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDBE9A30D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC225C706;
	Wed, 13 Aug 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R4Cf0b7L"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49023D7E2
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100915; cv=none; b=Lpb8Cyf2/clLx8DYX5VGL1hZ3OBd6K7+0be2tqmqEkUUMdap9rQV6P54ta9BQgaaB3JvfJncX0HBy6TzGUNiDU899kxPMrmbXAJPpWXhp48O1oSwA+2aZQEHaoIEM7pNcdXVBQzyeloCrFbzdQvCx17M2YeV5Qi1p48R7hKtpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100915; c=relaxed/simple;
	bh=T+3y8BiFHtIyRfRfp836FQFjDcVfPiRNAwpfTrxucN8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=kk2NDPPWVhGPX0zk1eqSBJpFMA/XY8I6+UvMQjBD6j4cYO5um/RefFI+Zg9Ia6dmU5dnXTOH+3u6us6Y80IkN154yZBWEjzItz19vhycvrE625YVz6PLzwZBBZ/JzRrsw8QiZNyRaFdSdTgMM4jr7jHIckaFtE4SqqDkkyEzijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R4Cf0b7L; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e86f90d162so5952685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755100912; x=1755705712; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dw8+oeEJ7c8LZ72iCnSilzwcvbRhY3C+6FOqOUr1dJ0=;
        b=R4Cf0b7LUjcvTmE5TKeqIRGzsdfxw75OVNwJ3N9bLDsQFGK/K6syj3y7QysRrGN7ri
         1vkDMNnTQdo0DqZmnSjV/pe7bK+lN24rOyHfT7S+zoO9tjIpGPah30dg94tUsrjRf401
         3SnpBZaj/qE+R2PVGmQJOekpsZJFkM+Y4FHuJYwUN3ouSE87Q1j1o/r0CCU2PpnUHhv1
         fQlOxuzf1QgQ/cUuCGWX0+ec0lcDqJCC+wtR0y4S3SFukAPkrmumLnEhZRLOM8z0VKYe
         baRDEAHzrA5svAJP5F669mvPmmo/c/bE4RqVyUVxnuRzO+0F2C7sN9/CJOaT7kavzaqK
         Sghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100912; x=1755705712;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dw8+oeEJ7c8LZ72iCnSilzwcvbRhY3C+6FOqOUr1dJ0=;
        b=Gs98zOGnVvE0H0ENZ7r053GogpaRJpYUSaDZVhtjKDczWwVB1Ao/OY2usvBoN3PY6+
         2GXqmn068Ukx4tAe2R1gwVKTKSGvm5Z7f326TD1OtCVcgF78pcJxhUpCGK6VM3psqCFj
         qZqFLtuy8Nq+ED5hH39Ms1HP9JlnfI9lDsUNIffyrXWwm7WIi31694xAKZlu+kJwoytU
         ZgUUt8ox5n8GYz7d7bzVexQjcOLjnyh8aP+vZ9yT6BbVLDxdQEgF+Z2w5CEXrzKxgcrO
         I51W4vI5maZ/oGAUJ2sljRmyngf9xr2t7uJdgMvQHxkDOXgCWj5XKeXJfD4AD57W7N4c
         9k1w==
X-Forwarded-Encrypted: i=1; AJvYcCVryc3g1zAGA/fTD8dXMoRXJnD7Mj1i8vT48CqmuS//N8MPcUz6dpMG7cqVotQgUFI4I4mB6ReTF/NBtv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvF6bKhKKL9L2+k2XWA0xmNA40gkcukzohZQxYWBHwfq3XVvjT
	4W8DVJpJcPiiVokm8Mal8EM/VXly52Y6zgq+Mj94wJ25AItPJlzra2krpyIgKup9Bg==
X-Gm-Gg: ASbGncuD/wfdDs/B61AwA6AG9DWLiaApz9FifczXvdn7LnpPk2aI6IrladAD4Ke+nRF
	/cTA5m7gnnPp07eVgbPVWFslNxjg4c9Dn0pSyJj93c21oRzfg0qhwYCbERKULAFJRGWx2YwgNKB
	2uYZV/yoV1Ll5TaR+Jg7QTFV/WoKGoUo76kqD1g/8RhMV1KjtcIhhv3FYGC26qcrWcLNou23/cZ
	dcOx+9hhIdtoQp3I2EXWuUHAvf5QjmwXG1Bu4faIfkTzGD05KKCe+seQ9dPvSbZNz9Ez0F9uZbt
	gWz7CpuO2IN0t0WbNmblN1xSP6TSx3pPKOV5pINdpWUfEUnqJFJaTHo3WW6TwUZKJydCTUOtWak
	nLE0wdxHL3/ApxNNJDKMQzs8roZML7qcaEyvLTfSVvwTRs9u3Q4sCcYZIVhf6gh/iJOU=
X-Google-Smtp-Source: AGHT+IEeiU8GDqNtvKXoIwTdREgaManpc5CD9rIVEoJC++gPCoA0os4E3MbFoDyumspUCFni5tDj0Q==
X-Received: by 2002:a05:620a:d8e:b0:7e6:9753:d959 with SMTP id af79cd13be357-7e86fbeb6a8mr14589185a.4.1755100903431;
        Wed, 13 Aug 2025 09:01:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e8068ec9cesm1485491585a.55.2025.08.13.09.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 09:01:42 -0700 (PDT)
Date: Wed, 13 Aug 2025 12:01:42 -0400
Message-ID: <b7fae70a87b4fe937607e5e3215397bc@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250812_1310/pstg-lib:20250812_1218/pstg-pwork:20250812_1310
From: Paul Moore <paul@paul-moore.com>
To: Frederick Lawler <fred@cloudflare.com>, Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org, kernel-team@cloudflare.com, linux-kernel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Subject: Re: [PATCH 1/1] audit: make ADUITSYSCALL optional again
References: <20250808194034.3559323-1-fred@cloudflare.com>
In-Reply-To: <20250808194034.3559323-1-fred@cloudflare.com>

On Aug  8, 2025 Frederick Lawler <fred@cloudflare.com> wrote:
> 
> Since the introduction of commit cb74ed278f80 ("audit: always enable
> syscall auditing when supported and audit is enabled"), eBPF
> technologies are being adopted to track syscalls for auditing purposes.
> Those technologies add an additional overhead ontop of AUDITSYSCALL.
> Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
> offers some advantages over eBPF technologies, such as early-init/boot
> integrity logs with. Therefore, make ADUITSYSCALL optional
> again, but keep it default y.
> 
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  init/Kconfig | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
 
Generally speaking the less Kconfig knobs the better; it tends to
complicate things and for those that rely on distro kernels, there is
always at least one group that is going to be upset about the Kconfig
knob being set "wrong".  In my ideal world, CONFIG_AUDITSYSCALL wouldn't
exist at all, but sadly not all arches have the necessary support to
do that at the moment, so CONFIG_AUDITSYSCALL remains a necessary evil.

Thank you for the patch, but IMO this is not the direction we want to
go with audit.

--
paul-moore.com

