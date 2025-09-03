Return-Path: <linux-kernel+bounces-797561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C3AB411E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1420C70238B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 01:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93E41FBEA6;
	Wed,  3 Sep 2025 01:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0OIlR5gc"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179801E9B0B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756862509; cv=none; b=MutGiz86bqWUCd7tLMsj7Rt2a3DRBGSAqQ2bH1csM5i4dUgobsgEaNPRoJf3Q1EdyW2N0FwyOnKtvlFsZ5b8ozw87YpUe/6fc3bY4sJFKupABamGqMqo6m6HPVLJNrPKkmLpxn3EndI72ZO5VD/lBf7yJNMQgTen4jlQog7p0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756862509; c=relaxed/simple;
	bh=tSQUCTJc0B6mCqPpSe5HPg5FHEPKsayYzH9TbUKp4aQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XqtSYaBQ0tOZPhpk3m+K3rSOpZLIoSFad5cQmhCAePUiu6owlXRKjYUGNEjw9RyVQI7OVqeMGwj/frWSPF1aZ5rYKOjhCWfzmqeIbrKaGIoC88NxyO6KBcnOoID58e79zGApUtohnmOyn9jgJhEbfPaNnqawd8NhlStTFp4l6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0OIlR5gc; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432cbdb8bso63249939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756862505; x=1757467305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4NIOVQpv6RIEBSqtyyz+LY0rABAsxUnVqFohJq2RFI=;
        b=0OIlR5gchJccOSdersS3RXgzcFbQdwMAMhIQ/40UOBPObQSL82gqeBNzsm8YXCi6LK
         sNRHkJljvYyoOeqDgbuy7Vh6mI7CimvwvASAfl9zFz8caVLxWaPcxpEo/mq1EugRxeih
         NZC0vnBL28EWvO6xEvcmCPh7FcsyTl2xTZQmLRnVEK4Q0ePoex2pQPZNCd5NUN3eNLk5
         0AEvyArcDN4Ih4zbn7qWR4XY/0DMI92XCpt9ItQI94J9LNRrJVs7/pPRVaDDUTvq0SGy
         qvde2ILqoBemRM2ii7a0ENCczI1m5TpfPk9ROM2pr3yYQIhfufpShARkl6fxYjbWjH6r
         vO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756862505; x=1757467305;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4NIOVQpv6RIEBSqtyyz+LY0rABAsxUnVqFohJq2RFI=;
        b=bgsZ+RS74C6GhKxyx/zgOCGlnjWG/YmvQQNRaVv6JbRX90TkUzZ4NajoYr16nPXdKK
         uEdbMoB/rvGYI6/SeIkuq9ZhaaGy0bQHRdKgFv/ORCwQbcX06nk96Pu51eI04VJ0LzZ4
         9AxIFfPxEPAuDWXltRlF8579VJzY2xScykf38c0DJdAPHJgJvCukQnzGOCVIL2ppc/bZ
         hxp9rRH2DkJLJtwAkOR+ZorM59IEr16WCNL5kdtpZamb4EDlJ2voVPbSsD7S+hmqq8Nz
         xgm9eHamTXYBKVyOh284KSX5euHMrTjDccUsMpnUXVGjuvn26MOqbBWLolfduGNxP0me
         M8fg==
X-Forwarded-Encrypted: i=1; AJvYcCVXpwzPth0tvQLf76zIXIuMXbyRINBYbVfl412cLAboFIObLqKMOZt/RT1c1NAWKmC4/OPFpDNXnv2Kokc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0PLbjI1FQ3iBbqB7D5vRCdj6rc+UJLl5UNXu50TZ3+RC2WZg
	TtFNTuE22SQAq35qq7v4QSrSl8Q7KLpzg0xYibF7R/Ox4Qrf4ap6IO1rVm6US5uvAy32TZP94Dt
	2/+10
X-Gm-Gg: ASbGncs0fcRy6+xqylR+JJQahmOJ4p4CIgAzE6xJezfuzPLiBZoeefIFoo7cdcDPE5I
	7XjduZZgG4IrIQUZ2G2J3SvajWKR3x+pncKLWqh+dbJfZhAbvK7ntLejNmjMwcP5T+6WJa1HRez
	h7M13D0WRtpCP3KM5ghNPDtcGLHQutmvDuCirxF2Lzc7IAwslHMYZJl0V1cTl3KDVWn4oxT5dCd
	Nu7dEwnCcKV/uw2/vGC4LafUbzCHGpLD91t/Nc8AUnx+gJ28PjK53ePJqIN+vWuXkdY/tcTW4Xn
	hCOquzdGl1HzCMP3rv+EIgQZw42AIGt/XamBlIVfyJec7FLZj9hzz6qh2NFrs7l0w9+61lxQQfK
	BZp3LXpalMyV/vx6BiJTWngE4vhvPocJvR760UZxdjdy94l+t2IXXsg==
X-Google-Smtp-Source: AGHT+IFTHza/jI5g5VkO1QeePpLnsb6+uz+U51iDGQOHLDSSg+FLmw/SKGCOVw/bx2upSp6dOQxEow==
X-Received: by 2002:a05:6602:1614:b0:887:4a5:b9d7 with SMTP id ca18e2360f4ac-8871f41ea47mr2701292439f.4.1756862505498;
        Tue, 02 Sep 2025 18:21:45 -0700 (PDT)
Received: from [127.0.0.1] (syn-047-044-098-030.biz.spectrum.com. [47.44.98.30])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31cc0dsm3662537173.38.2025.09.02.18.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 18:21:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902160657.1726828-1-csander@purestorage.com>
References: <20250902160657.1726828-1-csander@purestorage.com>
Subject: Re: [PATCH] io_uring/uring_cmd: add io_uring_cmd_tw_t type alias
Message-Id: <175686250399.108754.12103527747945353586.b4-ty@kernel.dk>
Date: Tue, 02 Sep 2025 19:21:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Tue, 02 Sep 2025 10:06:56 -0600, Caleb Sander Mateos wrote:
> Introduce a function pointer type alias io_uring_cmd_tw_t for the
> uring_cmd task work callback. This avoids repeating the signature in
> several places. Also name both arguments to the callback to clarify what
> they represent.
> 
> 

Applied, thanks!

[1/1] io_uring/uring_cmd: add io_uring_cmd_tw_t type alias
      commit: df3a7762ee24ba6a33d4215244e329ca300f4819

Best regards,
-- 
Jens Axboe




