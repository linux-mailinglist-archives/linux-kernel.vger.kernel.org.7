Return-Path: <linux-kernel+bounces-772771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C898B29753
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949964E19C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF625F973;
	Mon, 18 Aug 2025 03:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFJxbViO"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A51DDC08;
	Mon, 18 Aug 2025 03:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755487513; cv=none; b=Tvdgw/r3o5bzUqb9dRcR4g175HI+bz4EN6ZXTG/uwgAnn+LIwSA0KbhAaHpA+CK3hQQqqQ3bGbVOt/KubcOFwVPwy6Rzh0N8mBuMty6loA8kRhNhV0IE2OJaqiak6f7e9UtDlsQwnBKgY+mD60TZ/Tr1qaBzMaUTqkzpW0AhrqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755487513; c=relaxed/simple;
	bh=E29G00bJo5W0ceSVlw85nDvCJoLFQhZsxrQRqwDK/6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBArsPV6kcHJsl98lYTZbESOSoreTvduySynuyorzM4vjGAWOTzjHvN/8nbbzG6dq+97gH66De1ayhnGzNInVP29etp/T1wZyBKQToFjPQkoA3i0wkJczmGnZGQl8hC95GdvQ4NBkQB5AVxktvtVRU7BerwAjRZ5Gd603GvO/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFJxbViO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-24456f3f669so35191575ad.1;
        Sun, 17 Aug 2025 20:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755487511; x=1756092311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E29G00bJo5W0ceSVlw85nDvCJoLFQhZsxrQRqwDK/6w=;
        b=KFJxbViOccUrPQAE7PXLldcuuSZIp8peuoTvOfRjd+ET40R0YOeu3DVrrZqpHq2sWc
         NVsRfS93saPZnAXixLa/Y3HIyKhzQFmDbnUZGcI5vgA6XYEolmRzUE6tl5XRIS24O4Tv
         TLecG/R2914qC3LLBfyoMUtHa+EcPJILzveFc/NFpeYOgcztzJaYjwKj9hyk6M5gj/wC
         HSfSjUwYt7lzGrRLTB80reKDj6HarqCVhJ04z6qQMKrMPGbSlXRAAXsxycd18JEPmxTU
         3ZB5kPookFavYOnt5WZJQL3DezdXaMyzdLJYdDOq8QelkQyDWTm/w6suJ9NURg4AEy72
         xFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755487511; x=1756092311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E29G00bJo5W0ceSVlw85nDvCJoLFQhZsxrQRqwDK/6w=;
        b=hVTXf0mETInV8elkCbTVVnytsBJJjK1Y77QyO4+SI1SubQJM/jZ5rbfz7UtSdV37Bn
         xKfN/HlAfZGG+5UMfQ85T6hEQhs79VT0xPlmW3yP1O9gu5VH3205NUhQHpYzrl9X3qWs
         xhs63Y1mUHZ/OOOwB4Q+lHPvJ0waLiZWgm0M0dCBClYAs+xq3LOc9mjOL/AQq6gdwo41
         p4n1kxNj1D+7ELEVY6d9CY7DK7Zx4SGjuy/mIpI5RmOAaDNwUR0Z6HhFnIQKxsxdr3HI
         ZXe+eS09mtxlhZNfDc6upO9o9XrViE5cIHTKlhdSuHbuHY2wY0WZP1sqSmiXhga3ZpHd
         UWCw==
X-Forwarded-Encrypted: i=1; AJvYcCVOqEa0hpemJRk5poLyV+UpnqZGDURDlO3wjqGBgKws0g9msGad0BGq+778ItO8e3EGgSFqXx5ZUelVz9k=@vger.kernel.org, AJvYcCWgDLe2DCXxbB1EuFO0Kk4BMvGwduuF0L22f4EQ9GHMiJkZQo24Gl58sb83+TnX6Ud2voYgYIiinLko@vger.kernel.org, AJvYcCWu+MgPapqRk08NKqYMt0M2zPow/iG9L8ABZ2HTkwxU4lLn6oMSTSfvhmODkqsp54pctM6fGAGZffFk@vger.kernel.org, AJvYcCX5wjyR0HhiUhB3C2twESmqkQ+QkH91D2mzhiBsmydCc9rtLzAcGW5c++G78SVAB4Bmn0HV6dC5CFdOLzrf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qfEDhzxyG5g1jOe/U12Xqv3UTDQ1c56pvWGkdGyru/iGDJYw
	JTPNSrGbYM7r5f7SFn721QU4rGTazCIYkd36sppHbm1/p8b7L8Nk/vbh3PEVUA==
X-Gm-Gg: ASbGnctrZj1IVGJm518FJZemqSuMYVic2g764VcG3/ebfS6OQvn/sKoSQkIWrx2CxpA
	aoA/JvKfmY7gKzBfE1BWacm43UndLkkEVlV64gC2TjHRKflNeyYjyJ8AP+Nup39DhdZh6MS0Q3X
	+1pWK6OooKXnM+ztQA4C6yfmYNanupZLrqDXGv4VPmWX9aeUc4NZB7QcwUHcwDKWnpp9nzlZw5y
	BcaxJ6eb+NpEBciV63jQcPuegzk0Ge2xJ+c0HYH37njTiLaeVxOQGym6N47HwJl50LlNucZk2qX
	gE30GzpIP/pLXSI1Z2Z3TelFDCrOj2HMXzNC6W2XXfFpl4bezbRpVgtKS10b1vsc37bhjebVnmM
	zR3fIt3o8x7bk8KVyiWkxGjiDjIdd1yGu4L+wE07/rqQHXdhzpjpKqeIhfu5llk0nOBuoOAONpH
	yoiYJdJe+mpzyalv4=
X-Google-Smtp-Source: AGHT+IGCPuIqztyx4RygtP4sPEfUvqj6mba4WZZZUCuucDqVjtfkJIZWVoAbT28i1nkr55HEWB8rVA==
X-Received: by 2002:a17:902:d483:b0:234:1e11:95a3 with SMTP id d9443c01a7336-2445978c8ccmr221438235ad.13.1755487511284;
        Sun, 17 Aug 2025 20:25:11 -0700 (PDT)
Received: from CNTWS00427A.itotolink.net (111-242-93-174.dynamic-ip.hinet.net. [111.242.93.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d592448sm66070415ad.161.2025.08.17.20.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 20:25:10 -0700 (PDT)
From: ChiShih Tsai <tomtsai764@gmail.com>
To: linux@roeck-us.net
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	jdelvare@suse.com,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	t630619@gmail.com
Subject: Re: [PATCH v3 0/2] Add sq24905c support
Date: Mon, 18 Aug 2025 11:25:07 +0800
Message-ID: <20250818032507.1195-1-tomtsai764@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0b7b396a-c53f-4456-ae17-1b5f3c1d6859@roeck-us.net>
References: <0b7b396a-c53f-4456-ae17-1b5f3c1d6859@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I see, could you review these patches?

Thanks,
ChiShih Tsai

