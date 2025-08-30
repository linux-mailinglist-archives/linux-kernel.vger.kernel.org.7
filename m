Return-Path: <linux-kernel+bounces-793036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7712EB3CC81
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A0B1BA3063
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 15:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9C2857C2;
	Sat, 30 Aug 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="bysNEgtY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AB284B4F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569520; cv=none; b=L9nYHvxqS63YBlu2daoAcl5tiDE0P4bNL3iY+U4rAZU0a34xw9I4yTFbo4KLJOO6RqjjhByUAGmuECPHUUJl+NsyfT+WYxjw4eNSDhhRn7O1ALjKfGeex6RP5TUmw9M1BAVo8kZVRMsZIaB8uzVZGMQ28nUhQ3z+k0e0cYbzW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569520; c=relaxed/simple;
	bh=M67VIf2LnguVOfjjJ2dtA/J6bLeW2cV6ngdi3Mm5Clw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ob3dwhO94ig4/fgxqFlkZM/H7MrDDi+kDci4TYefC53aIX6d5z6j/8YDYo2pZXSCECebZXDPu/GkAvtGsUCPWmhW6WpWSYpUUHtuMpxWgOq3EmUOFaQmpoIrMblI0uRQekESSF4J6PB/LIqb+fCjbSX8VjVJrgxjVwMRKdLMEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=bysNEgtY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b883aa3c9so1404705e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1756569517; x=1757174317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABownbaUg3AHmPNhjojTuZnDvYFZmQNhHDZWniNlbg8=;
        b=bysNEgtYgSbsHJiiUGZjOwThxbjGYMd/WZkex1mNzeU6ThaRoNPW/vPzm34Acg4NB8
         7nh7K76OLRwm54ysx6oSNNTZzHTRY9RA0GV4XL6r/yT1Wv3cTurJ+Y3/Zj87Xz5L7Ogp
         L2a6w5z0QtykLw1H+6QGqp1e9OWS9TZzYefdrY5nxIkq0uE4hpK1QXNuIPlCqvS1SmHW
         v9uLxe59zcNHrUtwtus8KHPofKfma4yG2cxT2wODpobqcPusgCFUSGXsruCSSwejjlI5
         OZ9/WldoFvVrpQUJq8r/QlFVmJHOtP+JpOgWYTe8tNRtGKTdj7/Vu5+EP9d5hZVodFPS
         OGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756569517; x=1757174317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABownbaUg3AHmPNhjojTuZnDvYFZmQNhHDZWniNlbg8=;
        b=is/lBJ7YU9oX1IuqU0QJmuhKHuUX1yErvTUdZ+Z0qP2dnZMiDht+vrunJ49EIi5LJO
         UCxlDTQUbA5CkmZ65Weha2TOSUgQYMSYe4kpOwOW4MDHpmYGJSz5IMXSsdqVtfOGVnDK
         CperNuIRxnIF2ZJfOKg/6GafNXOnUTZ5PWt1UPE3jiEQue2DsIaI5g/BdIuQvbuW9cQB
         +AkqFrPC+fYOVbXFtk53ErAHw5EJXjPTLD44/V1tqyiyX7VzFjzIMuJ1xxVg0iHniG+c
         UNL1DWXLOcphS3G52Plpvq/3MIQxfz9BnluiaMQ1gByOHXwThnQuSa4aXxoLLkY/fdPN
         8eFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZJAplABhza1N/05r/8N/vwpi2cNwMX+lMiuEf9i+D1a27r5eUKqV5pmW4PIW8p/jk5fF5DHJoGnGsqEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmmmykaixptGYoKYxO1kZgzoen6/P73riC7lzW9Q84kDKW39P
	cSsN0r26zRnOzb8ucPEDwZg0qeXnhhW02M9nVsh6Dw+QT6DBhz73pKmmyNG2ya/V3uQ=
X-Gm-Gg: ASbGncuM0X6yIZApNq0WwtYlY+HK6gD0k7gAmCcs4tD/FIU1FfNoWU9lk9GSqiP1kCv
	rMkuoiHYxFCNiLBNC6uM0TXOp7edIi7t/4FyvA6CQdfRPUF1WXCEJBpCM78Lxn+VBn/X8aR9Abt
	tlqAmpmeKvMWaDtFJLndFsqRZ9tqFgFL/xANGt2M0WIT+ue2TxzVgnt/2fB2IR76FdJTU0JttAi
	Qa+4XRAHu+H6LUqrTHyMEaZpbA1Vnu3x/0O4MZksnOUfR5UBajVZd/3M3P8Qc1n9mpSmN5XrCUo
	BYwIAzcTx4+DmolVrLsf9wlUgWM43hYfa/cXjZRoUk/UFAxlBaX5CGBWHKB5/MkFDiHdBBCXl1O
	iO7pSSGaJaRuhu2Mv+7HucxZU2jE1+wx5MPamhvcu6Q==
X-Google-Smtp-Source: AGHT+IEDQidOEd9iz7Lacwhs555bnsIebla8gQ1GfjnC7hwy29HMkMsV1OD2J38Qij71+3dVPlwrBA==
X-Received: by 2002:a05:600c:1e8b:b0:45b:8324:d2fc with SMTP id 5b1f17b1804b1-45b8549c384mr19560285e9.0.1756569516942;
        Sat, 30 Aug 2025 08:58:36 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:d876:81b2:f3c4:351b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fba9fbsm7711205f8f.50.2025.08.30.08.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 08:58:36 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: krzk@kernel.org
Cc: asmirnou@pinefeat.co.uk,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	jacopo.mondi@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Sat, 30 Aug 2025 16:58:36 +0100
Message-Id: <20250830155836.10254-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4eee57c0-a2fb-4fa7-bafe-e3a41c8954bd@kernel.org>
References: <4eee57c0-a2fb-4fa7-bafe-e3a41c8954bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 30 Aug 2025 15:21:46 +0200, Krzysztof Kozlowski wrote:
> b4 diff '<20250830111500.53169-2-asmirnou@pinefeat.co.uk>'
> Grabbing thread from
> lore.kernel.org/all/20250830111500.53169-2-asmirnou@pinefeat.co.uk/t.mbox.gz
> Checking for older revisions
> Grabbing search results from lore.kernel.org
> ---
> Analyzing 9 messages in the thread
> Could not find lower series to compare against.
> 
> You are not making it easier for us.

Sorry, I know how hard the reviewing process can be.

To compare the differences, the mbox files can be created manually
and then a range-diff can be run against the previous series revision.

b4 am -T '<20250822171041.7340-1-support@pinefeat.co.uk>'

b4 am -T '<20250830111500.53169-1-asmirnou@pinefeat.co.uk>'

b4 diff -m \
  v4_20250822_support_pinefeat_cef168_lens_control_board_driver.mbx \
  v4_20250830_asmirnou_pinefeat_cef168_lens_control_board_driver.mbx

Let me know if you'd prefer that I submit a v5 instead.

