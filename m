Return-Path: <linux-kernel+bounces-762001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A461B200F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B72169147
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553E62DA750;
	Mon, 11 Aug 2025 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDjh9fFh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286D2D97BC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898963; cv=none; b=szLRJe+5GNJ5eEXF741O1bdWacffOkaov7o7r9L9NnShvggVlYllMjxVeUYY8TvlK/mOVGmxmLrM7Gv92J0v7MEWNWoAMa8KyPhy8nZk8M8r2VjUlb3Y1QCVw8Ox4ZCF3iMW8Kq77BXatrl43xGRWo8NlxbzztIti3Jw1Jp9fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898963; c=relaxed/simple;
	bh=pHEHeCvx6mHDiIUFL+6VywN7wHOrPWrKHo+ygnf0eI0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=alQH9k51xuxFr2PQ+r1j0MSn0ZikTrjcjFY6o0iLkaMxrCw8P7jkD7Bxa1pr1IcOuchktPQSC6y5cct8uLro/pZa20oBfrsdxo7Fe4NS2JhQamM0H4QnAfkW6INT94DazOaR4aMsnmXRiaP+8t3E0BuTsA8ZNV+EpUH5bT9KdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDjh9fFh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61563789ab7so492186a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 00:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754898960; x=1755503760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B+PdwnV07kNbcJNhPLT1/ZZi6u4wFzi0KY+3/EKxhc=;
        b=sDjh9fFh77a2dJQGXo6ySdV+tJYEJaUYC0I/5Vq5FDKAP/c2LCAKK+xJeA/rVfGGTj
         HPW5IdYD54SWlYXfMM+sJJ+qphckvEPPra3os6PgDbr5x67tyxoSqyYmsyfHJXgpw0gb
         jpkW6ZjFs4jxmf+uz4Tcp7RqElaw/RXjSjm3+d9/+q1Oi3hM7Z2c9jr0wzLg1W37t8vQ
         KpGBPwMA1mCKMuyIUCxkKpXmw3hEVpFDF0NlUrB/wpciYhtnFXQJ7dV+j3g/XOgd0EvI
         mfe40PLrQf5wouATskqL6nSkcJHmvTYo6+fdhrtb70HOBNqrgkLQKvuSEhMPbIigl+kf
         jymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754898960; x=1755503760;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B+PdwnV07kNbcJNhPLT1/ZZi6u4wFzi0KY+3/EKxhc=;
        b=M9yMAZ395/iOJqAG5aXLkff+nuy9W9BWxPJEMBYA7UHrp8cmvVUVUzQDDF3IQZgAkq
         2oVVRsYyOBt03iRbV1Z2+xDBEQj9b8fNFizjHKwRwBaYTjx7k2XHQfNhZkYcERJXebUj
         jW/NCAcz8VqcZxV77AJ7Z9NsXHb/HQBPdJGYz30qOckBVEbh0m+fs3IefvqStrhMAMoy
         hcbNbg8Gstp323A70EV7NKLxMs+QRkraS1uVUBpaYcgXrXFqEqEhyCH14O7pqQ6j8Kpg
         jqAAj/RTo+9SfOv+LSFrPmL8WPaMKOFgEmVGZy+WC/sXYXS1+/X1RqEXu2wYSy5gdM7B
         K9Kg==
X-Forwarded-Encrypted: i=1; AJvYcCVeLDTFiheMObKKbetT041cf6b99YZfim/mI2ZBIqr4V+7PUETascJxkoOkojYdLnmzWgk7YX4w38f8A+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkQeihv2L4QibhWC7fYxaFQ1aLyJE9j2t/l6dNjhwiQPKsN4d
	pZPbsZfBakb3TIoTFX8PbK+E1vi7k4n+yV+Qais8vwANVFwYZhRgNbsRtnRdxf/aamR21YjkrMs
	85v7R
X-Gm-Gg: ASbGncvvAU4VJDy8WUPHV/K8InVak4aQojv5Iif/TW8MsHq3uBcD2H+9WcILRMoIDrX
	JvYIlfU9v19j8x94Ii0YV3rXIaSfjrEuhjaDaQibCIptaUtw/lIoPrNxFWBEst1QeZKlnfbsrwP
	qtvZqP9jfbsDng4QjWJpsFxkP3nOno+b53Slng39PPHNgmh7W4wGP/eDc+2pdyi8AT9YwRe+218
	K+zFiPIJTGVj8E9SfpB71F/YucvxRkGR0cob5Dc5H27smLk1O34mLVb+grp7xYAIXrtl8dyNkoi
	DM4Q8YynGicUeA9cb+eaVf/mTQWvUIjhjfkzxR+EEn4uUvH1AhpdIs8ps97EyCFxMjsuTz2R7Bm
	scWnda227fIB8t6FT+1Q+lUOXOIART4noSL4wwX0=
X-Google-Smtp-Source: AGHT+IGNmkXLXrR7zQMQNPjPvO6Wbeyt1MjIJrWklNZfntMizipUD1DSUNe0TAxm0XQdiwqXZymfhw==
X-Received: by 2002:a17:907:720f:b0:af8:fc60:5008 with SMTP id a640c23a62f3a-af9de994749mr316980766b.4.1754898960200;
        Mon, 11 Aug 2025 00:56:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fec4sm1979741466b.121.2025.08.11.00.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:55:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730072730.1882549-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250730072730.1882549-1-ivo.ivanov.ivanov1@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: soc: samsung: usi: add
 samsung,exynos2200-usi compatible
Message-Id: <175489895870.26398.4695794885978749604.b4-ty@linaro.org>
Date: Mon, 11 Aug 2025 09:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 30 Jul 2025 10:27:30 +0300, Ivaylo Ivanov wrote:
> Add samsung,exynos2200-usi dedicated compatible for representing the USI
> of Samsung Exynos 2200 SoC.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: samsung: usi: add samsung,exynos2200-usi compatible
      https://git.kernel.org/krzk/linux/c/187a3426a664737381a70a3fca3b8108f2300de9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


