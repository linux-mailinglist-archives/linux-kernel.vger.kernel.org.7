Return-Path: <linux-kernel+bounces-729300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73487B03498
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB973B5D09
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B121DE2D8;
	Mon, 14 Jul 2025 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QJPqD/lS"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86618D656
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752461083; cv=none; b=oWynVX58JlLuSB7v+OkYyi/btHxWYh3jS434OeJgO99dPok40qtQFlU6RyKOvR9+192uMSUGpj5B5pFuetb0sQJiNK7u8M+IpARWYLvLB9ZSx7E0nxMPnlsgDO2na+6Q6rNg7NA5Pll2M3BmjeC056BJ4998gnW9JfNZ5c5iWQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752461083; c=relaxed/simple;
	bh=woqpO3NRbjhHBU4xUE1MFG1XPmmi0HP0qmLRNxoUwpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiIkhNKwuSlYlL5svijKawCsTYn9cXb7Tk4SIXEY6oJXlRx8K1kpMZ0sZSGbj68KBTH65IzJmIH33NEljiR0lXPBrFb8qd1JxRtUxG/9LWoEj0gp3oqG5LEtl6LyrYjENtLjCd75yGO2XLrg37qknTlE+Fq2f9LTweP6b8Xz1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QJPqD/lS; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8a5053c2so36012265ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 19:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752461081; x=1753065881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGnDLyzoK1hk6QcZEHX4yplSrEzwZbOUE/lD+OVxxOo=;
        b=QJPqD/lSzuaCQxFW6bVir/fstzj/7y39TTmNX7Zkh03BiE2mUquJDD3ZEOMb+uuNBU
         HnRlSzDiTiBudOPZdP4Nn2ke8f1sSeYT296S28EzeodATLrlDcjc/MncsQSEcr0oJwvH
         f8Lkqih7H37AUaYwPFuTwnmLKx5kavXJqcDnmClb5ex6msiHzPOkzFBKBffrYnkafB93
         0odF8UXAXvYw7IBfxSFBx1I5jAaIoDvKaUMG5d3VMwh0fZ3G4SJwg3BSY9LagKsn6eCa
         ct6UCvXfrRkoyQNcmgPf/yezWj7W/sUD/2Wk63+l7KH+nVAzR63Am0QbJX/MRdAfZBUA
         P8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752461081; x=1753065881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGnDLyzoK1hk6QcZEHX4yplSrEzwZbOUE/lD+OVxxOo=;
        b=W2F5y8biN7FwjGIojU9lvG6T+oZBHMpwWXFjDCfbhi+Uq3GOfFbthGyn0Z8FL4MaAQ
         b2tTnXUEiW9XDzPyNVcPsiITdWCo4PyO13PfaBuvZDrUGOd8g8jsAHFZ7Aeq9g6141pG
         a9wJyRU4sLWRSwPmMOwTr+LbVyt8i10KhFHzmZqPlfTAJaJLsKsrNCVyTBWTT60cGPBK
         1wjlpOh+9Lgj4+M6qpKFJ6i/mnUsobeTPxzJGZKTYWUbb/955MQnavmBvWHf+IIiwXsO
         ZBGdNqO8b3CyMrKM/LA4Sq+sq8c7snY2gIMzkUhV4/dNtFTXqOBGrfSXSfqlN64cLQkm
         FxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVowzfMB6L91ahml2JgZKjVwjySgwtVJG8796V34w6iTgtf5D9UyReUOUkGvItx+X/GV+jq4glMi83XKWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pjmXcVkgu95ko0x6YF+78aryA22fbwfFiUvv+Ik1mTE91rcr
	/ZoR+C+gwR7Qj8Kuw9tfoNmV86SjnUGLbnIh+X2DYC/0JxcZgxqtXAGryxhDHi0rBg8=
X-Gm-Gg: ASbGncvb13ZM0lBymeNRrQPSdqfGQXxxM3YTBJ0skCyjqFtMqd4/GIB6FOzIP1txRlJ
	hiqDly7g+6jL1Bb/MdoK9wOpaewG9wbmKYQricr6GhOGgQk21bOdK5linKLClEDNmcmf+CQRd7l
	lxzZos/Sif5UXiuhGOx4sIdftOpB9dHg1dGBE5L3UMT6SSW1oQeRI249Wh7AU6r0eDP0gn1+9rt
	MyyX7Rr7NN2d5Vl+fc5mJAB3RrDidyyRQshXZTHuK19yFIIUPmkxysRuG1Abugeh91uFxB16aEu
	oMkg+OyaoEnmoTXEVuYjfP7V1NiJ+0XLj5mOkjbp4j/ya5o8n0D+REBAFg1gcC1VvFT3/zed+NQ
	QaeL/tlMTo8TzFZc5CksmhnkGgH+Ub24hy4R79eqwpfDgl8ghBg==
X-Google-Smtp-Source: AGHT+IG2a3ZcNn/X49Q30mvFsGR46F/NachCN13vl0w9s5ICMWR61xTnTwucl1IEoa++sqdOjScs+w==
X-Received: by 2002:a17:902:f70d:b0:234:a139:1206 with SMTP id d9443c01a7336-23df093ca68mr146385185ad.40.1752461080974;
        Sun, 13 Jul 2025 19:44:40 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323daesm82683445ad.139.2025.07.13.19.44.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Jul 2025 19:44:40 -0700 (PDT)
From: lizhe.67@bytedance.com
To: alex.williamson@redhat.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	jgg@ziepe.ca,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lizhe.67@bytedance.com,
	peterx@redhat.com
Subject: Re: [PATCH v4 2/5] vfio/type1: optimize vfio_pin_pages_remote()
Date: Mon, 14 Jul 2025 10:44:33 +0800
Message-ID: <20250714024433.14441-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250711153523.42d68ec0.alex.williamson@redhat.com>
References: <20250711153523.42d68ec0.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Jul 2025 15:35:23 -0600, alex.williamson@redhat.com wrote:
 
> > +			if (acct_pages) {
> >  				if (!dma->lock_cap &&
> > -				    mm->locked_vm + lock_acct + 1 > limit) {
> > +				     mm->locked_vm + lock_acct + acct_pages > limit) {
> 
> Don't resend, I'll fix on commit, but there's still a gratuitous
> difference in leading white space from the original. Otherwise the
> series looks good to me

The leading-white-space indentation was adjusted in accordance with
David's suggestion[1]. It seems to me that either approach is acceptable.

Thank you for your review.

Thanks,
Zhe

[1]: https://lore.kernel.org/all/9d74e93d-5a5f-4ffa-91fa-eb2061080f94@redhat.com/

