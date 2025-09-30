Return-Path: <linux-kernel+bounces-837324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C48BABFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D353C6059
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7FF2F3C27;
	Tue, 30 Sep 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bM6ttSNo"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497B0255F27
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220532; cv=none; b=XqLhbZd2LStbOq/xK78KgVooftSF1B8WWWOWyRXzccl/JVt2A3wBLkRqPTiKiJ1mvLD7LICh8tEjVs4Zk4v2A2/de1zdOlfMrLbuEjAFv3EP9A1ZtWHyi8V5GfDaFH2E1xw013rH6Ng85Og7CBFZBT457zUvImEUtlGumKqm4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220532; c=relaxed/simple;
	bh=4pE3k2VBU5zrdsB3CR7FkZwhjoZcQukX7hsPH5UvQJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgXg6KvEAzaTFmipUaJ+UO3Np5mDxqt5yKj64iYG42ZlSdmvAQzHe5Tvm6tl4iRbubjYZQdB/zRqh6XpVU4tQc7XDfDmdTwBdHTn/gVBomk3lOdzoiy5nIyKUVYDHrtVoJB4AK5TJ5DQNNugTey4coqW+5ZoJKf5HWD2MiUCx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bM6ttSNo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8582a34639aso375974885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759220528; x=1759825328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0MYOqdthezk2Y5aWzOzKpk43i1E5SPt8BTiExHKtReY=;
        b=bM6ttSNo7otdGv4BLNxO4zMnBWW2WYdy6KSDTZKB/1BEq3d0PR70G6GJneitZdIHYy
         aCP5mWEkxZb+CuEYPJ1vGlBizeawQQgo8g69L/w5lbsTccSWZ3YbXvgXBrrTDq9Qt16L
         dmYthKXDpPm2+7dSnvZf/vlsNxxJVejrw9GTEZQ+kTuu3eKsEUkKI+kgfMGiswQWJdit
         4GGsIHzJMFTnDD7ZisryVyJTj62d+DanYSpzhtvReMhMQaaHC0Rc5rZb7qY9WKtbDZIR
         t2qhharnKWM2BGVsCAK0RiJzh0eCQkxjEPDP+I+9KX4ZBR48h3So8GbT9ACZz3jBPPxf
         BeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220528; x=1759825328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MYOqdthezk2Y5aWzOzKpk43i1E5SPt8BTiExHKtReY=;
        b=p0dvHeg2CfQIphE6KpnERG0601g2uvJP1g4ztbR5sTXYztOTTcWXDWnPWqCvqSrYuE
         BE6UCMphye23iz5NewPl6wHehUQiXZD1Ab+DnwtqrBQ6f5UguA1WrbeWEnkOkd+X4/O3
         tbvlBDEeeylzvuDA5ZgUkTTovApkERoFFOCwfDp8gdlvDskUG2vowB5V7cIdYKCBOh1K
         wq51SsmxRqCVpgPAPJPdAuxRl+raM5p91VkTXJi7g3DGGTk0cDOVr+Gm8UkSFTmMSF+F
         V4+taYSh38rlrwCk5qaZ2Wj2H7kSvI8uCfcQ5wv1Qgq7JMac3+XqSxG0h4r67KWfcWGT
         FPew==
X-Forwarded-Encrypted: i=1; AJvYcCVxW5QHi3TyRupknyEGOo0zimU2CEKt7Stx5hh2lnv0DYWulhfOvuNB5mJXUHuq6zkEq1D2H9fGzqsgSJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+Bh0rRFZAz4v0OVH+jw9ZztxN6DHr0amCx9SDZkk5QOwauXs
	Mw31cM3R8OcbhU1dvhsvhj5IppuIz1X0EFwkC++ujdQQkOQrvquelV2PVdtlbJbkf0jLQ17zcFU
	FnB7ioJSaHaSBEToCsB8qaW6g/p635KL1iZ9jSyTRLQ==
X-Gm-Gg: ASbGncuVFbL9D63MKJkcA8GB4y70IiMZWdsjzyZNS5yKLFR2+eG0ZAIa96LurWdIw4D
	/zqKpNBaKezXDzgc9de0BbnwzjcIlJGrUlqwgaJNYE9Qz7bmlT/gqGnH52f5s9msy02VvQ8N/0g
	fUbXt9HwnLQ09BbQfmOTDL429biMPudswmshtNXcYsWTo/0f31veZ7iSEV6izwE7DUuYQvRxsfs
	zBQJjGZbmDv/kWtURTsXCT3qNMT7YcD
X-Google-Smtp-Source: AGHT+IFFpQTgFBa/WWGnT5QFcu4l0kS7gkEATk8JWkO6XxM3M12kz6g8Ct77aVC/3wWZvw3xXRdgjGXw0bvG4/9kIY0=
X-Received: by 2002:ad4:5cc2:0:b0:81d:6f27:aff9 with SMTP id
 6a1803df08f44-81d6f27b588mr167506256d6.56.1759220528215; Tue, 30 Sep 2025
 01:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821031514.49497-1-yelangyan@huaqin.corp-partner.google.com> <CA++9cvojHApEr0b5ZbRNVjYtWvCS8WmZ-mrGMDh5O9mp1fkT0w@mail.gmail.com>
In-Reply-To: <CA++9cvojHApEr0b5ZbRNVjYtWvCS8WmZ-mrGMDh5O9mp1fkT0w@mail.gmail.com>
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Date: Tue, 30 Sep 2025 16:21:56 +0800
X-Gm-Features: AS18NWBUsQkpqXkip294ozPcJDVep0TBrUZwRk3B4uL8u_5nT6ff_J9AvEre7T4
Message-ID: <CA++9cvrDRU4PStp82M0oz-ZtE-1fuPnMOEfMw4uv3wL1_DoYiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add tc3408 bindings and timing
To: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org
Cc: dianders@chromium.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Just a gentle ping on this 2-patch series:

  [1/2] https://patchwork.kernel.org/project/linux-input/patch/20250821031514.49497-2-yelangyan@huaqin.corp-partner.google.com/
    Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

  [2/2] https://patchwork.kernel.org/project/linux-input/patch/20250821031514.49497-3-yelangyan@huaqin.corp-partner.google.com/
    Reviewed-by: Douglas Anderson <dianders@chromium.org>

Both patches have been reviewed.
Is there anything else I should do to help get this series landed?

Thanks a lot!

Best regards,
Langyan

