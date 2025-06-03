Return-Path: <linux-kernel+bounces-672289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A93ACCD52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B9D17053D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jun 2025 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36375213E76;
	Tue,  3 Jun 2025 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="B7Q7s2Kk"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD0818C03D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Jun 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748976370; cv=none; b=lbV/yOReVQYQWXUznAh2Lj194A3cSFDgG+77FvAzixswXxdzBWsMVE6OYAdWKmj4x0YO5EEelSm0dmFvscAlMg27eeE4C1LRAOXreaJVKBxfpRMFKkGvuO7DdGQHFdNil+Kn3G7MP4EbiNXoGcJyo3Nw+dKOoCW8Dknj+OJ0omM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748976370; c=relaxed/simple;
	bh=BGGyoOAitopUbOF8JRNp9e7ymTkcBN2zyfb0bX51Xpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TPOV4DWK9I5bPWk1sFHDq4IrZ36rSacfUgyt2IS3bV+GTuOk8obJU9LNdXL3eWkPNMdM9LSjbgW7O0SNHtWyjjBQrYNSdmWhKLty+egAYC2SeYnbOWXNUAwqk39eQDtfTVCnFteeD7GulJ5i6uLmvUyv/d2D1UbvYW+7fi/2gkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=B7Q7s2Kk; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-86a55400913so175208339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1748976367; x=1749581167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytv+YWv+S75md5rXeB13AvL/fqgyAAlIGtDQ7fSe6gs=;
        b=B7Q7s2Kkj6QHX53bh5al5jCj8QpshWVCGlPDoY88fUOhvMtkPbUJc4KyLFj8keoNXM
         w9RixbUMRL+7fB7oyxH8gG8i1P75qaSN6/dN4YVcxULWxXtLwLKv7Ldx7dlOIiW5dC9w
         G1LCzO/dietahsMXcI+PjpYRZQ2ru39oJbclFibP/3bK1KLo1koFwGVDpVt1UGEp0Jsw
         f4INUvbXHt2BTjFWctgxg7F7xHk2g4jV9xGbN7blsFCYkMEUPTM9VVA73EeTNSx+Qiv3
         pbYvSRbki072xIRr+Hk7kEGoms3ATPnKJiOhEI54iWmZj9g9S4hLU6os+F5Np9AUbr5k
         YvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748976367; x=1749581167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytv+YWv+S75md5rXeB13AvL/fqgyAAlIGtDQ7fSe6gs=;
        b=g/B8e+RhW4b0tXMlsvktqtzge4gAsysQ16Q5/f41vZH3BRSAX848sv9k2mC74h2Way
         1zOLnsrU0vgaDyYwfPVxYmUE4xrd6w8oIJOyWnLdw9RD8WkS5SH3TFxOnnVdOZw31SL0
         7tOvVw75QGloIJw3XVycNc+wW/V2pS1E0fv7TXgdmKwI10ru1zuw90MRHApRRZQ/erm7
         kM3rdsx1UrAockiRXToUZpVzOZhzg7INrAZUjzw90fdkPiRwxWmohpZczKTegjmRTtap
         ecP8EfNa8wyWhj1mN1LQUg2+/z88n2oXUKmalPQC5+DwKuxu/bGh8mPL7rKt9lNZJwVY
         obcA==
X-Forwarded-Encrypted: i=1; AJvYcCVOMVy40y+nk4nz3++jV9pv/J5tHEzM0cdEAC3jAQfhFBvFIXopaM/u5DGb2+tyGXGk6TsuiM6d6jK3apo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dwKsKeBCoS2aitpyoYHG7RSgHGhbBRywFecDO1LxLG+v/Bwg
	tMWetayBa0dBNWDMGDJL/q7HRstM2l97LGrKjbIJivi+BnpboMFGcyCKqGBK+Rs4RGdnDMPvNrR
	eDTu2
X-Gm-Gg: ASbGnctYNAecF0fg2A5RIAjvVVGCbl2RzTglz16ooxDbxMAzWyIClAdTRbn7ggpXJ5M
	+t0IcH11ZogijaC09ZU/GhEQYClXoEJ5PM/QjVbFfonjPzPxO5rZ3i8dzJIAeltBpLig8wHtNAr
	vQFeNelIGviU3FCp0X2mYj5CELwRkd+mQMB60Kgh282zRaY8gR1RlnWwejGzsYTTv/oMaSn/kCz
	+2KBSSgYMR2P+XUiA+liptNjtJHyc6703HjGxyKkgjboASd/PaHJgapBrzJP8QE5h+jimJO5qYa
	ruKQOM5xMX9GwHsCDiso7CDU5pdnIB59Agw5AtpxMg==
X-Google-Smtp-Source: AGHT+IGQVJBhh4r6CbR3SMBMSOpcdLANMW7TJEkb1UHjw6n0V54ffSovSdkLt6VoVn1npFg4sbriNg==
X-Received: by 2002:a05:6602:721a:b0:86c:f2ea:d8d3 with SMTP id ca18e2360f4ac-8731c643e38mr5739139f.10.1748976366844;
        Tue, 03 Jun 2025 11:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86cf5e51d99sm232212639f.7.2025.06.03.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:46:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603183133.1178062-1-csander@purestorage.com>
References: <20250603183133.1178062-1-csander@purestorage.com>
Subject: Re: [PATCH] block: drop direction param from
 bio_integrity_copy_user()
Message-Id: <174897636598.14684.15850235224325997999.b4-ty@kernel.dk>
Date: Tue, 03 Jun 2025 12:46:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 03 Jun 2025 12:31:32 -0600, Caleb Sander Mateos wrote:
> direction is determined from bio, which is already passed in. Compute
> op_is_write(bio_op(bio)) directly instead of converting it to an iter
> direction and back to a bool.
> 
> 

Applied, thanks!

[1/1] block: drop direction param from bio_integrity_copy_user()
      commit: c09a8b00f850d3ca0af998bff1fac4a3f6d11768

Best regards,
-- 
Jens Axboe




