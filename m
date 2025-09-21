Return-Path: <linux-kernel+bounces-826338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF273B8E38A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DC6189BE95
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB08266574;
	Sun, 21 Sep 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="UpO4mQmo"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C41C84A0
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758480780; cv=none; b=PBgXM2S362kruXM8r4NMBNos4l/44us8Skrww+MVtP4ewe+djsnQw9TXf0v3gEgOa09ANDOPKGh78mXvwDWZxmBQgUfjcjIRI2jk0LN/EHO0q7uCtz420hnV3ZdCp8yIJIb4oWfunqdrWMkzM/DgCKetlccOkEF0cyROsjjzdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758480780; c=relaxed/simple;
	bh=MC8psRJR3jjNg3dIH4LXX7tPa2/ymiVUB8mRNj6lCsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aoj1q3s6EeZ+9P79iDzPZ654ZvkvGc4t/vLnU1M629VLZjaI9J4A5QPDYy0IcxdQpqe6LJm5AC3+/eKzMLKVXzUseAXFvbp6MieNbvEArovZI4v2+aRtxSsO0nTdgEQecVRCNqr2JbOlvjU+cHqdw616Kr5EFeGVRsJvIDN58Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=UpO4mQmo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so2087617f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1758480777; x=1759085577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkZms6IJlV9Kq6Bvugi++P5U8z/GfXKW3hq5MRRzeXM=;
        b=UpO4mQmo1r7rHLs6Dpn+PYFmyxtbIC0Ay2aUsszBgnLXijoG0uVD0ji+e2YHVBnrDQ
         Nm3WFyzkZNFE/LeuJNJCXFdmw+Tq7FqW59WUw3W6TtHBzXXjJs+1NxnxXqpGv2LBKIqz
         ZrB7QAZWvhvB8GTyJD//Erv4YSqS+OOU+onQmPxjHB5i92HMLszW223Vo+ndrAeOPWo4
         bWH6rxOJ2pnK113mdN9tn9janw2fyheQ0wyKXGfzPluzVAd5VxIMVpE8kCkpDc4WEFhP
         CZX+JUZBWpM7p5JRpSTLN4g49GHiEi32USDymlFqYzLJ9HC0H7iwx/3XUZwAjTQU7Zgl
         5NoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758480777; x=1759085577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkZms6IJlV9Kq6Bvugi++P5U8z/GfXKW3hq5MRRzeXM=;
        b=HNa989AiE8ZLVpSwcB4YYJZs9m6xk8putftiiRDNfol80xKNjWbp1ZV2rczb5gzY/5
         3Fw28/b7+Aol+7pkzC8C0VXoGsER00vzHcL6XcrPA4QbUaw+ILmCHNEkeqNBKsx+Wt4v
         ZyNO9OF2/fQKRyq8kDGSiAXGEMQMdZV/VqAnLoIslSrywzE0AEaZBODWKc95Zucvk6Ba
         PH0xHYZpMAzz2OhezsFClsTo0u+/hbHSwueni1Zd88dQ4U30xDJtAO4RcOCTlBSTh8qi
         e9YC818uDXq8T9Ka2itxxaugbLDbPb/sbB1iy6x0ZgdfivufyUAjO3wL0xfa6uej9ZR5
         OJKg==
X-Forwarded-Encrypted: i=1; AJvYcCXbtcSKKHQcXEVtB6isuOPPKcP/cVJcWmyRPHzILjCpKT+S7hlttvMSf3Iy/3V5l2dWKydrq4ILJUyWkGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqa7PwevhhuPmy9DzXUAYokYtUPpxuBH9tAQCeXs6NCjBHiROp
	0OjYeauQWkO4VslHRCcSk5WOkR/xsIRwIc3I+n/BqbmVKjDiSgJJ8DnMl6KRnhmyXFc=
X-Gm-Gg: ASbGncukWDALuIF13UFR5AeqmZT0iW/AFHFNM/s+kU1u+PyFVyWu1O+Jnz8CGSsmf1w
	53MNgyMRJzG6cNo3zB+6OCd5kQyGkcDBpDVuneJEuhcedE6OTKBRbCAcYUrd9s6PWlzgrdjZWp3
	DPbICOgYVoTE2yohiXYwOLtiW3LrVsp5oMG8vXweEi/pjB8T9wN8MtuSgkddGMNpasRAw8ICEob
	3vn1f1qQJS0sjsc5FVKZOdxHgfxdWFVDKswNU//hbL8R/pYRNqxZj+MFxJExujIzmCePQl4yaEh
	D3CErdw2QED2fX+alQ4TVhyONU86EbfdUBAEVJ09ZfN5Px20uB23ob31EcUJnwwaZk0T1fDolvM
	080rsXPlNel0VtdZQuZClEHdifHyymfwwjeSrHgQTw+fMQY+k2bfa
X-Google-Smtp-Source: AGHT+IFLokWFX5QQyvB31/3nPAXcA98bLt8kBvJ4UrliwgAEi7mGk/gCusbB300xH5lmm6GEt+I+gA==
X-Received: by 2002:a05:6000:603:b0:3e7:27b9:40f3 with SMTP id ffacd0b85a97d-3ee7db4c3cfmr8908411f8f.15.1758480776576;
        Sun, 21 Sep 2025 11:52:56 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:3800:f880:3b2c:b75f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fac7463f2fsm3468131f8f.39.2025.09.21.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 11:52:56 -0700 (PDT)
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
Subject: Re: [PATCH v4 0/2] Pinefeat cef168 lens control board driver
Date: Sun, 21 Sep 2025 19:52:50 +0100
Message-Id: <20250921185250.7619-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <436efc30-5e54-43c4-9d68-88bc63d71231@kernel.org>
References: <436efc30-5e54-43c4-9d68-88bc63d71231@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 30 Aug 2025 15:20:30 +0200, Krzysztof Kozlowski wrote:
> > This patch series adds support for the Pinefeat adapter, which interfaces
> > Canon EF and EF-S lenses to non-Canon camera bodies. The cef168 circuit
> > control board provides an I2C interface for electronic focus and aperture
> > control. The driver integrates with the V4L2 sub-device API.
> > 
> > For more information about the product, see:
> > https://github.com/pinefeat/cef168
> > 
> > Changes in v4:
> 
> You already sent v4, so this makes a duplicate posting messing up with
> tools.
> 
> https://lore.kernel.org/all/20250824-cuddly-cryptic-porpoise-b66b4a@kuoka/
> 
> Each posting is its own version. Resending - not marked here as resend -
> would be sending the same patch.

Gentle ping.

This is still v4; the only difference was correcting the sender address.
No functional changes since v4. I'm keeping this as v4 unless you prefer a
rebase.

