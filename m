Return-Path: <linux-kernel+bounces-864330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1ABFA882
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B371A034AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9E2F619C;
	Wed, 22 Oct 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri65JzYp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9692F49E9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117955; cv=none; b=nGjIOk8M2X0WiHw3ne6pzPwFwYjwGaneW/zOcfnMvU8gKWZqm9P/tsn4o+miJuYw/aNkVd3ZkVBhiGbkQaGUOyg5P7R+IkVq6RuoY3OdpnKcShiYxAv4hj53PGlIIIjOTvRpiR8brrXB5oVkm+kCJOoxSsYUMiU+kpft1X3cqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117955; c=relaxed/simple;
	bh=5N+bM5amrNetXwXJxRuKz0Pnn27FUWJd6XEgHZXg6Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZBGRNYVUugti4JrZSpZqQ+NjFzN24WPCIGiEvCcV0QKhqbkOC+wfGUoeWQ4KJtyCK4Aug30UtOJ9FnPBlkHUCW5hACjgfP29tUK2ZvP1RnlvylTMdKdJOi8WGCT5RFhv+q2Acq+GThkGM4jNkowN7psXdXVamFut0PisbNDG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri65JzYp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-471075c0a18so68026465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761117951; x=1761722751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKMoThOVBKwHugFJponVe6vbvCHZyCwokPD8AF+alpc=;
        b=Ri65JzYpaiGjNVRoLE66+Za0BWXPSvMvIz287hil8hacoVa4rALLTcEHkyCBVKfviF
         r5cAbsnZEy7KZCgHdhNYmr3X2OTqjvGtM/Mp6DgzmgwMAc3LvwWZAGK30o+wtRvWFSCu
         paycjfuUaKixEjEjFI8FnKSMY2D/OBDtswVWzfWBMvyGLPKilnUBtkSd3V6GwfrrgstE
         dCjNE1lzm2v8780XvBzvtYCRo+9crc83yQGNfVi9TCeAMYzMTuTc7QZQ2+ITZwPOK9yY
         NwROGqCUdMc/52N1zEEsk0wi7z4TtZZWaCqf3/xirLpTYIyweYDo7Ym4v0DeohNj3AAn
         SfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117951; x=1761722751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKMoThOVBKwHugFJponVe6vbvCHZyCwokPD8AF+alpc=;
        b=vb1YZjkcc9H7U7MQVU3aymSrklNsQmU8sXM7VQ19vuRXjyEA43rhsiztpccUyFoMzx
         w+3tijeWEWYAKeiGZXEJysNTzzbSOC51LaOTqztzq1waZ/JAv9hHJ7sZbSZnqev/dbon
         Dtc9/iylF24oA3DIsUx1Uay8rdVWYntH37Jh6rfy49bQimpFlfdF97zHN/QskWOndhAK
         zkn2+gg3ocZk8IK4wv7rkAgDyJ5viNBIGDyELniU3ig2vY9rWNlKk/AYB6iFTgMiFNYt
         i6sPS93KriBLenvcK4q8DhGV20TNJOL6ivzPwxFWxITGr0iao9vyizOeIH2RojLt6jFa
         OfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIeITM9kgLLHT84uz5AlkReJfCZwktORckILgB9CiAVYGQTMZOYkDrdxrr1cEV3RaKdmhBXDG2TQLAWsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HhQ1bVdgsNVQXGkYbPRWUAHheSsvDlUOqF9o7wxahk9BsRod
	l5uf1VEmV7Ti12Z7Rqigrts3TRDNDYy9ozBykBO94Y+g2PrYFxWrEsnBwegc8Iuf7OMfo+8CIZk
	OabO3
X-Gm-Gg: ASbGncvJDin2IZwwfP3uYG6j7hWiR4JPArBAhamiMyScmmfO+6yIAE7zEVYzxg+wbF0
	wd/4IDn3ulK1ekHBVRud58OhGDwT7deNo0Gf21oLvLmDbopLLSG2b/P3f8YxceVQ2xafakjHHGW
	l10ndh3r0bO6QeRqknG3mz9qVziFxIB3QHAthKkbQXE4ujE+NBVxJReX/E5mbYzW9I/s8E5j7LD
	Z6Sw0UYHHNw7pmhns67vhgd7AFZzXMbDwVGFkQ6DP3bocy+XSaBz6Qh5rnPU8KHteLkdsAVVnY+
	boP8vNhQhA7nKZ9AIlyAluYYtwhJT+Z5VKQVgjrb4o/MocI6P0A8gIQfpOdkXGIGdxfEAlLS0Tw
	WhFbsFmbhtHHQ8E/pMkESoFB4mhoxQGwBjho4OJTu95nyzo3z50PBM9UoNtTUxMPgT9GuBD7bKq
	1r7CkhdA==
X-Google-Smtp-Source: AGHT+IFlPf+i5rM3V2aPth3/QorfaAiBmBO6+U2yQMIYWYZnD3lbKAlJhKzYMQ1lM3lkudsWOGqQEg==
X-Received: by 2002:a05:600c:3b03:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-47117906a72mr140545185e9.26.1761117951513;
        Wed, 22 Oct 2025 00:25:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428a534sm33459415e9.6.2025.10.22.00.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:25:51 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:25:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ally Heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] checkpatch: add uninitialized pointer with __free
 attribute check
Message-ID: <aPiG_F5EBQUjZqsl@stanley.mountain>
References: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-aheev-checkpatch-uninitialized-free-v1-1-18fb01bc6a7a@gmail.com>

I made a list of the warnings this generates (on Monday's linux-next).

None of the warnings are real bugs.  Every single one of these has the
assignment as the first statement after the declaration block.  We have
had bugs because of this before but Smatch and (I think) Clang detect
them so they don't last for long.

regards,
dan carpenter

arch/powerpc/platforms/82xx/km82xx.c:30:
crypto/asymmetric_keys/x509_cert_parser.c:63:
crypto/asymmetric_keys/x509_public_key.c:151:
drivers/firmware/arm_scmi/shmem.c:199:
drivers/net/ethernet/intel/ice/ice_flow.c:1576:
drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1015:
drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:
drivers/net/wireless/intel/iwlwifi/fw/uefi.c:821:
drivers/net/wireless/intel/iwlwifi/mld/d3.c:1788:
drivers/opp/core.c:1413:
drivers/opp/core.c:1480:
drivers/opp/core.c:1797:
drivers/opp/core.c:1888:
drivers/opp/core.c:2874:
drivers/opp/core.c:2935:
drivers/opp/core.c:2989:
drivers/opp/core.c:3065:
drivers/opp/core.c:3085:
drivers/opp/core.c:3104:
drivers/opp/core.c:312:
drivers/opp/core.c:330:
drivers/opp/core.c:412:
drivers/opp/core.c:450:
drivers/opp/core.c:608:
drivers/opp/cpu.c:157:
drivers/opp/cpu.c:204:
drivers/opp/cpu.c:59:
drivers/opp/of.c:1272:
drivers/opp/of.c:1331:
drivers/opp/of.c:1428:
drivers/opp/of.c:1469:
drivers/opp/of.c:149:
drivers/opp/of.c:1505:
drivers/opp/of.c:174:
drivers/opp/of.c:276:
drivers/opp/of.c:352:
drivers/opp/of.c:409:
drivers/opp/of.c:48:
drivers/opp/of.c:98:
drivers/scsi/scsi_debug.c:2964:
drivers/tee/qcomtee/call.c:648:
fs/overlayfs/params.c:451:

