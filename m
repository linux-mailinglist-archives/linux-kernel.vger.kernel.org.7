Return-Path: <linux-kernel+bounces-759058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E73B1D7D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F1A5607D5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 12:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E2F246335;
	Thu,  7 Aug 2025 12:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZHqZxOs/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F4241114
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754569706; cv=none; b=U85sVzbM7g3zFyopSLf927en2eihV8E8CaOiBQWgg/gM0GKJKkcrkLCgCEPTBnFDM0RCB3xIzBYhH8C6usYprxEjh4m9j9gRN6yXxl0DVyngYhk0i2X4Uk4beQy/X3iHL09IirdCtUYLvwdSimcwTYdacFLVpcW/PnCgSvmQ8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754569706; c=relaxed/simple;
	bh=O9Voi/RWYUfSWWfDQZc/hD2r8yWPb9rMLJvZyIFedV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CFr5Z/e2mnpalxktzS6sAFdckePj5VU4KEByhtpCol1E749QYoNws2at5T+xedEc4W38mtnFMLXQfG6pr8vmcCkaIV/OWAtHpdOH0tZpGWb9vqsvb0aWmGIgNGgxjYibcugvTrk1XwJFdcVDMnDTiO1naESaQwwtUUj3ZYCnTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZHqZxOs/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd050184bso1339864b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754569703; x=1755174503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=ZHqZxOs/AiAkWI6LkUNKp42AG0GgvoTSp69d/zVZJ/sIvzp0wfKN2IH4+n3EvufF9j
         cZGU+mKxFH/t8/BFBjmh5sdd5j97WcT4GxGKVb9FXIqRrBp75li4SyuFOutwPvg7ck9A
         PdobNBC/sLDwBd3sPF2ZaIfwRSxgFDpbeUL0k1+uKfJckr1D9Ty72uayPZWs7n599GNb
         ah7UIn6oro7sPfWbGTTwOByEQkrDFADJd5IPGqq5CodJ2bjCqLvteluVIkGt58eAS6OZ
         jvaDkMqc228vvfy+5CRx7wBomUCCRp3U3uDRrCnOfZbHd1WWgiU79InYFEwYAf3rHeQp
         TLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754569703; x=1755174503;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41g/9cH0APsfIUsqOHFdZAgoS+pLjh1fhvOleDoY0lk=;
        b=iKj/Wbf8H/8ud1CcRXOhVjo6jwP99cS5Urv+XcOxQtwSbRwBJ7+eGHl6E492uxdJfA
         /ONsGdmGWTvX2uA5SLyVdA7NyXaC5Up93x5usaKolE0nBNAJ9lH/8dKLbyaX1IbWoPm6
         SEGIFdsEDNd1sKzZBVUUogsuJUv/iTMnHMi/cpLS7FleiuoGnJ0oDeAp5tciM1cYSEoO
         vinXDZIzSeeplEp7sBRugl0EpdCaUfPDP3ueZNq9pOjB795K+J6fcGwEX/I8E0SlVNmt
         /5ubyCW0kqCn1PIRGGUGXMlhFK9FPqXgDFA3NHljOMkrEZ+ImpvbCpc8s9MVX56sutrl
         ktOw==
X-Forwarded-Encrypted: i=1; AJvYcCVQQX0hBM/cwSvyZKVyX8BnlfOrrl+ExIXWq73RjAgDL/tbJBVEL7qWxnmpH5W8oC9goRNKV3qQ50HygQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVv4GoYnXqgfjMKlC5/iQP1HisnI3u9+LYqqBZudg6iy2xf6l
	fZD7CK6DOUUNxqDY8iZ6wyo6A40v6L4O4Co+VazPEZMCPcmTGirwYxqzTd44iGBoWUA=
X-Gm-Gg: ASbGnctbKfL7xbE2MHHw392md1BfJeIKAawZ8sHpWgrIJuHmZGO4fF0R4x7pFckac17
	3/XrIR3RTvObn/CNEXD7mumlDRvLoJyBMXVXRKwk6AP2mqVF62HZUAk5ZvelVud8VVS4HboVuQL
	pGM7UHXGEHumNTGFOEtVG2ucYqamEmmbFnSP/gCoLFGzx+uh/dcnHn4hpTTUt0+xjWj8CctZaEx
	64fKlZox5nzwWQjBiIbYVWoFUFVqL545doNMJ4ZAo35pkAgKKBfywUcL8hs06RkXG70Cn8mwgdy
	XxA/GFq4ckUylBGvt7vgOqwSqUJ9guLNDMr0WDD7+FfNwHJJanK4c+l3oVa2zBYKjWRV+JGcMdi
	UZuNfxoxZDU8qWFk=
X-Google-Smtp-Source: AGHT+IFZflKqpkXCxCNuCXe0IkTo0oWflze6NE8a1yQ9TivWCEJGMOIfgjBBvn4BOsd6MO76MkWDPw==
X-Received: by 2002:a05:6a20:a11e:b0:239:1fad:a3c4 with SMTP id adf61e73a8af0-24031252cdbmr10058825637.16.1754569703349;
        Thu, 07 Aug 2025 05:28:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c34d23f01sm2710016b3a.23.2025.08.07.05.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:28:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Keith Busch <kbusch@kernel.org>, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
 Maurizio Lombardi <mlombard@redhat.com>, 
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org, 
 linux-block <linux-block@vger.kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20250807053507.2794335-1-mkhalfella@purestorage.com>
References: <20250807053507.2794335-1-mkhalfella@purestorage.com>
Subject: Re: [PATCH] nvmet: exit debugfs after discovery subsystem exits
Message-Id: <175456970208.305227.5090103339122864119.b4-ty@kernel.dk>
Date: Thu, 07 Aug 2025 06:28:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 06 Aug 2025 22:35:07 -0700, Mohamed Khalfella wrote:
> Commit 528589947c180 ("nvmet: initialize discovery subsys after debugfs
> is initialized") changed nvmet_init() to initialize nvme discovery after
> "nvmet" debugfs directory is initialized. The change broke nvmet_exit()
> because discovery subsystem now depends on debugfs. Debugfs should be
> destroyed after discovery subsystem. Fix nvmet_exit() to do that.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmet: exit debugfs after discovery subsystem exits
      commit: 80f21806b8e34ae1e24c0fc6a0f0dfd9b055e130

Best regards,
-- 
Jens Axboe




