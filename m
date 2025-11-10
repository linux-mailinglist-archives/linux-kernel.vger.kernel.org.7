Return-Path: <linux-kernel+bounces-892839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25950C45EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F53B3A5C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21E30DD3B;
	Mon, 10 Nov 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKzAInx1"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3B430DD0B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770335; cv=none; b=Cjzv9aZZqYx8kLRi9iEiqY0sBPjS3zN1M/hRJ8j4aPFBzTIfSDINNj2V6nkks0RbRsJzfHmHwlhpNGDgVgh8hlMAirY1adrSecpIcT6AjBZ8eHukz9OnC7jHMuRbG7gYT5Eamx+8dXH75SsZ8QcQ3BUh9L3NcVek0k6zFoqvIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770335; c=relaxed/simple;
	bh=gPYWZCrFWH5A95MUItopTio1Dv+bF3Yimo8m+Fu0LPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukfgiM7OVrgWltBNk3IZObRhF9fGzxLr7UTsPvKjd6Krib1QCVB8AuvnLgdNehGK+K557JM7dyunMwOBqpaoNugQuTlbrO+XdOEN5stBzqvRp36sRGnhJ65BJFazhRsF5RkzqL0ECFE7xa3CT4eTqaDq57os5EpwveNreVGN4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKzAInx1; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso13963565e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770331; x=1763375131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDWEaabtponRDh5izzcawYcKRcbqPl2YaKoP5YJjm8U=;
        b=kKzAInx1BERRwvXMlNV3q7PIasDrwvKrbC3+gYr74JV3RyBmjbq7DH1l7g8WNDWdvl
         w7p0P23zvVIjF/emeGViLPqlDWndI6loG/C/OUNLht0xDJdYvX+J6fvOtoOj/UQP0Mam
         Z6rpSH4aDcR/V4N3WCECR250nT249LH+dJp5JBQLbfTcjl6bIYKC+DK62zGkqUPbz0Sv
         Ds8Gu2AHXpb2l/U9lMxsp1RHJnr/jFpJtgtSI8ux1q5sAxMrIiz1EJMKo/E0FG+P2iqW
         iEQOszMKgGHvQUvQvEkJTGmQDnPfxjQmub3ootoF8cf6zM0rEpkT4nDZe+PBao7IFo8z
         Cg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770331; x=1763375131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDWEaabtponRDh5izzcawYcKRcbqPl2YaKoP5YJjm8U=;
        b=gtatf9A/0STRrJcGcZJCd2vbplGo/K9qdB9RpnR6qV6u20TXyLN7OuO0qG9OsB5Whn
         /SzDTEujvBK4KHZThJrLCxXJdDNpOIJvPM6zsZxFPj4KvNMqubBIi04PkFME9U5Vnqd8
         hVx82XLf5nAYdaZELaFmSIVLFf7jKRmLsYVT8em38cSdiJIXhwvBd5iPjw/zKDVWoM06
         X6ZJ7AVH0l6ME9X6fvL6UqNDab6qKtQ6miN0IWWbbKgPqrkLE6eBsHCkMJTPVEuaftJ0
         85dHQNUwpEWftT+HX/aFeC7V5LL3oYRAkD02MMR6v2i0I4Vm9rZ+1uNOxavtCH/i/W0M
         6ihA==
X-Forwarded-Encrypted: i=1; AJvYcCVttAbTBCpf2i03v7AOYKtVNMenWpG6oom4zhxmU+adJX+msTeCWjo7wbbAl9C07tKFTUDzxdoX+3kfj6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws94QkFV8VBXpvNKn1YpZtTKsVlfwfBoahqAoZq0LMArsAp6BS
	Nukk0Cs0qqPEaUsXm/Dr7p0WkVNOKzbY/Mvxn5LO4+akUc+HiiODI3Dl
X-Gm-Gg: ASbGncswmONdw2/lxNJvcehBg5m2GGqocg8ZkWrx95MOxww7OvLAMmjyLmAP0veUaZ8
	YNP6/PhtdHkZmQ7VaSuEDqJFOpEzyHRhOC+p+tmlDvtuqVaIppgceYpFeG7oDfiOWJcTXVovhVs
	fZRiu9kHqMBLEVxLt3jyJI2nXFIavwIVr3tKpAcZu2f0XLPBXKeU4ZAvAJw5nQlo49RgCbGt3hQ
	EiSL25xPP+bJbGbc1mFV/ZOkRcoNfDcIJwqW3UiF9cKXQaA2vvgXh9j7Q9WyajMfFwSH7IxG2PD
	/q7TfhzE6OiKOlZcjzu1HSAb6PWQDPEKHWGLeSdKYrVT4LA7F2/szs73COOksECzfiAm6gnz5wN
	A/T6GQ7kv1B0NEb4SMfGj8AiP1NHAy7uF/RKGrIFVamsN6moEuajZP+3XQ1Og+mugo1T+g/bShY
	LGF+EQHvSy6wTDf+0Z
X-Google-Smtp-Source: AGHT+IHawc3zpPw1mww5Jy+6xxmUpYQPVhoTye5mvT5aqx9FHprZ00gpbNG1v/9TjsKc7wIYslUeXA==
X-Received: by 2002:a05:600c:68d7:b0:477:75eb:a643 with SMTP id 5b1f17b1804b1-47775ebadcbmr50548365e9.4.1762770331236;
        Mon, 10 Nov 2025 02:25:31 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:31 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 08/11] uapi: linux: Add common gpib interface headers
Date: Mon, 10 Nov 2025 11:25:04 +0100
Message-ID: <20251110102507.1445-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpib user space library needs these include files in order
to communicate with the drivers. Copies of these includes were
previously used to build the user space library. Post destaging
they can use the includes from the kernel headers.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h       | 0
 {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib.h (100%)
 rename {drivers/staging/gpib/uapi => include/uapi/linux}/gpib_ioctl.h (100%)

diff --git a/drivers/staging/gpib/uapi/gpib.h b/include/uapi/linux/gpib.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib.h
rename to include/uapi/linux/gpib.h
diff --git a/drivers/staging/gpib/uapi/gpib_ioctl.h b/include/uapi/linux/gpib_ioctl.h
similarity index 100%
rename from drivers/staging/gpib/uapi/gpib_ioctl.h
rename to include/uapi/linux/gpib_ioctl.h
-- 
2.51.2


