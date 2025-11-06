Return-Path: <linux-kernel+bounces-889260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ABCC3D17A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4983A5100
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D77934DCC0;
	Thu,  6 Nov 2025 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMsPdwdw"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ABB2F4A04
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454536; cv=none; b=ubJq9jTGXrwP7BSFnTAcT8xbHvIpgSWbVhNeqvvFpj23wGhDXEB28o72jHFB15jycJVSCXdLq3+ixoAlnPoFSleibhY3c9w9KMFu3c3796h4TzUIrUQSbPdZVaW6v2OppC57Zakfd2e/iYKBszXb9Dqdu64CxTd511es/9Revks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454536; c=relaxed/simple;
	bh=FKuQXbpNdmu7125LPLQYFDj76PrmpfPzH8vQG6hTqh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDbTt+MkcfWiRaDJQGHskTjn6K7GpcCXAaW6q+voWQbn1plDOzbsTzHL1mmr2Ug/iOapEnZCS/YTOd9T7ILOVBoCZzOsZ3N0q+xea/G6+VJBCss4i3JUQn7jsS6i98T8XOxCmK5ufhXeFrwyqXfIHxbwGhT052t4Wf3UWuz7Po8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMsPdwdw; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fbbad0ac3so1261902d50.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454533; x=1763059333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FIkj9b+mixj5Rm823k0FAzL9RiM2lOllkS3tk8IaM0=;
        b=nMsPdwdwqoZ9mDbgI/kNRKOuiBovm5NYEWhQa6k76NIW4qp+QcWzSYiZFKbLjq5dM5
         7Wh6CV4ph5kRNGXitibwWyCP0G3nqmsd231tN6j6jbj/J+2VNNvAIfcmdrUGAIrJSF4A
         spMJft9pjzBbMzFFmz+rVgRWQ1hvyIPHVuk7aeTCav+LUPZSxQqIDIDQ0gAf8XPoSHK+
         uAbSJWXJy3RR18ytokBBTCjdGClVI+TS2r6j/iJ/HXYLub2Pc0oOM4BIsPYrdFscvBZk
         ZsCJ8a6BIwefLGUH2lNszWYleR3nJ6oFL4ehGa1j63Bl72efKynzffIT8UmE0vrJSOL9
         NgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454533; x=1763059333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FIkj9b+mixj5Rm823k0FAzL9RiM2lOllkS3tk8IaM0=;
        b=FcXsdhMMBjzf4KOw500/bQkJ+qlnUP3tD1Q/ms9OhRQwe+Q25C3jPPhjHh/wzvbpYU
         +C30tCQtGRcNfkR7iFYU7VJcqK6LD4QR1ejkJsWxoZrUh8Lch4wM3rPJ5VP+KPPIREzb
         8aL38EmszC26W6Ycd11YCUR0TgZqQQgzrrAq3r2FnFU3p1pBLb4EFRdxc32VzIMByiG8
         obSA1F80MGRTaGYgdJiRvVl3hlKqNytqR1ax/rLIpZgmDUPY9KW2N98gLfnp/XBmUFad
         VlvjsqJ+zI1rjgRndRRKeozr1D+3st9lm0e2lpq6XTnoPE5wDqXztvWNJzAp8I5ztzpK
         h4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUC7dFD+eiYLTeXfAPWZcDlXqLwTX20vCizj+YQFT5irVXZBTNkqptXpfQyrz9qPPYavId0fH6qTM9ZqUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxO0y00GPxSCdsl9wy6+5MEKujU+cMaS4HFt5SXPCCjZAF3Yc
	Xe83zdeKiVYsD7lLcMK2YlpiWe0M0zh5th85TnRK3E2VbplrWbwmiQyeW/ePKM2SPFdfCJngIk3
	L3CwQ3a5a8bTT6/TYm3156JH3wChXy3w=
X-Gm-Gg: ASbGncvmojLCxHpBsfzlgrI/KPx+LCzMuURnRQKixAEj0CA57WFld56M/GxjKa8ibiS
	sEJCaUjammxf73IeWm2h+E582g4AYplJUq5JndZudsywXPpRW4tYCtDpSAKpeZd5aoS8vaQqo4p
	iJHxJ8anq5yY5YycmIaJjYaJmXTUHHWqqZZ58ihXAbgDVL1wE4mxO8kE7ZYkr1UlgCWxXSsEcxg
	l6ahVwKUcjs7knt2HDskdyxCLr8YkaGGtBNZKstqC5VP7h+mOPRzquOYYpwkA3/wcWMgX8V
X-Google-Smtp-Source: AGHT+IElVNhW0M3PjCH+PkYBjIXR+99AQZBInQ6KD2TmAz+A/SchLSZlk+h5L9aFTawIceMky+lJCga4v9uIkZCCVWs=
X-Received: by 2002:a05:690e:419a:b0:63f:aa5b:bce1 with SMTP id
 956f58d0204a3-640c444de3emr325438d50.39.1762454532744; Thu, 06 Nov 2025
 10:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org> <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
In-Reply-To: <CABPRKS9aLHfaiTH6YSa6E3d5gQab-tUEmPYbr59X-ybg1p5ErQ@mail.gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Thu, 6 Nov 2025 10:41:36 -0800
X-Gm-Features: AWmQ_bnLCiQ3MQsUo2WmF_ON4-aDlzJE-K4Fh-EBv0St_rNCfVThKj3v4IS0qig
Message-ID: <CABPRKS8K8zfkbbVZYYxrLYPgAD+nhmrknkpA+57wc5TTAKwz1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] nvme-fc: fix blktests nvme/041
To: Daniel Wagner <wagi@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Justin Tee <justin.tee@broadcom.com>, paul.ely@broadcom.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

Taking a different approach than this patch set, may we see if the
following singular patch resolves the nvme/041 blktest?

[PATCH 1/1] nvme-fabrics: add ENOKEY to no retry criteria for
authentication failures

With authentication, in addition to EKEYREJECTED there is also no point in
retrying reconnects when status is ENOKEY.  Thus, add -ENOKEY as another
criteria to determine when to stop retries.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d4d6d8e88c4..fb7765bf0cdf 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -594,7 +594,7 @@ bool nvmf_should_reconnect(struct nvme_ctrl *ctrl,
int status)
        if (status > 0 && (status & NVME_STATUS_DNR))
                return false;

-       if (status == -EKEYREJECTED)
+       if (status == -EKEYREJECTED || status == -ENOKEY)
                return false;

        if (ctrl->opts->max_reconnects == -1 ||
--
2.38.0

Regards,
Justin

