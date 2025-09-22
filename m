Return-Path: <linux-kernel+bounces-827311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AD4B91680
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415A418983F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FB2309EFB;
	Mon, 22 Sep 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ03RKiu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0751CAB3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758547874; cv=none; b=iY9kN+wntXydYHwcnBL9XyGm2qcMxOnzj93mpYJxdBpV0FyFGm8N2LPmK9qCrO2IfzxlGJWK0rPA5f0rXyAznwgE9uGCdRpI6NVx8STx16jdMkwKwmRe44KwsjIVp94G8lF9XlxkFmbJjj0imAtlqkRyQ5CR6YqouNI2AfWLo1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758547874; c=relaxed/simple;
	bh=9U9Oq0mZV2UmPfUWr510i+RGShVlmBrXJe+uht1I9m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3YoezSCFtLfInZXmZXnvrPAi3LKTlIm1qpM79950r3Y50e8BPsLX2D0Cd7Oj+yDYl2sr3oSv7rxxhBf3L4NMu9kTBtD/dy+jFV+bH+0WSaXCrxddEGUIOpx/wL8wqSxeyz37jB9aHEHN/2PBtMgTFPaML2O5HGMxdLDz7Hfy1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ03RKiu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2445805aa2eso44662615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758547872; x=1759152672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOZ+3sPJjHhme5/KGeK2VfF1vjlB7AEmx0hb+K9u3c4=;
        b=LZ03RKiu1MvI6rBhHagcvMADWN5KMvpEBDVt8zPPbBICM49t9UIILIXfb4qBdyvwXL
         KBp894+VLjC5UqjTqKEeJm+osNgnv0NlYREYHvHyZ3no5XHTp+jEjKmDVRNQarSNhXG0
         DsvkEMGHTr827V1YAnImWwXSiAdfuTGVC6mXB3D0zUzMBybAGLd2YPYtvtcvoqvSIGY3
         8n9qncJ0Xm3WAOOJueFCsLkcd6+3WPir0FAywZnjug1H89WsxmPeTsm7rMQ8esywcMe6
         LULbUidNrhH68mBB5FflEiqe9RslxXj3wa/s9c8MBfvvzXW3f2Lq2BD+h3k4przP09T0
         xdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758547872; x=1759152672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOZ+3sPJjHhme5/KGeK2VfF1vjlB7AEmx0hb+K9u3c4=;
        b=udGhzNrciKYa0R6oMBflwfx/+mDWrhS/meISu1j1YxxT7bPWlVotMV7NhbmmjiaIGh
         AdU4wAzMpSxxSMcdz1bt6LkOWnKAahC9FrXm75q3ni4pFO++9RgySdSYxe/zd/3fc25M
         bRxpTwss41v/AgmKJvhUKG/p+2Cecy3lI1mLNgbjPcFoTQRhGSfp5pgXx+Zj4nQFfmvI
         saYRwdBx8IrAejJNVQuPEHfjUGsKdA4fZQPIigGnOGbrHKEM2xZsEy1+mMNFm0gDy9oC
         vTBgkCai8hgO/9qANd7qxU/t5iDE0Eg/6w3LFVeN4dP9MLTgOZ3LrHsOsd53vkiq6/Ie
         J4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTsAKiQgdbT1MW+oz/szVYhl8OjfnbfVzanrPfQbbkoZs1W3sqf5gG4sz6NeWi8njTjoDMZS1O9GR2MvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ObbRaEkT578gBra4zPQtQ3KsMtImrlu5ZTQxgn4hgMSBrR0Y
	fQtUWvQ/lO8r3Tpn+9nPb6U3e2+kxx6mT/b/gzYXMSTYrOTYzsLmx+3q
X-Gm-Gg: ASbGncuJG/OOSv4Fib+Ypzeuy6oiEHgfcoSTDojeQK0j5tBRfjZ7qjEnxGQ96id7ukI
	m6acKv50Cidkn/a0CRIdGeff2HZMQ7dwQ5NkqfJxGkwQ9hHwFKmrOnG+/UK2dZiUzgldxCygFl5
	NeygQ2UEf46jvsPTsRyci0nL459qjUp7ghbxbRV4WCVBxIY/+sDr3LS6vSsL8hfymEm5LYVS5Pg
	qIgOiQgvoUL4Lheka5srDALMihXwswaJrlVdiCsEjkeJs8yqT+NiOb0kUI8ZJE1xxNXLHhfzCIr
	fbgRwd3GBYKeO2ZLS/yO0lNPzM2ESH9izPzFFR79iJabRktdippiR06i+DAxFq/3bzchpBWkhCL
	6EROAW/lavRPAyE2JyvwZqLjo7eY0Fwg7K66W4E6VlQ==
X-Google-Smtp-Source: AGHT+IFlTjUjT9pWpL0XES6XJeOQp9klXOqCDduhPdWixXuTgA5G1oF5J1nVDUpvKjADmsMp/r83wg==
X-Received: by 2002:a17:903:11d2:b0:268:cc5:5e4e with SMTP id d9443c01a7336-269ba3f5f96mr161584175ad.1.1758547872057;
        Mon, 22 Sep 2025 06:31:12 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c959sm134572465ad.48.2025.09.22.06.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:31:11 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: vigneshr@ti.com
Cc: david.hunter.linux@gmail.com,
	krishnagopi487@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] mtd: cfi: use struct_size() helper for cfiq allocation
Date: Mon, 22 Sep 2025 19:01:06 +0530
Message-ID: <20250922133106.2524-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e79d5220-2824-4cd2-8e61-b1da8d22d2a1@ti.com>
References: <e79d5220-2824-4cd2-8e61-b1da8d22d2a1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vignesh, Thanks for the review.

Regarding the other occurrence you pointed out in jedec_probe.c, after your
reply, someone (Rahul Kumar) submitted a patch addressing that occurence
in jedec_probe.c. 

link: https://lore.kernel.org/linux-kernel-mentees/20250922071137.900508-1-rk0006818@gmail.com/T/#u

Please let me know if any further changes are needed on my side.

