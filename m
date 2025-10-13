Return-Path: <linux-kernel+bounces-849814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7145BD0FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F40E4E5774
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 00:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D412FF69;
	Mon, 13 Oct 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vL5dvb3K"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9EB2566
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760314789; cv=none; b=ZWKMvostChqcxcxb3pG+yfv5SB7ru+eUYZN07G3rDU8nOOoAqv//8d3BD9bm7uPNmbasN4SciRJ5vHqHEpMdmgevC4trRTxlRtu0OiXGVy+x1zHF5BT71HTsnjFpLGjqS3TXwh843dwBexQt3/Djf2SJOEYc4vgmq+weUcNvQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760314789; c=relaxed/simple;
	bh=oIgptcny33PtUkWAu4e+wrPZTq3feeCerDCEqm1SR4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YdKDjTgs4m8SyYJ+7atTagOUITyqb3Hsfku1mkT9Fxd5DCB2hQfzHTBZXQsJbAVkOMSWP3k5oILdTQGBJKkPQb6Zqyqy9op/sc3KhLbtfozThdtfR4E0WdjRGMOcGJ/P/W1NXehR9P5adDfUYH+C2zMzzHrBaGtwrinU2KYUdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vL5dvb3K; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32eb8144fecso517161a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760314787; x=1760919587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wmgn9ZyA9IwcGHiucdpyOI3qaKNCjjhSZb/S7IcZPc=;
        b=vL5dvb3K3obJ3807va7gCxGZigjD+eIo6kTV8hYPJ2RVDPlbwekcEilAtXu2t8a30i
         KO5rkpdjWlDz8LaOaSOApTMwEg6Bb70QJFiNI8dPT52iDaguU3FfP4GXcs7aoqF5JEN5
         GTlCdsNcc7y1UBfEEJFVqcQkhd6Ry1jerTxfUJePccpfOQvaez8lSoseve8NpoHU1XZF
         UhGRPrC6B3TzGZXrE0pCTi2mtcDGy35je8vR+aXXeleBEBLDs54dGFJeTXm2jwODdHa1
         stdPwkXITdkTmG0zRF5r51SGVqBVe/7M5/Ymz2S7xmfRwraY1rPk13bLpJ6v2++NgHaK
         5qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760314787; x=1760919587;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wmgn9ZyA9IwcGHiucdpyOI3qaKNCjjhSZb/S7IcZPc=;
        b=OAjZqb/EyqdQ8K2mCGysOC5Ju+TWSw70D4Yk89U2vjSYmJ45xIMjpz5tEMF0oB75rT
         TfvCDNy5UjS2JxLeHiMvEJJf0Lu60Y7UCz/vA7cYanE69yYzPrOxrHf9yAFstNL2/JAv
         6gzo2NY595OiAjCLgpgurEEIv1fNDAYdqum8RM1XNY5NRdhaUtkqWsfmchqa68uy/Xtb
         RTYvvikbnWFsSozJlX53pYmguQv1wC4y/lApdLWKuZOT9BxRiYyoO7k4b27csYwPeUI4
         aG0d3Ha0f5a0Uu1X5GjNYlPTP37iTMCklt6X3UdyCXF1WlaKSupJAKVJayLZVMp/DAWQ
         iscA==
X-Forwarded-Encrypted: i=1; AJvYcCWQH9apHNyfuQOkyxPBA2mpdJPpYR9ZmPcXCXxJZwCaVScnmQJ6nXvnnN5BHGrnwGwqr1yDEv/m49mE4Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjj4CyKBfdWcrS6ABnrL+DSikpQJHNrJ72kYhGeiY75WHLra00
	KqOJjPzpPXBpsTCkKcuxXCOD7mMAbS3jN7+tIZdIvMVVEUq34ZHUPhRI7zvZ4614flM=
X-Gm-Gg: ASbGncs99uufHAdqmjRaTmHQKgcl6gdCwx58zdfU/HH3bIlw8I1qWUYC13pk8C+XjQ1
	+NYzbO+fhwTeo8WEVMo5j9J9AO6tVF4rvD25/62batng8vuVIeH1KAzacazGqaFOUapYMzkH5Zl
	CDb73CurqrKAA5C6rZmZVSdrXTROGtMeculDMUAB4VgfQHkGjzeGvVv2N6MpdLTw4v38lu4CDC6
	FC7K5bTxR6LouWKaHY4xlTMrlKDuYrg2batbc/xr8/ioxeeYroC7XU1mjx/DqHoQPH/umyTtlAS
	a5mAQ8rtIBQaxTVF1HjelMTbo5cr16RISRG4vJU3HjilQNSqXKhH3LyubcSZ0RPxXk98wf3filT
	vrgX03By0R3mE6JNji4TaHPR6XYrigWfQAz+n1eChXM12MaGk5o/Re3+hFk6O
X-Google-Smtp-Source: AGHT+IFRvB8fN0V1YVzHc4CjsBQ012S3kt97YU4LXDg0lSowYBhGxM5FfNjwF4yUmDH/oW2kOMYofQ==
X-Received: by 2002:a17:90b:1643:b0:32e:4924:68f8 with SMTP id 98e67ed59e1d1-33b5110d5b6mr13867735a91.2.1760314787447;
        Sun, 12 Oct 2025 17:19:47 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62645851sm9679057a91.9.2025.10.12.17.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:19:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: w1-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20251004222128.4105173-1-vivek.balachandhar@gmail.com>
References: <20251004222128.4105173-1-vivek.balachandhar@gmail.com>
Subject: Re: [PATCH] w1: use sysfs_emit() in sysfs show() callbacks
Message-Id: <176031478546.9069.15252505742878527184.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 02:19:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 04 Oct 2025 22:21:28 +0000, Vivek BalachandharTN wrote:
> Replace sprintf in sysfs show() paths with sysfs_emit(),
> per Documentation/filesystems/sysfs.rst.
> No functional changes.
> 
> 

Applied, thanks!

[1/1] w1: use sysfs_emit() in sysfs show() callbacks
      https://git.kernel.org/krzk/linux-w1/c/c6d0c9cae7eea0a029b5961d896c016d1467d03d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


