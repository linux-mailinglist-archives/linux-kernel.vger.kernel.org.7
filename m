Return-Path: <linux-kernel+bounces-797560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38289B411E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CC6561BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C201F463F;
	Wed,  3 Sep 2025 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U8vfaoRd"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6331E520D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862507; cv=none; b=clJBoIrEzeWHVjebYMU7JGllTnCX+fU1QyLZg339ARXF0Xlzrfuz6hmsIdukoVEtCzw7M8PG+2ZcAF+7GmcypHsun/IS3R4NW3KXQHsVv3LaHNjxYQfmmTGPgEp7QIRJI2gbH9DRzFls5tjnIooDw4c2IwtJmEi8hWGy8V2Ylh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862507; c=relaxed/simple;
	bh=PM+IAa6D+7JRvOsDd49HmyMUGDSaJXBLJBLbItAyfAU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UNmjMDBz72Ak6TUDj6ITuVPzr0VPde67AB7LfK7i9YCXQuU8bNzuScNJgqjoWF7mDJhAQGujs8ZAbpiCSUkvDx8SJFXj2Z5dVJDQWZh6jt6BCg4WDamwQsjTfPSlgv+eXdP1CzTHUI63hYsSLEG+qLMGFzFW0qDBeZMklyMP0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U8vfaoRd; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3f0fcd81068so37075425ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862504; x=1757467304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJWw4md4ZzcVTetUSdQyZ+2bMYMienRhnen9fvHE7Ec=;
        b=U8vfaoRdvyxaeqXMQ6ZpgawY98fShrnbZzXtGzyKoJGkal7nFa4OvVdETVEN58Rr3+
         7ibz4Vet8KkTYCw+qFM87L7E8u/6l/xvedDBgdR6J+HJUmc9zqjUZ6fKW0iQlvNaZmpb
         HVRzpUbUbk5o5TKuu9+7HmfrM8GI91OGUrWO6q4E5UgiiurGlu3+kRZlxPAxHvLO6IM5
         UjrknsPUetuc4Hh7iU/CV5PELx5ptxYjGmdfo2BCvKmc4VkB6SZjrvQiyu8/+S0SiPMS
         Wbg8LRgURuP+yR9sF8QWGNM+5NW6DFvlIc+2V02ELL+cCQ32XFv9n6IVNVVMy2J7NOWF
         JjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862504; x=1757467304;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJWw4md4ZzcVTetUSdQyZ+2bMYMienRhnen9fvHE7Ec=;
        b=QXAIFOOZspZuaMX4HeeXzrAI707YIupd7WKiXiU3TUZ+MjwRnM8Gac5jbNZoQqOQEB
         sDSb1EQmv6/8Y//x6SRBIGHwobSf+6f9BHvSGpN4Jri7C1gfe+CAVy2RmvGauygLPNt7
         wY/rhpBTZ+Ik6EAJC9MzVCdU9H36Wz1HOGt79sZgQ80ct0jt2A7eouck6a6dznnVhp17
         ohnffC3E++JtSeHpUyUxTmI4ygvaUdpJqrP6/GyXV4VNJXLrjD0gEbd48L57ELtkDRwW
         0BkG3pFjyvN+GCTAl/CPYZCOPnpabLrm6sjOaRlJ2eE9EDOYL/JRJgIkqEhi+eOh4BRg
         ePgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/LABNwbirSnyBagwhS5pBHguvZ/EGjtClvFZKRYAQbLRhrkBIFc6M+xJjYYMxMz2yFqpCkDsnWzgYxCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12v3C4eEgEZ5m8pFmSJMe8t8t81B/8y5BcwNzxfbcRQ8e7363
	deLQkG8O3lHoPUbEMsO+rVJ7BxfqO/qtJjwubL+iqN6V6FfwTZqbAXWVsxXZOxAUPFuOSYpQHtd
	JGTqd
X-Gm-Gg: ASbGncs3E85JlrKtVuqJlzOInMFfroM83xaAtd6J/wIqs8B7SmSM+FztwWhDMJvhG0K
	0LmyNyd34qwG8FcYzkQ+ki18jzkwl4nLW9OIHa+6MdDfUNFMw9RiI1HnNnJgOkTy3Hlgvy0D+1W
	VTCCfaFQhVleq8SsduOEV1+3mW98x58plw0SrcmFxtDO+PqDh1p37h7PE37M4wR7+TnzvzzaFQL
	R2K8TPz5wepX1MrVomE64RQtq3CXjW82TmvkryZNdCryie4p4VLm4RsqD+PrTliTIXkmgPIgFGR
	MHAW8KvdLUlJRPPdligUMLSZc5taiF0EOmwXgdkEg/QhzWvnQu9mKAR55BkKMF77ziuRgShmWC9
	pLLhhUmXnYsYbpaBAHESskZJ3IFerOtTc7hyKH62YKpoaheZY5SMMtGmNmg6+WDim
X-Google-Smtp-Source: AGHT+IEpPfuAAE8pbVm+xvNfRUo9Bw3bSAVSdw6Wvw/qtz54SOaCk9QzmO8i29HhuAPP6IWFV/kXFQ==
X-Received: by 2002:a05:6e02:3c81:b0:3f0:7ad2:2bf5 with SMTP id e9e14a558f8ab-3f400674aa1mr237520975ab.12.1756862503862;
        Tue, 02 Sep 2025 18:21:43 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc0dsm3662537173.38.2025.09.02.18.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:21:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902215108.1925105-1-csander@purestorage.com>
References: <20250902215108.1925105-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/register: drop redundant submitter_task check
Message-Id: <175686250149.108754.7904798401542730118.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 19:21:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 15:51:07 -0600, Caleb Sander Mateos wrote:
> For IORING_SETUP_SINGLE_ISSUER io_ring_ctx's, io_register_resize_rings()
> checks that the current task is the ctx's submitter_task. However, its
> caller __io_uring_register() already checks this. Drop the redundant
> check in io_register_resize_rings().
> 
> 

Applied, thanks!

[1/1] io_uring/register: drop redundant submitter_task check
      commit: 8b9c9a2e7da11e50a1109a1f38bca0aecf25b185

Best regards,
-- 
Jens Axboe




