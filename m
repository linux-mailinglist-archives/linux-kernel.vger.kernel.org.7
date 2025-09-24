Return-Path: <linux-kernel+bounces-830433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68344B99A52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0520A323B74
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9556C2FF177;
	Wed, 24 Sep 2025 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pK1MjQb5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993EC2E1EE1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714525; cv=none; b=L9gN7cvKWlNyaT7m7Oepv7Okgi/PB9VCwvocPTGDrEWUbK42frPRdHqjylTQTzfBqUFwv6xhC7+J6FeVdHhhnNedxh67dAt+7FLnpFmpr1AjcZ2OTufKSnrDnGkx1QIJqR99CECpw2FntjHimwkQnTIE0bdWcs1iLnUPJk7sy9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714525; c=relaxed/simple;
	bh=pj8PvxyzC/z3kcdQ9jQHUKp9r/I26BHWLbx0ugQyktI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HCDiC8uqDQEekg15sqXPancgy76+L6RPI5S9dOfiImHvGW6NF0bP7g+MoQ4/UkBeDCdwyCRH4ePSn0IiadfTqvcrmXWuUu+T6Tif410dCiPRVi/YQ8kHskyIf2dJ2byL1g/tcnGdFFCcSqfEhx5SX7MnzI+4njirgIwEJkxpFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pK1MjQb5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso6502805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758714517; x=1759319317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du9BNVEhuhgOCmpO5yclDaaObVQns4cLiTGaVHcZCxw=;
        b=pK1MjQb5bw6UWZM4g/1b7KO5oSv5WR7pBDIpQ8hmfMjQaPD01fzy1Q+ho2+jRPbz0z
         x1mebBLsoyN6jexhUNSDfLTvu9wW1ZTl7XLUXm0yy3qkdZuS8VWL5FvPSw/1iYaZqP8w
         YKFDqTsBAQIonlt3q6H1G/+5fRVec+elXoOw7rC1JvammifG2buzN7zfF52cW6MPCW9O
         tsthEetqq45bTnKon3NqbJo4k/5uxGCgwrLGD8i0blv3Es2sSCOgDgjVHPg8Tohbys/0
         QV0TNvq/AC9yfCjo0KvMyQFPaKRsM3l5ftSPKkJBIVD8XghJ9IvwguVWrG1sG40ZENMQ
         FNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758714517; x=1759319317;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du9BNVEhuhgOCmpO5yclDaaObVQns4cLiTGaVHcZCxw=;
        b=eTRsv/X/ijT/kgFEVLLXluVqEC/y5MfQMdg+S/vgdEHB4y0OQ/WIarNjYIgo/fI0IB
         if9c032Hit8w+aw351A4Pt9m7SBtJmPmd6XeKKbCfFj+PBiRS55QZDhICZHGJgjQKTtp
         vywz++fiU9B9fnKjMJ9Z+nfwkzX4PTf4ss6iuGIqvypkl0yTIDd59QrfXacTsJc3WPvW
         I4hjAzy/P0H7A8GmWausQGhJV2DiDiXRsgtQB7rKEhHOsJ2iptUoGLXCckqE4aiRBo74
         KZsQgYbdTgW6OpfHfyqR9DisH3uBmVbufd70ZXMBD2KuNwMBynpXrBs94WOdQ7rsHE9y
         qGwA==
X-Forwarded-Encrypted: i=1; AJvYcCVQnU1M3FQ6iWcYnYUwbB3uX/L7S7QuY616x7xnRMeR13jm04wQvSgjSCaizShnEGd/7n3KPEGKUIzm0xY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQINcDWDVYr0Q27PAr7VutJS69ZqqJv5nQwXecNOl6j9UxHM4
	vH0PDcdbw73uL/rda7nLrKK9op8DmQJnPho2tXFaXVDBEiVSB/IxgXpyB1J4OntIGAoDARgH/Gt
	TCPA/+98=
X-Gm-Gg: ASbGncvkPWIFKFN8vIVRWPjk9mk/xVqEWkPjaS6hk6olrZDgdqKXNBdm6T5MN86PTkC
	Cbm7HysEwHUmyfm5p110n7RBTJZTMaj5GYMhEK28ebWIoqSh/CGcrIVNCiC2s7B3DnDrHoW2ZZm
	aDZZs3DfrFHPhDhmXVHuD4kHLUCpxVR/rNqncEpnEWq1bJrULniQA35omw172GL/bH7AHS+yMIP
	LbVTJ9pEU+LoYtrVAi0St7X1YbOqGGdp7cncxnUPwifPyAUhKkAAMSEGicGW7V3VqC6w+AnQry4
	CI4la2DIgGS7iWlHgu+eqpikctQnh8m6WHNTJaCeuHrLEWCyBlCSrubylS34nTaOh/3REc8/NE6
	3ySPMlCeoK/KMKvWSwQ==
X-Google-Smtp-Source: AGHT+IFgego+GrflALefJre2aO2eYh8KTDjGfe4uYRtoi3EEg/5php7KyGqhlwX9+ZPt+XwIRrvSLA==
X-Received: by 2002:a05:600c:1553:b0:45d:f7df:2735 with SMTP id 5b1f17b1804b1-46e2b556f5amr22847345e9.16.1758714517495;
        Wed, 24 Sep 2025 04:48:37 -0700 (PDT)
Received: from [127.0.0.1] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm28162185e9.11.2025.09.24.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:48:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250923155249.2891305-1-csander@purestorage.com>
References: <20250923155249.2891305-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: remove redundant zone op check in
 ublk_setup_iod()
Message-Id: <175871451630.316144.8713000663758942668.b4-ty@kernel.dk>
Date: Wed, 24 Sep 2025 05:48:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 23 Sep 2025 09:52:48 -0600, Caleb Sander Mateos wrote:
> ublk_setup_iod() checks first whether the request is a zoned operation
> issued to a device without zoned support and returns BLK_STS_IOERR if
> so. However, such a request would already hit the default case in the
> subsequent switch statement and fail the ublk_queue_is_zoned() check,
> which also results in a return of BLK_STS_IOERR. So remove the redundant
> early check for unsupported zone ops.
> 
> [...]

Applied, thanks!

[1/1] ublk: remove redundant zone op check in ublk_setup_iod()
      commit: f85e254b51aeadf8dc367aaf2fbd2c20378f75c2

Best regards,
-- 
Jens Axboe




