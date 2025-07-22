Return-Path: <linux-kernel+bounces-741619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DEB0E6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68E2E56779E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0722828983F;
	Tue, 22 Jul 2025 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="v3RA55QD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B821C190
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224659; cv=none; b=tLrIatZ81fal3ZQyByAYV6G1nvosUZcvKQNbsWZCDb8ElewdegRNwDpt/r0tmiqthMyP35qtKEUyo31Oad6LYCClZFVT7jCOHm2p8zPEj3ZcUmiKcLa8Z7VEQ5y6KT1m1i//oqlNltLb1qkpu2ACPDKeyFQKmGDYu/suNAnWhhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224659; c=relaxed/simple;
	bh=6uB2lZ5a3FhUwFntFS23O6jdsDBMwEqNb4UAXhcRzKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpQNObtn7CtbkMBwNbANlyq9JvK9sa4GqojP3MVzGUk5abBZVejlrUxUk2DYgcdXuRftsZEWplkzgY8rj0PVjtTgLkMeZRxJfumc/Hl3eKkjvEt46BvmS1qxilkgRpnN5tQZ7FtY3WCM5XvpqGYUWQyeT+jGdThUxXsU00tHWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=v3RA55QD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23aeac7d77aso51177875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753224657; x=1753829457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQzRATxFUKQGYan/owFeZWMrnr0JMY054iWgwuSEiR0=;
        b=v3RA55QDcA5HTgfMBoZ4bD0VRZIDOiruZjlUg9BURUEmsNT1vd70w0WeQoIV+s3EKu
         oJgjtCYwRLYcJ2HJFXoPfAwqGh8jfLedjA1+lflbSlPrVqVkSEWGTOVfW3CtuvuUPFGt
         ujCgp0kDqwln3ke/wHRmpqvCVoseKN0ePF5lh1Ds+/7LjzJYC3eSaNhtwdQVXi+u/YuB
         uBQevYSp/8YLlnlOkTfQ/m7SHn0/vl4seaZca0aoEZujWrWTZjiPTm9qYvRnhRbAOz7l
         mOA4gfJit2DmN/yH5jdk0cpFWK5jZoEjXqb+ij6gbzAzE+TYxf5XFSZ/IaF93kJxh4ja
         MoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224657; x=1753829457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQzRATxFUKQGYan/owFeZWMrnr0JMY054iWgwuSEiR0=;
        b=t5SS3KvdXQOxyp5NiEJg1DJ0gUmJoMfONQ+7uIVI0TYhFr4jcxsSHpLsYhF3El+jKH
         tCdWCdBGdt5uS3mhKLUPTjYvHv/XMPRm3cHoI0bGqew0BxL0KvelAtjjWjOs3KUF9WMy
         eGLwg43FyMLk1JM+al6OhN2ecwQ7sxP8+CoXIRzvy2Vg9Mxy6Ca+GWJOB7k3WjdEt6Wv
         +OMIcEPWZYCnF5UJRMKhPhpDpWPNVbB4lBOcljWjHYGvjw+1ElKefqMBulg5dFZtbaQ8
         tQtOTEv7dbJpHIUbboBGDg3dFamAmeUjpd3zsQwPUNWCFfGyn24ky25zcEen/YlLb6xg
         5Ebg==
X-Forwarded-Encrypted: i=1; AJvYcCVf46xMx+t0BZiwovBWgwUrnTOQhVcVtClML/wqdVhOvcjGdrP1tAjiheInfNJwgWJ1gFftCvLkpCFg1yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxplG9iuqEU+t4MB3P6OSyoTv60kY/i/4Vo4CLhJfijFnwEquF
	6ifNifkZvqp9hnRk+3IKKJDtndJAbAPfDCuAFPIc+fVUMZm4G75rHIyUX/oYLQZg3vU=
X-Gm-Gg: ASbGnctajD3HJBA9KJGxqLekokIrnqUQa9VLIkIngv5taR9PovVDyLcC5MmoIaJvEze
	Ds0dPTegwBXVKgvF3fzVsICayIjqvIO6d0MYgKQthHrU2w57OEVu5c17IOIAuqVDnvst5EBrtcH
	alII7LmJf7aAFeBua9ym93HqFRBjrc9/1n5CEu0XET9FodPy9DQ3B7sKYGN4BWGUFSsKJP4AlSl
	u6yEM5yQ0fdzuSYD1r1mUBEeJYf4g4a8yEldslcpG2sPT+j4LB4nA5T2h81jO+nGMvQc0aD1u4L
	/zKbIsCTMinKgcsqb/uYuootQM4NBorGzOCu9LDI1uQ/VzS00TVVJGBYE/hf34pO2sGmsIXfIku
	Ac2XrnBHLYzm2fg7/0GOWgtPx9ktLLV00t0wn/himSlkPRpiKJUd5Ly5PUZyNmL4uADuDpFbBiW
	s=
X-Google-Smtp-Source: AGHT+IFb6BfUi9++lrjruDrp1u8SDwu2XZE+PQZF8X0tcMFOL5inVJKagXvznCSDmVJiiqBwRvC8qA==
X-Received: by 2002:a17:902:e54e:b0:225:abd2:5e4b with SMTP id d9443c01a7336-23f98176ad5mr8911005ad.16.1753224657384;
        Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60e8e2sm83115645ad.52.2025.07.22.15.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:50:57 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:50:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples:pktgen: This file was missing shebang line, so
 added it
Message-ID: <20250722155055.14bc916a@hermes.local>
In-Reply-To: <20250722220629.24753-1-unixbhaskar@gmail.com>
References: <20250722220629.24753-1-unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 03:35:31 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This file was missing the shebang line, so added it.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---

NAK
This file is not meant to be executed directly it is
sourced from other files.

