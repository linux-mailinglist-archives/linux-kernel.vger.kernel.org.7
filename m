Return-Path: <linux-kernel+bounces-741184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A933B0E126
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7905811A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4234C1DE2B5;
	Tue, 22 Jul 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xt3xVbJs"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCF433A8
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200159; cv=none; b=o9Me5cVgI3WvjAxGTtCx1LU7WqRIg0T1MWc9mUrvLIKbWudcMWT1IXhtBcXKRk0yKy9vbsNbVHTU2io/08A6foUMi8qiQ3IWYuDbozi0B/C/dSS0JYZnGfPFBTxxgCwLH5eAVEXcrTHCWc2SFp0EsAqxKJ0SPy5vZVUqD88/xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200159; c=relaxed/simple;
	bh=noCp+eXK33xOruhl37s/mqn60tBI6l0AIHoZYe0gMCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pJvvThpp6COIRRmjN8tSxuJ1+8r5rEDj96g5h+f7Wjdksi7NAhh5RRY8viMPKfrE7l0YxmdDpCz+Vtfxy9kRjNnjl+nEF5cPpCSfUA79/BZP4C3ahNfWRLIf5yJcOq4vs2JShSB5d8zAtnlToV+QZgJmMi+4HL+yFFrAw4orJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xt3xVbJs; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-875dd57d63bso1829639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753200156; x=1753804956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=xt3xVbJsXEzkPhPitoRtfx5sqT2K6sM94IayNFRZvpJe538HdUludl83xXLiAiaPbI
         Y+DTlJBMwcLQrv3bHNIiwMNS0qnBgk7Xd4BH81HI3fOlhhkoeNfLRJDBCbljhjedtxi8
         ly6ura0OF04Jsc799gZ8ZEmzRJ6R8akr3Bl3v/czMOyA2Pf9n+NJb/5fzjXnYZ1Ko0Yj
         M/X9hccYU/7e/aJE3bFdYuJTL8E9g1XEAGGpBbl1isaykTzDpSH5ghfBGIv/bzK0QPph
         6+aXJgEOh4erjwbahzyOonudSopGu0r8fuz0ten8Yr/mnYl4pfhEJAGoTjq44+JG74jC
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200156; x=1753804956;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=sIw9z+caOi6veY3m4tgv4iIc/rDktxDGGiVy5wgY3BDBVvl5JDmOyVrViljOMolg9p
         n/TTeKzdzaGCld1CwJAYzFpO2upu4QImYgdtjggNv8oJzvpXLmFGAArxV40xqqBdJO3G
         t9FcFH7RnEJqu+mDr+Jo00d88P7TqlUVIJVhSzOjPt+Z8BmeMvkV8AYU4icECI5rxSKO
         Ah5LQIBicAm0fhDaa+qSplRchB52WZthyQU9YtSohMtqtoxNb01XODyePSfEwNkZU1K+
         Om+WPIXVK8lnQnVh3pub+VKfPxepRtuasXQML0Gd0PEGwnsxmpvRRk0I/ya4XFNgZ2Vm
         TOWg==
X-Forwarded-Encrypted: i=1; AJvYcCV3566gyKAc21caKqn5I1Ip9OHlcIRsON6fioYXiwbJESwMqO2Ok2uaKBAmOOtwKJW8IMh/DfR1cBnvrWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCPf5wNcrcYTCvlHA9X6nNKlLOhWPKKEaQdCFjEB35ZC4y295
	vPPxl9uSoeEPqNIrFnt4ecuYKBqX9CKjEYdA308EwxYawlKIwdQF+jJJidIYf5PZysc=
X-Gm-Gg: ASbGncvy+3eHVYMnfQaSej/wfmqMRuI9ScOn3ach68Bw6iQF0W7Kk6j7iFHwBkPaZ+W
	SpuiAS1zWhk7AWYXv0bqnERpzVvD8F+fjWsndZaGICGj7idsl2iK6snB9N7zrmk7D2wIZWRFLr3
	W6lo+fFup1H/U4yqKbX18WZOgv1JGNmWLfri0yL3Z1X9TjvXin2N5NY65w+PO8UAue45UNREgjY
	88v0OtO9OMlE/h6xtTGsUlummcALr387n33TfM7NkmlFcnz6rGLHZvmkEtfddwt2PNa8yzz37/8
	Fo1l2Ckwf6ffnYgLw1LLsHYTIYeB8EtIrWDu3DXzpzw5Bq5NPbiTTlSc5gca+iMifRvENBbqPZO
	ZzKeMazNya/8K
X-Google-Smtp-Source: AGHT+IGwFeinDrd1apvfPiLCe115kkPKtu21yo+ZtYpYX23SlO5YPHk6OgHUI5gPbzer2SUz6HNeAQ==
X-Received: by 2002:a05:6602:7417:b0:873:1e91:210e with SMTP id ca18e2360f4ac-87c538883bcmr676458339f.4.1753200151901;
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca62884sm2493638173.123.2025.07.22.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jim.Quigley@oracle.com, davem@davemloft.net, sln@onemain.com, 
 alexandre.chartre@oracle.com, aaron.young@oracle.com, 
 Ma Ke <make24@iscas.ac.cn>
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250719075856.3447953-1-make24@iscas.ac.cn>
References: <20250719075856.3447953-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] sunvdc: Balance device refcount in
 vdc_port_mpgroup_check
Message-Id: <175320015081.186214.5828107139805643955.b4-ty@kernel.dk>
Date: Tue, 22 Jul 2025 10:02:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 19 Jul 2025 15:58:56 +0800, Ma Ke wrote:
> Using device_find_child() to locate a probed virtual-device-port node
> causes a device refcount imbalance, as device_find_child() internally
> calls get_device() to increment the device’s reference count before
> returning its pointer. vdc_port_mpgroup_check() directly returns true
> upon finding a matching device without releasing the reference via
> put_device(). We should call put_device() to decrement refcount.
> 
> [...]

Applied, thanks!

[1/1] sunvdc: Balance device refcount in vdc_port_mpgroup_check
      commit: 63ce53724637e2e7ba51fe3a4f78351715049905

Best regards,
-- 
Jens Axboe




