Return-Path: <linux-kernel+bounces-769538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEEFB2700F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948B71C25016
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6578252904;
	Thu, 14 Aug 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="lOhA+ROm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C42472B7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 20:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755202243; cv=none; b=bVyvZB3hQrQQY5XnN6nvaR9mPak1Fz4fWRiF9UeLa7lk4HrLVSapr+J+EDymtPdDE1Vl5VkoHefkomfsrcfjwtTy1PIZcRfr/+bBU7t2R7WPDhqB0ABLAXILcHVW/zhlum1Ui09dlax+WWB41pseq+3fy3IMapNwEyn9HXF41/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755202243; c=relaxed/simple;
	bh=eYgA3N4h05PhIefRPlZZxd2Kvoq2AoymFCQfoY+NFpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dnz0OTYv2ihi+nAnnI2QOQSJK2U+4FLtUbRNiCNBY3eZv5Uhx2aEKoZkLKe47mMgbQiXmLW9D/3cDyRRH1X6oc2cJliX7T4m6lY0f8/r0gZj7JhuiEXMd454lcuwWrywqKTd8N+xOgqOEgrZxni5hVCVAjyXjPWcTSvH9Zne624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=lOhA+ROm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so8090955e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755202240; x=1755807040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYgA3N4h05PhIefRPlZZxd2Kvoq2AoymFCQfoY+NFpI=;
        b=lOhA+ROmf3+IsheI8EuwHGSVkC7SrlZuUzxielDEps0Y0Jce7/o+j8vo4vehsFmO2M
         zxVK7I1Zzybq1KLewQXJxO291KGdjbFpRnNtmRsi0HcmJ3JD6BAGTDq34IyhfT9+ma2U
         +p2y1sic76NdErVYsHbT6rNcsZtBQYQuj0Xvl5iB88Z1gPj3bB1Pd9tHXfgPzdTU2zwG
         pcsAFVCZLgGK6SqawiPxQ9pIqjrsvKDDD8q8qtMnB83BLtfL3NEkih9drlDXjgvGSss2
         KraSIot6V74MIPxVt/rYshNK+IiMnYJwIWcDIoKW+jRZzN9Qbdby/EVk57qG7zFCPyk3
         uexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755202240; x=1755807040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYgA3N4h05PhIefRPlZZxd2Kvoq2AoymFCQfoY+NFpI=;
        b=dDGB1D3ntwRfFKY+4+gVnX3VF6rHMOLf2TPSYRg+rJTPcyJL11CFPK0X4o0Dk48//H
         Fi13MwEOkcwRNPS9Eqx7lKhU7x64yN5oP7kSxxjJkA0T13s1RcXHi5epmWtQGeQu1Q6C
         on0QiXGtaAl6l6fCsXDP+ColUuDL/PMKcIxaDh07do2/ELM25TwX33V85cZWGOeBf5Hx
         QXkMzza2CGMa1dVjWQqB118Soisx/avP3k73Ks6w1L0BmxNggubcaALKAGOG5O1F1Ljo
         Ccnzl2iRD/7KixE10i82ObnWWgdLaGDCx42XwLgOkr2Q2/pEFfkcuU7QYgALXNMqQsD2
         BEVg==
X-Forwarded-Encrypted: i=1; AJvYcCV7oeJBJ0thbXjL3gYzBcIm2AOtJoWjia5iNKf4UdBNP/At/3NRDrmiZPf3C80Yufn2tZOg5qKyn19Uvlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutnV/0jJKzq9SdBhoSMmQ4IUD0HuFkGTdirlQr5RQHCsLfrw6
	kAXymfEm9xpZLFXeKY5kK0Jm2fyrNWGwgSsFAiTZ2KyKe6tX8GbKkhcmxKje9xaFPW0=
X-Gm-Gg: ASbGnct89zUX4wn12sHzy1YNrGl+Vhw+aCJTwKXXDu8N1JI94ePfBa7oGxA9SBG3UUR
	lhvAqGfa08Q4hzmyb3NgZzNlzDUcRn+f3os89sS0aNaXrGcy3z/ABkufuVi4i0LiJ7c5nG5rkG+
	qfwIWGYquTgfM8L7qN0RAJG3R24FmQ+V51SGVJi9MvYC0UCZoN221/dYUnZnJkE8hP1ehWhjuBw
	KrDRAkzDpvT6wL/e1zm7yfEMmfIVf0nBIw7GBmBROYEgDaEJOwUge5VvwGM9bD9OKLsaW8oqEss
	sBZ2giVI/I/g/WafsiVJKmVjp7Fy5HtrXiyxOBIS6OsFn0llR6HBFihPZkbrJKFxMpzM1RFuNdb
	59/RDyPVpvGEAjAiLeixk5MT5a5bT5BEhfoODIbkuSOXwQu/rtz0=
X-Google-Smtp-Source: AGHT+IFKimWuBri2WoewJAsYNvoksiCVAxKmqE+2453BhQHj6EQUXYD9g2OaPfcuoOtVVKHO6X1LWg==
X-Received: by 2002:a05:600c:3b1d:b0:459:443e:b18a with SMTP id 5b1f17b1804b1-45a1b7b3133mr35254355e9.14.1755202239865;
        Thu, 14 Aug 2025 13:10:39 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:8a22:14e2:8791:d972])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1f7082absm18740525e9.24.2025.08.14.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:10:39 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org,
	support@pinefeat.co.uk
Subject: Re: [PATCH v2 1/2] dt-bindings: Pinefeat cef168 lens control board
Date: Thu, 14 Aug 2025 21:10:38 +0100
Message-Id: <20250814201038.15054-1-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814-intelligent-industrious-cassowary-b73c9b@kuoka>
References: <20250814-intelligent-industrious-cassowary-b73c9b@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 11:04:10 +0200, Krzysztof Kozlowski wrote:
> You describe here the entire board, not the MCU only or lens motor
> only...

Since you asked about 5 V, I was explaining that this power source is not
relevant for the driver.

> Can the board be used outside of above setup? I understand so far this
> is only for Rpi where both above supplies - 3.3 V and 5 V - are coming
> from the header pins, so supplies would be totally redundant.

There are several variants of the board, differing only in physical size
and type of CSI connector, targeting different cameras. The board should
be compatible with any single-board computer that uses a similar CSI
connector pinout and MIPI signal lane assignment. For example, the NVIDIA
Jetson series replicates the Raspberry Pi camera and GPIO header pinout.
So yes, the board can be used outside of a Raspberry Pi setup.

As noted above, these supplies are redundant and were not included in the
driver description. Given that, is it acceptable to remove the vcc-supply
property?

