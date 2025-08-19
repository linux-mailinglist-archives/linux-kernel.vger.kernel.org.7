Return-Path: <linux-kernel+bounces-776337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD130B2CC20
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E3B568685
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25324DD00;
	Tue, 19 Aug 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj7pM/Yy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19332248868;
	Tue, 19 Aug 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628413; cv=none; b=Z3O7XpZbQ2UCc5VP3JTsc4C1797A4j+drMBinZb3oyqfRzYQcgyT+lHtFHxysDPlrsciGIJUVrD7ajYKJ6J1DI/peZqVr0787zUf+J0Vm7PlwhNO+z3xr7xcnhwog5/uKRamBxg4MsIXoTI9vvDOXOY4OBM/TPc/DJ99rvCEMEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628413; c=relaxed/simple;
	bh=o+zceiVuOcpZLkpqo8KMD2GruuNiZUPXZGqCGuB2Tl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMghWuABXWA8Em2jrM9yPIssuZJea62BRJUmqrMzWuC+ro2y4Dth09N5GCBnbeE1I6OyGhMClsCQGwrT+SIfMSkKJo1fxr5HqZcgsjef15rv3hqMISdQvRCP4b6LIY81un25DrN7HYJ/w4GDlqbfmq6zGY25fH32nNt2fVw/vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj7pM/Yy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso797551666b.1;
        Tue, 19 Aug 2025 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755628410; x=1756233210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+zceiVuOcpZLkpqo8KMD2GruuNiZUPXZGqCGuB2Tl4=;
        b=cj7pM/YyT0otSdtkrDlQ48eoFqHsuT0QOPQfIomSwAIcI+4KBFLFex6P0gu+UslJNh
         NxbzUJF4kyUChgT6TOMwj47QxhOOpSfIs2v/0RgVsysnif3Nfzu3HfkAr33qj5h2dYs8
         nNcqCR7HIy7JzT8IcpWdfUKXgEkNndgk6BanFgz38miyB5I5ZH8YhrZh9I65T0sg4+zo
         sIyBenoC/Zl7ylqcSHmmxzmZCstww5N1UszwdTSvAlLJ9zsm/hVNYvs8DMhB5UDvU+pU
         9+d9vnbLCA60x4bvWIYzE/9TqE4yxbftj4R3oOaWH2+P0Cp8Hbp4ITIdxG1rs0ImMNir
         lKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628410; x=1756233210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+zceiVuOcpZLkpqo8KMD2GruuNiZUPXZGqCGuB2Tl4=;
        b=wrlJw1dV4/09/NPd+8IcLFhbVNc9NW8DYymvtMp4cBxLsfY0OBJOsv3tPHhcJX8d4Y
         V5rkNssQEnBBLsLbaWcKL+0zw6Pz4kulyf/ua1DBXpb4uEY/degInEwaBUg4BWx7q42W
         s0VikNhVZFXT2WQm6ss4yuWXOpV+pkJuLBh9RdTHFp2het3vPliGfrjfuAsszIuGinfe
         UcDeEynCPArGpZlgDwnQJTXuY2YB7tMlU0S3xGPO9aVWSXs2+mB+NBW4hmzKh3TtKcRk
         xk4eDBHe1zxF+yOYf4wvtRRC5nZyhwbvXvY2Q7QMy3PxwQamFKZnaN6Zxv+hQ9KiY8yq
         0QdA==
X-Forwarded-Encrypted: i=1; AJvYcCUGh9gxrwAATMDs2UFU1nYWrokVOlnqvsH4lGJDoCgfcUa4bzvSowEUOiPtX7ueDAWagHIszulPczqhuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKXJx/Ba9NQ0qGnSMLNoN5/y+tY7Babm5X/Nd6s9OGoCachVw
	zc8Ab4lD3ifBl9Y/ZgVl4W1tIeIUQFG7sw6/30Gv9YWdN68NblZHMzG/
X-Gm-Gg: ASbGncuid8yjXVxnV70XNncRCW79cUgbN7+cxw9wcFd7dR8m9YtO1BUgX850GHcUmeU
	UZKMc9PyeH6DV9GJVwaVb5hv+eh9TSrP9pHuJUnr4vJoij3baYE1DwMF0CN5TOxhzaz7DOa3Nam
	I4ca1BtJpie3Mm3o+8MOkfbKVofkTWbk8gT8SWHi8/DhIOaM7iQ5r7/2YnxwTJvQ6bavzqPs5uY
	lthVaPqCk/5bG+GB7Nz2byDRofSGwKL+gCh3SFaoKAemqoadMnzaRz59WWoqMVQTtddT06HzL0+
	2+XcVtspt/63Q7N+12T/pFe4skTmR8VZjajxqm1HwmNfOYiQChzOB7IEuWVz40AIXskPaXMFkHu
	6Ni/jaaE6gWASrS73J/w3VNTku+W4CQ+I5wXb36Tqls+BTw1+TH3G0/CEtmr7TBq94OqKjETx
X-Google-Smtp-Source: AGHT+IGd1J4aQrF6M5pIE/VXoFf54QZlBM+/RWFzGlkHn7ZXoyPKY2KSfPCqq2dVGUparC5olACeQg==
X-Received: by 2002:a17:907:9486:b0:af9:8c20:145b with SMTP id a640c23a62f3a-afddc96119cmr368044866b.10.1755628410245;
        Tue, 19 Aug 2025 11:33:30 -0700 (PDT)
Received: from cachyos-x8664 (93-87-121-239.dynamic.isp.telekom.rs. [93.87.121.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded3020e4sm28606566b.37.2025.08.19.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:33:29 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: dan.carpenter@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	lkp@intel.com,
	perex@perex.cz,
	ramiserifpersia@gmail.com,
	sfr@canb.auug.org.au,
	tiwai@suse.com
Subject: Re: [PATCH] ALSA: usb-audio: usx2y: Fix null-deref in tascam_midi_in_urb_complete()
Date: Tue, 19 Aug 2025 20:33:28 +0200
Message-ID: <20250819183328.6228-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aKS-B6O8ZEAN_X7x@stanley.mountain>
References: <aKS-B6O8ZEAN_X7x@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dan,

Thanks for the review and for spotting these issues. You are correct.

I'll send a v2 shortly that addresses these points.

Thanks,
Šerif

