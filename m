Return-Path: <linux-kernel+bounces-738106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC064B0B450
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39701897840
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9C21E285A;
	Sun, 20 Jul 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INAEW+sI"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E101019644B
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001092; cv=none; b=e7aocDZ9vJULPVwsdKA4VU8SKBVLbi1hZsmF3+VvHEr8lNrl2MSwFSDOsn++SOC/LgQKdUFHEJ2dDOq6keKXF9zzNavkRrRq2EkApf/aVpUCfzQPivfrAgAj65gob9SMS0JmhNuYCVKj61lmjwaREM6e+sWZ5vPdhv97DBmRZ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001092; c=relaxed/simple;
	bh=UKNgJZREfFSehHVmGWlScbZTYhwHo9TCUqfy3LGsfEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmVP7DFWtgTuxaP4f+hX72+Otd/4jo1PfOwfVVQ7DVHsqoOqujcLyBau0momPIO0XWVDA7hxjseNTIMUDtZ4fuE3n/3qcp6O7SR14XOWryCTsYpOJ2nCNRpu5kN6U8YlqsqHcFWiHQtNqfsUfXVVyp2CPbE9qZvR+CBmulvTfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INAEW+sI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad3400ea3so32517216d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753001090; x=1753605890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKNgJZREfFSehHVmGWlScbZTYhwHo9TCUqfy3LGsfEI=;
        b=INAEW+sIm1EY5jXwmC/ycvz4esPSJ2/VUhl8d7m1lA7EdxhnxSBQQMMmgjH14RtNCt
         S/NmBLFWhW/h9+eKNoxBXN42FAWGbjc8glqoLXhdn5rW7MU7vt5SSUcDXV38JHozNrQ3
         YXBynRhE2rlsiLevRvuTie9b8ACTr+AXGYtkQJ/SQ6x/TMAo98lsFLmP4MLqZ8b6EZEl
         +Og9YDyjLLnd5e32QBDY6XIfE4wDVwh/0+aeuWf6pT07bwDk9TzsLeojFp7dphcblsnE
         UdqCXTUPPktWsy0Rad3KNizPqXNDatOG8sdupDTnpyQcIiHTwekwKNmNfNdA7kT10QS6
         uEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753001090; x=1753605890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKNgJZREfFSehHVmGWlScbZTYhwHo9TCUqfy3LGsfEI=;
        b=akEczExmXr0Ko3KmEiKFN9IJTslfSK3jWezJ+tyUlizoSFsQXx6hU///BZ70+oHfY2
         gxOTMGtQTFx9cYiiFsKnHHft6vMoXF4UUbz0b6kftqA8S0IxpjNOeIGD8nOgYAwPqZoT
         1fSPJi5AtsorLaS0sFtgbTkSXsGoI8GxQhiBOaYlWfUsfrqyV9vRjKwRYdLlzeth1ddg
         onx+oKsQkc6+piQNO4PJhUlNS0P0oA5p4v/0W9T/UR/g1naR6T413of99NBjpzpOwFhu
         iSoYG9yPBcf1Am4K4l+sFRDR5b58mYOoyXzUOq0CHaHjITkaG4MYtNJC85z5zJNpRQkF
         GQQA==
X-Forwarded-Encrypted: i=1; AJvYcCX07fMqGpTQ/jxU2w5lVLcvcUFWhLKchEIxVGI6FYFsld8VvZ2CUTfGieOr5VKjNDx5FDoggXnOTJx9Csc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHXRRWf0ZJIlbsduH2Bspze8OO16OHazLpclX8f8n8PhWjRb6
	cEwVCpPn9SrR7OC9EFmYPLNjGhSms/Q6Kcowu7f6Dg7EbnICNHrQJ1nt8Nq8LkCl
X-Gm-Gg: ASbGncurZwRYlCgVgbNY7fortbsj753zm+FlGqGn1qHQDQmzM52gY3Btj0jS3kkJ6+S
	IiXJK9YTn8pjRhqhLJKUs4CKzXB3riR3O++T+NSVVM1i3v+ZHl6EKDUIS3iri4YOCzGxrSp1yEp
	s9MS969RKT7NPaHpWN+iHV0au6IyRZklbYhmyfUChXexdpZ1GFjakhUkkS7IUzUN4gncXYE/io6
	41v7XummNCZS2n3XCMD1s6kK9EuVsXnNRzfKGICPapjD7Y5MVfVlqWEdCJqS+mtYcfzy7t8EB+w
	INVpjWxtuwhsw6PXXS7LcGD1x7y1Vm7WYlc/4ZWJFN9rfa/VtXmNCv5YmMU4dIzxd7enFPzfXNA
	uZyC2Xmhy3yOUX8y+rS7KfGCI4RzYzAD/XuDjK5n+2FyexMwg8LE=
X-Google-Smtp-Source: AGHT+IEt26ex5gs36+PooHyGwBBsjJFkDd3jbDx6DGnMerjLzqdpfz44NkXxG+eTngxuvBHw29PaBg==
X-Received: by 2002:a05:6214:daa:b0:704:ae41:df2e with SMTP id 6a1803df08f44-7050744785fmr179861606d6.43.1753001089497;
        Sun, 20 Jul 2025 01:44:49 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2f1sm26291016d6.19.2025.07.20.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 01:44:49 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: vivek.balachandhar@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: =?UTF-8?q?Re=3A=20=5BPATCH=5D=20staging=3A=20rtl8723bs=3A=20Improve=20indentation=20consistency=20in=20rtw=5Fmlme=2Ec=20=E2=80=94=20follow-up=20on=20patch=20strategy?=
Date: Sun, 20 Jul 2025 08:44:36 +0000
Message-Id: <20250720084436.246590-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250719230707.238377-1-vivek.balachandhar@gmail.com>
References: <20250719230707.238377-1-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

Thanks for the review and your feedback. Let's neglect this patch.

I’m following your suggestion to address one type of issue per patch, which is why I’ve started creating a series of separate patches, each focused on a single category of fixes.

For example, the first patch in this series, which only cleans up unnecessary parentheses, is here:
https://lore.kernel.org/all/20250720083332.246512-1-vivek.balachandhar@gmail.com/

I’ll continue submitting focused patches accordingly and appreciate your guidance.

Thanks again!
Vivek

