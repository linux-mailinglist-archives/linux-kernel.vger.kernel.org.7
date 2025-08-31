Return-Path: <linux-kernel+bounces-793583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD14B3D592
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0FB11898894
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF324635E;
	Sun, 31 Aug 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db6jFYLX"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA8635;
	Sun, 31 Aug 2025 22:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679158; cv=none; b=G03fkm6BeOWSdze3o0fLiaQF/L3Y3WS/06Ku31Rp1EnHKoaxAM0EpTnml16EMPQM3Q7+G+AndIPnT3bb/ylCIrdr4V5CrvFBqCQbODKh8MsF1xkN2N1LeD7aoLmd0Wrf7ovvDP6L0Ysf5c5Epm3cNY4QSnB6/Imi7Tf1jaaVh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679158; c=relaxed/simple;
	bh=GF0XqyF8T0i8SaxIgLCis1iUyN8CfKUJFguzohAp4OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS4wc0hVhM36jM7a4vdDVuD/C3QHfFA73QQmX8R1SyansSAwJo9R4YwGheYtq9h3rkOtYJbulVg7+hzEY+RobNJ11BK+pvTQLXh0t5yH5kMGsehvB/ajwh6PkQykoD2MF9mzApEuiZefSr7RC32l5SIZHT91Qb1rdeXdj5vMyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db6jFYLX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so37252845ad.1;
        Sun, 31 Aug 2025 15:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679156; x=1757283956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lErwqdXAiawKk/J4W1qUfXQ8o9bdNswi7/uGqQDQTas=;
        b=Db6jFYLXqSTdsKIDezR7FX4ofEN1wY9cWIQRRGu4xqbyohBxiYK9aVL8ZS7KB44Qv3
         JDU3pL1+LRPJ2t7aVn+SOAzLdi0p47XDMW6ROQCwv6/Degi+oFdXS+k4O0gtEoM9AUwm
         f9zqcEJE3KciluYzWZfM1/T1neENiN9fOlxzjZdtGHHgxGvo1N7/0XvC/Qus0Ijf3OBC
         Y7lh06mGJCwy9U54dq6BC1pUGhyjEvug4AeA6E6OEdVpg5KgLli9FnHy+Emch9yO/2gh
         7ENU/s39ZOyE1MqHiAl3sHfFE07XlsFHNKFAMoEjQ2v/VnsbkBoLwn19XvGXsWr0aJzP
         JxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679156; x=1757283956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lErwqdXAiawKk/J4W1qUfXQ8o9bdNswi7/uGqQDQTas=;
        b=qLkxl44OfKOmnXOpU+YZn6r3vFTD9dwwX6m1jEaT2l2fSSJDJTxwG7jvwqw6zKtR2Z
         KU8hLpBeu5N3l6X3Sk/4dRQ7f/+mRjGAEVFzeA7tQd09y55/QvGqEYOLj2n0soUvabBn
         lAkJrQAiR/AiRdjYJWOkg08R0gCVb3x1YoHMIBsPVlbu8mne7I1jmfP1ht5LxnJW/aVe
         RAKqnW0HKRSwHQQZ3ZkDxn9ZUQZjLClH/M9Br6zTR8JCFT1/lI5Vo5SrCqcdI88aRKa4
         B6O8cfxqW2rnu3HApOr8MudNGqnn8VqWCqsFmE/satsMVZmXG/ef2t8VUPqxp2dJxMCs
         NP3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNbg/91Uw3MMTYslMTyvqzRLZgU2KNT4KdwQQF9aWIWmo4ODf/XaZNGZ5etsoKOiQq8n//bIsxHomZ7io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsgg6Kn4YZswsH5DDtK/Z5L0B3KNCVuyChHSO6OAurUdY9awO
	J8UCf0wVeOhUIZqlzzA9CnZwI2tyQI3veqkJ14GWIiER23PpiPA9qvdn
X-Gm-Gg: ASbGncsr5z0NOUEJOnZ0x7ikSVPaqkPB9wAfWtpDxqcDG2bKTG+p01MJu5qyTwYiiPS
	SHbB5P8O30TEscZHwJ7iu9Zxe4EMHhOaCzd7IElpk4w4G4l1m+hOLhCXakQAHQIa/Z07oshwHSA
	z85UnKLF3dGpJ59MHwse5F5A2zLfREiMb4FOruvmY6Fu2IBib7ePjl0D0ni+OoKCqj2CMBy+4FG
	PaERnB/pV4xFpydBARZttB1Q/RMvg/VEDCpCilT1UJk/+9hG/RZP21R/lguNrr05j5g9wL5Z20U
	JiINnTlQAcg0Zf4vJICES52aNAHv+CutlMy2jMP4KD8E7vI6AN3L3mM1vXN5wfdKQ5LA+CUTCP5
	ufEFE6R5iYNwV/Xppwi0bmU9HzuPU/qsDRdA=
X-Google-Smtp-Source: AGHT+IGKeWvXgTZa5r4hJBpoBI4TKcabJw1ea935dYp4kCD0Py5s7uizMiWBMYtGu5UXjSkboWVDkA==
X-Received: by 2002:a17:903:28c:b0:240:3eb9:5363 with SMTP id d9443c01a7336-24944a70227mr80661775ad.27.1756679155674;
        Sun, 31 Aug 2025 15:25:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065ad5b7sm85569585ad.128.2025.08.31.15.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:25:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:25:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) refine config description
Message-ID: <dc1cdc4e-624a-4a35-bc1e-e09a8034c32f@roeck-us.net>
References: <20250830131224.748481-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830131224.748481-1-eugene.shalygin@gmail.com>

On Sat, Aug 30, 2025 at 03:12:15PM +0200, Eugene Shalygin wrote:
> Remove outdated mention of the supported mmotherboard families and add a
> hint which sensor readings are available via the module.
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

