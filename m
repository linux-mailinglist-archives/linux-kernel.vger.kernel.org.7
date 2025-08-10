Return-Path: <linux-kernel+bounces-761291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC98B1F77A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 02:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BAD17B95F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 00:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8264F9D9;
	Sun, 10 Aug 2025 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3/vK52p"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910348BEE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754786840; cv=none; b=Y0mF+cpUKrqZpiLalva2Au2Xhxbgn1KSneHH83o+N3XS1mM0MO4mPaieP0mhGSeDaxYxy+uQujsERAkLd6qxr+DPuxwmSGGCgIPRT4C7Zh4MSe4dtGrGzhHSM7rcqB96HsKjN91XnIwiY4+1CvK0xZzLxoT93ZP4fLJLe1bbpoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754786840; c=relaxed/simple;
	bh=SwPd0PSnHp1gIMXWnBVBVH/dV4tyQkbK3O07xqxJLKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzrGCReLa/3tYc8imO/kgqHi68LwnQFJJKOudynYozDVpO2GwvAJOwgLY7rRStpWjZ/4k8wo7c6zuSY5qvjME7XpMtPiQEMK6LWWhR3Z5YfLYbWXP6KXbnUlIr/14sY6vZ06FWST4iXe4fe5Hu2RuYGMPOL7iWQQx+AQAETkiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3/vK52p; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso6289717a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754786837; x=1755391637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SwPd0PSnHp1gIMXWnBVBVH/dV4tyQkbK3O07xqxJLKI=;
        b=W3/vK52pUeGmbA9RUrIExL+upXvjSIdk/hJDemEzRKwpsA95u6cdh1J05sVyOeJJLp
         8sWi2s3jY2SjjWqZrXdeAizRbGe/uc65HSrdXSkItl1M5g/3E7bi2yDIaujq1E5P9uEw
         z6ViijRbV6sKxU5tVkx/WSd+3WQCTp+e+rxUvhItURLRuQ5jgmT0yqMkAA3RCjtdQ+1y
         9aowatAL+uQ417tXmrdeUHYIdzAS4IzoMA4k29lnNTvrNtWuiGT1+MbPz5+vkAzXqhCA
         V/3dZEKpE3kXlrmbDOFbqpJ5sq6N6p0pbjBbjAzVtsbYbn+D3zs1T19oSBkQT/ZQDamj
         devQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754786837; x=1755391637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwPd0PSnHp1gIMXWnBVBVH/dV4tyQkbK3O07xqxJLKI=;
        b=GwUmx/unaxN3BrviqcZIkjzJ89ljxTqSHWxdEl+847NdZM5JX3qc0uBx4WQIx/bvTq
         Wo98Jzt1TnopiQ8iVLIIS5JnbC1BsVjrqePMUx5t9nFMqKO63+MKgMPAHSFQHUAMIdVN
         a5H8yrlcBTrc9RwkkzrH+zGj/Q6Oq5wNQzhmHths2NZMoHmFBnDfrECmyiUqW7JiV6Bx
         ArwfOAlVRcaAvor/to/18Z8RtS9VZkqkgijipHgp9rafxazk/Qsm942hfr+/RhLnVGoD
         ygvyE6Hx7cle3hnVzwvUISHuq0naLeoZhFhgSFKeRxwzcYjD1dWjrFPnGNtTBee4/5M3
         bLlA==
X-Gm-Message-State: AOJu0YyCNkmTl4nV3FsSBUVOHxBD4I83KWQjrpM9+qOfWqsRsYSFDLBQ
	kKU+bvawl4J4lgTnAsVYmoi44xPg0jnt5pQX7Dwk8ibFXDZbkuwPDqZDl4VjirlTvOP6AEoG7Jg
	jztQhNoV30xEqD6vJ8O7Xyn7zN9gYMH/Yokkh2oI=
X-Gm-Gg: ASbGncuqfajDmKxuJ37IPCT2sjqxCflfxFj0MkfclRgfDnX1NexzsbfzjTeodedcQGf
	4LmDBSdh1hsmvqltAZx8Qgcl+5zPl9FTANYFM+rm6Jv2S/cnUIJJOHaTAE7S8Zt3OQHUoDepktC
	iBpotTqz2kSTr5A4ZmkxVkRfAxWZTR2RaMQ5RrdeTFK+NgN8OCO7lYZS4z3g9eEUfwAdLs5vPuo
	hzU5JYQS6N29CS2DiCo2ZNdKxTfK2VIDlo+Mbo=
X-Google-Smtp-Source: AGHT+IE0H4I9x5QDJNMg7RChdAyDFXE8A9t7ca651opSyfYHwle1f8Y+IuztZLr+sN5TPl7i/c5MHHcNjQy0yYIoNo4=
X-Received: by 2002:a05:6402:42cb:b0:618:1521:8dec with SMTP id
 4fb4d7f45d1cf-6181521952fmr2129978a12.16.1754786836903; Sat, 09 Aug 2025
 17:47:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
In-Reply-To: <CA+LcPJ3nAdBmuSBQ0mgzFmUL=ZE5RKkfp_4dQf-ycTiHxH=PXA@mail.gmail.com>
From: wajahat iqbal <wajahatiqbal22@gmail.com>
Date: Sun, 10 Aug 2025 05:47:05 +0500
X-Gm-Features: Ac12FXxOa8EElY1hyv4TGAEeQ4tydGpRyXLKEXS0OE_bmxgve1Q-Pqonc1914cg
Message-ID: <CA+LcPJ1jSPOCp7Tr-tsy9aGirPtP7-FXTr=qnLjfHeo-T1u_tw@mail.gmail.com>
Subject: Re: [PATCH] misc: ds1682: fix out-of-bounds access in EEPROM functions
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi again,

Just to add, while sysfs enforces size limits, these only protect
accesses through the sysfs interface. Adding explicit bounds checks in
the driver helps ensure safety if the functions are called from
elsewhere or future code changes bypass sysfs checks.

This extra layer helps avoid potential hardware issues or crashes due
to out-of-bounds access.

Thanks again for reviewing.

Best,

Wajahat

