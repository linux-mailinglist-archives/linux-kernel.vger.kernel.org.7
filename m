Return-Path: <linux-kernel+bounces-722148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57AAFD5DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59FF3AB33D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC52E6D08;
	Tue,  8 Jul 2025 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q1WNK59e"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779E21A43B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997618; cv=none; b=ZciqcOC2LYNStgMNJOHOMljFmjzgUFbHbzgTLQ5pfxllbVhyfxkCxZP/BajO0qch3AiBHvd22fAYSf9KamSipSD49zHJYy00H88Sgjpcol60FhpoySIUjkaPJS54hkGlRr/cL43Tm1FIiQ32LDZ/Ek7ioMQUMiaL5G3Zw0DJHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997618; c=relaxed/simple;
	bh=UtBv0aeoJSL1jBusVGKSnn9luAbvSMV72LX8N498vKs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YajCL4BZD6QZzA0r4+PYqP7GHGjDfqCve1tNeNZFnF1qmdrHR43MbBu0lBIDqFj3ftgM5PoUE83DT2E/VNi4bo4gdCG/400WxeM1BLRFuz9delluHqrR+KVxYudGlDRoEkMQD79PhlVkxNsh+a8jMWYoz5nXIf+yRR2CyohPRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q1WNK59e; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3df2e7cdc69so13967855ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751997616; x=1752602416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTaZVsYCFHrHcx2ton4bjQXkjChOR0CFYCOoEbLvagw=;
        b=Q1WNK59eClXXPZblj2cHuShtpaR6IYwJiuVdzXzD0Ix9kgGYRvOrn64GLtvBFltq7/
         diphc5JPb2UzMpZKixudWZDEFGMJfGA+kZHcS+4IINWlPM/VqdQW2ODOscriZHlti1sV
         SQUQAzp4oTPeqUdYLTXCsUwGNn6mnRwpc08K8fmu0O+Lumsahg8NrvASWDQspn6zQ41S
         kFKZvrpHKh2LTyp930gh/be6GgwUlcDb8Jjdn5xVt5TmPnxcNiLFSUe6nw5uoTaNYNT8
         xkYNwBnnzY5GHgO5rp5/Zg8I8gB6TZjvgStRLJGwEPaxYKVQnT2xrPuQmofLJweMaBJV
         02UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997616; x=1752602416;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTaZVsYCFHrHcx2ton4bjQXkjChOR0CFYCOoEbLvagw=;
        b=telHSTO8gtFFZkIArj7JXVckboVOxxnu4P7pdszKcXtv3v8VUBW9p7S8BueQtZRtnM
         2+ojgeuBqLbEJSjH8LcECbskJsj0/s4f/YYE/2ovHxbXOZ8hRDru+0Ic/KjVYgbmuqv/
         aJvkta2TaCoXC6T3NfAtIhOQObe6ON2fMsxqXT9H6Z+OtjK4+YGQanAednYw/stLrJZV
         7454uE+uThdIrMoFs/i/52ysXPHsU0Kivu7b6AGq9IMT5NWSIqEMndX1u3o8tEh2j2+B
         ZLPz9LoUyv42MDfcmoaz1tcaWkpd26qrmY8izo1EXOlH6LGjuQKFonfP6gAB/XVDobP9
         2hIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjTQShR0XYZEK5vhG2ujspvEqz/6B6U842bXVpzNbxLj9Y/mYp48nruu4aKp91+Acg5PKlr9HCypd/1gU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBm6zMfVuXXnllh37TlBomovNaT3hk1cpLmjXElsarSBpzE3wa
	T16IHhTirSvRQfEc6BPy1kAfJY8VY1wtrtPxe2N16wXFscXDeIKaEokM90kt4ing2co=
X-Gm-Gg: ASbGncstRMvuickWU5CNinzpRPBah50wWTK4d9/zSaabdanar9/1xhDm2cx2c7HheM9
	HTwHRX4GIa5JLqy4Ro+um96oi3D2Wt7an+PRV/D56JamqISPdrZitn08RZj6H3KYOp5OfirldZU
	Gb7W9jOgkNwlIkfvmjglZ0Z4+L0gNk748lI7vM7m4FiYsoK2O7jD9vCuHXjvgGY3mUBGOINeoSg
	wJdRC2621+4Kfs+l+dQJwuobxISBUd6yzqUT7JM5vdUWa+C4Hbn2v5iBbIsFuWo7vxozvxJa80S
	vJEoh87qOucvfOTh2RVG9LCR+1sCQw43zKVJs+MwuwS2SrEA0zVv
X-Google-Smtp-Source: AGHT+IGf7DhyE6cPFBeAzzxZ7ZZkWyuGsVu+jmKXb2eDm4gaRTMXmMIKPbVUJim0L6HTPNaocIyEWQ==
X-Received: by 2002:a05:6e02:18cc:b0:3dd:d995:30ec with SMTP id e9e14a558f8ab-3e153a67248mr59069015ab.12.1751997616011;
        Tue, 08 Jul 2025 11:00:16 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b59c72bbsm2276958173.38.2025.07.08.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:00:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org, 
 Sarah Newman <srn@prgmr.com>, Lars Ellenberg <lars@linbit.com>
In-Reply-To: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
References: <20250627095728.800688-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: add missing kref_get in handle_write_conflicts
Message-Id: <175199761446.1185853.16712742207654241158.b4-ty@kernel.dk>
Date: Tue, 08 Jul 2025 12:00:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-d7477


On Fri, 27 Jun 2025 11:57:28 +0200, Christoph Böhmwalder wrote:
> With `two-primaries` enabled, DRBD tries to detect "concurrent" writes
> and handle write conflicts, so that even if you write to the same sector
> simultaneously on both nodes, they end up with the identical data once
> the writes are completed.
> 
> In handling "superseeded" writes, we forgot a kref_get,
> resulting in a premature drbd_destroy_device and use after free,
> and further to kernel crashes with symptoms.
> 
> [...]

Applied, thanks!

[1/1] drbd: add missing kref_get in handle_write_conflicts
      commit: 00c9c9628b49e368d140cfa61d7df9b8922ec2a8

Best regards,
-- 
Jens Axboe




