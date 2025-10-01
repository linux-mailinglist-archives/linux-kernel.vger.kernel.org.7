Return-Path: <linux-kernel+bounces-839335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD098BB1663
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9873B71FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E2258EF0;
	Wed,  1 Oct 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKALSCzK"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF692561A7
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340970; cv=none; b=HJ6I63sUW2EREOqIqaglO1HtfW7U2ygaSNxsXUzV9lAbwCoZCLnfj62r1wY6ocApAyA5U8+Wn6iJUzNLT9bCQk4G3Iacgsx+YVQhU5Lpn0y0nJLMQvGKE4dZrAQ/Enu7ha4Y31V8lf/bWGwu9rj0I4bAIVmvXCu8BqQqYWjBLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340970; c=relaxed/simple;
	bh=+waJQB4fHI/86YXZ3IivT0VQyCfdoykuuj8W+W79+qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQW9PmYvb0GWwaGyurFlaCEtHYVBc+CqJNaNabu0Nrd/vDFkxbnU5YCRpvX9BTRK4OIP1JmdwdekEi0k7h0q9FCrG4fjWBFuThhygFfu5vxu0sYJMNOhReNdxoR8Q2p+m8I3nqLu0snIGDDT3lDv3KwGX12zJcRKfsyjZs27TbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKALSCzK; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so201932b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759340969; x=1759945769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDXYs1gW6lHgm0Sdi5E337TPiuAJ1IkOjd5WpuSNp2U=;
        b=KKALSCzK2K8phkEy0Ibm9BECtutDeSLdAh5QTb4fKqSouzDqouLVMmtCrgjk3Fn1J9
         EL/GEJsapcQ9lUoqBWLZEbNoYvyAitJTa8BpNrvygX8pRVaRAkbxNLUuZoYE9EZoUkC1
         l/5QcFkkwcCZB940a5mxdzztT3JnRM0NegkCyVkr5iWZkwXJJu5LxfqGgaEr2eXAS0gW
         Bhqg681GsbeneE8p3kjuUSP9/bsEyov52VyuJv5j+LX8a29fvuJYAOpNpfqLpw9wtW7q
         oURDwxUiHpOVdieZBA/JxBdI1OPwK7cko02ikCSS7l4w+ucNGhZN1PNEXvljN4LoPO8h
         8xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759340969; x=1759945769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDXYs1gW6lHgm0Sdi5E337TPiuAJ1IkOjd5WpuSNp2U=;
        b=O6220ipLBJLKpfpxtYZHhH9m6UAyp93hbwXYCPPA64oakaRrlabE7NX7jbcGPX82q4
         DEq2/Ki97lLAIasfpcAKG8F3FgR+4Y83gsJ/zYW13+PYgQ/eZhdHTSHNYw7oogcaeTA3
         /n+9kBP43R35xQBSes2VNwFyXgEoMe62S0SNH3PICyI54iiBVi7ocZVOKYzSSca18fW3
         ZCIDxux9fNY4YjXFQw4zZOZ/ZOb5YvosZtDu3HmTzjK6uMcP6VAIAxPCHQPGDeeoPYpJ
         EfkwQrP1Jb/wkLWZdh5XazeOKCjUjyyGtqhg/jvQXs09/jqoStebxvNoeq0bst+YJ04w
         NPAA==
X-Forwarded-Encrypted: i=1; AJvYcCXds0bRmo4CKzOtWv96Pf9sQq+LWrFgWoksrPr01tUAkl2pLcLi3vtlyvjSOU16Ks9ZeZxCTG3QkfYDlFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGhusNBgBndlQ06xQTvV/8rIE35Rp0HLhPIs47WmBHuVT42rs
	6o5eP0tQDnKNbyu6DL64+0+WLwD/pIPdq2OtwOTBZxXVAaYLWqCAdO9L
X-Gm-Gg: ASbGncvDV4CMmnBCH02S7cO2KH1mhMeD+f0dmTFsxbyeEKO0xixly4WgCDDSKnyO1lS
	5L40mhvDuiKiWraiyOfYoGiv/LE+qAUgFL7Qp7NsbxmWnwt+sa1mskAgTgTMy41n/wE6yqyvPw9
	6z2zW4Vy4xMNfxmWmAmJrz1GoRR1IcaoO75e2POTnosprWyMu4T1ztqQJqqwAtpuBomRyyvCXUu
	yzB8GDvruRd3nshhGyk4OZcAc9X0zVeyQ3XsKROL/36C63wUaX0gx1bWqQ0ZAMjx8jy2kHS2aM+
	5ESGEo6hBiIwsL1VDR/Hp5vTEIi8nEnswxQ2zwgZ882dtg6ke527XkLcUE1v4dSh9Z2tmoX4hlf
	PyNByLkQhvQIIoIlewTmcAPG8OWMLZQ==
X-Google-Smtp-Source: AGHT+IHwkrMABNi4K2yFUS+N5upbIB/1p2WPLL98eB0Gpyk0aDMrnqKNVONAsmUquFt3MfN5gfQChA==
X-Received: by 2002:a05:6a00:4b54:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-78af4223e1amr4810892b3a.22.1759340968453;
        Wed, 01 Oct 2025 10:49:28 -0700 (PDT)
Received: from archlinux ([2a09:bac6:d739:1232::1d0:83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020938b1sm264532b3a.83.2025.10.01.10.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 10:49:28 -0700 (PDT)
From: kfatyuip@gmail.com
To: Ashish.Kalra@amd.com
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kieran Moy <kfatyuip@gmail.com>
Subject: Re: [PATCH] crypto: ccp/sfs - Use DIV_ROUND_UP for set_memory_uc() size calculation
Date: Thu,  2 Oct 2025 01:49:21 +0800
Message-ID: <20251001174921.274261-1-kfatyuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001144431.247305-1-Ashish.Kalra@amd.com>
References: <20251001144431.247305-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kieran Moy <kfatyuip@gmail.com>

Signed-off-by: Kieran Moy <kfatyuip@gmail.com>

Thank you for your review and for pointing this out. You are absolutely right - the math is indeed straightforward in this case, and the existing calculation is correct. I apologize for my unnecessary change.

Thanks again for your attention to this and for the clarification.

Best regards,  
Kieran Moy

