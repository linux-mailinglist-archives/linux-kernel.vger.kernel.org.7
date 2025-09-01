Return-Path: <linux-kernel+bounces-794796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4006B3E75C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D99188A6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2164341AC5;
	Mon,  1 Sep 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="liWgYTtm"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3251B4141
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756737467; cv=none; b=TwA7ZT6oUQdc6KfPbX1PV735PuE+3EvzD+ub49Yjf2NIPe9zQk61UXvNqqblH2Rfb5GeIjhFfr5AtLFiT2t3ijzGl0eEjihHJTMDGSyQlgTVao5FP6EbjGnSic6ogdKgEE9V6D/hzg7s2RDWDkoR6PzfzD/9RSVaFnDNQGTlPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756737467; c=relaxed/simple;
	bh=sra0/FDnnUH8X1K3s5FaMUQj5vaPuAreMN5Lt9OQLYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=knE7810HlqaIh70Z1plPrvqPWsMZzlP8Of7d2Dtd5Z9QmdVhjxaD9qqtRbdWZSr0ZPItnNCIrBTpEi8NnSLLtcdIgqWGkxWHnAV1+6ZNF8ap9cQ2r43FApNcC/MSnk262hGTJKxny4C8yLn+AydvAujEGiCzKZmbcwhEWstvyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=liWgYTtm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so3020142a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756737465; x=1757342265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTfsWeNGithKokPaf8LnUeHsYMRih1Pm7H+/AYqRTGM=;
        b=liWgYTtmY44mCW6rLBVTC5Se3eeAexg5teq0lLK6gWh1HB/plUCp/0j6uvmEzl+QZt
         JrM1OOCZHhNIfkttG9yTVpDQ0l77DaAc96mHMeLc+SxkTzpq7MlZZKswrpUK5ekJABoB
         mZebhGA2+hAmJR0fl19FiBmwuvLNpz+OLc4xnOo4Kpckt4ip0RtDWAxnLUVSwhxqrRv+
         BMp1niscqXgQFX96w1d1VCFXnEp0xGsghire7Ij8ztFg9iDy7tsdDEcMV8wvze2jksP8
         ShcFL4dS4tO9pFjPJyeJyeahar+mPkkwnHgCuggFdR78oQJAV87RJjU55Wz96td3XeWt
         dJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756737465; x=1757342265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTfsWeNGithKokPaf8LnUeHsYMRih1Pm7H+/AYqRTGM=;
        b=LOPW2TsOKMHNuAivDEh2Lpn5kpCTzcxjIO96+kUAjYwwyAdMzdB0M6H9Xvc1XMTOzD
         EHexzkJB3DWheLHX1PMtCxx6Pq+fRFolgcEN+fjwoSpI+GOA2iRixBONkhIwO0CUuvsX
         vf+5iVBi7sVwdCwTldxDuNe8Gs0QTGUPCNFPAJc4qZF+KQud19xyf/NtPvgkoAkQ3BWn
         BJxUNPlbN0qOLwkRWhw/EOS9p0H9TAbvM7DWe42TNyhfrEVr7l5gQRG/9LcXsjX0n7zl
         QX19SQqYHqOx3hzI7ATj7JEyzJgFjGPudT4QHgH9o1R+AgDQG2scDog7XXK1RE9aTmhg
         ZxKw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXrTFVC2jO2z2/YTDZ473ImfQnSu7NY+/EGY4eSzRNn20viEm3miWs8KcVWcZfOfmzLgLooAmdmrtHuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjP4vkXNcp+Pl7IRqB+wPUESsB1XhkpsI+GCdxl0D5+2TBw23
	EAgmp598//HbrZUhB+UOx1pJSIaWNOV1c2O3G7WbEeTLVoC3YUroF6ZkXzsYzOdb1qM=
X-Gm-Gg: ASbGnctxv8sZmzUukPmKt3lyZHnG4GSYBN7IpkddegVsOaQVK6UmZ0mudCPTAAd/qGa
	yvfxZlBpwQI9RfNzhmmDztDsavgHqlVG9sqGLZA4wEWscei8s1DIMGFj5mfhB1b6/AZUgDI0yNl
	JHpy21SYhrRq6Dcx4CHgsk9RKQGiDPyMboYegVnSZ0LN9tVvjmZY7qCB7DxBmfUxZT0dScHrTWt
	4HPe28KAvs77U6M8zcsFHaVMfC1ijwGIihxKlVEBRABU2YJpd5XZMnBHSdDmeGIv48jLWSrSCM2
	OUSFHi1WPNni3kS5AEmqU3wGTqzwHnHFs+NcNVaNfdbpXIBRB2Ikhu10JsVVdWH+3HCAtsTGnd1
	fZMB7UqHbc8MxZbo=
X-Google-Smtp-Source: AGHT+IEaM9vFz+UVeUU5AY/6OvHJYzbkVtiO4j665XtK5yxUnNyy9lt762KQCwiXvBmRtrrLMjcdcQ==
X-Received: by 2002:a17:90b:48d0:b0:327:dce5:f635 with SMTP id 98e67ed59e1d1-328156dfca5mr10342372a91.25.1756737464713;
        Mon, 01 Sep 2025 07:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28b37dfsm9546596a12.25.2025.09.01.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 07:37:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@lst.de, houtao1@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, 
 johnny.chenyi@huawei.com
In-Reply-To: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
References: <20250811065628.1829339-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v3] brd: use page reference to protect page lifetime
Message-Id: <175673746364.13707.6940913855936222519.b4-ty@kernel.dk>
Date: Mon, 01 Sep 2025 08:37:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 11 Aug 2025 14:56:28 +0800, Yu Kuai wrote:
> As discussed [1], hold rcu for copying data from/to page is too heavy,
> it's better to protect page with rcu around for page lookup and then
> grab a reference to prevent page to be freed by discard.
> 
> [1] https://lore.kernel.org/all/eb41cab3-5946-4fe3-a1be-843dd6fca159@kernel.dk/
> 
> 
> [...]

Applied, thanks!

[1/1] brd: use page reference to protect page lifetime
      commit: 2a0614522885b136e9e650791c794dd49abb5b31

Best regards,
-- 
Jens Axboe




