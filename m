Return-Path: <linux-kernel+bounces-895681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7EC4EA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C5F4F4378
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71705309EE3;
	Tue, 11 Nov 2025 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zw4y/LOE"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AB027814A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872908; cv=none; b=FWumwBca7EXGNdndQgar6QiNVrrcZrT248lhGDHRdy0i+vRa/zTYgypOe4BF5LnB7dqExEHMg0u8Hgyeak7Wt1ebGPdcFdZSNtsWpUtNTXFf3mJ4AwTYJqrUZ5v8h6/qSF/vvyRvRq9/1nbRVW+ITomwegLfRpXByP9PbOVGMEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872908; c=relaxed/simple;
	bh=Pc086ujvScE2BI9hiMALfAHgXYz5Z656q27m00hb3To=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sqCuGC/tiwiXdehdZI6gytSNjDAR6ztBPvDYtDW2W+AzfgsDAPRQZXkPJfUY8d9BfiRTrjI0nZFI+3fl7R9eeorOsQfz3JWCCtZjn923sP7z0SdazaeHO7e3ZMSC3kKsL0Y2DjUV5mrZPiyNBkEejaHq8mDZLjf6KErcvNZm5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zw4y/LOE; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-93e7d3648a8so167495039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762872904; x=1763477704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd60/KfMSWtIeVZjWzA7tGiHeUAva3B/1z//rOpfIQw=;
        b=zw4y/LOE287jm6K6HVPtVkEOlEeIcCJRNRUEjwlkMdRAnc/su6+SQ/zIOK4hndN5B2
         fb+4DGpQH7D+V3yq5dhHsZ78w5xQ38SLm/3rJ+hwfAf3pxZnuc9NmmqfFp4x/WA4G7BJ
         Vqt9Xaa0zCkxGK+UpwHMc32hhvZteXjl6r4b7gT2mPFtY2UilHHk3gP8o17oi05ay+nF
         sqkYR+ASvcqAn7CVJI+adySa7hHCS+S50TM+2dlno/ErCtFK+HCki0a0JpPzKpq9oG8G
         oIew/J9HAx823uccYExYzF/JIuJV5A1PGDlkJONBmGzkmzkBXyaajvm/MC9CaxdenNxe
         PyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872904; x=1763477704;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vd60/KfMSWtIeVZjWzA7tGiHeUAva3B/1z//rOpfIQw=;
        b=M4dGLcoYX1Y8OOpFFPflAJGPtx51Cbkkhl4HUwQWEKLAnsCJAqqZGiQsqlG8yBTQtD
         j2jb+hAa6dzTO9EnoXEyVeXgI7mB41QiRmuQVAuLIQlCL11amui1VpKKNBylJLwB35a1
         X1s0FCUcJqGf1qdK65IQPEGAAWcQsoQfCjsd6dBVGPXL4wuLZg8L3wFUlsn3nGZoAlVS
         +0YGydM62S8goWpoLvPIt2LlYXr7yo7bKQJtOZRBxlfKAQpYvcKK4KaXwXGeF43z5ww+
         taozQu7y1TXYKPQ20NTM+J7ukiQkQmzUfPo4dcO3szECC7gqu5mszs/iKlkHjcvn2wfk
         QT0A==
X-Forwarded-Encrypted: i=1; AJvYcCUPy9qR8S8pKihTy6yjUjTcGKShBJ4cdj+tGN+cM0nyNuQr0AjyIussMYXN6N6g1fgMgMmrpgcaml9xLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbgVUIEYlLA86dqaKcG1szhhQoj5i6NyUCzXqqJDtXE12KDfv
	qJOv3zX1SJZK29DkIMIGj+265XR/kPVk239mp+MTBqsy9SPrl7GlBitcbthfl+URDvY=
X-Gm-Gg: ASbGncuQeIZfUmPsRSEmgOt4Yz9atc+jp5muUPcwlmV1sxIoCVL/tgmoiXhAGz9vqb9
	7lboKut6bJtNCY1OlGZaOXTmxSONdKv/6JRwZ4HEuLUHWQgNNQbc+5KwgLBjKw0YpeK8vqNEc+A
	gx6ytVBRbVSxc60lHzHhi+rK0XyHHAp/Le5Q2QkJmfgrl7MLdkY07edMphD6lm0ash6HwjVSQBW
	RfrPkkHBxgs15FW0TqVpNOFOCnpOup9XMaaKf2DCLwY8sROM8VkoTVPxydCPoIKeR++dJTXgU3l
	6l1TVZtzOkCBHw1S0aKX32ZmeIAajBmNTI1qv7rNYE7clx2LhGLxH1cIHr5+SYBENzFsg4wr7Gy
	0a6BQUCOz67z3ErjeUPFKqohOp1oJgHJiSmWGOMtFfyFL3Tazdg3Q+fXdzodNQITt6y+toXtfFd
	GXtV8=
X-Google-Smtp-Source: AGHT+IFMYYVFn/FWFoI4cBgTrfFiY+nGqvc8CTHosZF05Ixu1TUPMtPgPExq2cQbx0wbLmmkWOTIQQ==
X-Received: by 2002:a05:6e02:17ca:b0:433:5a9d:dac6 with SMTP id e9e14a558f8ab-43367e7166fmr180713905ab.27.1762872904081;
        Tue, 11 Nov 2025 06:55:04 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43380302872sm26311045ab.32.2025.11.11.06.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:55:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
 houtao1@huawei.com, zhengqixing@huawei.com
In-Reply-To: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
References: <20251110124920.1333561-1-zhengqixing@huaweicloud.com>
Subject: Re: [PATCH] nbd: defer config unlock in nbd_genl_connect
Message-Id: <176287290263.173215.8003110522218932458.b4-ty@kernel.dk>
Date: Tue, 11 Nov 2025 07:55:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 10 Nov 2025 20:49:20 +0800, Zheng Qixing wrote:
> There is one use-after-free warning when running NBD_CMD_CONNECT and
> NBD_CLEAR_SOCK:
> 
> nbd_genl_connect
>   nbd_alloc_and_init_config // config_refs=1
>   nbd_start_device // config_refs=2
>   set NBD_RT_HAS_CONFIG_REF			open nbd // config_refs=3
>   recv_work done // config_refs=2
> 						NBD_CLEAR_SOCK // config_refs=1
> 						close nbd // config_refs=0
>   refcount_inc -> uaf
> 
> [...]

Applied, thanks!

[1/1] nbd: defer config unlock in nbd_genl_connect
      commit: 1649714b930f9ea6233ce0810ba885999da3b5d4

Best regards,
-- 
Jens Axboe




